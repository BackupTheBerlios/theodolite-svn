#!/usr/bin/python2.3
#  admin.py
# 2004-Sept-10 Jim Hefferon jhefferon@smcvt.edu
import os, sys
import cgi, cgitb
import time
import sha  # crypto
import smtplib, MimeWriter, StringIO

import psycopg

import cgiUtils
from cgiUtils import bail
from xml.sax.saxutils import quoteattr

import library
import defaults
import surveyObject
import dBUtils
from dBUtils import *
from util import *

SUBJECT_FILE=defaults.SUBJECT_FILE  # set separately if you need it frozen on a per-file basis
THIS_SCRIPT=defaults.ADMIN_URL  # if you set the prior line separately then you probably want many copies of this script, and will want this line changed -- inlcude the scheme, such as https!

# DEBUG=defaults.DEBUG
DEBUG=True
LOGGING=True # permission to write to the log file?
LOGFILE_NAME='admin.log'

import mx.DateTime
month_names=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

if DEBUG:
    cgitb.enable()


def default_page():
    """Show the visitor the options to start a survey
    """
    r=[cgiUtils.section('Survey basic information')]
    r.append(cgiUtils.form_begin(action=THIS_SCRIPT,enctype='multipart/form-data',charset=defaults.HTML_CODEC))
    #r.append("<form action='%s' enctype='multipart/form-data' method='POST' accept-charset='%s'>\n" % (THIS_SCRIPT,defaults.HTML_CODEC))
    background="""<p>
Here you will enter the basic outline of your survey.
</p>

<p>
Fill in the fields below
(fields that are required are <span class='required'>in color</span>).
When you are ready, hit the &quot;Ready&quot; button at the bottom
of the page.
</p>
"""
    r.append(background)

    noqs=["<select name='numberqs'>\n"]
    for i in range(1,defaults.MAX_NUM_QUESTIONS+1):
        noqs.append("  <option value='%d'>%d</option>\n" % (i,i))
    noqs.append("</select>\n")
    noqs_str="".join(noqs)
    admin_questions="""
<table class='info_summary'>

<tr class='evenrow'><td class='info_description'><p><span class='required'>Your name</span></p></td>
  <td class='info'><input type='text' name='contact_name' value='' size='25' /></td></tr>

<tr class='oddrow'><td class='info_description'><p><span class='required'>Your email address.</span> Give the while email, including the @ and the rest.</p></td>
  <td class='info'><input type='text' name='contact_email' value='' size='35' /></td></tr>

<tr class='evenrow'><td class='info_description'><p>The password that you will use to administer your survey
(edit the questions, view the results, etc.)</p></td>
  <td class='info'><input type='password' name='password' value='' size='20' /></td></tr>

<tr class='oddrow'><td class='info_description'><p><span class='required'>The title of your survey</span></p></td>
  <td class='info'><input type='text' name='title' value=''  size='40'/></td></tr>

<tr class='evenrow'><td class='info_description'><p>Any introductory text; this will be set as a
paragraph between your title and your questions.</p></td> 
  <td class='info'><textarea name='intro' value='' rows='4' cols='72'></textarea></td></tr>

<tr class='oddrow'><td class='info_description'><p>Do you want to run one of these goofy web surveys, where anyone can fill it out, any number of times?
</p></td>
  <td class='info'><table><tr><td><input type='radio' name='no_subj_id_flag' value='no' checked='checked' />No</td> <td><input type='radio' name='no_subj_id_flag' value='yes' />Yes</td></tr></table>
<p>We recommend that you check &quot;No&quot;. If you say &quot;Yes&quot;, the system will ignore your file upload selection, and the mails that you enter below.</p></td></tr>

<tr class='evenrow'><td class='info_description'><p>Do you want an email sent to you as the responses come in?
</p></td>
  <td class='info'><table><tr><td><input type='radio' name='email_flag' value='no' checked='checked' />No</td> <td><input type='radio' name='email_flag' value='yes' />Yes</td></tr></table>
<p>We recommend that you check &quot;No&quot;.</p>
</td></tr>

<tr class='oddrow'><td class='info_description'><p>Do you want the responses to be recorded without any identifier?</p></td>
  <td class='info'><table><tr><td><input type='radio' name='anonymous_flag' value='no' checked='checked' />No</td> <td><input type='radio' name='anonymous_flag' value='yes' />Yes</td></tr></table>
<p>We recommend that you check &quot;No&quot;.  If you say &quot;Yes&quot; then your analysis will not be able to answer questions like &quot;Of the people who anwered Yes on my question 6, what percentage answered No to my question 7?&quot;.</p>
</td></tr>

<tr class='evenrow'><td class='info_description'><p>Select the number of questions (you will enter the questions themselves on a later page.).</p></td> 
  <td class='info'>%s</td></tr>
"""  % (noqs_str,)
    upload_line="""
<tr class='oddrow'><td class='info_description'><span class='required'>File of people to email to take the survey</span> (format: one person per line, each line has two fields, id number and email address).</td> 
  <td class='info'><input type='file' name='submit_file' size='60' value='submit'/></td></tr>
"""
    r.append(admin_questions)
    if SUBJECT_FILE is None:
        r.append(upload_line)
    r.append("\n</table>\n")
    # select the start and end dates
    curr_time=time.localtime()
    years=[]
    this_year=curr_time[0]
    for year in range(this_year,this_year+2):
        years.append("  <option value='%d'>%d</option>\n" % (year,year))
    years.append("</select>\n")
    years_str="".join(years)
    this_month=curr_time[1]
    months=[]
    for m in range(this_month,this_month+12):
        m_int=(m-1) % 12
        m_str=month_names[m_int]
        months.append("  <option value='%s'>%s</option>\n" % (m_int+1,cgi.escape(m_str)))
    months.append("</select>\n")
    months_str="".join(months)
    this_day=curr_time[2]
    days=[]
    for day in range(this_day-2,this_day+29):
        d=(day % 31)+1  # start with today; midnight that just passed
        days.append("  <option value='%s'>%s</option>\n" % (d,d))
    days.append("</select>\n")
    days_str="".join(days)
    r.append(cgiUtils.section('Survey Dates and Mailings'))
    dates_info="""
<p>
You will next enter the dates for your survey.
You will also enter the email to be sent to each survey subject.
<i>Note:</i>
Your mail needs a place for the system to put the link that subjects will click on to take the survey -- indicate that place by writing &quot;%s&quot; (without the quotes) right in the body of the mail. 
</p>
<p>
You also have the chance to send up to two emails to subjects prompting them
to respond.
These are only sent to those subjects who have not yet responded.
To send such a mail, click in a date and enter a message body
(again, include a &quot;%s&quot;).
To not send that mail, just leave the email area blank.
</p>
<p>
Note that the dates refer to the midnight after that day.
For instance, if you open the survey today, %s %s, then it will open at
midnight tonight.
</p>
""" % (defaults.LINK_STRING,defaults.LINK_STRING,cgi.escape(month_names[this_month]),this_day)
    r.append(dates_info)
    dates_table_top="""
<table class='info_summary'>
"""
    r.append(dates_table_top)
    r.append("""<tr class='evenrow'><td class='info_description'><p><span class='required'>The date that your survey should begin accepting survey input.</span></p></td>
  <td class='info'><table>\n<tr><td>Year&nbsp;<select name=%s>\n%s</td><td>Month&nbsp;<select name=%s>\n%s</td><td>Day&nbsp;<select name=%s>\n%s\n</td></tr></table></td></tr>
""" % (quoteattr('year1'),years_str,quoteattr('month1'),months_str,quoteattr('day1'),days_str))
    r.append("""<tr class='oddrow'><td class='info_description'><p><span class='required'>The mail that you would like to send.</span>  Remember to include a &quot;%s&quot;.</p></td>
  <td class='info'><textarea name='body1' rows='%s' cols='%s'></textarea></td></tr>
""" % (defaults.LINK_STRING,defaults.EMAIL_ENTRY_ROWS,defaults.EMAIL_ENTRY_COLS))
    r.append("""<tr class='evenrow'><td class='info_description'><p>The date that you will send the first prompting email.</p></td>
  <td class='info'><table>\n<tr><td>Year&nbsp;<select name=%s>\n%s</td><td>Month&nbsp;<select name=%s>\n%s</td><td>Day&nbsp;<select name=%s>\n%s\n</td></tr></table></td></tr>""" % (quoteattr('year2'),years_str,quoteattr('month2'),months_str,quoteattr('day2'),days_str))
    r.append("""<tr class='oddrow'><td class='info_description'><p>The body of the email -- remember the &quot;%s&quot;.</p></td>
  <td class='info'><textarea name='body2' rows='%s' cols='%s'></textarea></td></tr>""" % (defaults.LINK_STRING,defaults.EMAIL_ENTRY_ROWS,defaults.EMAIL_ENTRY_COLS))
    r.append("""<tr class='evenrow'><td class='info_description'><p>The date that you will send the second prompting email.</p></td>
  <td class='info'><table>\n<tr><td>Year&nbsp;<select name=%s>\n%s</td><td>Month&nbsp;<select name=%s>\n%s</td><td>Day&nbsp;<select name=%s>\n%s\n</td></tr></table></td></tr>""" % (quoteattr('year3'),years_str,quoteattr('month3'),months_str,quoteattr('day3'),days_str))
    r.append("""<tr class='oddrow'><td class='info_description'><p>The body of your email -- remember a &quot;%s&quot;.</p></td>
  <td class='info'><textarea name='body3' rows='%s' cols='%s'></textarea></td></tr>""" % (defaults.LINK_STRING,defaults.EMAIL_ENTRY_ROWS,defaults.EMAIL_ENTRY_COLS))
    r.append("""<tr class='evenrow'><td class='info_description'><p><span class='required'>The date that your survey will stop accepting responses.</span></p></td>
  <td class='info'><table>\n<tr><td>Year&nbsp;<select name=%s>\n%s</td><td>Month&nbsp;<select name=%s>\n%s</td><td>Day&nbsp;<select name=%s>\n%s\n</td></tr></table></td></tr>""" % (quoteattr('year4'),years_str,quoteattr('month4'),months_str,quoteattr('day4'),days_str))
    r.append("</table>\n")
    r.append(cgiUtils.section('When you are ready ..'))
    r.append("<p>.. hit the button to register your request with the Theodolite administrator: <input type='submit' name='default_submit' value='Ready' />.</p>\n")
    r.append("</form>\n")
    return "".join(r)



def check_date(d_str,log=None):
    """See if a date string is a sensible date; knows about leap years, 'thirty
    days hath September', etc.
      d_str  A date that represents a string
      log  A logging instance
    Returns a pair (mx.DateTime object or None, error string)
    """
    try:
        dt=mx.DateTime.strptime(d_str,'%Y-%m-%d')
    except mx.DateTime.RangeError, err:
        return(None,"date %s" % (d_str,))
    except Exception, err:
        return(None,"date string %s" % (d_str,))
    return (dt,'')


def accept_survey(fs,dBcnx,dBcsr,log=None,debug=False):
    """Gather the list of questions
      fs  a cgi.fieldStorage instance
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None A logging object
      debug=False  Whether to output extra information on an error
    """
    contact_name=cgiUtils.getfirst(fs,'contact_name')
    if not(contact_name):
        return cgiUtils.need_more('contact name')
    contact_email=cgiUtils.getfirst(fs,'contact_email')
    if not(contact_email):
        return cgiUtils.need_more('contact email')
    if contact_email.find('@')==-1:
        return cgiUtils.need_more('all of the contact email address, including the @ and the rest')
    password=cgiUtils.getfirst(fs,'password')
    if password is None:
        return cgiUtils.need_more('password')
    title=cgiUtils.getfirst(fs,'title')
    if not(title):
        return cgiUtils.need_more('title')
    years=[]
    months=[]
    days=[]
    for i in range(1,5):
        year=cgiUtils.getfirst(fs,"year%d" % (i,))
        if year is None:
            return cgiUtils.need_more("year %d" % (i,))
        try:
            year=int(year)
        except:
            return cgiUtils.need_different("year %d" % (i,))
        years.append(year)
        month=cgiUtils.getfirst(fs,"month%d" % (i,))
        if month is None:
            return cgiUtils.need_more("month %d" (i,))
        try:
            month=int(month)
        except:
            return cgiUtils.need_different("month %d" % (i,))
        if not((month>0)
               and (month<=12)):
            return cgiUtils.need_different("month %d" % (i,))
        months.append(month)
        day=cgiUtils.getfirst(fs,"day%d" % (i,))
        if day is None:
            return cgiUtils.need_more("day %d" % (i,))
        try:
            day=int(day)
        except:
            return cgiUtils.need_different("day %d" % (i,))
        if not((day>0)
               and (day<=31)):
            return cgiUtils.need_different("day %d" % (i,))
        days.append(day)
    body1=cgiUtils.getfirst(fs,'body1')
    if body1 is None:
        return cgiUtils.need_more('first email')
    body2=cgiUtils.getfirst(fs,'body2')
    if body2 is None:
        return cgiUtils.need_more('second email (the first prompt)')
    body3=cgiUtils.getfirst(fs,'body3')
    if body3 is None:
        return cgiUtils.need_more('third email (the second prompt)')
    intro=cgiUtils.getfirst(fs,'intro')
    if intro is None:
        return cgiUtils.need_more('introductory text')
    email_flag=cgiUtils.getfirst(fs,'email_flag')
    if email_flag is None:
        return cgiUtils.need_more('email flag')
    if email_flag=='yes':
        email_flag=True
    else:
        email_flag=False
    anonymous_flag=cgiUtils.getfirst(fs,'anonymous_flag')
    if anonymous_flag is None:
        return cgiUtils.need_more('anonymous flag')
    if anonymous_flag=='yes':
        anonymous_flag=True
    else:
        anonymous_flag=False
    no_subj_id_flag=cgiUtils.getfirst(fs,'no_subj_id_flag')
    if no_subj_id_flag is None:
        return cgiUtils.need_more('the no subject id flag')
    if no_subj_id_flag=='yes':
        no_subj_id_flag=True
    else:
        no_subj_id_flag=False
    number_qs=cgiUtils.getfirst(fs,'numberqs')
    if number_qs is None:
        return cgiUtils.need_more('number of questions')
    try:
        number_qs=int(number_qs)
    except:
        return cgiUtils.need_different('number of questions')
    if ((number_qs<0)
        or (number_qs>defaults.MAX_NUM_QUESTIONS)):
        return cgiUtils.need_different('number of questions')
    # handle the subject file, on the server or uploaded
    if not(no_subj_id_flag):
        if SUBJECT_FILE is None:
            uploaded_file=fs['submit_file']
            subjects=[] # list of (lineno,subject id,email address)
            if not(uploaded_file.file):
                return cgiUtils.need_more('file of email addresses')
            else:
                sfile=uploaded_file.file
        else:
            try:
                sfile=open(SUBJECT_FILE,'r')
            except Exception, err:
                bail('Unable to read the subject file',devel="Unable to read the file named in defaults as the subject file %(subject_file)s: %(err)s",log=log,debug=debug,subject_file=SUBJECT_FILE,err=err)
        lineno=0
        firstTenEmails=[]  # show the uploader that you got the right file
        while True: # consume the uploaded file or subject file
            try:
                lineno+=1
                line=sfile.readline().strip()
                if not line:
                    break
                fields=line.split(None,1)
                log.debug("The next line in the file is %s; the fields are %s" % (line,repr(fields)))
                if len(fields)<>2:
                    return cgiUtils.need_different("email address file (line number %d)" % (lineno,))
                else:
                    subjects.append((lineno,fields[0],fields[1]))
            except Exception, err:
                return cgiUtils.need_different("file of email addresses")
            if lineno<10:
                email_address=fields[1]
                if email_address.find('<')==-1:  # no tricks with HTML
                    firstTenEmails.append(email_address)
        sfile.close()
    # check that data is consistent
    if not(no_subj_id_flag):
        if body1.count(defaults.LINK_STRING)==0:
            return cgiUtils.need_different("initial email message (it contains no %s)" % (defaults.LINK_STRING,))
    date_open="%s-%s-%s" % (years[0],months[0],days[0])
    (dt,dt_err)=check_date(date_open)
    if dt is None:
        cgiUtils.need_different("opening %s (is there such a date?)" % (cgi.escape(dt_err),))
    if (not(no_subj_id_flag)
        and (body2.count(defaults.LINK_STRING)>0)):
            date_mail2="%s-%s-%s" % (years[1],months[1],days[1])
            (dt,dt_err)=check_date(date_mail2)
            if dt is None:
                cgiUtils.need_different("first prompt %s (is there such a date?)" % (cgi.escape(dt_err),))
    else:
        date_mail2=None # send no such mail
    if (not(no_subj_id_flag)
        and (body3.count(defaults.LINK_STRING)>0)):
            date_mail3="%s-%s-%s" % (years[2],months[2],days[2])
            (dt,dt_err)=check_date(date_mail3)
            if dt is None:
                cgiUtils.need_different("second prompt %s (is there such a date?)" % (cgi.escape(dt_err),))
    else:
        date_mail3=None # send no such mail
    date_closed="%s-%s-%s" % (years[3],months[3],days[3])
    (dt,dt_err)=check_date(date_closed)
    if dt is None:
        cgiUtils.need_different("closing %s (is there such a date?)" % (cgi.escape(dt_err),))
    # end data checking; put the survey data into the database
    #   make a new survey record
    dct={'title':title,
         'contact_name':contact_name,
         'contact_email':contact_email,
         'password':password,
         'intro':intro,
         'no_qs':number_qs,
         'email_flag':email_flag,
         'anonymous_flag':anonymous_flag,
         'no_subj_id_flag':no_subj_id_flag,
         'date_open':date_open,
         'mail1':body1,
         'date_mail2':date_mail2,
         'mail2':body2,
         'date_mail3':date_mail3,
         'mail3':body3,
         'date_closed':date_closed}
    sql="INSERT INTO survey (title,contact_name,contact_email,password,date,intro,no_qs,email,anonymous,no_subj_id,date_open,mail1,date_mail2,mail2,date_mail3,mail3,date_closed) VALUES (%(title)s,%(contact_name)s,%(contact_email)s,%(password)s,NOW(),%(intro)s,%(no_qs)s,%(email_flag)s,%(anonymous_flag)s,%(no_subj_id_flag)s,%(date_open)s,%(mail1)s,%(date_mail2)s,%(mail2)s,%(date_mail3)s,%(mail3)s,%(date_closed)s)"
    try:
        putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='new survey information')
    except dBUtilsError, err:
        bail("Unable to put survey information into the database",devel="Unable to put information into the database:%(err)s",log=log,debug=DEBUG,err=err)
    # get the current value of the survey id field
    sql="SELECT currval('survey_id_seq') FROM survey"
    dct={}
    try:
        dBres=dBUtils.getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=debug,listtype='current value of id sequence')
        #dBcsr.execute(sql,dct)
        survey_id=dBres[0]
    except psycopg.DatabaseError, err:
        bail("Unable to get the survey id from the database",devel="Unable to get the survey id from the databse: %(err)s",log=log,debug=DEBUG,err=err)
    # make an id for each subject
    if not(no_subj_id_flag):
        for (lineno,subject_id,email) in subjects:
            hashed_subject_id=sha.new("%d%s%s" % (survey_id,defaults.SEPARATOR,subject_id)).hexdigest()
            sql="INSERT INTO subjects (survey_id,id,persons_id,email) VALUES (%(survey_id)s,%(hashed_subject_id)s,%(persons_id)s,%(email)s)"
            dct={'survey_id':survey_id,
                 'hashed_subject_id':hashed_subject_id,
                 'persons_id':subject_id,
                 'email':email}
            try:
                putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='subject id and email')
            except dBUtilsError, err:
                bail("Unable to put the subject id, email information into the databse (at line number %(lineno)s for subject id %(subject_id)s)",devel="Unable to put the subject id, email information into the databse (at line number %(lineno)s for subject id %(subject_id)s): %(err)s",log=log,debug=DEBUG,lineno=lineno,subject_id=subject_id,err=err)
    # if anonymous and no_subj_id, add 'anonymous' to the list of subjects
    if (anonymous_flag
        and no_subj_id_flag):
        sql="INSERT INTO subjects (survey_id,id,email) VALUES (%(survey_id)s,'anonymous',NULL)"
        dct={'survey_id':survey_id}
        try:
            putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='anonymous subject id and email')
        except dBUtilsError, err:
            bail("Unable to put the subject id, email information into the databse for subject 'anonymous'",devel="Unable to put the subject id, email information into the databse for subject 'anonymous': %(err)s",log=log,debug=DEBUG,err=err)        
    # commit the survey and subject inserts 
    try:
        dBcnx.commit()
    except psycopg.DatabaseError, err:
        bail("Unable to commit the survey information to the database",devel="Unable to commit the survey information to the database: %(err)s",log=log,debug=DEBUG,err=err)
    # get emails of administrators
    try:
        dBres=getData("SELECT name,email_name,email_domain FROM admins",dBcsr=dBcsr,log=log,debug=DEBUG,listtype='administrators names and emails')
    except dBUtilsError, err:
        bail("Unable to get the administrator email addresses from the database",devel="Unable to get the administrator email addresses from the database: %(err)s",log=log,debug=DEBUG,err=err)
    # mail the admins for approval
    try:
        message=StringIO.StringIO()
        writer=MimeWriter.MimeWriter(message)
        writer.addheader('subject',"Theodolite -- new survey proposal: %s" % (title,))
        writer.addheader('MIME-Version','1.0')
        writer.startmultipartbody('mixed')
        part=writer.nextpart()
        body=part.startbody('text/plain')
        body.write("A new survey has been proposed by %s.\n\n" % (contact_name,))
        body.write("Title: %s\n" % (title,))
        body.write("Number of questions: %s\n" % (number_qs,))
        body.write("Date open: %s, date closed: %s\n" % (date_open,date_closed))
        body.write("Visit %s to approve it." % (defaults.APPROVE_URL,))
        writer.lastpart()
        smtp=smtplib.SMTP(defaults.THIS_MACHINE)
        for (name,email_name,email_domain) in dBres:
            smtp.sendmail("%s@%s" % (email_name,email_domain),defaults.MAINTAINER,message.getvalue())
        smtp.quit()
    except Exception, err:
        bail("The system has had trouble mailing the Theo system administrator.",devel="Unable to notify the Theo system administrator of an uploaded survey: error=%(err)s, survey id=%(survey_id)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # acknowledge to the surveyer
    r=[cgiUtils.section('Your survey request has been received')]
    admins_toshow=[]
    for (name,email_name,email_domain) in dBres:
        admins_toshow.append("%s (at) %s" % (email_name,email_domain))
    firstTenEmails=['"'+em+'"' for em in firstTenEmails]
    intro="""
<p>
Your request for the survey &quot;%s&quot; is in the database.
Just as a quick check: the first few emails that you uploaded are
%s
</p>
<p>
An email about your request will be sent for approval to <code>%s</code>.
You should be contacted by email in a couple of days.
</p>
""" % (cgi.escape(title),cgi.escape(", ".join(firstTenEmails)),cgi.escape("</code>, <code>".join(admins_toshow)))
    r.append(intro)
    r.append(cgiUtils.section('What you can do next'))
    next="""
<p>
You can now either wait for approval or go ahead and edit the list
of questions.
If you want to go ahead, click on
<a href=%s>this link</a>.
</p>
""" % (quoteattr("%s?survey_id=%s" % (THIS_SCRIPT,survey_id)),)
    r.append(next)
    return "".join(r)


def edit_questions(fs,dBcnx,dBcsr,log=None,debug=False):
    """Allow the user to edit the list of questions.
      fs  A cgi FieldStorage class
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None  A logging object
      debug=False  Whether to output extra information on an error
    """
    survey_id=cgiUtils.getfirst(fs,'survey_id')
    if survey_id is None:
        return cgiUtils.need_more('survey id')
    try:
        survey_id=int(survey_id)
    except:
        return cgiUtils.need_different('survey id')
    # get the types of questions, with description and html
    sql="SELECT type,description,html FROM question_types"
    try:
        qTypeList=getData(sql,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='the question types, descriptions, and html')
    except dBUtils.Error, err:
        bail('Unable to get the list of question types from the database.',devel="Unable to get the list of question types from the database: %(err)s",log=log,debug=DEBUG,err=err)
    # make up the table of question types in the database
    question_html=["<table class='info_summary'>\n<tr><th>Question type</th> <th>Example</th></tr>\n"]
    j=0
    for (type,description,html) in qTypeList:
        j+=1
        if (j % 2)==0:
            rowclass='evenrow'
        else:
            rowclass='oddrow'
        n=html.count('%s')
        dummy=tuple(["dummy%d" % (j,)]*n) 
        question_html.append("<tr class='%s'><td class='info_description'>%s</td> <td class='info'>%s</td></tr>\n" % (rowclass,description,html % dummy)) # don't escape description, html as they came from the dB
    question_html.append("</table>\n")
    try:
        s=surveyObject.survey(survey_id,dBcsr,log=log)
    except surveyObject.surveyError, err:
        bail("Unable to get the survey object from the database",devel="Unable to get the survey information for %(survey_id)s from the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # generate the page
    r=[]
    r.append(cgiUtils.form_begin(action=THIS_SCRIPT))
    #r.append("<form action='%s' method='POST'>\n" % (THIS_SCRIPT,))
    r.append("<input type='hidden' name='survey_id' value='%s' />" % (survey_id,))
    r.append(cgiUtils.section('Enter the password'))
    r.append("<p>Enter the password for this survey: <input type='password' name='password' value='' size='20'/></p>")
    r.append(cgiUtils.section('Edit the questions'))
    instructions="""
<p>
For each question, you can have a preamble text such as
&quot;The following questions pertain to the new meal program.&quot;
or
&quot;If you entered Yes to the prior question then skip to question 19&quot;
You can leave this blank for some or all questions.
</p>
<p>
For each question you can enter text like
&quot;Are you satisfied?&quot;.
Then, for each question you select a type, such as
&quot;Yes or No&quot;
(see <a href='#types'>below</a> for a list of types).
Finally, for each question you can choose for it to
be followed by a space for a subject to comment
(except, you can't do this for a &quot;comment&quot;-type question).
</p>
<p>
When you have finished,
click the Done button at the end.
</p>
"""
    r.append(instructions)
    r.append("<ol>\n")
    for i in range(1,s.getNumberQuestions()+1):
        if (i % 2)==0:
            r.append("<li class='evenitem'/>\n")
        else:
            r.append("<li class='odditem'/>\n")
        if s.getQuestion(i):
            (preamble,q_type,body,comment)=(s.getQuestionPreamble(i),s.getQuestionType(i),s.getQuestionBody(i),s.getQuestionComment(i))
        else:
            (preamble,q_type,body,comment)=('',defaults.DEFAULT_QUESTION_TYPE,'',False)
        questiontype_select=["<select name='question_type%d'>" % (i,)]
        for (type,description,html) in qTypeList:
            if type==q_type:
                sel_str=" selected='selected'"
            else:
                sel_str=''
            questiontype_select.append("  <option value='%s'%s>%s</option>\n" % (type,sel_str,description))  # don't escape type, description as they come strainght from the dB
        questiontype_select.append("</select>\n")
        qTypeSelect="".join(questiontype_select)
        if comment:
            y_checked="checked='checked'"
            n_checked=""
        else:
            y_checked=""
            n_checked="checked='checked'"
        r.append("<table class='question_item'>\n")
        r.append("<tr><td>Question preamble <input type='text' name='preamble%d' value=%s size='80' /></td></tr>\n" % (i,quoteattr(preamble)))
        r.append("<tr><td>Question text <input type='text' name='body%d' value=%s size='80' /></td></tr>\n" % (i,quoteattr(body)))
        r.append("<tr><td>Question type %s</td></tr>\n" % (qTypeSelect,))
        r.append("<tr><td>Allow text comment? <input type='radio' name='comment%d' value='no' %s />No  <input type='radio' name='comment%d' value='yes' %s />Yes</td></tr>\n" % (i,n_checked,i,y_checked))
        r.append("</table>\n")
    r.append('</ol>\n')
    r.append(cgiUtils.section('Ready?'))
    r.append("<p>When you are ready, hit the button: <input type='submit' name='questions_submit' value='ready' /></p>\n")
    r.append(cgiUtils.form_end())
    r.append(cgiUtils.section("<a id='types'>Possible question types</a>"))
    question_type_text="""
<p>
These are the types of question that you can choose among.
</p>
"""
    r.append(question_type_text)
    r.append("".join(question_html))
    return "".join(r)


def accept_questions(fd,dBcnx,dBcsr,log=None,debug=False):
    """Construct the survey,
      fs  A CGI fieldStorage structure
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None  a logging object
      debug=False  Whether to output extra information
    """
    r=[]
    survey_id=cgiUtils.getfirst(fs,'survey_id')
    if survey_id is None:
        return cgiUtils.need_more('survey id')
    try:
        survey_id=int(survey_id)
    except:
        return cgiUtils.need_different('survey id')
    try:
        s=surveyObject.survey(survey_id,dBcsr)
    except surveyObject.surveyError, err:
        bail("Unable to get the survey information from the database.",devel="Unable to get the survey information from the database: %(err)s",log=log,debug=DEBUG,err=err)
    # check the password
    if s.getPassword() is None:
        bail('The password for this survey was not found in the database',devel="The password for survey %(survey_id)s was not found in the database",log=log,debug=DEBUG,survey_id=survey_id)
    # store the items in the database
    sql="DELETE FROM questions WHERE survey_id=%(survey_id)s"
    dct={'survey_id':survey_id}
    try:
        dBUtils.putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug)
        #dBcsr.execute(sql,dct)
    except psycopg.DatabaseError, err:
        bail("Unable to delete the information for questions from the database",devel="Unable to delete the information for questions for %(survey_id)s from the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # get the types of questions, with description and html
    sql="SELECT type,description,html FROM question_types"
    try:
        dBres=dBUtils.getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug,listtype='list of question types')
        #dBcsr.execute(sql)
        qTypeList=dBres
    except psycopg.DatabaseError, err:
        bail('Unable to get the list of question types, descriptions, and html from the database.',devel="Unable to get the list of question types from the database for %(survey_id)s: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    qTypeHTMLDict={}  # maps question type to html
    qTypes=[]  # list of question types
    for (type,description,html) in qTypeList:
        qTypes.append(type)
        qTypeHTMLDict[type]=html
    qData=[]  # list of dictionaries: keys=preamble,body,question_type,comment
    for q_no in range(1,s.getNumberQuestions()+1):
        dct={'survey_id':survey_id,
             'number':q_no}
        for x in ['preamble','body','comment','question_type']:
            key="%s%d" % (x,q_no)
            val=cgiUtils.getfirst(fs,key)
            if val is None:
                return cgiUtils.need_more(key)
            if ((x=='question_type')
                and not(val in qTypes)):
                return cgiUtils.need_different(key)
            if ((x=='question_type')  # if question type is "comment", don't
                and (val=='comment')): # allow another comment
                dct['comment']=False  # 
            if x=='comment':
                if val=='yes':
                    val=True
                else:
                    val=False
            dct[x]=val      
        qData.append(dct)
        sql="INSERT INTO questions (survey_id,number,preamble,q_type,body,comment) VALUES (%(survey_id)s,%(number)s,%(preamble)s,%(question_type)s,%(body)s,%(comment)s)"
        try:
            dBUtils.putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug)
            #dBcsr.execute(sql,dct)
        except psycopg.DatabaseError, err:
            bail("Unable to put the question information into the database",devel="Unable to put the question information for survey %(survey_id)s into the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
        except Exception, err:
            bail("Unable to insert the question information into the database",devel="Unable to insert the question information for survey %(survey_id)s into the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # commit the inserts
    try:
        dBcnx.commit()
    except psycopg.DatabaseError, err:
        bail("Unable to commit the question information to the database",devel="Unable to commit the question information for survey %(survey_id)s to the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # make up the page to return
    r.append(cgiUtils.section('Thank you'))
    ifapproved="""
<p>
Your questions have been stored in the database.
</p>
"""
    ifnotapproved="""
<p>
Your questions have been stored in the database.
<i>Note:</i> your survey has not yet been approved by the administrator.
Your survey can't go out -- questions or no -- until it is approved.
</p>
"""
    if s.getApproved():
        r.append(ifapproved)
    else:
        r.append(ifnotapproved)
    pageURL="%s?survey_id=%d" % (THIS_SCRIPT,survey_id)
    conclusion="""
<p>
Your survey will appear as on the shaded area below (but without the shade!).
If you wish to further edit it, you can use your browser's BACK button,
or visit the page %s at a later date.
</p>
""" % ("\n<a href=%s>%s</a>\n" % (quoteattr(pageURL),cgi.escape(pageURL)),)
    r.append(conclusion)
    survey_prefix=[]
    survey=["<h2>%s</h2>\n" % (cgi.escape(s.getTitle()),)]
    intro=s.getIntro()
    if intro:
        survey.append("<p id='intro'>%s</p>\n" % (cgi.escape(intro),))
    #survey.append("<ol>\n")
    for q_no in range(1,s.getNumberQuestions()+1):
        dct=qData[q_no-1]
        if dct['preamble']:
            survey.append("<p class='question_preamble'>Preamble: %s</p>\n" % (cgi.escape(dct['preamble']),))
        #survey.append("<li /> <span class='question_body'>Question: %(body)s</span>\n" % dct)
        survey.append("<p class='question'><span class='question_number'>Question %s</span> <span class='question_body'>%s</span></p>\n" % (dct['number'],cgi.escape(dct['body']),))
        q_string=qTypeHTMLDict[dct['question_type']]
        n=q_string.count('%s') # how many " name='%s' " are there?
        t=tuple(["question%d" % (q_no,)]*n) 
        survey.append(q_string % t)
        if ((dct['comment'])
            and not(dct['question_type']=='commentonly')):
            survey.append("<span class='question_comment'>Comment: <input name='comment%d' size='80' maxlength='160' /></span>\n" % (q_no,))
    survey.append(cgiUtils.section('When you are finished ..'))
    survey.append("<p>.. hit the button. <input type='submit' name='Done' value='Done' /></p>\n")
    survey.append("<p>Thank you!</p>\n")
    r.append("<hr />\n")
    r.append("<div id='survey'>\n") # show off the survey as different
    r.append("".join(survey))
    r.append("</div>\n")
    survey_postfix=survey  #  anything else?
    # put the prefix and postfix into the database
    sql="UPDATE survey SET prefix=%(survey_prefix)s, postfix=%(survey_postfix)s WHERE id=%(survey_id)s"
    dct={'survey_prefix':"".join(survey_prefix),
         'survey_postfix':"".join(survey_postfix),
         'survey_id':survey_id}
    try:
        dBUtils.putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='survey prefix and postfix information')
        #dBcsr.execute(sql,dct)
        dBcnx.commit()
    except psycopg.DatabaseError, err:
        bail("Unable to put the survey prefix and postfix into the database",devel="Unable to put the survey prefix and postfix for survey %(survey_id)s into the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    return "".join(r)



#--------------- main script -------------------------------------------
r=[cgiUtils.xhtml_content_type()]
r.append(cgiUtils.xhtml_head())
r.append(cgiUtils.page_head('Set up a survey'))
r.append(cgiUtils.page_start_body())
r.append(cgiUtils.page_top('Set up your survey'))

# open the log file
log=None
if LOGGING:
    try:
        log=openLog(LOGFILE_NAME)
    except utilError, err:
        bail("Sorry, the system is misconfigured.  Unable to open the log file.",devel="Unable to open the log file %(logfilename)s",debug=DEBUG,logfilename=LOGFILE_NAME)
# connect to the database
try:
    (dBcnx,dBcsr)=opendB()
except StandardError, err:
    bail("This program cannot connect to the database.",devel="Unable to connect to the database: %(err)s",log=log,debug=DEBUG,err=err)
# get the http parameters 
fs=cgi.FieldStorage(keep_blank_values=1)
if DEBUG:
    r.append(cgiUtils.dumpFieldStorage(fs))
# select the page
if fs.has_key('questions_submit'):
    r.append(accept_questions(fs,dBcnx,dBcsr,log=log,debug=DEBUG))
elif fs.has_key('survey_id'):
    r.append(edit_questions(fs,dBcnx,dBcsr,log=log,debug=DEBUG))
elif fs.has_key('default_submit'):
    r.append(accept_survey(fs,dBcnx,dBcsr,log=log,debug=DEBUG))
else:
    r.append(default_page())
# get out
r.append(cgiUtils.page_foot())
cgiUtils.return_page(r)
sys.exit(0)

#!/usr/bin/python2.3
#  approve.py
# Part of the Theodolite system.  Set approval for a survey.
#
# 2004-Sept-23 Jim Hefferon jhefferon@smcvt.edu
import os, sys
import cgi, cgitb
import time, mx.DateTime
import smtplib, MimeWriter, StringIO

import psycopg

import cgiUtils
from cgiUtils import bail

import library
import defaults
import surveyObject
from dBUtils import *
from util import *

DEBUG=defaults.DEBUG
LOGGING=True # permission to write to the log file?
LOGFILE_NAME='approve.log'

if DEBUG:
    cgitb.enable()

class approveError(StandardError):
    pass


def default_page(fs,dBcnx,dBcsr,log=None):
    """Start a survey
      fs  A cgi fieldStorage structure
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None  A logging object
    Returns a pair (success,page) where success if a flag, and page is some
    HTML.
    """
    r=[]
    sql="SELECT id,title,contact_name,contact_email,date,intro,no_qs,email,anonymous,approved,prefix,postfix,date_open,mail1,mail1sent,date_mail2,mail2,mail2sent,date_mail3,mail3,mail3sent,date_closed FROM survey WHERE date_closed>NOW()"
    try:
        dBres=getData(sql,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='list of not-yet-expired surveys')
    except dBUtilsError, err:
        bail("Unable to get the list of unexpired surveys from the database",devel="Unable to get the list of unexpired surveys from the database: %(err)s",log=log,debug=DEBUG,err=err)
    # break them into ones that have been approved, and ones that have not
    notA=["<table>\n"]
    notA.append("<tr><th>Approve</th> <th>id</th> <th>Title</th> <th>Contact</th> <th>date open</th> <th>date closed</th></tr>\n")
    A=["<table>\n"]
    A.append("<tr><th>id</th> <th>Title</th> <th>Contact</th> <th>date open</th> <th>date closed</th></tr>\n")
    anyNotA=False
    anyA=False
    for (id,title,contact_name,contact_email,date,intro,no_qs,email,anonymous,approved,prefix,postfix,date_open,mail1,mail1sent,date_mail2,mail2,mail2sent,date_mail3,mail3,mail3sent,date_closed) in dBres:
       if approved: 
           anyA=True
           A.append("<tr><td><a href='%s?id=%s'>%s</a></td> <td>%s</td> <td><a href='mailto:%s'>%s</a></td> <td>%s</td> <td>%s</td> </tr>\n" % (defaults.APPROVE_URL,id,id,title,contact_email,contact_name,date_open.date,date_closed.date))
       else:
           anyNotA=True
           notA.append("<tr><td><input type='checkbox' name='approve' value='%s' /></td> <td><a href='%s?id=%s'>%s</a></td> <td>%s</td> <td><a href='mailto:%s'>%s</a></td> <td>%s</td> <td>%s</td> </tr>\n" % (id,defaults.APPROVE_URL,id,id,title,contact_email,contact_name,date_open.date,date_closed.date))
    notA.append("</table>\n")
    A.append("</table>\n")
    r.append("<p>These are the unexpired surveys in the database.</p>\n")
    r.append(cgiUtils.section('Surveys that are not yet approved'))
    if anyNotA:
        r.append("<p>You can approve surveys by clicking the box and then hitting Submit.</p>\n")
        r.append("<form action='%s' method='POST'>\n" % (defaults.APPROVE_URL,))
        r.append("<p>Enter the administrative password. <input type='password' name='password' value='' /></p>\n")
        r.append("".join(notA))
        r.append("<input type='submit' name='submit' value='submit' />")
        r.append("</form>\n")
    else:
        r.append("<p><i>There are no surveys pending approval.</i></p>\n")
    r.append(cgiUtils.section('Surveys that have already been approved'))
    if anyA:
        r.append("".join(A))
    else:
        r.append("<p><i>There are no unexpired surveys that have been approved.</i></p>\n")
    return "".join(r)


def show_survey(fs,dBcnx,dBcsr,log=None):
    """Display the active surveys
      fs  a cgi.fieldStorage instance
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None  A logging object
    Returns HTML (perhaps an error page).
    """
    survey_id=cgiUtils.getfirst(fs,'id')
    if survey_id is None:
        return cgiUtils.ErrorPage('<h2>Error</h2>','<p>Unable to get the id number of the survey.</p>')
    try:
        survey_id=int(survey_id)
    except Exception, err:
        return cgiUtils.ErrorPage('<h2>Error</h2>','<p>The id number of the survey was not given as an integer.</p>')        
    r=[]
    try:
        s=surveyObject.survey(survey_id,dBcsr,log=log)
    except surveyObject.surveyError, err:
        bail("Unable to fetch the survey information from the database",devel="Unable to fetch the information for survey %(survey_id)s from the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    r.append(cgiUtils.section("Summary of Survey with ID=%s" % (s.getID(),)))
    r.append(s.show())
    return "".join(r)


def accept_approvals(fs,dBcnx,dBcsr,log=None):
    """Accept the checked approvals
      fs  A cgi FieldStorage structure
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None  A logging object
    """
    r=[]
    password=cgiUtils.getfirst(fs,'password',default='')
    sql="SELECT name FROM admins WHERE password=%(password)s"
    dct={'password':password}
    try:
        dBres=getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG,listtype='name of administrator')
    except dBUtilsError, err:
        bail("Unable to check the database for the administrative password",devel="Unable to check the database for the administrative password: %(err)s",log=log,debug=DEBUG,err=err)
    if not(dBres):
        time.sleep(3.0)  # slow down cracking
        bail("Unable to find that administrative password in the database",devel="Unable to find the administrative password %(password)s in the database",log=log,debug=DEBUG,password=password)
    (admin_name,)=dBres
    r.append("<p>Hello, %s.</p>\n" % (admin_name,))
    pending=cgiUtils.getlist(fs,'approve')
    if not(pending):
        r.append("<p><i>You checked none of the surveys for approval.</i></p>\n")
    else:
        for survey_id in pending:
            try:
                s=surveyObject.survey(survey_id,dBcsr,log=log)
            except surveyObject.surveyError, err:
                bail("Error while looking for a survey in the database",devel="Error while looking for survey %(survey_id)s in the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
            sql="UPDATE survey SET approved=TRUE WHERE id=%(survey_id)s"
            dct={'survey_id':survey_id}
            try:
                putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='update approval for survey')
            except dBUtilsError, err:
                bail("Error while updating the approval status of a survey in the database",devel="Error while updating the approval status of survey %(survey_id)s in the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
            try:
                message=StringIO.StringIO()
                writer=MimeWriter.MimeWriter(message)
                writer.addheader('subject',"Your survey for Theodolite: %s" % (s.getTitle(),))
                writer.addheader('MIME-Version','1.0')
                writer.startmultipartbody('mixed')
                
                part=writer.nextpart()
                body=part.startbody('text/plain')
                link="%s?id=%s" % (defaults.SURVEY_URL,s.getID())
                toUser="""Dear %s:
The survey that you entered into the Theodolite system titled
  %s
has been approved by the system administrator.  You can edit
the questions (if you have not already done so) at
  %s 
.  You can see the summary information and the survey results at
  %s
.

Thank you,
%s
""" % (s.getContactName(),s.getTitle(),"%s?survey_id=%s" % (defaults.ADMIN_URL,s.getID()),"%s?id=%s" % (defaults.RESULTS_URL,s.getID()),defaults.MAINTAINER)
                body.write(toUser)
                writer.lastpart()
                smtp=smtplib.SMTP('localhost')
                smtp.sendmail(s.getContactEmail(),defaults.MAINTAINER,message.getvalue())
                smtp.quit()
            except Exception, err:
                bail("Error while notifying the survey user for survey %(id)s",devel="Unable to mail the survey user %(contact_email)s for unapproved survey %(id)s: %(err)s",log=log,debug=DEBUG,id=s.getID(),contact_email=s.getContactEmail(),err=err)
        try:
            dBcnx.commit()
        except psycopg.DatabaseError, err:
            bail("Error while commiting updates of the approval status to the database",devel="Error while committing updates of the approval status of survey %(survey_id)s to the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
        r.append(cgiUtils.section('Thank you'))
        r.append("<p>Approval for survey %s has been put in the database.</p>" % (", ".join(map(str,pending)),))
    return "".join(r)




#........................................................
r=[cgiUtils.xhtml_content_type()]
r.append(cgiUtils.xhtml_head())
r.append(cgiUtils.page_head('Theodolite outstanding surveys'))
r.append(cgiUtils.page_start_body())
r.append(cgiUtils.page_top("Theodolite: outstanding surveys"))

log=None
if LOGGING:
    log=openLog(LOGFILE_NAME)

try:
    (dBcnx,dBcsr)=opendB()
except dBUtilsError, err:
    bail("Cannot open a connection to the database",devel="Cannont open a connection to the database: %(err)s",debug=DEBUG,err=err)

fs=cgi.FieldStorage(keep_blank_values=1)
if DEBUG:
    r.append(cgiUtils.dumpFieldStorage(fs))

if fs.has_key('submit'):
    r.append(accept_approvals(fs,dBcnx,dBcsr,log=log))
elif fs.has_key('id'):
    r.append(show_survey(fs,dBcnx,dBcsr,log=log))
else:
    r.append(default_page(fs,dBcnx,dBcsr,log=log))

r.append(cgiUtils.page_foot())
cgiUtils.return_page(r)
sys.exit(0)

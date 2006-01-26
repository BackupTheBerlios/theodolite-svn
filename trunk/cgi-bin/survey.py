#!/usr/bin/python2.3
#  admin.py
# 2004-Sept-10 Jim Hefferon jhefferon@smcvt.edu
import os, sys
import cgi, cgitb, urllib
import time, mx.DateTime
import smtplib, MimeWriter, StringIO
import sha

import psycopg

import cgiUtils
from cgiUtils import bail

import library
from util import *
import defaults
from dBUtils import *
import surveyObject

DEBUG=defaults.DEBUG
# DEBUG=True
LOGGING=True # permission to write to the log file?
LOGFILE_NAME='survey.log'
MAX_NUM_QUESTIONS=50
DEFAULT_QUESTION_TYPE='comment' # make sure it is in the dB

if DEBUG:
    cgitb.enable()


class surveyError(StandardError):
    pass


def default_page(fs,id,survey,dBcnx,dBcsr):
    """Start a survey
      fs  A cgi fieldStorage structure
      subject_id  The identifier of the subject taking the survey
      survey  An instance of a surveyObject
      dBcnx  A database connection
      dBcsr  A database cursor
    Returns a pair (success,page) where success if a flag, and page is some
    HTML.
    """
    return (True,survey.getHTML(action=defaults.SURVEY_URL,id=id))


def accept_survey(fs,subject_id,survey,dBcnx,dBcsr):
    """Gather the list of questions
      fs  a cgi.fieldStorage instance
      subject_id  The identifier of the subject taking the survey
      survey  An instance of a surveyObject
      dBcnx  A database connection
      dBcsr  A database cursor
    Might raise a surveyError.
    """
    r=[cgiUtils.section('Thank you')]
    email_response=["The subject id is %s" % (subject_id,)] # if email flag set
    # mark this subject down as having replied
    if survey.getNoSubjID(): # must insert the new subject id
        sql="INSERT INTO subjects (survey_id,id) VALUES (%(survey_id)s,%(subject_id)s)"
        dct={'survey_id':survey.getID(),
             'subject_id':subject_id}
        try:
            putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG)
        except dBUtilsError, err:
            bail("Unable to mark into the database the id of a subject making a reply",devel="Unable to mark into the database the id of a subject making a reply: %(err)s",log=log,debug=DEBUG,err=err)
    sql="INSERT INTO replied (survey_id,subject_id,date) VALUES (%(survey_id)s,%(subject_id)s,NOW())"
    dct={'survey_id':survey.getID(),
         'subject_id':subject_id}
    try:
        putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG)
    except dBUtilsError, err:
        bail("Unable to mark into the database that a reply was made",devel="Unable to mark into the database that a reply was made: %(err)s",log=log,debug=DEBUG,err=err)
    # Handle each question one at a time
    for q_no in range(1,survey.getNumberQuestions()+1):
        if DEBUG:
            r.append("<p>Doing question number %d</p>\n" % (q_no,))
        c_name="comment%d" % (q_no,)
        comment=cgiUtils.getfirst(fs,c_name)
        email_response.append("Question %d comment: %s\n" % (q_no,repr(comment)))
        # Insert the answers, inlcuding any comment, here.
        if survey.getAnonymous(): # if anonymous flag, don't record subject_id
            sql="INSERT INTO answers_anon (survey_id,number,comment) VALUES (%(survey_id)s,%(number)s,%(comment)s)"
            dct={'survey_id':survey.getID(),
                 'number':q_no,
                 'comment':comment}
            subject_id='anonymous' # for bail message
        else:
            sql="INSERT INTO answers (survey_id,subject_id,number,comment) VALUES (%(survey_id)s,%(subject_id)s,%(number)s,%(comment)s)"
            dct={'survey_id':survey.getID(),
                 'subject_id':subject_id,
                 'number':q_no,
                 'comment':comment}
        try:
            putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG)
        except dBUtilsError, err:
            bail("Unable to add the answers information into the database, including the comment",devel="Unable to add the answers information for %(subject_id)s on survey %(survey_id)s into the database, including the comment: %(err)s",log=log,debug=DEBUG,subject_id=subject_id,survey_id=survey_id,err=err)
        if survey.getAnonymous(): 
            sql="SELECT currval('answers_anon_dex_seq') FROM answers_anon"
            dct={}
            try:
                dBres=getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG,listtype='current value of answers_anon-dex_seq')
            except dBUtilsError, err:
                bail("Database error while fetching the survey",devel="Database error while fetching a survey associated with id %(id)s: %(err)s",dBcsr=dBcsr,log=log,debug=DEBUG,subject_id=id,err=err)
            dex=dBres[0]
        # If any values for the question, insert those
        q_name="question%d" % (q_no,)
        if survey.getQuestionMultiple(q_no):
            ans=cgiUtils.getlist(fs,q_name)
        else:
            ans=cgiUtils.getfirst(fs,q_name)
        if not(ans): # no answer found for this question
            # JH 2005-Oct-01 continue
            ans=None
        if not(type(ans)==type([])):
            ans=[ans]  # ans is a list for uniformity
        for val in ans:  
            # check the answer is legal
            legalAnswers=survey.getQuestionLegalAnswers(q_no)
            if log:
                log.debug("legal answers is %s" % (repr(legalAnswers),))
            if not(legalAnswers is None): # if it is None, any answer is legal
                if (not(val in legalAnswers)
                    and not(val is None)):  # the respondent didn't answer 
                    bail("The value given for one of the questions is not valid",devel="The value %(val)s given for question %(q_no)s is not valid on survey %(survey_id)s with subject %(subject_id)s",log=log,debug=DEBUG,val=val,q_no=q_no,survey_id=survey_id,subject_id=subject_id)
            # insert the value in the dB
            if survey.getAnonymous(): 
                sql="INSERT INTO answers_values_anon (dex,survey_id,number,value) VALUES (%(dex)s,%(survey_id)s,%(number)s,%(value)s)"
                dct={'dex':dex,
                     'survey_id':survey_id,
                     'number':q_no,
                     'value':val}
                subject_id='anonymous' # for bail message
            else:
                sql="INSERT INTO answers_values (survey_id,subject_id,number,value) VALUES (%(survey_id)s,%(subject_id)s,%(number)s,%(value)s)"
                dct={'survey_id':survey_id,
                     'subject_id':subject_id,
                     'number':q_no,
                     'value':val}
            try:
                putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG)
            except dBUtilsError, err:
                bail("Unable to put the answer value information in the database",devel="Unable to put the answer value information in the database for survey %(survey_id)s and question %(q_no)s with subject %(subject_id)s: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,q_no=q_no,subject_id=subject_id,err=err)
        email_response.append("Question %d response: %s\n" % (q_no,repr(val)))
    # done with the database stuffing.  Commit the inserts
    try:
        dBcnx.commit()
    except psycopg.DatabaseError, err:
        bail("Unable to commit the answer values information into the database",devel="Unable to commit the answer values information for survey %(survey_id)s into the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # send the email
    if survey.getEmail():
        try:
            message=StringIO.StringIO()
            writer=MimeWriter.MimeWriter(message)
            writer.addheader('subject',"Survey response for survey: %s" % (survey.getTitle(),))
            writer.addheader('MIME-Version','1.0')
            writer.startmultipartbody('mixed')
            part=writer.nextpart()
            body=part.startbody('text/plain')
            body.write("\n".join(email_response))
            writer.lastpart()
            smtp=smtplib.SMTP(defaults.THIS_MACHINE)
            smtp.sendmail(contact_email,MAINTAINER,message.getvalue())
            smtp.quit()
        except Exception, err:
            r="Unable to mail"
            r_debug=r+": %s" % (err,)
            if log:
                log.ERROR(r_debug)
            if DEBUG:
                r=r_debug
                r.append("<p>Unable to mail: %s</p>\n" % (err,))
    r.append("<p>Your responses have been recorded in the database.</p>\n")
    return (True,"".join(r))


#........................................................
r=[cgiUtils.xhtml_content_type()]
r.append(cgiUtils.xhtml_head())
r.append(cgiUtils.page_head('survey response'))
r.append(cgiUtils.page_start_body())

log=None
if LOGGING:
    log=openLog(LOGFILE_NAME)

# establish the database connection
try:
    (dBcnx,dBcsr)=opendB()
except dBUtilsError, err:
    bail("Unable to open the database",devel="Unable to open the database: %(err)s",log=log,debug=DEBUG,err=err)

fs=cgi.FieldStorage(keep_blank_values=1)
if DEBUG:
    r.append(cgiUtils.dumpFieldStorage(fs))

# get the id
id=cgiUtils.getfirst(fs,'id')
if id is None:
    cgiUtils.need_more('survey id parameter')

# Get the survey id
sql="SELECT survey_id FROM subjects WHERE id=%(id)s"
dct={'id':id}
try:
    dBres=getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG,listtype='subject id to survey id item')
except dBUtilsError, err:
    bail("Database error while fetching the survey",devel="Database error while fetching a survey associated with id %(id)s: %(err)s",dBcsr=dBcsr,log=log,debug=DEBUG,subject_id=id,err=err)
if not(dBres):  # maybe it is a survey id for a no_subj_id survey
    sql="SELECT no_subj_id FROM survey WHERE id=%(id)s"
    dct={'id':id}
    try:
        dBres=getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG,listtype='survey_id item')
    except dBUtilsError, err:
        bail("Databse error fetching the survey",devel="Databse error fetching a survey with id %(id)s: %(err)s",dBcsr=dBcsr,log=log,debug=DEBUG,id=id,err=err)
    try:
        survey_id=int(id)
    except ValueError, err:
        bail("Error fetching the survey",devel="Error fetching a survey with id %(id)s: %(err)s",dBcsr=dBcsr,log=log,debug=DEBUG,id=id,err=err)
    if not(dBres):
        bail("There is no subject and no survey with the given id",devel="There is no subject and no survey with id %(survey_id)s",dBcsr=dBcsr,log=log,debug=DEBUG,survey_id=survey_id)
    no_subj_id_flag=dBres[0]
    if not(no_subj_id_flag):
        bail("That survey is not open without a subject id",devel="The survey %(id)s is not open without a subject id",dBcsr=dBcsr,log=log,debug=DEBUG,survey_id=survey_id)
    sql="SELECT count(*) FROM replied WHERE survey_id=%(survey_id)s"
    dct={'survey_id':survey_id}
    try:
        dBres=getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG,listtype='count of answers to survey')
    except dBUtilsError, err:
        bail("Databse error assigning a subject id",devel="Databse error assigning a subject id for the survey with id %(survey_id)s: %(err)s",dBcsr=dBcsr,log=log,debug=DEBUG,survey_id=survey_id,err=err)
    count=dBres[0]
    try:
        process_id=os.getpid()
    except OSError, err:
        bail("Error assigning the subject an id",devel="Error assigning the subject an id for the survey with id %(survey_id)s; unable to get process id: %(err)s",dBcsr=dBcsr,log=log,debug=DEBUG,survey_id=survey_id,err=err)            
    subject_id=sha.new("%s%s%s" % (survey_id,count,process_id)).hexdigest()
else: # this is the normal situation
    subject_id=id
    survey_id=dBres[0]

# get the information about this survey
try:
    survey=surveyObject.survey(survey_id,dBcsr,log=log)
except surveyObject.surveyError, err:
    bail("Unable to get the survey information from the database.",devel="Unable to get the information about survey %(survey_id)s from the database.",log=log,debug=DEBUG,survey_id=survey_id)
#r.append(cgiUtils.page_top(survey.getTitle(),logoShown=False))

# see if the survey is open, and approved
now=mx.DateTime.localtime()
if not((now>=survey.getDateOpen())
       and (now<survey.getDateClosed())):
    bail("That survey is not active at this time.  The opening is %(date_open)s, and the closing is %(date_closed)s, while it is %(date_now)s now.  Thank you, anyway.",log=log,debug=DEBUG,date_open=survey.getDateOpen(),date_closed=survey.getDateClosed(),date_now=now)
if not(survey.getApproved()):
    bail('That survey has not yet been approved by the Theodolite survey system administrator.  Thank you, anyway.',devel="Survey %(survey_id)s has not yet been approved by the system administrator.",log=log,debug=DEBUG,survey_id=survey_id)

# Check if this person has already answered
if not(survey.getNoSubjID()):
    sql="SELECT date FROM replied WHERE subject_id=%(subject_id)s"
    dct={'subject_id':subject_id}
    try:
        dBres=getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG,listtype='reply date')
    except dBUtilsError, err:
        bail("A database problem happend while the system was checking whether you have already answered this survey",devel='A database problem happend while the system was checking whether %(subject_id)s has already answered survey %(survey_id)s: %(err)s',log=log,debug=DEBUG,subject_id=subject_id,survey_id=survey_id,err=err)
    if dBres:
        (date,)=dBres
        bail("The database says that you have already answered this survey, at %(date)s.",devel="The database says that subject %(subject_id)s has already answered survey %(survey_id)s, at %(date)s.",log=log,debug=DEBUG,date=date,subject_id=subject_id,survey_id=survey_id)

# select which page to show
if fs.has_key('Done'):
    (success,page)=accept_survey(fs,subject_id,survey,dBcnx,dBcsr)
else:
    (success,page)=default_page(fs,id,survey,dBcnx,dBcsr)
if success:
    r.append(page)
    #r.append("<pre>\n%s\n</pre>\n" % (cgi.escape(repr(page)),))
else:
    r.append(page)
r.append(cgiUtils.page_foot())

# show the page
cgiUtils.return_page(r)
if success:
    sys.exit(0)
else:
    sys.exit(10)

#!/usr/bin/python2.3
#  mails.py
# Send out any mails called for by the Theodolite surveying system.
# 2004-Sep-15 Jim Hefferon jim@joshua.smcvt.edu
import os, sys
import time, mx.DateTime

import getopt
import smtplib, MimeWriter, StringIO

import psycopg

import defaults
import dBUtils
from util import *
import surveyObject

DEBUG=defaults.DEBUG
LOGGING=False # permission to write to the log file?
LOGFILE_NAME='mails.log'


class mailsError(StandardError):
    pass

# TODO Check if questions have been entered

def one_survey(survey_id,dBcnx,dBcsr,log=None,debug=False):
    """Send out the email for one survey.
      survey_id  The database's id for the survey
      dBcnx  A database connection
      dBcsr  A database cursor
      log=None  A logging object
      debug=False  Whether to output extra information
    May raise mailsError.  Returns None for success, or a string for failure
    """
    try:
        s=surveyObject.survey(survey_id,dBcsr=dBcsr,log=log)
    except surveyObject.surveyError, err:
        noteException("Unable to select survey information from the database table for survey object with id=%(id)s: %(err)s",exception=mailsError,log=log,debug=DEBUG,id=id,err=err)
    if verbose:
        print "Checking survey:"
        print s._administrivia(prefix='    ')
    # couple of sanity checks
    if not(s.getApproved()):
        return "Survey not approved"
    if not(s.questionsEntered()):
        return "Survey questions have not been entered"
    today=mx.DateTime.now()
    if (s.getDateOpen()>today
        or s.getDateClosed()<today):
        return "Survey is not active"
    # check if the sent flags are True"
    if not(s.getMail1Sent()):
        if verbose:
            print "  About to send mail one for the survey"
        send_mail(s.getMail1(),survey_id,dBcsr)
        sql="UPDATE survey SET mail1sent=TRUE WHERE id=%(survey_id)s"
        dct={'survey_id':survey_id}
        try:
            dBUtils.putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug,listtype='update survey that first mail sent')
            #dBcnx.commit()
            pass
        except dBUtils.dBUtilsError, err:
            noteException("Unable to update the database survey table mail 1 sent flag using query %(sql)s: %(err)s",exception=mailsError,log=log,debug=DEBUG,sql=sql,err=err)
    elif (s.getMail2()
          and s.getDateMail2()<today
          and not(s.getMail2Sent())):
        if verbose:
            print "  About to send mail 2 for the survey"
        send_mail(s.getMail2(),survey_id,dBcsr)
        sql="UPDATE survey SET mail2sent=TRUE WHERE id=%(survey_id)s"
        dct={'survey_id':survey_id}
        try:
            dBUtils.putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug,listtype='update survey that second mail sent')
        except dBUtils.dBUtilsError, err:
            noteException("Unable to update the database survey table mail 2 sent flag using query %(sql)s: %(err)s",exception=mailsError,log=log,debug=DEBUG,sql=sql,err=err)
    elif (s.getMail3()
          and s.getDateMail3()<today
          and not(s.getMail3Sent())):
        if verbose:
            print "  About to send mail 3 for the survey"
        send_mail(s.getMail3(),survey_id,dBcsr,log=log,debug=debug)
        sql="UPDATE survey SET mail3sent=TRUE WHERE id=%(survey_id)s"
        dct={'survey_id':survey_id}
        try:
            dBUtils.putData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug,listtype='update survey that third mail sent')
            pass
        except dBUtils.dBUtilsError, err:
            noteException("Unable to update the database survey table mail 3 sent flag using query %(sql)s: %(err)s",exception=mailsError,log=log,debug=DEBUG,sql=sql,err=err)
    else:
        if verbose:
            print "  No mails to send for this survey"
    return None


def send_mail(template,survey_id,dBcsr,log=None,debug=False):
    """Send the mails to the people in survey_id that are relevant.
        template  string to send as email message.  Note the LINK_STRING.
        survey_id  id number of the survey
        dBcsr  database cursor
        log=None  A logging object
        debug=False  Whether to output extra info on error
    """
    #print "in send_mail with survye_id=",repr(survey_id)
    dct={'survey_id':survey_id}
    sql="SELECT title, contact_email FROM survey WHERE id=%(survey_id)s"
    try:
        dBres=dBUtils.getData(sql,dct=dct,dBcsr=dBcsr,selectOne=True,log=log,debug=debug,listtype='title and contact email for a survey')
    except dBUtils.dBUtilsError, err:
        noteException("Unable to get the title of the survey %(id)s from the database using query %(sql)s: %(err)s",exception=mailsError,log=log,debug=DEBUG,id=id,sql=sql,err=err)
    if dBres:
        (title,contact_email)=dBres
    else:
        noteException("Unable to get the title of the survey: there seems to be no survey with id=%(id)s",exception=mailsError,log=log,debug=DEBUG,id=repr(id))
    # get the subjects to which to send mails
    sql="SELECT subjects.id, subjects.email FROM subjects WHERE subjects.survey_id=%(survey_id)s AND subjects.id NOT IN ( SELECT DISTINCT answers.subject_id FROM answers WHERE answers.survey_id=%(survey_id)s )"
    try:
        dBres=dBUtils.getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=debug,listtype='subjects for a survey')
    except dBUtils.dBUtilsError, err:
        noteException("Unable to get the list of subject ids and emails for the survey %(id)s from the database using query %(sql)s: %(err)s",exception=mailsError,log=log,debug=DEBUG,id=id,sql=sql,err=err)
    # Make the emails
    for (id,email) in dBres:
        if verbose:
            print "  About to send mail to %s" % (email,)
        message=StringIO.StringIO()
        writer=MimeWriter.MimeWriter(message)
        writer.addheader('subject',title)
        writer.addheader('MIME-Version','1.0')
        writer.startmultipartbody('mixed')

        part=writer.nextpart()
        body=part.startbody('text/plain')
        link="%s?id=%s" % (defaults.SURVEY_URL,id)
        body.write(template.replace(defaults.LINK_STRING,link))
        writer.lastpart()
        smtp=smtplib.SMTP('localhost')
        #print "email is ",repr(email)
        email.strip()
        try:
            smtp.sendmail(contact_email,email,message.getvalue())
        except Exception, err:
            print "Unable to send mail to %s: %s" % (email,err)
        smtp.quit()
        #print "message.getvalue() is ",message.getvalue()
        time.sleep(defaults.PAUSE_BETWEEN_EMAILS)
    return




#===================================================================
if __name__=='__main__':
    # see top of file for DEBUG variable
    verbose=False
    id=None
    test=False
    usage="""%s: Send mails due to the Theodolite subjects.
  --id=<integer>  Send only the mails for the survey number id.  (If not
    present, all active surveys are used.)
  --test  Print what would be done, but don't do it
  -v give verbose output
  -D set the debug flag
  -? or --help  Give this usage statement""" % (sys.argv[0],)
    shortOptions='Dvh?'
    longOptions=['help','id=','test']
    try:
        (opts,args_proper)=getopt.getopt(sys.argv[1:],shortOptions,longOptions)
    except getopt.GetoptError, err:
        fail("Unable to parse the command line arguments: %(err)s",returnCode=1,log=log,debug=DEBUG,err=err)
    for (option,parameter) in opts:
        if option=='--id':
            id=parameter
            try:
                id=int(id)
            except:
                fail("Unable to recognize id's parameter %(parameter)s as an integer",returnCode=2,log=log,debug=DEBUG,parameter=repr(parameter))
        elif option=='--test':
            test=True
        elif option=='-D':
            DEBUG=True
        elif option=='-v':
            verbose=True
        elif (option=='-?'
              or option=='--help'):
            print >>sys.stdout, usage
            sys.exit(0)
    # done getting the parameters, open some connections
    log=None
    if LOGGING:
        try:
            log=openLog(LOGFILE_NAME,announce=DEBUG)
        except utilError, err:
            fail("Unable to open log file %(logfilename)s: %(err)s",returnCode=3,log=None,debug=DEBUG,logfilename=LOGFILE_NAME,err=err)
    try:
        (dBcnx,dBcsr)=dBUtils.opendB()
    except dBUtils.dBUtilsError, err:
        fail("Unable to open the database: %(err)s",returnCode=4,log=log,debug=DEBUG,err=err)
    # connections open, now start working
    if not(id is None):
        try:
            surveyResult=one_survey(id,dBcnx,dBcsr,log=log,debug=DEBUG)
        except mailsError, err:
            fail("Unable to run the one survey %(id)s: %(err)s",returnCode=10,log=log,debug=DEBUG,id=id,err=err)
        if surveyResult:
            m=msg("WARNING: unexpected results from mailing to survey-takers for survey id=%(id)s: %(surveyResult)s",log=log,debug=DEBUG,id=id,surveyResult=surveyResult)
            print >>sys.stderr, m
        elif verbose:
            m=msg("Notice: mailing completed to survey-takers for survey id=%(id)s: %(surveyResult)s",log=log,debug=DEBUG,id=id,surveyResult=surveyResult)
            print >>sys.stderr, m            
    else:
        sql="SELECT id FROM survey WHERE (date_open<=CURRENT_DATE) AND (date_closed>=CURRENT_DATE)"
        dct={}
        try:
            dBres=dBUtils.getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='list of active surveys')
        except dBUtils.dBUtilsError, err:
            fail("Unable to select active surveys from the database with the query %(sql)s: %(err)s",returnCode=11,log=log,debug=DEBUG,sql=sql,err=err)
        for (id,) in dBres:
            try:
                surveyResult=one_survey(id,dBcnx,dBcsr,log=log,debug=DEBUG)
            except mailsError, err:
                fail("From among the active surveys %(dBres)s unable to run the one %(id)s: %(err)s",returnCode=12,log=log,debug=DEBUG,dBres=repr(dBres),id=id,err=err)
            if surveyResult:
                m=msg("WARNING: unexpected results from mailing to survey-takers for survey id=%(id)s: %(surveyResult)s",log=log,debug=DEBUG,id=id,surveyResult=surveyResult)
                print >>sys.stderr, m
            elif verbose:
                m=msg("Notice: mailing completed to survey-takers for survey id=%(id)s: %(surveyResult)s",log=log,debug=DEBUG,id=id,surveyResult=surveyResult)
                print >>sys.stderr, m            
    try:
        dBcnx.commit()
    except psycopg.DatabaseError, err:
        fail("Unable to commit the results to the database: %(err)s",returnCode=13,log=log,debug=DEBUG,err=err)
    sys.exit(0)

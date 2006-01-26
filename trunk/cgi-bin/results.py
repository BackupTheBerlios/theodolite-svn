#!/usr/bin/python2.3
#  results.py
# 2004-Sept-19 Jim Hefferon jhefferon@smcvt.edu

# TODO The SPSS option is a hack to get around the fact that the SPSS wizard
#  cannot handle strings; it does not know what the quotes mean, and does
#  not understand how to skip the commas (anc cannot handle multiple values).
import os, sys
import cgi, cgitb, urllib

import math
import cgiUtils
from cgiUtils import bail

import psycopg

import library
import defaults
from dBUtils import *
from util import *
import surveyObject

DEBUG=defaults.DEBUG
# DEBUG=True
CHECK_PASSWORD=False
LOGGING=True # permission to write to the log file?
LOGFILE_NAME='results.log'
ANSWER_FORMAT="%(number)s, %(subject_id)s, %(value)s, %(comment)s" # answers are in comma-separated values form; for possible fields, see the answer_dct below

if DEBUG:
    cgitb.enable()


class resultsError(StandardError):
    pass


def default_page(fs,survey_id,survey,dBcnx,dBcsr):
    """Start a survey
      fs  A cgi fieldStorage structure
      survey_id  integer  The id of the survey
      survey  A surveyObject.survey instance
      dBcnx  A database connection
      dBcsr  A database cursor
    Returns a pair (success,page) where success if a flag, and page is some
    HTML.
    """
    survey_id=cgiUtils.getfirst(fs,'id')
    if survey_id is None:
        return (False,cgiUtils.need_more('survey id'))
    # Check the survey id
    sql="SELECT title FROM survey"
    dct={'survey_id':survey_id}
    try:
        s=surveyObject.survey(survey_id,dBcsr,log=log)
    except surveyObject.surveyError, err:
        bail("Trouble getting the survey information from the database",devel="Trouble getting information from the database for survey %(survey_id)s: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    if not(s):
        bail("The system cannot find a survey with the id that you gave",devel="The system cannot find a survey with survey is %(survey_id)s",log=log,debug=DEBUG,survey_id=survey_id)
    # present the survey
    r=["<form action='%s' method='POST'>\n" % (defaults.RESULTS_URL,)]
    r.append("<input type='hidden' name='id' value='%s' />\n" % (s.getID(),))
    r.append(cgiUtils.section('Enter the password'))
    r.append("<p>Enter the password for this survey data.</p>\n")
    r.append("<center><input type='password' name='password' size='20' /></center>\n")
    r.append("<input type='submit' name='Ready' value='Ready' />\n")
    r.append("</form>\n")
    return (True,"".join(r))


def escape_double_quotes(s):
    """Convert double quotes to pairs of single quotes
      s A string
    """
    return s.replace('"',"''")


def analyze(vals,analyzableVals,quantitative=False,keys=[]):
    """Find the distribution of a list of values (if quantitative=True, then
    it will try to find the mean and std dev also, so the things in the list
    must be numbers in that case)
      vals  The list of values
      analyzableVals  The list of values to include in analysis
      quantitative=False  If true, calculate the mean and standard deviation
      keys=[]  Seed list of keys
    Returns the triple (freq,total,mean,stddev) where freq is a dictionary
    mapping values to the number of times that value appeared in the list
    """
    mean=0
    std_dev=0
    sum_x=0
    sum_xsquared=0
    freq={}
    if keys:
        for k in keys:
            freq[k]=0
    n=0
    analyzableN=0
    if vals:
        for x in vals:
            n+=1
            if freq.has_key(x):
                freq[x]+=1
            else:
                freq[x]=1
            if quantitative:
                if not(x in analyzableVals):
                    continue
                analyzableN+=1
                try:
                    x=float(x)  # will convert strings to nos, if needed
                except ValueError, err:
                    bail('One of the values in a quantitative question is not interpretable as a number',devel="One of the values %(x)s in a question that is listed as quantitative raised an error on conversion to float: %(err)s",log=log,debug=DEBUG,x=repr(x),err=err)
                sum_x+=x
                sum_xsquared+=math.pow(x,2)
        if quantitative:
            mean=sum_x/analyzableN

            numerator=sum_xsquared-(pow(sum_x,2)*1.0/analyzableN)
            if     analyzableN==1:
                std_dev=0
            else:
                std_dev=math.sqrt(numerator*1.0/(analyzableN-1))
    return (freq,n,mean,std_dev)
        

def show_results(fs,survey_id,survey,dBcnx,dBcsr):
    """Show the results currently in the database
      fs  A CGI fieldStorage structure
      survey_id  integer  The id of the survey
      survey  A surveyObject.survey instance
      dBcnx  A database connection
      dBcsr  A database cursor
    """
    r=[]
    # Check the password
    password_given=cgiUtils.getfirst(fs,'password')
    if password_given is None:
        return (False,cgiUtils.need_more('password'))
    if (CHECK_PASSWORD
        and (password!=survey.getPassword())):
        bail("Incorrect password",devel="Incorrect administrative password given '%(password)s' for survey %(survey_id)s",log=log,debug=DEBUG,survey_id=survey_id,password=password)
    # Get the number of respondents by question number for this survey
    respondents={}
    for q_no in range(1,survey.getNumberQuestions()+1):
        if survey.getAnonymous():
            sql="SELECT COUNT(*) FROM answers_anon WHERE survey_id=%(survey_id)s AND number=%(number)s"
        else:
            sql="SELECT COUNT(*) FROM answers WHERE survey_id=%(survey_id)s AND number=%(number)s"
        dct={'survey_id':survey_id,
             'number':q_no}
        try:
            dBres=getData(sql,dct=dct,selectOne=True,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='respondent count information')
        except dBUtilsError, err:
            bail("Unable to get the count of respondents information for this survey from the database",devel="Unable to get the count of respondents information for question %(q_no)s for survey %(survey_id)s from the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,q_no=q_no,err=err)
        respondents[q_no]=dBres[0]
    # Get the comments by number for this survey
    if survey.getAnonymous():
        sql="SELECT number,comment FROM answers_anon WHERE survey_id=%(survey_id)s"
    else:
        sql="SELECT number,comment FROM answers WHERE survey_id=%(survey_id)s"
    dct={'survey_id':survey_id}
    try:
        dBres=getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='answer number and comment information')
    except dBUtilsError, err:
        bail("Unable to get the comment information for this survey from the database",devel="Unable to get the comment information for survey %(survey_id)s from the database: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    comments={}   # mapping question number -> comment
    for q_no in range(1,survey.getNumberQuestions()+1):
        comments[q_no]=[]
    for (number,comment) in dBres:
        if comment:
            comments[number].append(comment)
    # Get all the answers values information for this survey
    if survey.getAnonymous():
        sql="SELECT number,value FROM answers_values_anon WHERE survey_id=%(survey_id)s"
    else:
        sql="SELECT number,value FROM answers_values WHERE survey_id=%(survey_id)s"
    dct={'survey_id':survey_id}
    try:
        dBres=getData(sql,dct=dct,log=log,debug=DEBUG,listtype='answers values information')
    except dBUtilsError, err:
        bail("Unable to get the answers values information from the database",devel="Unable to get the answers values information for survey %(survey_id)s: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    # gather the data into lists
    values={}  # mapping question number -> list of values
    analyzableAnswers={} # dct of lists: q_no -> list of analyzable answers
    analyzableValues={}  # dct of lists: q_no -> list of values received
    for q_no in range(1,survey.getNumberQuestions()+1):
        values[q_no]=[]
        analyzableAnswers[q_no]=survey.getQuestionAnswersAnalyzable(q_no)
        analyzableValues[q_no]=[]
    for (number,value) in dBres:
        #if value is None:  # respondent did not submit a response
        #    continue
        lAns=survey.getQuestionLegalAnswers(number)
        if ((lAns is None)
            or (value is None)
            or (value in lAns)):
            values[number].append(value)
        else: # shouldn't happen
            bail("A value for a question is there that is not a legal answer",devel="Found a value %(value)s for question %(number)s that is not a legal answer",log=log,debug=DEBUG,value=value,number=number)
        if (analyzableAnswers .has_key(number)
            and analyzableValues.has_key(number)
            and ((analyzableAnswers[number] is None)
                 or (value in analyzableAnswers[number]))):
            analyzableValues[number].append(value)
    # Done gathering the data; now compute and display it
    for q_no in range(1,survey.getNumberQuestions()+1):
        r.append("<table class='results'>\n") # the table for this question
        r.append("<tr class='question_row'><td>Question %s: <i>%s</i></td></tr>\n" % (q_no,survey.getQuestionBody(q_no)))
        r.append("<tr><td>Number of respondents: %s</td></tr>\n" % (respondents[q_no],))
        r.append("<tr class='results_row'><td>\n")
        if values[q_no]:
            if (survey.getQuestionQuantitative(q_no)
                or survey.getQuestionBarChart(q_no)):
                (freq,total,mean,stddev)=analyze(values[q_no],analyzableValues[q_no],quantitative=survey.getQuestionQuantitative(q_no),keys=survey.getQuestionLegalAnswers(q_no))
                r.append("  <table>\n")
                #r.append("  <tr><th></th> <th>distribution of responses</th></tr>\n")
                if survey.getQuestionBarChart(q_no):
                    topr=["  <tr class='results_values'><td class='value'>value</td> "]
                    botr=["  <tr class='results_number'><td class='number'>number</td> "]
                    if survey.getQuestionLegalAnswers(q_no) is None:
                        keys=freq.keys()
                        keys.sort()
                    else:
                        keys=survey.getQuestionLegalAnswers(q_no) # preserve order in which they were entered into the dB, if possible
                    for k in keys:
                        topr.append(" <td class='key'>%s</td>" % (cgi.escape(k),))
                        if freq.has_key(k):
                            count=freq[k]
                        else:
                            count=0
                        if respondents[q_no]>0:
                            botr.append(" <td class='total'>%s&nbsp;&nbsp;%0.0f%%</td>" % (freq[k],100.0*freq[k]/(respondents[q_no])))
                        else:
                            botr.append(" <td class='total'>%s</td>" % (freq[k],))
                    topr.append("  </tr>\n")
                    botr.append("  </tr>\n")
                    r.append("<tr><td><table class='results_distribution'>\n")
                    r.append("".join(topr))
                    r.append("".join(botr))
                    r.append("</table></td></tr>\n")
                if survey.getQuestionQuantitative(q_no):
                    r.append("<tr class='mean'><td>mean: %0.1f, standard deviation: %0.1f</td></tr>" % (mean,stddev))
                if comments[q_no]:
                    r.append("  <tr><td>Comments: <table class='comments_list'>\n")
                    row_kind='evenrow'
                    for v in comments[q_no]:
                        r.append("    <tr class='%s'><td>%s</td></tr>\n" % (row_kind,cgi.escape(v),))
                        if row_kind=='evenrow':
                            row_kind='oddrow'
                        else:
                            row_kind='evenrow'
                    r.append("  </table></td></tr>\n")                    
                r.append("  </table>\n")
            else:  # if notquantative, just list
                r.append("  <table class='results_list'>\n")
                row_kind='evenrow'
                for v in values[q_no]:
                    r.append("    <tr class='%s'><td>%s</td></tr>\n" % (row_kind,cgi.escape(v),))
                    if row_kind=='evenrow':
                        row_kind='oddrow'
                    else:
                        row_kind='evenrow'
                r.append("  </table>\n")
        else:
            r.append("There are no values yet.")
        r.append("</td></tr>\n") # close the table for this question
        r.append("</table>\n")
    # to get the full CSV file
    r.append("<p>\n")
    r.append("<form action='%s' method='POST'><input type='hidden' name='csv_id' value='%s' /><input type='hidden' name='password' value='%s' />To get the comma-separated-values file, click for <input type='submit' name='csv_general' value='General' /> or <input type='submit' name='csv_spss' value='Tab-delimited (for SPSS)' />.</form>\n" % (defaults.RESULTS_URL,survey_id,survey.getPassword()))
    r.append("</p>\n")
    # show the administrative information about the survey
    #  a user can check their values here
    r.append(cgiUtils.section('Information about your survey'))
    r.append("<p>This is the information in the database for your survey.</p>\n")
    r.append(survey.show())
    return (True,"".join(r))


class textFile(object):
    """Make a plain text file from the survey results, for the survey giver to
download for analysis by a real stats package.
"""
    def __init__(self,survey,dBcnx,dBcsr):
        """
          survey  A surveyObject instance
          dBcnx  A database connection
          dBcsr  A database cursor
        """
        self.survey=survey
        self.survey_id=survey.getID()  # handy to have without calling all over
        self.dBcnx=dBcnx
        self.dBcsr=dBcsr

    def handle_text(self,s):
        """How to do escaping in text, such as comments?  The default is to
replace double quotes with two single quotes, and surround the string
with double quotes.
  s  input string
"""
        return "\"%s\"" % (s.replace('"',"''"))

    def handle_text_field(self,s):
        """If the field is None (that is, was NULL in the dB), return an
empty string; else call handle_text
  s  input string or None
"""
        if s is None:
            return ''
        else:
            return self.handle_text(s)

    def translate_answer_format(self,f):
        """Change the listed answer format
  f  answer format
"""
        return f
    
    def make_file(self):
        """Make the file of the complete survey results.
Returns a pair (flag,string); if the flag is True then success was had and the
desired file is in string.  If the flag is false then the error message is in
the string.
"""
        lineFormat=self.translate_answer_format(self.survey.getTextFileLineFormat()) 
        r=[]
        # these fields are available for answerFormat
        answer_dct={'title':self.handle_text_field(survey.getTitle()),  
                    'contact_name':self.handle_text_field(survey.getContactName()),
                    'no_qs':survey.getNumberQuestions(),
                    'anonymous':survey.getAnonymous(),
                    'date_open':survey.getDateOpen(),
                    'mail1':self.handle_text_field(survey.getMail1()),
                    'mail1sent':survey.getMail1Sent(),
                    'date_mail2':survey.getDateMail2(),
                    'mail2':self.handle_text_field(survey.getMail2()),
                    'mail2sent':survey.getMail2Sent(),
                    'date_mail3':survey.getDateMail3(),
                    'mail3':self.handle_text_field(survey.getMail3()),
                    'mail3sent':survey.getMail3Sent(),
                    'date_closed':survey.getDateClosed()}
        # Get the answer data
        if self.survey.getAnonymous():
            sql="SELECT dex,number,comment FROM answers_anon WHERE survey_id=%(survey_id)s"
        else:
            sql="SELECT subject_id,number,comment FROM answers WHERE survey_id=%(survey_id)s"
        dct={'survey_id':self.survey_id}
        try:
            dBres=getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='answer data')
        except dBUtilsError, err:
            bail("Unable to get the answers for this survey by fetching from the database",devel="Unable to get the answers for survey %(survey_id)s by fetching from the database: %(err)s",log=log,debug=DEBUG,survey_id=self.survey_id,err=err)
        dexes=[]  # list of all dex or subject_id's
        # comments is a dct such that comments[dex][x] is the comment made by
        # subject dex to question x
        comments={}
        priorDex=None
        for (dex,number,comment) in dBres:
            comments[dex]={}
            if dex!=priorDex:
                dexes.append(dex)
                priorDex=dex
        for (dex,number,comment) in dBres:
            if (log and DEBUG):
                log.debug("subject_id is %s, number is %s, comment is %s, comments is %s" % (dex,number,comment,repr(comments)))
            if comment is not None:
                comments[dex][number]=comment
        # Recall that some questions may get multiple answers ("check all that
        # apply" with a HTML checkbox)
        # Here is how we handle that.  The line gets repeated until all the
        # multiple answers are exhausted, with blanks elsewhere.
        if self.survey.getAnonymous():
            sql="SELECT dex,subject_id,number,value FROM answers_values_anon WHERE survey_id=%(survey_id)s ORDER BY dex, number"
        else:
            sql="SELECT subject_id,subject_id,number,value FROM answers_values WHERE survey_id=%(survey_id)s ORDER BY subject_id, number"
        dct={'survey_id':self.survey_id}
        try:
            dBres=getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='answers values information')
        except dBUtilsError, err:
            bail("Unable to get the answers values for this survey by fetching from the database",devel="Unable to get the answers values for survey %(survey_id)s by fetching from the database: %(err)s",log=log,debug=DEBUG)
        # define dct answers: maps dex --> answers given by that subject
        answers={}
        prior=None
        for (x,subject_id,number,value) in dBres:
            if not(x==prior):
                answers[x]={} # answers[s] dct will map q_no -> list of answers
                for i in range(1,survey.getNumberQuestions()+1):
                    answers[x][i]=[]  
        for (x,subject_id,number,value) in dBres:
            answers[x][number].append(value)
        # have now stored all the answers in the data structure (and comments
        # in a separate data structure).  Ready to substitute into the
        # lineFormat
        for dex in dexes:  # for each respondent
            firstLine=True
            doAnotherLine=False
            while (firstLine
                   or doAnotherLine):  # produce the lines for that respondent
                doAnotherLine=False  
                answer_dct={}
                answer_dct['subject_id']=dex
                for i in range(1,survey.getNumberQuestions()+1): # build the answer dictionary
                    answerKey="answer%03d" % (i,)  # see surveyObject.getTextFileLineFormat
                    commentKey="comment%03d" % (i,)
                    try:
                        value=answers[dex][i].pop()
                    except IndexError:
                        value=''
                    doAnotherLine=(doAnotherLine or answers[dex][i]) # anything left on the list of answers?
                    if value is None:  # if respondent didn't submit at all
                        value=''
                    if survey.getQuestionQuantitative(i):
                        answer_dct[answerKey]=value
                    else:
                        answer_dct[answerKey]=self.handle_text_field(value)
                    if (firstLine
                        and comments[dex].has_key(i)):
                        answer_dct[commentKey]=self.handle_text_field(comments[dex][i])
                    else:
                        answer_dct[commentKey]=''
                firstLine=False
                r.append(lineFormat % answer_dct)
        return (True,"\n".join(r))


class textFileSPSS(textFile):
    """Make a plain text file from the survey results, suited for SPSS
"""
    def handle_text(self,s):
        """Because the SPSS wizard is inept, we do not surround strings with
quotes and we replace tab with four spaces (and do tab-delimited).
  s  input string
"""
        s=s.replace("\t",'    ')  # replace tab with four spaces
        return  "\"%s\"" % (s.replace('"',"''"))

    def translate_answer_format(self,f):
        """Change the listed answer format by replacing the commas with tabs
  f  answer format
"""
        return f.replace(", ","\t")



#........................................................
r=[cgiUtils.xhtml_content_type()]
r.append(cgiUtils.xhtml_head())
r.append(cgiUtils.page_head('Survey results'))
r.append(cgiUtils.page_start_body())
r.append(cgiUtils.page_top('Results for your survey'))

log=None
if LOGGING:
    log=openLog(LOGFILE_NAME)

try:
    (dBcnx,dBcsr)=opendB()
except dBUtilsError, err:
    bail("Unable to connect to the database",devel="Unable to connect to the database: %(err)s",log=log,debug=DEBUG,err=err)
if not(dBcsr):
    bail("Connecting to the database failed",devel="Connecting to the database failed: dB cursor is null",log=log,debug=DEBUG)

# get the cgi fields information
fs=cgi.FieldStorage(keep_blank_values=1)
if DEBUG:
    cgiUtils.dumpFieldStorage(fs)

# get the survey id 
if fs.has_key('csv_id'):
    survey_id=cgiUtils.getfirst(fs,'csv_id')
else:
    survey_id=cgiUtils.getfirst(fs,'id')
if survey_id is None:
    cgiUtils.need_more("survey id")

# get the information about this survey
try:
    survey=surveyObject.survey(survey_id,dBcsr,log=log)
except surveyObject.surveyError, err:
    bail("Unable to get information from the database about the survey",devel="Unable to get information from the database about survey %(survey_id)s: %(err)s",log=log,debug=DEBUG,survey_id=survey_id,err=err)
    
# display the pages
if fs.has_key('csv_id'):
    # Check the password
    password_given=cgiUtils.getfirst(fs,'password')
    if password_given is None:
        bail("no password",devel="no password was given in attempting to see the results for survey %(survey_id)s",log=log,debug=DEBUG,survey_id=survey_id)
    if (CHECK_PASSWORD
        and (password!=survey.getPassword())):
        bail("Incorrect password",devel="Incorrect administrative password given '%(password)s' for survey %(survey_id)s",log=log,debug=DEBUG,survey_id=survey_id,password=password)
    if fs.has_key('csv_spss'):
        #(success,f)=send_SPSS_file(fs,survey_id,survey,dBcnx,dBcsr)
        (success,f)=textFileSPSS(survey,dBcnx,dBcsr).make_file()
    else:
        # (success,f)=send_file(fs,survey_id,survey,dBcnx,dBcsr)
        (success,f)=textFile(survey,dBcnx,dBcsr).make_file()
    if success:
        print "Content-Type: text/plain\n"
        print "".join(f)
        sys.exit(0)
    else:
        page=f
elif fs.has_key('Ready'):
    (success,page)=show_results(fs,survey_id,survey,dBcnx,dBcsr)
else:
    (success,page)=default_page(fs,survey_id,survey,dBcnx,dBcsr)

r.append(page)

r.append(cgiUtils.page_foot())
cgiUtils.return_page(r)
sys.exit(0)

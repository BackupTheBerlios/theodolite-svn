#!/usr/bin/python2.3
#  survey.py
# Class survey for use by the Theodolite system
# 2004-Sep-28 Jim Hefferon
import logging
import psycopg
import cgi

import dBUtils
from util import *
sys.path.append('/home/svn/theodolite/trunk/cgi-bin')
import cgiUtils
import defaults
DEBUG=defaults.DEBUG

class surveyError(StandardError):
    pass

class survey(object):
    """Encapsulate the information about a survey"""
    def __init__(self,survey_id,dBcsr,log=None):
        """
          survey_id  The number of the survey
          dBcsr  a database cursor
          log  A logging object
        """
        self.id=survey_id
        # get the overall survey information (administrivia)
        sql="SELECT title,contact_name,contact_email,password,intro,no_qs,email,anonymous,approved,answer_format,no_subj_id,prefix,postfix,date_open,mail1,mail1sent,date_mail2,mail2,mail2sent,date_mail3,mail3,mail3sent,date_closed FROM survey WHERE id=%(survey_id)s"
        dct={'survey_id':survey_id}
        try:
            dBres=dBUtils.getData(sql,dct,dBcsr=dBcsr,selectOne=True,log=log,debug=DEBUG)
            #dBcsr.execute(sql,dct)
            #dBres=dBcsr.fetchone()
        #except psycopg.DatabaseError, err:
        except dBUtils.dBUtilsError, err:
            noteException("Unable to get survey object with id %(survey_id)s from the database",devel="Unable to get survey object with id %(survey_id)s from the database: %(err)s",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id,err=err)
        if not(dBres):
            noteException("Unable to find a survey object with id %(survey_id)s from the database",devel="Unable to get survey object with id %(survey_id)s from the database: query results empty",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id)
        (self.title,self.contact_name,self.contact_email,self.password,self.intro,self.no_qs,self.email,self.anonymous,self.approved,self.answer_format,self.no_subj_id,self.prefix,self.postfix,self.date_open,self.mail1,self.mail1sent,self.date_mail2,self.mail2,self.mail2sent,self.date_mail3,self.mail3,self.mail3sent,self.date_closed)=dBres
        # get the question type information
        sql="SELECT type, description, multiple, quantitative, bar_chart, html FROM question_types"
        try:
            dBres=dBUtils.getData(sql,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='list of question type information')
        except dBUtils.dBUtilsError, err:
            noteException("Unable to get question type information from the database",devel="Unable to get question type information from the database for the survey %(survey_id)s: %(err)s",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id,err=err)
        if dBres is None:
            noteException("Unable to find question type information in the database",devel="Unable to find question type information in the database for the survey %(survey_id)s, result of query is empty",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id)
        qTypeDct={} # map q type -> (description,multiple,quantitative,html)
        for (type,description,multiple,quantitative,bar_chart,html) in dBres:
            qTypeDct[type]=(description,multiple,quantitative,bar_chart,html)
        # get the legal answers information
        sql="SELECT q_type, answer, analyzable FROM legal_answers ORDER BY a_id"  # "ORDER BY" makes the answers come out in the same order in which they went in; so are displayed in the results in a controllable order
        try:
            dBres=dBUtils.getData(sql,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='list of legal answers information')
        except dBUtils.dBUtilsError, err:
            noteException("Unable to get legal answers information from the database",devel="Unable to get legal answers information from the database for the survey %(survey_id)s: %(err)s",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id,err=err)
        if dBres is None:
            noteException("Unable to find legal answers information in the database",devel="Unable to find legal answers information in the database for the survey %(survey_id)s: query results empty",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id)
        legalAnswersDct={}
        for (q_type,answer,analyzable) in dBres:
            if legalAnswersDct.has_key(q_type):
                legalAnswersDct[q_type].append((answer,analyzable))
            else:
                legalAnswersDct[q_type]=[(answer,analyzable)]
        # get the question information
        sql="SELECT number,preamble,q_type,body,comment FROM questions WHERE survey_id=%(survey_id)s"
        dct={'survey_id':survey_id}
        try:
            dBres=dBUtils.getData(sql,dct=dct,dBcsr=dBcsr,log=log,debug=DEBUG,listtype='list of questions information')
        except dBUtils.dBUtilsError, err:
            noteException("Unable to get question type information from the database",devel="Unable to get question type information from the database for the survey %(survey_id)s: %(err)s",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id,err=err)
        if dBres is None:
            noteException("Unable to find questions information in the database",devel="Unable to find questions information in the database for the survey %(survey_id)s, result of query is empty",log=log,exception=surveyError,debug=DEBUG,survey_id=survey_id)
        self.questions=[] # make a list of dictionaries
        for q_no in range(self.no_qs):
            self.questions.append({})
        for (number,preamble,q_type,body,comment) in dBres:
            self.questions[number-1]['type']=q_type
            self.questions[number-1]['description']=qTypeDct[q_type][0]
            self.questions[number-1]['multiple']=qTypeDct[q_type][1]
            self.questions[number-1]['quantitative']=qTypeDct[q_type][2]
            self.questions[number-1]['bar_chart']=qTypeDct[q_type][3]
            self.questions[number-1]['html']=qTypeDct[q_type][4]
            self.questions[number-1]['preamble']=preamble
            self.questions[number-1]['body']=body
            self.questions[number-1]['comment']=comment
            if legalAnswersDct.has_key(q_type):
                self.questions[number-1]['legal_answers']=legalAnswersDct[q_type]
            else:
                self.questions[number-1]['legal_answers']=None

    def _administrivia(self,prefix=''):
        """Return the administrive information for the survey.
"""
        r=["%sID: %s  Title: %s\n" % (prefix,self.id,self.title)]
        r.append("%sContact: Name %s  Email: %s\n" % (prefix,self.getContactName(),self.getContactEmail()))
        r.append("%sNumber of questions: %s  Anonymous? %s  Approved? %s\n" % (prefix,self.getNumberQuestions(),self.getAnonymous(),self.getApproved()))
        r.append("%sOpening: Date: %s  Mail sent? %s  Mail:\n%s\n" % (prefix,self.getDateOpen(),self.getMail1Sent(),self.getMail1()))
        if self.getDateMail2():
            r.append("%sFirst email prompt: Date: %s  Sent? %s  Mail:\n%s\n" % (prefix,self.getDateMail2(),self.getMail2Sent(),self.getMail2()))
        else:
            r.append("%sFirst email prompt not scheduled\n" % (prefix,))
        if self.getDateMail3():
            r.append("%sSecond email prompt: Date: %s  Sent? %s  Mail:\n%s\n" % (prefix,self.getDateMail3(),self.getMail3Sent(),self.getMail3()))
        else:
            r.append("%sSecond email prompt not scheduled\n" % (prefix,))
        r.append("%sClosing date: %s" % (prefix,self.getDateClosed(),))
        return "".join(r)

    def __str__(self):
        # First the administrivia
        r=[self._administrivia()+"\n"]
        # Second the questions
        for q_no in range(1,self.no_qs+1):
            r.append("Question: %s\n" % (q_no,))
            r.append("  Body: %s\n" % (self.getQuestionBody(q_no),))
            r.append("  Type: %s  Multiple answers allowed? %s\n" % (self.getQuestionType(q_no),self.getQuestionMultiple(q_no)))
            r.append("  Quantitative? %s  Comments allowed? %s\n" % (self.getQuestionQuantitative(q_no),self.getQuestionComment(q_no)))
            r.append("  (HTML not shown)\n")
            if self.questions[q_no-1]['legal_answers'] is None:
                la="All answers are legal"
            else:
                la=", ".join(self.questions[q_no-1]['legal_answers'])
            r.append("  Legal answers: %s\n" % (la,))
        return "".join(r)

    def show(self):
        """Return the HTML that describes the survey
        """
        r=[]
        r.append("<table class='info_summary'>\n")
        r.append("<tr><th>Attribute</th> <th>Value</th></tr>\n")
        r.append("<tr class='evenrow'><td class='info_description'>Title</td> <td class='info'>%s</td> </tr>\n" % (cgi.escape(self.getTitle()),))
        r.append("<tr class='oddrow'><td class='info_description'>Contact</td> <td class='info'>%s</td> </tr>\n" % ("<a href='mailto:%s'>%s</a>" % (cgi.escape(self.getContactEmail()),cgi.escape(self.getContactName())),))
        r.append("<tr class='oddrow'><td class='info_description'>Number of questions</td> <td class='info'>%s</td> </tr>\n" % (self.getNumberQuestions(),))
        r.append("<tr class='evenrow'><td class='info_description'>Emails sent for each subject?</td> <td class='info'>%s</td> </tr>\n" % (self.getEmail(),))
        r.append("<tr class='oddrow'><td class='info_description'>Anonymous subjects?</td> <td class='info'>%s</td> </tr>\n" % (self.getAnonymous(),))
        r.append("<tr class='evenrow'><td class='info_description'>Approved?</td> <td class='info'>%s</td> </tr>\n" % (self.getApproved(),))
        r.append("<tr class='oddrow'><td class='info_description'>Answer format</td> <td class='info'>%s</td> </tr>\n" % (cgi.escape(self.getAnswerFormat()),))
        r.append("<tr class='evenrow'><td class='info_description'>No subject ID (i.e., goofy)?</td> <td class='info'>%s</td> </tr>\n" % (self.getNoSubjID(),))
        r.append("<tr class='evenrow'><td class='info_description'>Date open</td> <td class='info'>%s</td> </tr>\n" % (cgi.escape(self.getDateOpen().date),))
        r.append("<tr class='oddrow'><td class='info_description'>Opening email</td> <td class='info'>%s</td> </tr>\n" % ("<textarea rows='%s' cols='%s'>%s</textarea>" % (defaults.EMAIL_ENTRY_ROWS,defaults.EMAIL_ENTRY_COLS,cgi.escape(self.getMail1()),),))
        r.append("<tr class='evenrow'><td class='info_description'>Opening email sent?</td> <td class='info'>%s</td> </tr>\n" % (self.getMail1Sent(),))
        if self.getMail2():
            r.append("<tr class='oddrow'><td colspan='2'>First prompting email</td></tr>\n")
            r.append("<tr class='evenrow'><td class='info_description'>Date of first prompting email</td> <td class='info'>%s</td> </tr>\n" % (cgi.escape(self.getDateMail2().date),))
            r.append("<tr class='oddrow'><td class='info_description'>First prompting email</td> <td class='info'>%s</td> </tr>\n" % ("<textarea rows='%s' cols='%s'>%s</textarea>" % (defaults.EMAIL_ENTRY_ROWS,defaults.EMAIL_ENTRY_COLS,cgi.escape(self.getMail2()),),))
            r.append("<tr class='evenrow'><td class='info_description'>First prompting email sent?</td> <td class='info'>%s</td> </tr>\n" % (self.getMail2Sent(),))
        if self.getMail3():
            r.append("<tr class='oddrow'><td colspan='2'>Second prompting email</td></tr>\n")
            r.append("<tr class='evenrow'><td class='info_description'>Date of second prompting email</td> <td class='info'>%s</td> </tr>\n" % (self.getDateMail3().date,))
            r.append("<tr class='oddrow'><td class='info_description'>Second prompting email</td> <td class='info'>%s</td> </tr>\n" % ("<textarea rows='%s' cols='%s'>%s</textarea>" % (defaults.EMAIL_ENTRY_ROWS,defaults.EMAIL_ENTRY_COLS,cgi.escape(self.getMail3()),),))
            r.append("<tr class='evenrow'><td class='info_description'>Second prompting email sent?</td> <td class='info'>%s</td> </tr>\n" % (self.getMail3Sent(),))
        r.append("<tr class='oddrow'><td class='info_description'>Date survey closes</td> <td class='info'>%s</td> </tr>\n" % (cgi.escape(self.getDateClosed().date),))
        r.append("</table>\n")
        r.append("<h4>Survey contents</h4>\n")
        r.append("<div id='survey'>\n") # show off the survey as different
        r.append(self.getHTML())
        r.append("</div>\n")
        return "".join(r)

    def getID(self):
        return self.id
    def getTitle(self):
        return self.title
    def getContactName(self):
        return self.contact_name
    def getContactEmail(self):
        return self.contact_email
    def getPassword(self):
        return self.password
    def getIntro(self):
        return self.intro
    def getNumberQuestions(self):
        return self.no_qs
    def getEmail(self):
        return bool(self.email)
    def getAnonymous(self):
        return bool(self.anonymous)
    def getAnswerFormat(self):
        return self.answer_format
    def getNoSubjID(self):
        return bool(self.no_subj_id)
    def getApproved(self):
        return bool(self.approved)
    def getPrefix(self):
        return self.prefix
    def getPostfix(self):
        return self.postfix
    def getHTML(self,action=None,id=None):
        """Get the HTML representation of the page
          action=None  If not None, include the <form action=.. </form> elets
          id=None  If not None, include a <input type='hidden' name='id' ../>
            element
        """ 
        r=[]
        if self.getPostfix():
            r.append(cgiUtils.page_top(None))
            if self.getPrefix():
                r.append(self.getPrefix())
            if not(action is None):
                r.append("<form action='%s' method='POST'>\n" % (action,))
            if not(id is None):
                r.append("<input type='hidden' name='id' value='%s' />\n" % (id,))
            r.append(self.getPostfix())
            if not(action is None):
                r.append("</form>\n")
        else:
            r.append("<p><i>Sorry; the questions have not yet been entered for this survey.</i></p>\n")
        return "".join(r)
    def getDateOpen(self):
        return self.date_open
    def getMail1(self):
        return self.mail1
    def getMail1Sent(self):
        return bool(self.mail1sent)
    def getDateMail2(self):
        return self.date_mail2
    def getMail2(self):
        return self.mail2
    def getMail2Sent(self):
        return bool(self.mail2sent)
    def getDateMail3(self):
        return self.date_mail3
    def getMail3(self):
        return self.mail3
    def getMail3Sent(self):
        return bool(self.mail3sent)
    def getDateClosed(self):
        return self.date_closed

    def getQuestion(self,q_no):
        """Return a dictionary with keys 'body', 'type', 'comment' (are
        comments allowed?) and 'legal_answers'.
          q_no  The question number; in range from 1 to self.no_qs
        May raise a surveyError.
        """
        if (q_no<1
            or q_no>self.no_qs):
            raise surveyError, "getQuestion: question number out of bounds"
        return self.questions[q_no-1]

    def getQuestionType(self,q_no):
        return self.getQuestion(q_no)['type']
    def getQuestionDescription(self,q_no):
        return self.getQuestion(q_no)['description']
    def getQuestionMultiple(self,q_no):
        return bool(self.getQuestion(q_no)['multiple'])
    def getQuestionQuantitative(self,q_no):
        return bool(self.getQuestion(q_no)['quantitative'])
    def getQuestionBarChart(self,q_no):
        return self.getQuestion(q_no)['bar_chart']
    def getQuestionHTML(self,q_no):
        return self.getQuestion(q_no)['html']
    def getQuestionPreamble(self,q_no):
        return self.getQuestion(q_no)['preamble']
    def getQuestionBody(self,q_no):
        d=self.getQuestion(q_no) # may raise surveyError
        if d.has_key('body'):
            return d['body']
        else:
            raise surveyError, "getQuestionBody: no body for question %s" % (q_no,)
    def getQuestionComment(self,q_no):
        d=self.getQuestion(q_no) # may raise surveyError
        if d.has_key('comment'):
            return bool(d['comment'])
        else:
            raise surveyError, "getQuestionComment: no comment for question %s" % (q_no,)
    def getQuestionLegalAnswers(self,q_no):
        """If it is None, then all answers are legal; otherwise a list"""
        d=self.getQuestion(q_no) # may raise surveyError
        if d.has_key('legal_answers'):
            if d['legal_answers'] is None:
                return None  # flag that any answer is legal
            else:
                lst=[]
                for (answer,analyzable) in d['legal_answers']:
                    lst.append(answer)
                return lst
        else:
            raise surveyError, "getQuestionLegalAnswers: no legal answers for question %s" % (q_no,)
    def getQuestionAnswersAnalyzable(self,q_no):
        """Return a list of the analyzable legal answers (e.g., if a question
        has rate 1-5 and "no opinion" coded as 1, 2, .. 5 and 0 then you don't
        want the 0's counted as part of the std dev)"""
        d=self.getQuestion(q_no) # may raise surveyError
        lst=[]
        if d.has_key('legal_answers'):
            if d['legal_answers'] is None:
                return None   # any answer is legal
            for (answer,analyzable) in d['legal_answers']:
                lst.append(answer)
            return lst
        else:
            raise surveyError, "getQuestionLegalAnswers: no legal answers for question %s" % (q_no,)
    def questionsEntered(self):
        for q_no in range(self.getNumberQuestions()):
            try:
                if not(self.questions[q_no]): # get {} there?
                   return False
            except: # index exists?
                return False
        return True
    def getTextFileLineFormat(self):
        """Build a format for python to do % substitution
        """
        r=["%(subject_id)s"]
        for q_no in range(1,self.getNumberQuestions()+1):
            # the 03d allows up to 999 questions
            if self.getQuestionQuantitative(q_no):
                r.append("%%(answer%03d)s" % (q_no,))
            else:
                r.append("%%(answer%03d)s" % (q_no,)) # quote strings
            if self.getQuestionComment(q_no):
                r.append("%%(comment%03d)s" % (q_no,))
        return ", ".join(r)

                  
#------------------------------------------------------------------
if __name__=='__main__':
    import dBUtils
    (dBcnx,dBcsr)=dBUtils.opendB()
    s=survey(1,dBcsr)
    print s

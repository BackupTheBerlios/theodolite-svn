# defaults.py

# Default values for the Theo system
#  When you install Theo, copy defaults_model.py to defaults.py and edit
# the entries to suit.  Because defaults.py is not in the svn tree, it
# will not be replaced when you update.
import sys, os, os.path

# Default values for the Theo system
THIS_MACHINE='localhost'
MAINTAINER="ftpmaint@%s" % (THIS_MACHINE,)
SCHEME='http'
CGI_PATH='cgi-bin/theo'
BASE_CGI_URL="%s://%s/%s" % (SCHEME,THIS_MACHINE,CGI_PATH)
ADMIN_URL="%s/admin.py" % (BASE_CGI_URL,)
APPROVE_URL="%s/approve.py" % (BASE_CGI_URL,)
SURVEY_URL="%s/survey.py" % (BASE_CGI_URL,)
RESULTS_URL="%s/results.py" % (BASE_CGI_URL,)
HTML_PATH='theo'
BASE_HTML_URL="%s://%s/%s" % (SCHEME,THIS_MACHINE,HTML_PATH)
GRAPHIC_URL='/'+HTML_PATH  # where the .png lives; set this in index.html also
HOME_URL="%s/index.html" % (BASE_HTML_URL,)

# web demon name and password
WEB_DEMON_NAME='apache' # name used by the web demon to access the dB
WEB_DEMON_PASSWORD=''  # password used to access the dB

# used to generate unique ids from the survey id and the user's id 
SEPARATOR='W2f)kkk78l'  # put in some random characters

# used for the emails that are sent to subjects: every place this string
# appears is replaced by a URL pointing to the right survey.
LINK_STRING='LINK HERE'

# Most questions allowed in a single survey
MAX_NUM_QUESTIONS=50

# The question type pre-chosen and shown to the user.
DEFAULT_QUESTION_TYPE='comment' # make sure it is in the dB

# To always have subject information taken from the same file (not uploaded),
# make this be the name of that file.  Otherwise, make it be None
SUBJECT_FILE=None

# Between emails we pause to avoid overflowing the mail buffer (in secs)
PAUSE_BETWEEN_EMAILS=1.0

# Size of email entry spaces
EMAIL_ENTRY_ROWS=20
EMAIL_ENTRY_COLS=72

# Unicode stuff
HTML_CODEC='UTF-8'
DATABASE_CODEC='UTF-8'

import os
user=os.getenv('USER')
#print "defaults.py: user is %s" % (repr(user),)
if user=='ftpmaint':  # your name when you are installing
    DBCONNECTION_STRING="user=ftpmaint dbname=theo password="
else:  # e.g., running as the apache user
    DBCONNECTION_STRING="user=%s dbname=theo password=" % (WEB_DEMON_NAME,)

# Log lots of stuff; turn off for production use
LOGGING=True
# Give lots of extra info; turn off for production use
DEBUG=False

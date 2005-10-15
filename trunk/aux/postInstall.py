#!/usr/bin/python2.3 -u
# postInstall.py
#  Run this script after the initial install, or after any update.
#  After you install first create a default file:
#   cd ../bin
#   cp defaults_model.py defaults.py
#   emacs defaults.py
#  After install or update, run this script to set constants to your local
# preferences.
#
#  2005-Oct-11 Jim Hefferon
import sys, os, os.path, re
import glob

sys.path.append('../bin')
import util
import defaults

VERBOSE=True  # talk a lot?

# replace the web demon name in the .sql files
sqlDir=os.path.normpath(os.path.join(os.getcwd(),'../sql'))
sqlFiles=glob.glob(sqlDir+'/*.sql')
if VERBOSE:
    print "sql file list is %s" % ("\n  ".join(sqlFiles),)

GRANT_rePattern="(GRANT .* TO )(\S)+(;.*)"
GRANT_re=re.compile(GRANT_rePattern)
for fn in sqlFiles:
    fileLines=[]
    changedLines=[]
    numberChangedLines=0
    try:
        f=open(fn,'r')
        fileLines=f.readlines()
        f.close()
    except Exception, err:
        util.fail('Unable to change the name of the web demon in the SQL file %(fn)s; unable to read: %(err)s',fn=fn,err=err)
    for line in fileLines:
        m=GRANT_re.match(line)
        if m:
            line=m.group(1)+'"'+defaults.WEB_DEMON_NAME+'"'+m.group(3)+"\n" # double quotes to guard against funny chars in name of web demon, such as www-demon's - 
            numberChangedLines+=1
        changedLines.append(line)
    try:
        f=open(fn,'w')
        f.writelines(changedLines)
        f.close()
    except Exception, err:
        util.fail('Unable to change the name of the web demon in the SQL file %(fn)s; unable to write: %(err)s',fn=fn,err=err)
    if VERBOSE:
        print "sql file %s written out with %d changed lines" % (fn,numberChangedLines)

if VERBOSE:
    print "done all changes"

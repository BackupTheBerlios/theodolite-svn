#!/usr/bin/python2.3 -u
# setWebDemonName.py
#  Change the name of the web demon to 'www-data' or 'apache' or whatever.
# 2005-Oct-11 Jim Hefferon
import sys, os, os.path, re
import glob

sys.path.append('../bin')
import util

configFileName='webDemonName.cfg' # contains three lines; the second has only
                                  # the name of the web demon in it (note that
                                  # the - in www-data requires that the config
                                  # say "www-data" with double quotes), the
                                  # third has the password the demon uses to
                                  # access the dB (so it may be empty; just a
                                  # \n)

VERBOSE=True  # ? talk a lot?

# get the name of the web demon
try:
    f=open(configFileName,'r')
    f.readline()  # throw away the comment line
    name=f.readline().strip()
    pswd=f.readline().strip()
    f.close()
except Exception, err:
    util.fail('Unable to read the name of the web demon from the file %(configFileName)s: %(err)s',configFileName=configFileName,err=err)
if VERBOSE:
    print "web demon name is '%s' and password is '%s'" % (name,pswd)

# replace it in the relevant files

# defaults.py
defaultsFn=os.path.normpath(os.path.join(os.getcwd(),'../bin/defaults.py'))
defaultsLines=[]
try:
    f=open(defaultsFn,'r')
    defaultLines=f.readlines()
    f.close()
except Exception, err:
    util.fail('Unable to read the file %(defaultsFn)s: %(err)s',defaultsFn=defaultsFn,err=err)
if VERBOSE:
    print "defaults file %s read" % (defaultsFn,)

DBCONNECTION_STRING_rePattern="(\s*DBCONNECTION_STRING='user=)(\S)+( dbname=theo password=)([^\"]*)(' # demon user)"
DBCONNECTION_STRING_re=re.compile(DBCONNECTION_STRING_rePattern)
changedDefaultLines=[]
numberChangedLines=0
for line in defaultLines:
    m=DBCONNECTION_STRING_re.match(line)
    if m:
        print "defaults.py match"
        line=m.group(1)+name+m.group(3)+pswd+m.group(5)
        numberChangedLines+=1
    changedDefaultLines.append(line)
try:
    f=open(defaultsFn,'w')
    f.writelines(changedDefaultLines)
    f.close()
except Exception, err:
    util.fail('Unable to write the name of the web demon to the file %(defaultsFn)s: %(err)s',defaultsFn=defaultsFn,err=err)
if VERBOSE:
    print "  changed version written out with %d changed lines" % (numberChangedLines,)

# the .sql files
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
            line=m.group(1)+name+m.group(3)+"\n"
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

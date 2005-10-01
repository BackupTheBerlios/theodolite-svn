#!/usr/bin/python2.3 -u
"""Tests the util.py utilities"""
import unittest

import util
from util import *

import os, sys, time, re
import logging

LOGFILE='/tmp/util_test.log'

class utilTestError(StandardError):
    pass

def lastLine(fn):
    """Return the last line of a file
      fn  File name
    """
    f=open(fn,'r')
    lines=f.readlines()
    #for line in lines:
    #    print "next line is: ",line.rstrip()
    return lines[-1].rstrip()


class msg_test(unittest.TestCase):
    """Test the msg function"""
    log=None
    
    def setUp(self):
        """Make log files to work with"""
        #print "Starting setUp"
        self.log=openLog(LOGFILE,name='test',purpose='util_test.py',format="%(levelname)s\t%(asctime)s\t%(message)s")  # format allows me to split on the tab
        #print "Ending setUp"

    def tearDown(self):
        """Remove directories made in setUp"""
        #print "Starting tearDown"
        try:
            #self.log.handlers[0].close()
            #f=open(LOGFILE,'r')
            #print "Log file reads"
            #for line in f.readlines():
            #    print "  "+line,
            #print "end log file"
            #f.close()
            os.remove(LOGFILE)
        except OSError, err:
            raise utilTestError,"utilTestError: cannot teardown err=%s" % (err,)
        #print "Ending tearDown"

    def test_basicCase(self):
        s='Howdy'
        m=msg(s,log=self.log)
        self.failUnlessEqual(m,
                             s)
        m=msg(s,log=self.log,logLevel='info')
        self.failUnlessEqual(m,
                             s)

    def test_logLevel(self):
        s='Should be INFO'
        m=msg(s,log=self.log,logLevel='info')
        self.failUnlessEqual(s,
                             lastLine(LOGFILE).split("\t")[2])
        self.failUnlessEqual('INFO',
                             lastLine(LOGFILE).split("\t")[0])
        s='Should be CRITICAL'
        m=msg(s,log=self.log,logLevel=logging.CRITICAL)
        self.failUnlessEqual(s,
                             lastLine(LOGFILE).split("\t")[2])
        self.failUnlessEqual('CRITICAL',
                             lastLine(LOGFILE).split("\t")[0])
        
    def test_substitution(self):
        # does the resulting message get the substitution?
        s='Howdy %(id)s'
        m=msg(s,log=self.log,id='Jim')
        self.failUnlessEqual(m,
                             s %  {'id':'Jim'})
        # test that substitution is done in the log
        m=msg(s,log=self.log,id='Jim')
        self.failUnlessEqual(s %  {'id':'Jim'},
                             lastLine(LOGFILE).split("\t")[2])
        s='Howdy %(id)s'
        d='Good %(daytime)s'
        # with debug=False, get user message only
        m=msg(s,devel=d,log=self.log,id='Jim',daytime='morning')
        self.failUnlessEqual(s % {'id':'Jim', 'daytime':'morning'},
                             m)
        self.failUnlessEqual(d % {'id':'Jim', 'daytime':'morning'},
                             lastLine(LOGFILE).split("\t")[2])
        # with debug=True, get full developer message
        m=msg(s,devel=d,log=self.log,debug=True,id='Jim',daytime='morning')
        self.failUnlessEqual(d % {'id':'Jim', 'daytime':'morning'},
                             m)
        self.failUnlessEqual(d % {'id':'Jim', 'daytime':'morning'},
                             lastLine(LOGFILE).split("\t")[2])
        

    def test_traceback(self):
        s='Howdy %(id)s'
        d='Good %(daytime)s'
        # with debug=True, get full developer message
        try:
            x=7.0/0.0
        except:
            m=msg(s,devel=d,log=self.log,debug=True,id='Jim',daytime='morning')
            self.failUnlessEqual(d % {'id':'Jim', 'daytime':'morning'},
                                 m)



class noteException_test(unittest.TestCase):
    """Test the noteException function"""
    log=None
    
    def setUp(self):
        """Make log files to work with"""
        #print "Starting setUp"
        self.log=openLog(LOGFILE,name='test',purpose='util_test.py',format="%(levelname)s\t%(asctime)s\t%(message)s")  # format allows me to split on the tab
        #print "Ending setUp"

    def tearDown(self):
        """Remove directories made in setUp"""
        #print "Starting tearDown"
        try:
            #f=open(LOGFILE,'r')
            #print "Log file reads"
            #for line in f.readlines():
            #    print "  "+line,
            #print "end log file"
            #f.close()
            os.remove(LOGFILE)
        except OSError, err:
            raise utilTestError,"utilTestError: cannot teardown err=%s" % (err,)
        #print "Ending tearDown"

    def test_basicCase(self):
        s='Howdy'
        self.failUnlessRaises(util.DEFAULT_EXCEPTION,noteException,s,log=self.log,debug=False)
        # raise an exception, make a substitution for log file
        s='Howdy %(id)s'
        d='Good %(daytime)s'
        self.failUnlessRaises(util.DEFAULT_EXCEPTION,noteException,s,devel=d,log=self.log,debug=False,id='Jim',daytime='morning')
        self.failUnlessEqual(d %  {'id':'Jim', 'daytime':'morning'},
                             lastLine(LOGFILE).split("\t")[2])



# ---------------------------------------------------------------
if __name__=='__main__':
    if os.path.exists(LOGFILE):
        print "  NOTE: You will get an error; rm -Rf %s first" % (LOGFILE,)
    unittest.main()

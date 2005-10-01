#!/usr/bin/python2.3 -u
"""Tests the dBUtils.py utilities"""
import unittest

import dBUtils
from dBUtils import *
import psycopg

import os, sys, time, re
import logging
from util import *

LOGFILE='/tmp/dBUtils_test.log'

class dBUtilsTestError(StandardError):
    pass

user=os.getenv('USER')
print "user is %s" % (repr(user),)
test_dB='test_dBUtils'
not_test_dB='test_dBUtils'+'_xxx'
password='' # doesn't work; leave blank
dBconnection_string="user=%s dbname=%s password=%s" % (user,test_dB,password)

class opendB_test(unittest.TestCase):
    """Test the opendB function"""
    log=None
    
    def setUp(self):
        """Make the database to work with"""
        print "Starting setUp"
        try:
            rc=os.system("createdb -EUTF-8 %s" % (test_dB,))
        except Exception, err:
            print "Failed to create database: %s" % (err,)
            sys.exit(1)
        if rc<>0:
            print "Nonzero return code while creating database: %s" % (rc,)
            sys.exit(1)
        print "Ending setUp"

    def tearDown(self):
        """Drop the database made in setUp"""
        print "Starting tearDown"
        try:
            rc=os.system("dropdb %s" % (test_dB,))
        except Exception, err:
            print "Failed to drop database: %s" % (err,)
            sys.exit(1)
        if rc<>0:
            print "Nonzero return code while dropping database: %s" % (rc,)
            sys.exit(1)
        print "Ending tearDown"

    def test_basicCase(self):
        (dBcnx,dBcsr)=opendB(connectionstring=dBconnection_string)
        self.failUnless(dBcnx)
        self.failUnless(dBcsr)

    def test_failure(self):
        # try to connect to a non-existent dB
        c_str="user=%s dbname=%s password=%s" % (user,not_test_dB,password)
        self.failUnlessRaises(dBUtilsError,
                              opendB,connectionstring=c_str)



class getList_test(unittest.TestCase):
    """Test the getList function"""
    log=None
    
    def setUp(self):
        """Make the database to work with"""
        print "Starting setUp"
        try:
            rc=os.system("createdb -EUTF-8 %s" % (test_dB,))
        except Exception, err:
            print "Failed to create database: %s" % (err,)
            sys.exit(2)
        if rc<>0:
            print "Nonzero return code while creating database: %s" % (rc,)
            sys.exit(2)
        try:
            (dBcnx,dBcsr)=opendB(connectionstring=dBconnection_string)
            dBcsr.execute("CREATE TABLE folks (name TEXT, email TEXT, age INT)")
            dBcsr.execute("INSERT INTO folks (name,email,age) VALUES ('Jim','jim@myhome.org',32)")
            dBcsr.execute("INSERT INTO folks (name,email,age) VALUES ('Mike Schr\xc3\xb6der','mike@myhome.org',62)")
            dBcnx.commit()
        except psycopg.DatabaseError,err:
            print "Failed to stock the dB: %s" % (err,)
            sys.exit(2)
        print "Ending setUp"

    def tearDown(self):
        """Drop the database made in setUp"""
        print "Starting tearDown"
        try:
            rc=os.system("dropdb %s" % (test_dB,))
        except Exception, err:
            print "Failed to create database: %s" % (err,)
            sys.exit(1)
        if rc<>0:
            print "Nonzero return code while creating database: %s" % (rc,)
            sys.exit(1)
        print "Ending tearDown"

    def test_basicCase(self):
        (dBcnx,dBcsr)=opendB(connectionstring=dBconnection_string)
        lst=getList("SELECT name,email,age FROM folks",dBcsr=dBcsr)
        self.failUnlessEqual(lst[1][0],
                             'Mike Schr\xc3\xb6der'.decode('UTF-8'))
        print "This should give a non-ascii name: ",lst[1][0]
        lst=getList("SELECT email FROM folks WHERE name=%(name)s",dct={'name':'Mike Schr\xc3\xb6der'.decode('UTF-8')},dBcsr=dBcsr)
        self.failUnlessEqual(lst[0][0],
                             'mike@myhome.org')


# ---------------------------------------------------------------
if __name__=='__main__':
    print "  NOTE: if the dB exists, try dropdb %s first" % (test_dB,)
    unittest.main()

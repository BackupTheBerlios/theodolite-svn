# dBUtils.py
#  Utilities pertaining to the database
import types
import psycopg

from types import * # !!! temp only

from util import * 
from defaults import DBCONNECTION_STRING, DATABASE_CODEC, DEBUG

dBConnectionString=DBCONNECTION_STRING

class dBUtilsError(StandardError):
    pass


def opendB(connectionstring=dBConnectionString,log=None,debug=DEBUG,serialize=0):
    """
    Make a connection to the database; return the pair (connection, cursor).
      connectionstring  string  See doc for psycopg
      log  logging object
      debug=DEBUG  Whether to output extra information
      serialize=0  Whether to serialize cursors; see the README for psycopg
    May raise a dBUtilsError.
    """
    try:
        dBcnx = psycopg.connect(connectionstring,serialize=serialize)
        dBcsr = dBcnx.cursor()
    except psycopg.DatabaseError, err:
        noteException('Unable to connect to the database',devel="Unable to connect to the database using connection string %(connectionstring)s: %(err)s",log=log,exception=dBUtilsError,debug=debug,connectionstring=connectionstring,err=err)
    return (dBcnx,dBcsr)


def getData(sql,dct={},dBcsr=None,selectOne=False,log=None,encoding=DATABASE_CODEC,debug=DEBUG,listtype='list from the database'):
    """
    Get data out of the database, returning a list of lists
      sql  SQL statement; typically a SELECT statement
      dct={}  Dictionary of substitutions into SQL statement (unicode strings
        are encoded according to the encoding)
      dBcsr=None  database cursor. If None, one will be generated
      log=None  Instance of logging object
      selectOne=False  With a dB result, issue a fetchone() or a fetchall()?
      encoding=DATABASE_CODEC  Unicode encoding to use for the
        database
      debug=DEBUG  Whether to include debugging information
      listtype  Phrase for use in error messages
    Note that unicode strings will be encoded on the way in, and decoded back
    to Python unicode on the way out.
    """
    if not(dBcsr):
        try:
            (dBcnx,dBcsr)=opendB()
        except dBUtilsError, err:
            noteException("Error getting access to the database",devel="Error getting access to the database: %(err)s, while getting a %(listtype)s",log=log,exception=dBUtilsError,debug=debug,err=err,listtype=listtype)
    # encode unicode strings that come in as data
    for (k,v) in dct.items():
        if type(v)==type(u''):
            dct[k]=v.encode(encoding)
    try:
        dBcsr.execute(sql,dct)
        if selectOne:
            dBres=dBcsr.fetchone()
            if dBres is None:
                lst=[]
            else:
                lst=[dBres]   # make it a list of lists, like the else
        else:
            lst=dBcsr.fetchall()
    except psycopg.DatabaseError, err:
        noteException("Database operation error, fetching a %(listtype)s",devel="Database error fetching a %(listtype)s with sql='%(sql)s' and dct=%(dct)s: %(err)s",log=log,exception=dBUtilsError,debug=debug,listtype=listtype,sql=sql,dct=repr(dct),err=err)
    # Take the results and decode them back into Python unicode strings
    newlst=[]
    for i in range(0,len(lst)):
        newitem=[]
        for j in range(0,len(lst[i])):
            if isinstance(lst[i][j],types.StringTypes):
                newitem.append(unicode(lst[i][j],encoding))
            else:
                newitem.append(lst[i][j])
        newlst.append(newitem)
    if (selectOne
        and newlst):
            return newlst[0]  # come back from a list of lists
    else:
        return newlst


def putData(sql,dct={},dBcsr=None,log=None,encoding=DATABASE_CODEC,debug=DEBUG,listtype='list to the database'):
    """
    Put data into the database, encoding unicode strings on their way in
      sql  SQL statement; should be an INSERT or an UPDATE
      dct={}  Dictionary of substitutions into SQL statement (unicode strings
        are encoded according to the encoding)
      dBcsr=None  database cursor. If None, one will be generated
      log=None  Instance of logging object
      encoding=DATABASE_CODEC  Unicode encoding to use for the
        database
      debug=DEBUG  Whether to include debugging information
      listtype  Phrase for use in error messages
    Does *not* do a dBcsr.commit().
    """
    if not(dBcsr):
        try:
            (dBcnx,dBcsr)=opendB()
        except dBUtilsError, err:
            noteException("Error accessing the database",devel="Error opening the database: %(err)s, while putting a %(listtype)s",log=log,exception=dBUtilsError,debug=debug,err=err,listtype=listtype)
    # encode unicode strings that come in as data
    for (k,v) in dct.items():
        if type(v)==type(u''):
            dct[k]=v.encode(encoding)
    try:
        dBcsr.execute(sql,dct)
    except psycopg.DatabaseError, err:
        noteException("Database operation error",devel="Database error %(err)s while putting a %(listtype)s",log=log,exception=dBUtilsError,debug=debug,err=err,listtype=listtype)
    return None

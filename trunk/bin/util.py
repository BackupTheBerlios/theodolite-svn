#!/bin/env python2.3
# util.py
#  Various Python utilities that I find convienent
# 2004-Oct-02 Jim Hefferon jhefferon@smcvt.edu

import sys # for msg
import os  # for openLog
import StringIO # for msg
import traceback # for msg
import logging  # for openLog, msg


class utilError(StandardError):
    pass


# You can use a string to set the level, or a constant from the logging
# module
_logLevels={'debug':logging.DEBUG,
            'info':logging.INFO,
            'warn':logging.WARN,
            'error':logging.ERROR,
            'critical':logging.CRITICAL,
            logging.DEBUG:logging.DEBUG,
            logging.INFO:logging.INFO,
            logging.WARN:logging.WARN,
            logging.WARN:logging.ERROR,
            logging.CRITICAL:logging.CRITICAL}


# openLog  Open a logging instance
def openLog(fn,name=None,purpose=None,format="%(levelname)s\t%(asctime)s: %(message)s",level=logging.DEBUG,announce=False):
    """Open an instance of the logging module
      fn  Name of the file.
      name=None  Name of the logging instance; if None then fn is used
      purpose=None  Name of calling program; if None then no head line on log
        file is written
      format='%(levelname)s %(asctime)s: %(message)s' Format for log file
        entries
      announce=False  Announce in log file that logging has started
    These are available for the format:
    %(name)s            Name of the logger (logging channel)
    %(levelno)s         Numeric logging level for the message (DEBUG, INFO,
                        WARN, ERROR, CRITICAL)
    %(levelname)s       Text logging level for the message ("DEBUG", "INFO",
                        "WARN", "ERROR", "CRITICAL")
    %(pathname)s        Full pathname of the source file where the logging
                        call was issued (if available)
    %(filename)s        Filename portion of pathname
    %(module)s          Module (name portion of filename)
    %(lineno)d          Source line number where the logging call was issued
                        (if available)
    %(created)f         Time when the LogRecord was created (time.time()
                        return value)
    %(asctime)s         Textual time when the LogRecord was created
    %(msecs)d           Millisecond portion of the creation time
    %(relativeCreated)d Time in milliseconds when the LogRecord was created,
                        relative to the time the logging module was loaded
                        (typically at application startup time)
    %(thread)d          Thread ID (if available)
    %(message)s         The result of record.getMessage(), computed just as
                        the record is emitted
    May raise a utilError.
    """
    if not(purpose is None): # write a header on the file, if it is new
        if not(os.path.isfile(fn)):
            try:
                f=open(fn,'w')
                f.write("# log file for %s\n" % (purpose,))
                f.close()
            except IOError, err:
                raise utilError, "Log file %s not present and unable to open and write to a new log file: %s" % (fn,err)
    if name is None:
        log=logging.getLogger(fn)
    else:
        log=logging.getLogger(name)
    logger_formatter=logging.Formatter(format)
    try:
        logger_handler=logging.FileHandler(fn)
    except Exception, err:
        raise utilError, "Unable to associate a log with %s: %s" % (fn,err)
    logger_handler.setFormatter(logger_formatter)
    log.addHandler(logger_handler)
    try:
        log.setLevel(_logLevels[level])
    except:
        raise utilError, "Unable to set level of the log"
    if announce:
        try:
            log.info("Logging started")
        except Exception, err:
            raise utilError, "Unable to initially write to the log with file name %s: %s" % (fn.err)
    return log



# msg  return a message, for debugging, feedback to the user, etc., and
#  optionally log
def msg(m,devel=None,log=None,logLevel='debug',debug=False,**mDct):
    """Return a message.  Options allow it to be logged, or for a special
    debugging flag to be switched to give additional information
      m  The message returned.  Substitutions from the keyword arguments at end
      devel=None  String that will be used if the DEBUG flag is set for
        developer (and used for writing to the log).  If devel=None, then m
        is used.
      log  A logging object
      logLevel='debug'  One of 'debug', 'info', 'warn', 'error', 'critical',
         or logging.DEBUG, .. logging.CRITICAL
      debug=False  Boolean select which message m or mDevel is shown.
      **mDct  Keyword argument that are substituted into m and mDevel
    Note that if an exception is pending then a traceback gets printed to the
    log file.
    """
    # Indicate log level
    try:
        level=_logLevels[logLevel]
    except:
        raise utilError, "Unable to set level of the log to %s" % (repr(logLevel),)
    # The main part
    if not(devel):
        devel_str=m
    else:
        devel_str=devel
    #log.debug("in msg: m=<%s>, devel_str=<%s>" % (m,devel_str))
    if log:
        (excClass,excObj,excTb)=sys.exc_info() # is there a pending exception? 
        if excClass: 
            tbStr=StringIO.StringIO()
            traceback.print_exc(None,tbStr)
            mDct['tB']=tbStr.getvalue().rstrip()
            log.log(level,(devel_str+"\n  %(tB)s") % mDct)
        else:
            log.log(level,devel_str % mDct)
    if debug:
        m=devel_str
    return m % mDct 


DEFAULT_EXCEPTION=utilError
def noteException(m,devel='',log=None,logLevel='error',exception=DEFAULT_EXCEPTION,debug=None,**mDct):
    """
    Raise an exception, and also, optionally, note it in a log file
      m  string  Error message for users; use '%(id)s'-style substitution
      devel  string  String for development; sub as in m. 
      log  Instance of logging module
      exception  An exception
      debug  Print the error to the stderr?
      **mDct  Additional keyword arguments; like 'id=7' will be subbed into
        m, devel
    Uses the msg function; will raise exception.
    """
    r=msg(m,devel=devel,log=log,logLevel=logLevel,debug=debug,**mDct)
    if (debug
        and not(log)):
        print >>sys.stderr, "\n"+r
    raise exception, r

def fail(s,returnCode=1,log=None,debug=False,**mDct):
    """Drop out, reporting a return code, and possibly logging a message
      s  Message to report
      returnCode=1  return code
      log=None  A logging object
      debug=False  Whether to report debugging information
    Warning!  You can't use returnCode, log, or debug as a key
    """
    print >>sys.stderr, "ERROR: ", msg(s,log=log,logLevel='error',debug=debug,**mDct)
    sys.exit(returnCode)

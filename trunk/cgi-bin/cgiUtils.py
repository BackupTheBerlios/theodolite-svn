#!/usr/bin/python2.3
#  cgiutils
# Utilities for CGI functions
import cgi, Cookie
import os, sys
import time, logging
import marshal, base64 # for encode and decode
from types import *  # for showListItems

import library
from defaults import HTML_CODEC, HOME_URL, GRAPHIC_URL, MAINTAINER, DEBUG
import util

from htmllib import HTMLParser
from formatter import AbstractFormatter, DumbWriter

from xml.sax.saxutils import quoteattr

class cgiUtilsException(Exception):
    pass


def xhtml_content_type(HTTP_ACCEPT=None,cookie=None):
    """Return the appropriate Content-type
      For XHTML 1.0, you may use text/html if you follow the compatibility
      guidelines, otherwise you must use application/xhtml+xml
      For 1.1 you should use application/xhtml+xml

      But .. IE doesn't hew to the standards, so we get the parameter from
      the environment
        HTTP_ACCEPT=None  Force getting the result from the environment
          (by using None) or XHTML (with True) or HTML (with False).
        cookie=None  An instance of the Cookie object, or None
    """
    r=[]
    xhtml="Content-type: application/xhtml+xml"
    html="Content-type: text/html"
    if HTTP_ACCEPT is None:  # figure it out from the environ
        accepts=os.getenv('HTTP_ACCEPT','')
        if accepts.find('application/xhtml+xml') > -1:
            r.append(xhtml)
        else:
            r.append(html)
    else:
        if HTTP_ACCEPT:
            r.append(xhtml)
        else:
            r.append(html)
    if not(cookie is None):
        r.append(cookie.output())
    r.append("\n")
    return "\n".join(r)


def xhtml_head():
    """The XML head that starts all the XHTML pages
    """
    return """<?xml version='1.0' encoding=%s?>
<!DOCTYPE html
    PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
    ' http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd '>
<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'>
""" % (quoteattr(HTML_CODEC),)


def page_head(title,meta=None):
    """The HTML or XHTML <head> part
      title The title that will show in the browser's bar
      meta=None  Meta tag string
    """
    # ?should say: <meta http-equiv='Content-Type' contents='text/hmtl; charset=UTF-8' />
    return """<head>
  <title>CTAN: %s</title>
  <link rel='stylesheet' type='text/css'
      href='/css/theo.css'
      title='Theodolite style' />
      <meta http-equiv='Content-Type' contents='text/hmtl; charset=UTF-8' />
</head>
""" % (title.encode('latin-1'),) 


def page_start_body():
    """The HTML or XHTML <body> start"""
    return "\n<body>\n"

def page_top(title,logoShown=True):
    """The headline of the page
      title  The page title, at the start of the page body.  If None, no head
         is given
      logoShown=True  Whether to show the logo graphic
    """
    logo="""<div id='logo'><img src='%s/theo.png' alt='Theodolite logo' /></div>
""" % (GRAPHIC_URL,)
    top="""
<div id='top' />
"""
    if not(title is None):
        top+="""
<h2>%s</h2>
"""% (cgi.escape(title),)
    if logoShown:
        return logo+top
    else:
        return top
    
def page_foot(home_link=True, extra=''):
    """
    Make an HTML or XHTML page footer
      home_link=True  Show the link to the home page
      extra=''  Extra test after home link (e.g., date)
    """
    if home_link:
        home="""<span id='footer_home'><a href='%s'>Theodolite: a surveyor's tool</a></span>""" % (HOME_URL,)
    else:
        home=""
    return """
<div id='footer'><hr />
<table class='page_foot' width='100%%'>
  <tr>
    <td class='left'>%s%s</td>
    <td class='right'><span id='footer_author'>Author: Jim Hefferon</span></td>
  </tr>
</table>
</div>
</body></html>
""" % (home,extra)
    
def form_begin(action='',method='POST',enctype='application/x-www-form-urlencoded',charset='UTF-8'):
    """Begin an HTML form element
    """
    return """<form action=%s method=%s enctype=%s accept-charset=%s>
""" % (quoteattr(action),quoteattr(method),quoteattr(enctype),quoteattr(charset))


def form_end():
    """Terminate an HTML form element
    """
    return """</form>
"""


def section(t):
    """Make a section in a page
      t  string.  Text of section head.  (Note, text in t should be
        cgi.escap()-ed for safety; it is not part of the routine because
        you may want to put an anchor, etc., in there.)
    """
    return """<div class='section' />
<h3 class='subhead'>%s</h3>

""" % (t,)


def return_page(r,encoding=HTML_CODEC,log=None):
    """
    Return the contents of r as an HTML or XHTML page
      r Array of Unicode strings that is the page contets
      encoding=HTML_CODEC  Encoding of output page 
    """
    #if log:
    #    for x in r:
    #        if type(x)==type(''):
    #            log.debug("  x is a regular string")
    #            log.debug(" ==> it is "+x)
    #        elif type(x)==type(u''):
    #            log.debug("  x is a unicode string")
    #        else:
    #            log.debug("  x is something else")
    print "".join(r).encode(encoding)


def getfirst(fs,key,default=None,encoding=HTML_CODEC):
    """Return the value of the HTTP parameter, decoded into a Unicode string
      fs  A cgi.fieldStorage structure
      key  the key in the key-val structure
      default=None  value to default to
      encoding=HTML_CODEC  Unicode encoding expected
    """
    val=fs.getfirst(key,default)
    if isinstance(val,basestring): # default might be None, etc.
        val=val.decode(encoding)
    return val


def getlist(fs,key,encoding=HTML_CODEC):
    """Return as a list the value of the HTTP parameter, decoded into a
    list of Unicode strings
      fs  A cgi.fieldStorage structure
      key  the key in the key-val structure
      encoding=HTML_CODEC  Unicode encoding expected
    """
    val=fs.getlist(key)
    return [i.decode(encoding) for i in val]


def errorPage(title,body,optionalInformation='',debug=DEBUG):
    """What to send when something fails
      title  Error title
      body  Unicode string stating that an error has occurred
      optionalInformation=''  Optional information
      debug=DEBUG
    """
    r=[section(title)]
    r.append(body)
    if debug:
        r.append(optionalInformation)
    r.append("<p>Please contact <code>%s</code> about anything that is wrong.</p>" % (cgi.escape(' (at) '.join(MAINTAINER.split('@',1))),))
    return "\n".join(r)


def bail(m,devel=None,top="An error has happened",log=None,debug=DEBUG,returnValue=1,**mDct):
    """Return an error page, clean up, and exit.
      m  Error message.  Use %(id)s along with getOut( ..,id='Jones') to put in
        variables
      devel=None  Error message that is added to m and shown in DEBUG=True
      top='An error has happened'  Main headline for the page.
      log=None  An instance of logging
      DEBUG=False  Boolean saying whether to show devel messages
      returnValue=1  Level of return code
      **mDct  Optional keyword arguments
    Should not raise any exceptions (that's why logLevel is fixed to 'error').
    """
    r=[xhtml_content_type()]
    r.append(xhtml_head())
    r.append(page_head('Error'))
    r.append(page_start_body())
    r.append(page_top(top))
    q=util.msg(m,devel=devel,log=log,logLevel='error',debug=debug,**mDct)
    r.append(errorPage('The problem ..',"<p>%s</p>" % (cgi.escape(q),)))
    r.append(page_foot())
    return_page(r)
    sys.exit(returnValue)


def need_more(s,devel=None,log=None,debug=DEBUG,returnValue=1):
    """Return a page saying that an attribute is required; perhaps the link
    is missing one?
      s  string  Names the attribute
      devel=None  Potential debugging message
      log=None  A logging object
      debug=False  Should log messages?
      returnValue=1  Value returned to the os.
    """
    bail("You have not supplied %(s)s.  You can't proceed without it.  Please use your browser's BACK button and fill it out.",devel=devel,top="You have not supplied a field",log=log,debug=debug,returnValue=returnValue,s=s)


def need_different(s,devel=None,log=None,debug=DEBUG,returnValue=1):
    """Return a page saying that an attribute is nonsensical
      s  string  Names the attribute
      devel=None  Potential debugging message
      log=None  A logging object
      debug=False  Should log messages?
      returnValue=1  Value returned to the os.
    """
    bail("You supplied an unusable value for the attribute %(s)s.  Please use your browser's BACK button and try again.",devel=devel,top="A value that you supplied doesn't make sense",log=log,debug=debug,returnValue=returnValue,s=s)

                                                                               
def escape_apostrophe(s):
    """
    Escape only the single-quote character (for use as an attribute: in
    \"<input name='%s'>\" %(x,) the x cannot have a quote in it.)
    """
    return "&#039;".join(s.split("'"))

def unescape_apostrophe(s):
    """
    Reverse the escaping of the single-quote character.
    """
    return "'".join(s.split("&#039;"))
 

def escape_ampersand(s):
    """
    Escape only the ampersand character (for use as an attribute; in
    particular, as in href='foo.py?go=yes&stay=no')  See the W3C's XHTML
    document on the differences between XHTML 1.0 and HTML4, in section C.12
    """
    return "&amp;".join(s.split("&"))

def unescape_ampersand(s):
    """
    Reverse the escaping of the ampersand character.
    """
    return "'".join(s.split("&amp;"))

def stripHTML(str):
    """
    Remove the HTML tags from a string
    """
    parser=HTMLParser(AbstractFormatter(DumbWriter()))
    return parser.feed(str)


# adaptation of cgi.print_environ() to return a string
def show_environ(environ=os.environ):
    """Dump the shell environment as HTML."""
    keys = environ.keys()
    keys.sort()
    r=[]
    r.append("<h3>Shell Environment</h3>")
    r.append("<dl>")
    for key in keys:
        r.append("<dt>"+cgi.escape(key)+"</dt>\n<dd>"+cgi.escape(environ[key])+"</dd>")
    r.append("</dl>")
    return u"\n".join(r)


class FieldStorage(dict):
    """
    mimic cgi.FieldStorage

      dict  Dictionary

    Used for testing, e.g., unit testing.  Note that these attributes are not
    mimiced: disposition, disposition_options, headers, file, filename, name,
    type, type_options.
    """
    def __init__(self,dict={}):
        self.value=dict

    def __setitem__(self,key,val):
        self.value[key]=val

    def __getitem__(self,key):
        return self.value[key]

    def keys(self):
        return self.value.keys()

    def __str__(self):
        r=['{']
        for key in self.keys():
            r.append("%s:%s," % (key,self.value[key]))
        r.append('}')
        return "".join(r)

    def has_key(self,key):
        return self.value.has_key(key)

    def getvalue(self,key,default=None):
        if self.value.has_key(key):
            return self.value[key]
        else:
            return default

    def getfirst(self,key,default=None):
        if self.value.has_key(key):
            if type(self.value[key]) in [ListType,TupleType]:
                return self.value[key][0]
            else:
                return self.value[key]
        else:
            return default

    def getlist(self,key):
        if self.value.has_key(key):
            if type(self.value[key]) in [ListType,TupleType]:
                return self.value[key]
            else:
                return list(self.value[key])
        else:
            return []

def dumpFieldStorage(fs,HTML=True):
    """Drop all the field, value pairs from fs into a table
      HTML=True  Include the HTML table wrappings?
    """
    r=[]
    if HTML:
        r.append("<table>\n")
    if fs.keys():
        for k in fs.keys():
            if HTML:
                r.append("  <tr><td>%s</td> <td>%s</td></tr>\n" % (cgi.escape(k),cgi.escape(repr(fs.getvalue(k)))))
            else:
                r.append("  %s\t%s\n" % (k,fs.getvalue(k)))
    else:
        if HTML:
            r.append("  <tr><td><i>There are no key, value pairs in fieldStorage</i></td></tr>\n")
        else:
            r.append("  There are no key,value pairs in fieldStorage\n")
    if HTML:
        r.append("</table>\n")
    return "".join(r)


def showListItems(r,HTML=False):
    """
    Describe the parts of a list for cgi debugging.

    Lots of times in cgi programming you gather strings in a list, then do
    "".join(list), which will fail if one of the strings is unicode (and
    so all are coerced to unicode) and one of the chars in the non-unicode
    string has an ord(c)>127 (since the coercion uses the codec ascii by
    default).  This routine looks for that.
    """
    lst=[]
    if HTML:
        lst.append("<table>\n  <tr><th>Type</th> <th>Content</th></tr>")
    for item in r:
        if isinstance(item,StringType):
            flag=0
            for i in range(0,len(item)):
                if flag:
                    break
                if ord(item[i])>127:
                    flag=i
            if flag:
                if HTML:
                    lst.append("<tr><td>String type (Not OK)</td> <td>%s</td></tr>" % (repr(item[0:flag],)+"WARNING: next char ord exceeds 127",))
                else:
                    lst.append("String type (Not OK): %s" % (repr(item[0:flag],)+"WARNING: next char ord exceeds 127",))
            else:
                if HTML:
                    lst.append("<tr><td>String type (OK)</td> <td>%s</td></tr>" % (repr(item),))
                else:
                    lst.append("String type (OK): %s" %  (repr(item),))
        elif isinstance(item,UnicodeType):
            if HTML:
                lst.append("<tr><td>Unicode type</td> <td>%s</td></tr>" % (repr(item),))
            else:
                lst.append("Unicode type: %s" % (repr(item),))
        elif isinstance(item,IntType):
            if HTML:
                lst.append("<tr><td>Integer type</td> <td>%s</td></tr>" % (repr(item),))
            else:
                lst.append("Integer type: %s" % (repr(item),))
        elif isinstance(item,TupleType):
            if HTML:
                lst.append("<tr><td>Tuple type</td> <td>%s</td></tr>" % (repr(item),))
            else:
                lst.append("Tuple type: %s" %  (repr(item),))
        elif isinstance(item,ListType):
            if HTML:
                lst.append("<tr><td>List type</td> <td>%s</td></tr>" % (repr(item),))
            else:
                lst.append("List type: %s" %  (repr(item),))
        else:
            if HTML:
                lst.append("<tr><td>other type</td> <td>%s</td></tr>" % (repr(item),))
            else:
                lst.append("Other type: %s" % (repr(item),))
    if HTML:
        lst.append("</table>")
    return "\n".join(lst)

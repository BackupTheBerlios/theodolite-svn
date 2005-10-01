-- theo_debug.sql
--  A dummy survey, for development and debugging.
-- 2004-Sept-30 Jim Hefferon
INSERT INTO survey (id,title,contact_name,contact_email,password,date,intro,no_qs,email,anonymous,approved,prefix,postfix,date_open,mail1,mail1sent,date_mail2,mail2,mail2sent,date_mail3,mail3,mail3sent,date_closed) VALUES (1,'Sex','Jim Hefferon','jhefferon@smcvt.edu',NULL,'2004-09-30 13:47:42.300174','This is a survey of sexual habits.',3,false,false,true,'','
<p id=''intro''>This is a survey of sexual habits.</p>
<ol>
<p class=''question_preamble''>Preamble: preamble 1</p>
<li /> <span class=''question_body''>Question: question one</span>
<table class="onetoten">
  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>
  <tr><td><input type="radio" name="question1" value="1" checked="checked" /></td> <td><input type="radio" name="question1" value="2" /></td> <td><input type="radio" name="question1" value="3" /></td> <td><input type="radio" name="question1" value="4" /></td> <td><input type="radio" name="question1" value="5" /></td> <td><input type="radio" name="question1" value="6" /></td> <td><input type="radio" name="question1" value="7" /></td> <td><input type="radio" name="question1" value="8" /></td> <td><input type="radio" name="question1" value="9" /></td> <td><input type="radio" name="question1" value="10" /></td> </tr></table><span class=''question_comment''>Comment: <input name=''comment1'' /></span>
<p class=''question_preamble''>Preamble: preamble 2</p>
<li /> <span class=''question_body''>Question: question 2</span>
<table class="satis">
  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td></tr>
  <tr><td><input type="radio" name="question2" value="1" /></td> <td><input type="radio" name="question2" value="2" /></td> <td><input type="radio" name="question2" value="3" checked="checked"/></td> <td><input type="radio" name="question2" value="4" /></td> <td><input type="radio" name="question2" value="5" /></td> </tr></table><li /> <span class=''question_body''>Question: question 3</span>
<input type="text" name="question3" /></ol>
<div class=''section'' />
<h3 class=''subhead''>When you are finished ..</h3>
 
<p>.. hit the button. <input type=''submit'' name=''Done'' value=''Done'' /></p>
<p>Thank you!</p>
','2004-09-19 00:00:00','Please take our survey.  Click on this link: LINK HERE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2004-12-31 00:00:00');
INSERT INTO subjects (survey_id,id,email) VALUES (1,'a2d12588e0a94ea295feda5df2b4d042a8d2bf8c','ftpmaint@localhost');
INSERT INTO subjects (survey_id,id,email) VALUES (1,'745a1dbef94d9c5d8150ae746e9c6e17c6a0268d','ftpmaint@localhost');
INSERT INTO questions (survey_id,number,preamble,q_type,body,comment) VALUES (1,1,'preamble 1','ontotenfivechecked','question 1',true);
INSERT INTO questions (survey_id,number,preamble,q_type,body,comment) VALUES (1,2,'preamble 2','satisneutralchecked','question 2',false);
INSERT INTO questions (survey_id,number,preamble,q_type,body,comment) VALUES (1,3,NULL,'comment','question 3',false);



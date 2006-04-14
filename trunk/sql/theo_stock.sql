-- theo_stock.sql
--  Stock the tables for the Theodolite system
-- 2004-Sept-10


-- People responsible for administering Theo
INSERT INTO admins (name,password,email_name,email_domain) VALUES ('jim','','jim','localhost');
-- INSERT INTO admins (name,password,email_name,email_domain) VALUES ('johnk','','jkulhowvick','smcvt.edu');


-- question types

-- Just a comment -- no radio boxes at all
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('comment','Comment only',TRUE,FALSE,FALSE,'<input type="text" name="%s" size="80" maxlength="240" />');

-- Just a comment -- room for a paragraph
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('paragraphcomment','Comment only, paragraph size',TRUE,FALSE,FALSE,'<textarea name="%s" cols="72" rows="20"></textarea>');


-- True or false
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tftruechecked','True or False, True prechecked',FALSE,FALSE,TRUE,'<table class="tf"><tr><td><input type="radio" name="%s" value="true" checked="checked"/>True</td> <td><input type="radio" name="%s" value="false" />False</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tftruechecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tftruechecked','false',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tffalsechecked','True or False, False prechecked',FALSE,FALSE,TRUE,'<table class="tf"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" checked="checked"/>False</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tffalsechecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tffalsechecked','false',TRUE);


-- True or false or undecided
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfutruechecked','True or False or Undecided, True prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" checked="checked" />True</td> <td><input type="radio" name="%s" value="false" />False</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfutruechecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfutruechecked','false',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfutruechecked','undecided',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfufalsechecked','True or False or Undecided, False prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" checked="checked"/>False</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfufalsechecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfufalsechecked','false',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfufalsechecked','undecided',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfuundecidedchecked','True or False or Undecided, True prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" />False</td> <td><input type="radio" name="%s" value="undecided" checked="checked" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfuundecidedchecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfuundecidedchecked','false',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tfuundecidedchecked','undecided',FALSE);


-- yes or no
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynyeschecked','Yes or No, Yes prechecked',FALSE,FALSE,TRUE,'<table class="yn"><tr><td><input type="radio" name="%s" value="yes" checked="checked" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynyeschecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynyeschecked','no',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynnochecked','Yes or No, No prechecked',FALSE,FALSE,TRUE,'<table class="yn"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" checked="checked"/>No</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnochecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnochecked','no',TRUE);


-- yes or no or undecided
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynuyeschecked','Yes or No or Undecided, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" checked="checked" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuyeschecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuyeschecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuyeschecked','undecided',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynunochecked','Yes or No or Undecided, No prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" checked="checked" />No</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynunochecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynunochecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynunochecked','undecided',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynuundecidedchecked','Yes or No or Undecided, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="undecided" checked="checked" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuundecidedchecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuundecidedchecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuundecidedchecked','undecided',FALSE);


-- yes or no or dont know
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('yndkyeschecked','Yes or No or Don''t Know, Yes prechecked',FALSE,FALSE,TRUE,'<table class="yndk"><tr><td><input type="radio" name="%s" value="yes" checked="checked" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="dontknow" />Don''t Know</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndkyeschecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndkyeschecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndkyeschecked','dontknow',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('yndknochecked','Yes or No or Don''t Know, No prechecked',FALSE,FALSE,TRUE,'<table class="yndk"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" checked="checked"/>No</td> <td><input type="radio" name="%s" value="dontknow" />Don''t Know</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndknochecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndknochecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndknochecked','dontknow',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('yndkdontknowchecked','Yes or No or Don''t Know, Don''t Know prechecked',FALSE,FALSE,TRUE,'<table class="yndk"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="dontknow" checked="checked" />Don''t Know</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndkdontknowchecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndkdontknowchecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('yndkdontknowchecked','dontknow',FALSE);


-- yes or no or no response
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynnryeschecked','Yes or No or No Response, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynnr"><tr><td><input type="radio" name="%s" value="yes" checked="checked" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="no response" />No Response</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnryeschecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnryeschecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnryeschecked','no response',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynnrnochecked','Yes or No or No response, No prechecked',FALSE,FALSE,TRUE,'<table class="ynnr"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" checked="checked" />No</td> <td><input type="radio" name="%s" value="no response" />No Response</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnrnochecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnrnochecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnrnochecked','no response',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynnrnoresponsechecked','Yes or No or No Response, No Response prechecked',FALSE,FALSE,TRUE,'<table class="ynnr"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="no response" checked="checked" />No Response</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnrnoresponsechecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnrnoresponsechecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnrnoresponsechecked','no response',FALSE);


-- satisfaction one to five
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisnoopinchecked','Satisfaction one to five or Undecided, Undecided prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Undecided</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','0',FALSE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','5',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisneutralchecked','Satisfaction one to five or Undecided, Neutral prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" checked="checked" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','0',FALSE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','5',TRUE);


-- satisfaction categorical
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('verysatisfiedtodissatisfieddontknowchecked','Satisfaction categorical or Don''t Know, Don''t Know prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Very</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Very</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Don''t Know</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked"/></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfieddontknowchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfieddontknowchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfieddontknowchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfieddontknowchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfieddontknowchecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfieddontknowchecked','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('verysatisfiedtodissatisfiedneutralchecked','Satisfaction one to five or Undecided, Neutral prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Very</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Very</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Don''t Know</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3"  checked="checked" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0"/></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfiedneutralchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfiedneutralchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfiedneutralchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfiedneutralchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfiedneutralchecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verysatisfiedtodissatisfiedneutralchecked','0',FALSE);


-- level of agreement
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofagreement','Level of agreement',FALSE,TRUE,TRUE,'<table class="levelofagreement">\n  <tr><td><table><tr><td>Strongly</td></tr><tr><td>Agree</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Agree</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Disagree</td></tr></table></td> <td><table><tr><td>Strongly</td></tr><tr><td>Disagree</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>No Response</td></tr></table></td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','0',FALSE);



-- agree or disagree
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('agreeordisagree','Agree or Disagree',FALSE,TRUE,TRUE,'<table class="agreeordisagree">\n  <tr><td>Agree</td> <td>Disagree</td> <td>Neither</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('agreeordisagree','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('agreeordisagree','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('agreeordisagree','0',FALSE);



-- how much three
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('howmuchthree','How much, three choices',FALSE,TRUE,TRUE,'<table class="howmuchthree">\n  <tr><td>Too little</td> <td>Too much</td> <td>Just about right</td> <td>No Response</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','0',FALSE);


-- how much four
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('howmuchfour','How much, four choices',FALSE,TRUE,TRUE,'<table class="howmuchfour">\n  <tr><td>Very Little</td> <td>Some</td> <td>Quite A Bit</td> <td>Very Much</td> <td>No Response</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','0',FALSE);


-- level of reason
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofreasondontknowchecked','Level of reason',FALSE,TRUE,TRUE,'<table class="levelofreason">\n  <tr><td>Major reason</td> <td>Minor reason</td> <td>Not a reason</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofreasondontknowchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofreasondontknowchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofreasondontknowchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofreasondontknowchecked','0',FALSE);


-- reason or not
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('reasonornotdontknowchecked','Reason or not',FALSE,TRUE,TRUE,'<table class="reasonornot">\n  <tr><td>Reason</td> <td>Not a reason</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('reasonornotdontknowchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('reasonornotdontknowchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('reasonornotdontknowchecked','0',TRUE);


-- level of concern
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofconcern','Level of concern',FALSE,TRUE,TRUE,'<table class="levelofconcern">\n  <tr><td>Very Concerned</td> <td>Concerned</td> <td>Somewhat Concerned</td> <td>Not Concerned</td> <td>No Response</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','0',FALSE);



-- much stronger to much weaker
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('muchstrongertomuchweaker','Much Stronger to Much Weaker',FALSE,TRUE,TRUE,'<table class="hightolow">\n  <tr><td>Much Stronger</td> <td>Stronger</td> <td>No Change</td> <td>Weaker</td> <td>Much Weaker</td> <td>Don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('muchstrongertomuchweaker','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('muchstrongertomuchweaker','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('muchstrongertomuchweaker','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('muchstrongertomuchweaker','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('muchstrongertomuchweaker','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('muchstrongertomuchweaker','0',FALSE);



-- below average to outstanding
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('belowaveragetooutstanding','Below Average to Outstanding',FALSE,TRUE,TRUE,'<table class="hightolow">\n  <tr><td>Below Average</td> <td>Average</td> <td>Above Average</td> <td>Superior</td> <td>Outstanding</td> <td>Don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('belowaveragetooutstanding','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('belowaveragetooutstanding','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('belowaveragetooutstanding','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('belowaveragetooutstanding','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('belowaveragetooutstanding','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('belowaveragetooutstanding','0',FALSE);



-- choice level
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('firstchoicetofifthchoice','Choice Level',FALSE,TRUE,TRUE,'<table class="choicelevel">\n  <tr><td>First Choice</td> <td>Second Choice</td> <td>Third Choice</td> <td>Fourth Choice</td> <td>Fifth Choice</td> <td>Not Sure</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('firstchoicetofifthchoice','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('firstchoicetofifthchoice','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('firstchoicetofifthchoice','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('firstchoicetofifthchoice','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('firstchoicetofifthchoice','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('firstchoicetofifthchoice','0',FALSE);


-- expectations met
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('expectationsmet','Expectations were:',FALSE,TRUE,TRUE,'<table class="expectationsmet">\n  <tr><td>Met At A High Level</td> <td>Met</td> <td>Not met</td> <td>Unsure/Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','0',FALSE);


-- excellent to poor
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('excellenttopoor','Rating',FALSE,TRUE,TRUE,'<table class="excellenttopoor">\n  <tr><td>Excellent</td> <td>Very Good</td> <td>Fair</td> <td>Poor</td> <td>Unsure/Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','0',FALSE);



-- very poorly to very well
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('verypoorlytoverywell','Very Poorly to Very Well',FALSE,TRUE,TRUE,'<table class="verypoortoverywell">\n  <tr><td>Very Poorly</td> <td>Poorly</td> <td>Fair</td> <td>Well</td> <td>Very Well</td> <td>Not Applicable</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verypoorlytoverywell','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verypoorlytoverywell','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verypoorlytoverywell','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verypoorlytoverywell','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verypoorlytoverywell','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('verypoorlytoverywell','0',FALSE);



-- better to poorer
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('bettertopoorer','Better to Poorer',FALSE,TRUE,TRUE,'<table class="bettertoporrer">\n  <tr><td>Better</td> <td>About The Same</td> <td>Poorer</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('bettertopoorer','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('bettertopoorer','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('bettertopoorer','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('bettertopoorer','0',FALSE);


-- of great value to of no value
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ofgreatvaluetoofnovalue','Value',FALSE,TRUE,TRUE,'<table class="value">\n  <tr><td>Of Great Value</td> <td>Of Some Value</td> <td>Of Little Value</td> <td>Of No Value</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ofgreatvaluetoofnovalue','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ofgreatvaluetoofnovalue','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ofgreatvaluetoofnovalue','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ofgreatvaluetoofnovalue','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ofgreatvaluetoofnovalue','0',FALSE);



-- high to low
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('hightolow','High to Low',FALSE,TRUE,TRUE,'<table class="hightolow">\n  <tr><td>High</td> <td>Medium</td> <td>Low</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('hightolow','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('hightolow','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('hightolow','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('hightolow','0',FALSE);



-- many to none
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('manytonone','Many to None',FALSE,TRUE,TRUE,'<table class="manytonone">\n  <tr><td>Many</td> <td>Some</td> <td>Few</td> <td>None</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('manytonone','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('manytonone','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('manytonone','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('manytonone','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('manytonone','0',FALSE);



-- easy to difficult
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('easytodifficult','Easy to Difficult',FALSE,TRUE,TRUE,'<table class="value">\n  <tr><td>Extremely Easy</td> <td>Easy</td> <td>Neutral</td> <td>Difficult</td> <td>Extremely Difficult</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('easytodifficult','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('easytodifficult','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('easytodifficult','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('easytodifficult','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('easytodifficult','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('easytodifficult','0',FALSE);



-- major problem to not a problem
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('majorproblemtonotaproblem','Problem Level',FALSE,TRUE,TRUE,'<table class="value">\n  <tr><td>Major Problem</td> <td>Minor Problem</td> <td>Not A Problem</td> <td>Don''t Know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('majorproblemtonotaproblem','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('majorproblemtonotaproblem','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('majorproblemtonotaproblem','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('majorproblemtonotaproblem','0',FALSE);


-- essential to not important
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('essentialtonotimportant','Essential to Not Important',FALSE,TRUE,TRUE,'<table class="essentialtonotimportang">\n  <tr><td>Essential</td> <td>Importatn</td> <td>Not Important</td> <td>Don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('essentialtonotimportant','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('essentialtonotimportant','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('essentialtonotimportant','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('essentialtonotimportant','0',FALSE);


-- very important to not important
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('veryimportanttonotimportant','Important to Not Important',FALSE,TRUE,TRUE,'<table class="value">\n  <tr><td>Very Important</td> <td>Moderately Important</td> <td>Slightly Important</td> <td>Not Important</td> <td>Don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotimportant','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotimportant','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotimportant','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotimportant','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotimportant','0',TRUE);


-- very important to not at all important
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('veryimportanttonotatallimportant','Important to Not At All Important',FALSE,TRUE,TRUE,'<table class="value">\n  <tr><td><table><tr><td>Very</td></tr><tr><td>Important</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Important</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Not</td></tr><tr><td>Important</td></tr></table></td> <td><table><tr><td>Not At All</td></tr><tr><td>Important</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Don''t Know</td></tr></table></td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotatallimportant','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotatallimportant','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotatallimportant','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotatallimportant','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotatallimportant','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryimportanttonotatallimportant','0',FALSE);


-- excellent to poor, including non-participation
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('excellenttopoorwithnonparticipation','Rating',FALSE,TRUE,TRUE,'<table class="excellenttopoorwithnonparticipation">\n  <tr><td>Excellent</td> <td>Very good</td> <td>Fair</td> <td>Poor</td> <td>I Did Not Use This Service</td> <td>No Response</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','5',FALSE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','0',FALSE);


-- one to ten
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotennrchecked','One to Ten, No Response prechecked',FALSE,TRUE,TRUE,'<table class="onetoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','6',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','7',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','8',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','9',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','10',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotennrchecked','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotenonechecked','One to Ten, One prechecked',FALSE,TRUE,TRUE,'<table class="onetoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" checked="checked" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','6',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','7',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','8',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','9',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenonechecked','10',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotenfivechecked','One to Ten, Five prechecked',FALSE,TRUE,TRUE,'<table class="onetoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" checked="checked" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','6',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','7',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','8',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','9',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotenfivechecked','10',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotentenchecked','One to Ten, Ten prechecked',FALSE,TRUE,TRUE,'<table class="onetoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','6',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','7',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','8',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','9',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontotentenchecked','10',TRUE);

-- one to five, Lo to High
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivelotohigh','One to Five, Lo to High, No Response prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>Lo</td> <td></td> <td></td> <td></td> <td>High</td> <td>No Response</td> </tr>\n <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','0',FALSE);


-- one to five
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('onetofivenr','One to Five, No Response prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofivenr','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofivenr','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofivenr','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofivenr','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofivenr','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofivenr','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('onetofive','One to Five, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofive','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofive','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofive','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofive','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('onetofive','5',TRUE);


-- one to five, Not True to True
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivenottruetotruenr','One to Five, Not True to True, No Response prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td><table><tr><td>Not True</td></tr> <tr><td>At All</td></tr></table></td> <td><table><tr><td></td></tr> <tr><td>1</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>2</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>3</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>4</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>5</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>True</td></tr></table></td> <td><table><tr><td></td></tr> <tr><td>No Response</td></tr></table></td> </tr>\n <tr><td></td> <td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotruenr','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotruenr','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotruenr','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotruenr','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotruenr','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotruenr','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivenottruetotrue','One to Five, Not True to True, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td><table><tr><td>Not True</td></tr> <tr><td>At All</td></tr></table></td> <td><table><tr><td></td></tr> <tr><td>1</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>2</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>3</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>4</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>5</td></tr></table></td> <td><table><tr><td> </td></tr> <tr><td>True</td></tr></table></td> </tr>\n <tr><td></td> <td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','5',TRUE);


-- none to very much
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('nonetoverymuchdontknowprechecked','None to Very Much, Don''t Know prechecked',FALSE,TRUE,TRUE,'<table class="noetoverymuch">\n  <tr><td>None</td> <td>Very Little</td> <td>Some</td> <td>Quite A Bit</td> <td>Very Much</td> <td>Don''t Know</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('nonetoverymuchdontknowprechecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('nonetoverymuchdontknowprechecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('nonetoverymuchdontknowprechecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('nonetoverymuchdontknowprechecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('nonetoverymuchdontknowprechecked','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('nonetoverymuchdontknowprechecked','0',FALSE);


-- daily, weekly, monthly
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmdaycheckednr','Daily, or Weekly, or Monthly, No Response checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never" /></td> <td><input type="radio" name="%s" value="no response" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaycheckednr','daily',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaycheckednr','weekly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaycheckednr','monthly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaycheckednr','rarely',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaycheckednr','never',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaycheckednr','no response',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmdaychecked','Daily, or Weekly, or Monthly, Daily checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" checked="checked" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','daily',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','weekly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','monthly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','rarely',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','never',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmneverchecked','Daily, or Weekly, or Monthly, Never checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never"  checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','daily',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','weekly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','monthly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','rarely',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','never',TRUE);


-- often to never
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('oftentonever','Often to Never',FALSE,TRUE,TRUE,'<table class="dwm"><tr><td>Often</td> <td>Occasionally</td> <td>Rarely</td> <td>Never</td> <td>Not Sure</td></tr>\n  <tr><td><input type="radio" name="%s" value="1"/></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0"  checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('oftentonever','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('oftentonever','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('oftentonever','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('oftentonever','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('oftentonever','0',FALSE);


-- very often to never
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('veryoftentonever','Very Often to Never',FALSE,TRUE,TRUE,'<table class="dwm"><tr><td>Very Often</td> <td>Often</td> <td>Occasionally</td> <td>Never</td> <td>Not Sure</td></tr>\n  <tr><td><input type="radio" name="%s" value="1"/></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryoftentonever','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryoftentonever','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryoftentonever','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryoftentonever','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('veryoftentonever','0',FALSE);



-- minutes
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('minsnrchecked','Minutes, No Response checked',FALSE,FALSE,TRUE,'<table class="mins"><tr><td>Less than 5 mins</td> <td>5-15 mins</td> <td>15-30 mins</td> <td>30-60 mins</td> <td>More than 60 mins</td>  <td>No response</td></tr>\n  <tr><td><input type="radio" name="%s" value="less than 5 mins" /></td> <td><input type="radio" name="%s" value="5-15" /></td> <td><input type="radio" name="%s" value="15-30" /></td> <td><input type="radio" name="%s" value="30-60" /></td> <td><input type="radio" name="%s" value="more than 60" /></td>  <td><input type="radio" name="%s" value="no response" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minsnrchecked','less than 5 mins',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minsnrchecked','5-15',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minsnrchecked','15-30',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minsnrchecked','30-60',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minsnrchecked','more than 60',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minsnrchecked','no response',TRUE);


-- full-time to part-time
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('fulltimeparttime','Full time, Part time',FALSE,TRUE,TRUE,'<table class="ftpt"><tr><td>Full Time</td> <td>Part Time</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="0"  checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('fulltimeparttime','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('fulltimeparttime','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('fulltimeparttime','0',TRUE);


-- faculty, staff, student, alumni
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('facultystaffstudentalumni','Faculty, Staff, Student, Alumni',FALSE,FALSE,TRUE,'<table class="facstaff"><tr><td>Faculty</td> <td>Staff</td> <td>Student</td> <td>Alumni</td> <td>Other</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="faculty" /></td> <td><input type="radio" name="%s" value="staff" /></td> <td><input type="radio" name="%s" value="student" /></td> <td><input type="radio" name="%s" value="alumni" /></td> <td><input type="radio" name="%s" value="other" /></td> <td><input type="radio" name="%s" value="no response" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('facultystaffstudentalumni','faculty',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('facultystaffstudentalumni','staff',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('facultystaffstudentalumni','student',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('facultystaffstudentalumni','alumni',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('facultystaffstudentalumni','other',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('facultystaffstudentalumni','no response',TRUE);


-- credits
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('credits','Credits, No Response prechecked',FALSE,TRUE,TRUE,'<select  class="credits" name="%s"> <option value="no response" disabled="disabled" selected="selected">Select one</option> <option value="0">0 credits</option> <option value="1">1 credit</option> <option value="2">2 credits</option> <option value="3">3 credits</option> <option value="4">4 credits</option> <option value="5">5 credits</option> <option value="6">6 credits</option> <option value="7">7 credits</option> <option value="8">8 credits</option> <option value="9">9 credits</option> <option value="10">10 credits</option> <option value="11">11 credits</option> <option value="12">12 credits</option> <option value="13">13 credits</option> <option value="14">14 credits</option> <option value="15">15 credits</option> <option value="16">16 credits</option> <option value="17">17 credits</option> <option value="18">18 credits</option> <option value="19">19 credits</option> <option value="20">20 credits</option> <option value="21">More than 20</option> </select>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','no response',FALSE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','0',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','6',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','7',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','8',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','9',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','10',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','11',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','12',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','13',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','14',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','15',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','16',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','17',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','18',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','19',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','20',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('credits','21',TRUE);


-- gender
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gendernr','Gender with No Response prechecked',FALSE,FALSE,TRUE,'<table class="gender"><tr><td>Female</td> <td>Male</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="female" /></td> <td><input type="radio" name="%s" value="male" /></td> <td><input type="radio" name="%s" value="no response" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gendernr','female',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gendernr','male',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gendernr','no response',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gender','Gender',FALSE,FALSE,TRUE,'<table class="gender"><tr><td>Female</td> <td>Male</td></tr>\n  <tr><td><input type="radio" name="%s" value="female" /></td> <td><input type="radio" name="%s" value="male" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gender','female',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gender','male',TRUE);


-- class
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('classnr','Class, No Response prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> <td>Senior</td> <td>No Response</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('class','Class, none prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> <td>Senior</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','4',TRUE);


-- class (no seniors)
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('classnr (no seniors)','Class, no seniors, No Response prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> <td>No Response</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr (no seniors)','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr (no seniors)','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr (no seniors)','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('classnr (no seniors)','0',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('class (no seniors)','Class, no seniors, No Response prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class (no seniors)','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class (no seniors)','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class (no seniors)','3',TRUE);


-- gpa
<<<<<<< .mine
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gpanr','GPA, No Response prechecked',FALSE,FALSE,TRUE,'<table class="gpa"><tr><td>4.0-3.5</td> <td>3.4-3.0</td> <td>2.9-2.5</td> <td>less than 2.5</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="4.0-3.5" /></td> <td><input type="radio" name="%s" value="3.4-3.0" /></td> <td><input type="radio" name="%s" value="2.9-2.5" /></td> <td><input type="radio" name="%s" value="less than 2.5" /></td> <td><input type="radio" name="%s" value="no response" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpanr','4.0-3.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpanr','3.4-3.0',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpanr','2.9-2.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpanr','less than 2.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpanr','no response',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gpa','GPA',FALSE,FALSE,TRUE,'<table class="gpa"><tr><td>4.0-3.5</td> <td>3.4-3.0</td> <td>2.9-2.5</td> <td>less than 2.5</td></tr>\n  <tr><td><input type="radio" name="%s" value="4.0-3.5" /></td> <td><input type="radio" name="%s" value="3.4-3.0" /></td> <td><input type="radio" name="%s" value="2.9-2.5" /></td> <td><input type="radio" name="%s" value="less than 2.5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','4.0-3.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','3.4-3.0',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','2.9-2.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','less than 2.5',TRUE);


-- meeting type
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtypenr','Meeting type, No Response prechecked',FALSE,FALSE,TRUE,'<table class="meetingtype"><tr><td>Individual</td> <td>Group</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="individual" /></td> <td><input type="radio" name="%s" value="group" /></td> <td><input type="radio" name="%s" value="no response" checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtypenr','individual',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtypenr','group',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtypenr','no response',TRUE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtype','Meeting type',FALSE,FALSE,TRUE,'<table class="meetingtype"><tr><td>Individual</td> <td>Group</td></tr>\n  <tr><td><input type="radio" name="%s" value="individual" /></td> <td><input type="radio" name="%s" value="group" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtype','individual',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtype','group',TRUE);


-- meeting time
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtime','Meeting time',FALSE,FALSE,TRUE,'<table class="meetingtime">\n  <tr><td></td> <td>One Hour</td> <td>Two-Five</td> <td>Six-Ten</td> <td>More Than</td> </tr>\n <tr><td>None</td> <td>Or Less</td> <td>Hours</td> <td>Hours</td> <td>Ten Hours</td> <td>No Response</td> </tr>\n <tr><td><input type="radio" name="%s" value="none" /></td> <td><input type="radio" name="%s" value="one hour or less" /></td> <td><input type="radio" name="%s" value="two to five hours" /></td> <td><input type="radio" name="%s" value="six to ten hours" /></td> <td><input type="radio" name="%s" value="more than ten hours" /></td> <td><input type="radio" name="%s" value="no response" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtime','none',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtime','one hour or less',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtime','two to five hours',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtime','six to ten hours',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtime','more than ten hours',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meetingtime','no response',TRUE);


-- highest level of education
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('highesteducation','Highest level of education',FALSE,FALSE,TRUE,'<table class="highesteducation">\n  <tr><td>Bachelor''s degree (B.A., B.S., etc.)</td> <td><input type="radio" name="%s" value="bachelors" /></td></tr>\n  <tr><td>Master''s degree (M.A., M.S., etc.)</td> <td><input type="radio" name="%s" value="masters" /></td></tr>\n  <tr><td>M.B.A.</td> <td><input type="radio" name="%s" value="mba" /></td></tr>\n  <tr><td>Bachelor''s degree (B.A., B.S., etc.)</td> <td><input type="radio" name="%s" value="bachelors" /></td></tr>\n  <tr><td>Medical degree (M.D, D.O., D.D.S., D.V.M., etc.)</td> <td><input type="radio" name="%s" value="medical" /></td></tr>\n  <tr><td>Law degree (L.L.B, J.D., etc.)</td> <td><input type="radio" name="%s" value="law" /></td></tr>\n  <tr><td>Other</td> <td><input type="radio" name="%s" value="other" /></td></tr>\n  <tr><td>No Response</td> <td><input type="radio" name="%s" value="no response" checked="checked" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','bachelors',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','masters',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','mba',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','phd',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','medical',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','law',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','other',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','no response',TRUE);


-- very satisfied to very dissatisfied, vertically written
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisfactionvertical','Satisfaction level, vertical',FALSE,TRUE,TRUE,'<table class="satisfactionvertical">\n  <tr><td>Very Satisfied</td> <td><input type="radio" name="%s" value="1" /></td></tr>\n  <tr><td>Satisfied</td> <td><input type="radio" name="%s" value="2" /></td></tr>\n  <tr><td>Neither Satisfied Nor Dissatisfied</td> <td><input type="radio" name="%s" value="3" /></td></tr>\n  <tr><td>Dissatisfied</td> <td><input type="radio" name="%s" value="4" /></td></tr>\n  <tr><td>Very Dissatisfied</td> <td><input type="radio" name="%s" value="5" /></td></tr>\n  <tr><td>No Response</td> <td><input type="radio" name="%s" value="0" checked="checked" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','0',FALSE);


-- definitely to definitely not, vertically written
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('definitelyvertical','Definitely to Definitely Not, vertical',FALSE,TRUE,TRUE,'<table class="definitelyvertical">\n  <tr><td>Definitely</td> <td><input type="radio" name="%s" value="1" /></td></tr>\n  <tr><td>Probably</td> <td><input type="radio" name="%s" value="2" /></td></tr>\n  <tr><td>Might Or Might Not</td> <td><input type="radio" name="%s" value="3" /></td></tr>\n  <tr><td>Probably Not</td> <td><input type="radio" name="%s" value="4" /></td></tr>\n  <tr><td>Definitely Not</td> <td><input type="radio" name="%s" value="5" /></td></tr>\n  <tr><td>No Response</td> <td><input type="radio" name="%s" value="0" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','0',FALSE);


-- major, select box
<<<<<<< .mine
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('major','Major',FALSE,FALSE,TRUE,'<select name="%s" class="major">\n  <option value="click to choose one" disabled="disabled" selected="selected">Click to choose one</option>\n <option value="accounting">Accounting</option>\n <option value="american studies">American Studies</option>\n <option value="anthropology">Anthropology</option>\n  <option value="art">Art</option>\n <option value="biochemistry">Biochemistry</option>\n <option value="biology">Biology</option>\n <option value="business administration">Business Administration</option>\n <option value="chemistry">Chemistry</option>\n <option value="classics">Classics</option>\n <option value="computer science">Computer Science</option>\n <option value="economics">Economics</option>\n <option value="elementary education">Elementary Education</option>\n <option value="engineering">Engineering</option>\n <option value="english">English</option>\n <option value="environmental science">Environmental Science</option>\n <option value="french">French</option>\n <option value="history">History</option>\n <option value="information systems">Information Systems</option>\n <option value="journalism">Journalism</option>\n <option value="mathematics">Mathematics</option>\n <option value="music">Music</option>\n <option value="philosophy">Philosophy</option>\n <option value="physical science">Physical Science</option>\n <option value="physics">Physics</option>\n <option value="political science">Political Science</option>\n <option value="psycology">Psycology</option>\n <option value="religious studies">Religious Stdies</option>\n <option value="sociology">Sociology</option>\n <option value="spanish">Spanish</option>\n <option value="theater">Theater</option>\n </select>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','click to choose one',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','accounting',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','american studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','anthropology',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','art',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','biochemistry',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','biology',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','business administration',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','chemistry',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','classics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','computer science',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','economics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','elementary education',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','engineering',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','english',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','environmental science',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','french',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','history',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','information systems',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','journalism',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','mathematics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','music',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','philosophy',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','physical science',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','physics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','political science',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','psycology',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','religious studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','sociology',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','spanish',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('major','theater',TRUE);


-- minor, select box
<<<<<<< .mine
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('minor','Minor',FALSE,FALSE,TRUE,'<select name="%s" class="minor">\n  <option value="click to choose one" disabled="disabled" selected="selected">Click to choose one</option>\n <option value="accounting">Accounting</option>\n <option value="art">Art</option>\n <option value="biology">Biology</option>\n <option value="business administration">Business Administration</option>\n <option value="chemistry">Chemistry</option>\n <option value="classics">Classics</option>\n <option value="computer science">Computer Science</option>\n <option value="east asian studies">East Asian Studies</option>\n  <option value="economics">Economics</option>\n <option value="english">English</option>\n <option value="environmental studies">Environmental Studies</option>\n <option value="french">French</option>\n <option value="gender/womens studies">Gender/Women''s Studies</option>\n <option value="global studies">Global Studies</option>\n <option value="history">History</option>\n  <option value="human geography">Human Geography</option>\n <option value="international business">International Business</option>\n  <option value="italian">Italian</option>\n <option value="journalism">Journalism</option>\n <option value="mathematics">Mathematics</option>\n <option value="medieval studies">Medieval Studies</option>\n <option value="music">Music</option>\n <option value="philosophy">Philosophy</option>\n <option value="physics">Physics</option>\n <option value="political science">Political Science</option>\n <option value="religious studies">Religious Studies</option>\n <option value="sociology">Sociology</option>\n <option value="spanish">Spanish</option>\n <option value="theater">Theater</option>\n </select>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','click to choose one',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','accounting',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','art',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','biochemistry',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','biology',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','business administration',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','chemistry',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','classics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','computer science',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','east asian studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','economics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','english',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','environmental studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','french',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','gender/womens studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','global studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','history',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','human geography',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','international business',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','italian',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','journalism',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','mathematics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','medieval studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','music',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','philosophy',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','physics',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','political science',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','religious studies',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','sociology',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','spanish',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('minor','theater',TRUE);

-- generic choices (you tell the respondent what are the choices in the quest)
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('generictwo','Generic Two Choices',FALSE,TRUE,TRUE,'<table class="generic">\n  <tr><td>Choice 1</td> <td>Choice 2</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('generictwo','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('generictwo','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('generictwo','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('genericthree','Generic Three Choices',FALSE,TRUE,TRUE,'<table class="generic">\n  <tr><td>Choice 1</td> <td>Choice 2</td> <td>Choice 3</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericthree','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericthree','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericthree','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericthree','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('genericfour','Generic Four Choices',FALSE,TRUE,TRUE,'<table class="generic">\n  <tr><td>Choice 1</td> <td>Choice 2</td> <td>Choice 3</td> <td>Choice 4</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfour','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfour','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfour','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfour','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfour','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('genericfive','Generic Five Choices',FALSE,TRUE,TRUE,'<table class="generic">\n  <tr><td>Choice 1</td> <td>Choice 2</td> <td>Choice 3</td> <td>Choice 4</td> <td>Choice 5</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfive','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfive','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfive','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfive','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfive','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericfive','0',FALSE);

INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('genericsix','Generic Six Choices',FALSE,TRUE,TRUE,'<table class="generic">\n  <tr><td>Choice 1</td> <td>Choice 2</td> <td>Choice 3</td> <td>Choice 4</td> <td>Choice 5</td> <td>Choice 6</td> <td>No Response</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="0" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','6',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('genericsix','0',FALSE);








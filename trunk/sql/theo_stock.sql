-- theo_stock.sql
--  Stock the tables for the Theodolite system
-- 2004-Sept-10


-- People responsible for administering Theo
INSERT INTO admins (name,password,email_name,email_domain) VALUES ('jim','','jim','localhost');


-- question types

-- Just a comment -- no radio boxes at all
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('comment','Comment only',TRUE,FALSE,FALSE,'<input type="text" name="%s" size="80" maxlength="240" />');


-- Just a comment -- room for a paragraph
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('paragraphcomment','Comment only, paragraph size',TRUE,FALSE,FALSE,'<textarea name="%s" cols="80" rows="10" />');

-- True or false
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tftruechecked','True or False, True prechecked',FALSE,FALSE,TRUE,'<table class="tf"><tr><td><input type="radio" name="%s" value="true" checked="checked"/>True</td> <td><input type="radio" name="%s" value="false" />False</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tftruechecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tftruechecked','false',TRUE);
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tffalsechecked','True or False, False prechecked',FALSE,FALSE,TRUE,'<table class="tf"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" checked="checked"/>False</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tffalsechecked','true',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('tffalsechecked','false',TRUE);

-- True or false or undecided
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfutruechecked','True or False or Undecided, True prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" checked="checked"/>True</td> <td><input type="radio" name="%s" value="false" />False</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
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
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynyeschecked','Yes or No, Yes prechecked',FALSE,FALSE,TRUE,'<table class="yn"><tr><td><input type="radio" name="%s" value="yes" checked="checked"/>Yes</td> <td><input type="radio" name="%s" value="no" />No</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynyeschecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynyeschecked','no',TRUE);
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynnochecked','Yes or No, No prechecked',FALSE,FALSE,TRUE,'<table class="yn"><tr><td><input type="radio" name="%s" value="yes" checked="checked"/>Yes</td> <td><input type="radio" name="%s" value="no" checked="checked"/>No</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnochecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynnochecked','no',TRUE);

-- yes or no or undecided
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynuyeschecked','Yes or No or Undecided, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" checked="checked"/>Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuyeschecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuyeschecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuyeschecked','undecided',FALSE);
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynunochecked','Yes or No or Undecided, No prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" checked="checked"/>No</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynunochecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynunochecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynunochecked','undecided',FALSE);
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynuundecidedchecked','Yes or No or Undecided, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="undecided" checked="checked" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuundecidedchecked','yes',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuundecidedchecked','no',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ynuundecidedchecked','undecided',FALSE);

-- satisfaction one to five
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisnoopinchecked','Satisfaction one to five or Undecided, Undecided prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Undecided</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked"/></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','0',FALSE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisnoopinchecked','5',TRUE);
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisneutralchecked','Satisfaction one to five or Undecided, Neutral prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" checked="checked"/></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','0',FALSE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisneutralchecked','5',TRUE);


-- level of agreement
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofagreement','Level of agreement',FALSE,TRUE,TRUE,'<table class="levelofagreement">\n  <tr><td><table><tr><td>Strongly</td></tr><tr><td>Agree</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Agree</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Neutral</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Disagree</td></tr></table></td> <td><table><tr><td>Strongly</td></tr><tr><td>Disagree</td></tr></table></td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofagreement','5',TRUE);


-- how much three
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('howmuchthree','How much, three choices',FALSE,TRUE,TRUE,'<table class="howmuchthree">\n  <tr><td>Too little</td> <td>Too much</td> <td>Just about right</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchthree','3',TRUE);

-- how much four
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('howmuchfour','How much, four choices',FALSE,TRUE,TRUE,'<table class="howmuchfour">\n  <tr><td>Very little</td> <td>Some</td> <td>Quite a bit</td> <td>Very much</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('howmuchfour','4',TRUE);


-- level of concern
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofconcern','Level of concern',FALSE,TRUE,TRUE,'<table class="levelofconcern">\n  <tr><td>Very concerned</td> <td>Concerned</td> <td>Somewhat concerned</td> <td>Not concerned</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('levelofconcern','4',TRUE);


-- expectations met
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('expectationsmet','Expectations were:',FALSE,TRUE,TRUE,'<table class="expectationsmet">\n  <tr><td>At a high level</td> <td>Met</td> <td>Not met</td> <td>Unsure/don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('expectationsmet','4',TRUE);


-- excellent to poor
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('excellenttopoor','Rating',FALSE,TRUE,TRUE,'<table class="excellenttopoor">\n  <tr><td>Excellent</td> <td>Very good</td> <td>Fair</td> <td>Poor</td> <td>Unsure/Don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoor','5',TRUE);


-- excellent to poor, including non-participation
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('excellenttopoorwithnonparticipation','Rating',FALSE,TRUE,TRUE,'<table class="excellenttopoorwithnonparticipation">\n  <tr><td>Excellent</td> <td>Very good</td> <td>Fair</td> <td>Poor</td> <td>I did not use this service</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('excellenttopoorwithnonparticipation','5',FALSE);


-- one to ten
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
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivelotohigh','One to Five, Lo to High, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>Lo</td> <td></td> <td></td> <td></td> <td>High</td> </tr>\n <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivelotohigh','5',TRUE);

-- one to five
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('onetofive','One to Five, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofive','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofive','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofive','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofive','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofive','5',TRUE);


-- one to five, Not True to True
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivenottruetotrue','One to Five, Not True to True, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>Not True</td> <td></td> <td></td> <td></td> <td>Very</td> </tr>\n <tr><td>at all</td> <td></td> <td></td> <td></td> <td>True</td> </tr>\n <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','5',TRUE);

-- daily, weekly, monthly
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmdaychecked','Daily or weekly or monthly, Daily checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" checked="checked" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','daily',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','weekly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','monthly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','rarely',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmdaychecked','never',TRUE);
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmneverchecked','Daily or weekly or monthly, Never checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never"  checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','daily',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','weekly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','monthly',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','rarely',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('dwmneverchecked','never',TRUE);

-- gender
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gender','Gender',FALSE,FALSE,TRUE,'<table class="gender"><tr><td>Female</td> <td>Male</td></tr>\n  <tr><td><input type="radio" name="%s" value="female" /></td> <td><input type="radio" name="%s" value="male" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gender','female',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gender','male',TRUE);


-- class
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('class','Class, none prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> <td>Senior</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','4',TRUE);


-- class (no seniors)
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('class (no seniors)','Class, no seniors, none prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('class','3',TRUE);


-- gpa
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gpa','GPA',FALSE,TRUE,TRUE,'<table class="gpa"><tr><td>4.0-3.5</td> <td>3.4-3.0</td> <td>2.9-2.5</td> <td>less than 2.5</td></tr>\n  <tr><td><input type="radio" name="%s" value="4.0-3.5" /></td> <td><input type="radio" name="%s" value="3.4-3.0" /></td> <td><input type="radio" name="%s" value="2.9-2.5" /></td> <td><input type="radio" name="%s" value="less than 2.5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','4.0-3.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','3.4-3.0',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','2.9-2.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('gpa','less than 2.5',TRUE);

-- meeting type
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtype','Meeting type',FALSE,FALSE,TRUE,'<table class="meetingtype"><tr><td>Individual</td> <td>Group</td></tr>\n  <tr><td><input type="radio" name="%s" value="individual" /></td> <td><input type="radio" name="%s" value="group" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meeting type','individual',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('meeting type','group',TRUE);

-- meeting time
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtime','Meeting time',FALSE,TRUE,TRUE,'<table class="meetingtime">\n  <tr><td></td> <td>Less than</td> <td>two-five</td> <td>six-ten</td> <td>more than</td> </tr>\n <tr><td>None</td> <td>one hour</td> <td>hours</td> <td>hours</td> <td>ten hours</td> </tr>\n <tr><td><input type="radio" name="%s" value="0" /></td> <td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="3.5" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="10" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','0',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','3.5',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','8',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('ontofivenottruetotrue','10',TRUE);

-- highest level of education
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('highesteducation','Highest level of education',FALSE,TRUE,TRUE,'<table class="highesteducation">\n  <tr><td>Bachelor''s degree (B.A., B.S., etc.)</td> <td><input type="radio" name="%s" value="bachelors" /></td></tr>\n  <tr><td>Master''s degree (M.A., M.S., etc.)</td> <td><input type="radio" name="%s" value="masters" /></td></tr>\n  <tr><td>M.B.A.</td> <td><input type="radio" name="%s" value="mba" /></td></tr>\n  <tr><td>Bachelor''s degree (B.A., B.S., etc.)</td> <td><input type="radio" name="%s" value="bachelors" /></td></tr>\n  <tr><td>Medical degree (M.D, D.O., D.D.S., D.V.M., etc.)</td> <td><input type="radio" name="%s" value="medical" /></td></tr>\n  <tr><td>Law degree (L.L.B, J.D., etc.)</td> <td><input type="radio" name="%s" value="law" /></td></tr>\n  <tr><td>Other</td> <td><input type="radio" name="%s" value="other" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','bachelors',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','masters',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','mba',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','phd',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','medical',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','law',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('highesteducation','other',TRUE);

-- very satisfied to very dissatisfied, vertically written
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisfactionvertical','Satisfaction level, vertical',FALSE,TRUE,TRUE,'<table class="satisfactionvertical">\n  <tr><td>Very satisfied</td> <td><input type="radio" name="%s" value="1" /></td></tr>\n  <tr><td>Satisfied</td> <td><input type="radio" name="%s" value="2" /></td></tr>\n  <tr><td>Neither satisfied nor dissatisfied</td> <td><input type="radio" name="%s" value="3" /></td></tr>\n  <tr><td>Dissatisfied</td> <td><input type="radio" name="%s" value="4" /></td></tr>\n  <tr><td>Very dissatisfied</td> <td><input type="radio" name="%s" value="5" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('satisfactionvertical','5',TRUE);

-- definitely to definitely not, vertically written
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('definitelyvertical','Definitelyto Definitely Not, vertical',FALSE,TRUE,TRUE,'<table class="definitelyvertical">\n  <tr><td>Definitely</td> <td><input type="radio" name="%s" value="1" /></td></tr>\n  <tr><td>Probably</td> <td><input type="radio" name="%s" value="2" /></td></tr>\n  <tr><td>Might or might not</td> <td><input type="radio" name="%s" value="3" /></td></tr>\n  <tr><td>Probably not</td> <td><input type="radio" name="%s" value="4" /></td></tr>\n  <tr><td>Definitely not</td> <td><input type="radio" name="%s" value="5" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','1',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','2',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','3',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','4',TRUE);
INSERT INTO legal_answers (q_type,answer,analyzable) VALUES ('definitelyvertical','5',TRUE);


-- major, select box
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('major','Major',FALSE,FALSE,TRUE,'<select name="%s" class="major">\n  <option disabled="disabled" selected="selected">Click to choose one</option>\n <option value="accounting">Accounting</option>\n <option value="american studies">American Studies</option>\n <option value="anthropology">Anthropology</option>\n  <option value="art">Art</option>\n <option value="biochemistry">Biochemistry</option>\n <option value="biology">Biology</option>\n <option value="business administration">Business Administration</option>\n <option value="chemistry">Chemistry</option>\n <option value="classics">Classics</option>\n <option value="computer science">Computer Science</option>\n <option value="economics">Economics</option>\n <option value="elementary education">Elementary Education</option>\n <option value="engineering">Engineering</option>\n <option value="english">English</option>\n <option value="environmental science">Environmental Science</option>\n <option value="french">French</option>\n <option value="history">History</option>\n <option value="information systems">Information Systems</option>\n <option value="journalism">Journalism</option>\n <option value="mathematics">Mathematics</option>\n <option value="music">Music</option>\n <option value="philosophy">Philosophy</option>\n <option value="physical science">Physical Science</option>\n <option value="physics">Physics</option>\n <option value="political science">Political Science</option>\n <option value="psycology">Psycology</option>\n <option value="religious studies">Religious Stdies</option>\n <option value="sociology">Sociology</option>\n <option value="spanish">Spanish</option>\n <option value="theater">Theater</option>\n </select>');
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
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('minor','Minor',FALSE,FALSE,TRUE,'<select name="%s" class="minor">\n  <option disabled="disabled" selected="selected">Click to choose one</option>\n <option value="accounting">Accounting</option>\n <option value="art">Art</option>\n <option value="biology">Biology</option>\n <option value="business administration">Business Administration</option>\n <option value="chemistry">Chemistry</option>\n <option value="classics">Classics</option>\n <option value="computer science">Computer Science</option>\n <option value="east asian studies">East Asian Studies</option>\n  <option value="economics">Economics</option>\n <option value="english">English</option>\n <option value="environmental studies">Environmental Studies</option>\n <option value="french">French</option>\n <option value="gender/womens studies">Gender/Women''s Studies</option>\n <option value="global studies">Global Studies</option>\n <option value="history">History</option>\n  <option value="human geography">Human Geography</option>\n <option value="international business">International Business</option>\n  <option value="italian">Italian</option>\n <option value="journalism">Journalism</option>\n <option value="mathematics">Mathematics</option>\n <option value="medieval studies">Medieval Studies</option>\n <option value="music">Music</option>\n <option value="philosophy">Philosophy</option>\n <option value="physics">Physics</option>\n <option value="political science">Political Science</option>\n <option value="religious studies">Religious Studies</option>\n <option value="sociology">Sociology</option>\n <option value="spanish">Spanish</option>\n <option value="theater">Theater</option>\n </select>');
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



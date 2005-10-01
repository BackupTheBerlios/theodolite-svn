-- theo_stock.sql
--  Stock the tables for the Theodolite system
-- 2004-Sept-10


-- People responsible for administering Theo
INSERT INTO admins (name,password,email_name,email_domain) VALUES ('ftpmaint','','ftpmaint','localhost');


-- question types

-- Just a comment -- no radio boxes at all
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('comment','Comment only',TRUE,FALSE,FALSE,'<input type="text" name="%s" size="80" maxlength="240" />');


-- Just a comment -- room for a paragraph
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('paragraphcomment','Comment only, paragraph size',TRUE,FALSE,FALSE,'<textarea name="%s" cols="80" rows="10" />');

-- True or false
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tftruechecked','True or False, True prechecked',FALSE,FALSE,TRUE,'<table class="tf"><tr><td><input type="radio" name="%s" value="true" checked="checked"/>True</td> <td><input type="radio" name="%s" value="false" />False</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('tftruechecked','true');
INSERT INTO legal_answers (q_type,answer) VALUES ('tftruechecked','false');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tffalsechecked','True or False, False prechecked',FALSE,FALSE,TRUE,'<table class="tf"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" checked="checked"/>False</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('tffalsechecked','true');
INSERT INTO legal_answers (q_type,answer) VALUES ('tffalsechecked','false');

-- True or false or undecided
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfutruechecked','True or False or Undecided, True prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" checked="checked"/>True</td> <td><input type="radio" name="%s" value="false" />False</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfutruechecked','true');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfutruechecked','false');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfutruechecked','undecided');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfufalsechecked','True or False or Undecided, False prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" checked="checked"/>False</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfufalsechecked','true');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfufalsechecked','false');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfufalsechecked','undecided');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('tfuundecidedchecked','True or False or Undecided, True prechecked',FALSE,FALSE,TRUE,'<table class="tfu"><tr><td><input type="radio" name="%s" value="true" />True</td> <td><input type="radio" name="%s" value="false" />False</td> <td><input type="radio" name="%s" value="undecided" checked="checked" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfuundecidedchecked','true');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfuundecidedchecked','false');
INSERT INTO legal_answers (q_type,answer) VALUES ('tfuundecidedchecked','undecided');

-- yes or no
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynyeschecked','Yes or No, Yes prechecked',FALSE,FALSE,TRUE,'<table class="yn"><tr><td><input type="radio" name="%s" value="yes" checked="checked"/>Yes</td> <td><input type="radio" name="%s" value="no" />No</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynyeschecked','yes');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynyeschecked','no');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynnochecked','Yes or No, No prechecked',FALSE,FALSE,TRUE,'<table class="yn"><tr><td><input type="radio" name="%s" value="yes" checked="checked"/>Yes</td> <td><input type="radio" name="%s" value="no" checked="checked"/>No</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynnochecked','yes');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynnochecked','no');

-- yes or no or undecided
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynuyeschecked','Yes or No or Undecided, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" checked="checked"/>Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynuyeschecked','yes');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynuyeschecked','no');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynuyeschecked','undecided');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynunochecked','Yes or No or Undecided, No prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" checked="checked"/>No</td> <td><input type="radio" name="%s" value="undecided" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynunochecked','yes');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynunochecked','no');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynunochecked','undecided');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ynuundecidedchecked','Yes or No or Undecided, Yes prechecked',FALSE,FALSE,TRUE,'<table class="ynu"><tr><td><input type="radio" name="%s" value="yes" />Yes</td> <td><input type="radio" name="%s" value="no" />No</td> <td><input type="radio" name="%s" value="undecided" checked="checked" />Undecided</td></tr></table>\n');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynuundecidedchecked','yes');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynuundecidedchecked','no');
INSERT INTO legal_answers (q_type,answer) VALUES ('ynuundecidedchecked','undecided');

-- satisfaction one to five
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisnoopinchecked','Satisfaction one to five or Undecided, Undecided prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Undecided</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="0" checked="checked"/></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisnoopinchecked','0');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisnoopinchecked','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisnoopinchecked','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisnoopinchecked','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisnoopinchecked','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisnoopinchecked','5');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisneutralchecked','Satisfaction one to five or Undecided, Neutral prechecked',FALSE,TRUE,TRUE,'<table class="satis">\n  <tr><td><table><tr><td>Quite</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Satisfied</td></tr></table></td> <td><table><tr><td>Neutral</td></tr></table></td> <td><table><tr><td>Moderately</td></tr><tr><td>Dissatisfied</td></tr></table></td> <td><table><tr><td>Quite</td></tr><tr><td>Dissatisfied</td></tr></table></td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" checked="checked"/></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisneutralchecked','0');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisneutralchecked','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisneutralchecked','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisneutralchecked','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisneutralchecked','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisneutralchecked','5');


-- level of agreement
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofagreement','Level of agreement',FALSE,TRUE,TRUE,'<table class="levelofagreement">\n  <tr><td><table><tr><td>Strongly</td></tr><tr><td>Agree</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Agree</td></tr></table></td> <td><table><tr><td>Neutral</td></tr></table></td> <td><table><tr><td></td></tr><tr><td>Disagree</td></tr></table></td> <td><table><tr><td>Strongly</td></tr><tr><td>Disagree</td></tr></table></td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofagreement','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofagreement','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofagreement','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofagreement','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofagreement','5');


-- how much three
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('howmuchthree','How much, three choices',FALSE,TRUE,TRUE,'<table class="howmuchthree">\n  <tr><td>Too little</td> <td>Too much</td> <td>Just about right</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchthree','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchthree','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchthree','3');

-- how much four
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('howmuchfour','How much, four choices',FALSE,TRUE,TRUE,'<table class="howmuchfour">\n  <tr><td>Very little</td> <td>Some</td> <td>Quite a bit</td> <td>Very much</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchfour','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchfour','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchfour','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('howmuchfour','4');


-- level of concern
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('levelofconcern','Level of concern',FALSE,TRUE,TRUE,'<table class="howmuchfour">\n  <tr><td>Very concerned</td> <td>Concerned</td> <td>Somewhat concerned</td> <td>Not concerned</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofconcern','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofconcern','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofconcern','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('levelofconcern','4');


-- expectations met
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('expectationsmet','Expectations were:',FALSE,TRUE,TRUE,'<table class="expectationsmet">\n  <tr><td>At a high level</td> <td>Met</td> <td>Not met</td> <td>Unsure/don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('expectationsmet','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('expectationsmet','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('expectationsmet','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('expectationsmet','4');


-- excellent to poor
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('excellenttopoor','Rating',FALSE,TRUE,TRUE,'<table class="excellenttopoor">\n  <tr><td>Excellent</td> <td>Very good</td> <td>Fair</td> <td>Poor</td> <td>Unsure/Don''t know</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoor','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoor','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoor','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoor','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoor','5');


-- excellent to poor, including non-participation
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('excellenttopoorwithnonparticipation','Rating',FALSE,TRUE,TRUE,'<table class="excellenttopoorwithnonparticipation">\n  <tr><td>Excellent</td> <td>Very good</td> <td>Fair</td> <td>Poor</td> <td>I did not use this service</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoorwithnonparticipation','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoorwithnonparticipation','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoorwithnonparticipation','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('excellenttopoorwithnonparticipation','4');


-- one to ten
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotenonechecked','One to Ten, One prechecked',FALSE,TRUE,TRUE,'<table class="onetoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" checked="checked" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','5');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','6');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','7');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','8');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','9');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenonechecked','10');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotenfivechecked','One to Ten, Five prechecked',FALSE,TRUE,TRUE,'<table class="ontoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" checked="checked" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','5');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','6');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','7');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','8');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','9');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotenfivechecked','10');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontotentenchecked','One to Ten, Ten prechecked',FALSE,TRUE,TRUE,'<table class="onetoten">\n  <tr><td>One</td> <td></td> <td></td> <td></td> <td>Five</td> <td></td> <td></td> <td></td> <td></td> <td>Ten</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td> <td><input type="radio" name="%s" value="6" /></td> <td><input type="radio" name="%s" value="7" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="9" /></td> <td><input type="radio" name="%s" value="10" checked="checked" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','5');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','6');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','7');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','8');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','9');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontotentenchecked','10');

-- one to five, Lo to High
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivelotohigh','One to Five, Lo to High, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>Lo</td> <td></td> <td></td> <td></td> <td>High</td> </tr>\n <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivelotohigh','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivelotohigh','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivelotohigh','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivelotohigh','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivelotohigh','5');

-- one to five
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofive','One to Five, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofive','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofive','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofive','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofive','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofive','5');


-- one to five, Not True to True
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('ontofivenottruetotrue','One to Five, Not True to True, none prechecked',FALSE,TRUE,TRUE,'<table class="onetofive">\n  <tr><td>Not True</td> <td></td> <td></td> <td></td> <td>Very</td> </tr>\n <tr><td>at all</td> <td></td> <td></td> <td></td> <td>True</td> </tr>\n <tr><td>1</td> <td>2</td> <td>3</td> <td>4</td> <td>5</td></tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> <td><input type="radio" name="%s" value="5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','5');

-- daily, weekly, monthly
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmdaychecked','Daily or weekly or monthly, Daily checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" checked="checked" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmdaychecked','daily');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmdaychecked','weekly');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmdaychecked','monthly');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmdaychecked','rarely');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmdaychecked','never');
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('dwmneverchecked','Daily or weekly or monthly, Never checked',FALSE,FALSE,TRUE,'<table class="dwm"><tr><td>Daily</td> <td>Weekly</td> <td>Monthly</td> <td>Rarely</td> <td>Never</td></tr>\n  <tr><td><input type="radio" name="%s" value="daily" /></td> <td><input type="radio" name="%s" value="weekly" /></td> <td><input type="radio" name="%s" value="monthly" /></td> <td><input type="radio" name="%s" value="rarely" /></td> <td><input type="radio" name="%s" value="never"  checked="checked" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmneverchecked','daily');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmneverchecked','weekly');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmneverchecked','monthly');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmneverchecked','rarely');
INSERT INTO legal_answers (q_type,answer) VALUES ('dwmneverchecked','never');

-- gender
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gender','Gender',FALSE,FALSE,TRUE,'<table class="gender"><tr><td>Female</td> <td>Male</td></tr>\n  <tr><td><input type="radio" name="%s" value="female" /></td> <td><input type="radio" name="%s" value="male" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('gender','female');
INSERT INTO legal_answers (q_type,answer) VALUES ('gender','male');


-- class
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('class','Class, none prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> <td>Senior</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> <td><input type="radio" name="%s" value="4" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','4');


-- class (no seniors)
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('class (no seniors)','Class, no seniors, none prechecked',FALSE,TRUE,TRUE,'<table class="class">\n  <tr><td>First-year</td> <td>Sophmore</td> <td>Junior</td> </tr>\n  <tr><td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="2" /></td> <td><input type="radio" name="%s" value="3" /></td> </tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('class','3');


-- gpa
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('gpa','GPA',FALSE,TRUE,TRUE,'<table class="gpa"><tr><td>4.0-3.5</td> <td>3.4-3.0</td> <td>2.9-2.5</td> <td>less than 2.5</td></tr>\n  <tr><td><input type="radio" name="%s" value="4.0-3.5" /></td> <td><input type="radio" name="%s" value="3.4-3.0" /></td> <td><input type="radio" name="%s" value="2.9-2.5" /></td> <td><input type="radio" name="%s" value="less than 2.5" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('gpa','4.0-3.5');
INSERT INTO legal_answers (q_type,answer) VALUES ('gpa','3.4-3.0');
INSERT INTO legal_answers (q_type,answer) VALUES ('gpa','2.9-2.5');
INSERT INTO legal_answers (q_type,answer) VALUES ('gpa','less than 2.5');

-- meeting type
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtype','Meeting type',FALSE,FALSE,TRUE,'<table class="meetingtype"><tr><td>Individual</td> <td>Group</td></tr>\n  <tr><td><input type="radio" name="%s" value="individual" /></td> <td><input type="radio" name="%s" value="group" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('meeting type','individual');
INSERT INTO legal_answers (q_type,answer) VALUES ('meeting type','group');

-- meeting time
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('meetingtime','Meeting time',FALSE,TRUE,TRUE,'<table class="meetingtime">\n  <tr><td></td> <td>Less than</td> <td>two-five</td> <td>six-ten</td> <td>more than</td> </tr>\n <tr><td>None</td> <td>one hour</td> <td>hours</td> <td>hours</td> <td>ten hours</td> </tr>\n <tr><td><input type="radio" name="%s" value="0" /></td> <td><input type="radio" name="%s" value="1" /></td> <td><input type="radio" name="%s" value="3.5" /></td> <td><input type="radio" name="%s" value="8" /></td> <td><input type="radio" name="%s" value="10" /></td></tr></table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','0');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','3.5');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','8');
INSERT INTO legal_answers (q_type,answer) VALUES ('ontofivenottruetotrue','10');

-- highest level of education
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('highesteducation','Highest level of education',FALSE,TRUE,TRUE,'<table class="highesteducation">\n  <tr><td>Bachelor''s degree (B.A., B.S., etc.)</td> <td><input type="radio" name="%s" value="bachelors" /></td></tr>\n  <tr><td>Master''s degree (M.A., M.S., etc.)</td> <td><input type="radio" name="%s" value="masters" /></td></tr>\n  <tr><td>M.B.A.</td> <td><input type="radio" name="%s" value="mba" /></td></tr>\n  <tr><td>Bachelor''s degree (B.A., B.S., etc.)</td> <td><input type="radio" name="%s" value="bachelors" /></td></tr>\n  <tr><td>Medical degree (M.D, D.O., D.D.S., D.V.M., etc.)</td> <td><input type="radio" name="%s" value="medical" /></td></tr>\n  <tr><td>Law degree (L.L.B, J.D., etc.)</td> <td><input type="radio" name="%s" value="law" /></td></tr>\n  <tr><td>Other</td> <td><input type="radio" name="%s" value="other" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','bachelors');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','masters');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','mba');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','phd');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','medical');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','law');
INSERT INTO legal_answers (q_type,answer) VALUES ('highesteducation','other');

-- very satisfied to very dissatisfied, vertically written
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('satisfactionvertical','Satisfaction level, vertical',FALSE,TRUE,TRUE,'<table class="satisfactionvertical">\n  <tr><td>Very satisfied</td> <td><input type="radio" name="%s" value="1" /></td></tr>\n  <tr><td>Satisfied</td> <td><input type="radio" name="%s" value="2" /></td></tr>\n  <tr><td>Neither satisfied nor dissatisfied</td> <td><input type="radio" name="%s" value="3" /></td></tr>\n  <tr><td>Dissatisfied</td> <td><input type="radio" name="%s" value="4" /></td></tr>\n  <tr><td>Very dissatisfied</td> <td><input type="radio" name="%s" value="5" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisfactionvertical','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisfactionvertical','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisfactionvertical','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisfactionvertical','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('satisfactionvertical','5');

-- definitely to definitely not, vertically written
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('definitelyvertical','Definitelyto Definitely Not, vertical',FALSE,TRUE,TRUE,'<table class="definitelyvertical">\n  <tr><td>Definitely</td> <td><input type="radio" name="%s" value="1" /></td></tr>\n  <tr><td>Probably</td> <td><input type="radio" name="%s" value="2" /></td></tr>\n  <tr><td>Might or might not</td> <td><input type="radio" name="%s" value="3" /></td></tr>\n  <tr><td>Probably not</td> <td><input type="radio" name="%s" value="4" /></td></tr>\n  <tr><td>Definitely not</td> <td><input type="radio" name="%s" value="5" /></td></tr>\n</table>');
INSERT INTO legal_answers (q_type,answer) VALUES ('definitelyvertical','1');
INSERT INTO legal_answers (q_type,answer) VALUES ('definitelyvertical','2');
INSERT INTO legal_answers (q_type,answer) VALUES ('definitelyvertical','3');
INSERT INTO legal_answers (q_type,answer) VALUES ('definitelyvertical','4');
INSERT INTO legal_answers (q_type,answer) VALUES ('definitelyvertical','5');


-- major, select box
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('major','Major',FALSE,FALSE,TRUE,'<select name="%s" class="major">\n  <option disabled="disabled" selected="selected">Click to choose one</option>\n <option value="accounting">Accounting</option>\n <option value="american studies">American Studies</option>\n <option value="anthropology">Anthropology</option>\n  <option value="art">Art</option>\n <option value="biochemistry">Biochemistry</option>\n <option value="biology">Biology</option>\n <option value="business administration">Business Administration</option>\n <option value="chemistry">Chemistry</option>\n <option value="classics">Classics</option>\n <option value="computer science">Computer Science</option>\n <option value="economics">Economics</option>\n <option value="elementary education">Elementary Education</option>\n <option value="engineering">Engineering</option>\n <option value="english">English</option>\n <option value="environmental science">Environmental Science</option>\n <option value="french">French</option>\n <option value="history">History</option>\n <option value="information systems">Information Systems</option>\n <option value="journalism">Journalism</option>\n <option value="mathematics">Mathematics</option>\n <option value="music">Music</option>\n <option value="philosophy">Philosophy</option>\n <option value="physical science">Physical Science</option>\n <option value="physics">Physics</option>\n <option value="political science">Political Science</option>\n <option value="psycology">Psycology</option>\n <option value="religious studies">Religious Stdies</option>\n <option value="sociology">Sociology</option>\n <option value="spanish">Spanish</option>\n <option value="theater">Theater</option>\n </select>');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','accounting');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','american studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','anthropology');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','art');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','biochemistry');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','biology');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','business administration');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','chemistry');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','classics');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','computer science');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','economics');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','elementary education');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','engineering');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','english');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','environmental science');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','french');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','history');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','information systems');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','journalism');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','mathematics');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','music');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','philosophy');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','physical science');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','physics');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','political science');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','psycology');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','religious studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','sociology');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','spanish');
INSERT INTO legal_answers (q_type,answer) VALUES ('major','theater');


-- minor, select box
INSERT INTO question_types (type,description,multiple,quantitative,bar_chart,html) VALUES ('minor','Minor',FALSE,FALSE,TRUE,'<select name="%s" class="minor">\n  <option disabled="disabled" selected="selected">Click to choose one</option>\n <option value="accounting">Accounting</option>\n <option value="art">Art</option>\n <option value="biology">Biology</option>\n <option value="business administration">Business Administration</option>\n <option value="chemistry">Chemistry</option>\n <option value="classics">Classics</option>\n <option value="computer science">Computer Science</option>\n <option value="east asian studies">East Asian Studies</option>\n  <option value="economics">Economics</option>\n <option value="english">English</option>\n <option value="environmental studies">Environmental Studies</option>\n <option value="french">French</option>\n <option value="gender/womens studies">Gender/Women''s Studies</option>\n <option value="global studies">Global Studies</option>\n <option value="history">History</option>\n  <option value="human geography">Human Geography</option>\n <option value="international business">International Business</option>\n  <option value="italian">Italian</option>\n <option value="journalism">Journalism</option>\n <option value="mathematics">Mathematics</option>\n <option value="medieval studies">Medieval Studies</option>\n <option value="music">Music</option>\n <option value="philosophy">Philosophy</option>\n <option value="physics">Physics</option>\n <option value="political science">Political Science</option>\n <option value="religious studies">Religious Studies</option>\n <option value="sociology">Sociology</option>\n <option value="spanish">Spanish</option>\n <option value="theater">Theater</option>\n </select>');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','accounting');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','art');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','biochemistry');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','biology');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','business administration');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','chemistry');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','classics');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','computer science');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','east asian studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','economics');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','english');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','environmental studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','french');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','gender/womens studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','global studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','history');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','human geography');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','international business');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','italian');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','journalism');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','mathematics');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','medieval studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','music');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','philosophy');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','physics');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','political science');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','religious studies');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','sociology');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','spanish');
INSERT INTO legal_answers (q_type,answer) VALUES ('minor','theater');



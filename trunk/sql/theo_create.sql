-- theo_create.sql
-- Create the tables for the theo database
-- 2004-Sept-10 Jim Hefferon jhefferon@smcvt.edu

-- person responsible for OK-ing surveys, maintainence, etc.
CREATE TABLE admins (
	name	TEXT,
	password	TEXT, -- to approve the proposed surveys 
	email_name	TEXT, -- the "jhefferon" in jhefferon.smcvt.edu
	email_domain	TEXT
);
GRANT select ON admins TO "www-data";

-- types, like "Yes or no"
CREATE TABLE question_types (
	type	TEXT PRIMARY KEY,  -- exs: torf, onetofive, etc.
	description	TEXT,  -- tag to display as choice
	multiple	BOOLEAN,	-- 'radio' is false, 'checkbox' true
	quantitative	BOOLEAN,	-- makes sense to avg values?
	bar_chart	BOOLEAN,	-- show results as bar chart, or list?
	html	TEXT  -- what to put on page for responses
);
GRANT select ON question_types TO "www-data";

-- answers that are allowed, like "yes" or "no"
CREATE TABLE legal_answers (
	a_id	SERIAL,	-- hack to allow order in which answers input to matter
	q_type	TEXT,  -- question type
	answer	TEXT,  -- answer that can be associated with q_type
	analyzable	BOOLEAN,   -- should this count as part of mean, std dev?  or is it a nominal value, like "No opinion"?
	UNIQUE(q_type,answer),
	FOREIGN KEY(q_type) REFERENCES question_types(type)
);
GRANT select ON legal_answers TO "www-data";

-- Surveys that can be taken
CREATE TABLE survey (
	id	SERIAL PRIMARY KEY,  -- what survey is this?
	title	TEXT DEFAULT '',  -- name of survey
	contact_name	TEXT DEFAULT '',	-- name of survey owner
	contact_email	TEXT DEFAULT '',	-- email of survey owner
	password	TEXT DEFAULT '',	-- password to get access to admin information
	date	TIMESTAMP,	-- date survey entered in dB
	intro	TEXT,	-- intro text
	no_qs	INTEGER,	-- number of questions 
	email	BOOLEAN,	-- send email of responses to survey owner?
	anonymous	BOOLEAN,	-- make survey-takers anonymous
	approved	BOOLEAN, 	-- whether admin approves
	answer_format  TEXT DEFAULT '%(number)s, %(subject_id)s, %(value)s, %(comment)s', -- format of each line for CSV file; what to do about comment?
	no_subj_id	BOOLEAN DEFAULT FALSE,	-- Can anyone take it, without a subject id?
	prefix	TEXT,	-- part before the respondent's id
	postfix	TEXT,	-- part after
	date_open	TIMESTAMP,  -- date survey starts up
	mail1	TEXT,  -- initial mail
	mail1sent	BOOLEAN,  -- sent it?
	date_mail2	TIMESTAMP,  -- date to send mail 2
	mail2	TEXT,  -- second mail (if any)
	mail2sent	BOOLEAN,  -- sent it?
	date_mail3	TIMESTAMP,  -- date to send mail 2
	mail3	TEXT,  -- third mail (if any)
	mail3sent	BOOLEAN,  -- sent it?
	date_closed	TIMESTAMP	-- date past which no accept answers
);
GRANT select, insert, update ON survey_id_seq TO "www-data";
GRANT select, insert, update ON survey TO "www-data";

-- People who will take the survey
CREATE TABLE subjects (
	survey_id	TEXT,  -- survey in which this id can partipate
	id	TEXT,	-- uniquifier (within the survey) of this survey-taker
	persons_id	TEXT,	-- id of person, not combined with survey id
	email	TEXT,	-- email to which to mail the invitation
	FOREIGN KEY(survey_id) REFERENCES survey(id),
	PRIMARY KEY(survey_id,id)
);
GRANT select, insert ON subjects TO "www-data";

-- Questions for a survey
CREATE TABLE questions (
	survey_id	TEXT,	-- id of the survey from which question comes
	number	INTEGER,	--what question is this on the survey?
	preamble	TEXT,	--text before the question?
	q_type	TEXT,	-- Yes-or-No, or what?
	body	TEXT,	-- what to ask?
	comment	BOOLEAN,	-- allow a comment after question?
	FOREIGN KEY(q_type) REFERENCES question_types(type),
	PRIMARY KEY(survey_id,number)
);
GRANT select, insert, delete, update ON questions TO "www-data";

-- Answers for a (non-anonymous) survey; value is not here as it is in 
-- answers_values 
-- Note: no date, as that could be used to match answers for anon subjects
CREATE TABLE answers (
	survey_id	TEXT,  -- redundant from the subject id, but useful
	subject_id	TEXT,
	number	INTEGER,
	comment	TEXT,
	PRIMARY KEY(subject_id,number),
	FOREIGN KEY(survey_id,number) REFERENCES questions(survey_id,number),
	FOREIGN KEY(survey_id,subject_id) REFERENCES subjects(survey_id,id)
);
GRANT select, insert, delete, update ON answers TO "www-data";

-- Multiple values are allowed for a single question, from a single subject.
CREATE TABLE answers_values (
	survey_id	TEXT,  -- redundant from the subject id, but useful
	subject_id	TEXT,
	number	INTEGER,
	value	TEXT,
	FOREIGN KEY(subject_id,number) REFERENCES answers(subject_id,number) 
);
GRANT select, insert, delete, update ON answers_values TO "www-data";

-- Contains an entry for each person who has replied already.
CREATE TABLE replied (
	survey_id	TEXT,
	subject_id	TEXT,
	date	TIMESTAMP,  -- so a person could see they had double-clicked
	PRIMARY KEY(survey_id,subject_id),
	FOREIGN KEY(survey_id,subject_id) REFERENCES subjects(survey_id,id)
);
GRANT select, insert, delete, update ON replied TO "www-data";
-- Below here handles the case of surveys with anonymous_flag set 

-- Answers for a survey; value is not here as it is in answers_values 
-- Note: no date, as that could be used to match answers for anon subjects
CREATE TABLE answers_anon (
	dex	SERIAL PRIMARY KEY, -- because sub id's not unique, need this
	survey_id	TEXT,
	subject_id	TEXT DEFAULT 'anonymous',
	number	INTEGER,
	comment	TEXT,
	FOREIGN KEY(survey_id,number) REFERENCES questions(survey_id,number)
);
GRANT select, insert, delete, update ON answers_anon TO "www-data";
GRANT select, insert, delete, update ON answers_anon_dex_seq TO "www-data";

-- Multiple values are allowed for a single question, from a single subject.
CREATE TABLE answers_values_anon (
	dex	INTEGER,
	survey_id	TEXT,
	subject_id	TEXT DEFAULT 'anonymous',
	number	INTEGER,
	value	TEXT,
	FOREIGN KEY(dex) REFERENCES answers_anon(dex) 
);
GRANT select, insert, delete, update ON answers_values_anon TO "www-data";


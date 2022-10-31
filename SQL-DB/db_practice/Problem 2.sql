/*

Problem 2

*/

-- ______________________________________________________

-- 1

SELECT title 
FROM Course
WHERE dept_name='Comp. Sci.' AND credits=3;

/*
output:

"International Finance"
"Japanese"
"Computability Theory"
*/

-- ______________________________________________________

-- 2

SELECT DISTINCT ID 
FROM Student NATURAL JOIN Takes 
WHERE  course_id IN 
(SELECT course_id 
FROM Instructor NATURAL JOIN Teaches 
WHERE  name='Einstein');

/* output is null */

-- ______________________________________________________

-- 3

SELECT MAX(salary) AS max_salary
FROM Instructor;

/* output: "124651.41" */

-- ______________________________________________________

-- 4

SELECT name,salary
FROM Instructor 
WHERE salary in (
SELECT MAX(SALARY)
FROM Instructor);

/* output: "Wieland" "124651.41" */

-- ______________________________________________________

-- #5

SELECT course_id,sec_id,count(ID)
FROM Student NATURAL JOIN Takes NATURAL JOIN Section
WHERE semester='Fall' AND year='2009'
GROUP BY course_id,sec_id;

/* 
output:
"105"	"1"	"327"
"237"	"2"	"311"
"242"	"1"	"295"
"304"	"1"	"307"
"334"	"1"	"268"
"486"	"1"	"304"
"960"	"1"	"307"
*/

-- ______________________________________________________

-- 6

SELECT MAX(enrolment) FROM 
( 
   SELECT course_id,sec_id,count(ID) AS enrolment
   FROM Student NATURAL JOIN Takes NATURAL JOIN Section
   WHERE semester='Fall' AND year='2009'
   GROUP BY course_id,sec_id
) AS fall_enrolment;

/* output: "327" */

-- ______________________________________________________

-- 7

SELECT enrolment, course_id,sec_id FROM(
	SELECT course_id,sec_id,count(ID) AS enrolment
	FROM Student NATURAL JOIN Takes NATURAL JOIN Section
	WHERE semester='Fall' AND year='2009'
	GROUP BY course_id,sec_id
) AS fall_entrolment
WHERE enrolment in(
	SELECT MAX(enrolment) FROM 
(
	SELECT course_id,sec_id,count(ID) AS enrolment
	FROM Student NATURAL JOIN Takes NATURAL JOIN Section
	WHERE semester='Fall' AND year='2009'
	GROUP BY course_id,sec_id
) AS autumn_enrolment
);

/* output: 
"327" 
"105" 
"1" 
*/

-- ______________________________________________________

-- 8

-- set up the relation

CREATE TABLE grade_points(

	grade varchar(3),
	points numeric (2,1),
	
	primary key(grade,points)
);

INSERT INTO grade_points VALUES ('A ',4.0);
INSERT INTO grade_points VALUES ('A-',3.7);
INSERT INTO grade_points VALUES ('B+',3.3);
INSERT INTO grade_points VALUES ('B ',3.0);
INSERT INTO grade_points VALUES ('B-',2.7);
INSERT INTO grade_points VALUES ('C+',2.3);
INSERT INTO grade_points VALUES ('C ',2.0);
INSERT INTO grade_points VALUES ('C-',1.7);
INSERT INTO grade_points VALUES ('D+',1.3);
INSERT INTO grade_points VALUES ('D ',1.0);

SELECT ID, SUM(credits*points) AS total_grade_point 
FROM takes NATURAL JOIN grade_points NATURAL JOIN course
WHERE ID='12345'
GROUP BY ID;

/* output: NONE */

-- ______________________________________________________

-- 9

SELECT ID, SUM(credits*points)/SUM(credits) AS gpa 
FROM takes NATURAL JOIN grade_points NATURAL JOIN course
WHERE ID='12345'
GROUP BY ID;

/* output: NONE */

-- ______________________________________________________

-- 10

SELECT ID, SUM(credits*points)/SUM(credits) AS gpa 
FROM takes NATURAL JOIN grade_points NATURAL JOIN course
GROUP BY ID;

/* output: (too large, 2000 rows) */

-- ______________________________________________________

-- 11

UPDATE  Instructor
SET salary=1.1*salary
WHERE dept_name='Comp. Sci.';

SELECT * FROM Instructor WHERE dept_name='Comp. Sci.';

/*
output:
"34175"	"Bondi"	"Comp. Sci."	"127016.02"
"3335"	"Bourrier"	"Comp. Sci."	"88877.61"
*/

-- ______________________________________________________

-- 12 

DELETE FROM prereq
WHERE course_id NOT IN(
SELECT course_id
FROM Section);

DELETE FROM prereq
WHERE prereq_id NOT IN(
SELECT course_id
FROM Section);

DELETE FROM Course
WHERE course_id NOT IN(
SELECT course_id
FROM Section);

/*
output:
"972"	"Greek Tragedy"	"Psychology"	"4"
"612"	"Mobile Computing"	"Physics"	"3"
"237"	"Surfing"	"Cybernetics"	"3"
"313"	"International Trade"	"Marketing"	"3"
"338"	"Graph Theory"	"Psychology"	"3"
"400"	"Visual BASIC"	"Psychology"	"4"
"760"	"How to Groom your Cat"	"Accounting"	"3"
"629"	"Finite Element Analysis"	"Cybernetics"	"3"
"242"	"Rock and Roll"	"Marketing"	"3"
"482"	"FOCAL Programming"	"Psychology"	"4"
"581"	"Calculus"	"Pol. Sci."	"4"
"843"	"Environmental Law"	"Math"	"4"
"679"	"The Beatles"	"Math"	"3"
"704"	"Marine Mammals"	"Geology"	"4"
"591"	"Shakespeare"	"Pol. Sci."	"4"
"319"	"World History"	"Finance"	"4"
"960"	"Tort Law"	"Civil Eng."	"3"
"274"	"Corporate Law"	"Comp. Sci."	"4"
"426"	"Video Gaming"	"Finance"	"3"
"852"	"World History"	"Athletics"	"4"
"408"	"Bankruptcy"	"Accounting"	"3"
"808"	"Organic Chemistry"	"English"	"4"
"362"	"Embedded Systems"	"Finance"	"4"
"867"	"The IBM 360 Architecture"	"History"	"3"
"169"	"Marine Mammals"	"Elec. Eng."	"3"
"991"	"Transaction Processing"	"Psychology"	"3"
"366"	"Computational Biology"	"English"	"3"
"376"	"Cost Accounting"	"Physics"	"4"
"489"	"Journalism"	"Astronomy"	"4"
"663"	"Geology"	"Psychology"	"3"
"461"	"Physical Chemistry"	"Math"	"3"
"105"	"Image Processing"	"Astronomy"	"3"
"457"	"Systems Software"	"History"	"3"
"401"	"Sanitary Engineering"	"Athletics"	"4"
"949"	"Japanese"	"Comp. Sci."	"3"
"496"	"Aquatic Chemistry"	"Cybernetics"	"3"
"334"	"International Trade"	"Athletics"	"3"
"137"	"Manufacturing"	"Finance"	"3"
"192"	"Drama"	"Languages"	"4"
"959"	"Bacteriology"	"Physics"	"4"
"421"	"Aquatic Chemistry"	"Athletics"	"4"
"200"	"The Music of the Ramones"	"Accounting"	"4"
"599"	"Mechanics"	"Psychology"	"4"
"603"	"Care and Feeding of Cats"	"Statistics"	"3"
"747"	"International Practicum"	"Comp. Sci."	"4"
"559"	"Martian History"	"Biology"	"3"
"545"	"International Practicum"	"History"	"3"
"893"	"Systems Software"	"Cybernetics"	"3"
"476"	"International Communication"	"Astronomy"	"4"
"352"	"Compiler Design"	"Psychology"	"4"
"795"	"Death and Taxes"	"Marketing"	"3"
"864"	"Heat Transfer"	"Geology"	"3"
"802"	"African History"	"Cybernetics"	"3"
"692"	"Cat Herding"	"Athletics"	"3"
"258"	"Colloid and Surface Chemistry"	"Math"	"3"
"748"	"Tort Law"	"Cybernetics"	"4"
"158"	"Elastic Structures"	"Cybernetics"	"3"
"626"	"Multimedia Design"	"History"	"4"
"696"	"Heat Transfer"	"Marketing"	"4"
"791"	"Operating Systems"	"Marketing"	"3"
"875"	"Bioinformatics"	"Cybernetics"	"3"
"415"	"Numerical Methods"	"Biology"	"3"
"468"	"Fractal Geometry"	"Civil Eng."	"4"
"270"	"Music of the 90s"	"Math"	"4"
"793"	"Decison Support Systems"	"Civil Eng."	"3"
"561"	"The Music of Donovan"	"Elec. Eng."	"4"
"239"	"The Music of the Ramones"	"Physics"	"4"
"962"	"Animal Behavior"	"Psychology"	"3"
"527"	"Graphics"	"Finance"	"3"
"974"	"Astronautics"	"Accounting"	"3"
"345"	"Race Car Driving"	"Accounting"	"4"
"642"	"Video Gaming"	"Psychology"	"3"
"927"	"Differential Geometry"	"Cybernetics"	"4"
"694"	"Optics"	"Math"	"3"
"604"	"UNIX System Programmming"	"Statistics"	"4"
"304"	"Music 2 New for your public.instructor"	"Finance"	"4"
"571"	"Plastics"	"Comp. Sci."	"4"
"443"	"Journalism"	"Physics"	"4"
"349"	"Networking"	"Finance"	"4"
"735"	"Greek Tragedy"	"Geology"	"3"
"702"	"Arabic"	"Biology"	"3"
"493"	"Music of the 50s"	"Geology"	"3"
"631"	"Plasma Physics"	"Elec. Eng."	"4"
"486"	"Accounting"	"Geology"	"3"
"445"	"Biostatistics"	"Finance"	"3"

*/

-- ______________________________________________________

-- 13

ALTER TABLE instructor DROP CONSTRAINT instructor_salary_check; 

INSERT INTO Instructor (ID,name,dept_name,salary)

	(SELECT ID,name,dept_name,10000.00
	FROM Student
	WHERE tot_cred>100);
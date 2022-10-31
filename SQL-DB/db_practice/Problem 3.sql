/*

NAME: 
['Ahmad Reza Zare Bidaki','Yasaman Mardan','Anthony Sanogo','Punan Chowdhury']

Assignment 3 / Problem 1

Here are the queries for the first problem:

*/
-- 1

select distinct s.name
from takes ta, student s
where s.id = ta.id and course_id in (	
	select course_id
	from course
	where dept_name like 'Comp. Sci.'
);


/*
output:

"Damas"
"Wakamiya"
"Hochri"
"Subbai"
"Wright"
"Fung"
...+>100

-- _____________________________________________________

-- 2

SELECT id, name FROM student EXCEPT(SELECT id, name 
FROM student NATURAL JOIN takes WHERE year<2009);


/*
output:

"23121"	"Chavez"
"98765"	"Bourikas"
"12345"	"Shankar"
"45678"	"Levy"
"00128"	"Zhang"
"55739"	"Sanchez"
"98988"	"Tanaka"
"44553"	"Peltier"
"19991"	"Brandt"
"54321"	"Williams"
"70557"	"Snow"
"76543"	"Brown"
"76653"	"Aoi"
*/

-- ______________________________________________________


-- 3

select dept_name, max(salary)
from instructor
group by dept_name;


/*
output:

"Astronomy"	    79070.08
"Comp. Sci."	115469.11
"History"	    62000.00
"Athletics"	    103146.87
"Music"	        40000.00
"Psychology"	62579.61
"Geology"	    99382.59
"Accounting"	71351.42
"Pol. Sci."	    124651.41
"Biology"	    77036.18
"Finance"	    105311.38
"Elec. Eng."	90038.09
"Languages"	    90891.69
"Statistics"	104563.38
"English"	    118143.98
"Cybernetics"	117836.50
"Mech. Eng."	107978.47
"Physics"	    121141.99
"Marketing"   	119921.41
*/

-- ______________________________________________________

-- 4 

SELECT MIN(maximum_salary) FROM ( SELECT dept_name, MAX(salary) 
AS maximum_salary FROM instructor GROUP BY dept_name) AS x;

/*
output:

40000.00

*/

-- ______________________________________________________

-- 5

INSERT INTO course(course_id, title, dept_name, credits) VALUES ('CS-001', 'WeeklySeminar', 'Comp. Sci.', 0);


/*
output:

INSERT 0 1

Query returned successfully in 62 msec.

*/

-- ______________________________________________________

-- 6

INSERT INTO SECTION(course_id, sec_id, semester, year) VALUES ('CS-001', '1', 'Autumn',2009);

/*
output:

INSERT 0 1

Query returned successfully in 51 msec.

*/

-- ______________________________________________________

-- 7

INSERT INTO takes(ID, course_id, sec_id, semester, YEAR)
SELECT ID, 'CS-001', '1', 'Spring', 2009 FROM student
WHERE dept_name = 'Comp. Sci.';

/*
output:

INSERT 0 198

Query returned successfully in 85 msec.

*/

-- ______________________________________________________

--8

DELETE FROM takes WHERE (course_id = 'CS-001') and (sec_id = '1') and (semester = 'Autumn') 
and (year = 2009) and (ID in (SELECT ID FROM student WHERE name = 'Chavez'));

/*
output:

DELETE 0

Query returned successfully in 41 msec.

*/

-- ______________________________________________________

--9

DELETE from course
WHERE course_id like 'CS-001';

/*
output:

DELETE 1

Query returned successfully in 49 msec.

*/

-- ______________________________________________________

-- 10

DELETE FROM takes WHERE course_id IN (SELECT course_id FROM course
WHERE lower(title) LIKE '%database%');

/*
output:

DELETE 2

Query returned successfully in 55 msec.

*/

-- ______________________________________________________

-- 11. Suppose that we have a relation marks(ID, score) and we wish to assign grades to
-- students based on the score as follows: grade F if score < 40, grade C 
-- if 40 ≤ score < 60, grade B if 60 ≤ score < 80, and grade A if 80 ≤ score. 
-- Write SQL queries to do the following:

-- Create table marks--
-- Table: public.marks

-- DROP TABLE public.marks;

CREATE TABLE public.marks

(
    "ID" character varying(5) COLLATE pg_catalog."default" NOT NULL,

    score numeric,

    CONSTRAINT "SID" PRIMARY KEY ("ID"),

    CONSTRAINT "ID" FOREIGN KEY ("ID")

        REFERENCES public.student (id) MATCH SIMPLE

        ON UPDATE NO ACTION

        ON DELETE NO ACTION

        NOT VALID

)
TABLESPACE pg_default;
ALTER TABLE public.marks
OWNER to postgres;
	
--Insert into marks--
INSERT INTO public.marks(
	"ID", score)
	VALUES (76672, 55),
	(14182, 56),
	(44985, 78),
	(96052, 98),
	(35175, 87),
	(44271, 65),
	(40897, 62),
	(92839, 98),
	(79329, 34),
	(97101, 76),
	(24865, 34),
	(36052, 76);

INSERT INTO public.marks(
	"ID", score)
	VALUES (98940, 55),
	(21395, 35),
	(55859, 67),
	(74016, 48),
	(93061, 78),
	(94998, 58),
	(1968, 89),
	(90567, 98),
	(49611, 65),
	(81538, 88),
	(68999, 84),
	(74639, 74);


-- 11.a. Display the grade for each student, based on the marks relation.

SELECT "ID", 
    CASE WHEN score >= 80
    THEN 'A'
    WHEN score < 80 AND score >= 60
    THEN 'B'
    WHEN score < 60 AND score >= 40
    THEN 'C'
    WHEN score < 40
    THEN 'F'
    END AS GRADE
    FROM marks;

-- b. Find the number of students with each grade.

with grade AS (SELECT "ID", 
    CASE WHEN score >= 80
    THEN 'A'
    WHEN score < 80 AND score >= 60
    THEN 'B'
    WHEN score < 60 AND score >= 40
    THEN 'C'
    WHEN score < 40
    THEN 'F'
    END AS GRADE
    FROM marks) 
		Select grade, count("ID")
			From GRADE
			Group BY GRADE;

/*
output:

11.a

"76672"	"C"
"14182"	"C"
"44985"	"B"
"96052"	"A"
"35175"	"A"
"44271"	"B"
"40897"	"B"
"92839"	"A"
"79329"	"F"
"97101"	"B"
"24865"	"F"
"36052"	"B"
"98940"	"C"
"21395"	"F"
"55859"	"B"
"74016"	"C"
"93061"	"B"
"94998"	"C"
"1968"	"A"
"90567"	"A"
"49611"	"B"
"81538"	"A"
"68999"	"A"
"74639"	"B"

11.b

"B"	9
"C"	5
"F"	3
"A"	7

*/


-- 12

SELECT dept_name FROM department WHERE lower(dept_name) LIKE "sci";

/*
output: 

*/

-- ______________________________________________________
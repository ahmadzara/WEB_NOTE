/*

Problem 1

*/

-- _____________________________________________________

-- 1

SELECT t_name from public."Teacher"
WHERE t_dept='ECE';

/*
output:

"Kim Basinger"
"James kareter"
"Christopher Lee"
*/

-- ______________________________________________________

-- 2 

SELECT st.s_name 
FROM public."Student" st, public."Enrolment" el
WHERE st.s_id=el.s_id AND el.c_id='CS250';

/*
output:

"Tawny Kitaen"
"Adelbert Antti"
"Benjamin Bratt"
*/

-- ______________________________________________________

-- 3

(SELECT st.s_name, st.s_id FROM public."Student" st, public."Enrolment" el
WHERE st.s_id=el.s_id AND el.c_id='CS348')
INTERSECT
(SELECT s_name, s_id FROM public."Student" NATURAL JOIN public."Enrolment"
WHERE c_id='ECE264' OR c_id='CS503');

/*
output:

"Judith Elba" 239
"William Walker" 237
*/

-- ______________________________________________________

-- 4 

SELECT t_name 
FROM public."Teacher" NATURAL JOIN public."Course_Schedule"
WHERE c_id='MA525';

/*
output: "Sheron Noel"
*/

-- ______________________________________________________

--5

SELECT s_name
FROM public."Student" NATURAL JOIN public."Enrolment"
GROUP BY s_name
HAVING COUNT(s_name)=1 OR COUNT(s_name)=3;

/*
output:

"Adelbert Antti"
"Abram Ace"
*/

-- ______________________________________________________

-- 6

SELECT s_name 
FROM public."Student" NATURAL JOIN public."Enrolment" 
NATURAL JOIN public."Course_Schedule" NATURAL JOIN public."Teacher"
WHERE t_name='Christopher Clifton';

/*
output:

"William Walker"
"Abram Ace"
"Judith Elba"

*/

-- ______________________________________________________

-- 7

SELECT c_name 
FROM public."Student" NATURAL JOIN public."Enrolment" 
NATURAL JOIN public."Course"
WHERE s_status='GR' AND c_level!='GR'
GROUP BY c_name;

/*
output: 

"Information Systems"
"Advanced C Programming"
*/

-- ______________________________________________________

--8 

SELECT s_name 
FROM public."Student" NATURAL JOIN public."Enrolment"
WHERE s_status!='GR' AND c_id IN 
(SELECT c_id 
FROM public."Course_Schedule" 
NATURAL JOIN public."Teacher"
WHERE t_name='Sheron Noel');

/*
output:

"Benjamin Bratt"
"Adelbert Antti"
*/
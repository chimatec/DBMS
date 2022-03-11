
-----(1a) Determine the average salary of employees who are not managers.------
SELECT AVG(salary) AS "EMPLOYEE AVERAGE SALARY"
FROM employee 
WHERE ssn NOT IN (SELECT mgr_ssn FROM department WHERE mgr_ssn = ssn)

------(1b)List all the information about the oldest employee who is not a supervisor.-----
SELECT *
FROM employee e LEFT JOIN employee dt
ON e.ssn = dt.super_ssn
WHERE dt.ssn IS NULL
ORDER BY e.bdate 
LIMIT 1;

-----(1c)List the first name, ssn, and total number of hours worked for employees who have worked less than 40 hours in total.
SELECT fname, ssn, SUM(hours) AS "TOTAL HOURS"
FROM  employee, works_on
WHERE ssn = essn
GROUP BY fname,ssn
HAVING SUM(hours) < 40

-----(1d) List the names of projects that have 3 or more employees working on them. List in order of the number of people working on projects and then in alphabetically order of the project name.
SELECT pname, COUNT(*) AS "AS NUMBERS OF EMPLOYEE"
FROM project, works_on ,employee
WHERE pnumber = Pno AND essn =ssn
GROUP BY pname 
HAVING COUNT (*)>=3
ORDER BY COUNT(*)DESC, pname ASC

----(1e)List the SSN and last name of employees who earn more than $10000 and have a daughter and a son.--
SELECT ssn, lname 
FROM dependent ds
INNER JOIN employee e ON(ds.essn=e.ssn)
INNER JOIN dependent dt ON(dt.essn =e.ssn)
WHERE ds.relationship ='Son' AND dt.relationship = 'Daughter'
AND e.salary >10000;

------(1f)For each employee with dependents, list their last name and the name of their oldest dependent. Display the results in sequence by dependent’s name.

SELECT e.lname AS "EMPLOYEE LAST NAME", dt.dependent_name AS " EMPLOYEE DEPENDNT NAME"
FROM employee e , dependent dt 
WHERE e.ssn =dt.essn AND dt.bdate =(select min(bdate) FROM dependent WHERE dependent.essn = e.ssn)
ORDER BY e.lname, dt.dependent_name

----(1g) Retrieve the last name of each employee who has a son. List the employees in sequence by last name. Do this in 3 different ways:
----(i)Use the IN operator--
SELECT e.lname
FROM employee e INNER JOIN dependent dt
ON ssn IN(dependent_name,essn)
GROUP BY e.lname, dt.relationship
HAVING dt.relationship ='Son'
ORDER BY lname;

---(ii)Use the EXISTS operator
SELECT e.lname
FROM employee e
WHERE EXISTS(SELECT dt.essn FROM dependent dt WHERE dt.essn = e.ssn GROUP BY e.lname, dt.essn,dt.relationship HAVING dt.relationship ='Son')
ORDER BY lname;

----(iii) Use a single-block query (i.e. do not use nested query)--
SELECT lname
FROM employee JOIN dependent ON ssn = essn
WHERE relationship = 'Son'    
ORDER BY lname   

-----(1h)Create a view named Project_hours that lists the project number, project name and the total hours worked on each project.
CREATE VIEW Project_Hours
AS
SELECT e.ssn, e.fname,e.lname,pj.pnumber,pj.pname,wk.essn,wk.hours
FROM employee e, project pj, works_on wk
WHERE e.ssn = wk.essn AND pj.pnumber = wk.pno
GROUP BY e.ssn, e.fname,e.lname,pj.pnumber,pj.pname,wk.hours,wk.essn

-----(h.i)Use the view created above to retrieve a list of employees (fname, lname, ssn) who are working on the project with the least hours.

SELECT fname,lname,ssn,hours
FROM Project_Hours
WHERE hours =(SELECT MIN(hours)FROM project_hours)
GROUP BY fname,lname,ssn,hours

---(2a).....
WITH EMPLOYEE_WORKING_THREE AS(SELECT ssn FROM employee e INNER JOIN works_on wk ON wk.essn = e.ssn INNER JOIN project p ON wk.pno = p.pnumber
WHERE pname = 'ProductX' OR pname = 'ProductY' OR pname = 'ProductZ' GROUP BY e.ssn)
SELECT lname, COUNT(dt.essn) AS TOTAL_NUMBER_OF_DEPENDENTS FROM employee e LEFT JOIN dependent dt ON e.ssn = dt.essn INNER JOIN EMPLOYEE_WORKING_THREE ON e.ssn = EMPLOYEE_WORKING_THREE.ssn
GROUP BY lname
ORDER BY TOTAL_NUMBER_OF_DEPENDENTS

-----(2b) For employee, James Borg, list the ssn and last names of all employees supervised by him directly or indirectly (i.e. from James Borg to the leaves) and their hierarchy level.
WITH RECURSIVE employeesupervisedbyjames(super_ssn,ssn,lname,supervisedlevel)AS
(SELECT e.super_ssn,e.ssn,e.lname,1 AS supervisedlevel
FROM employee e 
WHERE super_ssn IS NULL
UNION ALL
SELECT e.super_ssn,e.ssn,e.lname,supervisedlevel + 1
FROM employee e
INNER JOIN employeesupervisedbyjames AS esnj ON e.super_ssn = esnj.ssn 
)
SELECT ssn, lname,supervisedlevel
FROM employeesupervisedbyjames
ORDER BY supervisedlevel;

-----(2c)c. List the last name of the employee who is the top-most supervisor for ‘Alicia Zelaya’.
WITH RECURSIVE employeesupervisedbyzelaya(super_ssn,ssn,fname,lname,supervisedlevel)AS(
SELECT e.super_ssn,e.ssn,e.fname,e.lname ,1 AS supervisedlevel
FROM employee e 
WHERE super_ssn IS NULL
	UNION ALL
SELECT e.super_ssn, e.ssn,e.fname,e.lname, supervisedlevel +1
FROM employee e INNER JOIN employeesupervisedbyzelaya AS esbz ON e.super_ssn = esbz.ssn
WHERE e.fname = 'Alicia' AND e.lname = 'Zelaya'
)
SELECT ssn, fname, lname
FROM employeesupervisedbyzelaya;

----- (3) Suppose the DBA executed the following ALTER TABLE command but it failed because some rows of Employee violate the referential integrity constraint:
SELECT *
FROM employee
WHERE dno NOT IN (SELECT dnumber FROM department WHERE dnumber = dno)

------(4a) Write the SQL statements to do the following: Add a new attribute “OfficeNumber” to Employee table. “OfficeNumber” values may be 3 or 4 characters long, allows null, has a default value “W-0”. The general format of the field is that the first character is an upper case letter followed by a “-“, followed by any one or two digits. Values that do not have this format must not be allowed when inserting a record in Employee tabl
ALTER TABLE employee ADD COLUMN office VARCHAR(4) DEFAULT 'W-0' NULL CONSTRAINT officeNumber CHECK (office ~ '^[A-Z]-\d{2}$'  OR  office ~ '^[A-Z]-\d{1}$');

--------(4b)Perform a single update on the employee table to set the following office number based on the department number of the employees.
update employee set officeNumber =
CASE WHEN dno = 1 THEN 'A-11'
WHEN dno = 4 THEN 'B-0'
WHEN dno=5 THEN 'Z-99'
ELSE 'W-0'
END;
----------(4c) Increase the salary of employees working in the Research department based on the year they were born. Employees born before 1990 get a 30% increase, employees born between 1990 and 2000, get a 20% increase and employees born after year 2000 get a 10% increase on their original salary.
UPDATE employee
SET salary =
CASE WHEN bdate < '1950-01-01' THEN salary * 1.3
WHEN bdate BETWEEN '1950-01-01' AND '1970-12-31' THEN salary * 1.2
ELSE salary * 1.1
END
FROM department
WHERE dnumber = dno AND dname = 'Research';

/*(5a)Modify the Company database to do the following. For question 3a, you must drop existing constraints that conflict with the new conditions.
a. Use RESTRICT for all referential integrity. Except the following cases:
When an employee is deleted:
- set FK in Employee and Department to null
- delete referenced rows in Works_On and Dependent
When an employee’s SSN is updated: then propagate that change to all related FKs.
*/

ALter table employee drop constraint companyFK1 ;
alter table employee drop constraint companyFK2 ;
alter table works_on drop constraint companyFK3 ;
alter table works_on drop constraint companyFK4 ;
alter table dept_locations drop constraint companyFK5 ;
alter table dependent drop constraint companyFK6 ;
alter table department drop constraint companyFK7 ;
alter table project drop constraint companyFK8 ;

ALTER TABLE EMPLOYEE  ADD constraint companyFK1 FOREIGN KEY(Super_ssn)
REFERENCES EMPLOYEE (Ssn) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE EMPLOYEE  ADD constraint companyFK2 FOREIGN KEY(Dno)
REFERENCES DEPARTMENT (Dnumber) ON DELETE SET NULL;

ALTER TABLE WORKS_ON ADD constraint companyFK3 FOREIGN KEY(Essn)
REFERENCES EMPLOYEE (Ssn) ON UPDATE CASCADE;

ALTER TABLE WORKS_ON  ADD constraint companyFK4 FOREIGN KEY(Pno)
REFERENCES PROJECT (Pnumber) ON DELETE RESTRICT;

ALTER TABLE DEPT_LOCATIONS  ADD constraint companyFK5 FOREIGN KEY(Dnumber)
REFERENCES DEPARTMENT (Dnumber) ON DELETE RESTRICT;

ALTER TABLE DEPENDENT  ADD constraint companyFK6 FOREIGN KEY(Essn)
REFERENCES EMPLOYEE (Ssn) ON DELETE RESTRICT;

ALTER TABLE DEPARTMENT  ADD constraint companyFK7 FOREIGN KEY(Mgr_ssn)
REFERENCES EMPLOYEE (Ssn) ON DELETE RESTRICT;

ALTER TABLE PROJECT  ADD constraint companyFK8 FOREIGN KEY (Dnum)
REFERENCES DEPARTMENT (Dnumber) ON DELETE RESTRICT;

-----(5b)Change Franklin’s Wong’s SSN to 99995555.

update employee set ssn = '99955555' where lower(fname) = 'Franklin' and lower(lname) ='Wong'

---(5c)Insert yourself as an employee in the Administration department, where SSN is your student number, you are supervised by Alicia Zelaya (who is already an employee), your salary is $30000.
INSERT INTO EMPLOYEE (Fname,Minit,Lname,Ssn,Bdate,Address,Sex,Salary,Super_ssn,Dno) VALUES ('Chimankpam','M','Wilson','76636634','1937-11-10','450 Stone, Houston, TX','M',30000,999887777,4);

---(5d) Delete James Borg.
delete from employee where lower(fname) = 'james' and lower(lname)='borg'

----(6)Increase the salary of employees based on the number of people they supervise directly.Employees supervising more than 3 people get a 30% increase, employees supervising 1 or 2 people get a 20% increase and employee not supervising anyone get a 10% increase on their original salary.

UPDATE employee e 
SET salary = 
CASE WHEN NoSuper < 1 THEN salary * 1.1
     WHEN NoSuper <=2 THEN salary * 1.2
     ELSE salary *1.3
END
FROM (SELECT s.ssn, COUNT (e.SSn) as NoSuper FROM EMPLOYEE s 
LEFT JOIN EMPLOYEE e ON s.ssn = e.super_ssn 
GROUP BY s.ssn) Tempor
WHERE e.ssn = Temppor.ssn;
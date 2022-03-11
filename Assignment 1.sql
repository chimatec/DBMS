
/*
* QUESTION 2A. 
*List all employees sorted by last name and then first name, both in reverse order. Employee first
names must be displayed first.
*/

    SELECT fname,minit,lname,ssn,bdate,address,sex,salary,super_ssn, dno
    FROM Employee
    ORDER BY lname,fname

/*
* QUESTION 2B. 
* List all projects with the sequence of characters tion in its name.
*/
    SELECT * FROM project 
    WHERE pname LIKE '%t%'
    AND pname LIKE '%i%'
    AND pname LIKE '%o%'
    AND pname LIKE '%n%'

/*
* QUESTION 2C. 
*List all employees who are working on the project named ProductX.
*/
	SELECT *
	FROM employee
	WHERE ssn IN(SELECT essn
	FROM works_on
	WHERE pno IN(SELECT pnumber FROM project WHERE pname = 'ProductX'));

/*
* QUESTION 2D. 
*List employees where the employee and the dependent have the same first name and are of the
same sex. 
*/

    SELECT *
    FROM employee emp,dependent dp
    WHERE emp.ssn = dp.essn
    AND emp.fname = dp.dependent_name 
    AND emp.sex = dp.sex 

/*
* QUESTION 2E. 
*List the name of the oldest employee who has the least salary in the administration department.
Assume that there is more than one oldest employee.
*/

    SELECT *
    FROM employee emp, department dpt
    WHERE dpt.dnumber =emp.dno AND dpt.dname ='Administration'
    ORDER BY salary ASC, bdate ASC
    LIMIT 1;

/*
* QUESTION 2F. 
* List all employees who has a daughter that was born in the 1980s.
*/

    SELECT *
    FROM employee e, dependent dpt
    WHERE e.ssn = dpt.essn AND dpt.bdate BETWEEN '1980-01-01' AND '1989-12-31' AND dpt.relationship ='Daughter';

/*
* QUESTION 2G. 
*List all employees and the name of their supervisor (if they have one).
*/
    SELECT emp.fname AS "Employee Firstname", emp.lname AS "Employee Lastname",emp.ssn AS "Employee ssn",
    sup.fname AS "Supervisor Firstname", sup.lname AS "Supervisor Lastname",sup.ssn AS "Supervisor ssn"
    FROM employee emp 
    LEFT JOIN employee sup
    ON emp.super_ssn = sup.ssn;

/*
* QUESTION 2H. 
*List the oldest employee who is not a supervisor.
*/
    WITH employee_old AS(SELECT emp.*,
        MIN(bdate)
        OVER (PARTITION BY 1) 
        AS old_bdate
        FROM employee emp
    WHERE NOT EXISTS (SELECT null 
            FROM employee sup
            WHERE sup.super_ssn = emp.ssn))
    SELECT fname, lname
    FROM employee_old
    WHERE bdate = old_bdate






UPDATE employee 
    SET salary = salary * 1.1
        WHERE ssn IN(SELECT ssn FROM(SELECT ssn, COUNT(e.super_ssn) FROM employee e GROUP BY e.ssn HAVING COUNT(e.super_ssn)<1)supervis);

UPDATE employee 
    SET salary = salary * 1.2
        WHERE ssn IN(SELECT super_ssn FROM(SELECT e.super_ssn, COUNT(e.ssn)FROM employee e INNER JOIN employee s ON e.super_ssn = s.ssn GROUP BY e.super_ssn HAVING COUNT(e.ssn)<=2)supervisor);

UPDATE employee 
    SET salary = salary * 1.3
        WHERE ssn IN(SELECT super_ssn FROM(SELECT e.super_ssn, COUNT()FROM employee e INNER JOIN employee s ON e.super_ssn = s.ssn GROUP BY e.super_ssn HAVING COUNT()>=3)supervisor);

UPDATE Employee
    SET Salary = Salary * 1.1
        WHERE super_ssn IN (SELECT y.ssn
             FROM employee y WHERE y.super_ssn != ssn );
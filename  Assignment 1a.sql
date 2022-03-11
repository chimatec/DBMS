
/*
* QUESTION 1.e. 
* DDL QURIERS FOR AIRLINE DATABSE
*/

-- Creating table for airport:
CREATE TABLE AIRPORT (
    Airport_code CHAR(3) NOT NULL,
    Name VARCHAR(34) NOT NULL,
    City VARCHAR(20) NOT NULL,
    State VARCHAR (20) NOT NULL,
    PRIMARY KEY (Airport_code)
);
---Created a Domain to check yes or no value:
CREATE DOMAIN weekdays_check AS character Varying NOT NULL CONSTRAINT week_day_check CHECK(VALUE IN('yes','no'));

--- Creating Flight table:
CREATE TABLE FLIGHT(
    Flight_number VARCHAR(6) NOT NULL,
    Airline VARCHAR(20) NOT NULL,
    Weekdays weekdays_check NOT NULL,
    PRIMARY KEY(Flight_number)
);

---Creating Flight Leg table:
CREATE TABLE FLIGHT_LEG(
    Flight_number VARCHAR(6) NOT NULL,
    Leg_number INTEGER NOT NULL,
    Departure_airport_code CHAR(3) NOT NULL,
    Arrival_airport_code CHAR(3) NOT NULL,
    Schedule_departure_time TIMESTAMP WITH TIME ZONE,
    Schedule_arrival_time TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY(Flight_number, Leg_number), --added primary keys:
    FOREIGN KEY (Flight_number) REFERENCES FLIGHT (Flight_number), ---added foreign Keys:
    FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT (Airport_code),--- adding foreign Keys refrencing it to Airport:
    FOREIGN KEY(Arrival_airport_code)REFERENCES AIRPORT (Airport_code) ----More Foreign Key referencing Airport:
);
--- Creating Leg Instance Table with primary and foreign keys:
CREATE TABLE LEG_INSTANCE (
    Flight_number VARCHAR(6) NOT NULL,
    Leg_number INTEGER NOT NULL,
    Leg_date DATE NOT NULL,
    Number_of_available_seats INTEGER,
    Airline_id INTEGER,
    Departure_airport_code CHAR(3),
    Arrival_time TIMESTAMP WITH TIME ZONE,
    Departure_time TIMESTAMP WITH TIME ZONE,
    Arrival_airport_code CHAR(3),
    PRIMARY KEY (Flight_number,Leg_number,Leg_date),
    FOREIGN KEY (Flight_number,Leg_number) REFERENCES FLIGHT_LEG (Flight_number,Leg_number),
    FOREIGN KEY (Departure_airport_code) REFERENCES AIRPORT(Airport_code),
    FOREIGN KEY (Arrival_airport_code) REFERENCES AIRPORT (Airport_code)
);

--Creating Fare Table with primary and foreign Keys:
CREATE TABLE FARES(
    Flight_number VARCHAR(6) NOT NULL,
    Fare_code VARCHAR(12) NOT NULL,
    Amount DECIMAL (8,2) NOT NULL,
    Restrictions VARCHAR(200),
    PRIMARY KEY (Flight_number,Fare_code),
    FOREIGN KEY(Flight_number)REFERENCES FLIGHT(Flight_number)
);
---Creating Airplane Type Table with primary keys
CREATE TABLE AIRPLANE_TYPE(
    Airplane_type_name VARCHAR (20) NOT NULL,
    Max_seats INTEGER NOT NULL,
    Company VARCHAR(15)NOT NULL,
    PRIMARY KEY (Airplane_type_name)

);
-- Creating Can Land Table with primary and foreign Keys:
CREATE TABLE CAN_LAND (
    Airplane_type_name VARCHAR (20) NOT NULL,
    Airport_code CHAR(3) NOT NULL,
    PRIMARY KEY (Airplane_type_name,Airport_code),
    FOREIGN KEY (Airplane_type_name) REFERENCES AIRPLANE_TYPE (Airplane_type_name),
    FOREIGN KEY (Airport_code) REFERENCES AIRPORT(Airport_code)
);
---Creating Airplane Table including its primary and foreign keys:
CREATE TABLE AIRPLANE (
    Airline_id INTEGER NOT NULL,
    Total_number_of_seats INTEGER NOT NULL,
    Airplane_type VARCHAR(20) NOT NULL,
    PRIMARY KEY (Airline_id),
    FOREIGN KEY (Airplane_type) REFERENCES AIRPLANE_TYPE (Airplane_type_name)
);
---Creating Seat Reservation Table with Primary and foreign keys:
CREATE TABLE SEAT_RESERVATION (
    Flight_number VARCHAR(6) NOT NULL,
    Leg_number INTEGER NOT NULL,
    Seat_number VARCHAR(4) NOT NULL,
    Booking_date DATE NOT NULL,
    Customer_name VARCHAR(32) NOT NULL,
    Customer_phone CHAR(12),
    PRIMARY KEY(Flight_number,Leg_number,Booking_date,Seat_number),
    FOREIGN KEY(Flight_number,Leg_number,Booking_date) REFERENCES LEG_INSTANCE(Flight_number,Leg_number,Leg_date)
);


/*
* CHIMANKPAM MOTISE WILSON , 3071950
* ASSIGNMENT 1 
* COURSE ACS-3902-002
*/

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

    ---Refrenece: https://modern-sql.com/feature/with ---
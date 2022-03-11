
INSERT INTO BANK (bnkName,bnkNumber) VALUES ('RBC','093726');
INSERT INTO BANK (bnkName,bnkNumber) VALUES ('Scottia Bank','293478');
INSERT INTO BANK (bnkName,bnkNumber) VALUES ('TD','536456');
INSERT INTO BANK (bnkName,bnkNumber) VALUES ('Royal Bank','675856');


INSERT INTO BRANCH (bkNum,brnCode,address,phone) VALUES('093726','WP-775','24 Toronto Av. WPG','204-776-2673');
INSERT INTO BRANCH (bkNum,brnCode,address,phone) VALUES('293478','WP-776','65 Arlignton Av. WPG','204-776-2973');
INSERT INTO BRANCH (bkNum,brnCode,address,phone) VALUES('536456','WP-777','74 Academy Str. WPG','204-776-2876');
INSERT INTO BRANCH (bkNum,brnCode,address,phone) VALUES('675856','MB-778','34 Windshield Str. WPG','204-776-4876');
INSERT INTO BRANCH (bkNum,brnCode,address,phone) VALUES('675856','MB-773','4 Akokwa Str. WPG','204-076-4876');



INSERT INTO CUSTOMER (clientNum,acNumber,fname,lname,brnCode) VALUES ('001100220033', '093726347','Bright','Adams','MB-778');
INSERT INTO CUSTOMER (clientNum,acNumber,fname,lname,brnCode) VALUES ('001100220034', '093726346','Tony','Olujimi','WP-775');
INSERT INTO CUSTOMER (clientNum,acNumber,fname,lname,brnCode) VALUES ('001100220035', '093726345','Orji','Kalu','WP-777');
INSERT INTO CUSTOMER (clientNum,acNumber,fname,lname,brnCode) VALUES ('001100220036', '003726346','Daniel','Nwosu','WP-776');
INSERT INTO CUSTOMER (clientNum,acNumber,fname,lname,brnCode) VALUES ('001100220038', '093726344','Chima','Wilson','WP-776');


INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('Royal Bank','093726347','001100220033',4556,'MB-778');
INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('TD','009372634','001100220033',4346,'WP-777');
INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('Scottia Bank','003726346','001100220036',4666,'WP-775');
INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('Royal Bank','093726345','001100220035',756,'WP-776');
INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('Royal Bank','093726346','001100220034',856,'MB-773');
INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('Royal Bank','093726337','001100220034',656,'MB-773');
INSERT INTO ACCOUNT(bkName,accNum,clientNum,balance,bmCode) VALUES('RBC','093726344','001100220038',10256,'MB-773');


INSERT INTO CHEQUING(accNum,overDraft) VALUES('009372634',0);
INSERT INTO CHEQUING(accNum,overDraft) VALUES('003726346',0);
INSERT INTO CHEQUING(accNum,overDraft) VALUES('093726344',0);

INSERT INTO SAVINGS (savAccNum,interestRate) VALUES ('093726347',1.1);
INSERT INTO SAVINGS (savAccNum,interestRate) VALUES ('093726346',1.1);
INSERT INTO SAVINGS (savAccNum,interestRate) VALUES ('093726337',1.1);
INSERT INTO SAVINGS (savAccNum,interestRate) VALUES ('093726345',1.1);



INSERT INTO LOAN(bnkNam, brnCode,clientNum,balance,loaNum) VALUES ('Royal Bank','MB-778','001100220033',NULL,'00987654');
INSERT INTO LOAN(bnkNam, brnCode,clientNum,balance,loaNum) VALUES ('Royal Bank','MB-773','001100220034',300000,'00987657');
INSERT INTO LOAN(bnkNam, brnCode,clientNum,balance,loaNum) VALUES ('TD','WP-777','001100220034',NULL,'00987655');
INSERT INTO LOAN(bnkNam, brnCode,clientNum,balance,loaNum) VALUES ('RBC','WP-775','001100220035',NULL,'00987656');
INSERT INTO LOAN(bnkNam, brnCode,clientNum,balance,loaNum) VALUES ('Scottia Bank','WP-776','001100220038',NULL,'00987633');


INSERT INTO STUDENT(loanNum,amount,lnDate,gradYear) VALUES ('00987654',20000,NULL,NULL);
INSERT INTO STUDENT(loanNum,amount,lnDate,gradYear) VALUES('00987655',30000,NULL,NULL);
INSERT INTO STUDENT(loanNum,amount,lnDate,gradYear) VALUES('00987656',200000,NULL,NULL);
INSERT INTO STUDENT(loanNum,amount,lnDate,gradYear) VALUES('00987657',7000,NULL,NULL);


INSERT INTO HOUSE(loaNum,amount,lnDate,address, amortization) VALUES ('00987654',90000,'2021-02-04','87 Williams Ave. La Salle', NULL);
INSERT INTO HOUSE(loaNum,amount,lnDate,address, amortization) VALUES ('00987657',400000,'2021-02-04','873 Williams Ave. La Salle',NULL);
INSERT INTO HOUSE(loaNum,amount,lnDate,address, amortization) VALUES ('00987656',70000,'2021-02-04','73 Williams Ave. La Salle' ,NULL);
INSERT INTO HOUSE(loaNum,amount,lnDate,address, amortization) VALUES ('00987653',40000,'2021-02-04','173 Williams Ave. La Salle' ,NULL);

INSERT INTO CAR (loanNum,regAmount,regDate,model) VALUES ('00987651',70000,'2021-04-09','BMW-X5');
INSERT INTO CAR (loanNum,regAmount,regDate,model) VALUES ('00987650',7000,'2021-04-05','BMZ-GL');
INSERT INTO CAR (loanNum,regAmount,regDate,model) VALUES ('00987656', 70000,'2021-04-09','SUV-L5');
INSERT INTO CAR (loanNum,regAmount,regDate,model) VALUES ('00987657',7000, '2021-04-09','BMW-X5');


INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987656',10000,'4568-0984-3345-0876','2025-09-04');
INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987633',7000,'4568-0984-3345-0876','2026-03-02');
INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987654',20000,'4568-0984-3345-0876','2026-05-01');
INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987634',NULL,'4568-0984-3345-0876','2021-09-04');

INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987654',NULL,5000);
INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987655',NULL,5000);
INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987656',NULL,5000);
INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987657',NULL,5000);



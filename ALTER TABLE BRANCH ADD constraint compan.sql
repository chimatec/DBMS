ALTER TABLE BRANCH ADD constraint companyFK1 FOREIGN KEY(bkNum)
REFERENCES BANK(bnkNumber);

ALTER TABLE ACCOUNT ADD constraint FK3 FOREIGN KEY(bmCode)
REFERENCES BRANCH (brnCode);

ALTER TABLE SAVINGS ADD constraint FK5 FOREIGN KEY(savAccNum)
REFERENCES ACCOUNT(accNum);

ALTER TABLE CUSTOMER  ADD constraint FK6 FOREIGN KEY(brnCode)
REFERENCES BRANCH (brnCode);

ALTER TABLE ACCOUNT ADD constraint FK4 FOREIGN KEY(clientNum)
REFERENCES CUSTOMER(clientNum);

ALTER TABLE LOAN ADD constraint FK7 FOREIGN KEY(bnkNam)
REFERENCES BANK (bnkName);

ALTER TABLE LOAN ADD constraint FK8 FOREIGN KEY(brnCode)
REFERENCES BRANCH (brnCode);

ALTER TABLE LOAN ADD constraint FK9 FOREIGN KEY(clientNum)
REFERENCES CUSTOMER (clientNum);

ALTER TABLE HOUSE ADD constraint FK11 FOREIGN KEY (loaNum)
REFERENCES LOAN (loaNum);

ALTER TABLE STUDENT ADD constraint FK12 FOREIGN KEY (loanNum)
REFERENCES LOAN (loaNum);

ALTER TABLE CAR ADD constraint FK13 FOREIGN KEY (loanNum)
REFERENCES LOAN (loaNum);

ALTER TABLE CREDIT_CARD ADD constraint FK15 FOREIGN KEY (loaNum)
REFERENCES LOAN (loaNum);

ALTER TABLE LINE_OF_CREDIT ADD constraint FK16 FOREIGN KEY (loaNum)
REFERENCES LOAN (loaNum);






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
INSERT INTO SAVINGS (savAccNum,interestRate) VALUES ('093726337',1.1);----Not Present---
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


INSERT INTO CAR (loanNum,regAmount,regDate,model) VALUES ('00987656', 70000,'2021-04-09','SUV-L5');
INSERT INTO CAR (loanNum,regAmount,regDate,model) VALUES ('00987657',7000, '2021-04-09','BMW-X5');


INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987656',10000,'4568-0984-3345-0876','2025-09-04');
INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987633',7000,'4568-0984-3345-0876','2026-03-02');
INSERT INTO CREDIT_CARD(loaNum,revLimit,ccNum, expiry) VALUES('00987654',20000,'4568-0984-3345-0876','2026-05-01');

INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987654',NULL,5000);
INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987655',NULL,5000);
INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987656',NULL,5000);
INSERT INTO LINE_OF_CREDIT (loaNum,revLimit,line_of_credit ) VALUES ('00987657',NULL,5000);








CREATE TABLE BANK(
    bnkName VARCHAR(30)NOT NULL,
    bnkNumber CHAR(6) NOT NULL,
    PRIMARY KEY(bnkNumber),
	UNIQUE(bnkName)
);
CREATE TABLE BRANCH(
bkNum CHAR(6) NOT NULL,
brnCode VARCHAR(6)NOT NULL,
address VARCHAR(30) NOT NULL,
phone VARCHAR(12) NOT NULL,
PRIMARY KEY(brnCode)
);
CREATE TABLE CHEQUING(
    accNum VARCHAR(9) NOT NULL,
    overDraft DECIMAL(10,2) NULL,
    PRIMARY KEY(accNum)
   );
   
CREATE TABLE ACCOUNT(
    bkName VARCHAR(30) NOT NULL,
    accNum VARCHAR(9) NOT NULL,
	clientNum VARCHAR(12) NOT NULL,
    balance DECIMAL (10,2) NULL,
    bmCode VARCHAR(6)NOT NULL,
    PRIMARY KEY(accNum),
	UNIQUE(clientNum)
);
CREATE TABLE SAVINGS(
    savAccNum VARCHAR(9) NOT NULL,
    interestRate DECIMAL(10,0) NULL,
    PRIMARY KEY(savAccNum)

);
CREATE TABLE CUSTOMER(
    clientNum VARCHAR(12) NOT NULL,
	acNumber VARCHAR(9)NULL,
    fname VARCHAR(30)NOT NULL,
    lname VARCHAR(30)NOT NULL,
    brnCode VARCHAR(6) NOT NULL,
    PRIMARY KEY(clientNum)
);
CREATE TABLE LOAN(
    bnkNam VARCHAR(30) NOT NULL,
    brnCode VARCHAR(6) NOT NULL,
    clientNum VARCHAR(12) NOT NULL,
    balance DECIMAL(10,2)NULL,
    loaNum VARCHAR(8) NOT NULL,
    PRIMARY KEY(loaNum)
);
CREATE TABLE HOUSE(
    loaNum VARCHAR(8) NOT NULL,
    amount DECIMAL(10,2) NULL,
    lnDate DATE NULL,
    address VARCHAR(30)NULL,
    amortization VARCHAR (35)NULL,
    PRIMARY KEY(loaNum)
);
CREATE TABLE STUDENT (
    loanNum VARCHAR(8) NOT NULL,
    amount DECIMAL(10,2) NULL,
    lnDate DATE NULL,
    gradYear DATE NULL,
    PRIMARY KEY (loanNum)
);
CREATE TABLE CAR(
    loanNum VARCHAR(8) NOT NULL,
    regAmount DECIMAL(10,2) NULL,
    regDate DATE NULL,
    model VARCHAR(6) NULL,
    PRIMARY KEY(loanNum, model)
);
CREATE TABLE CREDIT_CARD(
    loaNum VARCHAR(8) NOT NULL,
    revLimit DECIMAL(10,2) NULL,
    ccNum VARCHAR(20),
    expiry Date NOT NULL,
    PRIMARY KEY(ccNum,expiry)
);
CREATE TABLE LINE_OF_CREDIT(
    loaNum VARCHAR(8) NOT NULL,
    revLimit DECIMAL(10,2) NULL,
    line_of_credit DECIMAL NOT NULL,
    PRIMARY KEY(loaNum,line_of_credit)
);
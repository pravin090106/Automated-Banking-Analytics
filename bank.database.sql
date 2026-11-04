CREATE DATABASE banking_db;
USE banking_db;

CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50),
    city VARCHAR(30),
    state VARCHAR(30)
);

INSERT INTO branches VALUES
(1,'Coimbatore Main','Coimbatore','Tamil Nadu'),
(2,'Chennai Central','Chennai','Tamil Nadu'),
(3,'Madurai Main','Madurai','Tamil Nadu'),
(4,'Salem Branch','Salem','Tamil Nadu'),
(5,'Bengaluru Central','Bengaluru','Karnataka'),
(6,'Erode Branch','Erode','Tamil Nadu'),
(7,'Trichy Branch','Trichy','Tamil Nadu'),
(8,'Tiruppur Branch','Tiruppur','Tamil Nadu');

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(30),
    occupation VARCHAR(40),
    registration_date DATE,
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

INSERT INTO customers VALUES
(1001,'Arun Kumar','Male','1988-04-12','Coimbatore','Engineer','2020-01-10',1),
(1002,'Priya Sharma','Female','1992-08-25','Chennai','Teacher','2020-02-15',2),
(1003,'Rahul Verma','Male','1985-11-03','Bengaluru','Manager','2020-03-05',5),
(1004,'Divya Raj','Female','1995-01-17','Madurai','Designer','2020-04-12',3),
(1005,'Karthik S','Male','1979-06-20','Salem','Business','2020-05-20',4),
(1006,'Sneha R','Female','1998-09-14','Chennai','Analyst','2020-06-18',2),
(1007,'Vijay Anand','Male','1975-12-30','Trichy','Business','2020-07-01',7),
(1008,'Meena Devi','Female','1989-05-09','Coimbatore','Nurse','2020-08-14',1),
(1009,'Suresh B','Male','1968-03-22','Erode','Retired','2020-09-10',6),
(1010,'Anitha M','Female','1994-10-11','Tiruppur','Teacher','2020-10-05',8),
(1011,'Mohamed Irfan','Male','1987-07-19','Chennai','Business','2021-01-08',2),
(1012,'Lakshmi P','Female','1972-02-28','Madurai','Doctor','2021-02-20',3),
(1013,'Gokul K','Male','1991-12-06','Salem','Engineer','2021-03-15',4),
(1014,'Nandhini S','Female','1984-04-16','Bengaluru','HR Manager','2021-04-10',5),
(1015,'Manoj Kumar','Male','1970-09-27','Coimbatore','Business','2021-05-18',1),
(1016,'Harini V','Female','2001-01-05','Erode','Student','2021-06-25',6),
(1017,'Dinesh R','Male','1965-06-13','Chennai','Retired','2021-07-14',2),
(1018,'Pooja N','Female','1997-11-21','Tiruppur','Developer','2021-08-09',8),
(1019,'Santhosh K','Male','1982-03-08','Madurai','Business','2021-09-17',3),
(1020,'Keerthana A','Female','1990-07-15','Coimbatore','Accountant','2021-10-21',1);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    opening_date DATE,
    balance DECIMAL(12,2),
    account_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO accounts VALUES
(20001,1001,'Savings','2020-01-10',85000,'Active'),
(20002,1002,'Savings','2020-02-15',120000,'Active'),
(20003,1003,'Current','2020-03-05',450000,'Active'),
(20004,1004,'Savings','2020-04-12',65000,'Active'),
(20005,1005,'Current','2020-05-20',280000,'Active'),
(20006,1006,'Savings','2020-06-18',92000,'Active'),
(20007,1007,'Current','2020-07-01',350000,'Active'),
(20008,1008,'Savings','2020-08-14',73000,'Active'),
(20009,1009,'Savings','2020-09-10',185000,'Active'),
(20010,1010,'Savings','2020-10-05',54000,'Active'),
(20011,1011,'Current','2021-01-08',315000,'Active'),
(20012,1012,'Savings','2021-02-20',240000,'Active'),
(20013,1013,'Savings','2021-03-15',98000,'Active'),
(20014,1014,'Savings','2021-04-10',175000,'Active'),
(20015,1015,'Current','2021-05-18',520000,'Active'),
(20016,1016,'Savings','2021-06-25',18000,'Active'),
(20017,1017,'Savings','2021-07-14',210000,'Dormant'),
(20018,1018,'Savings','2021-08-09',76000,'Active'),
(20019,1019,'Current','2021-09-17',390000,'Active'),
(20020,1020,'Savings','2021-10-21',145000,'Active'),
(20021,1001,'Fixed Deposit','2023-01-10',150000,'Active'),
(20022,1002,'Fixed Deposit','2023-03-15',200000,'Active'),
(20023,1005,'Fixed Deposit','2023-06-20',300000,'Active'),
(20024,1015,'Fixed Deposit','2023-09-18',250000,'Active');

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(12,2),
    transaction_mode VARCHAR(20),
    transaction_status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO transactions VALUES
(30001,20001,'2024-01-02','Credit',25000,'UPI','Success'),
(30002,20001,'2024-01-05','Debit',5000,'ATM','Success'),
(30003,20002,'2024-01-03','Credit',40000,'NEFT','Success'),
(30004,20002,'2024-01-08','Debit',8500,'UPI','Success'),
(30005,20003,'2024-01-10','Credit',125000,'NEFT','Success'),
(30006,20003,'2024-01-15','Debit',35000,'Cheque','Success'),
(30007,20004,'2024-01-12','Credit',18000,'UPI','Success'),
(30008,20004,'2024-01-20','Debit',4500,'ATM','Success'),
(30009,20005,'2024-01-05','Credit',90000,'NEFT','Success'),
(30010,20005,'2024-01-18','Debit',22000,'Cheque','Success'),
(30011,20006,'2024-02-01','Credit',30000,'UPI','Success'),
(30012,20006,'2024-02-05','Debit',7000,'ATM','Success'),
(30013,20007,'2024-02-03','Credit',150000,'NEFT','Success'),
(30014,20007,'2024-02-09','Debit',45000,'Cheque','Success'),
(30015,20008,'2024-02-06','Credit',22000,'UPI','Success'),
(30016,20008,'2024-02-12','Debit',3000,'ATM','Success'),
(30017,20009,'2024-02-08','Credit',35000,'NEFT','Success'),
(30018,20009,'2024-02-15','Debit',9000,'UPI','Success'),
(30019,20010,'2024-02-10','Credit',18000,'UPI','Success'),
(30020,20010,'2024-02-17','Debit',2500,'ATM','Success'),
(30021,20011,'2024-03-01','Credit',85000,'NEFT','Success'),
(30022,20011,'2024-03-05','Debit',17000,'Cheque','Success'),
(30023,20012,'2024-03-03','Credit',60000,'NEFT','Success'),
(30024,20012,'2024-03-10','Debit',12500,'UPI','Success'),
(30025,20013,'2024-03-06','Credit',25000,'UPI','Success'),
(30026,20013,'2024-03-14','Debit',6500,'ATM','Failed'),
(30027,20014,'2024-03-08','Credit',45000,'NEFT','Success'),
(30028,20014,'2024-03-16','Debit',12000,'UPI','Success'),
(30029,20015,'2024-03-12','Credit',175000,'NEFT','Success'),
(30030,20015,'2024-03-20','Debit',50000,'Cheque','Success'),
(30031,20016,'2024-04-01','Credit',8000,'UPI','Success'),
(30032,20016,'2024-04-05','Debit',2000,'ATM','Success'),
(30033,20017,'2024-04-02','Credit',15000,'NEFT','Success'),
(30034,20018,'2024-04-04','Credit',28000,'UPI','Success'),
(30035,20018,'2024-04-12','Debit',6000,'ATM','Success'),
(30036,20019,'2024-04-08','Credit',110000,'NEFT','Success'),
(30037,20019,'2024-04-18','Debit',30000,'Cheque','Success'),
(30038,20020,'2024-04-10','Credit',40000,'UPI','Success'),
(30039,20020,'2024-04-20','Debit',7500,'UPI','Success'),
(30040,20001,'2024-05-01','Debit',12000,'UPI','Success'),
(30041,20002,'2024-05-03','Credit',30000,'NEFT','Success'),
(30042,20003,'2024-05-05','Debit',45000,'Cheque','Success'),
(30043,20005,'2024-05-08','Credit',50000,'NEFT','Success'),
(30044,20010,'2024-05-10','Debit',3500,'ATM','Success'),
(30045,20015,'2024-05-12','Credit',100000,'NEFT','Success');

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(30),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_date DATE,
    loan_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO loans VALUES
(4001,1001,'Home Loan',2500000,8.50,'2022-01-15','Active'),
(4002,1002,'Personal Loan',400000,11.50,'2023-02-10','Active'),
(4003,1003,'Business Loan',1500000,10.25,'2021-08-05','Active'),
(4004,1004,'Education Loan',600000,7.90,'2022-06-20','Closed'),
(4005,1005,'Business Loan',2000000,10.75,'2021-04-15','Active'),
(4006,1006,'Personal Loan',300000,12.00,'2023-09-01','Active'),
(4007,1007,'Home Loan',3500000,8.25,'2020-12-10','Active'),
(4008,1008,'Vehicle Loan',700000,9.50,'2023-01-20','Active'),
(4009,1010,'Education Loan',450000,8.10,'2022-07-18','Closed'),
(4010,1011,'Personal Loan',500000,11.75,'2023-03-12','Active'),
(4011,1012,'Home Loan',2800000,8.40,'2021-11-05','Active'),
(4012,1014,'Vehicle Loan',900000,9.25,'2023-05-15','Active'),
(4013,1015,'Business Loan',1800000,10.50,'2022-03-20','Active'),
(4014,1018,'Personal Loan',250000,12.25,'2024-01-10','Active'),
(4015,1019,'Home Loan',3200000,8.35,'2021-09-10','Active');

show tables;

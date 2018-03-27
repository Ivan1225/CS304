--
-- 	Database Table Creation
--
--		This file will create the tables for use with the book 
--  Database Management Systems by Raghu Ramakrishnan and Johannes Gehrke.
--  It is run automatically by the installation script.
--
--	Version 0.1.0.0 2002/04/05 by: David Warden.
--	Copyright (C) 2002 McGraw-Hill Companies Inc. All Rights Reserved.
--
--  First drop any existing tables. Any errors are ignored.
--
drop table Employee cascade constraints;
drop table Restock cascade constraints;
drop table Deal cascade constraints;
drop table Manage cascade constraints;
drop table product_discount cascade constraints;
drop table Food cascade constraints;
drop table Beverage cascade constraints;
drop table PersonalCare cascade constraints;
drop table Access_to cascade constraints;
drop table Customer cascade constraints;

drop table Contains cascade constraints;
drop table Shipping_Info cascade constraints;

drop table Order_placedby_shippedwith cascade constraints;
drop table owns cascade constraints;

--
-- Now, add each table.
--

create table Employee(
	Employee_ID varchar2(30) primary key,
	sin integer
	);

create table Restock(
	Employee_ID varchar2(7),
	Product_ID varchar2(5),
	primary key(Employee_ID,Product_ID),
	foreign key(Employee_ID) references Employee
	);


CREATE TABLE Deal
(shared_link varchar2(40),
start_date date,
end_date date,
DID varchar2(5),
discount varchar2(10),
Premium_only varchar2(1),
PRIMARY KEY (DID)
);

create table Manage(
	Deal_ID varchar2(5),
	Employee_ID varchar2(7),
	primary key (Deal_ID, Employee_ID),
	FOREIGN KEY (Deal_ID) REFERENCES Deal,
	foreign key (Employee_ID) references Employee
	);

CREATE TABLE product_discount
(PID varchar2(5) not null,
DID varchar2(5),
expire_date date, 
price DOUBLE precision not null,
Ingredients varchar2(200),
origin varchar2(20), 
stock_quantity INTEGER not null, 
description varchar2(100), 
carbon_footprint DOUBLE precision, 
reward_points INTEGER,
PRIMARY KEY (PID),
FOREIGN KEY (DID) REFERENCES Deal
);


CREATE TABLE Food(
	PID varchar2(5),
Weight DOUBLE precision,
Allergies varchar2(100),
PRIMARY KEY (PID),
FOREIGN KEY (PID) REFERENCES product_discount
);

CREATE TABLE Beverage
(PID varchar2(5),
Volume DOUBLE precision,
Allergies varchar2(100),
PRIMARY KEY (PID),
FOREIGN KEY (PID) REFERENCES product_discount
	);

CREATE TABLE PersonalCare
(PID varchar2(5),
instruction varchar2(50),
PRIMARY KEY (PID),
FOREIGN KEY (PID) REFERENCES product_discount
);


CREATE TABLE Customer
(Name varchar2(20),
Email varchar2(40),
Reward_Points INTEGER,
Premium varchar2(1),
Account_no varchar2(5), 
PRIMARY KEY(Account_no)
);

CREATE TABLE Access_to
(DID varchar2(5),
Account_no varchar2(5),
PRIMARY KEY (DID,Account_no),
FOREIGN KEY (DID) REFERENCES Deal,
FOREIGN KEY (Account_no) REFERENCES Customer
);



CREATE TABLE Shipping_info
(delivery_type varchar2(10),
 Billing_address varchar2(50),
 Shipping_address varchar2(50),
 Shipping_method varchar2(10),
 Phone_number INTEGER,
 Shipping_info_no varchar2(6),
PRIMARY KEY(Shipping_info_no)
);

CREATE TABLE Order_placedby_shippedwith
(order_no varchar2(7), 
order_date date, 
Free_shipping varchar2(1), 
Status varchar2(10), 
Order_total DOUBLE precision,
Payment_method varchar2(10),
Poins_awarded INTEGER,
Account_no varchar2(5) NOT NULL,
Shipping_info_no varchar2(6) NOT NULL,
PRIMARY KEY (order_no),
FOREIGN KEY (Account_no) REFERENCES Customer,
FOREIGN KEY (shipping_info_no) REFERENCES Shipping_Info
);


CREATE TABLE Contains
(PID varchar2(5),
  order_no varchar2(7),
PRIMARY KEY (PID,order_no),
FOREIGN KEY (PID) REFERENCES product_discount,
FOREIGN KEY (order_no) REFERENCES Order_placedby_shippedwith
);


CREATE TABLE owns
(Account_no varchar2(5),
Shipping_info_no varchar2(6),
PRIMARY KEY (Account_no, Shipping_info_no),
FOREIGN KEY (Account_no) REFERENCES Customer,
FOREIGN KEY (Shipping_info_no) REFERENCES Shipping_Info
);










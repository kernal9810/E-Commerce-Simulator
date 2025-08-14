DROP database Amazon;
show databases;

create database Amazon;
use Amazon;
show tables;

CREATE TABLE Customers (
    CustomerId int not NULL AUTO_increment,
    PhoneNumber int NOT NULL,
    cname varchar(20),
    PRIMARY KEY (CustomerId));
CREATE TABLE Seller (
    SellerId int not NULL AUTO_INCREMENT,
    PhoneNumber int NOT NULL,
    sname varchar(20),
    PRIMARY KEY (SellerId));
CREATE TABLE Items (
    ItemId int not NULL auto_increment,
	ItemName varchar(20) NOT NULL,
    catergory varchar(20),
    PRIMARY KEY (ItemId));
CREATE TABLE SellerInventory (
	SellerId int not NULL,
    ItemId int not NULL,
    ItemName varchar(20) NOT NULL,
    Price int not NULL,
    Quantity int not NULL,
    PRIMARY KEY(SellerId,ItemId),
    Constraint FK_three FOREIGN KEY (ItemId) REFERENCES Items(ItemId)
    On Update Cascade
    On Delete Cascade,
    Constraint FK_four FOREIGN KEY (SellerId) REFERENCES Seller(SellerID)
    On Update Cascade
    On Delete Cascade);
CREATE TABLE NotStock (
    ItemId int not NULL,
    instockdate date,
    PRIMARY KEY (ItemId),
    Constraint FK_One FOREIGN KEY (ItemId) REFERENCES Items(ItemId) 
    On Update Cascade
    On Delete Cascade
    );
Create TABLE InStock (
	ItemId int not NULL,
    quantity int not NULL,
    PRIMARY KEY (ItemId),
	Constraint FK_two FOREIGN KEY (ItemId) REFERENCES Items(ItemId)
    On Update Cascade
    On Delete Cascade
    );
Create Table Payment (
	CustomerId int not NULL,
    Pmode varchar(10) not NULL,
    details varchar(20),
    PRIMARY KEY(CustomerId,Pmode),
    Constraint FK_seven FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId)
    On Update Cascade
    On Delete Cascade);
Create Table CustomerLocation (
	CustomerId int not NULL,
    Flatno int not NULL,
    Street varchar(20),
    State varchar(20),
    Primary Key(CustomerId,Flatno),
    Constraint FK_eight FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId)
    On Update Cascade
    On Delete Cascade);
Create Table SellerLocation (
	SellerId int not NULL,
    Factoryno int,
    Street varchar(20),
    State varchar(20),
    Primary Key(SellerId,Factoryno),
    Constraint FK_nine FOREIGN KEY(SellerId) REFERENCES Seller(SellerId)
    On Update Cascade
    On Delete Cascade);

Create TABLE Bill (
	BillId int not NULL auto_increment,
    SellerId int not NULL,
    ItemId int not NULL,
    Quantity int not NULL,
    price int not NULL,
    CustomerId int not NULL,
    PRIMARY KEY(BillId),
    Constraint FK_six FOREIGN KEY (SellerId) REFERENCES SellerInventory(SellerId),
    Constraint FK_ff FOREIGN KEY (CustomerId) REFERENCES Payment(CustomerId),
    Constraint FK_ll FOREIGN KEY (ItemId) REFERENCES InStock(ItemId)
);
DROP TABLE DeliverTo;
Create Table DeliverTo (
	SellerId int not NULL,
    CustomerId int not NULL,
    BillId int not NULL,
    Flatno int,
    Factoryno int,
    Primary Key(BillId),
    Constraint FK_ten FOREIGN KEY(BIllId) REFERENCES Bill(BillId),
    Constraint Fk_Sell FOREIGN KEY (SellerId,Factoryno) References SellerLocation(SellerId,Factoryno),
    Constraint Fk_Buy FOREIGN KEY (CustomerId,Flatno) References CustomerLocation(CustomerId,Flatno)
    );

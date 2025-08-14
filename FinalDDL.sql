DROP database Amazon;
show databases;

create database Amazon;
use Amazon;
show tables;

CREATE TABLE Customers (
    CustomerId int not NULL,
    PhoneNumber int NOT NULL,
    cname varchar(20),
    PRIMARY KEY (CustomerId));

CREATE TABLE Items (
    ItemId int not NULL,
    Price int NOT NULL,
    catergory varchar(20),
    PRIMARY KEY (ItemId));
    
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
    CustomerId int not Null,
    quantity int not NULL,
    PRIMARY KEY (CustomerId,ItemId),
	Constraint FK_two FOREIGN KEY (ItemId) REFERENCES Items(ItemId)
    On Update Cascade
    On Delete Cascade,
    Constraint FK_ctwo FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
    On Update Cascade
    On Delete Cascade
    );
CREATE TABLE Seller (
    SellerId int not NULL,
    PhoneNumber int NOT NULL,
    sname varchar(20),
    PRIMARY KEY (SellerId));

CREATE TABLE SellerInventory (
	SellerId int not NULL,
    ItemId int not NULL,
    Quantity int not NULL,
    PRIMARY KEY(SellerId,ItemId),
    Constraint FK_three FOREIGN KEY (ItemId) REFERENCES InStock(ItemId)
    On Update Cascade
    On Delete Cascade,
    Constraint FK_four FOREIGN KEY (SellerId) REFERENCES Seller(SellerID)
    On Update Cascade
    On Delete Cascade);
    
Create Table Payment (
	CustomerId int not NULL,
    Pmode varchar(10) not NULL,
    details varchar(20),
    PRIMARY KEY(CustomerId,Pmode),
    Constraint FK_seven FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId)
    On Update Cascade
    On Delete Cascade);
    
Create TABLE Bill (
	OrderId int not NULL,
    SellerId int not NULL,
    Quantity int not NULL,
    price int not NULL,
    CustomerId int not NULL,
    PRIMARY KEY(OrderId),
    Constraint FK_six FOREIGN KEY (SellerId) REFERENCES SellerInventory(SellerId),
    Constraint FK_ff FOREIGN KEY (CustomerId) REFERENCES Payment(CustomerId)
    );


Create Table CustomerLocation (
	CustomerId int not NULL,
    Flatno int,
    Street varchar(20),
    State varchar(20),
    Primary Key(CustomerId),
    Constraint FK_eight FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId)
    On Update Cascade
    On Delete Cascade);

Create Table SellerLocation (
	SellerId int not NULL,
    Factoryno int,
    Street varchar(20),
    State varchar(20),
    Primary Key(SellerId),
    Constraint FK_nine FOREIGN KEY(SellerId) REFERENCES Seller(SellerId)
    On Update Cascade
    On Delete Cascade);

Create Table DeliverTo (
	SellerId int not NULL,
    CustomerId int not NULL,
    OrderId int not NULL,
    Primary Key(OrderId),
    Constraint FK_ten FOREIGN KEY(OrderId) REFERENCES Bill(OrderId),
    Constraint Fk_Sell FOREIGN KEY (SellerId) References SellerLocation(SellerId),
    Constraint Fk_Buy FOREIGN KEY (CustomerId) References CustomerLocation(CustomerId)
    ); 

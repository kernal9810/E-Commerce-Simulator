use Amazon;

Select c.ItemId,c.Price,c.Catergory 
from Items c, NotStock 
where c.ItemId = NotStock.ItemId;


UPDATE Customers SET PhoneNumber=1, cname= 'killbill'
WHERE CustomerId=0;

ALTER TABLE Customers
ADD DOB date;

DELETE FROM Customers WHERE CustomerId < 10;

INSERT INTO Bill
VALUES (222,112,10,99,100);

SELECT Items.ItemId, Customers.cname, Items.Price
FROM Items
INNER JOIN Customers ON
Items.ItemId = Customers.CustomerId;

CREATE VIEW delivery AS
SELECT c.cname,d.OrderId,d.SellerId
FROM Customers c,DeliverTo d
WHERE d.CustomerId=c.CustomerId;

CREATE Table paa AS
SELECT Bill.SellerId, Bill.price
FROM Bill
WHERE Bill.price > (SELECT AVG(price) FROM Bill);


Select ItemId from Items Union Select ItemId from InStock;

SELECT * FROM Customers
LEFT JOIN Bill
ON Bill.CustomerId=Customers.CustomerId;




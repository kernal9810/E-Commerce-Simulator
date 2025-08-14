use Amazon;

-- 1----
UPDATE Customers SET PhoneNumber=1, cname= 'killbill'
WHERE CustomerId=0;
-- 2---
ALTER TABLE Customers
ADD DOB date;
-- 3---
DELETE FROM Customers WHERE CustomerId < 10;
-- 4---
select a.CustomerId, a.ItemId from (select ItemId,CustomerId from Bill where CustomerId= "1" ) a
inner join (select ItemId, COUNT(*) from Bill where CustomerId= 1 group by ItemId) b on a.ItemId = b.ItemId;

-- 5---
Select SellerId, ItemId, sum(Quantity) qty from  SellerInventory group by SellerId, ItemId
union all select SellerId, null, sum(Quantity) qty from SellerInventory
group by SellerId
union all select null, ItemId, sum(Quantity) qty from SellerInventory group by ItemId
union all select null,null, sum(Quantity) qty from SellerInventory;

-- finds total amount of items followed by total amount of each item followed by total quantity of all items
-- 6---
CREATE VIEW payingway AS
SELECT c.cname,d.OrderId,d.SellerId
FROM Customers c,DeliverTo d
WHERE d.CustomerId=c.CustomerId;

-- 7---
CREATE Table paa AS
SELECT Bill.SellerId, Bill.price
FROM Bill
WHERE Bill.price > (SELECT AVG(price) FROM Bill);
DROP TABLE paa;
select * from paa;

-- 8--- tells amount of times a customer ordered
select CustomerId, count(*) from Bill a inner join Items b on b.ItemId=a.ItemId
group by CustomerId having count(*) order by count(*) desc;

-- 9--- Customers who have ordered atleat once
select CustomerId,cname from Customers
where exists(select 1 from Bill where Bill.CustomerId = Customers.CustomerId);

-- 10---
Select Sum(total_price) 
from (Select ItemId,Quantity,price,Bill.price*Bill.Quantity AS total_price from Bill where CustomerId=1) AS t; 


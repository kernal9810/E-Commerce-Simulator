----INDEXING-----------------
create INDEX IX_Customers_CustomerId
ON Customers (CustomerId ASC);

create index IX1_Seller_SellerId
on Seller (SellerId ASC);

create index IX2_Items_ItemId
on Items (ItemId ASC);

create index IX3_Bill_OrderId
on Bill (BillId ASC);

create index IX4_CustomerLocation_CustomerId
on CustomerLocation (CustomerId ASC);

create index IX5_SellerLocation_SellerId
on SellerLocation (SellerId ASC);
----------------------------------

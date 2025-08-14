-- 1--- Finds deal of the day aggregate function
select Items.Itemname,a.ItemId,a.SellerId,a.Price
From Items INNER JOIN(Select ItemId,SellerId,Price from SellerInventory f 
where Price=(Select Min(price) from SellerInventory where ItemId =f.ItemId group by ItemId)) a 
ON  a.ItemId=Items.ItemId;
-- 2--- Find Most Frequently sold items of a seller
Select a.ItemId,a.Itemname from Items a INNER JOIN(select count(*),ItemId from Bill where SellerId=1 group by ItemId ) b ON a.Itemid=b.ItemId;
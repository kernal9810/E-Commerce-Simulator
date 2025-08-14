--- Views--
create view delivery as select d.CustomerId,d.SellerId,a.Street,a.State 
from DeliverTo d INNER JOIN SellerLocation a ON a.SellerId =d.SellerId;

Create view deals as select Items.Itemname,a.ItemId,a.SellerId,a.Price
From Items INNER JOIN(Select ItemId,SellerId,Price from SellerInventory f 
where Price=(Select Min(price) from SellerInventory where ItemId =f.ItemId group by ItemId)) a 
ON  a.ItemId=Items.ItemId;

create view pending as select d.CustomerId,d.SellerId,a.Street,a.State 
from DeliverTo d INNER JOIN CustomerLocation a ON a.CustomerId =d.CustomerId;

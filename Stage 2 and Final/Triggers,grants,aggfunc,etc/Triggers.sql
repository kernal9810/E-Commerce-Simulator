-- TRIGGERS FOR DATATBASE
Delimiter $$
Create Trigger Add_Item 
BEFORE INSERT ON SellerInventory
FOR EACH ROW
begin
Declare itemcount int;
Declare instock int;
Select count(*) from Items where ItemId=new.ItemId into itemcount;
Select count(*) from InStock where ItemId=new.ItemId into instock;
If itemcount > 0 then
	If instock>0 then
    Update InStock set quantity=quantity+new.Quantity where ItemId=new.ItemId;
    else
    Insert into Instock Values(new.ItemId,new.Quantity);
    Delete from NotStock where ItemId=new.ItemId;
    END IF;
else
	Insert Into Items values (new.ItemId,new.ItemName,"NA");
    Insert Into Instock values (new.ItemId,new.Quantity);
End If;
end$$
Delimiter ;

Delimiter $$
Create Trigger Sell_Item 
after Update ON SellerInventory
FOR EACH ROW
begin
declare sellercount int;
select count(Quantity) from SellerInventory where ItemId=new.ItemId into sellercount;   
if sellercount=old.Quantity-new.Quantity then
	delete from InStock where ItemId=new.ItemId;
    insert into NotStock (ItemId) values (new.ItemId);
else 
	update Instock set quantity=quantity-old.Quantity+new.Quantity where ItemId=old.ItemId;
End if;
end $$
Delimiter ;

Delimiter $$
Create Trigger Billing 
after Insert ON Bill
FOR EACH ROW
begin
	Update SellerInventory set quantity = quantity-new.Quantity where ItemId=new.ItemId and SellerId=new.SellerID;
end $$
Delimiter ;


DROP Trigger delivery;
Delimiter $$
Create Trigger delivery
after Insert on Bill
FOR EACH ROW
begin
	Insert into DeliverTo values(new.SellerId,new.CustomerId,new.BillId,(Select Flatno From CustomerLocation where CustomerId=new.CustomerId LIMIT 1),(Select Factoryno from SellerLocation where SellerId=new.SellerId LIMIT 1));
end$$
Delimiter ;



--- GRANTSSSSSSSSSSs-------------------
GRANT ALL PRIVILEGES ON amazon.* TO 'deeptanshu'@'localhost';


CREATE USER 'Customers'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
Grant select on SellerInventory to Customers@localhost;
GRANT select on Items to Customers@localhost;
Grant Insert on Bill to Customers@localhost;
Grant select on BIll to Customers@localhost;
Grant select on CustomerLocation to Customers@localhost;
Grant select on Payment to Customers@localhost;
Grant select on Delivery to Customers@localhost;
Grant select on deals to Customers@localhost; 
Grant ALL PRIVILEGES on Payment to Customers@localhost;
Grant ALL PRIVILEGES ON CustomerLocation to Customers@localhost;
GRANT ALL PRIVILEGES ON InStock to Customers@localhost;
GRANT ALL PRIVILEGES ON Items to Customers@localhost;
GRANT ALL PRIVILEGES ON NotStock to Customers@localhost;

Drop User Seller@localhost;
CREATE USER 'Seller'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
Grant ALL PRIVILEGES ON SellerLocation to Seller@localhost;
Grant select on Bill to Seller@localhost;
Grant ALL PRIVILEGES ON SellerInventory to Seller@localhost;
GRANT ALL PRIVILEGES ON SellerLocation to Seller@localhost;
GRANT SELECT ON DeliverTo to Seller@localhost;
GRANT UPDATE ON DeliverTo to Seller@localhost;
GRANT SELECT ON pending to Seller@localhost;
GRANT SELECT ON Items to Seller@localhost;
# E-Commerce-Simulator

Scope of Project- The scope of this project is to understand fundamental of DBMS. In this project we are going to learn and experiment with ER- diagram and its conversion into Relational Scheme, creating a Logical Database Design and the valid constraints that arise in them. We will also learn about the how-to identity the Weak Identities, relationship orles and constraints and also how to define Entities with underlined Primary Key and establish relation with in them.

<img width="1563" height="950" alt="image" src="https://github.com/user-attachments/assets/e81837e5-358e-4fef-b802-4c8ace0496db" />


<img width="1481" height="1241" alt="image" src="https://github.com/user-attachments/assets/cbdd66ad-789c-42c9-b7d0-4b96b6ac84f6" />



Stakeholders- In our project we have choose CUSTOMERS, SELLERS, ORDER as the stakeholders.
Entities Defined with Underlined Primary Key- 
1.	CUSTOMERS (CUSTOMER ID    int NOT NULL, customer_name   char NOT NULL, customer_phone_number    int NOT NULL)
2.	CUSTOMER LOCATION (CUSTOMER ID    int NOT NULL, street char, Flat No. int, City/State char)
3.	DELIVER TO (ORDER ID    char NOT NULL, CUSTOMER_ID   char NOT NULL,
 SELLER_ID    char NOT NULL)
4.	SELELR LOCATION (SELLER ID    int NOT NULL, Street char, factory No.   int, Street    char)
5.	SELLER (SELLER ID     int NOT NULL, Seller_Phone_Number    int NOT NULL, 
Seller_Name   char NOT NULL)
6.	SELLER INVENTORY (SELLER ID     int NOT NULL, ITEM ID       int NOT NULL, Quantity     int NOT NULL)
7.	BILL (ODER ID     int NOT NULL, SELLER ID     int NOT NULL, CUSTOMER ID    int NOT NULL, Price    int NOT NULL, Quantity      int NOT NULL)
8.	CUSTOMER PAYMENT MODE (CUSTOEMR ID        int NOT NULL, MODE     char NOT NULL, Details     char)
9.	IN STOCK (CUSTOMER ID   int NOT NULL, ITEM_ID  int NOT NULL, Quantity int NOT NULL)
10.	NOT IN STOCK (ITEM ID      int NOT NULL, expected IN-STOCK date      char)
11.	ITEMS (ITEMS ID       char NOT NULL, Category   char, Price   int NOT NULL)
Relationship Established-
1.	CUSTOMER-ORDER-CHECK STOCK – This is the case of ONE-TO-MANY relationship. Because one person can do many orders of many things.
2.	CUTOMER-LIVES IN – This is the case of ONE-ONE relationship because a person only lives at one location.
3.	CUSTOMER-Payment Info-CUSTOMER PAYMENT MODE – This is the case of 
ONE-TO-MANY as one person can have many modes of payment like COD, wallet, card.
4.	IN STOCK-ITEM PROVIDER- SELELR INVENTORY – This is the case ONE-TO-MANY relationship. Because one item can be present in many sellers inventory.


Weak Entity: 
1.	LIVES IN- It is a weak entity because without the presence of a CUSTOMER there will be no customer location. And because of no presence of CUSTOMER there will be no primary key attribute (CUSTOMER ID).
2.	SELLS IN- It is a weak entity because without the presence of a customer there will be no seller location. And because of not the presence of SELLER there will be no primary key attribute (SELLER ID).
3.	Payment Info- It is a weak entity because without the presence of a CUSTOMER there will be no customer payment info. And because of no presence of CUSTOMER there will be no primary key attribute (CUSTOMER ID).
Entities participation type-
1.	Total Participation: 
a.	LIVES IN-CUSTOMER LCOATION
b.	PAYMENT AND DELIVERY- BILL
c.	SELLS IN- SELLER LOCATION
d.	IN STOCK- ITEM PROVIDER
e.	SELELR INVENTORY- SELLS
f.	Payment info- CUSTOMER PAYMENT MODE
g.	Check Stock- IN STOCK
h.	Check Stock- IN STOCK
2.	Partial Participation:
a.	CUSTOEMR-ORDER
b.	ORDER-ITEMS
c.	OREDER-CHECK STOCK
d.	ITEM PROVIDER- SELLER INVENTORY
e.	BILLING-SELELR INVENTORY
f.	BILLING- BILL
g.	SELLS- SELELR
h.	SELLER- SELLS IN
i.	SELLER LOCATION-DELIVER TO
j.	DELIVER TO- CUSTOMER LOCATION
Relationship constraints-
1.	Each customer can have only one customer location.
2.	Each seller can have only one seller location.
3.	Items in NotStock are not present in InStock table.
4.	Delivery does not take place between every customer location and seller location.
Identified ternary relationship- In our project we have 2 ternary relationships:
1.	ITEM PROVIDER (Bill, ITEM PROVIDER, SELELR INVENTORY) - We choose this as ternary relationship because when a customer first searches for the product that he or she wants it is checked whether it is present in the seller inventory or not. If it is present and the customer buys it then there is bill generated. As item provider can only star delivery process of product to customer after bill generation and also keeping in mind that the product is present in the seller inventory.
2.	PAYMENT AND DELIVERY (Deliver to, PAYMENT AND DELIVERY, Bill)- We choose this as ternary relationship because of the customer payment mode and details provided by the customer a Bill is generated and it is forwarded to both Deliver team and item provider. As item provider needs Bill to inform the seller that the Bill has been generated and they can start processing the item. And delivery team also needs a payment info. So that they can start packing the item and get the necessary things for delivery. Like if a customer has chosen to pay COD, then the delivery has to be equipped to handle with those situations in advanced which can only happen if they know about customers payment info. 

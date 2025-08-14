import mysql.connector as sql;
import streamlit as st;
import pandas as pd;
from streamlit import caching
def csignup(cursor):
    phone = st.sidebar.text_input("Phone", max_chars=15)
    user_name = st.sidebar.text_input("username", max_chars=255)
    if st.sidebar.button("SignUp"):
        cursor.execute("Insert into Customers (PhoneNumber,cname) Values ("+phone+", '"+user_name+"');")
        db.commit()
        st.success("REGISTERED")
def ssignup(cursor):
    phone = st.sidebar.text_input("Phone", max_chars=15)
    user_name = st.sidebar.text_input("username", max_chars=255)
    if st.sidebar.button("SignUp"):
        cursor.execute("Insert into Seller (PhoneNumber,sname) Values ("+phone+", '"+user_name+"');")
        db.commit()
        st.success("REGISTERED")
def clogin():
    phone = st.sidebar.text_input("Phone", max_chars=15)
    user_name = st.sidebar.text_input("username", max_chars=255)
    if st.sidebar.button("login"):
        print("Select * from Customers where cname=%s and PhoneNumber = %s;",(user_name,phone))
        cursor.execute("Select * from Customers where cname=%s and PhoneNumber = %s;",(user_name,phone))
        answer=cursor.fetchone()
        if answer:
            st.success("Login Successfull")
            f=open("cache.txt","w")
            f.write(str(answer[0]))
            f.close()
            print("writing done")
        else:
            st.info("Wrong Credentials")
def slogin():
    phone = st.sidebar.text_input("Phone", max_chars=15)
    user_name = st.sidebar.text_input("username", max_chars=255)
    if st.sidebar.button("login"):
        cursor.execute("Select * from Seller where sname=%s and PhoneNumber = %s;",(user_name,phone))
        answer=cursor.fetchone()
        if answer:
            st.success("Login Successfull")
            f=open("cache.txt","w")
            f.write(str(answer[0]))
            f.close()
            print("writing done")
        else:
            st.info("Wrong Credentials")
def cdashboard(cid):
    db = sql.connect(
    host = "127.0.0.1",
    user = "Customers",
    passwd = "password",
    database = "amazon",
    auth_plugin="mysql_native_password"
    )
    cursor=db.cursor()
    qq=["None","ViewItems","ViewOrders","ViewAddress","ViewPaymentmethods","Add/modifyAddress","AddPayment","viewDeliveryStatus","SalesOftheDay"]
    newq=st.selectbox("What to do ?",qq)
    if newq=="ViewItems":
        cursor.execute("Select * From Items where ItemId in (select ItemId from Instock);")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["ItemId","Price","catergory"])
        st.dataframe(table)
        with st.form(key="orders"):
            selected=st.selectbox("Select Items",table.ItemId)
            if st.form_submit_button("Done"):
                cursor.execute("Select SellerId,Price,Quantity from SellerInventory where ItemId="+str(selected)+";")
                rr=cursor.fetchall()
                tt=pd.DataFrame(rr,columns=["SellerId","Price","quantity"])
                st.dataframe(tt)
                select_seller=st.selectbox("Select Seller",tt.SellerId)
                f=open("item.txt","w")
                f.write(str(selected))
                f.close()
                f=open("seller.txt","w")
                f.write(str(select_seller))
                f.close()
        with st.form(key="finalize"):
            quantity=st.text_input("enter QUANTITY",max_chars=10)
            if st.form_submit_button("Finalize Order"):
                f=open("item.txt","r")
                selected=f.read()
                f.close()
                f=open("seller.txt","r")
                select_seller=f.read()
                f.close()
                cursor.execute("Select Price from SellerInventory where ItemId= "+str(selected)+" and SellerId ="+str(select_seller)+" ;")
                rr=cursor.fetchone()
                price=rr[0]
                cursor.execute("Insert into Bill (SellerId,ItemId,Quantity,price,CustomerID) Values ("+str(select_seller)+","+str(selected)+","+str(quantity)+","+str(price)+","+str(cid)+");")
                db.commit()
                st.success("ORDER OUT FOR DELIVERY")
    elif newq=="ViewOrders":
        cursor.execute("select * from Bill where CustomerId ="+str(cid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["BillId","SellerId","ItemID","Quantity","price","CustomerId",])
        st.dataframe(table)
    elif newq=="ViewAddress":
        cursor.execute("select * from CustomerLocation where CustomerId ="+str(cid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["CustomerId","Flatno","Street","State"])
        st.dataframe(table)
    elif newq=="ViewPaymentmethods":
        cursor.execute("select * from Payment where CustomerId ="+str(cid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["CustomerId","Pmode","Details"])
        st.dataframe(table)
    elif newq=="Add/modifyAddress":
        cursor.execute("select * from CustomerLocation where CustomerId ="+str(cid)+";")
        rr=cursor.fetchall()
        ll=[]
        for i in rr:
            ll.append(i[1])
        print(ll)
        if rr:
            with st.form(key="address"):
                Flatno=st.text_input("FLAtNO",max_chars=25)
                Street=st.text_input("Street",max_chars=25)
                State =st.text_input("State",max_chars=25)
                if st.form_submit_button("Modify Address"):
                    if int(Flatno) in ll:
                        cursor.execute("Update CustomerLocation set Street=%s,State=%s where CustomerId ="+str(cid)+" and Flatno="+str(Flatno)+" ;",(Street,State))
                        db.commit()
                        st.success("Address Updated")
                    else:
                        cursor.execute("Insert into CustomerLocation Values ("+str(cid)+","+Flatno+",%s,%s);",(Street,State))
                        db.commit()
                        st.success("Address Added")

        else:
            with st.form(key="address2"):
                Flatno=st.text_input("FLAtNO",max_chars=25)
                Street=st.text_input("Street",max_chars=25)
                State =st.text_input("State",max_chars=25)
                if st.form_submit_button("Add Address"):
                    cursor.execute("Insert into CustomerLocation Values ("+str(cid)+","+Flatno+",%s,%s);",(Street,State))
                    db.commit()
                    st.success("Address Added")
    elif newq=="AddPayment":
        cursor.execute("select * from Payment where CustomerId ="+str(cid)+";")
        rr=cursor.fetchall()
        brahh=[]
        for i in rr:
            brahh.append(i[1])
        with st.form(key="payment"):
            pmode=st.text_input("Pmode",max_chars=25)
            details=st.text_input("Details",max_chars=25)
            if st.form_submit_button("Modify/Add"):
                if pmode in brahh:
                    cursor.execute("Update Payment set details=%s where CustomerId ="+str(cid)+" and Pmode=%s;",(details,pmode))
                    db.commit()
                    st.success("Payment Updated")
                else:
                    cursor.execute("Insert into Payment Values ("+str(cid)+",%s,%s);",(pmode,details))
                    db.commit()
                    st.success("Payment Added")
    elif newq=="viewDeliveryStatus":
        cursor.execute("Select SellerId,Street,State from delivery where CustomerId="+str(cid)+" ;")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["SellerId","Street","State"])
        st.dataframe(table)
    elif newq=="SalesOftheDay":
        cursor.execute("Select * from deals;")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["itemName","itemID","SellerId","Price"])
        st.dataframe(table)
    db.close()

def sdashboard(sid):
    db = sql.connect(
    host = "127.0.0.1",
    user = "Seller",
    passwd = "password",
    database = "amazon",
    auth_plugin="mysql_native_password"
    )
    cursor=db.cursor()
    qq=["None","ViewInventory","ViewBills","UpdateStock","AddNewstock","View Address","Add/modifyAddress","Pending Deliveries","Most Frequently Ordered"]
    newq=st.selectbox("What to do ?",qq)
    if newq=="ViewInventory":
        cursor.execute("Select ItemId,Price,Quantity From SellerInventory where SellerId= "+str(sid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["ItemId","Price","Quantity"])
        st.dataframe(table)
    elif newq=="ViewBills":
        cursor.execute("Select BillId,ItemId,Quantity,Price,CustomerId From Bill where SellerId= "+str(sid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["BillId","ItemId","Quanity","Price","CustomerId"])
        st.dataframe(table)
    elif newq=="UpdateStock":
        cursor.execute("Select ItemId From SellerInventory where SellerId= "+str(sid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["ItemId"])
        with st.form(key="ustock"):
            select_items=st.selectbox("Select item",table.ItemId)
            stock=st.text_input("ENTER NEW value",max_chars=10)
            if st.form_submit_button("Ok"):
                cursor.execute("Update SellerInventory set Quantity ="+str(stock)+" where SellerId="+str(sid)+" and ItemId="+str(select_items)+";")
                db.commit()
                st.success("Stock Updated")
    elif newq=="AddNewstock":
        with st.form(key="astock"):
            itemId=st.text_input("Enter ItemId",max_chars=10)
            stock=st.text_input("quanity",max_chars=10)
            itemname=st.text_input("Enter name",max_chars=10)
            price=st.text_input("ENTER price",max_chars=10)
            if st.form_submit_button("Ok"):
                cursor.execute("Select ItemId From SellerInventory where SellerId= "+str(sid)+" and ItemId= "+str(itemId)+";")
                rr=cursor.fetchall()
                ii=[]
                for i in rr:
                    ii.append(i[0]) 
                if int(itemId) in ii:
                    st.info("ITEM ALDREADY EXISTS")
                else:
                    cursor.execute("Insert into SellerInventory Values ("+str(sid)+","+str(itemId)+",'"+str(itemname)+"',"+str(price)+","+str(stock)+");")
                    db.commit()
                    st.success("ITEM ADDED")
    elif newq=="View Address":
        cursor.execute("select * from SellerLocation where SellerId ="+str(sid)+";")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["SellerId","Factoryno","Street","State"])
        st.dataframe(table)
    elif newq=="Add/modifyAddress":
        cursor.execute("select * from SellerLocation where SellerId ="+str(sid)+";")
        rr=cursor.fetchall()
        ll=[]
        for i in rr:
            ll.append(i[1])
        print(ll)
        if rr:
            with st.form(key="address"):
                Flatno=st.text_input("FactoryNO",max_chars=25)
                Street=st.text_input("Street",max_chars=25)
                State =st.text_input("State",max_chars=25)
                if st.form_submit_button("Modify Address"):
                    if int(Flatno) in ll:
                        cursor.execute("Update SellerrLocation set Street=%s,State=%s where CustomerId ="+str(sid)+" and Factoryno="+str(Flatno)+" ;",(Street,State))
                        db.commit()
                        st.success("Address Updated")
                    else:
                        cursor.execute("Insert into SellerLocation Values ("+str(sid)+","+Flatno+",%s,%s);",(Street,State))
                        db.commit()
                        st.success("Address Added")
        else:
            with st.form(key="address2"):
                Flatno=st.text_input("FLAtNO",max_chars=25)
                Street=st.text_input("Street",max_chars=25)
                State =st.text_input("State",max_chars=25)
                if st.form_submit_button("Add Address"):
                    cursor.execute("Insert into SelllerLocation Values ("+str(sid)+","+Flatno+",%s,%s);",(Street,State))
                    db.commit()
                    st.success("Address Added")
    elif newq=="Pending Deliveries":
        cursor.execute("Select CustomerId,Street,State from pending where SellerId="+str(sid)+" ;")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["CustomerId","street","State"])
        st.dataframe(table)
    elif newq=="Most Frequently Ordered":
        cursor.execute("Select a.ItemId,a.Itemname from Items a INNER JOIN(select count(*),ItemId from Bill where SellerId="+str(sid)+" group by ItemId ) b ON a.Itemid=b.ItemId;")
        rr=cursor.fetchall()
        table=pd.DataFrame(rr,columns=["ItemId","ItemName"])
        st.dataframe(table)

                
db = sql.connect(
    host = "127.0.0.1",
    user = "deeptanshu",
    passwd = "some_pass",
    database = "amazon",
    auth_plugin="mysql_native_password"
)
cursor=db.cursor()
def main():
    choices=["Customer Login","Seller Login","CustomerSignUP","SellerSignUP"]
    with st.form(key="fdddd"):
        with st.sidebar:  
            query = st.sidebar.selectbox("Choices", choices,key=1)
            tt=st.form_submit_button("OK")
    if query=="Customer Login":
        clogin()
        db.close()
        f=open("cache.txt","r")
        cdashboard(int(f.read()))
    elif query=="Seller Login":
        slogin()
        db.close()
        f=open("cache.txt","r")
        sdashboard(int(f.read()))
    elif query=="CustomerSignUP":
        csignup(cursor)
        db.close()
    elif query=="SellerSignUP":
        ssignup(cursor)
        db.close()
if __name__ == '__main__':
	main()

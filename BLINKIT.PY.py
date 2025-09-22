import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt



conn = mysql.connector.connect(

    host="localhost",
    user="root",
    password="roh4990",
    database="blinkit"


)

if conn.is_connected():
    print("✅ Database connected successfully!")
else:
    print("❌ Connection failed!")



query = """

SELECT O.ID ,NAME , SUM(QTY) AS TOTAL_QUANTITY FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID
GROUP BY NAME , O.ID 
ORDER BY TOTAL_QUANTITY DESC
LIMIT 10;

"""

df = pd.read_sql(query,conn)
print(df)

plt.figure(figsize = (8,10))
plt.bar(df["NAME"],df["TOTAL_QUANTITY"],color=["#00A651", "#FFD300"],label="TOP 10 PRODUCTS")
plt.xlabel("NAME",fontsize=7,fontweight="bold")
plt.ylabel("TOTAL_QUANTITY",fontsize=10,fontweight="bold")
plt.title("TOP 10 PRODUCTS BY QUANTITY",color="gold",fontweight="bold",fontsize=12)
plt.legend(loc="upper right")
plt.xticks(rotation=45)
plt.tight_layout()

plt.show()



query = """

SELECT NAME , SUM(TOTAL) AS REVENUE FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID
GROUP BY NAME 
ORDER BY REVENUE DESC
limit 5;

"""

df1 = pd.read_sql(query,conn)
print(df1)

plt.figure(figsize = (8,10))
plt.bar(df1["NAME"],df1["REVENUE"],color=["#B8860B","#00A651"],label="REVENUE")
plt.xlabel("NAME",fontsize=10,fontweight="bold")
plt.ylabel("REVENUE",fontsize=10,fontweight="bold")
plt.title("TOP 5 PRODUCTS BY REVENUE",color="gold",fontweight="bold",fontsize=12)
plt.legend(loc="upper right")
plt.tight_layout()

plt.show()


query = """

SELECT DATE(ORDER_DATE) AS DAY , COUNT(ID) , SUM(TOTAL) AS TOTAL_SALES FROM ORDERS AS O
GROUP BY DATE(ORDER_DATE)
ORDER BY DAY;

"""

df2 = pd.read_sql(query,conn)
print(df2)

plt.figure(figsize = (8,10))
plt.plot(df2["DAY"],df2["TOTAL_SALES"],color="greenyellow",label="PER DAY SALES",marker="o")
plt.xlabel("DAY",fontsize=10,fontweight="bold",color="gold")
plt.ylabel("TOTAL_SALES",fontsize=10,fontweight="bold",color="gold")
plt.title("PER DAY TOTAL SALES",fontweight="bold",color="gold",fontsize=12)
plt.legend(loc="upper center")
plt.tight_layout()

plt.show()


query = """

SELECT CATEGORY , SUM(TOTAL) AS REVENUE FROM ORDERS AS O
JOIN PRODUCTS AS P
ON O.PRODUCT_ID = P.ID
GROUP BY CATEGORY
ORDER BY REVENUE DESC;

"""

df3 = pd.read_sql(query,conn)
print(df3)

category = df3.groupby(["CATEGORY"])["REVENUE"].sum()
print(category)

plt.figure(figsize = (8,8))
plt.pie(category,labels=category.index,autopct="%1.1f%%")
plt.title("REVENUE BY CATEGORY",color="gold",fontweight="bold",fontsize=12)
plt.tight_layout()

plt.show()



#subplot

plt.figure(figsize = (20,12))
plt.subplot(2,2,1)
plt.bar(df["NAME"],df["TOTAL_QUANTITY"],color=["#00A651", "#FFD300"],label="TOP 10 PRODUCTS")
plt.xlabel("NAME",fontsize=7,fontweight="bold")
plt.ylabel("TOTAL_QUANTITY",fontsize=10,fontweight="bold")
plt.title("TOP 10 PRODUCTS BY QUANTITY",color="gold",fontweight="bold",fontsize=12)
plt.legend(loc="upper right")
plt.xticks(rotation=45)

plt.subplot(2,2,2)
plt.bar(df1["NAME"],df1["REVENUE"],color=["#B8860B","#00A651"],label="REVENUE")
plt.xlabel("NAME",fontsize=10,fontweight="bold")
plt.ylabel("REVENUE",fontsize=10,fontweight="bold")
plt.title("TOP 5 PRODUCTS BY REVENUE",color="gold",fontweight="bold",fontsize=12)
plt.legend(loc="upper right")

plt.subplot(2,2,3)
plt.plot(df2["DAY"],df2["TOTAL_SALES"],color="greenyellow",label="PER DAY SALES",marker="o")
plt.xlabel("DAY",fontsize=10,fontweight="bold",color="gold")
plt.ylabel("TOTAL_SALES",fontsize=10,fontweight="bold",color="gold")
plt.title("PER DAY TOTAL SALES",fontweight="bold",color="gold",fontsize=12)
plt.legend(loc="upper center")

plt.subplot(2,2,4)
plt.pie(category,labels=category.index,autopct="%1.1f%%")
plt.title("REVENUE BY CATEGORY",color="gold",fontweight="bold",fontsize=12)

plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.suptitle("BLINKIT DATA ANALYSIS",fontsize=14,fontweight="bold",color="gold")
plt.savefig("BLINKIT ANALYSIS",dpi=300)

plt.show()
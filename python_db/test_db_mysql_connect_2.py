import mysql.connector

connection = mysql.connector.connect(host="localhost",port='3306',database="world",user="root",password="19940827a")
print("データベースに接続しました")

cursor = connection.cursor()

sql_statement = """
select * from city where countrycode = 'JPN';
"""

cursor.execute(sql_statement)

#タプルでとってくる
rows = cursor.fetchall()
#print(rows) 全部出る
for row in rows:
    print(row)

print("行数",cursor.rowcount)



cursor.close()
connection.close()
print("接続を閉じました")
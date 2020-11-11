import mysql.connector
#挿入更新削除


connection = mysql.connector.connect(host="localhost",port='3306',database="world",user="root",password="19940827a")
print("データベースに接続しました")

cursor = connection.cursor()

#connection.autocommit(False)


sql_statement1 = """
INSERT INTO city VALUES (default,'Komatushima','JPN','Tokushima',0);
"""
sql_statement2 = """
UPDATE city SET Population = 36123 WHERE Name = 'Komatushima';
"""
sql_statement3 = """
DELETE FROM city WHERE Name = 'Komatushima';
"""

#SQL文実行する 
cursor.execute(sql_statement1)


print("行数",cursor.rowcount)

connection.commit()
print("コミットしました")


cursor.close()
connection.close()
print("接続を閉じました")
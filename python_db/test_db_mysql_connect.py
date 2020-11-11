import mysql.connector

connection = mysql.connector.connect(host="localhost",port='3306',database="world",user="root",password="19940827a")

print("データベースにせつぞくしました")


cursor = connection.cursor()

print("SQLの接続")
print("SQL文の実行・結果の取得・表示")
print("コミット確定")

cursor.close()

connection.close()
print("接続を閉じました")
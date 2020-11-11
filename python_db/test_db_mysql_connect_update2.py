import mysql.connector
from mysql.connector import InterfaceError, DatabaseError, IntegrityError, ProgrammingError
#例外処理

try:
    #初期化
    connection = None
    cursor = None
    connection = mysql.connector.connect(host="localhost",port='3306',database="world",user="root",password="19940827a")
    print("データベースに接続しました")


    cursor = connection.cursor()


    sql_statement1 = """
    INSERT INTO city VALUES (default,'Komatushima','JPN','Tokushima',0);
    """


    #SQL文実行する 
    cursor.execute(sql_statement1)


    print("行数",cursor.rowcount)

    connection.commit()
    print("コミットしました")

except ProgrammingError as err:
    print("プログラミングエラー",err)
    print("データベース名・ユーザー名・パスワード・SQL文を見直してください")

except IntegrityError as err:
    print("データ完全性エラー",err)
    print("主キー・参照・チェックなどの制約違反です。SQL文を見直して下さい")
    connection.rollback()
    print("ロールバックしました")
except DatabaseError as err:
    print("データベースエラー",err)
    connection.rollback()
    print("ロールバックしました")
except InterfaceError as err:
    print("インターフェースエラー",err)
    print("ホスト名、ポート番号を見直してください")
except Exception as err:
    print("その他例外",err)
    connection.rollback()
    print("ロールバックしました")

finally:
    if cursor != None:
        cursor.close()
    if connection != None:
        connection.close()
        print("接続を閉じました")

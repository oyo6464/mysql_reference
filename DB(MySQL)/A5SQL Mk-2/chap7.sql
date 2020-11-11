--第7章



-- testデータベースの作成 collteは検索や並び替えの順番を指定している
create database test character set utf8mb4 collate utf8mb4_0900_ai_ci ;

--world databaseの定義 確認
show create database world;

--
use test;

--テーブルの作成
create table t1 (
      i1  int not null primary key,v2 varchar(20)
  )
  engine=innodb;


--行を追加
insert into t1 values (1,'Firebird');


--確認できる
show create table t1;

--トランザクションの定義
--1A 原子性　１か１０か　中途半端✖
--2C一貫性  id等をユニークにする
--3I分離性　2人が同時に処理したらおかしくなる場合、後の人ちょっと待ってもらう
----------------コミットかロールバックまで待たされる
--4D持続性



--最大接続数の確認
show global variables like 'max_connections' ;


--同時接続数
set global max_connections = 30;

--現在の接続数
show status like 'threads_connected';



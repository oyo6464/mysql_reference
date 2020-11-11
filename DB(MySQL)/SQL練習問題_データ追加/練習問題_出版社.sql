use test;

create table 出版社(
   出版社コード char(4) primary key,
   出版社名 char(50) not null
);

create table 書籍(
       書籍コード char(4) primary key,
       書籍名 varchar(60) not null,
       単価 int,
       出版社コード char(4) not null
);

select * from 出版社;

select * from 書籍;

select * from 出版社 inner join 書籍 on 出版社.出版社コード = 書籍.出版社コード;

--出版社コードは2つのテーブルでかぶってるので、どちらを参照するか書かなければいけない
select 書籍コード,書籍名,単価,書籍.出版社コード,出版社名 from 出版社 inner join 書籍 on 出版社.出版社コード = 書籍.出版社コード;

--上と同じ
select 書籍コード,書籍名,単価,書籍.出版社コード,出版社名 from 出版社, 書籍 where 書籍.出版社コード = 出版社.出版社コード;

--出版社を基準にする場合 21行目改造 下のほうにnullがある
select 書籍コード,書籍名,単価,書籍.出版社コード,出版社名 from 出版社 left outer join  書籍 on 出版社.出版社コード = 書籍.出版社コード;

--書籍コード世界のリクガメの出版社名がnull
select 書籍コード,書籍名,単価,書籍.出版社コード,出版社名 from 出版社 right outer join  書籍 on 出版社.出版社コード = 書籍.出版社コード;

--リクガメの出版社を登録
insert into 出版社 values('P999','丸亀出版');


--左と右 両方 これで双方にnullがないかわかる

select 書籍コード,書籍名,単価,書籍.出版社コード,出版社名 from 出版社 left outer join  書籍 on 出版社.出版社コード = 書籍.出版社コード
union
select 書籍コード,書籍名,単価,書籍.出版社コード,出版社名 from 出版社 right outer join  書籍 on 出版社.出版社コード = 書籍.出版社コード;


--書籍テーブルに出版社テーブルの出版社コードがないものを登録できないようにする
--参照整合性s
alter table 書籍 add foreign key (出版社コード) references 出版社(出版社コード);

--↑確認　出版社テーブルに登録されていない　出版社コードつきのレコードを登録
insert into 書籍 values('9001','ざんねんな生き物物語','1000','P011');

--出版社コード追加
insert into 出版社 values('P011','高山書店');

--毎経BPと実京出版が倒産　削除

select * from 出版社 where 出版社名 in ('毎経BP','実京出版');

--消す
delete from 出版社 where 出版社名 in ('毎経BP','実京出版');


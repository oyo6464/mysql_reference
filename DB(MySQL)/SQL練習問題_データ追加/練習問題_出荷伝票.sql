use test;

create table 出荷先マスタ(
         出荷先コード char(4) primary key,
         出荷先名 varchar(40) not null unique
         );

create table 製品マスタ(
         製品コード char(4) primary key,
         製品名 varchar(40) not null unique,
         単価 int
         );

create table 出荷伝票(
         出荷番号 int primary key auto_increment,
         出荷日 date not null,
         出荷先コード char(4) not null,
         製品コード char(4) not null,
         出荷数量 int not null check(出荷数量>0),
         foreign key (出荷先コード) references 出荷先マスタ(出荷先コード),
         foreign key (製品コード) references 製品マスタ(製品コード)
         );

select * from 出荷先マスタ order by 出荷先コード;
select * from 製品マスタ order by 製品コード;
select * from 出荷伝票;



--参照制約を確認　適当な文

--出荷先コード　S099はない
insert into 出荷伝票(出荷日,出荷先コード,製品コード,出荷数量) values ('2020-11-06','S099','B001',72);
--製品コード B022はない
insert into 出荷伝票(出荷日,出荷先コード,製品コード,出荷数量)values ('2020-11-06','S008','B022',72);

--0はダメ
insert into 出荷伝票(出荷日,出荷先コード,製品コード,出荷数量)values ('2020-11-06','S008','B002',0);


--unique 適用されているか確認　適当な文

--出荷先名　重複させる
insert into 出荷先マスタ values('S009','青空ビア');

--製品名 重複させる
insert into 製品マスタvalues('B010','スーパーカライ',350);



--3つのテーブルを内部結合 

select * from 出荷先マスタ
inner join 出荷伝票 on 出荷先マスタ.出荷先コード = 出荷伝票.出荷先コード 
inner join 製品マスタ on 出荷伝票.製品コード =  製品マスタ.製品コード ;



select 出荷番号,出荷日,出荷伝票.出荷先コード,出荷先名,出荷伝票.製品コード,製品名,単価,出荷数量 from 出荷先マスタ
inner join 出荷伝票 on 出荷先マスタ.出荷先コード = 出荷伝票.出荷先コード
inner join 製品マスタ on 出荷伝票.製品コード =  製品マスタ.製品コード ;


--卸先へ見せる
select 製品コード,製品名,単価 as お値段 from 製品マスタ;

--円をつける
select 製品コード,製品名, concat(単価,'円') as お値段 from 製品マスタ;

--お値段が　nullになってるものを0円表示にする

select 製品コード,製品名, concat(coalesce(単価,0),'円') as お値段 from 製品マスタ;



--上の改造　nullを0にする
select 出荷番号,出荷日,出荷伝票.出荷先コード,出荷先名,出荷伝票.製品コード,製品名,coalesce(単価,0) as 単価,出荷数量,coalesce(単価,0)*出荷数量 as 売上 from 出荷先マスタ
inner join 出荷伝票 on 出荷先マスタ.出荷先コード = 出荷伝票.出荷先コード
inner join 製品マスタ on 出荷伝票.製品コード =  製品マスタ.製品コード;


--更に改造　税込み売上を追加
select 出荷番号,出荷日,出荷伝票.出荷先コード,出荷先名,出荷伝票.製品コード,製品名,
coalesce(単価,0) as 単価,
出荷数量,
coalesce(単価,0)*出荷数量 as 売上,
coalesce(単価,0)*出荷数量 * 1.08 as 税込み売上
from 出荷先マスタ
inner join 出荷伝票 on 出荷先マスタ.出荷先コード = 出荷伝票.出荷先コード
inner join 製品マスタ on 出荷伝票.製品コード =  製品マスタ.製品コード;

--roundで小数点を丸め込む 第二引数の0は小数点0以下まで表示するという意味
select 出荷番号,出荷日,出荷伝票.出荷先コード,出荷先名,出荷伝票.製品コード,製品名,
coalesce(単価,0) as 単価,
出荷数量,
coalesce(単価,0)*出荷数量 as 売上,
round(coalesce(単価,0)*出荷数量 * 1.08,0) as 税込み売上
from 出荷先マスタ
inner join 出荷伝票 on 出荷先マスタ.出荷先コード = 出荷伝票.出荷先コード
inner join 製品マスタ on 出荷伝票.製品コード =  製品マスタ.製品コード;

--集計関数
select sum(出荷数量)as 出荷数量の合計, avg(出荷数量) as出荷数量の平均,max(出荷数量) as 出荷数量の最大値
 from 出荷伝票;
 
--グループ化したうえで集計
select 出荷先コード,sum(出荷数量)as 出荷数量の合計, avg(出荷数量) as出荷数量の平均,max(出荷数量) as 出荷数量の最大値
 from 出荷伝票 group by 出荷先コード;

--上で表示したもののうち、合計500以上のみを表示
select 出荷先コード,sum(出荷数量)as 出荷数量の合計, avg(出荷数量) as出荷数量の平均,max(出荷数量) as 出荷数量の最大値
 from 出荷伝票 group by 出荷先コード
-- having sum(出荷数量)>500; --どっちでも大丈夫
 having 出荷数量の合計>500;


use test;


--テーブル作成
create table 都道府県(
            コード char(2) primary key,
            地域 varchar(20),
            都道府県名 varchar(20),
            県庁所在地 varchar(20),
            面積 int
);

--確認
select * from 都道府県;

--間違えたとき テーブルを消す
drop table 都道府県;

--データの追加(insert into文)は配布から


--徳島と香川県のデータを追加 23行目の()は全部入力するとき省略もできる
insert into 都道府県 
  value(36,'四国','徳島','徳島',4147),
         (37,'四国','香川','高松',1877);


--県庁所在地が入力されていないレコードを表示
select * from 都道府県 where 県庁所在地 is null;


--上で見つかった内の1つ、神奈川を指定
select * from 都道府県 where コード = 14;


--正しい県庁所在地を入力
update 都道府県 set 県庁所在地  = '横浜' where コード =14;


--正しい県庁所在地を入力2
update 都道府県 set 県庁所在地 = '岡山' where コード =33;

--和歌山と愛媛表示
select * from 都道府県 where 都道府県名 = '和歌山' or 都道府県名 = '愛媛';

--5つの県を表示 in演算子を使う     where列名 in (値達)
select * from 都道府県 where 都道府県名 in ('和歌山','愛媛','静岡','熊本','長崎');

--関東地域
select * from 都道府県 where 地域 = '関東';

--面積が3000未満
select * from 都道府県 where 面積 < 3000;

--関東地域かつ 3000未満
select * from 都道府県 where (面積<3000 and 地域='関東');

--関東地域と四国地域　3000未満
select * from 都道府県 where(面積<3000 and 地域 in ('関東','四国'));

--曖昧検索 like　川が付く都道府県
select 都道府県名 from 都道府県 where 都道府県名 like '%川';

--都道府県名と県庁所在地が同じ都道府県
select 都道府県名,県庁所在地 from 都道府県 where 都道府県名 = 県庁所在地;

--逆
select 都道府県名,県庁所在地 from 都道府県 where 都道府県名 != 県庁所在地;

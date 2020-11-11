--6章

show databases;

--SQLを開いたらこれを一番に実行する
use world;

show tables;



select *
  from city;

select * from city where countrycode= 'JPN';

select * from city where District='kyoto';

select Name,Population from city where District='kyoto' and Population> 100000;





--distinct で重複無し　47
select distinct district from city where countrycode='JPN';

--重複あり　248
select district from city where countrycode='JPN';


--order by で並べ替え 
select * from city where countrycode='JPN' order by Population;

--descで 降順　（ascで昇順）
select * from city where countrycode='JPN' order by Population desc;

--,区切りを使う
select * from city where countrycode='JPN' order by district,name;



--count()で数だす
select count(*) from city where countrycode='JPN';

--min() 等の関数も使える
select min(Population),max(Population),sum(Population),avg(Population) from city where countrycode='JPN';


--group_concat() なし
select name from city where countrycode='JPN' and district='kyoto';

--group_concat()　あり
select group_concat(name) from city where countrycode='JPN' and district='kyoto';


--distinct + group_concat() 
select group_concat(distinct  district) from city where countrycode='JPN';


--同じ値を持つ行をグループ化する　group by()
select district,count(*) from city where countrycode='JPN' GROUP BY district;


--group by でグループ化したものに条件を使うときは havingを使う
select district,count(*) from city where countrycode='JPN' group by district having count(*)=4;

--order by
select district,count(*) from city where countrycode='JPN' group by district having count(*)>4 order by count(*) desc;

/*

本節で学んだ「ORDERBY」「GROUPBY」「HAVING」の記述順序は以下のようになります。
記述する場合は、必ずこの順番で記述する必要があります。

①SELECT②FROM③WHERE④GROUPBY⑤HAVING⑥ORDERBY

*/


--Step2　データの更新、追加、削除

--update文 1まずnameがkiotoの文を探し出す
select * from city where countrycode='JPN' and district='kyoto' and name='kioto';

--update文 2訂正する レコードが更新される
update city set name='kioto' where countrycode='JPN' and district='kyoto' and name='kioto';



-- insert文 1愛媛に Ozu市追加する
insert into city values(DEFAULT, 'Ozu', 'JPN', 'Ehime', 45020);

--insert文  2追加できていることが確認できる
select * from city where countrycode='JPN' and district='Ehime';



--delete文  1先ほどのOZU市探してみる
select * from city where id=4080;

--delete文 2先ほどのOzu市が削除される
delete from city where id=4080;

--cityテーブルの定義が知れる
show create table city;

--こちらでもテーブルの定義が知れる(見やすい)
desc city;

--cityの後にどの列を入れるか指定する
insert into city(name,countrycode,district,population) values( 'Ozu', 'JPN', 'Ehime', 45020);

-- 上手くいかなかった
-- insert into city(id) values(default)



--テーブルのコピー(列見出しのみ)
create table citycopy like city;

--コピーしたテーブルを確認(値はnull)
select * from citycopy;

--内容をコピー
insert into citycopy select * from city; 

--コピーしたテーブルを確認(値がコピーされている)
select * from citycopy;


--複数のレコードを一度に挿入
insert into city (name,countrycode, district, population) 
  values
         ('Saijo', 'JPN','Ehime', 109598),
         ('Shikokuchuo','JPN','Ehime',87959),
         ('uwajima','JPN','Ehime',79269);
         
--確認できる
select * from city where countrycode='JPN' and district='Ehime';



--viewの作成 (cityehimeという名のview)
create view cityehime as select id, name, population from city where countrycode='JPN' and district='Ehime';


--作成したviewは　テーブルのように確認できる
select * from cityehime;

--viewの作成2　今度は人口700万人のviewを作成
create view largecity as select * from city where population>7000000 with check option;

--viewの作成3 cityjapan
create view cityjapan as select id, name, district, population from city where countrycode='JPN';

--確認
select * from cityjapan;

--副問い合わせ 平均より人口が多い市を表示
select * from cityjapan where population >(
                                        select avg(population)
                                          from cityjapan
                                        );

--詳細確認 入れ子のselect文 平均
select avg(population)from cityjapan;


--次に都道府県ごとで平均を上回った都市をピックアップする
select district,name,population from cityjapan as c1 
    where population>(
                     select avg(population) from cityjapan as c2
                       where c1.district=c2.district  group by district
                       );

--スカラ値(単一の値を返すSelect文) ()を使う
select count(*) from city;

--表形式で値を返すselect文
select * from city;


--単一の列・複数行の値を返すselect文
select population from city;


--日本で使われている言語
select * from countrylanguage where countrycode='JPN';

--日本語が使われている国
select * from countrylanguage where language = 'Japanese';

--国コードから国を検索してみる
select countrylanguage.*,country.name from countrylanguage
       inner join country on countrylanguage.countrycode=country.code where language='Japanese';

--言語追加 エスぺラン語をJPNの使用言語として追加
insert into countrylanguage (language,countrycode) values ('Esperanto', 'JPN');

--エスぺラン語が使われている国を確認
select countrylanguage.*,country.name from countrylanguage
       inner join country on countrylanguage.countrycode=country.code where language='Esperanto';

--確認2 Nullだった場合でも表形式で表示できる
select countrylanguage.*,country.name from countrylanguage
       left outer join country on countrylanguage.countrycode=country.code where language='Esperanto';


-- nullの比較
select 1 =1;

--nullが伝搬( )
select null=null;

--True(1)が返ってくる
select Null<=>Null;

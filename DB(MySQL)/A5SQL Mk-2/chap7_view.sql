-- ビューを使ってテーブルにデータを追加するテスト

-- ①チェックオプションのテスト
-- ビューの作成、チェックオプションなし
create 
  view testview1
  as 
    select * 
    from citycopy
    where population > 7000000;

-- ビューの作成、チェックオプションあり  (人口7000000以下は追加できない)
create 
  view testview2
  as 
    select * 
    from citycopy
    where population > 7000000
    with check option;

-- ビューの参照
select * 
  from testview1;

select * 
  from testview2;

select * from citycopy where district='Tokushima';

-- ビューを使ってテーブルにデータを追加
-- チェックオプションなしのビュー
insert 
  into testview1
  values (default, 'Anan', 'JPN', 'Tokushima', 54925);

-- チェックオプションありのビュー
-- ビューを作ったときの条件より人口が少ない
-- → チェックオプション エラー 700万以上にすると追加できる
insert 
  into testview2
  values (default, 'Anan', 'JPN', 'Tokushima', 54925);


-- ビューを使ってテーブルからレコードを削除
delete
  from testview2
  where name = 'Anan'
  and countrycode = 'JPN';


-- ビューの削除
drop
  view testview1;
  
drop
  view testview2;



-- ②limit句を使った行の絞り込みテスト

-- ビューの作成、limit句なし
create 
  view testview3
  as 
    select *
    from citycopy
    where countrycode = 'JPN';

-- ビューの作成、人口で並べ替え
-- limit句で上位10のみ取得
create 
  view testview4
  as 
    select *
    from citycopy
    where countrycode = 'JPN'
    order by population desc limit 10;


-- ビューの参照
select *
  from testview3;
  
select *
  from testview4;


-- ビューを使ってテーブルにデータを追加
-- limt句なしのビュー
insert
  into testview3
  values (default, 'Awa', 'JPN', 'Tokushima', 34599);

-- limt句ありのビュー
--上位10位まで　追加は認められない
insert
  into testview4
  values (default, 'Awa', 'JPN', 'Tokushima', 34599);


-- ビューを使ってテーブルからレコードを削除
delete
  from testview3
  where name = 'Awa';
  and countrycode = 'JPN';


-- ビューの削除
drop
  view testview3;
  
drop
  view testview4;




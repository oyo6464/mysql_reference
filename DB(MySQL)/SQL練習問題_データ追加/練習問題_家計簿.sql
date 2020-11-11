use test;


--間違えたとこ（,）ではなく ,  ,
create table 家計簿 (
         日付 date not null,
         費目 varchar(20) not null,
         メモ varchar(100)  not null,
         入金額  int,
         出金額  int
        );

--家計簿アーカイブ
create table 家計簿アーカイブ(
         日付 date not null,
         費目 varchar(20) not null,
         メモ varchar(100)  not null,
         入金額  int,
         出金額  int
        );
--確認
select * from 家計簿アーカイブ;
select * from 家計簿;

--家計簿アーカイブから費目のみ表示
select 費目 from 家計簿アーカイブ;

--上の重複を取り除く select distinct　ディスティンクト
select distinct 費目 from 家計簿アーカイブ;

--家計簿の出金額が多い順に並べ替える order by　（desc）
select * from 家計簿 order by 出金額 desc;

--出金額の多い順に並びTop3 limit
select * from 家計簿 order by 出金額 desc limit 3;

--テーブル同士の足し算 和集合 unionを使う 列名のデータ型があってれば使える
select * from 家計簿 union select * from 家計簿アーカイブ;

--費目のみ distinct使わないでも重複ない
select 費目 from 家計簿 union select 費目 from 家計簿アーカイブ;

--重複ほしい時 union all
select 費目 from 家計簿 union all  select 費目 from 家計簿アーカイブ;

--差集合 mySQLはexcept使えない、外部結合を使う
select 家計簿.費目 from 家計簿 left join 家計簿アーカイブ on 家計簿.費目 = 家計簿アーカイブ.費目 where 家計簿アーカイブ.費目 is null;

--差集合2
select 家計簿アーカイブ.費目 from 家計簿アーカイブ left join 家計簿 on 家計簿.費目= 家計簿アーカイブ.費目 where 家計簿.費目 is null;

--外部結合のみやって見る 費目が同じ列に行く
select * from 家計簿アーカイブ left join 家計簿 on 家計簿.費目=家計簿アーカイブ.費目;


--内部結合
select 家計簿アーカイブ.費目 from 家計簿アーカイブ inner join 家計簿 on 家計簿アーカイブ.費目 = 家計簿.費目;

--内部結合　重複無し
select distinct 家計簿アーカイブ.費目 from 家計簿アーカイブ inner join 家計簿 on 家計簿アーカイブ.費目 = 家計簿.費目;

--出金額が0よりおおきい費目と出金額 費目に応じて固定費か変動費化の分類を表示 ?????? →select とcaseの間に,がいる
select 費目,出金額, 
      case 費目 
         when '居住費' then '固定費'
         when  '水道光熱費' then '固定費'
         else '変動費'
      end as 支出の分類
      from 家計簿アーカイブ where 出金額 > 0;


--??????????
select 費目,出金額, 
      case 
         when '出金額'<5000 then '出金小'
         when  '出金額' <10000 then '出金中'
         when  '出金額'<30000 then '出金大'
      end as 支出の分類
      from 家計簿アーカイブ where  出金額 > 0;








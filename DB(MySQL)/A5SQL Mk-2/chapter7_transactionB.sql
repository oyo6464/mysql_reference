use test;

start transaction;

select * from t1;

rollback;


--step2
--シナリオ①
--1回目の変更
start transaction;

insert into t1 values (2,'MySQL');

commit;


rollback;


start transaction;

--2回目の変更
insert into t1 values (3,'PostgreSQL');

commit;

--3回目 コミットせずにAを見てみる
start transaction;

insert into t1 values(4,'Oracle');



--シナリオ②
start transaction;

insert into t1 values(4, 'Oracle');

rollback;

--step3
set transaction isolation level read committed;

start transaction;

select * from t1 where i1=1;


select * from t1 where i1 = 1;

rollback;

--デッドロック
start transaction;

insert into b values(1,'MySQL');
insert into a values(1,'MySQL');

rollback;


show engine innodb status;


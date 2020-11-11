use test;

start transaction;

select * from t1;

rollback;

--step2
--シナリオ①

start transaction;

--B commit 後に実行
select * from t1;

rollback;
--1,2 追加されている
--3



--シナリオ② 
start transaction ;

insert into t1 values(4, 'JavaDB');

rollback;

--step3
set transaction isolation level repeatable read;

start transaction;


select * from t1 where i1 = 1;


rollback;


--デッドロック
create table a(i1 int not null primary key, v2 varchar(20)) engine=innodb;

create table b(i1 int not null primary key, v2 varchar(20)) engine=innodb;

select * from a;

select * from b;


set innodb_lock_wait_timeout=50;
start transaction;

insert into a values(1,'Firebird');

insert into b values(1,'Firebird');


rollback;

show engine innodb status;



--step3
--シナリオ
--トランザクション C

use test;

start transaction;

update t1 set v2='MySQL' where i1 =1;
commit;
start transaction;

update t1 set v2='PostgreSQL' where i1 =1;
commit;
start transaction;

update t1 set v2='Oracle' where i1 =1;

select * from t1 where i1 = 1;

rollback;

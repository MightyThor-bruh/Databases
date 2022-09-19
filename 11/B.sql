----------------------------------4-------------------------------------------

set transaction isolation level read committed -- идет по умолчанию
begin tran
update Transactions set Info = 'Строка 6' where Cnter = 4
insert Transactions values ('Cтрока 5')
--t1
rollback tran
--t2
select * from Transactions
select count(*) from Transactions
----------------------------------5-------------------------------------------

set transaction isolation level read committed
begin tran
update Transactions set Info = 'Строка 6' where Cnter = 4
insert Transactions values ('Cтрока 5')
--t1
commit tran
--t2

----------------------------------6-------------------------------------------

set transaction isolation level read committed
begin tran
--update Transactions set Info = 'Строка 6' where Cnter = 4 -- не получится, будет ждать завершения первой транзакции
insert Transactions values ('Строка 5')-- можно
--t1
commit tran
--t2

----------------------------------7-------------------------------------------

set transaction isolation level read committed
begin tran
insert Transactions values ('Строка 5')
--t1
rollback tran
--t2
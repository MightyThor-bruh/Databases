create table Transactions
(
	Cnter int identity(1,1),
	Info nvarchar(20)
)
insert Transactions values ('Строка 1'),('Строка 2'),('Строка 3'),('Строка 4')

----------------------------------4-------------------------------------------

set transaction isolation level read uncommitted --неподтвержденное чтение - может быть коммит либо откат
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select count(*) from Transactions
select * from Transactions
--t2
commit

----------------------------------5-------------------------------------------

set transaction isolation level read committed
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select * from Transactions
select count(*) from Transactions
commit
--t2
update Transactions set Info = 'Строка 4' where Cnter = 4
delete from Transactions where Info = 'Cтрока 5'

----------------------------------6-------------------------------------------

set transaction isolation level repeatable read
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select * from Transactions
select count(*) from Transactions
commit
--
delete from Transactions where Info = 'Строка 5'
--t2

----------------------------------7-------------------------------------------

set transaction isolation level serializable
begin tran
select * from Transactions
select count(*) from Transactions
--t1
select * from Transactions
select count(*) from Transactions
commit
--t2
create table Transactions
(
	Cnter int identity(1,1),
	Info nvarchar(20)
)
insert Transactions values ('������ 1'),('������ 2'),('������ 3'),('������ 4')

----------------------------------4-------------------------------------------

set transaction isolation level read uncommitted --���������������� ������ - ����� ���� ������ ���� �����
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
update Transactions set Info = '������ 4' where Cnter = 4
delete from Transactions where Info = 'C����� 5'

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
delete from Transactions where Info = '������ 5'
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
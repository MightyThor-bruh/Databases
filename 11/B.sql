----------------------------------4-------------------------------------------

set transaction isolation level read committed -- ���� �� ���������
begin tran
update Transactions set Info = '������ 6' where Cnter = 4
insert Transactions values ('C����� 5')
--t1
rollback tran
--t2
select * from Transactions
select count(*) from Transactions
----------------------------------5-------------------------------------------

set transaction isolation level read committed
begin tran
update Transactions set Info = '������ 6' where Cnter = 4
insert Transactions values ('C����� 5')
--t1
commit tran
--t2

----------------------------------6-------------------------------------------

set transaction isolation level read committed
begin tran
--update Transactions set Info = '������ 6' where Cnter = 4 -- �� ���������, ����� ����� ���������� ������ ����������
insert Transactions values ('������ 5')-- �����
--t1
commit tran
--t2

----------------------------------7-------------------------------------------

set transaction isolation level read committed
begin tran
insert Transactions values ('������ 5')
--t1
rollback tran
--t2
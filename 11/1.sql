set nocount on;
if exists (select * from SYS.objects where object_id = object_id(N'dbo.X'))
drop table X;

declare @c int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON;
CREATE table X(K int);
INSERT X values (1),(2),(3);
set @c = (SELECT COUNT(*) from X);
print 'количество строк в таблице Х = ' + cast(@c as varchar(2));
if @flag = 'c' commit;
else rollback;
SET IMPLICIT_TRANSACTIONS OFF;

if  exists (select * from  SYS.OBJECTS where OBJECT_ID= object_id(N'dbo.X') )
	print 'таблица X есть';  
      else print 'таблицы X нет'

drop table Table2

begin tran 
	create table Table2(Num int identity, Words nvarchar(20))
	insert Table2 values ('qwerty'), ('asdfg'), ('zxcvb')
	begin tran 
		insert Table2 values ('zxcvbn')
	--rollback tran 
	commit tran
 if exists (select Words from Table2 where Words = 'zxcvbn')
 commit tran 
 else rollback tran 
 select Num[Id], Words[Строки] from Table2
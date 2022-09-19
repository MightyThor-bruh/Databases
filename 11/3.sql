USE UNIVER;
GO

declare @point varchar(32);
begin try
    BEGIN TRAN
	   insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME) values
		('ËÊ-Á      ','test');
		set @point='p1';
		save tran @point;
		delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ËÊ-Ê      ';
		set @point='p2';
		save tran @point;
	COMMIT TRAN;
end try
begin catch
    print 'Error: ' + cast(error_number()as nvarchar(20))
	print error_message()
	if @@TRANCOUNT>0 
	begin
	print 'save point: ' + @point;
	rollback tran @point;
	--commit tran;
	end;
end catch;
GO

USE UNIVER;
GO

begin try
    BEGIN TRAN
	   insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME) values
		('��-�      ','test');
		delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��-�      ';
	COMMIT TRAN;
end try
begin catch
    print 'Error: ' + cast(error_number()as nvarchar(20))
	print error_message()
	if @@TRANCOUNT>0 rollback tran -- ���� ������ 0, �� �� ���������
end catch
GO

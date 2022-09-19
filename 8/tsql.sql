DECLARE @a int = 3,
        @b varchar(4) = '����',
		@c datetime = getdate(),
		@d char,
		@e time,
		@f smallint,
		@g tinyint = 1, 
		@h numeric(12,5) = 12.5;
SET @d = 'd'; SET @e = '3:12'
SELECT @a a, @b b, @c c, @d d;
print 'e= ' + cast(@e as varchar(10));
print 'f= ' + cast(@f as varchar(10));
print 'g= ' + cast(@g as varchar(10));
print 'h= ' + cast(@h as varchar(10));

----------------------------------------------------------
USE UNIVER;
DECLARE @capacity numeric(8,3) = (select cast(sum(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM),
@total int,
@avgcapacity numeric(8,3),
@totallessavg int,
@procent numeric(8,3)
if @capacity > 200
begin
	set @total = (select cast(count(*) as numeric(8,3)) from AUDITORIUM);
	set @avgcapacity = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
	set @totallessavg = (select cast(count(*) as numeric(8,3)) from AUDITORIUM where AUDITORIUM_CAPACITY < @avgcapacity);
	set @procent = @totallessavg / @total;
	select @capacity '����� �����������',
	@total '����� ���������',
	@avgcapacity '������� �����������',
	@totallessavg '��������� � ������������ ���� �������',
	@procent '������� ����� ���������'
end
else print '����� ����������� < 200'

-------------------------------------------------------------------------
print '����� ������������ �����: ' + cast(@@rowcount as varchar);
print '������ SQL Server: ' + cast(@@version as varchar);
print '��������� ������������� ��������: ' + cast(@@spid as varchar);
print '��� ��������� ������: ' + cast(@@error as varchar);
print '��� �������: ' + cast(@@servername as varchar);
print '������� ����������� ����������: ' + cast(@@trancount as varchar);
print '�������� ���������� ���������� ����� ��������������� ������: ' + cast(@@fetch_status as varchar);
print '������� ����������� ������� ���������: ' + cast(@@nestlevel as varchar);

---------------------------------------------------------------------------
DECLARE @t float = 10.4, @x float = 2.5, @z float 
        IF @t > @x 
		   SET @z = sin(@t)*sin(@t)
		ELSE IF @t < @x 
		   SET @z = 4*(@t + @x)
		ELSE 
		   SET @z = 1 - exp(@x-2)
SELECT @z

---------------------------------------------------------------------------
GO
CREATE FUNCTION dbo.ShortName (@nameFull nvarchar(50))  
RETURNS nvarchar(50)   
as   
begin
    DECLARE @nameShort nvarchar(50) = '',
			@symbol nchar(1),
			@i int = 1,
			@wordCount int = 0,
			@isFirstLetter int = 0;
	WHILE @i < len(@nameFull)
		begin
			SET @symbol = substring(@nameFull, @i ,1);
			IF (@symbol = ' ')
				begin
					SELECT @wordCount = @wordCount + 1, 
					@isFirstLetter = 1, 
					@nameShort = @nameShort + @symbol
				end
			ELSE IF (@isFirstLetter = 1)
				begin
					SELECT @isFirstLetter = 0, 
					@nameShort = @nameShort + @symbol
				end
			ELSE IF (@wordCount = 0)
				begin
					SELECT @nameShort = @nameShort + @symbol
				end			
			SET @i = @i + 1
		end   
    RETURN @nameShort; 
end
GO

DECLARE @fullName nvarchar(50) = '������ ��������� ��������',
		@shortName nvarchar(50);
SET @shortName = dbo.ShortName(@fullName)
print @shortName

--------------------------------------------------------------------------
USE UNIVER;
SELECT STUDENT.Namee, STUDENT.Bday, (datediff(YY, STUDENT.Bday, sysdatetime())) as �������
       From STUDENT 
	   Where month(STUDENT.BDay) = month(sysdatetime()) + 1 

--------------------------------------------------------------------------
DECLARE @groupNumber int = 23;

SELECT distinct PROGRESS.PDATE[���� ����������� ��������], case 
    when DATEPART(dw,PROGRESS.PDATE) = 1 then '�����������'
    when DATEPART(dw,PROGRESS.PDATE) = 2 then '�������'
    when DATEPART(dw,PROGRESS.PDATE) = 3 then '�����'
    when DATEPART(dw,PROGRESS.PDATE) = 4 then '�������'
    when DATEPART(dw,PROGRESS.PDATE) = 5 then '�������'
    when DATEPART(dw,PROGRESS.PDATE) = 6 then '�������'
    when DATEPART(dw,PROGRESS.PDATE) = 7 then '�����������'
end [���� ������]
from GROUPA inner join STUDENT on STUDENT.IDGROUP = GROUPA.IDGROUP
      inner join PROGRESS on STUDENT.IDSTUDENT= PROGRESS.IDSTUDENT
  where GROUPA.IDGROUP = @groupNumber

--------------------------------------------------------------------------
DECLARE @A int = (SELECT count(*) From AUDITORIUM) 
       if @A > 50
	     begin 
		     print '����� ���������'
		 end
		 begin
		     print '���� ���������'
		 end

---------------------------------------------------------------------------
USE UNIVER;
SELECT CASE
       when NOTE between 0 and 3 then 'hasnt passed'
       when NOTE between 4 and 5 then 'passed'
       when NOTE between 6 and 7 then 'good'
       when NOTE between 8 and 10 then 'brilliant'
       end ������, count(*) [����������] 
From PROGRESS
GROUP BY CASE
      when NOTE between 0 and 3 then 'hasnt passed'
      when NOTE between 4 and 5 then 'passed'
      when NOTE between 6 and 7 then 'good'
      when NOTE between 8 and 10 then 'brilliant'
      end

----------------------------------------------------------------------------
CREATE TABLE #TEMPORARY 
(
   ID int,
   FullName varchar(100),
   City varchar(50)
);
SET nocount on;
DECLARE @i int = 0;
   While @i<1000 
   begin 
      INSERT #TEMPORARY(ID, FullName, City)
      values(FLOOR(10*rand()), REPLICATE('���', 10), REPLICATE('�����', 10));
   IF(@i % 100 = 0)
   print @i;
   SET @i = @i + 1;
   end;
   SELECT * FROM #TEMPORARY

----------------------------------------------------------------------------
DECLARE @x int = 2
  print @x+10 
  RETURN 
  print @x+4

----------------------------------------------------------------------------
begin TRY
	UPDATE PROGRESS set NOTE = 'lmao' where NOTE = 4
end try
begin CATCH
	print ERROR_NUMBER()
	print ERROR_MESSAGE()
	print ERROR_LINE()
	print ERROR_PROCEDURE()
	print ERROR_SEVERITY()
	print ERROR_STATE()
end catch


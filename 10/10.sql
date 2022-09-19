USE UNIVER;

--��������, ����������� ������ ���������

DECLARE specialtiesCursor cursor for
	SELECT SUBJECTT.Subjectt from PULPIT inner join SUBJECTT on PULPIT.Pulpit = SUBJECTT.Pulpit
	where PULPIT.Pulpit like '����'
go

DECLARE @str varchar(300) = '', @line varchar(30)

open specialtiesCursor
fetch specialtiesCursor into @line
while @@fetch_status = 0 
	begin
		SET @str = rtrim(@line) + ', ' + @str --�������� �������� ������ � ������
		fetch specialtiesCursor into @line
	end
close specialtiesCursor

print '�������� ������� ����: ' + @str
go

--------------------------------------------------------------------------------------
--��������, ��������������� ������� ����������� ������� �� ���������� 

DECLARE LinesLocal cursor local for 
      SELECT SUBJECTT from SUBJECTT
DECLARE @First nvarchar(10), @All nvarchar(200) = ' ';

open LinesLocal
fetch LinesLocal into @First
print '1. ' + @First
go

declare @First nvarchar(10), @All nvarchar(200) = ' ';
fetch LinesLocal into @First
print '2. ' + @First
go

--------------------------------------------------------------------------------------
--��������, ��������������� ������� ����������� �������� �� ������������ 
-- ������������
set nocount on

declare @One nvarchar(20), @Two nvarchar(20)
declare Local cursor global dynamic for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM

open Local
update AUDITORIUM set AUDITORIUM_CAPACITY = 299 where AUDITORIUM like '423-1%'
print '������������. � �����������'
fetch Local into @One, @Two
while @@FETCH_STATUS = 0
	begin
		print '' + @One + ' ' + @Two
		fetch Local into @One, @Two
	end
close Local

open Local
print ''
print '������������. ���������� ���������'
fetch Local into @One, @Two
while @@FETCH_STATUS = 0
	begin
		print '' + @One + ' ' + @Two
		fetch Local into @One, @Two
	end
close local
deallocate Local
go
update AUDITORIUM set AUDITORIUM_CAPACITY = 90 where  AUDITORIUM like '423-1%'

-- �����������
set nocount on

declare @One nvarchar(20), @Two nvarchar(20)
declare Local cursor local static for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM

open Local
update AUDITORIUM set AUDITORIUM_CAPACITY = 299 where AUDITORIUM like '423-1%'
print '�����������. ��������� �� ������������'
fetch Local into @One, @Two
while @@FETCH_STATUS = 0
	begin
		print '' + @One + ' ' + @Two
		fetch Local into @One, @Two
	end
close local

open Local
print ''
print '�����������. ��������� ������������'
fetch Local into @One, @Two
while @@FETCH_STATUS = 0
	begin
		print '' + @One + ' ' + @Two
		fetch Local into @One, @Two
	end
close local
go
update AUDITORIUM set AUDITORIUM_CAPACITY = 90 where  AUDITORIUM like '423-1%'

--------------------------------------------------------------------------------------------
--��������, ��������������� �������� ��������� � �������������� ������ ������� � ��������� SCROLL
deallocate Local

set nocount on

declare @type nvarchar(20), @capacity nvarchar(20)
declare Local cursor global static scroll for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM

open Local
print '���: '
fetch Local into @type, @capacity
while @@FETCH_STATUS = 0
	begin
		print '' + @type + ' ' + @capacity
		fetch Local into @type, @capacity
	end
close Local

open Local
print '������ ������: '
fetch first from Local into @type, @capacity
print '' + @type + @capacity

print '������ ������ (absolute)'
fetch absolute 2 from Local into @type, @capacity
print ''  + @type + @capacity

print '����� ������ � ����� (absolute)'
fetch absolute -5 from Local into @type, @capacity
print ''  + @type + @capacity

print '������ ������ (relative)'
fetch relative 2 from Local into @type, @capacity
print ''  + @type + @capacity

print '��������� ������: '
fetch next from Local into @type, @capacity
print ''  + @type + @capacity

print '��������������� ������: '
fetch prior from Local into @type, @capacity
print ''  + @type + @capacity

print '��������� ������: '
fetch last from Local into @type, @capacity
print ''  + @type + @capacity

close Local
go

----------------------------------------------------------------------------------
--������, ��������������� ���������� ����������� CURRENT OF

set nocount on;

declare @Sub nvarchar(10), @Sub_Name nvarchar(30);
declare currentOf cursor global dynamic for select Subjectt, Subjectt_Name from SUBJECTT for update

open currentOf 
fetch currentOf into @Sub, @Sub_Name
while @@FETCH_STATUS = 0
	begin
		if @Sub like '����%' update SUBJECTT set Subjectt_Name = '�������, ������� � �� ���� �����' where current of currentOf
		print '' + @Sub + ' ' + @Sub_Name
		fetch currentOf into @Sub, @Sub_Name
	end
close currentOf
deallocate currentOf

select Subjectt[�������], Subjectt_Name[�����������] from SUBJECTT
go

------------------------------------------------------------------------------------------
--�� ������� ��������� ������, ���������� ���������� � ���������, ���������� ������ ���� 4 

declare @Note int, @Name nvarchar(50), @Faculty nvarchar(20);
declare Goodbye cursor dynamic global for select PROGRESS.Note, STUDENT.Namee, GROUPA.Faculty
										  from PROGRESS inner join STUDENT on PROGRESS.IDStudent = STUDENT.IDStudent
										  inner join  GROUPA on STUDENT.IDGroup = GROUPA.IDGroup

open Goodbye
fetch Goodbye into @Note, @Name, @Faculty
while @@FETCH_STATUS = 0
	begin
		print '������ ' + cast(@Note as nvarchar(10)) + ' - ' + @Name + ' - ' + @Faculty
		fetch Goodbye into @Note, @Name, @Faculty

		if @Note <4 
		delete PROGRESS where current of Goodbye

		if
		@Note <4 delete STUDENT where current of Goodbye

		if
		@Note <4 delete GROUPA where current of Goodbye
	end
close Goodbye
deallocate Goodbye
go

--��� �������� � ���������� ������� �������������� ������ 

declare @Subject nvarchar(10), @IDStudent int, @Note int
declare Task6 cursor global dynamic for select Subjectt, IDStudent, Note
										from PROGRESS for update

open Task6
fetch Task6 into @Subject, @IDStudent, @Note
while @@FETCH_STATUS = 0
	begin
		print @Subject + ' ' +cast(@IDStudent as nvarchar(10)) + ' ' + cast(@Note as nvarchar(20)) -- �������������� ����� ������
		if @IDStudent = 1021 update PROGRESS set NOTE = NOTE + 1 where current of Task6
		fetch Task6 into @Subject, @IDStudent, @Note
	end
close Task6
deallocate Task6

select Subjectt[�������], IDStudent[Id ��������], Note[������] from PROGRESS
go

----------------------------------------------------------------------------------
declare @faculty nvarchar(10), @pulpitcount int, @i int = 0
declare @pulpitName nvarchar(50), @teacherCount int, @j int = 0
declare @subjectName nvarchar(15), @subjectline nvarchar(150) = '', @subjectPulpit nvarchar(50)

declare facultyCount cursor local static for
	select FACULTY.Faculty, count(*) from FACULTY inner join PULPIT on FACULTY.Faculty = PULPIT.Faculty
	group by FACULTY.Faculty order by FACULTY.Faculty asc

declare pulpits cursor local static for
	select PULPIT.Pulpit, count(*) from PULPIT left outer join TEACHER on PULPIT.Pulpit = TEACHER.Pulpit 
	group by Faculty, PULPIT.Pulpit order by Faculty asc

declare subjects cursor local static for
	select SUBJECTt.Subjectt, SUBJECTt.Pulpit from SUBJECTT

open facultyCount
open pulpits
	
	fetch from facultyCount into @faculty, @pulpitcount
	print '���������: ' + @faculty
	while @@fetch_status = 0
	begin
		set @i = 0
		while @i < @pulpitcount

			begin
				set @subjectline = ''
				fetch from pulpits into @pulpitName, @teacherCount
				print char(9) + '�������: ' + @pulpitName
				print char(9) + char(9) +'���������� ��������������: ' + cast(@teacherCount as nvarchar(10))

				open subjects

					fetch from subjects into @subjectName, @subjectPulpit

					if (@subjectPulpit = @pulpitName)
						set @subjectline = trim(@subjectName) + ', ' + @subjectline
					
					while @@fetch_status = 0
						begin
							fetch from subjects into @subjectName, @subjectPulpit

							if (@subjectPulpit = @pulpitName)
								set @subjectline = trim(@subjectName) + ', ' + @subjectline
						end

				close subjects

				if len(@subjectline) > 0
					set @subjectline = left(@subjectline, len(@subjectline)-1)
				else
					set @subjectline = '���.'
				print char(9) + char(9) + '����������: ' + @subjectline
				print ''
				set @i = @i+1	
			end

		fetch from facultyCount into @faculty, @pulpitcount
		if (@@fetch_status = 0) print '���������: ' + @faculty
	end

close facultyCount
close pulpits
go



use UNIVER;

declare @aud nvarchar(20)
declare AUD_CURSOR cursor local static for 
        SELECT Auditorium From TIMETABLE where SUBJECTT = '��'

open AUD_CURSOR 
fetch AUD_CURSOR into @aud
while @@fetch_status = 0 
	begin
		print '�� � ��������� ' + @aud
		fetch AUD_CURSOR into @aud
	end
close AUD_CURSOR
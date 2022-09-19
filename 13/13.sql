use UNIVER;
GO

CREATE FUNCTION COUNT_STUDENTS(@faculty varchar(20)) returns int 
as
  begin 
       DECLARE @rc int = 0;
	   set @rc = (SELECT count(*) 
	   From FACULTY Join GROUPA On FACULTY.Faculty = GROUPA.Faculty Join STUDENT On STUDENT.IDGroup = GROUPA.IDGroup
	   where FACULTY.Faculty = @faculty)
	   return @rc;
  end;

GO
print 'Количество студентов на факультете ИТ: ' + cast(dbo.COUNT_STUDENTS('ИТ') as nvarchar(20))
SELECT Faculty, dbo.COUNT_STUDENTS(Faculty) from FACULTY

----------------------------------------alter function----------------------------------------------------------

GO
ALTER FUNCTION COUNT_STUDENTS(@faculty varchar(20) = null, @prof varchar(20) = null) returns int 
as
  begin 
       DECLARE @rc int = 0;
	   set @rc = (SELECT count(STUDENT.IDStudent) 
	   From FACULTY 
	   Join GROUPA On FACULTY.Faculty = GROUPA.Faculty 
	   Join STUDENT On STUDENT.IDGroup = GROUPA.IDGroup
	   Join PROFESSION On FACULTY.Faculty = PROFESSION.Faculty
	   where FACULTY.Faculty = @faculty and PROFESSION.Profession_Name = @prof)
	   return @rc;
  end;

GO
SELECT FACULTY.Faculty, PROFESSION.Profession_Name,
	   dbo.COUNT_STUDENTS(FACULTY.Faculty, PROFESSION.Profession_Name)
	   From FACULTY
	   join PROFESSION on FACULTY.Faculty = PROFESSION.Faculty

print 'Количество студентов: ' + 
cast(dbo.COUNT_STUDENTS('ХТиТ', 'Машины и аппараты химических производств и предприятий строительных материалов') as nvarchar(20))

----------------------------------------task 2----------------------------------------------------------

GO
CREATE FUNCTION FSUBJECTS(@p varchar(20)) returns varchar(300)
as
  begin
       DECLARE @word varchar(10), @string nvarchar(200) = ' ';
	   DECLARE fsubject cursor local 
	   for SELECT Subjectt From SUBJECTT where Pulpit = @p;

	   open fsubject;
	   FETCH fsubject into @word;
	   while @@FETCH_STATUS = 0
	   begin 
	       set @string = @string + ', ' + RTRIM(@word);
		   FETCH fsubject into @word;
		end;
		
	    close fsubject;
		return @string
  end;

GO
SELECT Pulpit, dbo.FSUBJECTS(Pulpit) [Дисциплины] From SUBJECTT

----------------------------------------task 3----------------------------------------------------------

GO
CREATE FUNCTION FFACPUL(@fac varchar(20), @pul varchar(20)) returns table
as return
  SELECT FACULTY.Faculty, PULPIT.Pulpit From FACULTY left outer join PULPIT On FACULTY.Faculty = PULPIT.Faculty
  where FACULTY.Faculty = ISNULL(@fac, FACULTY.Faculty) and
        PULPIT.Pulpit = ISNULL(@pul, PULPIT.Pulpit)
GO

SELECT * From dbo.FFACPUL(null, null);
SELECT * From dbo.FFACPUL('ИДиП', null);
SELECT * From dbo.FFACPUL(null, 'ХПД');
SELECT * From dbo.FFACPUL('ТТЛП', 'ТДП');

----------------------------------------task 4----------------------------------------------------------

GO
CREATE FUNCTION FCTEACHER(@pulp varchar(20)) returns int
as
  begin
      DECLARE @rc int = (SELECT count(*) From TEACHER where TEACHER.Pulpit = ISNULL(@pulp, TEACHER.Pulpit));
	  return @rc;
  end;
GO

SELECT Pulpit, dbo.FCTEACHER(Pulpit) [Преподов на кафедре] From TEACHER
SELECT dbo.FCTEACHER(null) [Всего преподов]

----------------------------------------task 6----------------------------------------------------------

GO
CREATE FUNCTION StudentCount(@faculty varchar(50)) returns int
as
begin
	 DECLARE @studentCount int  = 0
	 set @studentCount = 
		(SELECT count(*) from STUDENT
				inner join GROUPA on STUDENT.IDGroup = GROUPA.IDGroup
				inner join FACULTY on GROUPA.Faculty = FACULTY.Faculty
		where FACULTY.Faculty = @faculty)
	return @studentCount
end
GO

GO
CREATE FUNCTION PulpitCount(@faculty varchar(50)) returns int
as
begin
	 DECLARE @pulpitCount int = 0
	 set @pulpitCount = 
		(SELECT count(*) from PULPIT
		 where PULPIT.Faculty = @faculty)
	return @pulpitCount
end
GO

GO
CREATE FUNCTION ProfessionCount(@faculty varchar(50)) returns int
as
begin
	 DECLARE @professionCount int = 0
	 set @professionCount = 
		(SELECT count(*) from PROFESSION
		where PROFESSION.Faculty = @faculty)
	return @professionCount
end
GO

GO
CREATE FUNCTION GroupCount(@faculty varchar(50)) returns int
as
begin
	DECLARE @groupCount int = 0
	set @groupCount =
		(SELECT count(*) from GROUPA
		where GROUPA.Faculty = @faculty)
	return @groupCount
end
GO

GO
CREATE FUNCTION FacultyReport(@c int)
returns @result table
		(
		[Факультет] varchar(50),
		[Количество кафедр] int,
		[Количество групп] int,
		[Количество специальностей] int,
		[Количество студентов] int
		)

as
begin

	DECLARE @faculty varchar(50)
	DECLARE FacultyCursor cursor local for
		SELECT Faculty From FACULTY
		where dbo.StudentCount(Faculty) > @c

	open FacultyCursor
		fetch FacultyCursor into @faculty
		while @@FETCH_STATUS = 0
		begin
			insert into @result values
			(@faculty, dbo.PulpitCount(@faculty), dbo.GroupCount(@faculty), dbo.ProfessionCount(@faculty), dbo.StudentCount(@faculty))
			fetch FacultyCursor into @faculty
		end

	close FacultyCursor
	return
end
GO	

SELECT * From dbo.FacultyReport(0)

----------------------------------------task 7----------------------------------------------------------

GO
CREATE PROCEDURE PFACULTY_REPORTX @faculty char(10) = null, @pulpit char(10) = null
as
begin

	DECLARE @currFaculty varchar(30), @currPulpit varchar(30), @subjectString varchar(300)

	DECLARE facultyCursor cursor local
	for
	SELECT faculty From FACULTY

	DECLARE pulpitCursor cursor local for 
		SELECT pulpit From PULPIT

	DECLARE @result int = 0

	open facultyCursor
	
	-- два значения null

	if(@faculty is null)
	begin
		if (@pulpit is null)
		begin
			
			fetch facultyCursor into @currFaculty
			while @@FETCH_STATUS = 0
			begin
				print 'Факультет: ' + @currFaculty
				open pulpitCursor 
				fetch pulpitCursor into @currPulpit
				while @@FETCH_STATUS = 0
				begin
					if (exists (SELECT * from PULPIT where FACULTY = @currFaculty AND PULPIT = @currPulpit)) 
					begin
						print char(9) + 'Кафедра ' + @currPulpit
						print char(9) +  char(9) + 'Количество учителей: ' +cast(dbo.fcteacher(@currPulpit) as varchar(5))
						print char(9) +  char(9) + cast(dbo.fsubjects(@currPulpit) as varchar(300))
					end
					
					fetch pulpitCursor into @currPulpit
				end
				close pulpitCursor
				fetch facultyCursor into @currFaculty
			end
			set @result = dbo.PulpitCount(@faculty)
		end
		else

		-- faculty null

		begin
			
			fetch facultyCursor into @currFaculty
			open pulpitCursor
			while @@FETCH_STATUS = 0
			begin		
				fetch pulpitCursor into @currPulpit
				while @@FETCH_STATUS = 0
				begin
					if(@currPulpit = @pulpit)
					begin
						print 'Факультет: ' + @currFaculty
						print char(9) + 'Кафедра ' + @currPulpit
						print char(9) +  char(9) + 'Количество учителей: ' +cast(dbo.fcteacher(@currPulpit) as varchar(5))
						print char(9) +  char(9) + cast(dbo.fsubjects(@currPulpit) as varchar(300))
						
					end
					fetch pulpitCursor into @currPulpit
				end
				set @result = @result + dbo.PulpitCount(@faculty)
				fetch facultyCursor into @currFaculty
			end
			close pulpitCursor
		end
	end
	else 

	-- pulpit null

	begin
		if (@pulpit is null)
		begin
			
			fetch facultyCursor into @currFaculty
			open pulpitCursor
			while @@FETCH_STATUS = 0
			begin
				if(@currFaculty = @faculty)
				begin
					print 'Факультет: ' + @currFaculty
					fetch pulpitCursor into @currPulpit
					while @@FETCH_STATUS = 0
					begin
						if (exists (SELECT * from PULPIT where FACULTY = @currFaculty AND PULPIT = @currPulpit)) 
						begin
							print char(9) + 'Кафедра ' + @currPulpit
							print char(9) +  char(9) + 'Количество учителей: ' +cast(dbo.fcteacher(@currPulpit) as varchar(5))
							print char(9) +  char(9) + cast(dbo.fsubjects(@currPulpit) as varchar(300))
						end
						fetch pulpitCursor into @currPulpit
					end
				end
				fetch facultyCursor into @currFaculty

			end
			set @result = dbo.PulpitCount(@faculty)
			close pulpitCursor
		end
		else
		begin
			-- оба не null
			fetch facultyCursor into @currFaculty
			open pulpitCursor
			while @@FETCH_STATUS = 0
			begin		
					fetch pulpitCursor into @currPulpit
					while @@FETCH_STATUS = 0
					begin
						if(@currPulpit = @pulpit)
						begin
							print 'Факультет: ' + @currFaculty
							print char(9) + 'Кафедра ' + @currPulpit
							print char(9) +  char(9) + 'Количество учителей: ' +cast(dbo.fcteacher(@currPulpit) as varchar(5))
							print char(9) +  char(9) + cast(dbo.fsubjects(@currPulpit) as varchar(300))
							
						end
						fetch pulpitCursor into @currPulpit
					end
					fetch facultyCursor into @currFaculty
			end
			set @result = dbo.PulpitCount(@faculty)
			close pulpitCursor

		end
	end

	close facultyCursor
	return @result
end
GO

DECLARE @rez int
exec @rez = PFACULTY_REPORTX 
print 'Код процедуры: ' + cast (@rez as nvarchar(10)) 
GO

DECLARE @rez int
exec @rez = PFACULTY_REPORTX @faculty = 'ХТиТ'
print ('');
print 'Код процедуры: ' + cast (@rez as nvarchar(10)) 
GO

DECLARE @rez int
exec @rez = PFACULTY_REPORTX @pulpit = 'ИСиТ'
print ('');
print 'Код процедуры: ' + cast (@rez as nvarchar(10)) 
GO
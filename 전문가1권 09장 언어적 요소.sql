/*
	�������� ���� ������ 1 / �����ڿ�
	�� 9�� �ҽ� ��ũ��Ʈ 
	������ 2000.1
*/


print '�޽���'
select '�޽���' 



DECLARE @id	int
,	@name	char(20)
SELECT @id = 10		-- �ʱ�ȭ �Ѵ�.
SELECT @id		-- �ʱ�ȭ �� ���� ����Ѵ�.
SELECT @id, 'A' 		--1)
go

DECLARE @id	int
,	@name	char(20)
SELECT @id = 10		-- �ʱ�ȭ �Ѵ�.
SELECT @id		-- �ʱ�ȭ �� ���� ����Ѵ�.
PRINT @id, 'A' -- ������ �ʴ´�.
GO


declare @var1 varchar(100)
select @var1 = formatmessage(50002, 5, 'table1')
select @var1 +'.....'
go


DECLARE��
SET��
table_loop:                            --1)
.
.
.
IF ������ GOTO table_loop                --2) 
.




IF @begin > @end
	BEGIN
		SELECT '�������ڴ� �� ��¥���� �۾ƾ� �մϴ�.'
		RETURN
	END
ELSE 
	SELECT �� FROM �� WHERE date1 BETWEEN @begin AND @end




while ����
begin
	while������ ��� ��ġ
	if ... continue
	if ... break
end



----------
EXECUTE  stored_procedure
exec sp_help



USE pubs
DECLARE 	@sql	VARCHAR(8000)
SET @sql = 'SELECT COUNT(*) FROM '	-- FROM ������ �� ĭ�� �� ĭ�� �ִ�.
SET @sql = @sql + 'titles'
select @sql

EXEC(@sql)
go


set nocount on
select * from sales
select @@rowcount
set nocount off



-------------------------
SELECT NULLIF(2,3)	--2�� ����
SELECT NULLIF(3,3)	--���� ����


SELECT COALESCE(NULL, 1, 2)	-- 1�� ����
SELECT COALESCE(1, NULL, 2)	-- 1�� ����
SELECT COALESCE(NULL, NULL, 1)	-- 1�� ����
go
SELECT COALESCE(NULL, NULL, NULL)	-- �̰� ���ϱ�?
go


SELECT x = 1
GO 5


sqlcmd /Q "SELECT COUNT(*) FROM sales" /d pubs /E /S servername\instance
go


USE tempdb
CREATE TABLE t (id int, name char(1))
GO
ALTER TABLE t
	DROP COLUMN name
--GO�� �־�� �Ѵ�.
INSERT t VALUES (1)
go

-------------------------
SELECT COUNT(*) FROM table1
SELECT COUNT(*) FROM table2
SELECT COUNT(*) FROM table3


SELECT name FROM sysobjects WHERE type = 'U'	--6.5 ���


SET NOCOUNT ON
DECLARE @name varchar(80)
SELECT @name = ' '	-- �ʱ�ȭ
WHILE @name IS NOT NULL
BEGIN
	SELECT @name = MIN(table_name) FROM information_schema.tables 
	WHERE table_type = 'base table'
-- 1)		AND table_name > @name
 	IF @name IS NOT NULL
	BEGIN		
		SELECT '������ ���̺� �̸� : ' + @name
-- 2)		EXEC ('SELECT COUNT(*) FROM [' + @name+']')
	END
END
go


use tempdb
set nocount on
go

DECLARE @i int, @sql varchar(1000)
SET @i = 0

WHILE @i < 30
BEGIN
	SET @i = @i + 1
	SET @sql = 'CREATE TABLE a' + convert(varchar(3), @i) + ' ( '
	SET @sql = @sql + 'id int)'
	select @sql
	EXEC (@sql)
END
go


select name 
from sysobjects 
where type = 'U' and name like 'a%'
order by name


DECLARE @i	INT
SET @i = 0
SELECT @i	--1)
GO

SELECT @i = @i + 100	--2)
SET @j = 100
SELECT @j = @j + @i	--3)
GO


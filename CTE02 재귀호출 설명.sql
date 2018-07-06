use tempdb
go

-- ���̺� �����
IF OBJECT_ID('dbo.Employee02', 'U') IS NOT NULL
	DROP TABLE dbo.Employee02
GO

CREATE TABLE dbo.Employee02 (
	EmpID char(5) PRIMARY KEY,
	EmpName nvarchar(10) NOT NULL,
	ManagerID char(5) REFERENCES dbo.Employee02(EmpID) NULL,
	EMail varchar(60) NULL
)
GO

INSERT INTO dbo.Employee02 VALUES('S0001', N'ȫ�浿', NULL, 'hong@test.com')
INSERT INTO dbo.Employee02 VALUES('S0002', N'������', 'S0001', 'jiemae@test.com')
INSERT INTO dbo.Employee02 VALUES('S0003', N'���쵿', 'S0001', 'kang@test.com')
INSERT INTO dbo.Employee02 VALUES('S0004', N'�Ȱ���', 'S0002', 'glass@test.com')
INSERT INTO dbo.Employee02 VALUES('S0005', N'��ġ��', 'S0003', 'kimchi@test.com')
INSERT INTO dbo.Employee02 VALUES('S0006', N'������', 'S0002', 'ohoh@test.com')
INSERT INTO dbo.Employee02 VALUES('S0007', N'�㹫��', 'S0005', 'mumu@test.com')
GO

-- 1 �׳� �״��
WITH Employees_CTE 
	AS (
		SELECT EmpID, ManagerID, EmpName
			FROM dbo.Employee02
			WHERE ManagerID IS NULL
		UNION ALL
		SELECT e.EmpID, e.ManagerID, e.EmpName
			FROM Employees_CTE AS m
			JOIN dbo.Employee02 AS e
			ON m.EmpID = e.ManagerID
	)
	SELECT * FROM Employees_CTE
GO

--2 �Ŵ��� �̸� ���ϱ�
WITH Employees_CTE 
	AS (
		SELECT EmpID, EmpName, ManagerID, empName as �Ŵ���
			FROM dbo.Employee02
			WHERE ManagerID IS NULL
		UNION ALL
		SELECT e.EmpID, e.EmpName, e.ManagerID, m.EmpName
			FROM Employees_CTE AS m
			JOIN dbo.Employee02 AS e
			ON m.EmpID = e.ManagerID
	)
	SELECT * FROM Employees_CTE  order by �Ŵ���, empID
GO

--3.���� ǥ��

--3.1 ���� ǥ�ø� ����
WITH Employees_CTE 
	AS (
		SELECT EmpID, EmpName, ManagerID, empName as �Ŵ���, 0 as ����
			FROM dbo.Employee02
			WHERE ManagerID IS NULL
		UNION ALL
		SELECT e.EmpID, e.EmpName, e.ManagerID, m.EmpName, 1 as ����
			FROM Employees_CTE AS m
			JOIN dbo.Employee02 AS e
			ON m.EmpID = e.ManagerID
	)
	SELECT * FROM Employees_CTE
	order by ����, empid
GO


--3.2 ����� ���� + 1�� ǥ�ø� �� ����
WITH Employees_CTE 
	AS (
		SELECT EmpID, EmpName, ManagerID, empName as �Ŵ���, 0 as ����
			FROM dbo.Employee02
			WHERE ManagerID IS NULL
		UNION ALL
		SELECT e.EmpID, e.EmpName, e.ManagerID, m.EmpName, m.���� + 1	--���� ����
			FROM Employees_CTE AS m
			JOIN dbo.Employee02 AS e
			ON m.EmpID = e.ManagerID
	)
	SELECT * FROM Employees_CTE
	order by ����, empid
GO


--3.3 sortKey �߰�
--����
select CAST(1 AS VARBINARY(900)) AS SortKey
select CAST(2 AS VARBINARY(900)) AS SortKey
select CAST(1 AS VARBINARY(900)) + CAST( 2 AS VARBINARY(900) )


WITH Employees_CTE ( EmpID, EmpName, ManagerID, �Ŵ���, ����, sortKey )	--���� �÷��� �ݵ�� �ʿ��ϴ�. ������ ����.
	AS (
		SELECT EmpID, EmpName, ManagerID, empName, 0 , CAST(EmpID AS VARBINARY(900)) 
			FROM dbo.Employee02
			WHERE ManagerID IS NULL
		UNION ALL
		SELECT e.EmpID, e.EmpName, e.ManagerID, m.EmpName, m.���� + 1
			, CAST(m.EmpID AS VARBINARY(900)) + CAST(e.EmpID AS VARBINARY(900) )
			FROM Employees_CTE AS m
			JOIN dbo.Employee02 AS e
			ON m.EmpID = e.ManagerID
	)
	SELECT * FROM Employees_CTE
	order by ����, empid
GO
--�޽��� 240, ���� 16, ���� 1, �� 1
--��� ���� "Employees_CTE"�� �� "sortKey"�� �ִ� ��Ŀ �κа� ��� �κ� ���� ������ ��ġ���� �ʽ��ϴ�.

--����
WITH Employees_CTE ( EmpID, EmpName, ManagerID, �Ŵ���, ����, sortKey )	--���� �÷��� �ݵ�� �ʿ��ϴ�. ������ ����.
	AS (
		SELECT EmpID, EmpName, ManagerID, empName, 0 as ����, CAST(EmpID AS VARBINARY(900)) 
			FROM dbo.Employee02
			WHERE ManagerID IS NULL
		UNION ALL
		SELECT e.EmpID, e.EmpName, e.ManagerID, m.EmpName, m.���� + 1
			, CAST( sortKey + CAST(e.EmpID AS VARBINARY(900) ) AS VARBINARY(900) )	--������ �ڷ��� ��ġ�� �䱸�ȴ�. �ڵ� ����ȯ �� �ȴ�.
			FROM Employees_CTE AS m
			JOIN dbo.Employee02 AS e
			ON m.EmpID = e.ManagerID
	)
	SELECT * FROM Employees_CTE
	order by ����, empid
GO


select replicate ('�ݺ�  | ' , 3)
--����07 ���� ����� ����ϴ� ���ν����� ������



use tempdb
go
drop table CarParts
go
CREATE TABLE CarParts
(
	CarID	int			NOT NULL
,	Part	varchar(15)
,	SubPart	varchar(15)
,	Qty		int
)
GO

INSERT CarParts VALUES(1 , 'Body' , 'Door' , 4)
INSERT CarParts VALUES(1 , 'Body' , 'Trunk Lid' , 2)
INSERT CarParts VALUES(1 , 'Body' , 'Car Hood' , 1)
INSERT CarParts VALUES(1 , 'Door' , 'Handle' , 1)
INSERT CarParts VALUES(1 , 'Door' , 'Lock' , 1)
INSERT CarParts VALUES(1 , 'Door' , 'Window' , 1)
INSERT CarParts VALUES(1 , 'Body' , 'Rivets' , 1000)
INSERT CarParts VALUES(1 , 'Door' , 'Rivets' , 100)
INSERT CarParts VALUES(1 , 'Door' , 'Mirror' , 1)
INSERT CarParts VALUES(1 , 'Car Hood
' , 'Rivets' , 100)
SELECT * FROM CarParts order by part
go

WITH CarPartsCTE(SubPart , Qty)
AS
(
	-- ��Ŀ ���(Anchor Member):
	-- CarPartsCTE �ڽ��� �������� �ʴ� SELECT ����
	SELECT SubPart , Qty
	FROM CarParts
	WHERE Part = 'Body'

	UNION ALL

	-- ��� ��� (Recursive Member):
	-- CTE(CarPartsCTE) �ڱ� �ڽ��� �����ϴ� SELECT ����
	SELECT CarParts.SubPart , CarPartsCTE.Qty * CarParts.Qty
	FROM CarPartsCTE INNER JOIN CarParts
		ON CarPartsCTE.SubPart = CarParts.Part
	WHERE CarParts.CarID = 1
)

-- ��� ����
--SELECT * FROM CarPartsCTE order by subPart
SELECT SubPart , SUM(Qty) as q
FROM CarPartsCTE
GROUP BY SubPart;

--����08 ���� ����� ����ϴ� ���ν����� ������




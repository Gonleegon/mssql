--*
--* 6.3 ������ ����
--*



--*
--* A. INSERT
--*


USE HRDB
GO

-- 1) �⺻���� INSERT ��

-- ��� �� ����
INSERT INTO dbo.Department(DeptID, DeptName, UnitID, StartDate)
   VALUES('PRD', N'��ǰ', 'A', GETDATE())
GO

SELECT * FROM dbo.Department
GO


-- ��� �� ����
INSERT INTO dbo.Department
   VALUES('DBA', N'DB����', 'A', GETDATE())
GO


-- 2) ���ÿ� ���� �� INSERT ����(2008����)

INSERT INTO dbo.Department
   VALUES('OPR', N'�', 'A', GETDATE()), ('CST', N'������', NULL, GETDATE())
GO

SELECT * FROM dbo.Department
GO

-- 3) ���� n �� INSERT

-- ���̺� �����
SELECT * 
	INTO dbo.SampleVacation
	FROM dbo.Vacation
	WHERE 1 = 0
GO

-- ���� 5 �Ǹ� INSERT
INSERT TOP (5) 
   INTO dbo.SampleVacation
   SELECT EmpID, BeginDate, EndDate, Reason, Duration
      FROM dbo.Vacation
	  ORDER BY BeginDate DESC
GO

SELECT * FROM dbo.SampleVacation
GO


-- 4) ���� ���ν��� ��� INSERT

-- ���� ���ν��� �����
CREATE PROC dbo.usp_GetVacation
	@EmpID char(5)
AS
	SELECT EmpID, BeginDate, EndDate, Duration
		FROM dbo.Vacation
		WHERE EMpID = @EmpID
GO

-- �ӽ� ���̺� �����
CREATE TABLE #Vacation (
   EmpID char(5),
   BeginDate datetime,
   EndDate datetime,
   Duration int
)
GO

-- ���� ���ν��� ��� INSERT
INSERT INTO #Vacation EXEC dbo.usp_GetVacation 'S0001'
GO

SELECT * FROM #Vacation
GO


-- 5) IDENTITY �Ӽ��� INSERT

DELETE dbo.Vacation
	WHERE VacationID = 2
GO

SELECT * FROM dbo.Vacation
GO

-- �Ϲ����� INSERT�� ���� �߻�
INSERT INTO dbo.Vacation(VacationID, EmpID, BeginDate, EndDate, Reason)
   VALUES(2, 'S0003', '2007-01-02', '2007-01-08', N'�ų� ���� ��� ����')
GO

-- ������ �� INSERT �ϱ�
SET IDENTITY_INSERT dbo.Vacation ON
GO
INSERT INTO dbo.Vacation(VacationID, EmpID, BeginDate, EndDate, Reason)
   VALUES(2, 'S0003', '2007-01-02', '2007-01-08', N'�ų� ���� ��� ����')
GO
SET IDENTITY_INSERT dbo.Vacation OFF
GO
SELECT * FROM dbo.Vacation
GO



--*
--* B. UPDATE
--*


-- 1) �⺻���� UPDATE ��

UPDATE dbo.Employee
   SET EmpName = N'ȫ����'
   WHERE EmpID = 'S0001'
GO

SELECT * 
	FROM dbo.Employee
	WHERE EmpID = 'S0001'
GO


-- 2) FROM ���� ����� �پ��� ���� ����

UPDATE dbo.Employee
   SET Salary = Salary * 0.8
   FROM dbo.Employee e1
   WHERE (SELECT COUNT (*) 
             	FROM dbo.Vacation 
		WHERE EmpID = e1.EmpID) > 2
GO


--*
--* C. DELETE
--*


-- 1) �⺻���� DELETE��

DELETE dbo.Vacation
   WHERE VacationID = 10
GO

-- TRUNCATE TABLE

TRUNCATE TABLE dbo.Vacation
GO

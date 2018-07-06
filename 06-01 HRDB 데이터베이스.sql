--*
--* 6.1 HRDB �����ͺ��̽�
--*


-- 1) �����ͺ��̽� �����

USE master
GO

IF DB_ID('HRDB') IS NOT NULL
BEGIN
    ALTER DATABASE HRDB
		SET SINGLE_USER 
		WITH ROLLBACK IMMEDIATE
	DROP DATABASE HRDB
END
GO

CREATE DATABASE HRDB
GO


-- 2) ���̺� �����

USE HRDB
GO

SET NOCOUNT ON
GO

-- Unit ���̺� �����
CREATE TABLE dbo.Unit (
	UnitID char(1) PRIMARY KEY,
	UnitName nvarchar(10) NOT NULL
)
GO

INSERT INTO dbo.Unit VALUES('A', N'��1����')
INSERT INTO dbo.Unit VALUES('B', N'��2����')
INSERT INTO dbo.Unit VALUES('C', N'��3����')
GO

-- Department ���̺� �����
CREATE TABLE dbo.Department (
	DeptID char(3) PRIMARY KEY,
	DeptName nvarchar(10) NOT NULL,
	UnitID char(1) REFERENCES dbo.Unit(UnitID) NULL,
	StartDate date NOT NULL
)
GO

INSERT INTO dbo.Department VALUES('SYS', N'�����ý���', 'A', '2007-01-01')
INSERT INTO dbo.Department VALUES('MKT', N'����', 'C', '2006-05-01')
INSERT INTO dbo.Department VALUES('HRD', N'�λ�', 'B', '2006-05-01')
INSERT INTO dbo.Department VALUES('GEN', N'�ѹ�', 'B', '2007-03-01')
INSERT INTO dbo.Department VALUES('ACC', N'ȸ��', 'B', '2006-04-01')
INSERT INTO dbo.Department VALUES('ADV', N'ȫ��', 'C', '2009-06-01')
INSERT INTO dbo.Department VALUES('STG', N'������ȹ', NULL, '2009-06-01')
GO

-- Employee ���̺� �����
CREATE TABLE dbo.Employee (
	EmpID char(5) PRIMARY KEY,
	EmpName nvarchar(4) NOT NULL,
	Gender char(1) NOT NULL,
	HireDate date NOT NULL,
	RetireDate date NULL,
	DeptID char(3) REFERENCES Department(DeptID) NOT NULL,
	EMail varchar(50) NOT NULL,
	Salary int NULL
)
GO

-- ������ �߰�
INSERT INTO dbo.Employee VALUES('S0001', N'ȫ�浿', 'M', '2006-01-01', NULL, 'SYS', 'hong@itforum.co.kr', 8500)
INSERT INTO dbo.Employee VALUES('S0002', N'������', 'M', '2006-01-12', NULL, 'GEN', 'jimae@itforum.co.kr', 8200)
INSERT INTO dbo.Employee VALUES('S0003', N'���쵿', 'M', '2006-04-01', NULL, 'SYS', 'hodong@itforum.co.kr', 6500)
INSERT INTO dbo.Employee VALUES('S0004', N'����', 'F', '2006-08-01', NULL, 'MKT', 'samsoon@itforum.co.kr',	7000)
INSERT INTO dbo.Employee VALUES('S0005', N'�����', 'M', '2007-01-01', '2009-01-31','MKT', 'samsik@itforum.co.kr', 6400)
INSERT INTO dbo.Employee VALUES('S0006', N'��ġ��', 'M', '2007-03-01', NULL, 'HRD', 'chikook@itforum.co.kr',	6000)
INSERT INTO dbo.Employee VALUES('S0007', N'�Ȱ���', 'M', '2007-05-01', NULL, 'ACC', 'ahn@itforum.co.kr', 6000)
INSERT INTO dbo.Employee VALUES('S0008', N'�ڿ���', 'F', '2007-08-01', '2007-09-30','HRD', 'yeosa@itforum.co.kr', 6300)
INSERT INTO dbo.Employee VALUES('S0009', N'�ֻ��', 'F', '2007-10-01', NULL, 'SYS', 'samo@itforum.co.kr', 5800)
INSERT INTO dbo.Employee VALUES('S0010', N'��ȿ��', 'F', '2008-01-01', NULL, 'MKT', 'hyori@itforum.co.kr', 5000)
INSERT INTO dbo.Employee VALUES('S0011', N'������', 'M', '2008-02-01', NULL, 'SYS', 'gamja@itforum.co.kr',4700)
INSERT INTO dbo.Employee VALUES('S0012', N'���ϱ�', 'M', '2008-02-01', NULL, 'GEN', 'ilkook@itforum.co.kr', 6500)
INSERT INTO dbo.Employee VALUES('S0013', N'�ѱ���', 'M', '2008-04-01', NULL, 'SYS', 'hankook@itforum.co.kr', 4500)
INSERT INTO dbo.Employee VALUES('S0014', N'���ְ�', 'M', '2008-04-01', NULL, 'MKT', 'one@itforum.co.kr', 5000)
INSERT INTO dbo.Employee VALUES('S0015', N'��ġ��', 'M', '2008-06-01', '2009-05-31','MKT', 'chichi@itforum.co.kr', 4700)
INSERT INTO dbo.Employee VALUES('S0016', N'�ѻ��', 'F', '2008-06-01', NULL, 'HRD', 'love@itforum.co.kr', 7200)
INSERT INTO dbo.Employee VALUES('S0017', N'������', 'M', '2008-12-01', NULL, 'ACC', 'yaya@itforum.co.kr', 4000)
INSERT INTO dbo.Employee VALUES('S0018', N'�̸���', 'M', '2009-01-01', '2009-06-30','HRD', 'comeon@itforum.co.kr', 5300)
INSERT INTO dbo.Employee VALUES('S0019', N'���ְ�', 'M', '2009-01-01', NULL, 'SYS', 'give@itforum.co.kr', 6000)
INSERT INTO dbo.Employee VALUES('S0020', N'�����', 'F', '2009-04-01', NULL, 'STG', 'haha@itforum.co.kr', 5000)
GO

-- Vacation ���̺� �����
CREATE TABLE dbo.Vacation (
	VacationID int IDENTITY PRIMARY KEY,
	EmpID char(5) REFERENCES dbo.Employee(EmpID),
	BeginDate date NOT NULL,
	EndDate date NOT NULL,
	Reason nvarchar(50) DEFAULT N'���λ���',
	Duration AS (DATEDIFF(day, BeginDate, EndDate) + 1),
	CHECK (EndDate >= BeginDate)
)
GO

INSERT INTO dbo.Vacation VALUES('S0001', '2006-12-24', '2006-12-26', N'ũ�������� ��� ���� ����')
INSERT INTO dbo.Vacation VALUES('S0003', '2007-01-01', '2007-01-07', N'�ų� ���� ��� ����')
INSERT INTO dbo.Vacation VALUES('S0001', '2007-05-04', '2007-05-04', N'��̳� �̺�Ʈ �غ�')
INSERT INTO dbo.Vacation VALUES('S0011', '2009-03-01', '2009-03-02', DEFAULT)
INSERT INTO dbo.Vacation VALUES('S0014', '2009-06-05', '2009-06-06', N'�θ�� ȯ����ġ')
INSERT INTO dbo.Vacation VALUES('S0019', '2010-10-08', '2010-10-16', N'�����÷�')
INSERT INTO dbo.Vacation VALUES('S0001', '2010-12-02', '2010-12-05', N'������ ����')
INSERT INTO dbo.Vacation VALUES('S0012', '2010-12-15', '2010-12-18', N'�������')
INSERT INTO dbo.Vacation VALUES('S0009', '2010-12-26', '2010-12-26', N'ũ�������� ������')
INSERT INTO dbo.Vacation VALUES('S0016', '2011-01-03', '2011-01-15', N'�޳��� ����')
GO 

SET NOCOUNT OFF
GO
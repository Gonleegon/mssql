--*
--* 6.7 ��� ���� �����ϱ�
--*


-- 1) UNION

USE HRDB
GO

-- 2008�� �Ի��� ����
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE HireDate BETWEEN '2008-01-01' AND '2008-12-31' 
GO

-- �޿��� 7,000 �̻� �޴� ����
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE Salary >= 7000
GO

-- 2008�⿡ �Ի� �߰ų� �޿��� 7,000 �̻� �޴� ����
-- UNION(�ߺ� �� �ѹ��� ǥ��)
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE HireDate BETWEEN '2008-01-01' AND '2008-12-31' 

UNION

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE Salary >= 7000
GO

-- UNION(�ߺ� ��� ǥ��)
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE HireDate BETWEEN '2008-01-01' AND '2008-12-31' 

UNION ALL

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE Salary >= 7000
GO


-- 2) INTERSECT

-- 2008�⿡ �Ի������� �޿��� 7,000 �̻� �޴� ����
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE HireDate BETWEEN '2008-01-01' AND '2008-12-31' 

INTERSECT

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE Salary >= 7000
GO


-- 3) EXCEPT

-- 2008�⿡ �Ի������� �޿��� 7,000 �̻� ������ ����
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE HireDate BETWEEN '2008-01-01' AND '2008-12-31' 

EXCEPT

SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE Salary >= 7000
GO
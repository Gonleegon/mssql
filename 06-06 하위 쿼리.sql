--*
--* 6.6 ���� ����
--*


-- 1) �Ϲ� ���� ����

-- ���� ���� �޿��� �޴� ���� ����
USE HRDB
GO

SELECT EmpID, EmpName, Salary
   FROM dbo.Employee
   WHERE Salary = (SELECT MAX(Salary) FROM dbo.Employee)
GO

-- �ް��� �� ���� �ִ� ���� ����
SELECT EmpID, EmpName, DeptID, EMail
   FROM dbo.Employee
   WHERE EmpID IN (SELECT EmpID FROM dbo.Vacation)
GO


-- 2) ��� ���� ����

-- �μ� �̸� ��������
SELECT EmpID, EmpName, DeptID, (SELECT DeptName FROM dbo.Department
	  WHERE DeptID = e.DeptID) AS 'DeptName', Salary
   FROM dbo.Employee AS e
   WHERE Salary > 7000
GO


-- 3) EXISTS

-- �ް��� �� ���� �ִ� ���� ����
SELECT EmpID, EmpName, EMail
   FROM dbo.Employee e
   WHERE EXISTS(SELECT * 
                   FROM dbo.Vacation 
                   WHERE EmpID = e.EmpID);
GO

-- �ް��� �� ���� ���� ���� ����
SELECT EmpID, EmpName, EMail 
   FROM dbo.Employee e
   WHERE NOT EXISTS(SELECT * 
                      FROM dbo.Vacation 
                      WHERE EmpID = e.EmpID)
GO
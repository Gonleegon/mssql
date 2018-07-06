--*
--* 6.8 ���� ������
--*


-- 1) TOP

USE HRDB
GO

-- �޿��� ���� �޴� ���� 5��
SELECT TOP (5) EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	ORDER BY Salary DESC
GO

-- ���� �޿��� ���� ��� ���� ��Ŵ
SELECT TOP (5) WITH TIES EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	ORDER BY Salary DESC
GO

-- �޿��� ���� �޴� ���� 14.5 �ۼ�Ʈ 
SELECT TOP (14.5) PERCENT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE RetireDate IS NULL
	ORDER BY Salary DESC
GO


-- 2) CASE

-- ����� ������ M�� F�� ��, ���� ǥ���ؼ�
SELECT EmpID, EmpName, 
		 CASE WHEN Gender = 'M' THEN N'��'
			     WHEN Gender = 'F' THEN N'��'
				 ELSE '' END AS 'Gender', DeptID, HireDate, EMail 
	FROM dbo.Employee
	WHERE RetireDate IS NOT NULL
GO

-- �Ǵ�
SELECT EmpID, EmpName, 
		 CASE Gender WHEN 'M' THEN N'��'
						   WHEN 'F' THEN N'��'
						   ELSE '' END AS 'Gender', DeptID, HireDate, EMail 
	FROM dbo.Employee
	WHERE RetireDate IS NOT NULL
GO

-- 2007 �Ի��ڿ� ���� �ٹ�, ���� ���� ���� ǥ��
SELECT EmpID, EmpName, 
		 CASE WHEN RetireDate IS NULL THEN N'�ٹ�'
				ELSE N'���' END AS 'Status', DeptID, HireDate, EMail 
	FROM dbo.Employee
	WHERE HireDate BETWEEN '2007-01-01' AND '2007-12-01'
GO


-- 3) CTE

-- �μ� �޿��� ���� 10,000 �̻��� �μ� ����
WITH DeptSalary (DeptID, Tot_Salary)
	AS (SELECT DeptID, SUM(Salary)
			FROM dbo.Employee
			WHERE RetireDate IS NULL
			GROUP BY DeptID)
SELECT * FROM DeptSalary
	WHERE Tot_Salary >=10000
GO

-- �μ� �̸� ����
WITH 
	DeptSalary (DeptID, Tot_Salary)
	AS (
		SELECT DeptID, SUM(Salary)
			FROM dbo.Employee
			WHERE RetireDate IS NULL
			GROUP BY DeptID
	)
SELECT s.DeptID, d.DeptName, d.UnitID, s.Tot_Salary 
	FROM DeptSalary AS s
	INNER JOIN dbo.Department AS d ON s.DeptID = d.DeptID
	WHERE s.Tot_Salary >=10000
GO

-- CTE ��ø: ���� �̸� ����
WITH 
	DeptSalary (DeptID, Tot_Salary)
	AS 
	(
		SELECT DeptID, SUM(Salary)
			FROM dbo.Employee
			WHERE RetireDate IS NULL
			GROUP BY DeptID
	),
	DeptNameSalary (DeptID,  DeptName, UnitID, Tot_Salary)
	AS 
	(
		SELECT s.DeptID, d.DeptName, d.UnitID, s.Tot_Salary
		FROM DeptSalary AS s
		INNER JOIN dbo.Department AS d ON s.DeptID = d.DeptID
		WHERE s.Tot_Salary >=10000
	)
SELECT s.DeptID, s.DeptName, s.UnitID, u.UnitName, s.Tot_Salary
	FROM DeptNameSalary AS s
	LEFT OUTER JOIN dbo.Unit AS u ON s.UnitID = u.UnitID
GO



-- 6) OVER 

-- ������ ���̺� �����
SELECT e.EmpID, e.EmpName, e.DeptID, d.UnitID, e.Salary
	INTO dbo.EmpTest
	FROM dbo.Employee e
	INNER JOIN dbo.Department d ON e.DeptID = d.DeptID
	LEFT OUTER JOIN dbo.Unit u ON d.UnitID = u.UnitID
	WHERE e.DeptID IN ('GEN', 'HRD', 'MKT')
	ORDER BY e.EmpID ASC
GO

SELECT * FROM dbo.EmpTest
GO

-- ��ü ����
SELECT UnitID, DeptID, EmpID, EmpName, Salary,
		COUNT(Salary) OVER(PARTITION BY UnitID) AS 'Emp_Count',
		SUM(Salary) OVER(PARTITION BY UnitID) AS 'Tot_Salary',
		AVG(Salary) OVER(PARTITION BY UnitID) AS 'Avg_Salary',
		MIN(Salary) OVER(PARTITION BY UnitID) AS 'Min_Salary',
		MAX(Salary) OVER(PARTITION BY UnitID) AS 'Max_Salary'
	FROM dbo.EmpTest
	ORDER BY UnitID, DeptID, EmpID
GO

-- �μ��� ���� ��, �̵� ���
SELECT DeptID, EmpID, EmpName, Salary,
		SUM(Salary) OVER(PARTITION BY DeptID ORDER BY EmpID) AS 'Cumulative_Total',
		AVG(Salary) OVER(PARTITION BY DeptID ORDER BY EmpID) AS 'Moving_Avg'
	FROM dbo.EmpTest
	ORDER BY DeptID, EmpID
GO

-- ��ü ���� ��, �̵� ���
SELECT EmpID, EmpName, DeptID, Salary,
		SUM(Salary) OVER(ORDER BY EmpID) AS 'Cumulative_Total',
		AVG(Salary) OVER(ORDER BY EmpID) AS 'Moving_Avg'
	FROM dbo.EmpTest
	ORDER BY EmpID
GO

-- ROWS ���� �Բ� ���
-- ROW ����ؼ� ���� �� ������ ������ �ΰ� ������ â ����
SELECT UnitID, DeptID, EmpID, EmpName, Salary,
		SUM(Salary) OVER(
				PARTITION BY UnitID 
				ORDER BY DeptID 
				ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS 'Cumulative_Total',
		AVG(Salary) OVER(
				PARTITION BY UnitID 
				ORDER BY DeptID 
				ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS 'Moving_Avg'
	FROM dbo.EmpTest
	ORDER BY UnitID, DeptID
GO

-- ROWS ���� �Բ� UNBOUNDED PRECEDING�� ����
-- PARTITION ù��° ��ּ� ����
SELECT UnitID, DeptID, EmpID, EmpName, Salary,
		SUM(Salary) OVER(
				PARTITION BY UnitID 
				ORDER BY DeptID 
				ROWS UNBOUNDED PRECEDING) AS 'Cumulative_Total',
		AVG(Salary) OVER(
				PARTITION BY UnitID 
				ORDER BY DeptID 
				ROWS UNBOUNDED PRECEDING) AS 'Moving_Avg'
	FROM dbo.EmpTest
	ORDER BY UnitID, DeptID
GO



-- 7) OFFSET AND FETCH

USE HRDB
GO

-- ���ǿ� �´� ��� �� ��������
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	ORDER BY EmpID
GO

-- ó�� 3���� �����ϰ� ��������
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	ORDER BY EmpID 
	OFFSET 3 ROWS
GO

-- ó������ 5�� ��������
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	ORDER BY EmpID 
    OFFSET 0 ROWS
    FETCH NEXT 5 ROWS ONLY
GO

-- �� ����ϱ� 
DECLARE @StartNum tinyint = 2, @EndNum tinyint = 5
SELECT EmpID, EmpName, DeptID, HireDate, EMail, Salary
	FROM dbo.Employee
	WHERE DeptID IN ('SYS', 'MKT') AND RetireDate IS NULL
	ORDER BY EmpID 
    OFFSET @StartNum - 1  ROWS
    FETCH NEXT @EndNum - @StartNum + 1  ROWS ONLY
GO


-- 
select * into c from charge
create index ix on c (charge_amt)

select * from c where charge_amt not between 1 and 4999

WHERE �μ��ڵ� = 3	--�μ��ڵ�: char(3) 

drop table m
select * into m from member
update m set city = '3' where member_no < 10
create index ix on m (city)
go

                     [Credit].[dbo].[m].city = ��Į�� ������('3')
CONVERT_IMPLICIT(int,[Credit].[dbo].[m].[city],0)=(3)

select * from m where city = '3'
select * from m where city = N'3'
select * from m where convert(int, city) = 3



WHERE �μ��ڵ� = 3	--�μ��ڵ�: char(3) 

WHERE char_type = N'�����ڵ�'

WHERE �����ڵ� = 1	--�����ڵ�: bit

WHERE ��¥ = 19790314	--��¥: char(8)

WHERE ��¥ = '19790314'
@sql = '�� WHERE ��¥ = ' + @�˻��� 
@sql = '�� WHERE ��¥= ' + '''@�˻���'''
select SQRT(3)
SELECT * FROM charge WHERE charge_amt < SQRT(3)
SELECT * FROM charge WHERE charge_amt < CONVERT(money, SQRT(3))
SELECT * FROM charge WHERE charge_amt < 1.73


/*
CONVERT_IMPLICIT(float(53),[Credit].[dbo].[charge].[charge_amt],0)<sqrt(CONVERT_IMPLICIT(float(53),[@1],0))

[Credit].[dbo].[charge].[charge_amt]<CONVERT(money,sqrt(CONVERT_IMPLICIT(float(53),[@1],0)),0)

�˻� Ű[1]: ����: [Credit].[dbo].[charge].charge_amt > ��Į�� ������([Expr1004]), ��: [Credit].[dbo].[charge].charge_amt < ��Į�� ������([Expr1005])
*/



DECLARE @��ɹ� varchar(3000)
,	@������ varchar(8)
SET @������ = '20061024'
SET @��ɹ� = 'SELECT ... FROM ... WHERE �Ǹ��� = '
SET @��ɹ� = @��ɹ� + @������
SET @��ɹ� = @��ɹ� + '''+ @������+ '''





select * from c
create index cx on c (charge_dt)
dbcc show_statistics (c, cx)


select * from c where charge_dt < '2005-11-14 17:09:48'

declare @������ datetime = '2005-11-14 17:09:48'
select * from c where charge_dt < @������

select * from c where charge_dt between '2004.1.1' and '2005-11-14 17:09:48'
select DATEDIFF(s, '2004.1.1' , '2005-11-14 17:09:48')

select * from c where charge_dt between '2004.1.1' and DATEADD (s, 59072988, '2004.1.1')



declare @������ datetime = '2005-11-14 17:09:48'
select * from c where charge_dt between @������ and @������ + 7

select * from c where charge_dt >= GETDATE() - 7
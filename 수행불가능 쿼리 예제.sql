/*
	�̿ϼ��� ������ �ϼ�����. ������ �����ϰ� ���� �����ؾ� �Ѵ�.
*/
use pubs
go
--1. note�� recipe ��� ���ڰ� �ְ� ������ 10�̻� 20����.
select * from titles
where notes like '%recipe%' and price between 10 and 20
go 


--2. �������� 1991�� 7�� �����̰�, �丮�� ���õ� å (type �� cook ���� ������)
select * from titles
where pubdate > '1991-07-01' and type like '%cook'
go


--3. �Ǹ� ������ NULL �� ���� ��������, ���� ����(price)�� null ���� 0���� �ٲ� '����'�� �Ʒ� ����� ���� ����Ѵ�. 
/*
å��ȣ	price	����		title
MC3026	NULL	0.00	The Psychology of Computer Cooking
PC9999	NULL	0.00	Net Etiquette
*/

select  å��ȣ, price, title from titles
select å��ȣ, price ,ISNULL (price,0) as ���� , title from titles
where price is NULL
go

--4. �Ǹ� ���� 20�� �̻��̰�, ��������(payterms)�� Net 60 �̰ų�, ON invoice �� ��
select * from sales
where 20 <= qty and payterms like 'Net 60'
or 20 <= qty and payterms like 'on invoice'
go

--5. ������ ���� �ȸ� ������� ����Ѵ�. ����� �Ʒ��� �� ���ƾ� �Ѵ�.
/*
stor_id	qty	title_id
6380	5	BU1032
6380	3	PS2091
7066	75	PS2091
7066	50	PC8888
7067	40	TC3218
7067	20	TC4203
7067	20	TC7777
7067	10	PS2091
7131	25	MC3021
7131	25	PS2106
7131	25	PS7777
7131	20	PS1372
7131	20	PS2091
7131	15	PS3333
7896	35	BU2075
7896	15	BU7832
7896	10	MC2222
8042	30	PC1035
8042	25	BU1111
8042	15	MC3021
8042	10	BU1032
*/
select * from sales
SELECT stor_id,qty,title_id from sales
order by stor_id
go

FROM table1 WITH (INDEX(0))

WHERE au_lname LIKE ���ڹ�%'	
WHERE SUBSTRING (au_lname,1,2)='�ڹ�'
WHERE LEFT(au_lname,2)='�ڹ�'

WHERE titles.title_id = sales.title_id 
WHERE salary = commission
WHERE salary <= 500

WHERE salary != 3000

@�̸� = '���߱�'
WHERE �̸� = @�̸�
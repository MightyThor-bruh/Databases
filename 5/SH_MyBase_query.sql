USE SH_MyBase;
SELECT ����������.����_������_��_������, ����������.���������, �����.�������������
    From ����������, �����
	Where ����������.id_�������������� = �����.���_���������� 
	and �����.���_������������ In(SELECT �����.���_������������ From ����� 
	                                                      Where (�����.���_������������ Like '%���'))

SELECT ����������.����_������_��_������, ����������.���������, �����.�������������
    From ���������� INNER JOIN �����
	On ����������.id_�������������� = �����.���_���������� 
	and �����.���_������������ In(SELECT �����.���_������������ From ����� 
	                                                      Where (�����.���_������������ Like '%���'))

--??????????????????????????????????????
SELECT ��������_������������, ����������
    From ������������ a
	Where �������_�������� = (SELECT top(1) �������_�������� From ������������ aa
	                                 Where aa.��������_������������ = a.��������_������������)

SELECT ��������_������������ From ������������
    Where not exists (SELECT * From ����� Where �����.���_������������ = ������������.��������_������������)

SELECT Top 1 
    (SELECT avg(����������) From ������������) [������� ��������]
	From ������������

SELECT ��������_������������, ���������� From ������������
    Where ���������� >=all (SELECT ���������� From ������������ Where ��������_������������ like '%���')

SELECT ��������_������������, ���������� From ������������
    Where ���������� >=any (SELECT ���������� From ������������ Where ��������_������������ like '%���')
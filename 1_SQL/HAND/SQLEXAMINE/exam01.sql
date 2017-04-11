SELECT * FROM USER_TABLES;

--1.��ѯ"J2SE"���ſΣ�������60����������70��������֮���ѧ����Ϣ��
--�ֱ������ֱȽϲ���������ʾ��ѧ�������������� ��6�֣�
SELECT *
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO
   AND CORES.CORE BETWEEN 60 AND 70
   AND CORES.COURSE_NO =
       (SELECT COURSE_NO FROM HAND_COURSE WHERE COURSE_NAME = 'J2SE');

--2.��ѯ����15�����ϵ���ʦ����Ϣ���Լ�����ʦ����Щѧ����
--��ʾ����ʦ������ѧ������)���������ظ��С���5�֣�
SELECT COUR_TEAC.TEACHERNO AS TEACHER_NO,
       (SELECT TEACHER_NAME
          FROM HAND_TEACHER
         WHERE TEACHER_NO = COUR_TEAC.TEACHERNO) AS TEACHER_NAME,
       STUDENTNAME AS STUDENT_NAME
  FROM (SELECT COURSE.COURSE_NO   AS COURSENO,
               COURSE.COURSE_NAME AS COURSENAME,
               COURSE.TEACHER_NO  AS TEACHERNO
          FROM HAND_COURSE COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15)) COUR_TEAC,
       (SELECT CORES.COURSE_NO AS COURSENO,
               (SELECT STUDENT_NAME
                  FROM HAND_STUDENT
                 WHERE STUDENT_NO = CORES.STUDENT_NO) AS STUDENTNAME
          FROM HAND_STUDENT_CORE CORES) SOUR_STU
 WHERE COUR_TEAC.COURSENO = SOUR_STU.COURSENO;

--3.��ѯÿ����ʦ���ڿ��˴Σ���������ʦ��A��B�����γ̣�A��B�����γ̷ֱ���3����5��ѧ��ѡ����ô����ʦ���ڿ��˴�Ϊ8��
--��ʾ����ʦ�������ڿ��˴Σ�����5�֣�
SELECT TEA.TEACHER_NAME, COUNT(CORES.STUDENT_NO)
  FROM HAND_TEACHER TEA, HAND_COURSE COUR, HAND_STUDENT_CORE CORES
 WHERE TEA.TEACHER_NO = COUR.TEACHER_NO
   AND COUR.COURSE_NO = CORES.COURSE_NO
 GROUP BY TEA.TEACHER_NAME;
 
--4.��ѯѧ��"������"��ʦ����"����"��ʦ�Ŀε�ͬѧ��
--��ʾ��ѧ�š����������������ظ��С���6�֣�
--a.��ȡ������ʦ�ı��
SELECT TEACHER_NO, TEACHER_NAME
  FROM HAND_TEACHER
 WHERE TEACHER_NAME IN ('����', '������');
--b.����id��ȡ��λ��ʦ�̵Ŀγ�id
SELECT COURSE_NO, COURSE_NAME
  FROM HAND_COURSE
 WHERE TEACHER_NO IN (SELECT TEACHER_NO
                        FROM HAND_TEACHER
                       WHERE TEACHER_NAME IN ('����', '������'));
--c.���ݿγ�no��ȡѧ�����
SELECT STUDENT_NO
  FROM HAND_STUDENT_CORE
 WHERE COURSE_NO IN
       (SELECT COURSE_NO
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE TEACHER_NAME IN ('����', '������')));
--d.����ѧ��no��ȡѧ����Ϣ
SELECT STUDENT_NO, STUDENT_NAME
  FROM HAND_STUDENT
 WHERE STUDENT_NO IN
       (SELECT STUDENT_NO
          FROM HAND_STUDENT_CORE
         WHERE COURSE_NO IN
               (SELECT COURSE_NO
                  FROM HAND_COURSE
                 WHERE TEACHER_NO IN
                       (SELECT TEACHER_NO
                          FROM HAND_TEACHER
                         WHERE TEACHER_NAME IN ('����', '������'))));

--5.��ѯ����ѧ����ѡ����Ϣ����û��ѡ�Σ�Ĭ����ʾѡ��Ϊ"J2SE"���ڿ���ʦΪ"����"������Ϊ�ա�
--��ʾ��ѧ�š�������ѡ�Ρ���������6�֣�
SELECT STU.STUDENT_NO ѧ��,
       STU.STUDENT_NAME ����,
       NVL((SELECT COURSE_NAME
             FROM HAND_COURSE
            WHERE COURSE_NO = CORES.COURSE_NO),
           'J2SE') ѡ��,
       CORES.CORE ����
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO(+);

--6.��ѯ��ѧ��"����"��ʦ��ѧ��"����"��ʦ�Ŀε�ѧ����Ϣ��
--�ֱ������·�ʽ��
-- a�����ϡ���4�֣�
-- b�������Ϸ�ʽ�����������ʽ����4�֣�
--��b
--a.��ȡ������ʦ�ı��
SELECT TEACHER_NO, TEACHER_NAME
  FROM HAND_TEACHER
 WHERE TEACHER_NAME IN ('����', '����');
--b.����id��ȡ��λ��ʦ�̵Ŀγ�id
SELECT COURSE_NO, COURSE_NAME, TEACHER_NO
  FROM HAND_COURSE
 WHERE TEACHER_NO IN (SELECT TEACHER_NO
                        FROM HAND_TEACHER
                       WHERE TEACHER_NAME IN ('����', '����'));
--c.���ݿγ�id��ȡѧ���ı��
SELECT CORES.STUDENT_NO, COUNT(CORES.COURSE_NO)
  FROM HAND_STUDENT_CORE CORES
 WHERE COURSE_NO IN
       (SELECT COURSE_NO
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE TEACHER_NAME IN ('����', '����')))
 GROUP BY CORES.STUDENT_NO
HAVING COUNT(CORES.COURSE_NO) > 1;

--d.���ݱ�Ż�ȡѧ����Ϣ , it's ok
SELECT *
  FROM HAND_STUDENT
 WHERE STUDENT_NO IN (SELECT CORES.STUDENT_NO
                        FROM HAND_STUDENT_CORE CORES
                       WHERE COURSE_NO IN
                             (SELECT COURSE_NO
                                FROM HAND_COURSE
                               WHERE TEACHER_NO IN
                                     (SELECT TEACHER_NO
                                        FROM HAND_TEACHER
                                       WHERE TEACHER_NAME IN ('����', '����')))
                       GROUP BY CORES.STUDENT_NO
                      HAVING COUNT(CORES.COURSE_NO) > 1);

--7.��ѯ���ſγ̵�ƽ���֣�����2λС����С��λ�������룬��λС������ʾ����������88������ʾ��88.00����
--��ʾ���γ̱�ţ��γ����ƣ�ƽ���֣���5�֣� 
SELECT CORES.COURSE_NO AS �γ̱��,
       (SELECT COURSE_NAME
          FROM HAND_COURSE
         WHERE COURSE_NO = CORES.COURSE_NO) AS �γ�����,
       TO_CHAR(ROUND(AVG(CORES.CORE), 2), '999.99') AS ƽ����
  FROM HAND_COURSE COUR, HAND_STUDENT_CORE CORES
 WHERE COUR.COURSE_NO = CORES.COURSE_NO
 GROUP BY CORES.COURSE_NO;

--8.��ѯ��ÿ��ѧ�������пγ�ƽ���֣������ѡ��A�γ�60�֣�B�γ�80�֣���ô����ƽ����Ϊ70�֣�,���Ӹߵ��ͽ�������
--��ʾ��ѧ��������ƽ���֣���6�֣�
SELECT STU.STUDENT_NAME AS ѧ������,
       TO_CHAR(ROUND(AVG(CORES.CORE), 2), '999.99') AS ƽ����
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO
 GROUP BY STU.STUDENT_NAME
 ORDER BY ƽ����;

--9.��ѯ��ÿ�ſγ�ѧ�����������Ӹߵ��ͽ��������÷�����������
--��ͬ�ķ���������һ�����������򣬱��磬��2����һ����1���ڶ�����������Ϊ1��1��2��
--��ʾ���γ�����ѧ�����������������Σ���7�֣�

--10.�����¸�ʽ����ѯ��ʾ����ѧ����J2ST��Java Web��SSH���ſεĳɼ���û�гɼ��ģ���ʾΪ�ա���7�֣�
--ѧ������   j2se   java web    ssh
SELECT STU.STUDENT_NAME,
       DECODE(COURSE_NAME, 'J2SE', CORES.CORE, NULL) AS "J2SE",
       DECODE(COURSE_NAME, 'Java Web', CORES.CORE, NULL) AS "Java Web",
       DECODE(COURSE_NAME, 'SSH', CORES.CORE, NULL) "SSH"
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES, HAND_COURSE COUR
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO(+)
   AND CORES.COURSE_NO = COUR.COURSE_NO(+);

--11.��ѯ��ʦ"����"���µĸ�����ʦ�ı�ż�����:�������ܵĽ�ʦҲ��Ҫ��ʾ����
--��ʾ����ʦ��š���ʦ���ơ����ܱ�š��������ƣ���7�֣�

--12.������ſγ��У���������ƽ���ֵ�ѧ����Ϣ��
--��ʾ��ѧ���������γ����ơ�ѧ���ķ�������7�֣�
--a.��ȡƽ����
SELECT AVG(CORE) FROM HAND_STUDENT_CORE GROUP BY COURSE_NO;
--b.��ȡѧ����Ϣ, it's ok!
SELECT STU.STUDENT_NAME AS ѧ������,
       (SELECT COURSE_NAME
          FROM HAND_COURSE
         WHERE COURSE_NO = CORES.COURSE_NO) AS �γ�����,
       CORES.CORE AS ����,
       (SELECT TO_CHAR(ROUND(AVG(CORE), 2), '999.99')
          FROM HAND_STUDENT_CORE
         WHERE COURSE_NO = CORES.COURSE_NO
         GROUP BY COURSE_NO) ƽ����
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO
   AND CORES.CORE < (SELECT AVG(CORE)
                       FROM HAND_STUDENT_CORE
                      WHERE COURSE_NO = CORES.COURSE_NO
                      GROUP BY COURSE_NO);

--13.�ֱ���ݽ�ʦ����ʦ�Ϳγ̡��γ̡�ȫ�������ĸ�ά�ȣ�ͳ��ѡ�ε�ƽ��������
--��ʾ����ʦ���ơ��γ����ơ�ƽ���֣���7�֣�
SELECT TEA.TEACHER_NAME ��ʦ����,
       COUR.COURSE_NAME �γ�����,
       TO_CHAR(ROUND(AVG(CORES.CORE), 2), '999.99') ƽ����
  FROM HAND_TEACHER TEA, HAND_COURSE COUR, HAND_STUDENT_CORE CORES
 WHERE TEA.TEACHER_NO = COUR.TEACHER_NO
   AND COUR.COURSE_NO = CORES.COURSE_NO
 GROUP BY TEA.TEACHER_NAME, COUR.COURSE_NAME;

--14.����60���£�������60��û��ѧ�֣�60����������70������������1��ѧ�֣�
--70����������90������������2��ѧ�֣�90����������100����������3��ѧ�֣�
--��ѯ����ѧ�ֳ���3�ֵ�ѧ����Ϣ����ʾ��ѧ��������ѧ����������8�֣�
--a.
SELECT *
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO;

--���ݿ�����
SELECT * FROM HAND_STUDENT;
SELECT * FROM HAND_TEACHER;
SELECT * FROM HAND_COURSE;
SELECT * FROM HAND_COURSE_TIME;
SELECT * FROM HAND_STUDENT_CORE;

SELECT (TO_CHAR(SYSDATE, 'yyyy') > 2015) FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'yyyy') FROM DUAL;

SELECT MONTHS_BETWEEN(TO_DATE('2016-12-12', 'yyyy-mm-dd'),
                      TO_DATE('2016-10-20', 'yyyy-mm-dd'))
  FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'yyyy') FROM DUAL;

--2.��ѯ����15�����ϵ���ʦ����Ϣ���Լ�����ʦ����Щѧ����
--��ʾ����ʦ������ѧ������)���������ظ��С���5�֣�
--a.15�깤�����ʦ
SELECT *
  FROM HAND_TEACHER
 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15;
--b.15�깤����ʦ���Ŀ�
SELECT *
  FROM HAND_COURSE
 WHERE TEACHER_NO IN
       (SELECT TEACHER_NO
          FROM HAND_TEACHER
         WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15);
--c.ѡ��15�깤����ʦ�Ŀγ̵�ѧ�����
SELECT *
  FROM HAND_STUDENT_CORE
 WHERE COURSE_NO IN
       (SELECT COURSE_NO
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15));
--d.����b���c��
SELECT DISTINCT (SELECT TEACHER_NAME
          FROM HAND_TEACHER
         WHERE TEACHER_NO = BTAB.TEACHER_NO),
       (SELECT STUDENT_NAME
          FROM HAND_STUDENT
         WHERE STUDENT_NO = CTAB.STUDENT_NO)
  FROM (SELECT *
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15)) BTAB,
       (SELECT *
          FROM HAND_STUDENT_CORE
         WHERE COURSE_NO IN
               (SELECT COURSE_NO
                  FROM HAND_COURSE
                 WHERE TEACHER_NO IN
                       (SELECT TEACHER_NO
                          FROM HAND_TEACHER
                         WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15))) CTAB
 WHERE BTAB.COURSE_NO = CTAB.COURSE_NO;

--���ݿ�����
SELECT * FROM HAND_STUDENT;
SELECT * FROM HAND_TEACHER;
SELECT * FROM HAND_COURSE;
SELECT * FROM HAND_COURSE_TIME;
SELECT * FROM HAND_STUDENT_CORE;



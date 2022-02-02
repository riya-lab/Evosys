SELECT 
		username, 
		default_tablespace, 
		profile, 
		authentication_type
	FROM
		dba_users 
	WHERE 
		account_status = 'OPEN'
	ORDER BY
		username;
        
GRANT create session TO c##erpuser;
GRANT create table TO  c##erpuser;
GRANT create view TO c##erpuser;
GRANT create any trigger TO c##erpuser;
GRANT create any procedure TO c##erpuser;
GRANT create sequence TO c##erpuser;
GRANT create synonym TO c##erpuser;
GRANT ALL PRIVILEGES TO c##erpuser;

GRANT CONNECT TO c##erpuser;
GRANT RESOURCE TO c##erpuser;
GRANT DBA TO c##erpuser;

connect c##erpuser/Riya

CREATE TABLE DEPT    (
		DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
		DNAME VARCHAR2(14), 
		BRANCHNO	INT CONSTRAINT FK_DEPT_BRANCHNO REFERENCES BRANCH
	) ;
    
ALTER TABLE DEPT
    MODIFY DNAME VARCHAR2(14) NOT NULL UNIQUE;
    
CREATE TABLE EMP(
		EMPNO 		NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
		ENAME 		VARCHAR2(10),
		JOB 		VARCHAR2(9),
		MGR 		NUMBER(4),
		HIREDATE 	DATE,
		SAL 		NUMBER(7,2),
		COMM 		NUMBER(7,2),
		DEPTNO 		NUMBER(2) CONSTRAINT FK_EMP_DEPTNO REFERENCES DEPT,
		BRANCHNO 	INT CONSTRAINT FK_EMP_BRANCHNO REFERENCES BRANCH
	);  
INSERT INTO BRANCH VALUES 	(101,'Geneva','NEW YORK');
	INSERT INTO BRANCH VALUES 	(102,'Geneva','NEW YORK');
	INSERT INTO BRANCH VALUES 	(103,'CHICAGO','CHICAGO');
	INSERT INTO BRANCH VALUES 	(104,'CHICAGO','CHICAGO');
	INSERT INTO BRANCH VALUES 	(105,'Kingston','NEW YORK');
	INSERT INTO BRANCH VALUES 	(106,'Kingston','NEW YORK');
    
INSERT INTO DEPT VALUES	(10,'ACCOUNTING',101);
	INSERT INTO DEPT VALUES        (20,'RESEARCH',103);
	INSERT INTO DEPT VALUES	(30,'SALES',105);
	INSERT INTO DEPT VALUES	(40,'OPERATIONS',106);
    
INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20,102);
INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30,102);
INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30,103);
INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20,104);
INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30,105);
INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30,105);
INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10,102);
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20,103);
INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,NULL,101);
INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30,104);
INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20,105);
INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30,103);
INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20,105);
INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10,104);
INSERT INTO EMP VALUES(7901,'JOHN_SMITH','CLERK',7698,to_date('23-1-1982','dd-mm-yyyy'),3000,NULL,30,104);


COMMIT;

 SELECT  * FROM dept;
    SELECT deptno,dname,branchno FROM dept;
    
SELECT 
    empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno  
FROM
emp
ORDER BY 
empno;

SELECT 
    empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno  
FROM
    emp
ORDER BY
    deptno;
    
SELECT 
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno    
FROM
    emp
ORDER BY
    deptno,empno;
    
SELECT 
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno    
FROM
    emp
ORDER BY
    deptno,empno DESC;
    
SELECT
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno
FROM 
    emp
ORDER BY
    deptno,sal;
    
SELECT 
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno
FROM 
    emp
ORDER BY
    sal;
    
SELECT 
    empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno
FROM
    emp
WHERE deptno=10;

SELECT 
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno=10 or deptno=20;
SELECT 
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno IN (10,20);
    
SELECT
    empno,ename,deptno
FROM
    emp
WHERE
    deptno not in (10,20,30);
    
SELECT
    empno,ename,deptno
FROM
    emp
WHERE
    deptno is null;
    
SELECT
    empno,ename,deptno
FROM
    emp
WHERE
    deptno is not null;
    
SELECT
    empno,ename,comm
FROM
    emp
WHERE 
    comm is null or comm = 0;
    
SELECT
    empno,ename,sal
FROM
    emp
WHERE
    sal>=1000 and sal<=3000
ORDER BY
    sal;
    
    

SELECT
    empno,ename,sal
FROM
    emp
WHERE
    sal BETWEEN 1000 AND 3000
ORDER BY
    sal;
    
SELECT
    empno,ename,sal
FROM
    emp
WHERE
    sal>1000 and sal<3000
ORDER BY
    sal;

SELECT
    empno,ename,sal
FROM
    emp
WHERE
    sal BETWEEN 1001 AND 2999
ORDER BY
    sal;

SELECT
    empno,ename,sal
FROM
    emp
WHERE
    sal BETWEEN (1000+1) AND (3000-1)
ORDER BY
    sal;
    
SELECT
    empno,ename,sal
FROM
        emp
WHERE
    sal not between 1000 and 3000
ORDER BY
    sal;
    
SELECT
    empno,ename,sal
FROM
    emp
WHERE
    sal=5000
ORDER BY 
    sal;

SELECT
    empno,ename
FROM
    emp
WHERE
    ename='SMITH'
ORDER BY
    ename;
--    below query won't return any record as data saved in a cell is Case Sensetive
SELECT
    empno,ename
FROM
    emp
WHERE
    ename='Smith'
ORDER BY
    ename;   
    
SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE 'S%'
ORDER BY
    ename;    
    
SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%S'
ORDER BY
    ename; 

SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%LL%'
ORDER BY
    ename; 
    
--SELECT
--    empno,ename
--FROM
--    emp
--WHERE
--    ename LIKE '%\_%' ESCAPE '\' 
--ORDER BY
--    name;    
SELECT
    COUNT(*)
FROM 
    emp;
    
SELECT
    COUNT(*),COUNT(deptno),COUNT(EMPNO)
FROM
    emp;
    
SELECT
    MIN(sal),MAX(sal),SUM(sal),AVG(sal),COUNT(sal)
FROM 
    emp;
SELECT
        deptno,count(empno)
FROM
        emp
GROUP BY 
        deptno
ORDER BY 
        deptno;
        
SELECT
        job,count(empno)
FROM
        emp
GROUP BY 
        job
ORDER BY 
        count(empno);
        
SELECT
    deptno,min(sal),max(sal),avg(sal),sum(sal)
FROM
    emp
GROUP BY
        deptno
ORDER BY 
        deptno;

SELECT
    deptno,min(sal),max(sal),round(avg(sal),2),sum(sal)
FROM
    emp
GROUP BY
        deptno
HAVING 
        deptno=30
ORDER BY 
        deptno;
        
SELECT 
    deptno,min(sal),max(sal),avg(sal),sum(sal)
FROM
        emp
GROUP BY
        deptno
HAVING 
        avg(sal)<2500
ORDER BY
        deptno;
        
        
-- ################################################################
SELECT
    empno,ename,sal,comm, sal+comm
FROM 
    emp
ORDER BY
    empno;

-- correct solution


SELECT
    empno,ename,sal,comm, sal+nvl(comm,0)
FROM 
    emp
ORDER BY
    comm;
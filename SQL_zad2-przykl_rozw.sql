--1
SELECT *
FROM emp e 
WHERE e.sal = (SELECT MIN(sal)
               FROM emp);


--2
SELECT *
FROM emp e 
WHERE e.job = ( SELECT job 
                FROM emp 
                WHERE ename = 'BLAKE');
                
--3
SELECT *
FROM emp e 
WHERE e.sal IN (SELECT MIN(sal) 
                FROM emp
                GROUP BY deptno);
				
--4
SELECT *
FROM emp e 
WHERE e.sal > ANY(SELECT sal 
                  FROM emp
                  WHERE deptno=30);
                  
SELECT *
FROM emp e 
WHERE e.sal > (SELECT MIN(sal)
               FROM emp
               WHERE deptno=30);
			   
--5
SELECT *
FROM emp e 
WHERE e.sal > ALL(SELECT sal 
                  FROM emp
                  WHERE deptno=30);
				  

SELECT *
FROM emp e
WHERE e.sal > (SELECT MAX(sal)
			   FROM emp
			   WHERE deptno = 30);
                            
--6
SELECT d.dname 
FROM emp e JOIN dept d ON d.deptno = e.deptno
GROUP BY e.deptno, d.dname
HAVING AVG(e.sal) > (SELECT AVG(e2.sal)
                     FROM emp e2
                     WHERE e2.deptno = 30);


--7
SELECT e.*
FROM emp e
WHERE e.sal = (SELECT MAX(e2.sal)
               FROM emp e2
               WHERE e2.deptno = e.deptno);                     
                     
			 
--8
SELECT * 
FROM emp e
WHERE EXISTS (SELECT 1 
              FROM emp e2 
              WHERE e2.mgr = e.empno);

--9
SELECT * 
FROM emp e
WHERE NOT EXISTS (SELECT 1 
                  FROM dept d
                  WHERE d.deptno = e.deptno);
--bez korelacji
SELECT * 
FROM emp e
WHERE e.deptno NOT IN (SELECT deptno 
                       FROM dept);

--10
SELECT e.ename, e.sal, e.deptno, s.grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal >  (SELECT AVG(e2.sal)
                FROM emp e2 JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
                WHERE s2.grade = s.grade);
				
--11
SELECT e.ename, e.sal, s.grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal = (SELECT MIN(e2.sal)
               FROM emp e2 JOIN salgrade s2 ON e2.sal BETWEEN s2.losal AND s2.hisal
               WHERE s2.grade = s.grade)
ORDER BY s.grade;


--12
SELECT e.ename, e.sal, e.deptno, sub.av "Œrednia w departamencie"
FROM (SELECT ROUND(AVG(e2.sal),2) av, e2.deptno 
      FROM emp e2 
      GROUP BY e2.deptno) sub 
      JOIN emp e on sub.deptno = e.deptno
WHERE e.sal > sub.av;            
                     
-- 트랜잭션 (Transaction)
USE shop;

-- 재고 테이블
CREATE TABLE inven(
	ino INT PRIMARY KEY AUTO_INCREMENT,
	pid VARCHAR(20),
	qty INT
);

-- 판매 테이블
CREATE TABLE sale(
	sno INT PRIMARY KEY AUTO_INCREMENT,
	pid VARCHAR(2),
	qty INT
);

SHOW TABLES;

-- 입고
INSERT INTO inven(pid, qty) VALUES('a001', 12);
INSERT INTO inven(pid, qty) VALUES('b001', 25);
INSERT INTO inven(pid, qty) VALUES('c001', 18);

INSERT INTO inven(pid, qty) VALUES('a001', 11);
INSERT INTO inven(pid, qty) VALUES('b001', 19);
INSERT INTO inven(pid, qty) VALUES('c001', 14);

SELECT pid, SUM(qty) AS '재고합계' FROM inven GROUP BY pid;

CREATE VIEW pro_view1 AS (SELECT pid, SUM(qty) AS '재고합계' FROM inven GROUP BY pid);

SELECT * FROM inven;

SELECT * FROM pro_view1;

-- 출고

-- 트랜잭션 처리가 되지 않으면, 재고 처리 시스템에 문제가 발생하므로
-- 이러한 경우 간혹 차집합으로 연산하는 경우가 있음.
-- 그러나 테이블의 변화를 예측하기가 힘든 현상이 발생하기 때문에 사용하지 않는 것이 좋음.
-- 집합은 분기별로 관리할때나 사용됨.
CREATE VIEW jk AS (SELECT * FROM inven EXCEPT SELECT * FROM sale);

SELECT * FROM inven;

START TRANSACTION;

SAVEPOINT a;

INSERT INTO sale(pid, qty) VALUES('a001', 5);
UPDATE inven SET qty=qty-14 WHERE pid='a001';

SELECT * FROM sale;

UPDATE inven SET qty=qty-14 
WHERE pid='a001' AND ino=(SELECT MIN(ino) FROM inven WHERE pid='a001' GROUP BY pid);

COMMIT;			-- 전부 반영

ROLLBACK;		-- 전부 롤백

ROLLBACK TO a;	-- 해당 SAVEPOINT 내용만 롤백

CREATE TABLE student(
	sno INT PRIMARY KEY AUTO_INCREMENT,
	sname VARCHAR(100),
	kor INT,
	eng INT,
	mat INT
);

-- 5명의 학생 성적 데이터를 추가
INSERT INTO student(sname, kor, eng, mat) VALUES('손현우', 85, 95, 97);
INSERT INTO student(sname, kor, eng, mat) VALUES('이민혁', 86, 94, 81);
INSERT INTO student(sname, kor, eng, mat) VALUES('유기현', 95, 96, 87);
INSERT INTO student(sname, kor, eng, mat) VALUES('채형원', 88, 94, 94);
INSERT INTO student(sname, kor, eng, mat) VALUES('이주헌', 87, 85, 88);
INSERT INTO student(sname, kor, eng, mat) VALUES('임창균', 89, 94, 97);

SELECT * FROM student;

SELECT sname AS '이름', kor + eng + mat AS '총점', (kor + eng + mat)/3 AS '평균' 
FROM student;

-- if(조건식, 참일때 값, 거짓일때 값)

SELECT 
	sname AS '이름', kor + eng + mat AS '총점', ROUND((kor + eng + mat)/3) AS '평균', 
	IF((kor + eng + mat)/3 >= 80, '합격', '불합격') AS '판정'
FROM student;

-- 조건 예시 : ROUND((점수1+점수2+점수3)/3) BETWEEN 90 AND 100
-- case
-- 	when 조건1 then 조건1이 만족할 때 값
-- 	when 조건2 then 조건2이 만족할 때 값
-- 	when 조건3 then 조건3이 만족할 때 값
-- 	else 어떠한 조건도 만족하지 않을 경우의 값
-- end

SELECT 
	sname AS '이름', 
	kor + eng + mat AS '총점', 
	ROUND((kor + eng + mat)/3) AS '평균', 
	IF((kor + eng + mat)/3 >= 80, '합격', '불합격') AS '판정',
	CASE
		WHEN (ROUND((kor + eng + mat)/3) BETWEEN 90 AND 100) THEN 'A'
		WHEN (ROUND((kor + eng + mat)/3) BETWEEN 80 AND 89) THEN 'B'
		WHEN (ROUND((kor + eng + mat)/3) BETWEEN 70 AND 79) THEN 'C'
		ELSE 'F'
	END AS '등급'
FROM student;
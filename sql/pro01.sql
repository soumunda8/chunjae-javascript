-- 테이블 목록 보기
SHOW TABLES;

-- 회원(member) 테이블 생성
CREATE TABLE MEMBER(
	id VARCHAR(16) NOT NULL,
	pw VARCHAR(330) NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	tel VARCHAR(13),
	regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	POINT INT DEFAULT 0,
	PRIMARY KEY (id)
);

-- 회원 테이블 구조 보기
DESC member;

-- 더미 데이터 추가
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('admin', '1234', '관리자', 'admin@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('kim', '4321', '김리자', 'kim@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('lee', '2345', '이리자', 'lee@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('park', '5432', '박리자', 'park@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('choi', '3456', '최리자', 'choi@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('shin', '6543', '신리자', 'shin@edu.com', '010-5555-5555');

-- 회원 테이블 검색
SELECT * FROM member;

-- 게시판(board) 테이블 생성
CREATE TABLE board(
	bno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(1000),
	author VARCHAR(16),
	resdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	cnt INT DEFAULT 0
);

-- 게시판 테이블 구조 보기
DESC board;

-- 더미 데이터 추가
INSERT INTO board(title, content, author) VALUES('더미글1', '여기는 더미글1입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글2', '여기는 더미글2입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글3', '여기는 더미글3입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글4', '여기는 더미글4입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글5', '여기는 더미글5입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글6', '여기는 더미글6입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글7', '여기는 더미글7입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글8', '여기는 더미글8입니다', 'admin');
INSERT INTO board(title, content, author) VALUES('더미글9', '여기는 더미글9입니다', 'lee');

-- 게시판 테이블 검색
SELECT * FROM board;

DELETE FROM member WHERE id='shin';   -- 아이디가 shin 인 회원의 레코드 삭제

UPDATE board SET author='lee' WHERE bno=5;   -- bno가 5인 레코드의 작성자 아이디를 lee로 변경

COMMIT;

-- 7번 글에 대한 작성자의 이름
SELECT * FROM member WHERE id = 'admin';
SELECT author FROM board WHERE bno=7;
SELECT * FROM MEMBER SELECT author FROM board WHERE bno=7;

-- 일치 검색
SELECT * FROM member WHERE NAME IN ('관리자', '이리자');
SELECT * FROM member WHERE NAME ='관리자' OR NAME ='이리자';

-- 유사 검색
SELECT * FROM member WHERE NAME LIKE '김%';
SELECT * FROM member WHERE NAME LIKE '%리%';

-- 중복성 제거
SELECT DISTINCT author FROM board;

-- 구간 검색
SELECT * FROM board WHERE bno BETWEEN 3 AND 6;
SELECT * FROM board WHERE bno >=3 AND bno <=6;
-- 구간 검색 : MySQL, MariaDB 에서만 사용 가능
SELECT * FROM board LIMIT 2, 4;

-- 이중쿼리 (=, >=, <=, !=, ...) : select 문을 이중으로 사용
SELECT id, NAME FROM member WHERE id=(SELECT author FROM board WHERE bno=9);
-- 일치 검색
SELECT id, NAME FROM member WHERE id IN(SELECT author FROM board);
-- 불일치 검색
SELECT id, NAME FROM member WHERE id NOT IN(SELECT author FROM board);

-- 연관 쿼리와 join
-- 연관 쿼리(alias 활용)
SELECT * FROM member a, board b;   -- 5 * 9 -> 45건, 13개 항목
SELECT a.id, a.name, a.email, b.bno, b.title FROM member a, board b;   -- 45건, 5개 항목
SELECT a.id AS pid, a.name AS pname, a.email AS pemail, b.bno AS pno, b.title AS ptitle FROM member a, board b;
SELECT a.id AS pid, a.name AS pname, a.email AS pemail, b.bno AS pno, b.title AS ptitle FROM member a, board b WHERE a.id = b.author;   -- 게시판에 글을 올린 회원정보와 글 정보를 모두 표시

-- 내부 조인
SELECT a.id, a.name, a.email, b.bno, b.title FROM member a INNER JOIN board b ON a.id = b.author;

-- 테이블 복제 : 키에 대한 복제는 이루어지지 않는다.
CREATE TABLE board2 AS SELECT * FROM board;

-- 기본키 추가
ALTER TABLE board2 ADD CONSTRAINT PRIMARY KEY (bno);

-- 컬럼 수정 - auto_increment 추가
ALTER TABLE board2 MODIFY bno INT AUTO_INCREMENT;

SELECT * FROM board2;

DESC board2;

-- 내부 조인을 하나의 뷰로 생성
CREATE VIEW writer_info AS (SELECT a.id, a.name, a.email, b.bno, b.title FROM member a INNER JOIN board b ON a.id = b.author);

-- 생성된 뷰의 결과 출력
SELECT * FROM writer_info;

-- 읽은 횟수 증가
UPDATE board SET cnt=cnt+1 WHERE bno=2;

-- sort(소트) = 분류, 순서정렬
-- asc : 오름차순[default 값]
-- desc : 내림차순
SELECT * FROM board;

-- 정렬
SELECT * FROM board ORDER BY author ASC, cnt DESC;

-- 그룹화 및 집계(group by -> count, sum, avg, max, min, ...)
SELECT author, COUNT(author) FROM board GROUP BY author;



-- 테이블 만들기 및 예시 데이터 추가
-- [카테고리] 도서:0001, 온라인강의:0002, 오프라인강의:0003, 콘서트:0004
-- [결제수단] 계좌이체:1, 신용카드:2, 체크카드:3, 쿠폰:4
-- 더미데이터는 본인이 임의로 각자 12건 이상 추가하되
-- 상품 데이터는 교육, 서적, 동영상강의 등의 카테고리를 본인이 정하여 추가할 것.
-- 현재 회원의 내용을 기준으로 구매한 판매데이터를 추가할 것.

-- 테이블명 : 상품(product)
-- 상품코드 : gcode - 정수 / 일련번호 (기본키) - 필수입력
-- 상품명 : gname - 문자열(150) - 필수입력
-- 종류 : gcate - 문자열(40) - 필수입력
-- 단가 : gprice - 정수 - 필수입력
-- 수량 : gqty - 정수 - 기본값:0
-- 등록일 : regdate - 날짜 - 기본값:오늘 날짜 및 시간

CREATE TABLE product(
	gcode INT PRIMARY KEY AUTO_INCREMENT,
	gname VARCHAR(150) NOT NULL,
	gcate VARCHAR(40) NOT NULL,
	gprice INT NOT NULL,
	gqty INT DEFAULT 0,
	regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DESC product;

INSERT INTO product(gname, gcate, gprice, gqty) VALUES('집에일찍가는법', '0001', 25000, 5);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('JAVA의 정석', '0001', 31000, 2);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('강사님 몰래 집 가는 법', '0001', 15000, 4);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('나는 지금 뭐하는가', '0001', 25000, 10);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('정보처리기사-필기 인강', '0002', 45000, 5);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('정보처리기사-실기 인강', '0002', 50000, 2);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('정보처리기사-필기+실기 인강', '0002', 85000, 2);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('풀스택강의', '0003', 175000, 8);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('빅데이터강의', '0003', 225000, 2);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('PM강의', '0003', 185000, 5);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('강사님의 코딩 콘서트', '0004', 85000, 10);
INSERT INTO product(gname, gcate, gprice, gqty) VALUES('강사님의 유잼 콘서트', '0004', 95000, 5);

SELECT * FROM product;

-- 테이블명 : 판매(sales)
-- 판매코드 : scode - 정수 / 일련번호(기본키) - 필수입력
-- 상품코드 : gcode - 정수 - 필수입력
-- 구매자 : id - 문자열(16) - 필수입력
-- 수량 : qty - 정수 - 기본값:1 - 필수입력
-- 구매단가 : sprice - 정수 - 필수입력
-- 결제수단 : stype - 정수 - 필수입력
-- 할인금액 : distotal - 정수
-- 결제금액 : paytotal - 정수
-- 총금액 : stot - 정수
-- 판매일 : saledate - 날짜 - 기본값:오늘날짜 및 시간

CREATE TABLE sales(
	scode INT PRIMARY KEY AUTO_INCREMENT,
	gcode INT NOT NULL,
	id VARCHAR(16) NOT NULL,
	qty INT DEFAULT 1 NOT NULL,
	sprice INT NOT NULL,
	stype INT NOT NULL,
	distotal INT,
	paytotal INT,
	stot INT,
	saledate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DESC sales;

INSERT INTO sales(gcode, id, sprice, stype) VALUES('1', 'park', 25000, 1);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('2', 'choi', 31000, 2);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('2', 'park', 31000, 2);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('8', 'lee', 175000, 1);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('5', 'choi', 45000, 1);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('11', 'choi', 85000, 1);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('7', 'shin', 85000, 3);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('12', 'lee', 95000, 1);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('4', 'park', 25000, 4);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('10', 'lee', 185000, 3);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('5', 'park', 45000, 2);
INSERT INTO sales(gcode, id, sprice, stype) VALUES('6', 'shin', 50000, 2);

SELECT * FROM sales;
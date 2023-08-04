-- 회원(member) 테이블 생성
CREATE TABLE MEMBER(
	id VARCHAR(16) NOT NULL,
	pw VARCHAR(330) NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	tel VARCHAR(13),
	regdate TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,
	POINT INT DEFAULT 0,
	PRIMARY KEY (id));

-- 테이블 목록 보기	
SHOW TABLES;

-- 회원 테이블 구조 보기	
DESC MEMBER;

-- 더미 데이터 추가
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('admin', '1234', '관리자', 'admin@edu.com', '010-1004-1004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('kim', '4321', '김현경', 'kim@edu.com', '010-7979-2848');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('lee', '1111', '이소윤', 'lee@edu.com', '010-2424-2424');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('hwang', '7979', '황교진', 'hwang@edu.com', '010-2848-7979');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('oh', '2222', '오세훈', 'oh@edu.com', '010-2222-1234');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES 
('shin', '3333', '신승원', 'shin@edu.com', '010-3333-3333');

-- 회원 테이블 조회
SELECT * FROM MEMBER;


-- 게시판(board) 테이블 생성
CREATE TABLE board(
	bno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(1000),
	author VARCHAR(16),
	resdate TIMESTAMP NOT NULL default CURRENT_TIMESTAMP,
	cnt INT DEFAULT 0);

-- 게시판 테이블 구조 보기
DESC board;

-- 게시판 더미글 추가 8건
INSERT INTO board(title, content, author) VALUES 
('더미글1', '여기는 더미글1입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글2', '여기는 더미글2입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글3', '여기는 더미글3입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글4', '여기는 더미글4입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글5', '여기는 더미글5입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글6', '여기는 더미글6입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글7', '여기는 더미글7입니다', 'admin');
INSERT INTO board(title, content, author) VALUES 
('더미글8', '여기는 더미글8입니다', 'lee');

-- 게시판 테이블 검색
SELECT * FROM board;
SELECT * FROM MEMBER;

DELETE FROM MEMBER WHERE id='shin';		
-- 아이디 shin인 회원의 레코드 삭제

UPDATE board SET author='lee' WHERE bno=5;	
-- 글번호 5인 레코드의 작성자 아이디를 lee로 변경

COMMIT;

SELECT * FROM MEMBER WHERE id='admin';		-- 
SELECT author FROM board WHERE bno=7;		-- 

-- 일치 검색
SELECT * FROM MEMBER WHERE NAME IN ('김현경','오세훈','황교진');
SELECT * FROM MEMBER WHERE NAME='김현경' OR NAME='오세훈' OR NAME='황교진';	-- 

-- 유사 검색 
SELECT * FROM MEMBER WHERE NAME LIKE '김%'; -- 
SELECT * FROM MEMBER WHERE NAME LIKE '%세%'; -- 

-- 중복성 제거
SELECT DISTINCT author FROM board;  -- 

-- 구간 검색
SELECT * FROM board WHERE bno >=3 AND bno <=6;  --
SELECT * FROM board WHERE bno BETWEEN 3 AND 6;  -- 
SELECT * FROM board LIMIT 2, 4;

-- 7번 글에 대한 작성자의 이름
-- 이중쿼리(=, >=, <=, !=,,,,) : select 문을 이중으로 사용
SELECT id, name from member WHERE 
id=(SELECT author FROM board WHERE bno=8); -- 
-- 일치 검색(in)
SELECT id, NAME FROM MEMBER WHERE 
id IN(SELECT author FROM board);  -- 
-- 불일치 검색(not~in~)
SELECT id, NAME FROM MEMBER WHERE 
id not IN(SELECT author FROM board);  --

-- 연관쿼리와 join
-- 연관쿼리(alias 활용)
SELECT * FROM MEMBER a, board b;	-- 7 * 8 -> 56건, 13개 항목

SELECT a.id, a.name, a.email, b.bno, b.title from MEMBER a, board b; 
-- 56건, 5개 항목

SELECT a.id AS pid, a.name AS pname, a.email AS pemail, b.bno AS pno, b.title AS ptitle from MEMBER a, board b;

SELECT a.id AS pid, a.name AS pname, a.email AS pemail, b.bno AS pno, b.title AS ptitle from MEMBER a, board b WHERE a.id=b.author; 
-- 게시판에 글을 올린 회원정보와 글정보를 모두 표시

-- 내부 조인
SELECT a.id, a.name, a.email, b.bno, b.title FROM MEMBER a INNER JOIN board b ON a.id=b.author;

-- 테이블 복제 : 키와 auto_inrement 에 대한 복제는 이루어지 않는다.
CREATE TABLE board2 AS SELECT * FROM board;

-- 기본 키 추가
ALTER TABLE board2 ADD CONSTRAINT PRIMARY KEY (bno);

-- 컬럼 수정 - auto_increment 추가
ALTER TABLE board2 modify bno INT AUTO_INCREMENT;

SELECT * FROM board2;

DESC board2;

-- 내부 조인을 하나의 뷰로 생성
CREATE VIEW writer_info AS (SELECT a.id, a.name, a.email, b.bno, b.title FROM MEMBER a INNER JOIN board b ON a.id=b.author);

-- 생성된 뷰의 결과 출력
SELECT * FROM writer_info;

-- 읽은 횟수 증가
UPDATE board SET cnt=cnt+1 WHERE bno=7;

-- sort(소트) = 분류, 순서정렬
SELECT * FROM board;

-- 정렬
SELECT * FROM board ORDER BY author ASC, cnt DESC;

-- 그룹화 및 집계(group by -> count, sum, avg, max, min....
SELECT author, COUNT(author) FROM board GROUP BY author;





-- 테이블 만들기 및 예시 데이터 추가
-- 테이블명 : 상품(goods)
-- 상품코드 : gcode - 정수 / 일련번호(기본키) - 필수입력
-- 상품명 : gname - 문자열(150) - 필수입력
-- 종류 : gcate - 문자열(40) - 필수입력
-- 단가 : gprice - 정수 - 필수입력
-- 수량 : gqty - 정수 - 기본값:0
-- 등록일 : regdate - 날짜 - 기본값:오늘날짜 및 시간

-- 테이블명 : 판매(sales)
-- 판매코드 : scode - 정수 / 일련번호(기본키) - 필수입력
-- 상품코드 : gcode - 정수 - 필수입력
-- 구매자 : id - 문자열(16) - 필수입력
-- 수량 : qty - 정수 - 기본값:1 - 필수입력
-- 구매단가 : sprice - 정수 - 필수입력
-- 결제수단 : stype - 정수 - 필수입력
-- 할인금액 : distotal - 정수
-- 결제금액 : paytotal - 정수
-- 총금액 : stotal - 정수
-- 판매일 : saledate - 날짜 - 기본값:오늘날짜 및 시간

-- 더미데이터는 본인이 임의로 각자 12건 이상 추가하되
-- 상품 데이터는 교육, 서적, 동영상강의 등의 카테고리를 본인이 정하여 추가할 것.
-- 현재 회원과 현존하는 상품 내용을 기준으로  구매한 판매데이터를 추가할 것.







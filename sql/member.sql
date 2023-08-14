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
DESC MEMBER;

-- 더미 데이터 추가
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('admin', '1234', '관리자', 'admin@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('kim', '4321', '최상민', 'kim@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('lee', '2345', '황교진', 'lee@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('park', '5432', '이슬비', 'park@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('choi', '3456', '김이호', 'choi@edu.com', '010-1004-1004');
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES('shin', '6543', '박나연', 'shin@edu.com', '010-5555-5555');
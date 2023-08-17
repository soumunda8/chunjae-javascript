create table exam1(no INTEGER, name varchar(50));

-- point 컬럼 추가
alter table exam1 add column point INTEGER;

-- id 컬럼 추가
alter table exam1 add column id varchar(100);

-- id의 컬럼명을 sid로 변경
alter table exam1 rename column id to sid;

-- name의 타입을 100글자 타입으로 변경 - 컬럼타입 변경
alter table exam1 alter column name type varchar(100);

select * from exam1;

-- shop 데이터베이스에 테이블 설계 및 생성
-- 공지사항 (notice)
-- 컬럼명   참고      타입         제약조건
-- 번호     no       숫자(정수)    기본키, 자동증가
-- 제목 	  title    문자(200)    널 값 허용안함
-- 내용 	  title    문자(1000)    널 값 허용안함
-- 작성일	 resdate  날짜/시간     기본값 : 현재날짜/시간
-- 읽은횟수 visited   숫자(정수)   기본값 : 0

-- 시퀀스 방법
-- CREATE SEQUENCE notice_no;

create table notice(
	-- 시퀀스 방법
	-- no INTEGER primary key DEFAULT nextval('notice_no'),
	no serial primary key,
	title varchar(200) not null,
	content varchar(1000) not null,
	resdate timestamp DEFAULT CURRENT_TIMESTAMP,
	visited INTEGER DEFAULT 0
);

-- 더미데이터
insert into notice(title, content) values('공지1입니다.', '공지1관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지2입니다.', '공지2관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지3입니다.', '공지3관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지4입니다.', '공지4관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지5입니다.', '공지5관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지6입니다.', '공지6관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지7입니다.', '공지7관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지8입니다.', '공지8관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지9입니다.', '공지9관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지10입니다.', '공지10관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지11입니다.', '공지11관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지12입니다.', '공지12관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지13입니다.', '공지13관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지14입니다.', '공지14관련 내용을 적어봅니다.');
insert into notice(title, content) values('공지15입니다.', '공지15관련 내용을 적어봅니다.');

select * from notice;

-- 고객(custom

create table custom(
	id varchar(20) primary key,
	pw varchar(300) not null,
	name varchar(100) not null,
	point INTEGER DEFAULT 0,
	grade varchar(4) DEFAULT 'F',
	tel varchar(11) not null,
	email varchar(100) not null,
	birth timestamp not null,
	regdate timestamp DEFAULT current_timestamp
);

-- 더미데이터
insert into custom(id, pw, name, tel, email, birth) values('admin', '1234', '관리자', '01052224111', 'damin@edu.com', '2000-08-17 10:23:54');
insert into custom(id, pw, name, tel, email, birth) values('kim', '1234', '김땡자', '01012345678', 'kim@edu.com', '1999-07-27 10:23:54');
insert into custom(id, pw, name, tel, email, birth) values('lee', '1234', '이땡자', '01087654321', 'lee@edu.com', '1998-12-27 10:23:54');
insert into custom(id, pw, name, tel, email, birth) values('park', '1234', '박땡자', '01085214597', 'park@edu.com', '1998-05-27 10:23:54');
insert into custom(id, pw, name, tel, email, birth) values('choi', '1234', '최땡자', '01052635263', 'choi@edu.com', '1995-07-30 10:23:54');
insert into custom(id, pw, name, tel, email, birth) values('hwang', '1234', '황땡자', '01012345678', 'hwang@edu.com', '1999-12-15 10:23:54');
insert into custom(id, pw, name, tel, email, birth) values('han', '1234', '한땡자', '01054548575', 'han@edu.com', '1996-04-05 10:23:54');

select * from custom;

-- 이용후기, 상품, 판매, 결제, 입고출고이력

-- 결제 테이블
create table payment(
	no serial primary key,
	payType varchar(300) not null,
	payBank varchar(300) not null,
	payNum varchar(300) not null
);

-- 상품테이블
create table product(
	no serial primary key,
	proName varchar(330)
);

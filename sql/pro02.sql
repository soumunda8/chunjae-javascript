USE shop;

CREATE TABLE customer(
	customerid VARCHAR(15) PRIMARY KEY COMMENT '고객id',
	customername VARCHAR(50) NOT NULL COMMENT '고객명',
	customertype VARCHAR(50) NOT NULL COMMENT '고객구분',
	country VARCHAR(50) NOT NULL COMMENT '국적',
	city VARCHAR(50) NOT NULL COMMENT '국적',
	state VARCHAR(50) COMMENT '주',
	postcode INT COMMENT '우편번호',
	regiontype VARCHAR(50) COMMENT '지역구분'
);


CREATE TABLE buy(
	seq INT(10) PRIMARY KEY AUTO_INCREMENT COMMENT '순번',
	orderid VARCHAR(15) NOT NULL COMMENT '주문id',
	orderdate TIMESTAMP COMMENT '주문일자',
	shipdate TIMESTAMP COMMENT '배송일자',
	customerid VARCHAR(15) COMMENT '고객id',
	productid VARCHAR(15) COMMENT '제품id',
	quantity INT(10) COMMENT '주문수량',
	discount DECIMAL(10,2) COMMENT '할인금액'
);


CREATE TABLE product(
	productid VARCHAR(15) PRIMARY KEY COMMENT '제품id',
	bigcategory VARCHAR(50) NOT NULL COMMENT '대분류명',
	subcategory TIMESTAMP COMMENT '소분류명',
	productname VARCHAR(100) NOT NULL COMMENT '제품명',
	price DECIMAL(10,2) COMMENT '가격'
);



--대단위 데이터 csv 파일을 해당 테이블에 import 하기 : 현재 폴더 위치를 맞춰서 command 창에서 실행하기
LOAD DATA LOCAL INFILE 'customer.csv' INTO TABLE customer FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'buy.csv' INTO TABLE buy FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'product.csv' INTO TABLE product FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';


-- 해당 테이터를 csv로 export 하기
-- 해당 테이블 먼저 검색(select)
SELECT * FROM product;
-- 검색 결과에서 전체 선택한 후 마우스 오른쪽 [격자 행 내보내기]
-- 내보낼 타입을 Excel csv 선택하고, 해당 파일의 이름과 경로를 지정
-- 내보내기


-- 테이블 삭제
DROP TABLE customer;
DROP TABLE buy;
DROP TABLE product;

COMMIT;


-- 테이블 목록보기
SHOW TABLES;


-- sql 파일 실행하여 sql 명령을 실행하기 : 현재 폴더 위치를 맞춰서 command 창에서 실행하기
SOURCE test2.sql;

DESC customer;

-- ------------------------ 웹 시작 ---------------------------------

Customer cus = NEW customer();
cus.setCustomerid(request.getParameter("customerid"));
cus.setCustomername(request.getParameter("customername"));
cus.setCustomertype(request.getParameter("customertype"));
cus.setCountry(request.getParameter("country"));
cus.setCity(request.getParameter("city"));
cus.setState(request.getParameter("state"));
cus.setPostcode(Integer.parseInt(request.getParameter("postcode")));
cus.setRegiontype(request.getParameter("regiontype"));
cusInsert(cus);

-- 고객 등록
INSERT INTO customer VALUES('AK-10880', 'Alien Kim', 'Consumer', 'South Korea', 'Seoul', 'Seoul', 18517, 'West');

-- 웹에서  회원등록
public void cusInsert(Customer cus) {
	INSERT INTO customer VALUES(?, ?, ?, ?, ?, ?, ?, ?);
	pstmt.setString(1, cus.getCustomerid());
	pstmt.setString(2, cus.getCustomername());
	pstmt.setString(3, cus.getCustomertype());
	pstmt.setString(4, cus.getCountry());
	pstmt.setString(5, cus.getCity());
	pstmt.setString(6, cus.getState());
	pstmt.setInt(7, cus.getPostcode());
	pstmt.setString(8, cus.getRegiontype());
}


-- 고객 정보 변경
UPDATE customer SET country='America', city='Los Angels', state='Los Angels' WHERE customerid='AK-10880';

-- 웹에서 데이터 변경
UPDATE customer SET country=?, city=?, state=? WHERE customerid=?;
pstmt.setString(1, cus.getCountry());
pstmt.setString(2, cus.getCity());
pstmt.setString(3, cus.getState());
pstmt.setString(4, cus.getCustomerid());


-- 고객 삭제
DELETE FROM customer WHERE customerid='AK-10880';

-- 웹에서 고객 삭제
DELETE FROM customer WHERE customerid=?;
pstmt.setString(1, customerid);

-- ------------------------ 웹 종료 ---------------------------------

COMMIT;

SELECT * FROM customer WHERE customername LIKE '%kim%';

SELECT * FROM customer WHERE customername LIKE '%kim%' AND city='Seoul';

SELECT COUNT(*) AS cnt FROM customer WHERE customername LIKE '%kim%';
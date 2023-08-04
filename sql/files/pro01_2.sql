USE shop;

CREATE TABLE customer(
	customerid VARCHAR(15) PRIMARY KEY COMMENT '고객id',
	customername varchar(50) not null comment '고객이름',
	customertype varchar(50) null comment '고객구분',
	country varchar(50) null comment '국적',
	city varchar(50) null comment '도시',
	state varchar(50) null comment '주',
	postcode int null comment '우편번호',
	regiontype varchar(50) null comment '지역구분'
);	

create table buy(
	seq int(10) primary key AUTO_INCREMENT comment '순번',
	orderid varchar(15) not null comment '주문id',
	orderdate datetime comment '주문일자',
	shipdate datetime comment '배송일자',
	customerid varchar(15) comment '고객id',
	productid varchar(15) comment '제품id',
	quantity int(10) comment '주문수량',
	discount decimal(10,2) comment '할인금액'
);

create table product(
	productid varchar(15) not null primary key comment '제품id',
	bigcategory varchar(50) not null comment '대분류명',
	subcategory varchar(50) comment '소분류명',
	productname varchar(100) not null comment '제품명',
	price decimal(10,2) comment '가격'
);

DESC customer;

DESC buy;

DESC product;

-- 대단위 데이터 csv 파일을  해당  테이블에 import 하기

LOAD DATA LOCAL INFILE 'customer.csv' INTO TABLE customer FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

SELECT * FROM customer;

LOAD DATA LOCAL INFILE 'buy.csv' INTO TABLE buy FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

SELECT * FROM buy;

LOAD DATA LOCAL INFILE 'product.csv' INTO TABLE product FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';


-- 해당 데이터를 csv로 export 하기
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

-- 테이블 목록 보기
SHOW TABLES;

-- sql 파일 실행하여 sql 명령을 실행하기
SOURCE test2.sql;

DESC customer;

Customer cus = NEW Customer();
cus.setCustomerid(request.getParameter("customerid"));
cus.setCustomername(request.getParameter("customername"));
cus.setCustomertype(request.getParameter("customertype"));
cus.setCountry(request.getParameter("contry"));
cus.setCity(request.getParameter("city"));
cus.setState(request.getParameter("state"));
cus.setPostcode(Integer.parseInt(request.getParameter("postcode")));
cus.setRegiontype(request.getParameter("regiontype"));
cusInsert(cus);
-- 고객 등록
INSERT INTO customer VALUES('AK-10880', 'Alien Kim', 'Consumer', 'South Korea', 'Seoul', 'Seoul', 18517, 'West');

-- 웹에서 고객등록
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

-- 웹에서 고객 정보 변경
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


COMMIT;

SELECT * FROM customer WHERE customername LIKE '%Kim%';

SELECT * FROM customer WHERE customername LIKE '%Kim%' AND city='Seoul';

SELECT COUNT(*) AS cnt FROM customer WHERE customername LIKE '%Kim%';

USE shop;

SHOW TABLES;

SELECT * FROM buy;

-- customerid 별로 그룹화하여 customerid, 제품거래건수, 총수량, 평균 할인율을 출력하라
SELECT customerid, COUNT(productid) AS '제품거래건수', SUM(quantity) AS '총수량', AVG(discount) AS '평균할인율' FROM buy GROUP BY customerid;

-- buy 테이블에서 할인율이 가장 작은 거래 정보를 수량(quantity)의 내림차순으로 출력하시오.
-- (단, 수량이 같은 경우 주문일(oderdate)의 오름차순으로 하시오.)

SELECT * FROM buy WHERE discount = (SELECT min(discount) FROM buy) ORDER BY quantity DESC, orderdate asc;

-- 배송일(shipdate)의 년도별로 총수량의 합계와 총수량의 평균, 총수량의 최대값을 집계하시오.(년도를 추출하는 함수는 year임.)

SELECT YEAR(shipdate) AS '년도', SUM(quantity) AS '총합계', AVG(quantity) AS '총평균', MAX(quantity) AS '최대배송량' FROM buy GROUP BY YEAR(shipdate);



-- 주문일(oderdate)의 년도와 월별로 주문수량(quantity)의 합계와 평균 할인율을 집계하시오.(date_format 함수를 사용.)
-- date_format(컬럼, 형식)
-- (단, 주문량 합계가 0인 것은 제외할 것.)

SELECT DATE_FORMAT(orderdate, '%Y-%m') AS '년월', SUM(quantity) AS '주문량합계', AVG(discount) AS '할인율평균' FROM buy GROUP BY DATE_FORMAT(orderdate, '%Y-%m') HAVING SUM(quantity) != 0;

SELECT * FROM customer;

-- 제품번호(productid)가 FUR로 시작하는 가구 종류를 구매한 고객정보 중에서
-- 고객명(customername), 국가(country), 도시(city)를 출력하되, 고객id(customerid)의 내림차순으로 하고, 고객id가 같은 경우 주문수량(quantity)의 오름차순으로 할 것.
-- 이중쿼리, 연관쿼리, 내부조인 등 원하는 방식으로 해결할 것.

SELECT a.customername, a.country, a.city FROM customer a, buy b WHERE a.customerid = b.customerid AND b.productid LIKE 'FUR%' ORDER BY a.customerid DESC, b.quantity ASC; 

 SELECT a.customername, a.country, a.city FROM customer a INNER JOIN buy b ON a.customerid = b.customerid where b.productid LIKE 'FUR%' ORDER BY a.customerid DESC, b.quantity ASC;

SELECT * FROM product;

-- 제품(product) 테이블로 부터 가격(price)이 40 이상인 제품을 검색하여 제품2(product2) 테이블을 생성하시오.(고가 상품 테이블 = product2)

-- 제품(product) 테이블로 부터 가격(price)이 40 미만인 제품을 검색하여 제품3(product3) 테이블을 생성하시오.(저가 상품 테이블 = product3)

CREATE TABLE product2 AS (SELECT * FROM product WHERE price >= 40);

CREATE TABLE product3 AS (SELECT * FROM product WHERE price < 40);

-- 제품3(product3) 테이블로 부터 price가 0인 레코드를 삭제하시오.

DELETE FROM product3 WHERE price <= 0;

SELECT * FROM product2;

SELECT * FROM product3;

-- 제품명(productname)에 "(큰따옴표)가 있는 데이터의 "(큰따옴표)를 제거하시오.
UPDATE product2 SET productname=SUBSTRING(productname, 2, LENGTH(productname)-1) WHERE productname LIKE '\"%'; 

UPDATE product3 SET productname=SUBSTRING(productname, 2, LENGTH(productname)-1) WHERE productname LIKE '\"%'; 

-- UNION : 중복을 제거하여 합집합
-- UNION ALL : 중복 포함하여 합집합

create view uni_tab1 AS (SELECT productid, price FROM product2 UNION SELECT productid, price FROM product3); 

create view int_tab1 AS (SELECT productid, price FROM product2 INTERSECT SELECT productid, price FROM product3); 

create view exc_tab1 AS (SELECT productid, price FROM product EXCEPT SELECT productid, price FROM product2);

SELECT * FROM uni_tab1;
SELECT * FROM int_tab1;
SELECT * FROM exc_tab1;


-- 제품2(product2)와 제품3(product3)의 테이블 데이터를 합집합하여 전체상품(totpro)의 테이블을 생성하시오.

CREATE TABLE totpro AS (SELECT * FROM product2 UNION SELECT * FROM product3);

-- 제품(product)와 제품3(product3)의 테이블 데이터를 차집합하여 제거상품(revpro)의 테이블을 생성하시오.

CREATE TABLE revpro AS (SELECT * FROM product EXCEPT SELECT * FROM product3);

-- 제품(product)와 제품2(product2)의 테이블 데이터를 교집합하여 인기상품(hotpro)의 테이블을 생성하시오.
CREATE TABLE hotpro AS (SELECT * FROM product INTERSECT SELECT * FROM product2);

DESC buy;

SELECT * FROM buy;

-- 웹과 데이터베이스

-- 특정 고객의 주문정보를 검색
SELECT * FROM buy WHERE customerid = 'BH-11710';
SELECT * FROM buy WHERE customerid = ?;
pstmt.setString(1, customerid);

-- 특정 고객의 본인 정보
SELECT * FROM customer where customerid = 'BH-11710';

--- DAO(Data Access Object) - CustomDAO -> Model
public Customer myInfo(String customerid) {
	string SQL = "SELECT * FROM customer where customerid = ?";
	pstmt.setString(1, customerid);
	rs = pstmt.excute(SQL);
	Customer cus = NEW Customer();
	if(rs.next()){
		cus.setCustomerid(rs.getString("customerid"));
		cus.setCustomerName(rs.getString("customername"));
		....
	}
	RETURN cus;
}

-- Controller(Ctrl)
"http://localhost:8081/mypage?customerid=BH-11710"
String customerid = request.getParameter("customerid");
    
CustomDAO dao = NEW CustomDAO();
Customer cus = dao.myInfo(customerid);
...
patcher.forward(cus);

-- View(.jsp)
Customer cus = (Customer) request.getParameter("cus");

<p>id : <%=cus.getCustomerid() %></p>


-- 트랜잭션(Transaction)
USE shop;

-- 재고 테이블
CREATE TABLE inven(ino int primary key AUTO_INCREMENT, pid VARCHAR(20), qty INT);

-- 판매 테이블
CREATE TABLE sale(sno INT PRIMARY KEY AUTO_INCREMENT, pid VARCHAR(20), qty INT); 

-- 입고
INSERT INTO inven(pid, qty) VALUES ('a001',12);
INSERT INTO inven(pid, qty) VALUES ('b001',25);
INSERT INTO inven(pid, qty) VALUES ('c001',18);

INSERT INTO inven(pid, qty) VALUES ('a001',11);
INSERT INTO inven(pid, qty) VALUES ('b001',19);
INSERT INTO inven(pid, qty) VALUES ('c001',14);



SELECT pid, SUM(qty) AS '재고합계' FROM inven GROUP BY pid;

CREATE VIEW pro_view1 AS (SELECT pid, SUM(qty) AS '재고합계' FROM inven GROUP BY pid);

SELECT * FROM inven;

SELECT * FROM pro_view1;



UPDATE inven SET qty=qty-14 WHERE pid='a001';

DELETE FROM inven WHERE qty < 0;

-- 트랜잭션 처리가 되지 않으면, 재고 처리 시스템에 문제가 발생하므로 이러한 경우 간혹 차집합으로 연산하는 경우가 있음. 그러나 테이블의 변화를 예측하기 힘든 현상이 발생하기때문에 사용하지 않는 것이 좋다.
create view jk AS (SELECT * FROM inven EXCEPT SELECT * FROM sale);

SELECT * FROM inven;

START TRANSACTION;

SAVEPOINT a;

INSERT INTO sale(pid, qty) VALUES ('a001',5); 

UPDATE inven SET qty=qty-5 WHERE pid='a001' AND ino=(SELECT MIN(ino) FROM inven WHERE pid='a001' AND qty>=5 GROUP BY pid); 

SELECT * FROM inven;

COMMIT;

ROLLBACK;	-- 전부 롤백

ROLLBACK TO a; -- 해당 SAVEPOINT 내용만 롤백

CREATE TABLE student(sno INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR(100), kor INT, eng INT, mat INT);

-- 5명의 학생 성적 데이터를 추가
INSERT INTO student(sname, kor, eng, mat) VALUES ('오세원', 90, 100, 80);
INSERT INTO student(sname, kor, eng, mat) VALUES ('신승훈', 100, 90, 70);
INSERT INTO student(sname, kor, eng, mat) VALUES ('백준진', 90, 90, 90);
INSERT INTO student(sname, kor, eng, mat) VALUES ('구예철', 100, 100, 70);
INSERT INTO student(sname, kor, eng, mat) VALUES ('김현훈', 80, 100, 80);

SELECT * FROM student;

SELECT sname AS '이름', kor+mat+eng AS '총점', (kor+mat+eng)/3 AS '평균' FROM student;

-- if(조건식, 참일때값, 거짓일때값)

SELECT sname AS name, kor+mat+eng AS tot, ROUND((kor+mat+eng)/3) AS ave,
if((kor+mat+eng)/3, '합격','보충대상자') AS pan
 FROM student;

-- case
--		when 조건1 then 조건1이만족할때값
--		when 조건2 then 조건2이만족할때값
--		when 조건3 then 조건3이만족할때값
--		else 어떠한조건도만족하지않을경우의값
--	end

SELECT sname AS name, kor+mat+eng AS tot, (kor+mat+eng)/3 AS ave,
IF(ROUND((kor+mat+eng)/3) >= 80, '합격','보충대상자') AS pan,
CASE
	WHEN (ROUND((kor+mat+eng)/3) BETWEEN 90 AND 100) THEN 'A'
	WHEN (ROUND((kor+mat+eng)/3) BETWEEN 80 AND 89) THEN 'B'
	WHEN (ROUND((kor+mat+eng)/3) BETWEEN 70 AND 79) THEN 'C'
	ELSE 'F'
END AS hak
 FROM student;


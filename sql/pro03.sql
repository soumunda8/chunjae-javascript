USE shop;

SHOW TABLES;

SELECT * FROM buy;

-- customerId 별로 그룹화하여 customerid, 제품거래건수, 총수량, 평균 할인율을 출력하라
SELECT customerid, COUNT(productid) AS '제품거래건수', SUM(quantity) AS '총수량', 
AVG(discount) AS '평균할인율' FROM buy
GROUP BY customerid;

-- buy 테이블에서 할인율이 가장 작은 거래 정보를 수량(quantity)의 내림차순으로 출력하시오.
SELECT * FROM buy 
WHERE discount=(SELECT MIN(discount) FROM buy) 
ORDER BY quantity DESC, orderdate ASC;

-- 배송일(shipdate)의 년도별로 총수량의 합계와 총수량의 평균, 총수량의 최대값을 집계하시오.
-- (년도를 추출하는 함수는 year임.)
SELECT YEAR(shipdate) AS '해당 년도', SUM(quantity) AS '총수량의 합계', 
AVG(quantity) AS '총수량의 평균', MAX(quantity) AS '총수량의 최대값'
FROM buy
GROUP BY YEAR(shipdate);

-- 주문일(orderdate)의 년도와 월별로 주문수량(quantity)의 합계와 평균 할인율을 집계하시오.
-- (data_format 함수를 사용.)
-- dataformat(컬럼, 형식)
-- 단, 주문량 합계가 0인 것은 제외할 것.
SELECT DATE_FORMAT(orderdate,'%Y-%m') AS '년월',
SUM(quantity) AS '합계', AVG(discount) AS '평균 할인율'
FROM buy
GROUP BY DATE_FORMAT(orderdate,'%Y-%m') HAVING SUM(quantity)!=0;

-- 제품번호(productid)가 FUR로 시작하는가구 종류를 구매한 고객정보 중에서
-- 고객명(customername), 국가(country), 도시(city)를 출력하되, 고객id(customerid)의 내림차순으로 하고,
-- 고객id가 같은 경우 주문수량(quantity)의 오름차순으로 할 것.
-- 이중쿼리, 연관쿼리, 내부조인 등 원하는방식으로 해결할 것.
SELECT c.customername AS '고객명', c.country AS '국가', c.city AS '도시'
FROM buy b
INNER JOIN customer c ON b.customerid = c.customerid
WHERE productid LIKE 'FUR%'
ORDER BY c.customerid DESC, b.quantity ASC;

-- 제품(product) 테이블로부터 가격(price)이 40 이상인 제품을 검색하여 제품2(product2) 테이블을 생성하시오.
-- (고가 상품 테이블 = product2)
CREATE TABLE product2 AS (SELECT * FROM product WHERE price >= 40);

-- 제품(product) 테이블로부터 가격(price)이 40 미만인 제품을 검색하여 제품3(product3) 테이블을 생성하시오.
-- (저가 상품 테이블 = product3)
CREATE TABLE product3 AS (SELECT * FROM product WHERE price < 40);

-- 제품3(product3) 테이블로부터 price가 0인 레코드를 삭제하시오.
DELETE FROM product3 WHERE price <= 0;

SELECT * FROM product2;
SELECT * FROM product3;

-- 제품명(productname)에 "(큰따옴표)가 있는 데이터의 "(큰따옴표)를 제거하시오.
-- 인덱스가 1부터 시작
-- \" 는 자바에서 같이 사용해야 되니까 버릇들이기
UPDATE product2 SET productname = SUBSTRING(productname, 2, LENGTH(productname)-1)
WHERE productname LIKE '\"%';

UPDATE product3 SET productname = SUBSTRING(productname, 2, LENGTH(productname)-1)
WHERE productname LIKE '\"%';

-- 합집합은 뷰(view)로 생성해야 사용이 편함
-- 컬럼의 데이터 타입이 일치해야 함.
-- UNION : 중복을 제거하여 합집합
-- UNION ALL : 중복 포함하여 합집합
CREATE VIEW uni_tab1 AS (SELECT productid, price FROM product2 UNION SELECT productid, price FROM product3);
SELECT * FROM uni_tab1;

-- 교집합(INTERSECT)
-- 교집합 출력 결과가 없으면 공집합
CREATE VIEW int_tab1 AS (SELECT productid, price FROM product2 INTERSECT SELECT productid, price FROM product3);
SELECT * FROM int_tab1;

-- 차집합(EXCEPT)
-- MINUS(ORACLE, H2B)
CREATE VIEW exc_tab1 AS (SELECT productid, price FROM product EXCEPT SELECT productid, price FROM product2);
SELECT * FROM exc_tab1;

-- 제품2(product2)와 제품3(product3)의 테이블 데이터를 합집합하여 전체상품(totpro)의 테이블을 생성하시오.
CREATE TABLE totpro AS (SELECT * FROM product2 UNION SELECT * FROM product3);
SELECT * FROM totpro;

-- 제품(product)와 제품3(product3)의 테이블 데이터를 차집합하여 제거상품(revpro)의 테이블을 생성하시오.
CREATE TABLE revpro AS (SELECT * FROM product EXCEPT SELECT * FROM product3);
SELECT * FROM revpro;

-- 제품(product)와 제품2(product2)의 테이블 데이터를 교집합하여 인기상품(hotpro)의 테이블을 생성하시오.
CREATE TABLE hotpro AS (SELECT * FROM product INTERSECT SELECT * FROM product2);
SELECT * FROM hotpro;

-- 특정 고객의 주문정보를 검색
SELECT * FROM buy WHERE customerid = 'BH-11710';

SELECT * FROM buy WHERE customerid = ?;
pstmt.setString(1, customerid);

-- 특정 고객의 본인 정보
SELECT * FROM customer WHERE customerid = 'BH-11710';

-- DAO(Data Access Object) - CustomerDAO -> Model : 데이터를 전달하는 역활(수동)
public ArrayList<customer> myInfo(String customerid) {
	String SQL = "SELECT * FROM customer WHERE customerid = ?";
	pstmt.setString(1, customerid);
	re = pstmt.excute(SQL);
	customer cus = new customer();
	if(rs.next()) {
		cus.setCustomerid(rs.getString("customerid"));
		cus.setCustomerName(rs.getString("customername"));
		...
	}
	return cus;
};

SELECT * FROM customer WHERE customerid = ?;
pstmt.setString(1, customerid);

-- Controller(Ctrl) -> View 와 Model의 중간 제어(능동)
"https://localhost:8081/maypages?customerid=BH-11710";
String customerid = request.getParameter("customerid");

CustomDAO da = new CustomDAO();
Customer cus = dao.myInfo(customerid);
... -- 목적지 생략
patcher.forward(cus);

-- View(.jsp) -> 데이터를 출력하는 역활(수동)
Customer cus = (Customer) request.getParmeter("cus");
<p>id : <%=cus.getCustomerid(); %></p>
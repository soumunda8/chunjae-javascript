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
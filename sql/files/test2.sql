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
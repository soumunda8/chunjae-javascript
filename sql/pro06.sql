CREATE TABLE faq(
	fno INT PRIMARY KEY AUTO_INCREMENT,
	question VARCHAR(1000) NOT NULL,
	answer VARCHAR(1000) NOT NULL,
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	cnt INT DEFAULT 0
);

SELECT * FROM f
INSERT INTO faq(question, answer) VALUES('어렵다..', '외워');
INSERT INTO faq(question, answer) VALUES('ddddd', '2222');
INSERT INTO faq(question, answer) VALUES('bb.', 'dd');
INSERT INTO faq(question, answer) VALUES('어렵다..', '외워');
INSERT INTO faq(question, answer) VALUES('어렵다..', '외워');

select * from faq
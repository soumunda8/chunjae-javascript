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

SELECT * FROM member;

-- 암호화로 비밀번호 업데이트
UPDATE member SET pw = 'db2e7f1bd5ab9968ae76199b7cc74795ca7404d5a08d78567715ce532f9d2669' WHERE pw='4567';
UPDATE member SET pw = '4aeb7ad6d5d37a041c4c5ce6562bf9e3caf05a42d931cef4d9e2a60ca623194d' WHERE pw='5432';
UPDATE member SET pw = 'fe2592b42a727e977f055947385b709cc82b16b9a87f88c6abf3900d65d0cdc3' WHERE pw='4321';
UPDATE member SET pw = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' WHERE pw='1234';
UPDATE member SET pw = '38083c7ee9121e17401883566a148aa5c2e2d55dc53bc4a94a026517dbff3c6b' WHERE pw='2345';

COMMIT;
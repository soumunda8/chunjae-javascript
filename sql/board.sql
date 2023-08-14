-- 게시판(board) 테이블 생성
CREATE TABLE board(
	bno INT(11) PRIMARY KEY AUTO_INCREMENT,
	boardType INT NOT NULL,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(1000),
	author VARCHAR(16) NOT NULL,
	resdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	cnt INT DEFAULT 0
);

-- 게시판 테이블 구조 보기
DESC board;
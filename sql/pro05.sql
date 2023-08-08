-- 질문 및 답변 테이블 생성
CREATE TABLE qna(
	qno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(1000),
	author VARCHAR(16),
	resdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	cnt INT DEFAULT 0,
	lev INT DEFAULT 0,		-- 질문(0), 답변(1)
	par INT,			-- 부모 글 번호 -> 질문(자신 레코드의 qno), 답변
	FOREIGN KEY(author) REFERENCES member(id) ON DELETE CASCADE
);

DESC qna;
	
ALTER TABLE qna MODIFY par INT;

-- 만약, 외래키로 인해 발생한다.
--	판매 테이블에서 묻고 답하기와 연관되어 있다. -> 판매 테이블에서 묻고답하기 테이블의 qno 또는 author를 기준으로 참조하고 있음

-- 해당 질문 및 답변 글을 삭제시에 참조하고 있는 sales 테이블의 데이터도 같이 삭제하라
DELETE FROM qna WHERE qno=? CASCADE;

-- 해당 회원이 묻고 답하기(qna)에 글을 남기고, 회원 탈퇴를 시도하는 경우에는 묻고 답하기에 남긴 글도 같이 제거해야 한다.
DELETE FROM member wehre id = ?;		-- 탈퇴가 되지 않음(묻고 답하기에 글이 있어서)

DELETE FROM member wehre id = ? CASCADE;		-- 탈퇴를 허용하면서 묻고 답하기의 글도 같이 연쇄삭제 처리

DESC qna;

-- 더미 데이터 작성
INSERT INTO qna(title, content, author, lev) VALUES('질문1', '왜 저한테 그러시죠?', 'park', 0);
UPDATE qna SET par=qno WHERE lev=0;
INSERT INTO qna(title, content, author, lev, par) VALUES('답변1', '그러니까 말입니다.', 'admin', 1, 1);

INSERT INTO qna(title, content, author, lev) VALUES('질문2', '회의어렵습니다.', 'lee', 0);
UPDATE qna SET par=qno WHERE qno=3;
INSERT INTO qna(title, content, author, lev, par) VALUES('질문1', '어쩔수 없죠', 'admin', 1, 3);

INSERT INTO qna(title, content, author, lev) VALUES('질문3', '더미데이터가 제일 힘들어요', 'hwang', 0);
UPDATE qna SET par=qno WHERE qno=6;
INSERT INTO qna(title, content, author, lev, par) VALUES('답변3', '그러니까요..', 'admin', 1, 6);

INSERT INTO qna(title, content, author, lev) VALUES('질문4', '관리자만 답변하래요..망했어요...', 'shin', 0);
UPDATE qna SET par=qno WHERE qno=9;
INSERT INTO qna(title, content, author, lev, par) VALUES('답변4', '어쩔수 없죠 뭐...', 'admin', 1, 9);

INSERT INTO qna(title, content, author, lev) VALUES('질문5', '지워야 하나요?', 'choi', 0);
UPDATE qna SET par=qno WHERE qno=11;
INSERT INTO qna(title, content, author, lev, par) VALUES('답변5', '지우세요..', 'admin', 1, 11);

SELECT * FROM member;

select a.qno as qno, a.title as title, a.content as content, a.author as author, a.resdate as resdate, a.cnt as cnt, a.lev as lev, a.par as par, b.name as name from qna a, member b where a.author = b.id order by a.par desc, a.lev asc, a.qno ASC

CREATE VIEW qnalist AS (select a.qno as qno, a.title as title, a.content as content, a.author as author, a.resdate as resdate, a.cnt as cnt, a.lev as lev, a.par as par, b.name as name from qna a, member b where a.author = b.id order by a.par desc, a.lev asc, a.qno ASC)

SELECT * FROM qnalist;
SELECT * FROM qnalist WHERE qno = 7
use bugjeog;

-- 개인 회원
INSERT INTO tbl_member(member_email, member_password, member_phone_number, member_name, member_register_date, member_status, member_img_original_name, member_img_uuid, member_img_path)
VALUES 
('member1@gmail.com', 'MTIzJHF3ZVI=', '01012351234', '김철수', NOW(), 1, NULL, NULL, NULL);
,
('user2@example.com', 'password2', '01023452345', '이영희', NOW(), 1, NULL, NULL, NULL),
('user3@example.com', 'password3', '01034563456', '박영철', NOW(), 1, NULL, NULL, NULL),
('user4@example.com', 'password4', '01045674567', '홍길동', NOW(), 1, NULL, NULL, NULL),
('user5@example.com', 'password5', '01056785678', '이순신', NOW(), 1, NULL, NULL, NULL),
('user6@example.com', 'password6', '01067896789', '유관순', NOW(), 1, NULL, NULL, NULL),
('user7@example.com', 'password7', '01078907890', '안중근', NOW(), 1, NULL, NULL, NULL),
('user8@example.com', 'password8', '01089018901', '강감찬', NOW(), 1, NULL, NULL, NULL),
('user9@example.com', 'password9', '01090129012', '을지문덕', NOW(), 1, NULL, NULL, NULL),
('user10@example.com', 'password10', '01001230123', '권율', NOW(), 1, NULL, NULL, NULL);
-- 유통업자 회원
INSERT INTO tbl_business (
	business_email, business_password, business_ceo_name, business_number, business_company_name, business_phone_number, business_establishment_date, business_location, business_category
) VALUES 
    ('business1@gmail.com', 'MTIzJHF3ZVI=', '김사장', '123-45-12345', '상사', '010-1234-1234', '2000-01-01', '서울', '육류');
    ,
    ('business2@test.com', 'password2', '박사장', '234-56-78901', '우리상회', '010-2345-6789', '2001-02-01', '대전', '채소'),
    ('business3@test.com', 'password3', '이사장', '345-67-89012', '한국상사', '010-3456-7890', '2002-03-01', '부산', '채소'),
    ('business4@test.com', 'password4', '최사장', '456-78-90123', '미래상회', '010-4567-8901', '2003-04-01', '대전', '채소'),
    ('business5@test.com', 'password5', '정사장', '567-89-01234', '명품상사', '010-5678-9012', '2004-05-01', '대전', '향신료'),
    ('business6@test.com', 'password6', '홍사장', '678-90-12345', '제일상회', '010-6789-0123', '2005-06-01', '부산', '향신료'),
    ('business7@test.com', 'password7', '최사장', '789-01-23456', '행복상회', '010-7890-1234', '2006-07-01', '부산', '해산물'),
    ('business8@test.com', 'password8', '이사장', '890-12-34567', '순천상사', '010-8901-2345', '2007-08-01', '서울', '해산물'),
    ('business9@test.com', 'password9', '김사장', '901-23-45678', '정신상회', '010-9012-3456', '2008-09-01', '서울', '해산물'),
    ('business10@test.com', 'password10', '박사장', '012-34-56789', '지혜상회', '010-0123-4567', '2009-10-01', '서울', '육류')
;

/*-- 자유 게시판
INSERT INTO tbl_board_free (member_id, business_id, board_free_title, board_free_content, board_free_like)
VALUES 
  (1, NULL, '첫 번째 글입니다.', '첫 번째 글 내용입니다.', 0),
  (NULL, 2, '두 번째 글입니다.', '두 번째 글 내용입니다.', 0),
  (3, NULL, '세 번째 글입니다.', '세 번째 글 내용입니다.', 0),
  (NULL, 4, '네 번째 글입니다.', '네 번째 글 내용입니다.', 0),
  (5, NULL, '다섯 번째 글입니다.', '다섯 번째 글 내용입니다.', 0),
  (NULL, 6, '여섯 번째 글입니다.', '여섯 번째 글 내용입니다.', 0),
  (7, NULL, '일곱 번째 글입니다.', '일곱 번째 글 내용입니다.', 0),
  (NULL, 8, '여덟 번째 글입니다.', '여덟 번째 글 내용입니다.', 0),
  (9, NULL, '아홉 번째 글입니다.', '아홉 번째 글 내용입니다.', 0),
  (NULL, 10, '열 번째 글입니다.', '열 번째 글 내용입니다.', 0)
 ;*/

 -- 자유 게시판 댓글
INSERT INTO tbl_free_reply(board_free_id, member_id, business_id, reply_content)
VALUES (1, 1, NULL, '첫 번째 댓글입니다.'),
       (1, NULL, 1, '두 번째 댓글입니다.'),
       (1, 2, NULL, '세 번째 댓글입니다.'),
       (2, NULL, 2, '네 번째 댓글입니다.'),
       (2, 3, NULL, '다섯 번째 댓글입니다.'),
       (3, NULL, 3, '여섯 번째 댓글입니다.'),
       (3, 1, NULL, '일곱 번째 댓글입니다.'),
       (4, 2, NULL, '여덟 번째 댓글입니다.'),
       (4, NULL, 1, '아홉 번째 댓글입니다.'),
       (5, 3, NULL, '열 번째 댓글입니다.')
;

--  유통 피알 게시판
INSERT INTO tbl_board_business (business_id, board_business_title, board_business_content)
VALUES 
(1, '첫 번째 게시글 제목', '첫 번째 게시글 내용'),
(2, '두 번째 게시글 제목', '두 번째 게시글 내용'),
(3, '세 번째 게시글 제목', '세 번째 게시글 내용'),
(4, '네 번째 게시글 제목', '네 번째 게시글 내용'),
(5, '다섯 번째 게시글 제목', '다섯 번째 게시글 내용'),
(6, '여섯 번째 게시글 제목', '여섯 번째 게시글 내용'),
(7, '일곱 번째 게시글 제목', '일곱 번째 게시글 내용'),
(8, '여덟 번째 게시글 제목', '여덟 번째 게시글 내용'),
(9, '아홉 번째 게시글 제목', '아홉 번째 게시글 내용'),
(10, '열 번째 게시글 제목', '열 번째 게시글 내용')
;

 -- 유통 피알 게시판 리뷰
INSERT INTO tbl_business_review (member_id, board_business_id, review_content, review_grade)
VALUES (1, 1, '좋은 상품이에요', FLOOR(RAND() * 5) + 1),
       (2, 2, '추천합니다', FLOOR(RAND() * 5) + 1),
       (3, 3, '품질 좋아요', FLOOR(RAND() * 5) + 1),
       (4, 4, '맛있어요', FLOOR(RAND() * 5) + 1),
       (5, 5, '조금 아쉽네요', FLOOR(RAND() * 5) + 1),
       (6, 6, '만족합니다', FLOOR(RAND() * 5) + 1),
       (7, 7, '가격이 조금 아쉽네요', FLOOR(RAND() * 5) + 1),
       (8, 8, '서비스가 좋아요', FLOOR(RAND() * 5) + 1),
       (9, 9, '적극 추천합니다', FLOOR(RAND() * 5) + 1),
       (10, 10, '괜찮은 가격이에요', FLOOR(RAND() * 5) + 1)
;
INSERT INTO tbl_business_review (member_id, board_business_id, review_content, review_grade)
VALUES (1, 1, '좋은 상품이에요', FLOOR(RAND() * 5) + 1),
       (2, 2, '추천합니다', FLOOR(RAND() * 5) + 1),
       (3, 3, '품질 좋아요', FLOOR(RAND() * 5) + 1),
       (4, 4, '맛있어요', FLOOR(RAND() * 5) + 1),
       (5, 5, '조금 아쉽네요', FLOOR(RAND() * 5) + 1),
       (6, 6, '만족합니다', FLOOR(RAND() * 5) + 1),
       (7, 7, '가격이 조금 아쉽네요', FLOOR(RAND() * 5) + 1),
       (8, 8, '서비스가 좋아요', FLOOR(RAND() * 5) + 1),
       (9, 9, '적극 추천합니다', FLOOR(RAND() * 5) + 1),
       (10, 10, '괜찮은 가격이에요', FLOOR(RAND() * 5) + 1)
;
INSERT INTO tbl_business_review (member_id, board_business_id, review_content, review_grade)
VALUES (1, 1, '좋은 상품이에요', FLOOR(RAND() * 5) + 1),
       (2, 2, '추천합니다', FLOOR(RAND() * 5) + 1),
       (3, 3, '품질 좋아요', FLOOR(RAND() * 5) + 1),
       (4, 4, '맛있어요', FLOOR(RAND() * 5) + 1),
       (5, 5, '조금 아쉽네요', FLOOR(RAND() * 5) + 1),
       (6, 6, '만족합니다', FLOOR(RAND() * 5) + 1),
       (7, 7, '가격이 조금 아쉽네요', FLOOR(RAND() * 5) + 1),
       (8, 8, '서비스가 좋아요', FLOOR(RAND() * 5) + 1),
       (9, 9, '적극 추천합니다', FLOOR(RAND() * 5) + 1),
       (10, 10, '괜찮은 가격이에요', FLOOR(RAND() * 5) + 1)
;

-- 문의 게시판
INSERT INTO tbl_board_inquiry (member_id, business_id, board_inquiry_title, board_inquiry_content)
VALUES 
    (1, null, '문의 제목 1', '문의 내용 1'),
    (null, 1, '문의 제목 2', '문의 내용 2'),
    (1, null, '문의 제목 3', '문의 내용 3'),
    (null, 2, '문의 제목 4', '문의 내용 4'),
    (2, null, '문의 제목 5', '문의 내용 5'),
    (null, 3, '문의 제목 6', '문의 내용 6'),
    (3, null, '문의 제목 7', '문의 내용 7'),
    (null, 4, '문의 제목 8', '문의 내용 8'),
    (4, null, '문의 제목 9', '문의 내용 9'),
    (null, 5, '문의 제목 10', '문의 내용 10')
;


-- 문의 답변
INSERT INTO tbl_board_inquiry_answer (board_inquiry_id, board_inquiry_answer_content)
VALUES (1, '문의에 대한 답변입니다.'),
       (2, '문의에 대한 답변입니다.'),
       (3, '문의에 대한 답변입니다.'),
       (4, '문의에 대한 답변입니다.'),
       (5, '문의에 대한 답변입니다.'),
       (6, '문의에 대한 답변입니다.'),
       (7, '문의에 대한 답변입니다.'),
       (8, '문의에 대한 답변입니다.'),
       (9, '문의에 대한 답변입니다.'),
       (10, '문의에 대한 답변입니다.')
;

INSERT INTO tbl_interesting_company
(member_id, business_id)
VALUES(12, 11);

(11, 12);
,
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10);





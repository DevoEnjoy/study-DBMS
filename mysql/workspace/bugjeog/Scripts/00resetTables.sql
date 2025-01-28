use bugjeog;
drop table tbl_free_reply;
drop table tbl_free_like;
drop table tbl_board_free_img;
drop table tbl_board_free;
drop table tbl_business_review;
drop table tbl_board_business_img;
drop table tbl_board_business;
drop table tbl_board_inquiry_answer;
drop table tbl_board_inquiry;
drop table tbl_interesting_company;
drop table tbl_notice;

drop table tbl_member;
drop table tbl_business;

-- create database bugjeog;
use bugjeog;
-- 개인 회원
create table tbl_member(
	member_id int unsigned auto_increment primary key,
	member_email varchar(500) not null unique,
	member_password varchar(500) not null,
	member_phone_number varchar(500) not null unique,
	member_name varchar(500) not null,
	member_register_date datetime default current_timestamp(),
	member_status int default 1,
	member_img_original_name varchar(500),
	member_img_uuid varchar(500) unique,
	member_img_path varchar(500)
);
 -- 유통업자 회원
create table tbl_business(
	business_id int unsigned auto_increment primary key,
	business_email varchar(500) not null unique,
	business_password varchar(500) not null,
	business_ceo_name varchar(500) not null,
	business_number varchar(500) not null unique,/* 사업자 번호 */
	business_company_name varchar(500) not null,
	business_phone_number varchar(500) not null,
	business_establishment_date datetime not null, /* 설립일 */
	business_register_date datetime default current_timestamp(), /* 가입 날짜 */
	business_status int default 1,
	business_img_original_name varchar(500),
	business_img_uuid varchar(500),
	business_img_path varchar(500),
	business_location varchar(500),
	business_category varchar(500)
);
 -- 자유 게시판
create table tbl_board_free(
	board_free_id int unsigned auto_increment primary key,
	member_id int unsigned,
	business_id int unsigned,
	board_free_title varchar(500) not null,
	board_free_content varchar(500) not null,
	board_free_register_date datetime default current_timestamp(),
	board_free_update_date datetime default current_timestamp(),
	board_free_like int default 0,/* 좋아요 */
	constraint fk_free_business foreign key(business_id)
	references tbl_business(business_id) on delete cascade,
	constraint fk_free_member foreign key(member_id)
	references tbl_member(member_id) on delete cascade
);
 -- 자유 게시판 이미지
create table tbl_board_free_img(
	board_free_img_id int unsigned auto_increment primary key,
	board_free_id int unsigned,
	board_free_img_original_name varchar(500),
	board_free_img_uuid varchar(500),
	board_free_img_path varchar(500),
	constraint fk_board_free
	foreign key(board_free_id) references tbl_board_free(board_free_id) on delete cascade
);
 -- 자유 게시판 댓글
create table tbl_free_reply(
	reply_id int unsigned auto_increment primary key,
	board_free_id int unsigned,
	member_id int unsigned,
	business_id int unsigned,
	reply_content varchar(500) not null,
	reply_register_date datetime default current_timestamp(),
	reply_update_date datetime default current_timestamp(),
	constraint fk_reply_member
	foreign key(member_id) references tbl_member(member_id) on delete cascade,
	constraint fk_reply_business
	foreign key(business_id) references tbl_business(business_id) on delete cascade
);
 -- 자유 게시판 좋아요
create table tbl_free_like(
	free_like_id int unsigned auto_increment primary key,
	member_id int unsigned,
	business_id int unsigned,
	board_free_id int unsigned,
	constraint fk_like_member
	foreign key(member_id) references tbl_member(member_id) on delete cascade,
	constraint fk_like_business
	foreign key(business_id)references tbl_business(business_id) on delete cascade,
	constraint fk_like_free
	foreign key(board_free_id) references tbl_board_free(board_free_id) on delete cascade
);
 -- 유통 피알 게시판
create table tbl_board_business(
	board_business_id int unsigned auto_increment primary key,
	business_id int unsigned,
	board_business_title varchar(500) not null,
	board_business_content varchar(500) not null,
	board_business_register_date datetime default current_timestamp(),
	board_business_update_date datetime default current_timestamp(),
	board_business_status int default 1,
	constraint fk_board_business
	foreign key(business_id)references tbl_business(business_id) on delete cascade
);
 -- 유통 피알 게시판 이미지
create table tbl_board_business_img(
	board_business_img_id int unsigned auto_increment primary key,
	board_business_id int unsigned,
	board_business_img_original_name varchar(500) not null,
	board_business_img_uuid varchar(500) not null,
	board_business_img_path varchar(500) not null,
	constraint fk_img_business
	foreign key(board_business_id) references tbl_board_business(board_business_id) on delete cascade
);
 -- 유통 피알 게시판 리뷰
create table tbl_business_review(
	review_id int unsigned auto_increment primary key,
	member_id int unsigned,
	board_business_id int unsigned,
	review_content varchar(500) not null,
	review_register_date datetime default current_timestamp(),
	review_update_date datetime default current_timestamp(),
	review_grade int not null,/* 평점 */
	constraint fk_review_member
	foreign key(member_id) references tbl_member(member_id) on delete cascade,
	constraint fk_review_board_business
	foreign key(board_business_id) references tbl_board_business(board_business_id) on delete cascade
);
 -- 문의 게시판
create table tbl_board_inquiry(
	board_inquiry_id int unsigned auto_increment primary key,
	member_id int unsigned,
	business_id int unsigned,
	board_inquiry_title varchar(500) not null,
	board_inquiry_content varchar(500) not null,
	board_inquiry_register_date datetime default current_timestamp(),
	board_inquiry_status char(1) default 1,
	constraint fk_inquiry_member
	foreign key(member_id) references tbl_member(member_id) on delete cascade,
	constraint fk_inquiry_business
	foreign key(business_id) references tbl_business(business_id) on delete cascade
);
 -- 문의 답변
create table tbl_board_inquiry_answer(
	board_inquiry_answer_id int unsigned auto_increment primary key,
	board_inquiry_id int unsigned,
	board_inquiry_answer_content varchar(500) not null,
	board_inquiry_answer_register_date datetime default current_timestamp(),
	constraint fk_board_inquiry
	foreign key(board_inquiry_id) references tbl_board_inquiry(board_inquiry_id) on delete cascade
);
 -- 관심업체
create table tbl_interesting_company(
	interesting_company_id int unsigned auto_increment primary key,
	member_id int unsigned,
	business_id int unsigned,
	constraint fk_interesting_member
	foreign key(member_id) references tbl_member(member_id) on delete cascade,
	constraint fk_interesting_business
	foreign key(business_id) references tbl_business(business_id) on delete cascade
);

-- 공지사항
create table tbl_notice(
	notice_id int unsigned auto_increment primary key,
	notice_title varchar(500) not null,
	notice_content varchar(500) not null,
	notice_register_date datetime default current_timestamp()
);

use bugjeog;

-- 개인 회원
INSERT INTO tbl_member(member_email, member_password, member_phone_number, member_name, member_register_date, member_status, member_img_original_name, member_img_uuid, member_img_path)
VALUES 
('user1@example.com', 'password1', '01012341234', '김철수', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user2@example.com', 'password2', '01023452345', '이영희', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user3@example.com', 'password3', '01034563456', '박영철', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user4@example.com', 'password4', '01045674567', '홍길동', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user5@example.com', 'password5', '01056785678', '이순신', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user6@example.com', 'password6', '01067896789', '유관순', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user7@example.com', 'password7', '01078907890', '안중근', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user8@example.com', 'password8', '01089018901', '강감찬', NOW(), 1, 'member_no_image.png',   NULL, NULL),
('user9@example.com', 'password9', '01090129012', '을지문덕', NOW(), 1, 'member_no_image.png', NULL, NULL),
('user10@example.com', 'password10', '01001230123', '권율', NOW(), 1, 'member_no_image.png',  NULL, NULL);

-- 유통업자 회원
INSERT INTO tbl_business (
	business_email, business_password, business_ceo_name, business_number, business_company_name, business_phone_number, business_establishment_date, business_location, business_category
) VALUES 
    ('business1@test.com', 'password1', '김사장', '123-45-67890', '상사', '010-1234-5678', '2000-01-01', '서울', '육류'),
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

-- 자유 게시판
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
 ;

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

/* -- 유통 피알 게시판
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
;*/

/* -- 유통 피알 게시판 리뷰
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
;*/

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

 -- 관심업체
insert into tbl_interesting_company (member_id, business_id) values
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10);





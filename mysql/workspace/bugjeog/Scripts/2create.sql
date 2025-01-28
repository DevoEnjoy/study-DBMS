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
	foreign key(member_id) references tbl_member(member_id),
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
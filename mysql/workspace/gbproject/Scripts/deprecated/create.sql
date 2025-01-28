-- create database goldenPig;
-- use goldenPig;

 /* 멤버 테이블 */
create table tbl_member(
	member_id int unsigned auto_increment primary key,
	member_email varchar(500) not null unique,
	member_password varchar(500) not null,
	member_name varchar(500) not null,
	member_nickname varchar(500) not null,
	member_phonenumber varchar(100) not null unique,
	member_birth date not null,
	member_img_name varchar(500) default null,
	member_img_path varchar(500) default null unique,
	member_greeting varchar(500) default null
);

 /* 저축 목표 테이블 */
create table tbl_money(
	money_amount int not null, /* 현재 금액 */
	money_target int not null,/* 목표 금액 */
	money_register_date datetime default now(),
	money_expiry_date datetime not null,/* 목표일 */
	member_id int unsigned not null primary key,
/*member 테이블의 member_id가 슈퍼키고 saving 테이블의 member_id가 서브키다.*/
	foreign key(member_id) references tbl_member(member_id)
);
/* 저축 게시판 */
create table tbl_board_saving(
   board_id int unsigned auto_increment primary key,
   member_id int unsigned not null,
   FOREIGN KEY (member_id) REFERENCES tbl_member(member_id),
   board_title varchar(500) not null,
   board_content varchar(500) not null,
   board_register_date datetime default now(),
   board_update_date datetime default now(),
   board_read_count int unsigned default 0
);

  /* 저축 게시판 이미지 */
create table tbl_board_saving_img(
   board_img_id int unsigned auto_increment primary key,
   board_img_path varchar(500) not null,
   board_img_name varchar(500) not null,
   board_img_system_name varchar(500) not null,
   board_id int unsigned not null,
   FOREIGN KEY (board_id) REFERENCES tbl_board_saving(board_id)
);
/* 저축 게시판 댓글*/
create table tbl_board_saving_reply(
   reply_id int unsigned auto_increment primary key,
   reply_content varchar(500) not null,
   reply_register_date datetime default now(),
   reply_update_date datetime default now(),
   member_id int unsigned,
   board_id int unsigned,
   foreign key(member_id) references tbl_member(member_id),
   foreign key(board_id) references tbl_board_saving(board_id)
);
/* 저축 게시판 좋아요 */
create table tbl_board_saving_like(
   board_like_id int unsigned auto_increment primary key,
   member_id int unsigned not null,
   board_id int unsigned not null,
   foreign key(member_id) references tbl_member(member_id),
   foreign key(board_id) references tbl_board_saving(board_id)
);
/* 저축 게시판 태그*/
	create table tbl_board_saving_tag (
	tag_id int unsigned auto_increment primary key,
	tag_name varchar(500) not null,
	board_id int unsigned,
	foreign key(board_id) references tbl_board_saving(board_id)
);
 /* 관심 질문 */
create table tbl_favorite (
	favorite_id int unsigned auto_increment primary key,
	member_id int unsigned not null,
	board_id int unsigned not null,
	foreign key(member_id) references tbl_member(member_id),
	foreign key(board_id) references tbl_board_saving(board_id)
);
    /* 저축 게시판 - 답변*/
create table tbl_saving_answer(
	answer_id int unsigned auto_increment primary key,
	board_id int unsigned not null,
	FOREIGN KEY (board_id) REFERENCES tbl_board_saving(board_id),
	member_id int unsigned not null,
	FOREIGN KEY (member_id) REFERENCES tbl_member(member_id),
	answer_title varchar(500) not null,
	answer_content varchar(500) not null,
	answer_register_date datetime default now(),
	answer_update_date datetime default now()
);
 /* 저축 게시판 - 답변 좋아요*/
create table tbl_saving_answer_like(
   answer_like_id int unsigned auto_increment primary key,
   member_id int unsigned not null,
   answer_id int unsigned not null,
   foreign key(member_id) references tbl_member(member_id),
   foreign key(answer_id) references tbl_saving_answer(answer_id)
);

/* 저축 게시판 - 답변 - 댓글*/
create table tbl_saving_answer_reply(
   reply_id int unsigned auto_increment primary key,
   reply_content varchar(500) not null,
   reply_register_date datetime default now(),
   reply_update_date datetime default now(),
   member_id int unsigned,
   answer_id int unsigned,
   foreign key(member_id) references tbl_member(member_id),
   foreign key(answer_id) references tbl_saving_answer(answer_id)
);

/* 자유 게시판 */
create table tbl_board_free(
   board_id int unsigned auto_increment primary key,
   member_id int unsigned not null,
   FOREIGN KEY (member_id) REFERENCES tbl_member(member_id),
   board_title varchar(500) not null,
   board_content varchar(500) not null,
   board_register_date datetime default now(),
   board_update_date datetime default now(),
   board_read_count int unsigned default 0
);


 /* 자유 게시판 이미지 */
create table tbl_board_free_img(
   board_img_id int unsigned auto_increment primary key,
   board_img_name varchar(500) not null,
   board_img_system_name varchar(500) not null,
   board_id int unsigned not null,
   FOREIGN KEY (board_id) REFERENCES tbl_board_free(board_id)
);

/* 자유 게시판 댓글 */
create table tbl_board_free_reply(
   reply_id int unsigned auto_increment primary key,
   reply_content varchar(500) not null,
   reply_register_date datetime default now(),
   reply_update_date datetime default now(),
   member_id int unsigned,
   board_id int unsigned,
   foreign key(member_id) references tbl_member(member_id),
   foreign key(board_id) references tbl_board_free(board_id)
);

/* 자유 게시판 좋아요 */
create table tbl_board_free_like(
   like_id int unsigned auto_increment primary key,
   member_id int unsigned not null,
   foreign key(member_id) references tbl_member(member_id),
   board_id int unsigned not null,
   foreign key(board_id) references tbl_board_free(board_id)
);

           /* 배너 테이블*/
create table tbl_banner(
   banner_id int unsigned auto_increment primary key,
   banner_name varchar(500) not null,
   banner_system_name varchar(100) not null,
   banner_status int default 1
);

/* 공지사항 */
create table tbl_notice(
   notice_id int unsigned auto_increment primary key,
   notice_title varchar(500) not null,
   notice_content varchar(500),
   notice_register_date datetime default now(),
   notice_update_date datetime default now()
);
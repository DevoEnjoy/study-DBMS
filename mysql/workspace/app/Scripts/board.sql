use app;

create table tbl_board(
	board_id int unsigned auto_increment primary key,
	board_title varchar(500) not null,
	board_content varchar(500) not null,
	board_register_date datetime default now(),
	board_read_count int unsigned default 0,
	member_id int unsigned not null
);

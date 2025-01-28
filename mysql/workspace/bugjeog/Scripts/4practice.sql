use bugjeog;
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

select
	b.board_business_id,b.business_id,b.board_business_title,
	b.board_business_content,b.board_business_register_date,b.board_business_update_date,
	i2.board_business_img_id,i.board_business_img_original_name,i.board_business_img_uuid,
	i.board_business_img_path
	, ifnull(r.board_business_review_count, 0) board_business_review_count
	, ifnull(r.board_business_grade_average, 0) board_business_grade_average,
	bs.business_category,bs.business_location
from tbl_board_business b
left join (
	select board_business_id, min(board_business_img_id) board_business_img_id
	from tbl_board_business_img
	group by board_business_id
  ) i2
  on b.board_business_id = i2.board_business_id
left join 
    tbl_board_business_img i on
	i2.board_business_img_id = i.board_business_img_id
left join (
	select board_business_id, count(*) board_business_review_count,
		ifnull(avg(review_grade), 0) board_business_grade_average
	from tbl_business_review
	group by board_business_id
  ) r
  on b.board_business_id = r.board_business_id
inner join tbl_business bs
on b.business_id = bs.business_id
where bs.business_status = 1
group by b.board_business_id
order by b.board_business_id desc;

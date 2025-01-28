use goldenpig;


select * from tbl_board_free;
select * from tbl_board_free_like;
select * from tbl_board_free_reply;

drop table tbl_banner ;

/* 배너 테이블*/
create table tbl_banner(
   banner_id int unsigned auto_increment primary key,
   banner_system_name varchar(500) not null,
   banner_original_name varchar(500) not null,
   banner_register_date datetime default now(),
   banner_status int default 1
);
select * from tbl_banner tb ;


-- select b.board_id , b.member_id, b.member_nickname , b.board_title
-- 	, b.board_update_date , b.board_read_count, count(l.like_id) like_count
-- from (
-- 	select f.board_id , f.member_id, m.member_nickname ,  f.board_title
-- 	, f.board_update_date , f.board_read_count 
-- 	from tbl_board_free f
-- 	left outer join tbl_member m
-- 	on f.member_id = m.member_id
-- ) b
-- left outer join tbl_board_free_like l
-- on b.board_id = l.board_id
-- group by board_id;

select f.board_id , f.member_id, m.member_nickname ,  f.board_title
, f.board_update_date , f.board_read_count 
from tbl_board_free f
left outer join tbl_member m
on f.member_id = m.member_id;


select f.board_id , f.member_id, f.member_nickname ,  f.board_title
	, f.board_update_date , f.board_read_count , ifnull(l.like_count, 0) like_count
, ifnull(r.reply_count, 0) reply_count
from (
	select f.board_id , f.member_id, m.member_nickname ,  f.board_title
	, f.board_update_date , f.board_read_count 
	from tbl_board_free f
	left outer join tbl_member m
	on f.member_id = m.member_id
) f
left outer join 
(
	select l.board_id, count(l.like_id) like_count
	from tbl_board_free_like l
	group by l.board_id 
) l
on l.board_id = f.board_id 
left outer join(
	select r.board_id, count(r.reply_id) reply_count
	from tbl_board_free_reply r
	group by r.board_id 
) r
on r.board_id = f.board_id 
group by board_id;
-- order by board_id desc 
-- limit #{startRow}, #{rowCount};


-- select f.member_id favoriting, f.board_id, s.member_id favorited, s.board_title
-- , s.board_content , s.board_register_date 
-- from tbl_board_saving s /* member_id favorited */
-- join tbl_favorite f /*member_id favoriting */
-- on f.board_id = s.board_id;

select f.member_id favoriting/* 관심누른사람Id */, f.member_nickname /*관심누른사람nickname*/
	, f.board_id, s.member_id /* 관심받은사람Id*/, f.member_nickname /*관심받은사람nickname*/
	, s.board_title, s.board_content, s.board_register_date
	, s.member_img/*관심받은사람member_img_path*/
from (
	select m.member_id , m.member_nickname , m.member_img_path member_img
	, s.board_register_date, s.board_title, s.board_content, s.board_id 
	from tbl_member m
	join tbl_board_saving s 
	on m.member_id = s.member_id
	) s /* 관심받은 사람 */
join (
	select m.member_id , m.member_nickname, f.board_id
	from tbl_member m
	join tbl_favorite f 
	on m.member_id = f.member_id
	) f /* 관심누른 사람 */
on f.board_id = s.board_id;

select m.member_id , m.member_nickname, f.board_id
from tbl_member m
right outer join tbl_favorite f 
on m.member_id = f.member_id;

select m.member_id , m.member_nickname , m.member_img_path member_img
, s.board_register_date, s.board_title, s.board_content, s.board_id 
from tbl_member m
right outer join tbl_board_saving s 
on m.member_id = s.member_id;

select * from tbl_favorite tf ;
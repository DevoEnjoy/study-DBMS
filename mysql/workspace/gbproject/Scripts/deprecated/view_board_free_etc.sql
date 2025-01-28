use goldenpig;


create or replace view view_board_free as (
	select count(l.like_id) likeCount, f.board_id , f.member_id 
	, f.board_title , f.board_content , f.board_register_date , f.board_update_date , f.board_read_count 
	from tbl_board_free f
	left outer join tbl_board_free_like l
	on f.board_id = l.board_id
	group by f.board_id
);

select likeCount, member_id from view_board_free ;

create or replace view view_board_free_likeCount as (
	select member_id, sum(likeCount) like_count, sum(board_read_count) read_count
	from view_board_free
	group by member_id
);

create or replace view view_board_free_likeCount as (
	select member_id, sum(likeCount) like_count, sum(board_read_count) read_count
	from view_board_free
	group by member_id
);

select * from view_board_free_likecount ;


select f.board_id , f.member_id, f.member_nickname ,  f.board_title
	, f.board_update_date , f.board_read_count , ifnull(l.like_count, 0) board_like_count, ifnull(r.reply_count, 0) board_reply_count
from
(
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
left outer join
(
	select r.board_id, count(r.reply_id) reply_count
	from tbl_board_free_reply r
	group by r.board_id 
) r
on r.board_id = f.board_id 
group by board_id
order by board_id desc ;
limit 5,5;

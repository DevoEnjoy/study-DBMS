use goldenpig;

select * from tbl_board_saving_like tbsl ;
select * from tbl_board_saving_reply tbsr ;
select * from tbl_favorite tf;


select * from tbl_board_saving;
select * from tbl_board_saving_like;
select * from tbl_board_saving_reply;
select * from tbl_member;
select * from tbl_favorite;


select s.board_id , m.member_id , m.member_nickname, s.board_title , s.board_content, s.board_update_date
, count(l.board_like_id) like_count, count(r.reply_id) reply_count
, count(f.favorite_id) favorite_count
from tbl_member m
left outer join tbl_board_saving s on m.member_id = s.member_id  
left outer join tbl_board_saving_like l on l.board_id = s.board_id
left outer join tbl_board_saving_reply r on r.board_id = s.board_id 
left outer join tbl_favorite f on f.board_id = s.board_id 
group by s.board_id;

select * from tbl_favorite tf ;

create or replace view view_board_counts as (
	select f.board_id , f.favorite_count, r.reply_count, l.like_count
	from (
		select s.board_id, sum(if(ifnull(f.favorite_id , 0)=0, 0, 1)) favorite_count
		from tbl_board_saving s left outer join tbl_favorite f 
		on s.board_id = f.board_id
		group by board_id
	) f join (
		select s.board_id , sum(if(ifnull(r.reply_id, 0)=0, 0, 1)) reply_count
		from tbl_board_saving s left outer join tbl_board_saving_reply r
		on s.board_id = r.board_id
		group by board_id
	) r
	on f.board_id = r.board_id
	join (
		select s.board_id , sum(if(ifnull(l.board_like_id, 0)=0, 0, 1)) like_count  
		from tbl_board_saving s left outer join tbl_board_saving_like l
		on s.board_id = l.board_id
		group by board_id
	) l
	on f.board_id = l.board_id
	group by board_id
);
select * from view_board_counts;

select f.board_id, f.member_id, f.board_title, f.board_content, f.board_register_date, 
f.board_update_date, m.member_nickname
from tbl_board_free f
left outer join tbl_member m
on f.member_id = m.member_id;

select b.board_id, b.member_id, b.board_title, b.board_content, b.board_register_date, 
	b.board_update_date, b.member_nickname, c.favorite_count, c.reply_count, c.like_count
from (
	select f.board_id, f.member_id, f.board_title, f.board_content, f.board_register_date, 
	f.board_update_date, m.member_nickname
	from tbl_board_free f
	left outer join tbl_member m
	on f.member_id = m.member_id
) b join (
		select f.board_id , f.favorite_count, r.reply_count, l.like_count
	from (
		select s.board_id, sum(if(ifnull(f.favorite_id , 0)=0, 0, 1)) favorite_count
		from tbl_board_saving s left outer join tbl_favorite f 
		on s.board_id = f.board_id
		group by board_id
	) f join (
		select s.board_id , sum(if(ifnull(r.reply_id, 0)=0, 0, 1)) reply_count
		from tbl_board_saving s left outer join tbl_board_saving_reply r
		on s.board_id = r.board_id
		group by board_id
	) r
	on f.board_id = r.board_id
	join (
		select s.board_id , sum(if(ifnull(l.board_like_id, 0)=0, 0, 1)) like_count  
		from tbl_board_saving s left outer join tbl_board_saving_like l
		on s.board_id = l.board_id
		group by board_id
	) l
	on f.board_id = l.board_id
	group by board_id
) c
on b.board_id = c.board_id;


board_title
board_register_date 
board_update_date 
board_content
member_id writer_id
member_nickname writer

board_like_id(count)
favorite_id(count)
reply_id(count)
-- reply_content
-- member_id replyer



/* reply리스트
-- board_id
-- 		free_reply
	-- 		reply_id, reply_content, reply_register_date, reply_update_date
	-- 		, member_id, board_id

 		member
	 *		member_id, member_nickname, member_img_path
	 * 		
	 * 
	 */
select * from tbl_board_free_reply tbfr ;
select * from tbl_member tm ;
select m.member_id, m.member_nickname, m.member_img_path
	,r.reply_id, r.reply_content, r.reply_register_date, r.reply_update_date
	, r.member_id, r.board_id
from tbl_member m
join tbl_board_free_reply r 
on m.member_id = r.member_id;





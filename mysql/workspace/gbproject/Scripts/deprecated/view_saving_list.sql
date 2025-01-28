use goldenpig;

select * from tbl_board_saving;

select board_id, member_id , board_title , board_register_date , board_read_count 
from tbl_board_saving s;

select s.member_id , s.board_id, count(l.board_like_id) board_like_count , s.board_title , s.board_register_date, s.board_read_count
from tbl_board_saving s
left outer join tbl_board_saving_like l
on s.board_id = l.board_id
group by board_id;



-- 저축 게시판 리스트-좋아요
create or replace view view_board_saving_list_like as (
	select s.board_id, s.member_id, count(l.board_like_id) board_like_count , s.board_title , s.board_register_date, s.board_read_count
	from tbl_board_saving s
	left outer join tbl_board_saving_like l
	on s.board_id = l.board_id
	group by board_id
);
select * from view_board_saving_list_like;

-- 저축 게시판 리스트
create or replace view view_board_saving_list_ as (
	select s.board_id, s.member_id, l.board_reply_count, s.board_like_count , s.board_title , s.board_register_date, s.board_read_count
	from (
		select s.board_id, s.member_id, count(l.board_like_id) board_like_count , s.board_title , s.board_register_date, s.board_read_count
		from tbl_board_saving s
		left outer join tbl_board_saving_like l
		on s.board_id = l.board_id
		group by board_id
	) s
	left outer join (
		select s.board_id, s.member_id, count(r.reply_id) board_reply_count , s.board_title , s.board_register_date, s.board_read_count
		from tbl_board_saving s
		left outer join tbl_board_saving_reply r
		on s.board_id = r.board_id
		group by board_id
	) l
	on s.board_id = l.board_id
	group by board_id
);
-- drop view view_board_saving_list_;
-- select * from view_board_saving_list_ tbf ;
























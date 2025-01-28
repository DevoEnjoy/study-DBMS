use goldenpig;

-- 질문 좋아요
select s.member_id writer, l.member_id liker, l.board_id, l.board_like_id 
from tbl_board_saving s
left outer join tbl_board_saving_like l
on s.board_id = l.board_id;

-- group by s.member_id;

select m.member_id, if(l.board_like_id=null, 0, count(l.board_like_id)) like_total
from tbl_member m
left outer join (
	select s.member_id writer, l.board_like_id 
	from tbl_board_saving s
	left outer join tbl_board_saving_like l
	on s.board_id = l.board_id
) l
on m.member_id = l.writer
group by member_id;

-- 질문 좋아요
create or replace view view_saving_like_total as (
	select m.member_id, if(l.board_like_id=null, 0, count(l.board_like_id)) like_total
	from tbl_member m
	left outer join (
		select s.member_id writer, l.board_like_id 
		from tbl_board_saving s
		left outer join tbl_board_saving_like l
		on s.board_id = l.board_id
	) l
	on m.member_id = l.writer
	group by member_id
);
select * from view_saving_like_total;
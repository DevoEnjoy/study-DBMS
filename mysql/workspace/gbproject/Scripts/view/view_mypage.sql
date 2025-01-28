use goldenpig;


-- 나의 활동 내가 쓴 글-자유
select m.member_id, count(f.board_id) 
from tbl_member m left outer join tbl_board_free f
on m.member_id = f.member_id
group by member_id;

-- 나의 활동 내가 쓴 글-저축
select m.member_id, count(s.board_id) 
from tbl_member m left outer join tbl_board_saving s
on m.member_id = s.member_id
group by member_id;


-- 나의 활동 내가 쓴 글
select f.member_id, sum(f.board_count + s.board_count) write_count_total
from (
	select m.member_id, count(f.board_id) board_count
	from tbl_member m left outer join tbl_board_free f
	on m.member_id = f.member_id
	group by member_id
) f join (
	select m.member_id, count(s.board_id) board_count
	from tbl_member m left outer join tbl_board_saving s
	on m.member_id = s.member_id
	group by member_id
) s
on f.member_id = s.member_id 
group by member_id;


-- 나의 활동 질문
create or replace view view_board_saving_write_count as (
	select m.member_id, count(s.board_id) saving_write_count
	from tbl_board_saving s
	right outer join tbl_member m
	on s.member_id = m.member_id
	group by member_id
);
-- select * from view_board_saving_write_count;

-- 나의 활동 답변
create or replace view view_board_answer_write_count as (
	select m.member_id, count(a.board_id) answer_write_count
	from tbl_saving_answer a
	right outer join tbl_member m
	on a.member_id = m.member_id
	group by member_id
);
-- select * from view_board_answer_write_count;

-- 획득한 반응 질문 좋아요
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
-- select * from view_saving_like_total;

-- 획득한 반응 답변 좋아요
create or replace view view_answer_like_total as (
	select m.member_id, ifnull(answer_like_count, 0) answer_like_total
	from tbl_member m 
	left outer join (
		select a.member_id, a.board_id, a.answer_id, if(l.answer_like_id=0, 0,count(l.answer_like_id)) answer_like_count
		from tbl_saving_answer a
		left outer join tbl_saving_answer_like l
		on a.answer_id = l.answer_id
		group by a.member_id
	) a 
	on m.member_id = a.member_id
	order by member_id asc
);
-- select * from view_answer_like_total;

-- 획득한 반응 관심 질문
create or replace view view_saving_favorite_total as (
	select m.member_id, sum(if(ifnull(f.favorite_id, 0)=0, 0, 1)) favorite_total
	from tbl_member m
	left outer join (
		select s.board_id , s.member_id, f.favorite_id  
		from tbl_board_saving s
		left outer join tbl_favorite f
		on s.board_id = f.board_id
	) f
	on m.member_id = f.member_id
	group by member_id
);
select * from view_saving_favorite_total;
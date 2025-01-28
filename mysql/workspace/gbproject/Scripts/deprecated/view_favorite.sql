use goldenpig;

select * from tbl_board_saving tb;
select * from tbl_favorite tf ;

-- INSERT INTO tbl_favorite
-- (member_id, board_id)
-- VALUES(1, 3);

-- 관심 질문('각 회원'의 질문에 다른 사람이 관심을 표한 횟수의 총합)
select s.board_id , s.member_id , count(f.favorite_id)
from tbl_board_saving s
left outer join tbl_favorite f
on s.board_id = f.board_id
group by member_id;

select s.member_id
-- , count(ifnull(f.favorite_id, 0)) - count(f.favorite_id=0) favorite_total 
from (
	select m.member_id , s.board_id
	from tbl_member m 
	left outer join tbl_board_saving s
	on m.member_id = s.member_id
	) s left outer join (
		select s.board_id , s.member_id, f.favorite_id 
-- 		, count(f.favorite_id) favorite_id
		from tbl_board_saving s
		left outer join tbl_favorite f
		on s.board_id = f.board_id
	) f
on s.member_id = f.member_id;

-- 각 회원의 질문에 대한 관심 총계
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

select m.member_id, sum(if(ifnull(f.favorite_id, 0)=0, 0, 1))
from tbl_member m
left outer join (
	select s.board_id , s.member_id, f.favorite_id  
	from tbl_board_saving s
	left outer join tbl_favorite f
	on s.board_id = f.board_id
) f
on m.member_id = f.member_id
group by member_id;

select s.board_id , s.member_id, f.favorite_id  
from tbl_board_saving s
left outer join tbl_favorite f
on s.board_id = f.board_id;

-- 각 회원이 게시한 게시글 번호
select m.member_id , s.board_id
from tbl_member m 
left outer join tbl_board_saving s
on m.member_id = s.member_id;
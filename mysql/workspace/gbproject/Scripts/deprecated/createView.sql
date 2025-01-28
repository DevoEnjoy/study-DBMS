use goldenPig;

-- create or replace view view_answer_like_count as (
-- 	select member_id, count(answer_like_id) like_count
-- 	from tbl_saving_answer_like
-- 	group by member_id
-- );
create or replace view view_answer_like_count as (
	select member_id, count(answer_like_id) like_count
	from tbl_saving_answer_like a right outer join tbl_member tm 
	group by tm.member_id
);
-- member_id like_count(answer)
select * from view_answer_like_count;

create or replace view view_saving_like_count as (
	select member_id, count(board_like_id) like_count from tbl_board_saving_like
	group by member_id
);
-- member_id like_count(saving)
select * from view_saving_like_count;

create or replace view view_free_like_count as (
	select member_id, if(count(like_id) > 0, count(like_id), 0) like_count
	from tbl_board_free_like
	group by member_id
);
-- member_id like_count(free)
select * from view_free_like_count;

-- =========================================================

select * from view_answer_like_count;
select * from view_saving_like_count;
select * from view_free_like_count;















-- 게시판 DTO
-- 멤버 저축 게시판 목록  / 좋아요 리스트 
select d1.member_id, d1.board_id, d1.member_name, 
d1.member_nickname, d1.board_title, d1.board_content , 
d1.board_register_date , d1.board_update_date, d1.board_read_count,
ifnull(d2.like_count, 0)
from
   (
   select m.member_id, m.member_name, m.member_nickname, 
   b.board_id, b.board_title, b.board_content , b.board_register_date , 
   b.board_update_date, b.board_read_count 
   from tbl_member m join tbl_board_free b 
   on m.member_id = b.member_id 
--    회원 전체의 게시글 조회 
   ) d1 left outer join 
   (
   select board_id, count(like_id) as like_count
   from tbl_board_free_like
   group by board_id
--    각 게시글의 좋아요 조회 
   ) d2
on d1.board_id = d2.board_id;
-- where d1.member_id = 1;

select m.member_id, m.member_name, m.member_nickname, 
b.board_id, b.board_title, b.board_content , b.board_register_date , 
b.board_update_date, b.board_read_count 
from tbl_member m join tbl_board_saving b 
on m.member_id = b.member_id ;

select board_id, count(board_like_id) as like_count
from tbl_board_saving_like
group by board_id;
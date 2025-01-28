use goldenpig;

-- 게시판 DTO
-- 자유 게시판 좋아요 개수
create or replace view view_board_free_likecount as (
	select left_table.member_id,/* sum(left_table.board_read_count) read_count,*/ 
	sum(ifnull(right_table.like_count, 0)) like_count /* 좋아요 총계 */
	from
	   (
		   select m.member_id, m.member_name, m.member_nickname, 
		   b.board_id, b.board_title, b.board_content , b.board_register_date , 
		   b.board_update_date, b.board_read_count 
		   from tbl_member m join tbl_board_free b 
		   on m.member_id = b.member_id 
	--    회원 전체의 게시글 조회 
	   ) left_table left outer join 
	   (
		   select board_id, count(like_id) as like_count
		   from tbl_board_free_like
		   group by board_id
	--    각 게시글의 좋아요 조회 
	   ) right_table
	on left_table.board_id = right_table.board_id
	group by left_table.member_id
);
select * from view_board_free_likecount vbfl ;

-- 저축게시판 질문 좋아요 개수
create or replace view view_board_saving_likecount as (
	select left_table.member_id,/* sum(left_table.board_read_count) read_count,*/ 
	sum(ifnull(right_table.like_count, 0)) like_count /* 좋아요 총계 */
	from
	   (
		   select m.member_id, m.member_name, m.member_nickname, 
		   b.board_id, b.board_title, b.board_content , b.board_register_date , 
		   b.board_update_date, b.board_read_count 
		   from tbl_member m join tbl_board_saving b 
		   on m.member_id = b.member_id 
	--    회원 전체의 게시글 조회 
	   ) left_table left outer join 
	   (
		   select board_id, count(board_like_id) as like_count
		   from tbl_board_saving_like
		   group by board_id
	--    각 게시글의 좋아요 조회 
	   ) right_table
	on left_table.board_id = right_table.board_id
	group by left_table.member_id
);
select * from view_board_saving_likecount;


-- 저축게시판 답변 좋아요 개수
create or replace view view_board_answer_likecount as (
	select left_table.member_id,/* sum(left_table.board_read_count) read_count,*/ 
	sum(ifnull(right_table.like_count, 0)) like_count /* 좋아요 총계 */
	from
	   (
		   select m.member_id, m.member_name, m.member_nickname, 
		   b.board_id, b.answer_title, b.answer_content , b.answer_register_date , 
		   b.answer_update_date, b.answer_id 
		   from tbl_member m join tbl_saving_answer b 
		   on m.member_id = b.member_id 
	--    회원 전체의 게시글 조회 
	   ) left_table left outer join
	   (
		   select answer_id, count(answer_like_id) as like_count
		   from tbl_saving_answer_like
		   group by answer_id
	--    각 게시글의 좋아요 조회 
	   ) right_table
	on left_table.answer_id = right_table.answer_id
	group by left_table.member_id
);
select * from view_board_answer_likecount;


-- 답변 좋아요 총계
create or replace view view_answer_like_count as (
	select m.member_id, count(a.board_id) board_write_count
	from tbl_saving_answer a
	right outer join tbl_member m
	on f.member_id = m.member_id
	group by member_id
)




-- 자유게시판 게시글 개수
create or replace view view_board_free_write_count as (
	select m.member_id, count(f.board_id) board_write_count
	from tbl_board_free f
	right outer join tbl_member m
	on f.member_id = m.member_id
	group by member_id
);
select * from view_board_free_write_count;

-- 나의 활동 - 질문
create or replace view view_board_saving_write_count as (
	select m.member_id, count(s.board_id) saving_write_count
	from tbl_board_saving s
	right outer join tbl_member m
	on s.member_id = m.member_id
	group by member_id
);
select * from view_board_saving_write_count;

-- 답변게시판 게시글 개수
create or replace view view_board_answer_write_count as (
	select m.member_id, count(a.board_id) answer_write_count
	from tbl_saving_answer a
	right outer join tbl_member m
	on a.member_id = m.member_id
	group by member_id
);
select * from view_board_answer_write_count;









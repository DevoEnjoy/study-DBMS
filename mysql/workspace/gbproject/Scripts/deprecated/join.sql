use goldenPig;

-- 게시판 정보 + 댓글 개수
/*select b.board_id, b.board_title, b.board_content, b.board_register_date, 
b.board_update_date, b.member_id, b.like_count, count(r.reply_id) reply_count
from tbl_board b inner join tbl_replyfree r
on b.board_id = r.board_id 
group by b.board_id;*/

-- 게시판 정보 + 멤버 정보 뷰
create or replace view view_boardFree as 
select b.board_id, b.board_title, b.board_content, b.board_register_date,
b.board_update_date, m.member_nickname, b.board_like_count, b.board_read_count
from tbl_member m inner join tbl_boardfree b 
on m.member_id = b.member_id;

select * from view_boardfree;

-- 각 게시판에 달린 댓글 개수 뷰(댓글 개수 0이면 행 없음)
create or replace view view_replyfree_count as
select b.board_id, count(r.reply_id) reply_count
from view_boardfree b inner join tbl_replyfree r
on b.board_id = r.board_id 
group by b.board_id ;

select * from view_replyfree_count ;

-- 게시판 정보 + 멤버 닉네임 + 댓글 개수 뷰
create or replace view view_boardFreeList as
select b.board_id, b.board_title, b.board_content, b.board_register_date,
b.board_update_date, b.member_nickname, b.board_like_count, b.board_read_count, r.reply_count
from view_boardfree b inner join view_replyfree_count r
on b.board_id = r.board_id 
group by b.board_id;

select * from view_boardfreelist ;


-- 게시판 정보 + 멤버 닉네임 + 댓글 개수 + 태그 명
create or replace view view_boardfree_search as
select b.board_id, b.board_title, b.board_content, b.board_register_date,
b.board_update_date, b.member_nickname, b.board_like_count, b.board_read_count, 
reply_count, t.tag_name
from view_boardFreeList b inner join tbl_tagfree t
on b.board_id = t.board_id;

select * from view_boardfree_search ;

select count(board_id) from tbl_boardfree;
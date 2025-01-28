use goldenpig;

-- select f.member_id, f.board_id , f.board_title , f.board_register_date, 'free' category
-- from tbl_board_free f;
-- 
-- select s.member_id, s.board_id , s.board_title , s.board_register_date , 'saving' category
-- from tbl_board_saving s;


/*
select f.member_id, f.board_id , f.board_title , f.board_register_date, count(l.like_id), 'free' category
from tbl_board_free f left outer join tbl_board_free_like l 
on f.board_id = l.board_id
group by board_id;

select s.member_id, s.board_id , s.board_title , s.board_register_date , count(l.board_like_id), 'saving' category
from tbl_board_saving s left outer join tbl_board_saving_like l
on s.board_id = l.board_id
group by board_id ;
*/

-- 어드민용 자유게시판(카테고리 추가)
create or replace view view_admin_free as (
	select  f.board_id, f.member_id, f.board_title , f.board_register_date, count(l.like_id) like_count, 'free' category
	from tbl_board_free f left outer join tbl_board_free_like l 
	on f.board_id = l.board_id
	group by board_id
);
select * from view_admin_free;
	
-- 어드민용 저축게시판(카테고리 추가)
create or replace view view_admin_saving as (
	select s.board_id, s.member_id, s.board_title , s.board_register_date , count(l.board_like_id) like_count, 'saving' category
	from tbl_board_saving s left outer join tbl_board_saving_like l
	on s.board_id = l.board_id
	group by board_id
);
select * from view_admin_saving;

-- select 
-- from view_admin_free f join view_admin_saving s
-- on f.member_id = s.member_id ;

select *
from view_admin_free f
union All
select *
from view_admin_saving s
order by board_register_date ;

create or replace view view_admin_board_list as (
	select *
	from (
		select  f.board_id, f.member_id, f.board_title , f.board_register_date, count(l.like_id) like_count, 'free' category
		from tbl_board_free f left outer join tbl_board_free_like l 
		on f.board_id = l.board_id
		group by board_id
	) f
	union All
	select *
	from (
		select s.board_id, s.member_id, s.board_title , s.board_register_date , count(l.board_like_id) like_count, 'saving' category
		from tbl_board_saving s left outer join tbl_board_saving_like l
		on s.board_id = l.board_id
		group by board_id
	) s
	order by board_register_date
);
select * from view_admin_board_list;




select 
from (
	select m.member_id, f.board_id , f.board_title , f.board_register_date, 1 category
	from tbl_member m left outer join tbl_board_free f
	on m.member_id = f.member_id
) join (
	select m.member_id, s.board_id , s.board_title , s.board_register_date , 2 category
	from tbl_member m left outer join tbl_board_saving s
	on m.member_id = f.member_id
)


/*저축 게시판 
   저축 게시판 목록
      board_id      board_title      memeber_name      board_register_date

   저축 게시판 상세보기
      board_title      member_name      board_register_date      board_content

자유 게시판 동일*/

select member_id,  from tbl_member tm ;
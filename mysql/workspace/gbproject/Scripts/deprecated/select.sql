use goldenPig;

select * from tbl_banner;
select * from tbl_board_free;
select * from tbl_board_free_img;
select * from tbl_board_free_like;
select * from tbl_board_free_reply;
select * from tbl_board_saving;
select * from tbl_board_saving_img;
select * from tbl_board_saving_like;
select * from tbl_board_saving_reply;
select * from tbl_board_saving_tag;
select * from tbl_favorite;
select * from tbl_member;
select * from tbl_money;
select * from tbl_notice;
select * from tbl_saving_answer;
select * from tbl_saving_answer_like;
select * from tbl_saving_answer_reply;

select f.board_id , f.member_id, f.member_nickname ,  f.board_title
			, f.board_update_date, f.board_register_date , f.board_read_count , ifnull(l.like_count, 0) board_like_count, ifnull(r.reply_count, 0) board_reply_count
		from
		(
			select f.board_id , f.member_id, m.member_nickname ,  f.board_title
			, f.board_update_date, f.board_register_date , f.board_read_count 
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
		order by board_id desc 
		limit 5, 5;




SELECT board_id, member_id, board_title, board_content, 
board_register_date, board_update_date, board_like_count, board_read_count, 
board_reply_count
FROM tbl_board_free;

select count(board_id) board_count from tbl_board_free;
SELECT board_id, member_id, board_title, board_content, 
board_register_date, board_update_date, board_read_count 
FROM tbl_board_free;

SELECT board_id, member_id, board_title, board_content, 
board_register_date, board_update_date, board_read_count 
FROM tbl_board_free;

select member_id, count(board_id) freeCount from tbl_board_free
group by member_id;

select member_id, count(board_id) savingCount from tbl_board_saving
group by member_id ;

	SELECT COALESCE(f.member_id, s.member_id) AS member_id, ifnull(f.freeCount, 0) freeCount, ifnull(s.savingCount, 0) save 
	FROM (
	    SELECT member_id, COUNT(board_id) freeCount FROM tbl_board_free
	    GROUP BY member_id
	) f
	LEFT OUTER JOIN (
	    SELECT member_id, COUNT(board_id) savingCount FROM tbl_board_saving
	    GROUP BY member_id 
	) s
	ON f.member_id = s.member_id;

SELECT COALESCE(f.member_id, s.member_id) AS member_id, ifnull(f.freeCount, 0) freeCount, ifnull(s.savingCount, 0) save 
FROM (
    SELECT member_id, COUNT(board_id) freeCount FROM tbl_board_free
    GROUP BY member_id
) f
right OUTER JOIN (
    SELECT member_id, COUNT(board_id) savingCount FROM tbl_board_saving
    GROUP BY member_id 
) s
ON f.member_id = s.member_id;


select COALESCE(s.member_id, f.member_id) AS member_id, ifnull(f.freeCount, 0) , ifnull(s.savingCount, 0)
(
	SELECT COALESCE(f.member_id, s.member_id) AS member_id, ifnull(f.freeCount, 0) freeCount, ifnull(s.savingCount, 0) save 
	FROM (
	    SELECT member_id, COUNT(board_id) freeCount FROM tbl_board_free
	    GROUP BY member_id
	) f
	LEFT OUTER JOIN (
	    SELECT member_id, COUNT(board_id) savingCount FROM tbl_board_saving
	    GROUP BY member_id 
	) s
	ON f.member_id = s.member_id
) s inner join
(
	SELECT COALESCE(f.member_id, s.member_id) AS member_id, ifnull(f.freeCount, 0) freeCount, ifnull(s.savingCount, 0) save 
	FROM (
	    SELECT member_id, COUNT(board_id) freeCount FROM tbl_board_free
	    GROUP BY member_id
	) f
	right OUTER JOIN (
	    SELECT member_id, COUNT(board_id) savingCount FROM tbl_board_saving
	    GROUP BY member_id 
	) s
	ON f.member_id = s.member_id
) f
on i.member_id = o.member_id;


	select member_id, ifnull(count(board_id), 0) freeCount from tbl_board_free
	group by member_id;

	select member_id, if(count(board_id)='', 0) savingCount from tbl_board_saving
	group by member_id ;

select board_id, member_id, board_title, board_content, board_register_date, 
board_update_date, board_read_count
from tbl_board_free 
order by board_id desc ;







select b.board_id, b.member_id, b.board_title, b.board_content, b.board_register_date
			,b.board_update_date, b.member_nickname, c.favorite_count board_favorite_count
			, c.reply_count board_reply_count, c.like_count board_like_count, b.board_read_count
		from (
			select f.board_id, f.member_id, f.board_title, f.board_content, f.board_register_date, 
			f.board_update_date, m.member_nickname, f.board_read_count
			from tbl_board_free f
			left outer join tbl_member m
			on f.member_id = m.member_id
		) b left outer join (
				select f.board_id , f.favorite_count, r.reply_count, l.like_count
			from (
				select s.board_id, sum(if(ifnull(f.favorite_id , 0)=0, 0, 1)) favorite_count
				from tbl_board_saving s left outer join tbl_favorite f 
				on s.board_id = f.board_id
				group by board_id
			) f left outer join (
				select s.board_id , sum(if(ifnull(r.reply_id, 0)=0, 0, 1)) reply_count
				from tbl_board_saving s left outer join tbl_board_saving_reply r
				on s.board_id = r.board_id
				group by board_id
			) r
			on f.board_id = r.board_id
			left outer join (
				select s.board_id , sum(if(ifnull(l.board_like_id, 0)=0, 0, 1)) like_count  
				from tbl_board_saving s left outer join tbl_board_saving_like l
				on s.board_id = l.board_id
				group by board_id
			) l
			on f.board_id = l.board_id
			group by board_id
		) c
		on b.board_id = c.board_id
		where b.board_id = 32;




use goldenpig;

select like_id, member_id, board_id from tbl_board_free_like
where board_id = 1 and member_id = 1;

select * from tbl_board_free_like;
where board_id = 34;


select b.board_id, b.member_id, b.board_title, b.board_content, b.board_register_date
			,b.board_update_date, b.member_nickname
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
		where b.board_id = 34;
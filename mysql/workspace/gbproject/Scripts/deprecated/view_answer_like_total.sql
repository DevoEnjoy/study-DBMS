use goldenpig;

/*-- 답변 게시글 좋아요 총계
create or replace view view_answer_like_count as (
	select a.member_id, a.board_id, a.answer_id, if(l.answer_like_id=0, 0,count(l.answer_like_id)) answer_like_count
	from tbl_saving_answer a
	left outer join tbl_saving_answer_like l
	on a.answer_id = l.answer_id
	group by a.member_id
);
select * from view_answer_like_count;*/

-- 답변글 좋아요 총계
/*create or replace view view_answer_like_total as (
	select m.member_id, ifnull(answer_like_count, 0) answer_like_total
	from view_answer_like_count a
	right outer join tbl_member m 
	on m.member_id = a.member_id
	order by member_id asc
);
select * from view_answer_like_total;
select * from tbl_member tm ;*/


/*-- 답변글 좋아요 총계
create or replace view view_answer_like_total as (
	select m.member_id, ifnull(answer_like_count, 0) answer_like_total
	from (
		select a.member_id, a.board_id, a.answer_id, if(l.answer_like_id=0, 0,count(l.answer_like_id)) answer_like_count
		from tbl_saving_answer a
		left outer join tbl_saving_answer_like l
		on a.answer_id = l.answer_id
		group by a.member_id
	) a
	right outer join tbl_member m 
	on m.member_id = a.member_id
	order by member_id asc
);
select * from view_answer_like_total;*/


	-- 답변 좋아요
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
	select * from view_answer_like_total;
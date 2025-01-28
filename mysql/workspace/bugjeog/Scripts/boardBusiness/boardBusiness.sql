use bugjeog;

select board_business_id, business_id, board_business_title
    , board_business_content, board_business_register_date, board_business_update_date
from tbl_board_business;

-- select board_business_id, business_id, board_business_title
--     , board_business_content, board_business_register_date
--     , board_business_update_date
-- from tbl_board_business
-- where business_id = #{businessId}


delete from tbl_board_business
where board_business_id=0;

select board_business_id, business_id, board_business_title
, board_business_content, board_business_register_date, board_business_update_date
from tbl_board_business;

select b.board_business_id, b.business_id, b.board_business_title
, b.board_business_content, b.board_business_register_date, b.board_business_update_date
, i.board_business_img_id , i.board_business_img_original_name , i.board_business_img_uuid 
, i.board_business_img_path
from tbl_board_business b
left outer join tbl_board_business_img i
on b.board_business_id = i.board_business_id
-- group by b.board_business_id
;

select b.board_business_id, b.business_id, b.board_business_title
, b.board_business_content, b.board_business_register_date, b.board_business_update_date
, i.board_business_img_id , i.board_business_img_original_name , i.board_business_img_uuid 
, i.board_business_img_path, ifnull(r.board_business_review_count, 0) board_business_review_count
, ifnull(r.board_business_grade_average, 0) board_business_grade_average
from tbl_board_business b
left outer join (
	select
	i.board_business_img_id
	, i.board_business_id , i.board_business_img_original_name 
	, i.board_business_img_uuid , i.board_business_img_path
	from tbl_board_business_img i
	group by i.board_business_id
	order by i.board_business_img_id 
) i
on b.board_business_id = i.board_business_id
left outer join (
	select r.review_id, r.member_id , b.board_business_id, count(r.review_id) board_business_review_count
	, ifnull(avg(r.review_grade), 0) board_business_grade_average
	from tbl_business_review r
	right outer join tbl_board_business b
	on r.board_business_id = b.board_business_id
	group by r.board_business_id
) r
on r.board_business_id = b.board_business_id 
;

select
i.board_business_img_id
, i.board_business_id , i.board_business_img_original_name 
, i.board_business_img_uuid , i.board_business_img_path
from tbl_board_business_img i
group by i.board_business_id
order by i.board_business_img_id 
;


select r.review_id, r.member_id , r.board_business_id, count(review_id) board_business_review_count
-- , r.review_content, r.review_register_date , r.review_update_date
-- , r.review_grade 
from tbl_business_review r
group by member_id;


select r.review_id, r.member_id , b.board_business_id, count(r.review_id) board_business_review_count
, ifnull(avg(r.review_grade), 0) 
from tbl_business_review r
right outer join tbl_board_business b
on r.board_business_id = b.board_business_id
group by r.board_business_id;





/* 리스트 카테고리까지 뿌리기 */
select b.board_business_id, b.business_id, b.board_business_title
, b.board_business_content, b.board_business_register_date, b.board_business_update_date
, i.board_business_img_id , i.board_business_img_original_name , i.board_business_img_uuid
, i.board_business_img_path, ifnull(r.board_business_review_count, 0) board_business_review_count
, ifnull(r.board_business_grade_average, 0) board_business_grade_average
, bs.business_category, bs.business_location
from tbl_board_business b
left outer join (
    select
    i.board_business_img_id
    , i.board_business_id , i.board_business_img_original_name
    , i.board_business_img_uuid , i.board_business_img_path
    from tbl_board_business_img i
    group by i.board_business_id
    order by i.board_business_img_id
) i
on b.board_business_id = i.board_business_id
left outer join (
    select r.review_id, r.member_id , b.board_business_id, count(r.review_id) board_business_review_count
    , ifnull(avg(r.review_grade), 0) board_business_grade_average
    from tbl_business_review r
    right outer join tbl_board_business b
    on r.board_business_id = b.board_business_id
    group by r.board_business_id
) r
on r.board_business_id = b.board_business_id
join tbl_business bs
on b.business_id = bs.business_id;

/* 카테고리 검색 */
select b.board_business_id, b.business_id, b.board_business_title
, b.board_business_content, b.board_business_register_date, b.board_business_update_date
, i.board_business_img_id , i.board_business_img_original_name , i.board_business_img_uuid
, i.board_business_img_path, ifnull(r.board_business_review_count, 0) board_business_review_count
, ifnull(r.board_business_grade_average, 0) board_business_grade_average
, bs.business_category, bs.business_location
from tbl_board_business b
left outer join (
    select
    i.board_business_img_id
    , i.board_business_id , i.board_business_img_original_name
    , i.board_business_img_uuid , i.board_business_img_path
    from tbl_board_business_img i
    group by i.board_business_id
    order by i.board_business_img_id
) i
on b.board_business_id = i.board_business_id
left outer join (
    select r.review_id, r.member_id , b.board_business_id, count(r.review_id) board_business_review_count
    , ifnull(avg(r.review_grade), 0) board_business_grade_average
    from tbl_business_review r
    right outer join tbl_board_business b
    on r.board_business_id = b.board_business_id
    group by r.board_business_id
) r
on r.board_business_id = b.board_business_id
join tbl_business bs
on b.business_id = bs.business_id
where bs.business_category = "해산물";

select b.board_business_id, b.business_id, b.board_business_title
, b.board_business_content, b.board_business_register_date, b.board_business_update_date
, i.board_business_img_id , i.board_business_img_original_name , i.board_business_img_uuid
, i.board_business_img_path, ifnull(r.board_business_review_count, 0) board_business_review_count
, ifnull(r.board_business_grade_average, 0) board_business_grade_average
, bs.business_category, bs.business_location
from tbl_board_business b
left outer join (
    select
    i.board_business_img_id
    , i.board_business_id , i.board_business_img_original_name
    , i.board_business_img_uuid , i.board_business_img_path
    from tbl_board_business_img i
    group by i.board_business_id
    order by i.board_business_img_id
) i
on b.board_business_id = i.board_business_id
left outer join (
    select r.review_id, r.member_id , b.board_business_id, count(r.review_id) board_business_review_count
    , ifnull(avg(r.review_grade), 0) board_business_grade_average
    from tbl_business_review r
    right outer join tbl_board_business b
    on r.board_business_id = b.board_business_id
    group by r.board_business_id
) r
on r.board_business_id = b.board_business_id
join tbl_business bs
on b.business_id = bs.business_id
-- where bs.business_category = '육류'
order by b.board_business_id desc
-- order by board_business_grade_average desc
;


select * from tbl_business ;
select bs.board_business_id, bs.business_id, bs.board_business_title
, bs.board_business_content, bs.board_business_register_date, bs.board_business_update_date
, b.business_ceo_name, b.business_number, b.business_company_name, b.business_phone_number
, b.business_establishment_date, b.business_register_date, b.business_img_original_name
, b.business_img_uuid, b.business_img_path, b.business_location, b.business_category
from tbl_board_business bs
join tbl_business b
on b.business_id = bs.business_id
where board_business_id = 3
;




















use bugjeog;

select * from tbl_member;
select * from tbl_business;
select * from tbl_board_free;
select * from tbl_board_free_img;
select * from tbl_free_reply;
select * from tbl_free_like;
select * from tbl_board_business;
select * from tbl_board_business_img;
select * from tbl_business_review;
select * from tbl_board_inquiry;
select * from tbl_board_inquiry_answer;
select * from tbl_interesting_company;

insert into tbl_business_review
(member_id, board_business_id, review_content, review_grade)
values(11, 12, '리뷰입니다.', 4);

select b.board_business_id, b.business_id, board_business_title, board_business_content, 
board_business_register_date, board_business_update_date, board_business_status, 
board_business_img_original_name, board_business_img_uuid, board_business_img_path, main, 
business_location, business_category,
count(review_id) boardBusinessReviewCount, ifnull(avg(review_grade), 0) boardBusinessGradeAverage
from tbl_board_business b join tbl_board_business_img f
on b.board_business_id = f.board_business_id and f.main = 1 join tbl_business m
on b.business_id = m.business_id left outer join tbl_business_review r
on b.board_business_id = r.board_business_id
group by b.board_business_id, b.business_id, board_business_title, board_business_content, 
board_business_register_date, board_business_update_date, board_business_status, 
board_business_img_original_name, board_business_img_uuid, board_business_img_path, main, 
business_location, business_category

alter table tbl_board_business_img add column(main char(1) default 0);

select b.board_business_id, business_id, board_business_title, board_business_content, board_business_register_date, board_business_update_date, board_business_status
from tbl_board_business b join
(
select board_business_id, board_business_img_original_name, board_business_img_uuid, board_business_img_path
from tbl_board_business_img where main = 1
) f
on b.board_business_id = f.board_business_id;

SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select * from tbl_board_business
limit 0, 15;



SELECT
        ifnull(br.review_count, 0) as board_business_review_count,
        ifnull(br.board_business_grade_average, 0) as board_business_grade_average,
        bb.board_business_id,
        bb.board_business_title,
        bb.board_business_content,
        bb.board_business_register_date,
        bb.board_business_update_date,
        b.business_id,
        b.business_email,
        b.business_ceo_name,
        b.business_number,
        b.business_company_name,
        b.business_phone_number,
        b.business_establishment_date,
        b.business_register_date,
        ifnull(b.business_location, "미기재") business_location,
        ifnull(b.business_category, "미기재") business_category
        FROM
        (
        SELECT
        business_id,
        board_business_id,
        board_business_title,
        board_business_content,
        board_business_register_date,
        board_business_update_date,
        board_business_status
        FROM tbl_board_business
        where board_business_status = 1
        ) bb
        LEFT JOIN (
        select
        business_id,
        business_email,
        business_ceo_name,
        business_number,
        business_company_name,
        business_phone_number,
        business_establishment_date,
        business_register_date,
        business_status,
        ifnull(business_location, "미기재") business_location,
        ifnull(business_category, "미기재") business_category
        from tbl_business
        WHERE business_status = 1
        ) b ON bb.business_id = b.business_id
        LEFT JOIN tbl_board_business_img bi ON bb.board_business_id = bi.board_business_id
        LEFT JOIN (
        select
        COUNT(review_id) AS review_count, ifnull(AVG(review_grade), 0) as board_business_grade_average
        , board_business_id
        FROM tbl_business_review
        GROUP BY board_business_id) br ON bb.board_business_id = br.board_business_id
        WHERE business_status = 1
--         and b.business_category = #{searchMap.category}
--         and b.business_id = #{searchMap.businessId}
        GROUP BY
        bb.board_business_id,
        bb.board_business_title,
        bb.board_business_content,
        bb.board_business_register_date,
        bb.board_business_update_date,
        bb.board_business_status,
        b.business_id,
        b.business_email,
        b.business_ceo_name,
        b.business_number,
        b.business_company_name,
        b.business_phone_number,
        b.business_establishment_date,
        b.business_register_date,
        b.business_status,
        b.business_location,
        b.business_category
        LIMIT 0, 5;
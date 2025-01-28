use bugjeog;

select r.review_id, r.member_id, r.board_business_id
, r.review_content, r.review_register_date, r.review_update_date
, r.review_grade
, m.memeber_name, m.member_img_original_name, m.member_img_uuid
, m.member_img_path 
from tbl_business_review r
join tbl_member m
on r.member_id = m.member_id
where board_business_id = 3;

select member_id, member_email, member_password, member_phone_number, memeber_name, member_register_date, member_status, member_img_original_name, member_img_uuid, member_img_path
from tbl_member;
where member_id = #{memberId};

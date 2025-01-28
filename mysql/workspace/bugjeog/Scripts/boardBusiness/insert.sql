use bugjeog;

INSERT INTO tbl_business
(business_email, business_password
, business_ceo_name, business_number
, business_company_name, business_phone_number
, business_establishment_date, business_register_date
, business_status, business_img_original_name
, business_img_uuid, business_img_path)
VALUES('miraclelee0612@gmail.com', '1q2w3e4r'
, '사장2', 2
, '회사명2', '01012341234'
, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
, 2, ''
, '2', '');

INSERT INTO tbl_board_business (business_id, board_business_title, board_business_content, board_business_register_date, board_business_update_date)
values
(2, '제목2', '내용2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, '제목3', '내용3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, '제목4', '내용4', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, '제목5', '내용5', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
;

INSERT INTO tbl_business
(
	business_email, business_password, business_ceo_name
	, business_number, business_company_name, business_phone_number
	, business_establishment_date, business_register_date, business_status
)
VALUES(
	'asd1@', 'asd1q2w1', 'LJS'
	, '11-11-0001', 'comp1', '01012340001'
	, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1
);


INSERT INTO tbl_member
(
	member_email, member_password, member_phone_number
	, memeber_name, member_register_date, member_status
	, member_img_original_name, member_img_uuid, member_img_path
)
VALUES(
	'asd2@asd2.com', '1234', '01012341232'
	, 'asd', CURRENT_TIMESTAMP, 1
	, 'asd', 'asd2', 'asd'
);



INSERT INTO tbl_business_review
(
	member_id, board_business_id, review_content
	, review_register_date, review_update_date, review_grade
)
VALUES(
	3, 3, 'asd'
	, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 5
);

select * from tbl_member tm ;
select * from tbl_business_review tbr ;
INSERT INTO tbl_business_review (member_id, board_business_id, review_content, review_grade)
VALUES
  (1, 1, '이 가게 정말 좋아요!', 5),
  (8, 1, '서비스도 좋고 음식도 맛있어요.', 4),
  (9, 2, '아쉬운 부분도 있었지만 전체적으로 만족합니다.', 3),
  (9, 3, '한번 더 방문하고 싶은 맛집입니다.', 4),
  (9, 3, '분위기가 좋아서 더 좋았던 곳입니다.', 4);























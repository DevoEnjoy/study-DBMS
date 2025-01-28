use goldenPig;

-- 멤버 추가
INSERT INTO goldenpig.tbl_member
(member_email, member_password, member_name, member_nickname, 
member_phonenumber, member_birth)
VALUES('miraclelee9999@gmail.com', '1234', 'mi', 'mi06', 
'01012341239', '1993-06-13');
select * from tbl_member tm ;


-- 자유 게시글
INSERT INTO tbl_board_free
(member_id, board_title, board_content, board_register_date, 
board_update_date)
VALUES(3, 'testtitle123', 'testcontent3', CURRENT_TIMESTAMP, 
CURRENT_TIMESTAMP);
select * from tbl_board_free tbf ;

INSERT INTO tbl_board_free
(member_id, board_title, board_content, board_register_date, board_update_date, board_read_count)
VALUES(0, '', '', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 0);


-- 저축 게시글
INSERT INTO goldenpig.tbl_board_saving
(member_id, board_title, board_content, board_register_date, 
board_update_date, board_read_count)
VALUES(3, 'asd', 'asddd', CURRENT_TIMESTAMP, 
CURRENT_TIMESTAMP, 0);
select * from tbl_board_saving tbs ;

-- 답글 게시글
INSERT INTO goldenpig.tbl_saving_answer
(board_id, member_id, answer_title, answer_content, 
answer_register_date, answer_update_date)
VALUES(2, 3, 'asd', 'asdd', 
CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
select * from tbl_saving_answer tsa ;

-- 자유 좋아요
INSERT INTO goldenpig.tbl_board_free_like
(member_id, board_id)
VALUES(3, 13);
select * from tbl_board_free_like tbfl;

-- 저축 좋아요
INSERT INTO goldenpig.tbl_board_saving_like
(member_id, board_id)
VALUES(1, 5);
select * from tbl_board_saving_like tbsl ;

-- 답글 좋아요
INSERT INTO goldenpig.tbl_saving_answer_like
(member_id, answer_id)
VALUES(4, 1);

select * from tbl_board_free tbf ;
select * from tbl_member tm ;
-- 자유게시판 게시글 댓글 달기
INSERT INTO tbl_board_free_reply
(reply_content, reply_register_date, reply_update_date, member_id, board_id)
VALUES('2 4 두번째 댓글', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 2, 4);
select * from tbl_board_free_reply tbfr ;

INSERT INTO tbl_banner
(banner_id, banner_system_name, banner_original_name, banner_register_date, banner_status)
VALUES(1, 'banner_01.png', 'banner_01.png', CURRENT_TIMESTAMP, 1);
INSERT INTO tbl_banner
(banner_id, banner_system_name, banner_original_name, banner_register_date, banner_status)
VALUES(2, 'banner_02.png', 'banner_02.png', CURRENT_TIMESTAMP, 1);
INSERT INTO tbl_banner
(banner_id, banner_system_name, banner_original_name, banner_register_date, banner_status)
VALUES(3, 'banner_03.png', 'banner_03.png', CURRENT_TIMESTAMP, 1);
INSERT INTO tbl_banner
(banner_id, banner_system_name, banner_original_name, banner_register_date, banner_status)
VALUES(4, 'banner_04.png', 'banner_04.png', CURRENT_TIMESTAMP, 1);


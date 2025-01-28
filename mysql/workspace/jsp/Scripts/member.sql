create database jsp;

use jsp;

create table tbl_member(
	member_id int unsigned auto_increment primary key,
	member_name varchar(500),
	member_birth date,
	member_identification varchar(500),
	member_password varchar(500)
);

select member_id from tbl_member where member_identification = 'asd' and member_password = '213';

-- alter table tbl_member add column(member_identification varchar(500));
-- alter table tbl_member add column(member_password varchar(500));
-- drop table tbl_member;
select * from tbl_member;
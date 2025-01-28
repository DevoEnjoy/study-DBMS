use spring;
create table tbl_order(
	order_id int unsigned auto_increment primary key,
	product_id int unsigned,
	product_count int default 1,
	order_date datetime default current_timestamp(),
	constraint fk_order_product foreign key(product_id)
	references tbl_product(product_id)
);

select * from tbl_product tp ;

select o.order_id, o.product_id, o.product_count, o.order_date
, p.product_name, (p.product_price * o.product_count) order_total_price
from tbl_order o
join tbl_product p
on o.product_id = p.product_id
group by order_id;

insert into tbl_order
(product_id, product_count, order_date)
values(1, 3, current_timestamp());

select * from tbl_order to2 ;
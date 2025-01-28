create database spring;
use spring;

create table tbl_product(
	product_id int unsigned auto_increment primary key,
	product_name varchar(500) not null,
	product_price int default 0,
	product_stock int default 0
);

alter table product rename to tbl_product;
select * from tbl_product;

INSERT INTO product
(product_name, product_price, product_stock)
VALUES('', 0, 0);

UPDATE product
SET product_name='', product_price=0, product_stock=0
WHERE product_id=0;

DELETE FROM product
WHERE product_id=0;

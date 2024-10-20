-------------------------주문 테이블(order_table)----------------------
create table order_table(
    o_order_number VARCHAR2(30) PRIMARY KEY,
    o_address VARCHAR2(50) NOT NULL,
    o_name VARCHAR2(20) NOT NULL,
    o_book_name VARCHAR2(50) NOT NULL,
    o_total number(20) NOT NULL,
	o_price number NOT NULL,
    o_quantity number(10) NOT NULL,
    o_phone VARCHAR2(30) NOT NULL,
    o_order_code VARCHAR2(20) NOT NULL
);
commit;
--테이블 삭제
drop table order_table;
insert into order_table values('주문번호','주소','박승wns','책이름',1,1,1,'핸드폰 번호','0');
insert into order_table values('아이디1', '주문번호1', '주소1', '이름', 1, 1, '폰번호', '0');
select * from order_table;
select * from order_table;
select * from order_table where o_order_number = 'merchant_1692577622064';
select * from order_table where o_order_number= #{o_order_number};
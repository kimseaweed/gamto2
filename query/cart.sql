---------------------------장바구니 (cart)-------------------
create table cart(
    cart_seq_number NUMBER PRIMARY KEY,
    cart_id VARCHAR2(20) NOT NULL,
    cart_code VARCHAR(20) NOT NULL,
    cart_quantity NUMBER DEFAULT 0 -- 구매 수량
);

commit;
--테이블 삭제
drop table cart;
--시퀀스 생성
create sequence cart_seq;
--시퀀스 드랍 
drop sequence cart_seq;
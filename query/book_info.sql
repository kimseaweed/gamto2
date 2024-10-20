----------------------------- book_info table 만들기 ---------------------------
create table book_info(
    b_seq_number number(4) primary key,
    b_code VARCHAR2(20) NOT NULL UNIQUE, --책 코드번호   
    b_name VARCHAR2(50) NOT NULL, --책 이름
    b_author VARCHAR2(100) NOT NULL, --작가
    b_publisher VARCHAR2(20) NOT NULL, --출판사
    b_release VARCHAR2(20) NOT NULL, --출판일
    b_filename VARCHAR2(30) NOT NULL, --책 표지 이미지
    b_genre VARCHAR2(20) NOT NULL, --책의 장르
    b_price NUMBER NOT NULL, --책 가격
    b_stock NUMBER NOT NULL, -- 책 재고
    b_description VARCHAR2(1000) NOT NULL, -- 책 설명
    b_quantity NUMBER DEFAULT 0, -- 구매 수량
    b_delete number default 0 not null
);

commit;
--테이블 삭제
drop table book_info;
--시퀀스 생성 
create sequence b_seq_number;
--데이터 입력
insert into book_info values(b_seq_number.nextVal, 'ISBN0001', '사피엔스', '유발 하라리', '김영사', '2023.04.01', 'ISBN0001.jpeg', '인문학', 20000, 500, '인류에 대해 분석하다', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0002', '종의 기원', '정유정', '은행나무', '2016.05.16', 'ISBN0002.jpeg', '소설', 20000, 500, '사이코패스의 살인 이야기', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0003', '백엔드', '남궁', '가나다', '2020.05.16', 'ISBN0003.jpeg', '프로그래밍', 15000, 500, '백엔드 개발자를 위한 기초 서적', 0, 0);
--데이터 찾기
select * from book_info;
select sum(b_price * b_quantity) as sum from book_info;
--데이터 삭제
delete book_info where 
--데이터 업데이트
update  book_info set b_quantity=b_quantity+1 where b_code='ISBN0001';
update book_info set b_quantity=0;
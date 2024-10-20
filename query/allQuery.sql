ROLLBACK;
commit;


-----목차 ( ctrl + F )
-- ㄴselect
-- ㄴdelete
-- ㄴcreate
-- ㄴinsert sample

--01. [book_report] --너의생각 게시판 관련
--02. [free_board] --우리생각 게시판 관련
--03. [store] --상점 및 구매 관련
--04. [member] -- 회원 관련
--05. [admin] --관리자페이지 관련


-------------------select--------------------------------------
-- 01. [book_report]
select * from book_report; --너의생각 :: 게시판

-- 02. [free_board]
select * from free_board; --우리생각 :: 게시판
select * from comment_board; --우리생각 :: 댓글
select * from feeling; --우리생각 :: 좋아요

-- 03. [store]
select * from book_info; --상점 :: 판매상품 정보
select * from cart; -- 상점 :: 장바구니
select * from order_table; --상점 :: 거래내역 기록

-- 04. [member]
select * from member_function; --회원정보

-- 05. [admin]
select * from ask; -- 관리자 :: 문의
select * from accuse; --관리자 :: 신고
select * from admin; -- 관리자 :: 관리자계정

-------------------delete--------------------------------------

-- [book_report]
drop sequence book_report_seq; --너의생각 :: 게시판 시퀀스
drop table book_report; --너의생각 :: 게시판

-- [free_board]
drop sequence free_board_seq;
drop table free_board; --우리생각 :: 게시판
drop sequence comment_board_seq;
drop table comment_board; --우리생각 :: 댓글
drop sequence l_seq_number;
drop table feeling; --우리생각 :: 댓글

-- [store]
drop sequence b_seq_number; -- 상점 :: 판매상품 시퀀스
drop table book_info; -- 상점 :: 판매상품 정보
drop sequence cart_seq; -- 상점 :: 장바구니 시퀀스
drop table cart; -- 상점 :: 장바구니 
drop table order_table; -- 상점 :: 거래내역 기록

-- [member]
drop table member_function; -- 회원

-- [admin]
drop SEQUENCE ask_seq; -- 관리자 :: 문의 시퀀스
drop table ask; -- 관리자 :: 문의 기록
drop SEQUENCE accuse_seq; -- 관리자 :: 신고 시퀀스
drop table accuse; -- 관리자 :: 신고 기록
drop table admin; -- 관리자 :: 관리자계정 

-------------------create--------------------------------------
--[book_report]
create sequence book_report_seq; --너의생각 게시판 시퀀스생성
create table book_report( --너의생각 게시판
    r_seq_number number(4) primary key, -- 게시물번호
    r_title varchar2(100) not null, -- 제목 300자
    r_writer varchar2(100) not null, -- 작성자
    r_regist_day date default sysdate,-- 작성일자
    r_update_day date default sysdate, -- 수정일자
    r_filename varchar2(300), -- 첨부파일 이름
    r_recommend number default 0, -- 추천수
    r_delete number default 0 not null, -- 상태 (0정상,1삭제)
    r_view number default 0, -- 조회수
    r_content clob not null -- 내용
);

--[book_report]
create sequence free_board_seq;
create table free_board( --우리생각 게시판
    f_seq_number number(4) primary key, -- 게시물번호
    f_title varchar2(100) not null, -- 제목
    f_writer varchar2(100) not null, -- 작성자
    f_regist_day date default sysdate,-- 작성일자
    f_update_day date default sysdate, -- 수정일자
    f_recommend number default 0, -- 추천수
    f_delete number default 0 not null, -- 상태 (0정상,1삭제)
    f_view number default 0, -- 조회수
    f_content varchar2(4000) not null, --내용
    f_category varchar2(50) not null -- 카테고리
);
create sequence comment_board_seq;
create table comment_board( --우리생각 댓글
    c_seq_number number(4) primary key, --댓글번호
    f_seq_number number(4), -- 소속게시물 번호
    c_writer varchar2(100) not null, -- 작성자
    c_regist_day date default sysdate, -- 작성일자
    c_update_day date default sysdate, -- 수정일자
    c_recommend number default 0, -- 추천수
    c_derecommend number default 0, --비추천수
    c_delete number default 0 not null, -- 상태 (0정상,1삭제)
    c_content varchar2(1000) not null, -- 내용
    c_total_count number(20) default 0 -- 소속 게시물 댓글수
);
create sequence l_seq_number;
create table feeling( --좋아요 기록
    l_seq_number number primary key, --좋아요 등록번호
    l_board number(4), --소속 게시판 종류(1-너의생각 게시물, 2-우리생각게시물, 3-우리생각 댓글)
    l_number number(4), -- 게시판 번호
    l_id varchar(20), --좋아요 한 사람 아이디
    like_check number default 0 not null --추천내용(0 추천, 1비추천, 없음 삭제)
);


-- [store]
create sequence b_seq_number; -- 상점 상품등록번호
create table book_info( --상점 판매상품
    b_seq_number number(4) primary key, --상품 등록번호
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
    b_delete number default 0 not null --상태 (0정상,1판매중단)
);
create sequence cart_seq; --장바구니 생성번호
create table cart( --장바구니
    cart_seq_number NUMBER PRIMARY KEY, --장바구니 등록번호
    cart_id VARCHAR2(20) NOT NULL, -- 상품을 담은 회원의 아이디
    cart_code VARCHAR(20) NOT NULL, -- 담긴 상품의 코드번호
    cart_quantity NUMBER DEFAULT 0 -- 담긴 상품의 수량
);
create table order_table( --거래내역
    o_order_number VARCHAR2(30) PRIMARY KEY, -- 거래번호
    o_address VARCHAR2(50) NOT NULL, -- 주소
    o_name VARCHAR2(20) NOT NULL, -- 이름
    o_book_name VARCHAR2(50) NOT NULL, -- 상품명
    o_total number(20) NOT NULL, --
	o_price number NOT NULL, --
    o_quantity number(10) NOT NULL, --
    o_phone VARCHAR2(30) NOT NULL, -- 전화번호
    o_order_code VARCHAR2(20) NOT NULL -- 
);

-- [member]
create table member_function( --회원
    u_id varchar(20) PRIMARY KEY, --회원아이디
    u_pw varchar2(20) not null, --회원비밀번호
    u_name varchar2(20) not null, --회원이름
    u_phone varchar2(20) not null, --회원전화번호
    u_email varchar2(1000) not null unique, --회원메일
    u_address varchar2(1000) not null, --회원주소
    u_delete varchar2(2) not null --회원상태 (0 정상,1 탈퇴)
);

-- [admin]
create sequence ask_seq; --문의 등록번호
create table ask( --문의기록
a_seq_number number(5) default ask_seq.nextVal primary key, -- 등록번호
a_date date default sysdate not null, -- 날짜
a_id varchar2(20) null, -- 문의자 아이디
a_category varchar2(30) not null, -- 문의 유형
a_content varchar2(4000) not null, --문의 내용
a_filename varchar(300) null, -- 첨부파일명
a_email varchar2(40) not null, --문의자 이메일 주소
a_reception varchar(2) not null  CHECK (a_reception  IN ('y', 'n')), -- 메일회신 필요여부
a_complete varchar(30) default '신규' -- 문의 처리상태
);
create sequence accuse_seq; --신고 등록번호
create table accuse( --신고기록
ac_seq_number number(5) default accuse_seq.nextVal primary key, --등록번호
ac_date date default sysdate not null, --신고날짜
ac_id varchar2(20) not null, -- 신고자 아이디
ac_target varchar2(1000) not null, -- 신고 대상
ac_category varchar2(100) not null, -- 신고 유형
ac_content varchar2(4000) not null, -- 신고 내용
ac_filename varchar(300) null, -- 첨부파일명
ac_complete varchar(30) default '신규' -- 신고 처리상태
);
create table admin( --관리자 계정
admin_id varchar(20) primary key, --관리자 아이디
admin_password varchar(4000) not null, --관리자 비밀번호(암호화)
admin_number varchar2(10) not null UNIQUE, -- 관리자 사원번호
admin_name varchar2(20) not null, -- 관리자 이름
admin_role number(1) default 4 not null -- 권한 (4 승인대기, 3 직원, 2 임원, 1 최고권한)
);

-------------insert sample-----------------------------------
--[book_report] --너의생각 게시판
insert into book_report values(book_report_seq.nextval,'열공중','안상용',sysdate,sysdate,'default2.png',0,0,0,'포폴 빨리 끝내고싶다..');
insert into book_report values(book_report_seq.nextval,'망포역 하얀풍차 빵 사러 간다','장은미',sysdate,sysdate,'default1.png',0,0,0,'가위바위보 하자고 하는 사람이 걸리는 거 국룰..멀리 안나간다');
insert into book_report values(book_report_seq.nextval,'열공중','안상용',sysdate,sysdate,'default3.png',0,0,0,'포폴 빨리 끝내고싶다..');
insert into book_report values(book_report_seq.nextval,'망포역 하얀풍차 빵 사러 간다','장은미',sysdate,sysdate,'default1.png',0,0,0,'가위바위보 하자고 하는 사람이 걸리는 거 국룰..멀리 안나간다');
insert into book_report values(book_report_seq.nextval,'열공중','안상용',sysdate,sysdate,'default4.png',0,0,0,'포폴 빨리 끝내고싶다..');
insert into book_report values(book_report_seq.nextval,'망포역 하얀풍차 빵 사러 간다','장은미',sysdate,sysdate,'default1.png',0,0,0,'가위바위보 하자고 하는 사람이 걸리는 거 국룰..멀리 안나간다');

--[free_board]
  f_seq_number number(4) primary key, -- 게시물번호
    f_title varchar2(100) not null, -- 제목
    f_writer varchar2(100) not null, -- 작성자
    f_regist_day date default sysdate,-- 작성일자
    f_update_day date default sysdate, -- 수정일자
    f_recommend number default 0, -- 추천수
    f_delete number default 0 not null, -- 상태 (0정상,1삭제)
    f_view number default 0, -- 조회수
    f_content varchar2(4000) not null, --내용
    f_category varchar2(
    
    insert into free_board values(free_board_seq_number)


--[store]
insert into book_info values(b_seq_number.nextVal, 'ISBN0001', '사피엔스', '유발 하라리', '김영사', '2023.04.01', 'ISBN0001.jpeg', '인문학', 20000, 500, '인류에 대해 분석하다', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0002', '종의 기원', '정유정', '은행나무', '2016.05.16', 'ISBN0002.jpeg', '소설', 20000, 500, '사이코패스의 살인 이야기', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0003', '백엔드', '남궁', '가나다', '2020.05.16', 'ISBN0003.jpeg', '프로그래밍', 15000, 500, '백엔드 개발자를 위한 기초 서적', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0004', '사피엔스', '유발 하라리', '김영사', '2023.04.01', 'ISBN0004.jpeg', '인문학', 20000, 500, '인류에 대해 분석하다', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0005', '종의 기원', '정유정', '은행나무', '2016.05.16', 'ISBN0005.jpeg', '소설', 20000, 500, '사이코패스의 살인 이야기', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0006', '백엔드', '남궁', '가나다', '2020.05.16', 'ISBN0006.jpeg', '프로그래밍', 15000, 500, '백엔드 개발자를 위한 기초 서적', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0007', '사피엔스', '유발 하라리', '김영사', '2023.04.01', 'ISBN0007.jpeg', '인문학', 20000, 500, '인류에 대해 분석하다', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0008', '종의 기원', '정유정', '은행나무', '2016.05.16', 'ISBN0008.jpeg', '소설', 20000, 500, '사이코패스의 살인 이야기', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0009', '백엔드', '남궁', '가나다', '2020.05.16', 'ISBN0009.jpeg', '프로그래밍', 15000, 500, '백엔드 개발자를 위한 기초 서적', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0010', '사피엔스', '유발 하라리', '김영사', '2023.04.01', 'ISBN0010.jpeg', '인문학', 20000, 500, '인류에 대해 분석하다', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0011', '종의 기원', '정유정', '은행나무', '2016.05.16', 'ISBN0011.jpeg', '소설', 20000, 500, '사이코패스의 살인 이야기', 0, 0);
insert into book_info values(b_seq_number.nextVal, 'ISBN0012', '백엔드', '남궁', '가나다', '2020.05.16', 'ISBN0012.jpeg', '프로그래밍', 15000, 500, '백엔드 개발자를 위한 기초 서적', 0, 0);

-- [member]
insert into member_function values('qwer','1234','박승준','010-2181-1726','seungjun@naver.com','경기도 수원시 팔달구','0');
insert into member_function values('docho2','ehch1234','박승준','010-2181-1726','seungjun2181@naver.com','경기도 수원시 팔달구',0);

-- [admin]
BEGIN
  FOR i IN 1..168 LOOP
insert into ask(a_id,a_category,a_content,a_filename,a_email,a_reception)

values('테스트유저32547','서비스 이용문의',
'한글로렘입숨 국회의원은 국회에서 직무상 행한 발언과 표결에 관하여 . 국가의 세입·세출의 결산, 국가 및 법률이 정한 단체의  대통령 소속하에 감사원을 둔다.',
'test.png','nomail@nomail.com','y');

-- values('테스트유저4656','건의사항',
-- '한글로렘입숨 국회의원은 국회에서 직무상 행한 발언과 표결에 관하여 . 국가의 세입·세출의 결산, 국가 및 법률이 정한 단체의  대통령 소속하에 감사원을 둔다.',
-- 'test.png','nomail@nomail.com','n');

insert into accuse(ac_id,ac_target,ac_category,ac_content,ac_filename)
values('테스트유저1','http://gamtodomain/','불쾌한 표현','글을 너무 잘씀','가짜파일.pdf');
insert into accuse(ac_id,ac_target,ac_category,ac_content,ac_filename)
values('테스트유저2','궴토님을 신고합니다','불쾌한 표현','글을 너무 잘씀 이말하려고 어그로 끌었다.','가짜파일.pdf');

  END LOOP;
  COMMIT;
END;
--비번1234
insert into admin values('admin1','hUb8cPJeO4T14l49T4C8htroGv9M6Wd+Yp4cOaz32Xs=','a1','관리자1',1);
insert into admin values('admin2','hUb8cPJeO4T14l49T4C8htroGv9M6Wd+Yp4cOaz32Xs=','a2','관리자2',2);
insert into admin values('admin3','hUb8cPJeO4T14l49T4C8htroGv9M6Wd+Yp4cOaz32Xs=','a3','관리자3',3);
insert into admin values('admin4','hUb8cPJeO4T14l49T4C8htroGv9M6Wd+Yp4cOaz32Xs=','a4','관리자4',4);

------------------------------

commit;

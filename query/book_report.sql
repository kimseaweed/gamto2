----------------------[book_report table]-------------------------
create table book_report(
    r_seq_number number(4) primary key, --report sequence number
    r_title varchar2(100) not null, --report title
    r_writer varchar2(100) not null, --report writer
    r_regist_day date default sysdate,--report regist_day
    r_update_day date default sysdate, --report update_day
    r_filename varchar2(300), --report filename
    r_recommend number default 0, --report recommand count
    r_delete number default 0 not null, --report delete check
    r_view number default 0, --report hits count
    r_content varchar2(4000) not null --report content
);
--데이터 크기 변경
alter table book_report modify r_content varchar2(4000);
alter table book_report modify r_filename varchar2(300);

create sequence book_report_seq; --시퀀스 생성
drop sequence book_report_seq; --시퀀스 삭제

--데이터 저장
insert into book_report values(book_report_seq.nextval,'열공중','안상용',sysdate,sysdate,'img.png',0,0,0,'포폴 빨리 끝내고싶다..');
insert into book_report values(book_report_seq.nextval,'망포역 하얀풍차 빵 사러 간다','장은미',sysdate,sysdate,'ISBN0014.jpeg',0,0,0,'가위바위보 하자고 하는 사람이 걸리는 거 국룰..멀리 안나간다');

--데이터 확인
select * from book_report;
select * from book_report order by r_seq_number desc; --내림차순

--데이터 수정
update book_report set r_writer='열정맨', r_title='제목변경', r_content='컨텐츠변경' where r_seq_number=1;

--데이터 검색
select * from book_report where r_title like '%변경%';
select * from book_report where r_writer like '%작성%';

--테이블 삭제
drop table book_report;

rollback;
commit;
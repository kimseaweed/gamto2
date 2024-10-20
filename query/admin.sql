commit;

drop SEQUENCE ask_seq;
drop SEQUENCE accuse_seq;

drop table ask;
drop table accuse;
drop table admin;

select * from ask order by a_seq_number desc;
select * from accuse order by ac_seq_number desc;
select * from admin;


create sequence ask_seq;
create table ask(
a_seq_number number(5) default ask_seq.nextVal primary key,
a_date date default sysdate not null,
a_id varchar2(20) null,
a_category varchar2(30) not null,
a_content varchar2(4000) not null,
a_filename varchar(300) null,
a_email varchar2(40) not null,
a_reception varchar(2) not null  CHECK (a_reception  IN ('y', 'n')),
a_complete varchar(30) default '신규'
);
create sequence accuse_seq;
create table accuse(
ac_seq_number number(5) default accuse_seq.nextVal primary key,
ac_date date default sysdate not null,
ac_id varchar2(20) not null,
ac_target varchar2(1000) not null,
ac_category varchar2(100) not null,
ac_content varchar2(4000) not null,
ac_filename varchar(300) null,
ac_complete varchar(30) default '신규'
);
create table admin(
admin_id varchar(20) primary key,
admin_password varchar(4000) not null,
admin_number varchar2(10) not null UNIQUE, --사번
admin_name varchar2(20) not null, --이름
admin_role number(1) not null --권한
);


--- 샘플데이터 168개 삽입
BEGIN
  FOR i IN 1..168 LOOP

insert into ask(a_id,a_category,a_content,a_filename,a_email,a_reception)
values('테스트유저','테스트문의',
'한글로렘입숨 국회의원은 국회에서 직무상 행한 발언과 표결에 관하여 . 국가의 세입·세출의 결산, 국가 및 법률이 정한 단체의  대통령 소속하에 감사원을 둔다.',
'test.png','nomail@nomail.com','y');
insert into accuse(ac_id,ac_target,ac_category,ac_content,ac_filename)
values('테스트유저','ㅇㅇ님을 신고합니다','불쾌한 표현','글을 너무 잘씀','가짜파일.pdf');

  END LOOP;
  COMMIT;
END;
--- 샘플데이터삽입 end ---
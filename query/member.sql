----------------------member_function------------------------
create table member_function(
    u_id varchar(20) PRIMARY KEY, --회원아이디
    u_pw varchar2(20) not null, --회원비밀번호
    u_name varchar2(20) not null, --회원이름
    u_phone varchar2(20) not null, --회원전화번호
    u_email varchar2(50) not null unique, --회원메일
    u_address varchar2(70) not null, --회원주소
    u_delete varchar2(2) not null
);
insert into member_function values('qwer','1234','박승준','010-2181-1726','seungjun@naver.com','경기도 수원시 팔달구','0');
insert into member_function values('docho2','ehch1234','박승준','010-2181-1726','seungjun2181@naver.com','경기도 수원시 팔달구',0);
update member_function set u_pw='123152165651', u_name='박승준', u_phone='010-2181-1726', u_email='seungjun2181@naver.com' , u_address='경기도 수원시 팔달구' , u_delete='0' where u_id='qwe';
update member_function set u_pw='a', u_name='s', u_phone='d' , u_email='f' , u_address='g' where u_id='qwer';
update member_function set u_delete=1 where u_id='qwe';
drop table member_function;
select*from member_function;
update member_function set u_delete='0' where u_id='qwer';
select * from member_function where u_id = 'qwe' and u_pw='1234';
select * from member_function where u_id = 'qwer' and u_pw='1234';
select * from member_function where u_id='qwer';
update member_function set u_email='seungjun2181@daum.com' where u_id='qwer';
select u_id from member_function where u_email='seungjun2181@naver.com';
select u_id from member_function where u_id='qwe' and u_email='seungjun2181@naver.com';
commit;
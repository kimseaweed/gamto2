---------free_board------
create table free_board(
    f_seq_number number(4) primary key, --freeboard sequence number
    f_title varchar2(100) not null, --freeboard title
    f_writer varchar2(100) not null, --freeboard writer
    f_regist_day date default sysdate,--freeboard regist_day
    f_update_day date default sysdate, --freeboard update_day
    f_recommend number default 0, --freeboard recommand count
    f_delete number default 0 not null, --freeboard delete check
    f_view number default 0, --freeboard hits count
    f_content varchar2(500) not null, --freeboard content
    f_category varchar2(50) not null --freeboard category
);

create table comment_board(
    c_seq_number number(4) primary key, --comment_board sequence number
    f_seq_number number(4),
    c_writer varchar2(100) not null, --comment_board writer
    c_regist_day date default sysdate, --comment_board regist_day
    c_update_day date default sysdate, --comment_board update_day
    c_recommend number default 0, --comment_board recommand count
    c_derecommend number default 0, --comment_board derecommand count
    c_delete number default 0 not null, --comments_board delete check
    c_content varchar2(500) not null, --comments_board content
    c_total_count number(20) default 0
);

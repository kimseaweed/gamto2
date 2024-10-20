package com.mrmr.gamto.help.dto;

import lombok.Data;

@Data
public class AccuseDTO {
	/*
	ac_seq_number number(5) default accuse_seq.nextVal  primary key,
	ac_seq_date date default sysdate not null,
	ac_id varchar2(20) not null,
	ac_title varchar2(1000) not null,
	ac_category varchar2(100) not null,
	ac_content varchar2(4000) not null,
	ac_filename varchar(300) null,
	ac_complete number(2) default 1
	 */
	private int ac_total; //총 레코드 수
	private int ac_seq_number; //시퀀스 넘버
	private String ac_date; //날짜
	private String ac_id; //신고자 아이디
	private String ac_target; //신고대상
	private String ac_category; //유형
	private String ac_content; //내용
	private String ac_filename; //첨부파일
	private String ac_complete; //완료처리
}

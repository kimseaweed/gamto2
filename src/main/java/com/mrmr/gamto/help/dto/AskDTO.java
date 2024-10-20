package com.mrmr.gamto.help.dto;

import lombok.Data;

@Data
public class AskDTO {
	/*
	a_seq_number number(5) default ask_seq.nextVal primary key,
	a_seq_date date default sysdate not null,
	a_id varchar2(20) not null,
	a_category varchar2(30) not null,
	a_content varchar2(4000) not null,
	a_filename varchar(300) null,
	a_email varchar2(40) not null,
	a_reception varchar(2) not null  CHECK (a_reception  IN ('y', 'n')),
	a_complete number(2) default 1
	*/	
	private int a_total; //총 레코드 수
	private int a_seq_number; //문의번호
	private String a_date; //문의날짜
	private String a_id; //문의자아이디
	private String a_category; //문의분류
	private String a_content; //문의내용
	private String a_filename; //문의파일첨부
	private String a_email; //문의회신 이메일
	private String a_reception; //문의 여부
	private String a_complete; //문의 진행여부
}

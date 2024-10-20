package com.mrmr.gamto.report.dto;

import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class BookReportDTO {
	private int r_seq_number; //독후감 번호
	private String r_filename; //책 이미지
	private String r_title; //책 제목
	private String r_writer; //작성자
	private String r_content; //독후감 내용
	private String r_regist_day; //작성일
	private String r_update_day; //수정일
	private int r_view; //조회수
	private int r_recommend; //추천수
	private int r_delete; //삭제
	
	public void setR_regist_day(java.sql.Timestamp r_regist_day) {
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
		this.r_regist_day = format.format(r_regist_day);
	}
	public void setR_update_day(java.sql.Timestamp r_update_day) {
		SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
		this.r_update_day = format.format(r_update_day);
	}
	
}

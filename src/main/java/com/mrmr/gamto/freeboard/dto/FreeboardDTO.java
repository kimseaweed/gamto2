package com.mrmr.gamto.freeboard.dto;

import lombok.Data;

@Data
public class FreeboardDTO {
	private String f_title; //게시판 제목
	private String f_writer; //게시판 작성자
	private String f_regist_day; //등록 날짜
	private String f_update_day; //수정 날짜
	private String f_filename; //파일명
	private String f_content; //게시판 내용
	private int f_recommend; //추천수
	private int f_delete; //삭제여부
	private int f_view; //조회수
	private int f_seq_number; //게시판 코드
	private String f_category; //게시판 카테고리
}

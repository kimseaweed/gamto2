package com.mrmr.gamto.freeboard.dto;

import lombok.Data;

@Data
public class CommentDTO {
	private int c_seq_number; //댓글 코드
	private String c_writer; //댓글 작성자
	private String c_regist_day; //댓글 등록 날짜
	private String c_update_day; //댓글 수정 날짜
	private String c_content; //댓글 내용
	private int c_recommend; //댓글 추천
	private int c_derecommend; //댓글 비추천
	private int c_delete; //댓글 삭제 여부
	private int c_total_count; //총 댓글 개수
	private int c_freeboard; //게시물번호
}

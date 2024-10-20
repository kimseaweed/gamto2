package com.mrmr.gamto.freeboard.dto;

import lombok.Data;

@Data
public class FeelingDTO {
	private int l_seq_number; //좋아요 시퀀스 넘
	private int l_board; //게시판 종류
	private int l_number; //게시물 번호
	private String l_id; //로그인한 아이디
	private long l_checkL; //좋아요 활성화 상태
}

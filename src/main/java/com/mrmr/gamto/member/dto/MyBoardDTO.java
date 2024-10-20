package com.mrmr.gamto.member.dto;

import lombok.Data;

@Data
public class MyBoardDTO {
	private String seq_number;
	private String tablename;
	private String title;
	private String regist_day;
	private int deleted;
	private int total;
}

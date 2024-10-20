package com.mrmr.gamto.store.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class StoreDTO {
	
	private String b_seq_number; //책 코드 
	private String b_code; //책 코드 
	private String b_name; //책 제목 
	private String b_author; //저자 
	private String b_publisher; //출판사 
	private String b_release; //출판일 
	private String b_filename; //이미지 파일 이름 
	private String b_genre; //장르 
	private int b_price; //책 가격 
	private int b_stock; // 책 재고 
	private String b_description; //책 설명 
	private int b_quantity; // 책 수량 
	private int total; //수량 * 가격 
	private int sum; // 소계  
}

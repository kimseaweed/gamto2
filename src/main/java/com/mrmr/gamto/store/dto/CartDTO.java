package com.mrmr.gamto.store.dto;

import lombok.Data;

@Data
public class CartDTO {
    private String cart_seq_number;// 주문번호 
	private String cart_id; //주문한 사용자 아이디
	private String cart_code; //주문된 책 코드  
	private String cart_name; //상품 이름 
	private String cart_author; //상품 저자   
	private String cart_filename; //상품 사진 
	private String cart_price; //상품 가격 
	private int cart_quantity; //장바구니 수량 
}

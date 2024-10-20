package com.mrmr.gamto.store.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.store.dto.CartDTO;
import com.mrmr.gamto.store.dto.StoreDTO;
import com.mrmr.gamto.store.dto.OrderTableDTO;

@Mapper
public interface StoreDAO {
	public List<StoreDTO> BookList(); //상품을 보기 위한 select 메서드 정의
	public StoreDTO viewDao(String b_code); //상세 뷰 페이지를 보기 위한 select메서드 정의
	public int insertDao(String b_code); //제품 등록 메소드
	public int deleteDao(String b_code); // 제품 삭제 메소드 
	public List<CartDTO> cartDao(String u_id); // 장바구니 리스트 보여주기 메서드 정의 
	public int addCartDao(String u_id, String b_code, String b_quantity); //장바구니 담기 메서드
	public int updateQuantity(String u_id, String cart_code, String cart_quantity); //장바구니에서 수량 변경 
	public int removeCartDao(String u_id, String b_code); //장바구니 삭제 메소드 
	public int removeAllCartDao(String u_id); //장바구니 목록 전체 삭제 메소드
	public int listNumDao(String u_id); //장바구니 갯수.
	//주문내역 
	public MemberDTO orderDetail(String u_id);
	//구매 내역
	public OrderTableDTO orderList(String o_order_number);//구매내역
	public void insertKakaoPayInfo(OrderTableDTO orderTable); // 구매정보 받는 메서드
	public List<OrderTableDTO> purchaseList(String u_id);
	
	/* 페이징하는 부분 */
	public int countBookList();
	public List<StoreDTO> getPageList(Map<String, Integer> map);
		
	//검색하는 부분
	public List<StoreDTO> SearchTotal(Map<String, String> map);
}

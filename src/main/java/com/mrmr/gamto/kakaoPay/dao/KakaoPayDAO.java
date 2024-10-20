package com.mrmr.gamto.kakaoPay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mrmr.gamto.store.dto.CartDTO;

@Mapper
public interface KakaoPayDAO {
   public List<CartDTO> setKakaoPay(); //장바구니에 담긴 데이터 담아오는 메소드
}

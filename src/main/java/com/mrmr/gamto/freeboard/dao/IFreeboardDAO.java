package com.mrmr.gamto.freeboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mrmr.gamto.freeboard.dto.CommentDTO;
import com.mrmr.gamto.freeboard.dto.FeelingDTO;
import com.mrmr.gamto.freeboard.dto.FreeboardDTO;

@Mapper
public interface IFreeboardDAO {
	/* 페이징하는 부분 */
	public int countBoard();
	public List<FreeboardDTO> getPageList(Map<String, Integer> map);
	public FreeboardDTO viewDao(String f_seq_number);
	public int writeDao(Map<String, String> map);
	public int deleteDao(String f_seq_number);
	public int updateDao(Map<String, String> map);
	public int updateCnt(String f_seq_number);
	public int goodCnt(String f_seq_number);
	public int badCnt(String f_seq_number);
	
	public List<CommentDTO> cListDao(String f_seq_number);
	public CommentDTO cViewDao(String f_seq_number);
	public int cWriteDao(String f_seq_number, String c_writer, String c_content);
	public int cDeleteDao(String c_seq_number);
	public int cUpdateDao(Map<String, String> map);
	public int cGoodCnt(String c_seq_number);
	public int cGoodCancel(String c_seq_number);
	public int cBadCnt(String c_seq_number);
	public int cBadCancel(String c_seq_number);
	public int commentTotal(String f_seq_number); //게시글마다 댓글수 카운트
	
	
	//검색하는 부분
	public List<FreeboardDTO> SearchCategory(Map<String, String> map);
	public List<FreeboardDTO> SearchTotal(Map<String, String> map);
	
	
	//좋아요 버튼
	public int insertLike(int l_board,  int l_number, String l_id);
	public int deleteLike(int l_board, int l_number, String l_id);
	public int likeCheck(int l_board, int l_number, String l_id);
	
}

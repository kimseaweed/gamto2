package com.mrmr.gamto.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.member.dto.MyBoardDTO;


@Mapper
public interface MemberDAO {
	public List<MemberDTO> listDao();
	public MemberDTO loginDao(String u_id, String u_pw);
	public int addMemberDao(@Param("dto") MemberDTO dto);
	public int deleteMemberDao(String u_id);
	public MemberDTO readMemberDao(String u_id);
	public int updateMemberDao(@Param("dto") MemberDTO dto);
	public MemberDTO overlapIdDao(String u_id);
	public MemberDTO overlapMailDao(String u_id);
	public MemberDTO findIdDao(String u_email);
	public String ResetPwCheck(String u_id);
	public int ResetPwDo(@Param("u_id") String u_id,@Param("u_pw")String u_pw);
	public int countBoard(String u_id, String u_id2);
	public List<MyBoardDTO> getPageList(String u_id, int startNo, int endNo);
	
}

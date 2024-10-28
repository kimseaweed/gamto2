package com.mrmr.gamto.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mrmr.gamto.member.dto.MemberDTO;
import com.mrmr.gamto.member.dto.MyBoardDTO;


@Mapper
public interface MemberDAO {
	List<MemberDTO> listDao();
	MemberDTO loginDao(String u_id, String u_pw);
	int addMemberDao(@Param("dto") MemberDTO dto);
	int deleteMemberDao(String u_id);
	MemberDTO readMemberDao(String u_id);
	int updateMemberDao(@Param("dto") MemberDTO dto);
	boolean u_idExists(String u_id);
	boolean u_emailExists(String u_email);
	MemberDTO findIdDao(String u_email);
	String ResetPwCheck(String u_id);
	int ResetPwDo(@Param("u_id") String u_id,@Param("u_pw")String u_pw);
	int countBoard(String u_id, String u_id2);
	List<MyBoardDTO> getPageList(String u_id, int startNo, int endNo);

}

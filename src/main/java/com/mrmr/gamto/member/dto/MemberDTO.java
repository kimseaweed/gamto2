package com.mrmr.gamto.member.dto;

import java.io.Serializable;

import lombok.Data;

@Data
public class MemberDTO implements Serializable{
	private String u_id; //회원아이디
	private String u_pw; //회원비밀번호
	private String u_name; //회원이름
	private String u_phone; //회원번호
	private String u_email; //회원메일
	private String u_address; //회원주소
	private String u_delete; //회원탈퇴 u_delete가 0이면 회원이고 1이면 탈퇴 
	private int u_total;
}

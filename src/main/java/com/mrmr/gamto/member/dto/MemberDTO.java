package com.mrmr.gamto.member.dto;

import java.io.Serializable;

import lombok.Data;

//@Data
public class MemberDTO implements Serializable{
	private String u_id; //회원아이디
	private String u_pw; //회원비밀번호
	private String u_name; //회원이름
	private String u_phone; //회원번호
	private String u_email; //회원메일
	private String u_address; //회원주소
	private String u_delete; //회원탈퇴 u_delete가 0이면 회원이고 1이면 탈퇴 
	private int u_total;


	public int getU_total() {
		return u_total;
	}
	public void setU_total(int u_total) {
		this.u_total = u_total;
	}
	private static final long serialVersionUID = 1L;
	
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pw() {
		return u_pw;
	}
	public void setU_pw(String u_pw) {
		this.u_pw = u_pw;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_phone() {
		return u_phone;
	}
	public void setU_phone(String u_phone) {
		this.u_phone = u_phone;
	}
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}
	public String getU_address() {
		return u_address;
	}
	public void setU_address(String u_address) {
		this.u_address = u_address;
	}
	public String getU_delete() {
		return u_delete;
	}
	public void setU_delete(String u_delete) {
		this.u_delete = u_delete;
	}


	@Override
	public String toString() {
		return "MemberDTO [u_id=" + u_id + ", u_pw=" + u_pw + ", u_name=" + u_name + ", u_phone=" + u_phone
				+ ", u_email=" + u_email + ", u_address=" + u_address + ", u_delete=" + u_delete + "]";
	}
}

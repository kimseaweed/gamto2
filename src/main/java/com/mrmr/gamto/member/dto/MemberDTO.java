package com.mrmr.gamto.member.dto;

import java.io.Serializable;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class MemberDTO implements Serializable{
	@Pattern(regexp = "^[a-z0-9]{4,20}$", message="아이디가 유효하지 않습니다. (영소문자, 숫자 4~20자)")
	private String u_id; //회원아이디

	@Pattern(regexp = "^[a-zA-Z0-9]{4,20}$", message = "비밀번호가 유효하지 않습니다. (영문 소문자, 대문자, 숫자 4~20자)")
	private String u_pw; //회원비밀번호

	@Pattern(regexp = "^[\\w가-힣]{2,6}$", message = "이름(닉네임)이 유효하지 않습니다. (영문, 한글, 숫자 2~6자)")
	private String u_name; //회원이름

	@Pattern(regexp = "^\\w+@\\w+.\\w+$", message = "이메일이 유효하지 않습니다.")
	private String u_email; //회원메일

	@Pattern(regexp = "^[\\d]{10,11}$", message = "연락처가 유효하지 않습니다. (-를 제외하고 숫자만 입력해주세요)")
	private String u_phone; //회원번호

	@Size(min = 5, max= 300)
	private String u_address; //회원주소

	@PositiveOrZero
	private String u_delete; //회원탈퇴 u_delete가 0이면 회원이고 1이면 탈퇴 

	private int u_total;
}

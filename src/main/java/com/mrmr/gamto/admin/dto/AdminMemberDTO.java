package com.mrmr.gamto.admin.dto;

import lombok.Data;

@Data
public class AdminMemberDTO {
	private String admin_id;
	private String admin_password;
	private String admin_number;
	private String admin_name;
	private int admin_role;
	private int admin_total;
	
}

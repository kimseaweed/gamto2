package com.mrmr.gamto.kakaoPay.dto;

import lombok.Data;

@Data
public class CardVO {
	public CardVO(){}
	
    private String purchase_corp, purchase_corp_code;
    private String issuer_corp, issuer_corp_code;
    private String bin, card_type, install_month, approved_id, card_mid;
    private String interest_free_install, card_item_code;
    
	public CardVO(String purchase_corp, String purchase_corp_code, String issuer_corp, String issuer_corp_code,
			String bin, String card_type, String install_month, String approved_id, String card_mid,
			String interest_free_install, String card_item_code) {
		super();
		this.purchase_corp = purchase_corp;
		this.purchase_corp_code = purchase_corp_code;
		this.issuer_corp = issuer_corp;
		this.issuer_corp_code = issuer_corp_code;
		this.bin = bin;
		this.card_type = card_type;
		this.install_month = install_month;
		this.approved_id = approved_id;
		this.card_mid = card_mid;
		this.interest_free_install = interest_free_install;
		this.card_item_code = card_item_code;
	}
    
}
 
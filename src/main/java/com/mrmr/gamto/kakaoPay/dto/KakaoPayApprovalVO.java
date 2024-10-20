package com.mrmr.gamto.kakaoPay.dto;

import java.util.Date;

import lombok.Data;

@Data
public class KakaoPayApprovalVO {
	public KakaoPayApprovalVO(){};
    //response
    private String aid, tid, cid, sid;
    private String partner_order_id, partner_user_id, payment_method_type;
    private AmountVO amount;
    private CardVO card_info;
    private String item_name, item_code, payload;
    private Integer quantity, tax_free_amount, vat_amount;
    private Date created_at, approved_at;
    
	public KakaoPayApprovalVO(String aid, String tid, String cid, String sid, String partner_order_id,
			String partner_user_id, String payment_method_type, AmountVO amount, CardVO card_info, String item_name,
			String item_code, String payload, Integer quantity, Integer tax_free_amount, Integer vat_amount,
			Date created_at, Date approved_at) {
		super();
		this.aid = aid;
		this.tid = tid;
		this.cid = cid;
		this.sid = sid;
		this.partner_order_id = partner_order_id;
		this.partner_user_id = partner_user_id;
		this.payment_method_type = payment_method_type;
		this.amount = amount;
		this.card_info = card_info;
		this.item_name = item_name;
		this.item_code = item_code;
		this.payload = payload;
		this.quantity = quantity;
		this.tax_free_amount = tax_free_amount;
		this.vat_amount = vat_amount;
		this.created_at = created_at;
		this.approved_at = approved_at;
	}
    
    
    
}

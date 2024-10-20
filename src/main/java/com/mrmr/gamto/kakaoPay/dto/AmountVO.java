package com.mrmr.gamto.kakaoPay.dto;

import lombok.Data;

@Data
public class AmountVO {
	public AmountVO(){};
	
    private Integer total, tax_free, vat, point, discount;

	public AmountVO(Integer total, Integer tax_free, Integer vat, Integer point, Integer discount) {
		super();
		this.total = total;
		this.tax_free = tax_free;
		this.vat = vat;
		this.point = point;
		this.discount = discount;
	}
}
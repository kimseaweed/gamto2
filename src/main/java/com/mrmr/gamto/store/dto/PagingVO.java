package com.mrmr.gamto.store.dto;

import lombok.Data;

@Data
public class PagingVO {
    private int pageNo, pageSize, totalCount, startNo, endNo, startPage, endPage, totalPage;
	
	public PagingVO(int pageNo, int pageSize, int totalCount) {
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		
		/* 계산 시작 : 페이지 개수 */
		totalPage = (totalCount -1)/pageSize +1;
		
		this.pageNo = (pageNo<1)? 1:pageNo;
		this.pageNo = (pageNo>totalPage)? totalPage:pageNo;
	
		startNo = (this.pageNo-1)*pageSize+1;
		endNo = startNo + (pageSize -1);
	
		this.endNo = this.endNo>totalCount? totalCount:this.endNo;
	
		startPage = (this.pageNo-1)/10*10 +1;
		endPage = startPage+9;
	
		this.endPage = this.endPage>totalPage? totalPage:this.endPage;
	}
}

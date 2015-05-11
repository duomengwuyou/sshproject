package com.neusoft.logistics.service.inter.submanage;

import com.neusoft.logistics.bean.Substation;

public interface ISubPaymentSearchService {
	
	public String getAllSubProductsStatistics(Substation substation,String start, String end, String productid);

}

package com.neusoft.logistics.service.inter.dispatchCenterManage;
/**
 * 客服满意度Service
 *
 */
public interface ICustomerSatisfactionService {

	public String getAllCustomerSatisfaction();
	
	public 	String getCustomerSatisfaction(String beginTime, String endTime);
}

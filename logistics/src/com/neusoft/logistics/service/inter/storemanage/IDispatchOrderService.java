package com.neusoft.logistics.service.inter.storemanage;

import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;

public interface IDispatchOrderService {
	public String searchDispatchOrder(int dispatchOrderId,User user) throws Exception;
	public boolean saveRealIntoQuantity ( int dispatchOrderId , int realIntoQuantity);
	public boolean updateTaskOrderState(Substation substation);
	public boolean saveSubstationProduct(User userTemp,int dispatchOrderItemId , int realIntoQuantity);
}

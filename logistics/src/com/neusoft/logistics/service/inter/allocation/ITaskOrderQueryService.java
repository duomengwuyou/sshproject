package com.neusoft.logistics.service.inter.allocation;

import java.util.List;
import com.neusoft.logistics.bean.TaskOrder;

public interface ITaskOrderQueryService {
	public String taskOrderToJSON(List<TaskOrder> taskOrderList);
	public String findAllOrderId();
	public String findTaskOrder(String requiredDate,String taskOrderId,String taskOrderType,String taskOrderState,String deliverSubstation,String custormerName,String receivePersonTel);
}

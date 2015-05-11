package com.neusoft.logistics.service.inter.customermanage;

import java.util.List;

import com.neusoft.logistics.action.customerservice.LOrder;
import com.neusoft.logistics.bean.Order;

/**
 * 查询订单信息服务
 * @author 罗荣博
 *
 */
public interface IOrderInfoService {
	/**
	 * 查询订单信息
	 */
	public String findOrderInfo(Order order,String startTime,String endTime);
	
	/**
	 * 得到所有的订单
	 */
	public String findAllOrders();
}

package com.neusoft.logistics.service.inter.customermanage;

import java.util.List;

import com.neusoft.logistics.action.customerservice.LOrder;
import com.neusoft.logistics.bean.Order;

/**
 * 查询订单信息服务
 * @author 罗荣博
 *
 */
public interface IOrderDetailService {
	/**
	 * 显示订单详细信息
	 */
	public String findOrderDetailInfo(int orderId);
}

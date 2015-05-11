/**
 * 
 */
package com.neusoft.logistics.dao.inter;

import java.util.List;


import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Substation;

import java.util.List;

import com.neusoft.logistics.action.customerservice.LOrder;

import com.neusoft.logistics.bean.Order;

public interface IOrderDAO extends IBaseDAO<Order> {
	/**
	 * 根据条件查询订单信息
	 * @param order
	 * @return List<Order>
	 * @author 罗荣博
	 */

	public List<Order> findOrderInfo(Order order,String startTime,String endTime);

	/**
	 * 从数据库中查询所有的订单
	 * @return List<Order>
	 * @author 罗荣博
	 */
	public List<Order> findAllOrders();
	
	/**
	 * 李莎 根据id修改订单状态为"已完成"
	 * @param orderid
	 */
	public void modifyTastState(int orderid);
	/**
	 * 李莎 根据id修改订单状态为"已分配"
	 * @param orderid
	 */
	public void modifyTastStatetoAllocated(int orderid);
	
	/**
	 * @author 宋延杰
	 * 根据完成日期和订单类型从数据库中查询“可分配”的订单
	 * @return
	 */	
	public List<Order> findByRequireddateAndOrdertype(String requireddate,String ordertype);
	/**
	 * @author 宋延杰
	 * 根据完成日期、订单类型和缺货单状态从数据库中查询订单
	 * @return
	 */
	public List<Order> findOrderByRequireddateAndOrdertypeAndShortageState(String requiredDate,String orderType,String shortageState);
	/**
	 * @author 周诗龙
	 * @param substation
	 * @return
	 */
	public List<Order> findBySubstation(Substation substation);

	/**张文华
	 * 根据客户Id查找订单
	 * @param customerId
	 * @return
	 */
	public List<Order> findOrderByCustomer(int customerId);
}

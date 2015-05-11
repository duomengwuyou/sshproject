package com.neusoft.logistics.service.inter.allocation;
import com.neusoft.logistics.bean.User;
/**
 * @author 宋延杰
 * findOrderByRequireddateAndOrdertype：通过完成日期和订单类型查找订单
 * findOrderByRequireddateAndOrdertypeAndShortageState：通过完成日期、订单类型、是否到货查找订单
 * modSubstationOrOrderstate：调度分站、修改订单状态
 * saveAllocationOrder：生成任务单、调拨单
 */
public interface IAllocationService {
	public String findOrderByRequireddateAndOrdertype(String requireddate,String ordertype);
	public String findOrderByRequireddateAndOrdertypeAndShortageState(String requiredDate,String orderType,String shortageState);
	public void modSubstationOrOrderstate(int orderId,String field,String value);
	public String saveAllocationOrder(String orderIds, User user);
}

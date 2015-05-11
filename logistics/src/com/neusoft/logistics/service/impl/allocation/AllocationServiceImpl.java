package com.neusoft.logistics.service.impl.allocation;

import java.util.List;

import com.neusoft.logistics.bean.AllocationOrder;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IAllocationOrderDAO;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.ISubstationDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.service.inter.allocation.IAllocationService;
import com.neusoft.logistics.utils.JSONHelper;
/**
 * 
 * @author 宋延杰
 *
 */
public class AllocationServiceImpl implements IAllocationService{
	private IOrderDAO orderDAO;
	private ISubstationDAO substationDAO;
	private ITaskOrderDAO taskOrderDAO;
	private IAllocationOrderDAO allocationDAO;

	public ISubstationDAO getSubstationDAO() {
		return substationDAO;
	}
	public void setSubstationDAO(ISubstationDAO substationDAO) {
		this.substationDAO = substationDAO;
	}
	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}
	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}
	public ITaskOrderDAO getTaskOrderDAO() {
		return taskOrderDAO;
	}
	public void setTaskOrderDAO(ITaskOrderDAO taskOrderDAO) {
		this.taskOrderDAO = taskOrderDAO;
	}
	public IAllocationOrderDAO getAllocationDAO() {
		return allocationDAO;
	}
	public void setAllocationDAO(IAllocationOrderDAO allocationDAO) {
		this.allocationDAO = allocationDAO;
	}
	/**
	 * 将order转化成json
	 * @param orderList
	 * @return
	 */
	public String orderToJSON(List<Order> orderList){
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		if(orderList.size()>0){
			for(Order o:orderList){
				json.AddItem("orderId", Integer.toString(o.getOrderid()));
				json.AddItem("orderType", o.getOrdertype());
				json.AddItem("orderState", o.getOrderstate());

				if(o.getReceiveadd()==null||o.getReceiveadd().equals("")){
					json.AddItem("receiveAdd", "无");
				}else{
					json.AddItem("receiveAdd", o.getReceiveadd());
				}
				if(o.getPayeradd()==null||o.getPayeradd().equals("")){
					json.AddItem("payerAdd", "无");
				}else{
					json.AddItem("payerAdd", o.getPayeradd());
				}
				if(o.getLSubstationByDeliversubstation()==null||o.getLSubstationByDeliversubstation().equals("")){
					json.AddItem("deliverSubstation", "手动调度");
				}else{
					json.AddItem("deliverSubstation", o.getLSubstationByDeliversubstation().getSubstationadd());
				}
				if(o.getLSubstationByCheckoutsubstation()==null||o.getLSubstationByCheckoutsubstation().equals("")){
					json.AddItem("checkoutSubstation", "异地收费调度");
				}else{
					json.AddItem("checkoutSubstation", o.getLSubstationByCheckoutsubstation().getSubstationadd());
				}
				json.ItemOK();
			}
		}
		json.setTotalCount(orderList.size());
		String jsons="";
		jsons = json.toString();
		return jsons;
	}
	/**
	 * 根据完成日期和订单类型从数据库中查询“可分配”的订单
	 */
	public String findOrderByRequireddateAndOrdertype(String requiredDate,String orderType){
		List<Order> orderList;
		orderList = orderDAO.findByRequireddateAndOrdertype(requiredDate,orderType);
		return this.orderToJSON(orderList);
	}
	/**
	 * 根据完成日期、订单类型、是否到货，查询订单
	 */
	public String findOrderByRequireddateAndOrdertypeAndShortageState(String requiredDate,String orderType,String shortageState){
		List<Order> orderList;
		orderList = orderDAO.findOrderByRequireddateAndOrdertypeAndShortageState(requiredDate,orderType,shortageState);
		return this.orderToJSON(orderList);
	}
	/**
	 * 修改分站 和 修改订单状态为“可分配”
	 */
	public void modSubstationOrOrderstate(int orderId,String field,String value){
		Order order;
		order = orderDAO.findById(orderId);	
		if(order.getOrderstate().equals("缺货")){
			if(field.equals("orderState")){
				order.setOrderstate(value);
			}
		}
		if((order.getLSubstationByDeliversubstation()==null||order.getLSubstationByDeliversubstation().equals(""))&&(order.getLSubstationByCheckoutsubstation()==null||order.getLSubstationByCheckoutsubstation().equals(""))){
			if(order.getOrdertype().equals("新订")){
				if(field.equals("deliverSubstation")){
					order.setLSubstationByDeliversubstation(substationDAO.findById(Integer.parseInt(value)));
				}
			}else{
				if(field.equals("deliverSubstation")){
					order.setLSubstationByDeliversubstation(substationDAO.findById(Integer.parseInt(value)));
				}else if(field.equals("checkoutSubstation")){
					order.setLSubstationByCheckoutsubstation(substationDAO.findById(Integer.parseInt(value)));
				}
			}
		}else if((order.getLSubstationByDeliversubstation()==null||order.getLSubstationByDeliversubstation().equals(""))&&(order.getLSubstationByCheckoutsubstation()!=null&&!(order.getLSubstationByCheckoutsubstation().equals("")))){			
			if(field.equals("deliverSubstation")){
				order.setLSubstationByDeliversubstation(substationDAO.findById(Integer.parseInt(value)));
			}
		}else if((order.getLSubstationByDeliversubstation()!=null&&!(order.getLSubstationByDeliversubstation().equals("")))&&(order.getLSubstationByCheckoutsubstation()==null||order.getLSubstationByCheckoutsubstation().equals(""))){
			if(order.getOrdertype().equals("异地收费")){
				if(field.equals("checkoutSubstation")){
					order.setLSubstationByCheckoutsubstation(substationDAO.findById(Integer.parseInt(value)));
				}
			}
		}
	}
	/**
	 * 调度订单
	 */
	public String saveAllocationOrder(String orderIds, User user) {
		String msg = "yes";

		//1获取orderIdArray
		String[] orderIdsArray=orderIds.split(",");
		Order order = null;
		//2添加到lists中去
		TaskOrder taskOrder = null;
		AllocationOrder aOrder = null;
		for(int i=0;i<orderIdsArray.length;i++){
			order = orderDAO.findById(Integer.parseInt(orderIdsArray[i]));
			if(order.getOrdertype().equals("新订")&&order.getLSubstationByDeliversubstation() == null){
				msg = "no";
			}else if(order.getOrdertype().equals("异地收费") && (order.getLSubstationByDeliversubstation() == null||order.getLSubstationByCheckoutsubstation() == null)){
				msg = "no";
			}else{}
		}
		if(msg!="no"){
			for(int i=0;i<orderIdsArray.length;i++){
				order = orderDAO.findById(Integer.parseInt(orderIdsArray[i]));
				taskOrder = new TaskOrder();
				taskOrder.setLOrder(order);
				taskOrder.setLUserByOperator(user);
				taskOrder.setOperatedate(substationDAO.currentDate());
				taskOrder.setTaskorderstate("已调度");
				taskOrder.setTaskordertype("送货收款");
				//还差设置配送员
				taskOrder.setLUserByDeliverman(
						taskOrderDAO.getLessBusyDeliverman(
								order.getLSubstationByDeliversubstation().getSubstationid()));
				aOrder = new AllocationOrder();
				aOrder.setLOrder(order);
				aOrder.setAllocationdate(substationDAO.currentDate());
				aOrder.setAllocationstate("未调拨");
				aOrder.setLUser(user);
				//保存到数据库
				allocationDAO.save(aOrder);
				taskOrderDAO.save(taskOrder);
				//修改订单状态为 已调度
				order.setOrderstate("已调度");
			}
		}
		return msg;
	}
}

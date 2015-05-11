package com.neusoft.logistics.service.impl.customermanage;

import java.util.List;

import com.neusoft.logistics.action.customerservice.LOrder;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.service.inter.customermanage.IOrderInfoService;
import com.neusoft.logistics.utils.JSONHelper;

/**
 * 实现订单查询信息
 * @author 罗荣博
 *
 */
public class OrderInfoServiceImpl implements IOrderInfoService {

	private IOrderDAO orderDAO;


	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	/**
	 * 根据条件查询订单信息
	 * @return 订单信息的Json串
	 */
	public String findOrderInfo(Order order, String startTime, String endTime) {
		JSONHelper json = new JSONHelper();
		List<Order> orderInfos = orderDAO.findOrderInfo(order,startTime,endTime);
		//System.out.println("orderInfos.size()=======lrb========"+orderInfos.size());
		json.setSuccess(true);
		if(orderInfos!=null&&orderInfos.size()>0){
			for(Order lorder:orderInfos){
				json.AddItem("orderId", Integer.toString(lorder.getOrderid()));
				json.AddItem("customerId", Integer.toString(lorder.getLCustomer().getCustomerid()));
				json.AddItem("customerName", lorder.getLCustomer().getCustomername());
				json.AddItem("mobile", lorder.getReceivepersontel());
				json.AddItem("orderType", lorder.getOrdertype());
				json.AddItem("orderState", lorder.getOrderstate());
				json.AddItem("orderDate", lorder.getOrderdate().toString());
				json.AddItem("requireddate", lorder.getRequireddate().toString());
				json.ItemOK();
			}
		}
		//json.setTotalCount(orderInfos.size());
		String jsonss = json.toString();
	//	System.out.println("+++++++++"+jsonss);
		return jsonss;
	}
	
	/**
	 * 得到所有的订单
	 * @return 所有订单的信息
	 */
	public String findAllOrders(){
		JSONHelper json = new JSONHelper();
		List<Order> orderInfos = orderDAO.findAll();//根据DAO层的方法查询所有订单
		json.setSuccess(true);
		for(Order lorder:orderInfos){
			json.AddItem("orderId", Integer.toString(lorder.getOrderid()));
			json.AddItem("customerId", Integer.toString(lorder.getLCustomer().getCustomerid()));
			json.AddItem("customerName", lorder.getLCustomer().getCustomername());
			json.AddItem("mobile", lorder.getReceivepersontel());
			json.AddItem("orderType", lorder.getOrdertype());
			json.AddItem("orderState", lorder.getOrderstate());
			json.AddItem("orderDate", lorder.getOrderdate().toString());
			json.AddItem("requireddate", lorder.getRequireddate().toString());
			json.ItemOK();
		}
		String jsonss = json.toString();
		//System.out.println("allorder的jsonss为："+jsonss);
		return jsonss;

	}
}

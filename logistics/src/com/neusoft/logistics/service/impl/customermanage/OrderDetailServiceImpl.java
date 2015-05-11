package com.neusoft.logistics.service.impl.customermanage;

import java.util.List;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.service.inter.customermanage.IOrderDetailService;
import com.neusoft.logistics.service.inter.customermanage.IOrderInfoService;
import com.neusoft.logistics.utils.JSONHelper;

/**
 * 实现订单详细信息查询Service
 * @author 罗荣博
 *
 */
public class OrderDetailServiceImpl implements IOrderDetailService {

	private IOrderDAO orderDetailDAO;

	public IOrderDAO getOrderDetailDAO() {
		return orderDetailDAO;
	}

	public void setOrderDetailDAO(IOrderDAO orderDetailDAO) {
		this.orderDetailDAO = orderDetailDAO;
	}

	/**
	 * 显示订单详细信息
	 */
	
	public String findOrderDetailInfo(int orderId) {
		JSONHelper json = new JSONHelper();
		
		Order order1 = orderDetailDAO.findById(orderId);
		//System.out.println("deliverSubstation为："+order1.getLSubstationByDeliversubstation());
		if(order1 == null){
			System.out.println("没查到Order");
			return null;
		}else{
				json.setSuccess(true);
				json.AddItem("orderId", Integer.toString(order1.getOrderid()));
				json.AddItem("customerId", Integer.toString(order1.getLCustomer().getCustomerid()));
				
				json.AddItem("customerName", order1.getLCustomer().getCustomername());
			
				json.AddItem("idCard", order1.getLCustomer().getIdcard());
				
				if(order1.getLSubstationByDeliversubstation() != null){
				//	System.out.println("deliverSubstation为：");
					json.AddItem("deliverSubstation", order1.getLSubstationByDeliversubstation().getSubstationadd());
				}else{
				//	System.out.println("deliverSubstation为：待分配");
					json.AddItem("deliverSubstation", "待分配");
				}
				json.AddItem("signedDate", order1.getRequireddate().toString());
				json.AddItem("orderDate", order1.getOrderdate().toString());
				json.AddItem("receiveAdd", order1.getReceiveadd());
				json.AddItem("reveivePerson", order1.getReceiveperson());
				json.AddItem("reveivePersonTel", order1.getReceivepersontel());
				if(order1.getReceivepersonzip() != null){
					
					json.AddItem("reveivePersonZip", order1.getReceivepersonzip());
				}else{
					json.AddItem("reveivePersonZip", "暂无数据");
				}
				json.AddItem("orderType", order1.getOrdertype());
				json.ItemOK();
			String jsonss = json.toString();
			//System.out.println("Jsons的结果为："+jsonss);
			return jsonss;
		}
		
	}
}

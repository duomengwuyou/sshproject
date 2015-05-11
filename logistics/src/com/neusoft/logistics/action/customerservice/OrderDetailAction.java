package com.neusoft.logistics.action.customerservice;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.service.inter.customermanage.IOrderDetailService;
/**
 * OrderDetailAction
 * @author 罗荣博
 *
 */
public class OrderDetailAction extends DispatchAction{
	
	private IOrderDetailService orderDetailService;
	
	public IOrderDetailService getOrderDetailService() {
		return orderDetailService;
	}

	public void setOrderDetailService(IOrderDetailService orderDetailService) {
		this.orderDetailService = orderDetailService;
	}

	/**
	 * 查询订单详细信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return null
	 * @throws Exception
	 */
	public ActionForward findOrderDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");

	   // Order order = new Order();
	    int orderId = Integer.parseInt(request.getParameter("orderId"));
	  //  System.out.println("在OrderDetailAction中，前台穿过来的orderId为："+orderId);
	    
	    String orderDetails = orderDetailService.findOrderDetailInfo(orderId);
	    response.getWriter().print(orderDetails);
		return null;
	}
}

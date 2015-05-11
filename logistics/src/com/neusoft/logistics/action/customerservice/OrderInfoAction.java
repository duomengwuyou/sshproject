package com.neusoft.logistics.action.customerservice;
import java.io.IOException;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.service.inter.customermanage.IOrderInfoService;

/**
 * OrderInfoAction
 * @author 罗荣博
 *
 */
public class OrderInfoAction extends DispatchAction{
	
	private IOrderInfoService orderInfoService;
	
	public IOrderInfoService getOrderInfoService() {
		return orderInfoService;
	}

	public void setOrderInfoService(IOrderInfoService orderInfoService) {
		this.orderInfoService = orderInfoService;
	}
	
	/**
	 * 内置数据
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String str="{success:true,totalCount:2,data:[" +
	    		"{orderId:'1',customerId:'123456',customerName:'lrb',mobile:'13940021533',orderType:'新定',orderState:'可分配订单',orderDate:'2011-7-19'}" +
	    		",{orderId:'2',customerId:'123456',customerName:'李亚方',mobile:'13888888888',orderType:'新定',orderState:'不可分配',orderDate:'2011-7-19'}" +
	    		",{orderId:'3',customerId:'123454',customerName:'罗荣博',mobile:'15040204936',orderType:'新定',orderState:'可分配订单',orderDate:'2011-7-19'}]}";
	    response.getWriter().print(str);
		return null;
	}
	
	/**
	 * 根据相应条件查询订单基本信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return null
	 * @throws IOException
	 */
	public ActionForward findOrderInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		response.setContentType("text/json;charset = utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
			
		//读取前台数据
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String orderId = request.getParameter("orderId");
		String orderType = request.getParameter("orderType");
		String orderState = request.getParameter("orderState");
		String customerName = request.getParameter("customerName");
		String mobile = request.getParameter("mobile");
		
		//如果前台数据都为空，则查询所有的订单
		if(startTime==null && endTime==null && orderId == null && 
		orderType==null && orderState==null && customerName==null && mobile==null){
			
			String orders = orderInfoService.findAllOrders();
			response.getWriter().print(orders);
		
		}else{//根据相应条件查询订单信息
			
			Order order = new Order();
			Customer customer = new Customer();
			
			if(startTime.equals("请选择开始时间")){
				startTime = null;
			}
			System.out.println("order.startTime="+startTime);
			
			if(endTime.equals("请选择结束时间")){
				endTime = null;
			}
		//	System.out.println("endTime="+endTime);
			
			if(request.getParameter("orderId").equals("按订单号查询")){
				order.setOrderid(-1);
			}else{
				order.setOrderid(Integer.parseInt(request.getParameter("orderId")));
			}
			//System.out.println("order.getOrderid()="+order.getOrderid());
			
			if(request.getParameter("orderType") == null || request.getParameter("orderType").equals("")){
				order.setOrdertype(null);
			}else if(request.getParameter("orderType").equals("0")){
				order.setOrdertype("全部");
			}else if(request.getParameter("orderType").equals("1")){
				order.setOrdertype("新订");
			}else if(request.getParameter("orderType").equals("2")){
				order.setOrdertype("异地收费");
			}
	//		System.out.println("~~~~~~~~~~~~~~~~~ordertype="+order.getOrdertype());
			
			if(request.getParameter("orderState")==null || request.getParameter("orderState").equals("")){
				order.setOrderstate(null);
			}else if(request.getParameter("orderState").equals("0")){
				order.setOrderstate("可分配");
			}else if(request.getParameter("orderState").equals("1")){
				order.setOrderstate("缺货");
			}else if(request.getParameter("orderState").equals("2")){
				order.setOrderstate("已调度");
			}else if(request.getParameter("orderState").equals("3")){
				order.setOrderstate("中心库房出库");
			}else if(request.getParameter("orderState").equals("4")){
				order.setOrderstate("分站到货");
			}else if(request.getParameter("orderState").equals("5")){
				order.setOrderstate("已分配");
			}else if(request.getParameter("orderState").equals("6")){
				order.setOrderstate("已领货");
			}else if(request.getParameter("orderState").equals("7")){
				order.setOrderstate("已完成");
			}else if(request.getParameter("orderState").equals("7")){
				order.setOrderstate("失败");
			}
			
			if(request.getParameter("customerName").equals("按客户姓名查询")){
				order.setLCustomer(null);
			}else{
				customer.setCustomername(request.getParameter("customerName"));
				order.setLCustomer(customer);
			}

			if(request.getParameter("mobile").equals("按联系电话查询")){
				order.setReceivepersontel(null);
			}else{
				order.setReceivepersontel(request.getParameter("mobile"));
			}
			
			String orders =	orderInfoService.findOrderInfo(order,startTime,endTime);
			//String json = "{success:true,totalCount:2}";
			response.getWriter().print(orders);
		}
		return null;
	}


}

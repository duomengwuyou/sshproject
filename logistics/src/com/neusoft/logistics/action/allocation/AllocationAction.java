package com.neusoft.logistics.action.allocation;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.allocation.IAllocationService;
import com.neusoft.logistics.service.inter.allocation.ISubstationService;
/**
 * @author 宋延杰
 * doQueryOrder：查询订单
 * doModOrder：调度分站或者修改订单状态
 * doFindAllSubstation：查询全部分站
 * doAllocationOrder：调度订单，生成任务单和调拨单，并记录当前操作人员和操作时间
 */
public class AllocationAction extends DispatchAction{
	private IAllocationService allocationService;
	private ISubstationService substationService; 
	public ISubstationService getSubstationService() {
		return substationService;
	}

	public void setSubstationService(ISubstationService substationService) {
		this.substationService = substationService;
	}
	public IAllocationService getAllocationService() {
		return allocationService;
	}

	public void setAllocationService(IAllocationService allocationService) {
		this.allocationService = allocationService;
	}
	/**
	 * 查询订单
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return orderList
	 * @throws Exception
	 */
	public ActionForward doQueryOrder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String requiredDate = request.getParameter("requiredDate");
	    String orderType = request.getParameter("orderType");
	    String shortageState = request.getParameter("shortageState");
	    if(shortageState==null||shortageState.equals("")){
	    	String orderList = allocationService.findOrderByRequireddateAndOrdertype(requiredDate,orderType);
	    	response.getWriter().print(orderList);
	    }else{
	    	String orderList = allocationService.findOrderByRequireddateAndOrdertypeAndShortageState(requiredDate,orderType,shortageState);
	    	response.getWriter().print(orderList);
	    }
	    
		return null;
	}
	/**
	 * 调度分站或者修改订单状态
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public ActionForward doModOrder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String field = request.getParameter("field");
		String value = request.getParameter("value");
		int orderId = Integer.parseInt(request.getParameter("orderid"));
		allocationService.modSubstationOrOrderstate(orderId,field,value);
		response.getWriter().print("{success:true}");
		return null;
		
		
	}
	/**
	 * 查询全部分站
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return substationList
	 * @throws IOException
	 */
	public ActionForward doFindAllSubstation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
		String substationList = substationService.findAllSubstation();
		response.getWriter().print(substationList);
		return null;
	
	}
	/**
	 * 调度订单，生成任务单和调拨单，并记录当前操作人员和操作时间
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward doAllocationOrder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    //获取页面选中的orderId
	    String orderIds = request.getParameter("orderIds");
	    HttpSession session = request.getSession();
	    User user = (User) session.getAttribute("user");
	    //调用服务层 生成任务单和调拨单
	    String str=allocationService.saveAllocationOrder(orderIds,user);
	    if(str.equals("no"))
	    {
	    	String msg = "{success:false,totalCount:2,msg:'对不起，请调度分站！'}";
			response.getWriter().print(msg);
	    }else{
	    	String msg1 = "{success:true,totalCount:2}";
			response.getWriter().print(msg1);
	    }
	    //返回给页面
		return null;
	}
}
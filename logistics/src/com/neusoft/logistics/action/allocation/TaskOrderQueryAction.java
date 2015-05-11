package com.neusoft.logistics.action.allocation;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;


import com.neusoft.logistics.service.inter.allocation.ITaskOrderQueryService;

/**
 * 
 * @author 宋延杰
 *
 */
public class TaskOrderQueryAction extends DispatchAction{
	private ITaskOrderQueryService taskOrderQueryService;
	public ITaskOrderQueryService getTaskOrderQueryService() {
		return taskOrderQueryService;
	}
	public void setTaskOrderQueryService(ITaskOrderQueryService taskOrderQueryService) {
		this.taskOrderQueryService = taskOrderQueryService;
	}
	/**
	 * 查询订单
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward doQueryTaskOrder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    String requiredDate = request.getParameter("requiredDate");
	    String taskOrderId = request.getParameter("taskOrderId");
	    String taskOrderType = request.getParameter("taskOrderType");
	    String taskOrderState = request.getParameter("taskOrderState");
	    String deliverSubstation = request.getParameter("deliverSubstation");
	    String custormerName = request.getParameter("custormerName");
	    String receivePersonTel = request.getParameter("receivePersonTel");
	    
	    String taskOrderList = taskOrderQueryService.findTaskOrder(requiredDate,taskOrderId,taskOrderType,taskOrderState,deliverSubstation,custormerName,receivePersonTel);

	    response.getWriter().print(taskOrderList);
		return null;
	}
	/**
	 * 获取全部任务单号
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward doQueryOrderId(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
		String taskOrderIdList = taskOrderQueryService.findAllOrderId();
		response.getWriter().print(taskOrderIdList);
		return null;
	}
}

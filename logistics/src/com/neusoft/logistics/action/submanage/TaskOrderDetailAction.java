package com.neusoft.logistics.action.submanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.impl.submanage.SubGetAllTaskServiceImpl;
/**
 * 
 * @author 李莎 
 * 显示任务单详情
 *
 */
public class TaskOrderDetailAction extends DispatchAction{
	
	private SubGetAllTaskServiceImpl  subGetTaskService;
	
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    //从页面获得参数
	    String taskorderId = request.getParameter("taskid");
	    //调用服务层的返回任务单详情方法
	    String str = subGetTaskService.taskDetailInfo(Integer.parseInt(taskorderId));

		response.getWriter().print(str);
		return null;
	}
	public SubGetAllTaskServiceImpl getSubGetTaskService() {
		return subGetTaskService;
	}
	public void setSubGetTaskService(SubGetAllTaskServiceImpl subGetTaskService) {
		this.subGetTaskService = subGetTaskService;
	}
}

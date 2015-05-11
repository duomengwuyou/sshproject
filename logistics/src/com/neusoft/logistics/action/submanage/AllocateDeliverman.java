package com.neusoft.logistics.action.submanage;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.impl.submanage.SubGetAllTaskServiceImpl;

public class AllocateDeliverman extends DispatchAction{
	
	SubGetAllTaskServiceImpl allocateDiliverman;
	
	public SubGetAllTaskServiceImpl getAllocateDiliverman() {
		return allocateDiliverman;
	}

	public void setAllocateDiliverman(SubGetAllTaskServiceImpl allocateDiliverman) {
		this.allocateDiliverman = allocateDiliverman;
	}

	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    //从页面获得修改参数
	    int dilivermanid = Integer.parseInt(request.getParameter("value"));
	    int taskOrderId = Integer.parseInt(request.getParameter("taskOrderId"));
	    
	   //调用服务层的更新配送员方法
	    int i = allocateDiliverman.modifyDiliverman(taskOrderId, dilivermanid);
	    if(i == 1){
	    	response.getWriter().print("{success:true}");
	    } 
		return null;
	}

}

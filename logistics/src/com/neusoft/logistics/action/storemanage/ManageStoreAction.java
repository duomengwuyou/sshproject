package com.neusoft.logistics.action.storemanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.IQueryUserService;

/**
 * @author ttc
 *
 */
public class ManageStoreAction extends DispatchAction{ 
	private IQueryUserService queryUserService;
	
	public IQueryUserService getQueryUserService() {
		return queryUserService;
	}

	public void setQueryUserService(IQueryUserService queryUserService) {
		this.queryUserService = queryUserService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8"); 
		response.getWriter().print(queryUserService.findWarehouseManage());
		return null; 
	}
	
}

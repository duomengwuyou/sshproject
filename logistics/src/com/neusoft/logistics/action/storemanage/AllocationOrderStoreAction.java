package com.neusoft.logistics.action.storemanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import java.sql.Date;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.storemanage.IOutStorageService;

public class AllocationOrderStoreAction extends DispatchAction{
	private IOutStorageService outStorageService;
	
	public IOutStorageService getOutStorageService() {
		return outStorageService;
	}

	public void setOutStorageService(IOutStorageService outStorageService) {
		this.outStorageService = outStorageService;
	}

	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String RequiredDate = request.getParameter("RequiredDate");
	    String str = outStorageService.getAllocationOrderByDate(RequiredDate);
	    /*String str="{success:true,totalCount:4,data:[" +
	    		"{allocationOrder:'1',order:'11',allocationDate:'2011-7-24',operator:'1',allocationState:'已调拨'}," +
	    		"{allocationOrder:'2',order:'22',allocationDate:'2011-7-24',operator:'1',allocationState:'已调拨'}," +
	    		"{allocationOrder:'3',order:'33',allocationDate:'2011-7-24',operator:'1',allocationState:'已调拨'}," +
	    		"{allocationOrder:'4',order:'44',allocationDate:'2011-7-24',operator:'1',allocationState:'已调拨'}" +
	    		"]}";*/
	    response.getWriter().print(str);
		return null;
	}
	public ActionForward showDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String temp = request.getParameter("allocationIds");
	    String[] allocationIds = temp.split(",");
	    String str = this.outStorageService.showDetail(allocationIds);
	    /*String str="{success:true,totalCount:4,data:[" +
	    		"{id:'1',warehouse:'四川分库',productName:'洗发水',amount:'100'}," +
	    		"{id:'2',warehouse:'山西分库',productName:'电脑',amount:'100'}," +
	    		"{id:'3',warehouse:'四川分库',productName:'电脑',amount:'100'}," +
	    		"{id:'4',warehouse:'山西分库',productName:'洗发水',amount:'100'}" +
	    		"]}";*/
	    response.getWriter().print(str);
		return null;
	}
	
	public ActionForward saveAllocation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String allocationOrders = request.getParameter("allocationOrders");
		String[] allocations = allocationOrders.split(",");
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		this.outStorageService.saveAllocation(allocations,user);
		return null;
	}
	
}

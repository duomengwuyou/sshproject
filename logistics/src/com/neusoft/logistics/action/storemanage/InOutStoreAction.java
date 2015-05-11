package com.neusoft.logistics.action.storemanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.dispatchCenterManage.IInOutStorageOrderService;

public class InOutStoreAction extends DispatchAction{
	private IInOutStorageOrderService inOutStorageOrderService; 
 

	public IInOutStorageOrderService getInOutStorageOrderService() {
		return inOutStorageOrderService;
	}


	public void setInOutStorageOrderService(
			IInOutStorageOrderService inOutStorageOrderService) {
		this.inOutStorageOrderService = inOutStorageOrderService;
	}


	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    //pri
	    
	    
	   /* String str="{success:true,totalCount:5,data:[" +
		"{id:'1',style:'出库单',OrderId:'1',wareHouseName:'沈阳分站',productId:'1',productName:'诺基亚',costPrice:'100',Quantity:'1',MoneyAmount:'3',Date:'2011-7-21'}," +
		"{id:'2',style:'出库单',OrderId:'2',wareHouseName:'沈阳分站',productId:'2',productName:'诺基亚',costPrice:'100',Quantity:'1',MoneyAmount:'3',Date:'2011-7-21'}," +
		"{id:'3',style:'入库单',OrderId:'1',wareHouseName:'大连分站',productId:'3',productName:'诺基亚',costPrice:'100',Quantity:'1',MoneyAmount:'3',Date:'2011-7-21'}," +
		"{id:'4',style:'入库单',OrderId:'2',wareHouseName:'大连分站',productId:'4',productName:'诺基亚',costPrice:'100',Quantity:'1',MoneyAmount:'3',Date:'2011-7-21'}," +
		"{id:'5',style:'入库单',OrderId:'3',wareHouseName:'大连分站',productId:'5',productName:'诺基亚',costPrice:'100',Quantity:'1',MoneyAmount:'3',Date:'2011-7-21'}" +
		"]}";*/
	    response.getWriter().print(inOutStorageOrderService.getInOutStorageOrder(request.getParameter("startTime"),request.getParameter("endTime"),request.getParameter("productName")));
		return null;
	}
}

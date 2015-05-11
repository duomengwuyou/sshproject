package com.neusoft.logistics.action.storemanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.dispatchCenterManage.IStorageInfoService;

public class RemainStorageAction extends DispatchAction{
/*	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String str="{success:true,totalCount:4,data:[" +
		"{id:'1',warehouseName:'沈阳',productName:'诺基亚',totalQuantity:'100',returnQuantity:'5',allocateQuantity:'50',alreadyAllocateQuantity:'45'}," +
		"{id:'2',warehouseName:'沈阳',productName:'诺基亚',totalQuantity:'100',returnQuantity:'5',allocateQuantity:'50',alreadyAllocateQuantity:'45'}," +
		"{id:'3',warehouseName:'沈阳',productName:'诺基亚',totalQuantity:'100',returnQuantity:'5',allocateQuantity:'50',alreadyAllocateQuantity:'45'}," +
		"{id:'4',warehouseName:'沈阳',productName:'诺基亚',totalQuantity:'100',returnQuantity:'5',allocateQuantity:'50',alreadyAllocateQuantity:'45'}" +
		"]}";
	    response.getWriter().print(str);
		return null;
	}*/
	private IStorageInfoService  storageInsoService;
	
	public IStorageInfoService getStorageInsoService() {
		return storageInsoService;
	}

	public void setStorageInsoService(IStorageInfoService storageInsoService) {
		this.storageInsoService = storageInsoService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    response.getWriter().print(storageInsoService.searchStorageAmount(request.getParameter("productName"),request.getParameter("warehouseName")));
		return null;
	}
}

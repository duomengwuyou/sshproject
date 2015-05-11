package com.neusoft.logistics.action.storemanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.dispatchCenterManage.IWarehouseService;

public class WareHouseStoreAction extends DispatchAction{
	/*public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String str="{success:true,totalCount:4,data:[" +
		"{warehouseId:'1', warehouseName:'山西运城分站', warehouseAddress:'山西运城', warehouseType:'中心库房',warehouseManager:'李亚方'}," +
		"{warehouseId:'2', warehouseName:'山西运城分站', warehouseAddress:'山西运城', warehouseType:'中心库房',warehouseManager:'李亚方'}," +
		"{warehouseId:'3', warehouseName:'山西运城分站', warehouseAddress:'山西运城', warehouseType:'中心库房',warehouseManager:'李亚方'}," +
		"{warehouseId:'4', warehouseName:'山西运城分站', warehouseAddress:'山西运城', warehouseType:'中心库房',warehouseManager:'李亚方'}" +
		"]}";
	    response.getWriter().print(str);
		return null;
	}*/
	private IWarehouseService warehouseService;

	public IWarehouseService getWarehouseService() {
		return warehouseService;
	}

	public void setWarehouseService(IWarehouseService warehouseService) {
		this.warehouseService = warehouseService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
		String warehouseAdd=request.getParameter("SearchByAddress"); 
		response.getWriter().print(warehouseService.searchWarehouseByAdd(warehouseAdd));
		return null;
	}
}

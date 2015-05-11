package com.neusoft.logistics.action.dispatcherCenterManage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IWarehouseService;
/**
 * 库房设置
 * @author 陈秀能
 * **/
public class WarehouseAction extends DispatchAction {
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
		String actionType=request.getParameter("actionType"); 
		if(actionType.equals("add")){  
			User manager=new User();
			manager.setUserid(Integer.valueOf(request.getParameter("warehouseManager")));
			Warehouse warehouse=new Warehouse();
			warehouse.setWarehousename(request.getParameter("warehouseName"));
			warehouse.setWarehouseaddress(request.getParameter("warehouseAdress"));
			warehouse.setWarehousetype(request.getParameter("warehouseType"));
			warehouse.setLUser(manager);
			response.getWriter().print(warehouseService.saveWarehouse(warehouse));
		}else if(actionType.equals("edit")){
			response.getWriter().print(warehouseService.modifyWarehouse(Integer.valueOf(request.getParameter("warehouseId")),request.getParameter("field"),request.getParameter("value")));
		}else if(actionType.equals("delete")){
			String warehouseIds = request.getParameter("warehouseIds");
			System.out.println(this.getClass()+" delete warehouseIds="+warehouseIds);
			String[] root = warehouseIds.split(",");
			response.getWriter().print(warehouseService.delete(root)); 
		}
		return null;
	}
}

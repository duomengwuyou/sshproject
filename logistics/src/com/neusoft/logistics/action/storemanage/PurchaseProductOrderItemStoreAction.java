package com.neusoft.logistics.action.storemanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import com.neusoft.logistics.service.inter.storemanage.ISearchPurchaseOrderItemService;

import java.sql.Date;
public class PurchaseProductOrderItemStoreAction extends DispatchAction{
	
	private ISearchPurchaseOrderItemService searchPurchaseOrderItemService;
	
	public ISearchPurchaseOrderItemService getSearchPurchaseOrderItemService() {
		return searchPurchaseOrderItemService;
	}

	public void setSearchPurchaseOrderItemService(
			ISearchPurchaseOrderItemService searchPurchaseOrderItemService) {
		this.searchPurchaseOrderItemService = searchPurchaseOrderItemService;
	}
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("进入查询购货入库单Action");
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String purchaseProductOrderId = request.getParameter("purchaseProductOrderId");
	    int id;
	    if(purchaseProductOrderId == null||purchaseProductOrderId.equals("")){
	    	id = 0;
	    }else{
	    	id = Integer.parseInt(purchaseProductOrderId);
	    }
	    System.out.println("id为"+id);
	    String result = searchPurchaseOrderItemService.getItemsByPurchaseProductInStorageOrderId(id);
	    System.out.println("查询结果为===lyf===="+result);
	    response.getWriter().print(result);
		return null;
	}
	public ActionForward doUpdate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("进入查询购货入库单Action");
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String quantity = request.getParameter("quantity");
	    System.out.println("quantity=========="+quantity);
	    String id = request.getParameter("id");
	    System.out.println("id=========="+id);
	    searchPurchaseOrderItemService.saveRealIntoQuantity(Integer.parseInt(id),Integer.parseInt(quantity));
	    response.getWriter().print("{success:true}");
		return null;
	}
	public ActionForward saveInStorage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("开始入库===Action");
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String id = request.getParameter("purchaseProductOrderId");
	    String state = request.getParameter("productPurchaseState");
	    String date = request.getParameter("purchaseDate");
	    String remark = request.getParameter("puchaseRemark");
	    searchPurchaseOrderItemService.saveInStorage(Integer.parseInt(id), state, Date.valueOf(date),remark);
	    response.getWriter().print("{success:true}");
		return null;
	}
}

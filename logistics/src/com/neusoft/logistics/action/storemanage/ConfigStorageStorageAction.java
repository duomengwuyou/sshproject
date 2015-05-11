package com.neusoft.logistics.action.storemanage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.dispatchCenterManage.IStorageInfoService;

/*******************************************************************************
 * 库房储备设置
 * 
 * @author 陈秀能
 ******************************************************************************/
public class ConfigStorageStorageAction extends DispatchAction {
	private IStorageInfoService storageInfoService;

	public IStorageInfoService getStorageInfoService() {
		return storageInfoService;
	}

	public void setStorageInfoService(IStorageInfoService storageInfoService) {
		this.storageInfoService = storageInfoService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String actionType=request.getParameter("actionType");
	    if(actionType.equals("edit")){
	    	response.getWriter().print(storageInfoService.modifyStorageInfo(Integer.valueOf(request.getParameter("storageInfoId")),request.getParameter("field"),request.getParameter("value")));
	    }else if(actionType.equals("search")){
	    String productName=request.getParameter("productName");
	    System.out.println(this.getClass()+" product="+productName);
	   /*
		 * String str="{success:true,totalCount:4,data:[" + "{storageInfoId:'1',
		 * productId:'1', productName:'诺基亚',
		 * warningQuantity:'100',maxQuantity:'1000',remainQuantity:'400'}," +
		 * "{storageInfoId:'2', productId:'2', productName:'联想电脑',
		 * warningQuantity:'100',maxQuantity:'1000',remainQuantity:'400'}," +
		 * "{storageInfoId:'3', productId:'3', productName:'惠普电脑',
		 * warningQuantity:'100',maxQuantity:'1000',remainQuantity:'400'}," +
		 * "{storageInfoId:'4', productId:'4', productName:'佳能照相机',
		 * warningQuantity:'100',maxQuantity:'1000',remainQuantity:'400'}" +
		 * "]}"; response.getWriter().print(str);
		 */
	    response.getWriter().print(storageInfoService.findStorageInfoByProductName(productName));
	    }
		return null;
	}
}

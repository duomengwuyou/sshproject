package com.neusoft.logistics.action.storemanage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class CenterwarehouseOutAction extends DispatchAction{
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String str="{success:true,totalCount:4,data:[{id:'1',returnProductOrderId:'31', productName:'诺基亚', productQuantity:'100'}" +
		",{id:'2',returnProductOrderId:'31', productName:'联想电脑', productQuantity:'100'}" +
		",{id:'3',returnProductOrderId:'33', productName:'惠普电脑', productQuantity:'100'}" +
		",{id:'4',returnProductOrderId:'33', productName:'佳能照相机', productQuantity:'100'}]}";
//	    String str="{success:true,totalCount:3,data:[{id:'1',returnProductOrderId:'123456',productName:'大头皮鞋',productQuantity:'1000'}" +
//		",{id:'2',returnProductOrderId:'123456',productName:'李亚方牌沐浴露',productQuantity:'2000'}" +
//		",{id:'3',returnProductOrderId:'123454',productName:'罗荣博牌洗发水',productQuantity:'1000'}]}";

	    response.getWriter().print(str);
		return null;
	}
}

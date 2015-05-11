package com.neusoft.logistics.action.storemanage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class SubstationReturnOutAction extends DispatchAction{
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String str="{success:true,totalCount:3,data:[{id:'1',returnProductOrderId:'123456',productName:'大头皮鞋',unit:'双',returnQuantity:'1000',returnDate:'2011-7-19'}" +
		",{id:'2',returnProductOrderId:'123456',productName:'李亚方牌沐浴露',unit:'瓶',returnQuantity:'2000',returnDate:'2011-7-19'}" +
		",{id:'3',returnProductOrderId:'123454',productName:'罗荣博牌洗发水',unit:'瓶',returnQuantity:'1000',returnDate:'2011-7-19'}]}";
	    response.getWriter().print(str);
		return null;
	}
}

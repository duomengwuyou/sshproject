package com.neusoft.logistics.action.storemanage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

public class SubstationReturnAction extends DispatchAction{
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String str="{success:true,totalCount:3,data:[{id:'1',taskOrderId:'123456',productName:'大头皮鞋',productQuantity:'1000',realIntoQuantity:'',realReturnDate:'2011-7-19',receiveFormRemark:'不错'}" +
		",{id:'2',taskOrderId:'123456',productName:'李亚方牌沐浴露',productQuantity:'2000',realIntoQuantity:'',realReturnDate:'2011-7-19',receiveFormRemark:'不错'}" +
		",{id:'3',taskOrderId:'123454',productName:'罗荣博牌洗发水',productQuantity:'1000',realIntoQuantity:'',realReturnDate:'2011-7-19',receiveFormRemark:'不错'}]}";
	    response.getWriter().print(str);
		return null;
	}
}

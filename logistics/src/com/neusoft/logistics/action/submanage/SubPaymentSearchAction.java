package com.neusoft.logistics.action.submanage;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.submanage.ISubPaymentSearchService;
/**
 * 
 * @author 李莎 
 * 得到分站所有的缴款信息
 *
 */
public class SubPaymentSearchAction extends DispatchAction{
	ISubPaymentSearchService payService;
	public ISubPaymentSearchService getPayService() {
		return payService;
	}
	public void setPayService(ISubPaymentSearchService payService) {
		this.payService = payService;
	}
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");

	    //从页面获得参数
	    String start = request.getParameter("start");
	    String end = request.getParameter("end");
	    String product = request.getParameter("product");
	    
	  //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
	    Iterator iterator = user.getLSubstations().iterator();
	    Substation substation = null;
    
	    if(iterator.hasNext()){
	    	substation = (Substation)iterator.next();
	    }
	    response.getWriter().print(payService.getAllSubProductsStatistics(substation, start, end, product));
		return null;
	}
}


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
import com.neusoft.logistics.service.impl.submanage.SubGetAllDelivermanServiceImpl;
/**
 * 
 * @author 李莎 
 * 得到分站所有的配送员
 *
 */
public class SubGetAllDelivermanAction extends DispatchAction{
	private SubGetAllDelivermanServiceImpl subGetAllDelivermanService;
	
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");

	    //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
	    Iterator iterator = user.getLSubstations().iterator();
	    Substation substation = null;
	    
	    if(iterator.hasNext()){
	    	substation = (Substation)iterator.next();
	    }
	    response.getWriter().print(subGetAllDelivermanService.getAllDeliverman(substation));
		return null;
	}
	public SubGetAllDelivermanServiceImpl getSubGetAllDelivermanService() {
		return subGetAllDelivermanService;
	}
	public void setSubGetAllDelivermanService(
			SubGetAllDelivermanServiceImpl subGetAllDelivermanService) {
		this.subGetAllDelivermanService = subGetAllDelivermanService;
	}
}
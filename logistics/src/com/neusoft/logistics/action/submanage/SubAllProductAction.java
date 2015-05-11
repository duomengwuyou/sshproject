package com.neusoft.logistics.action.submanage;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.impl.submanage.SubGetAllDelivermanServiceImpl;
/**
 * 
 * @author 李莎 
 * 得到所有商品
 *
 */
public class SubAllProductAction extends DispatchAction{
	private SubGetAllDelivermanServiceImpl subGetAllDelivermanService;
	
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    //调用服务层的得到所有商品的方法
	    response.getWriter().print(subGetAllDelivermanService.getAllProducts());
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
package com.neusoft.logistics.action.customerservice;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.service.inter.customermanage.ICustomerInfoService;
/**
 * CustomerInfoAction
 * @author 张文华
 *
 */
public class CustomerInfoAction extends DispatchAction{
	
	private ICustomerInfoService customerInfoService;
	
	
	public ICustomerInfoService getCustomerInfoService() {
		return customerInfoService;
	}


	public void setCustomerInfoService(ICustomerInfoService customerInfoService) {
		this.customerInfoService = customerInfoService;
	}


	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    if(request.getParameter("customerName2")==null && request.getParameter("mobile2")==null&&request.getParameter("idcard2")==null){
	    	response.getWriter().print(customerInfoService.getAllCustomers());
	    }else{
	    	Customer customer = new Customer();
			
			customer.setCustomername(request.getParameter("customerName2"));
			customer.setMobile(request.getParameter("mobile2"));
			customer.setIdcard(request.getParameter("idcard2"));
	    	response.getWriter().print(customerInfoService.getSearchCustomers(customer));
	    }
	    
	    
		return null;
	}
	
	public ActionForward addCustomer(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		Customer customer = new Customer();
		
		customer.setCustomername(request.getParameter("customerName"));
		customer.setIdcard(request.getParameter("idcard"));
		customer.setAddress(request.getParameter("address"));
		customer.setCustomerzipcode(request.getParameter("customerZipCode"));
		customer.setEmail(request.getParameter("email"));
		customer.setMobile(request.getParameter("mobile"));
		customer.setPhone(request.getParameter("phone"));
		customer.setWorkplace(request.getParameter("workPlace"));
		
		customerInfoService.addCustomer(customer);
		String str = "{success:true,totalCount:2}";
		response.getWriter().print(str);
		return null;
	}
	
	public ActionForward delCustomer(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		int customerId = Integer.parseInt(request.getParameter("customerid"));
		Customer customer = customerInfoService.findCustomerById(customerId);
		if(customerInfoService.findOrderByCustomer(customerId).size()==0){
			customerInfoService.delCustomer(customer);
			String str = "{success:true,totalCount:2,deleteid:"+customerId+"}";
			response.getWriter().print(str);
		}else{
			String str = "{success:false,totalCount:2,deleteid:"+customerId+"}";
			response.getWriter().print(str);
		}		
		return null;
	}
	
	public ActionForward modCustomer(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		int customerId = Integer.parseInt(request.getParameter("customerid"));
		Customer customer = customerInfoService.findCustomerById(customerId);
		String field = request.getParameter("field");
		String value = request.getParameter("value");
		
		if(field.equals("customerName")){
			customer.setCustomername(value);
		}else if(field.equals("idcard")){
			customer.setIdcard(value);
		}else if(field.equals("address")){
			customer.setAddress(value);
		}else if(field.equals("customerZipCode")){
			customer.setCustomerzipcode(value);
		}else if(field.equals("email")){
			customer.setEmail(value);
		}else if(field.equals("mobile")){
			customer.setMobile(value);
		}else if(field.equals("phone")){
			customer.setPhone(value);
		}else if(field.equals("workPlace")){
			customer.setWorkplace(value);
		}
		
		customerInfoService.modCustomer(customer);
		String str = "{success:true,totalCount:2}";
		response.getWriter().print(str);
		return null;
	}
	
}

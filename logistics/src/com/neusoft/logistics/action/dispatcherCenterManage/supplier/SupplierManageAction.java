package com.neusoft.logistics.action.dispatcherCenterManage.supplier;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Supplier;
import com.neusoft.logistics.service.inter.dispatchCenterManage.ISupplierService;
/**
 * SupplierManageAction
 * @author 陈秀能
 *
 */
public class SupplierManageAction extends DispatchAction{
	private ISupplierService supplierService;

	public ISupplierService getSupplierService() {
		return supplierService;
	}

	public void setSupplierService(ISupplierService supplierService) {
		this.supplierService = supplierService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String actionType=request.getParameter("actionType");
		if(actionType.equals("display")) response.getWriter().print(supplierService.getAllSuppliers());
		else if(actionType.equals("add"))return add(mapping,form,request,response);
		else if(actionType.equals("delete"))return delete(mapping,form,request,response);
		else if(actionType.equals("mod"))return mod(mapping,form,request,response);
		return null;
	}

	private ActionForward mod(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" execute mod");
		Supplier supplier =new Supplier();
		supplier.setSupplierid(Integer.valueOf(request.getParameter("supplierId")));
		supplier.setBank(request.getParameter("bank"));
		supplier.setBankaccount(request.getParameter("bankAccount"));
		supplier.setContactperson(request.getParameter("contactPerson"));
		supplier.setFax(request.getParameter("fax"));
		supplier.setLegalperson(request.getParameter("legalPerson"));
		supplier.setSupplieradd(request.getParameter("supplierAdd"));
		supplier.setSuppliername(request.getParameter("supplierName"));
		supplier.setSupplierremark(request.getParameter("supplierRemark"));
		supplier.setSuppliertel(request.getParameter("supplierTel"));
		supplier.setSupplierzipcode(request.getParameter("supplierZipCode")); 
		response.getWriter().print(supplierService.modSupplier(supplier));
		return null;
	}

	private ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		String categoryIds = request.getParameter("supplierid");
		System.out.println(this.getClass()+" supplierid="+categoryIds);
		String[] root = categoryIds.split(",");
		response.getWriter().print(supplierService.delete(root));
		// TODO Auto-generated method stub
		return null;
	}

	private ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		Supplier supplier =new Supplier();
		supplier.setBank(request.getParameter("bank"));
		supplier.setBankaccount(request.getParameter("bankAccount"));
		supplier.setContactperson(request.getParameter("contactPerson"));
		supplier.setFax(request.getParameter("fax"));
		supplier.setLegalperson(request.getParameter("legalPerson"));
		supplier.setSupplieradd(request.getParameter("supplierAdd"));
		supplier.setSuppliername(request.getParameter("supplierName"));
		supplier.setSupplierremark(request.getParameter("supplierRemark"));
		supplier.setSuppliertel(request.getParameter("supplierTel"));
		supplier.setSupplierzipcode(request.getParameter("supplierZipCode")); 
		response.getWriter().print(supplierService.saveSupplier(supplier));
		// TODO Auto-generated method stub
		return null;
	}
}

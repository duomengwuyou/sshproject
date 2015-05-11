package com.neusoft.logistics.action.dispatcherCenterManage;

import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.Supplier;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IManageProductService;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IQueryProductService;

/**
 * CustomerInfoAction
 * 
 * @author 张文华
 * 
 */
public class ProductInfoAction extends DispatchAction {
	private IQueryProductService queryProductService;
	private IManageProductService manageProductService;

	public IQueryProductService getQueryProductService() {
		return queryProductService;
	}

	public void setQueryProductService(IQueryProductService queryProductService) {
		this.queryProductService = queryProductService;
	}

	

	public IManageProductService getManageProductService() {
		return manageProductService;
	}

	public void setManageProductService(IManageProductService manageProductService) {
		this.manageProductService = manageProductService;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		System.out.println(this.getClass() + " exec");
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String actionType = request.getParameter("actionType");
		System.out.println(this.getClass() + " actionType="+actionType);
		if (actionType.equals("product"))
			response.getWriter().print(queryProductService.getAllProducts());
		else if(actionType.equals("add"))return add(mapping,form,request,response);
		else if(actionType.equals("delete"))return delete(mapping,form,request,response);
		else if(actionType.equals("modify"))return modify(mapping,form,request,response);
		return null;
	}

	private ActionForward modify(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
	/*	String value=request.getParameter("value");
		String field=request.getParameter("field");
		int productId=Integer.valueOf(request.getParameter("productId"));
		System.out.println(this.getClass()+" value="+value+" field="+field+" productId="+productId);*/
		response.getWriter().print(manageProductService.modify(Integer.valueOf(request.getParameter("productId")),request.getParameter("value"),request.getParameter("field"))); 
		// TODO Auto-generated method stub
		return null;
	}

	private ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException { 
		String productIds = request.getParameter("productIds");
		System.out.println(this.getClass()+" delete productIds="+productIds);
		String[] root = productIds.split(",");
		response.getWriter().print(manageProductService.delete(root)); 
		// TODO Auto-generated method stub
		return null;
	}

	private ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println(this.getClass() + " execute add");
 
		Product product=new Product();
		int secondCategoryid=Integer.valueOf(request.getParameter("secondcategory"));
		String productName=request.getParameter("productName");
		String unit=request.getParameter("unit");
		double originalPrice=Double.valueOf(request.getParameter("originalPrice"));
		double discount=Double.valueOf(request.getParameter("discount"));
		double costPrice=Double.valueOf(request.getParameter("costPrice"));
		String productType=request.getParameter("productType");
		int supplierid=Integer.valueOf(request.getParameter("supplierSelected"));
		String manufacturer=request.getParameter("manufacturer");
		String guaranteePeriod=request.getParameter("guaranteePeriod");
		String returnable=request.getParameter("returnable");
		String changeable=request.getParameter("changeable");
		String productRemark=request.getParameter("productRemark");
		
		product.setChangeable(changeable.equals("是")?1:0);
		product.setCostprice(costPrice);
		product.setDiscount(discount);
		product.setGuaranteeperiod(Date.valueOf(guaranteePeriod));
		Category category=new Category();
		category.setCategoryid(secondCategoryid);
		product.setLCategory(category);
		product.setManufacturer(manufacturer);
		product.setUnit(unit);
		product.setReturnable(returnable.equals("是")?1:0);
		product.setProducttype(productType);
		product.setProductremark(productRemark);
		product.setProductname(productName);
		product.setOriginalprice(originalPrice);
		Supplier LSupplier=new Supplier();
		LSupplier.setSupplierid(supplierid);
		product.setLSupplier(LSupplier);
		// TODO Auto-generated method stub
		response.getWriter().print(manageProductService.save(product)); 
		return null;
	}

	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String str = "{success:true,totalCount:2,data:["
			+ "{productId:'1',productName:'补水霜',firstClassName:'化妆品',secondClassName:'御泥坊',unit:'瓶',originalPrice:'50',discount:'0.9',costPrice:'45',productType:'4556767',supplier:'御泥坊',manufacturer:'御泥坊',guaranteePeriod:'3年',returnable:'是',changeable:'是',productRemark:'效果好'}"
			+ ",{productId:'2',productName:'海飞丝',firstClassName:'化妆品',secondClassName:'洗发露',unit:'瓶',originalPrice:'40',discount:'0.9',costPrice:'35',productType:'4556767',supplier:'御泥坊',manufacturer:'御泥坊',guaranteePeriod:'3年',returnable:'是',changeable:'是',productRemark:'效果好'}"
			+ ",{productId:'3',productName:'飘柔',firstClassName:'化妆品',secondClassName:'洗发露',unit:'瓶',originalPrice:'30',discount:'0.9',costPrice:'25',productType:'4556767',supplier:'御泥坊',manufacturer:'御泥坊',guaranteePeriod:'3年',returnable:'是',changeable:'是',productRemark:'效果好'}]}";
		response.getWriter().print(str);
		return null;
	}
}

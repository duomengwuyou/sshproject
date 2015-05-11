package com.neusoft.logistics.action.customerservice;


import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.customermanage.ICustomerInfoService;
import com.neusoft.logistics.service.inter.customermanage.IOrderProductInfoService;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IQueryCategoryService;
import com.neusoft.logistics.utils.JSONHelper;
/**
 * OrderProductInfoAction
 * @author 张文华
 *
 */
public class OrderProductInfoAction extends DispatchAction{
	private IOrderProductInfoService orderProductInfoService;
	private ICustomerInfoService customerInfoService;

	public IOrderProductInfoService getOrderProductInfoService() {
		return orderProductInfoService;
	}

	public void setOrderProductInfoService(
			IOrderProductInfoService orderProductInfoService) {
		this.orderProductInfoService = orderProductInfoService;
	}

	private IQueryCategoryService queryCategoryService;
	public IQueryCategoryService getQueryCategoryService() {
		return queryCategoryService;
	}

	public void setQueryCategoryService(IQueryCategoryService queryCategoryService) {
		this.queryCategoryService = queryCategoryService;
	}

	public ICustomerInfoService getCustomerInfoService() {
		return customerInfoService;
	}

	public void setCustomerInfoService(ICustomerInfoService customerInfoService) {
		this.customerInfoService = customerInfoService;
	}

	//显示所有商品
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		if((request.getParameter("firstcategory")==null||request.getParameter("firstcategory").equals(""))
				&&(request.getParameter("secondcategory")==null||request.getParameter("secondcategory").equals(""))){
			//一级分类为空，二级分类为空
			response.getWriter().print(orderProductInfoService.getAllProducts());
		}else if((request.getParameter("firstcategory")==null||request.getParameter("firstcategory").equals(""))&&request.getParameter("secondcategory")!=null){
			//一级分类为空，二级分类不为空
			Category category=new Category();
			category.setCategoryid(Integer.parseInt(request.getParameter("secondcategory")));
			response.getWriter().print(orderProductInfoService.findProductByCategory(category));
		}else if(request.getParameter("firstcategory")!=null&&(request.getParameter("secondcategory")==null||request.getParameter("secondcategory").equals(""))){
			//一级分类不为空，二级分类为空 
			Category category=new Category();
			category.setCategoryid(Integer.parseInt(request.getParameter("firstcategory")));
			response.getWriter().print(orderProductInfoService.findProductByCategory(category));
		}else{
			//一级分类不为空，二级分类不为空
			Category category = new Category();

			category.setCategoryid(Integer.parseInt(request.getParameter("firstcategory")));
			Category secondcategory = new Category();
			secondcategory.setCategoryid(Integer.parseInt(request.getParameter("secondcategory")));
			secondcategory.setLCategory(category); 
			response.getWriter().print(orderProductInfoService.findProductByCategory(secondcategory));
		}
		return null;
	}

	//确定订购的商品
	public ActionForward purchaseSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String customerId = request.getParameter("customerId");
		System.out.println("customerId"+customerId);
		if(customerId !=null){  
			HttpSession session = request.getSession();
			OrderItem orderItem=new OrderItem();
			Product product = new Product();
			product.setProductid(Integer.parseInt(request.getParameter("productId")));
			Category firstcategory=new Category();
			firstcategory.setCategoryname(request.getParameter("firstcategoryName"));

			Category secondcatagory = new Category();
			
			secondcatagory.setCategoryname(request.getParameter("secondcategoryName"));
			secondcatagory.setLCategory(firstcategory);
			product.setLCategory(secondcatagory);
			product.setProductid(Integer.parseInt(request.getParameter("productId")));			
			product.setProductname(request.getParameter("productName"));
			product.setUnit(request.getParameter("unit"));
			product.setOriginalprice(Double.parseDouble(request.getParameter("originalPrice")));
			product.setDiscount(Double.parseDouble(request.getParameter("discount")));
			product.setProductremark(request.getParameter("productRemark"));
			
			int num=Integer.parseInt(request.getParameter("buyNumber"));
			Double totalPrice = (Double.parseDouble(request.getParameter("originalPrice")))*num;

			orderItem.setLProduct(product);
			orderItem.setFirstcatergory(product.getLCategory().getLCategory().getCategoryname());
			orderItem.setSecondcategory(product.getLCategory().getCategoryname());
			orderItem.setProductname(product.getProductname());
			orderItem.setOriginalprice(product.getOriginalprice());
			orderItem.setDiscount(product.getDiscount());
			orderItem.setProductremark(product.getProductremark());
			orderItem.setUnit(product.getUnit());
			
			Set<OrderItem>  orderItems=null; 
			orderItems=session.getAttribute(customerId)!=null?(Set<OrderItem>)session.getAttribute(customerId):null;
			if(orderItems==null)orderItems=new HashSet<OrderItem>(); 
			orderItem.setOrderitemamount(num);
			orderItems.add(orderItem);
			session.setAttribute(customerId,orderItems);
		}
		return null;
	}
	
	//显示订购的商品
	public ActionForward getOrderItems(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		String customerId = request.getParameter("customerId");
		Set<OrderItem>  orderItems=null; 
		Set<OrderItem>  orderItems2=new HashSet<OrderItem>(); 
		orderItems=(request.getSession().getAttribute(customerId)!=null?(Set<OrderItem>)request.getSession().getAttribute(customerId):null);
		//删除订购的商品
		if(request.getParameter("productId")!=null&&request.getParameter("operate").equals("delete")){
			System.out.println(this.getClass()+" operate=delete");
			for(OrderItem orderItem:orderItems){
				Product product = new Product(); 
				product.setProductid(Integer.parseInt(request.getParameter("productId")));
				if(!orderItem.equals(product)){
					orderItems2.add(orderItem);
				} 
			}

			request.getSession().setAttribute(customerId, orderItems2);
			orderItems=orderItems2;
		}
		
		
		if(orderItems!=null&&orderItems.size()>0){
			for(OrderItem orderItem:orderItems){
				json.AddItem("firstClassName2", orderItem.getLProduct().getLCategory().getLCategory().getCategoryname());
				json.AddItem("secondClassName2", orderItem.getLProduct().getLCategory().getCategoryname());
				json.AddItem("productId2", Integer.toString(orderItem.getLProduct().getProductid()));
				json.AddItem("productName2", orderItem.getLProduct().getProductname());
				json.AddItem("unit2", orderItem.getLProduct().getUnit());
				json.AddItem("originalPrice2", Double.toString(orderItem.getLProduct().getOriginalprice()));
				json.AddItem("discount2", Double.toString(orderItem.getLProduct().getDiscount()));
				json.AddItem("productRemark2", orderItem.getLProduct().getProductremark());
				json.AddItem("productNumber", Integer.toString(orderItem.getOrderitemamount()));
				json.AddItem("totalPrice", Double.toString(orderItem.getLProduct().getOriginalprice()*orderItem.getOrderitemamount()*orderItem.getLProduct().getDiscount()));

				json.ItemOK();
			}
		}
		response.getWriter().print(json.toString());
		return null;
	}
	//关闭session
	public ActionForward removeOrderItems(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {  
		request.getSession().removeAttribute(request.getParameter("customerId"));
		return null;
	}

	//动态加载货物投递分站
	public ActionForward getDeliverSubstation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		String substationList = orderProductInfoService.findAllSubstation();
		response.getWriter().print(substationList);

		return null;
	}

	//动态加载商品一级分类
	public ActionForward getFirstcategory(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		String firstcategoryList = queryCategoryService.getFirstCategories();
		response.getWriter().print(firstcategoryList);

		return null;
	}
	
	//级联加载商品二级分类
	public ActionForward getParent(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("utf-8");

		if(request.getParameter("firstcategory")==null||request.getParameter("firstcategory").equals("")){
			String secondcategoryList = queryCategoryService.getSecondCategories(null);
			System.out.println(secondcategoryList);
			response.getWriter().print(secondcategoryList);
		}else{
			Category firstcategory = new Category();

			firstcategory.setCategoryid(Integer.parseInt(request.getParameter("firstcategory")));
			System.out.println("商品yi级分类"+request.getParameter("firstcategory"));
			String secondcategoryList = queryCategoryService.getSecondCategories(firstcategory);
			System.out.println(secondcategoryList);
			response.getWriter().print(secondcategoryList);
		}
		return null;
	}
	
	//生成订单
	public ActionForward addOrder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType("text/json;charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");

		String customerId = request.getParameter("customerId");
		Set<OrderItem>  orderItems=null; 
		orderItems=request.getSession().getAttribute(customerId)!=null?(Set<OrderItem>)request.getSession().getAttribute(customerId):null;

		Order order = new Order();
		Customer customer = new Customer();
		customer.setCustomerid(Integer.parseInt(customerId));
		order.setLCustomer(customer);
		order.setReceiveadd(customerInfoService.findCustomerById(Integer.parseInt(customerId)).getAddress());
		order.setReceiveperson(customerInfoService.findCustomerById(Integer.parseInt(customerId)).getCustomername());
		order.setReceivepersontel(customerInfoService.findCustomerById(Integer.parseInt(customerId)).getMobile());
		order.setReceivepersonzip(customerInfoService.findCustomerById(Integer.parseInt(customerId)).getCustomerzipcode());
		
		order.setLOrderitems(orderItems);

		if((request.getParameter("fukuanName")==null||request.getParameter("fukuanName").equals(""))
				&&(request.getParameter("fukuanAdd")==null||request.getParameter("fukuanAdd").equals(""))
				&&(request.getParameter("fukuanTel")==null||request.getParameter("fukuanTel").equals(""))
				&&(request.getParameter("fukuanPost")==null||request.getParameter("fukuanPost").equals(""))
				&&(request.getParameter("checkoutsubstation")==null||request.getParameter("checkoutsubstation").equals(""))){
			order.setOrdertype("新订");
		}else{			
			order.setPayer(request.getParameter("fukuanName"));
			order.setPayeradd(request.getParameter("fukuanAdd"));
			order.setPayertel(request.getParameter("fukuanTel"));
			order.setPayerzipcode(request.getParameter("fukuanPost"));

			Substation checkoutsubstation = null;
			if(request.getParameter("checkoutsubstation")!=null&&!request.getParameter("checkoutsubstation").equals("")){
				checkoutsubstation = new Substation();
				checkoutsubstation.setSubstationid(Integer.parseInt(request.getParameter("checkoutsubstation")));
			}
			order.setLSubstationByCheckoutsubstation(checkoutsubstation);
			
			order.setOrdertype("异地收费");
		}
		
		
		Substation deliversubstation = null;
		System.out.println(this.getClass()+" deliverSubstation1="+request.getParameter("deliverSubstation1"));
		if(request.getParameter("deliverSubstation1")!=null&&!request.getParameter("deliverSubstation1").equals("")){
			deliversubstation=new Substation();
			deliversubstation.setSubstationid(Integer.parseInt(request.getParameter("deliverSubstation1")));
		} 
		order.setLSubstationByDeliversubstation(deliversubstation); 
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		order.setLUser(user); 
		
		if(orderItems!=null&&orderItems.size()>0&&Date.valueOf(request.getParameter("date1")).before(Date.valueOf(request.getParameter("date")))){
			for(OrderItem orderItem:orderItems){
				orderItem.setLOrder(order);
			}
			order.setOrderdate(Date.valueOf(request.getParameter("date1")));
			order.setRequireddate(Date.valueOf(request.getParameter("date")));
			orderProductInfoService.addOrder(order);			
			String str = "{success:true,totalCount:2}";
			response.getWriter().print(str);
			request.getSession().removeAttribute(customerId);
		}else if(Date.valueOf(request.getParameter("date1")).after(Date.valueOf(request.getParameter("date")))){
			String str = "{success:false,totalCount:2,msg:'生成订单日期不能在完成日期之前，不能生成订单！'}";
			response.getWriter().print(str);
		}else{			
			String str = "{success:false,totalCount:2,msg:'没有订购商品，不能生成订单！'}";
			response.getWriter().print(str);
			request.getSession().removeAttribute(customerId);
		}
		
		return null;
	}

}



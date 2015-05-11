package com.neusoft.logistics.action.customerservice;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.service.inter.customermanage.IProductDetailService;
/**
 * ProductDetailAction
 * @author 罗荣博
 *
 */
public class ProductDetailAction extends DispatchAction{
	
	private IProductDetailService productDetailService;
	
	public IProductDetailService getProductDetailService() {
		return productDetailService;
	}

	public void setProductDetailService(IProductDetailService productDetailService) {
		this.productDetailService = productDetailService;
	}


	/**
	 * 查询订单中的商品信息
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return null
	 * @throws Exception
	 */
	public ActionForward findProductDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	   
	    Order order = new Order();
	    
	    //获得相应的orderId
	    int orderId = Integer.parseInt(request.getParameter("orderId"));
	 //   System.out.println("ProductDetailAction中的orderId为" + orderId);
	    
	    //根据相应的orderId查询商品详细信息
	    String productDetails = productDetailService.findProductDetails(orderId);
	   
	    response.getWriter().print(productDetails);
	    
		return null;
	}
}

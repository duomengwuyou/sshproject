package com.neusoft.logistics.action.dispatcherCenterManage.purchaseproduct;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.PurchaseInstorageOrder;
import com.neusoft.logistics.bean.PurchaseProductOrder;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IPurchaseProductService;
/**
 * PurchaseProductAction
 * @author 龚玉斌
 *
 */
public class PurchaseProductAction extends DispatchAction{
		private IPurchaseProductService purchaseProductService;
		
		public IPurchaseProductService getPurchaseProductService() {
			return purchaseProductService;
		}

		public void setPurchaseProductService(
				IPurchaseProductService purchaseProductService) {
			this.purchaseProductService = purchaseProductService;
		}

		public ActionForward doSearch(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			response.setContentType("text/json;charset=utf-8");
		    response.setCharacterEncoding("UTF-8");
		    request.setCharacterEncoding("UTF-8");
//		    String str="{success:true,totalCount:3,data:[" +
//		    		"{productId:'1',productName:'补水霜',firstCatergory:'化妆品',secondCategory:'御泥坊',unit:'瓶',remainQuantity:'50',warningQuantity:'9',maxQuantity：'12',shortageQuantity:'45',puchaseQuantity:'4556767'}" +
//		    		",{productId:'2',productName:'海飞丝',firstCatergory:'化妆品',secondCategory:'洗发露',unit:'瓶',remainQuantity:'40',warningQuantity:'9',maxQuantity：'12',shortageQuantity:'35',puchaseQuantity:'4556767'}" +
//		    		",{productId:'3',productName:'飘柔',firstCatergory:'化妆品',secondCategory:'洗发露',unit:'瓶',remainQuantity:'30',warningQuantity:'9',maxQuantity：'12',shortageQuantity:'25',puchaseQuantity:'4556767'}]}";
//		    
		    System.out.println("---"+this.getClass()+"--进货action开始--");
		    
//		    String rtn =purchaseProductService.getShortProductsTotal();
//		    System.out.println("rtn"+rtn);
		    response.getWriter().print(purchaseProductService.getShortProductsTotal());
		    System.out.println("---"+this.getClass()+"--进货action发送数据到前台结束-");
			return null;
		}
		
		/**
		 * 从页面获取数据生成进货单和购货单
		 * @param mapping
		 * @param form
		 * @param request
		 * @param response
		 * @return
		 * @throws Exception
		 */
		public ActionForward doToPurchaseProduct(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			response.setContentType("text/json;charset=utf-8");
		    response.setCharacterEncoding("UTF-8");
		    request.setCharacterEncoding("UTF-8");
		    
		    //从页面获取进货商品信息
		    String productIdsString = request.getParameter("purchaseProductIds");
		    String quantitysString = request.getParameter("purchaseQuantitys");
		    String datesString = request.getParameter("purchaseDates");
		    
		    System.out.println("----------进货前台传入的时间---"+datesString+"--------");
		    
		    String[] productIds = productIdsString.split(",");
		    String[] quantitys = quantitysString.split(",");
		    String[] dates = datesString.split(",");
		    
		    //将需要添加的信息加到lists中
		    List<PurchaseProductOrder> lists = new ArrayList<PurchaseProductOrder>();
		    PurchaseProductOrder p;
		    for(int i=0;i<productIds.length;i++){
		    	p=new PurchaseProductOrder();
		    	Product product=new Product();
		    	product.setProductid(Integer.parseInt(productIds[i]));
		    	p.setLProduct(product);
		    	p.setProductquantity(Integer.parseInt(quantitys[i]));
		    	p.setPurchaseDate(Date.valueOf(dates[i]));
		    	System.out.println("productid "+product.getProductid()+"  "+p.getProductquantity());
		    	lists.add(p);
		    }
		    System.out.println("生成进货单的antion中的 从页面获取的lists：的长度"+lists.size());
			
		    //调用服务层，生成进货单
		    purchaseProductService.addShortProductTotal(lists);
		    
		    //调用服务层，生成入库调拨单
		    purchaseProductService.addPurchaseProductInStorageOrder(lists);
			
		    //返回成功与否信息
			response.getWriter().print("{success:true,totalCount:0,data:[]}");
			return null;
		
	}
}

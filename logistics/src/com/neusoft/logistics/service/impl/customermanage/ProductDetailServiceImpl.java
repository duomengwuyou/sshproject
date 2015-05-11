package com.neusoft.logistics.service.impl.customermanage;

import java.util.Iterator;
import java.util.List;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.ShortageOrder;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.IOrderItemDAO;
import com.neusoft.logistics.dao.inter.IShortageOrderDAO;
import com.neusoft.logistics.service.inter.customermanage.IProductDetailService;
import com.neusoft.logistics.utils.JSONHelper;

/**
 * 实现订单中商品详细信息查询Service
 * @author 罗荣博
 *
 */
public class ProductDetailServiceImpl implements IProductDetailService {

	private IOrderItemDAO orderItemDAO;
	private IOrderDAO orderDAO;
	private IShortageOrderDAO shortageOrderDAO;

	public IShortageOrderDAO getShortageOrderDAO() {
		return shortageOrderDAO;
	}

	public void setShortageOrderDAO(IShortageOrderDAO shortageOrderDAO) {
		this.shortageOrderDAO = shortageOrderDAO;
	}

	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	public IOrderItemDAO getOrderItemDAO() {
		return orderItemDAO;
	}

	public void setOrderItemDAO(IOrderItemDAO orderItemDAO) {
		this.orderItemDAO = orderItemDAO;
	}

	/**
	 * 根据订单号查询订单中的商品信息
	 */
	public String findProductDetails(int orderId){

		Order order = orderDAO.findById(orderId); 

 
		if(order == null){
			return null;
		}else{

			List<OrderItem> orderItems = orderItemDAO.findByProperty("LOrder", order);
			System.out.println("PS的orderItems大小为:"+orderItems.size());

		/*	for(int i = 0; i< orderItems.size(); i++){

				System.out.println("orderItem对应的orderID为："+orderItems.get(i).getLOrder().getOrderid());
			}
*/

			if(orderItems.size() == 0){
				return null;
			}else{

				JSONHelper json = new JSONHelper();
				json.setSuccess(true);

				for(OrderItem orderItem1:orderItems){
					json.AddItem("productId", Integer.toString(orderItem1.getLProduct().getProductid()));
					json.AddItem("parentCategory", orderItem1.getLProduct().getLCategory().getCategoryname());
					json.AddItem("category", orderItem1.getLProduct().getLCategory().getLCategory().getCategoryname());
					json.AddItem("productName", orderItem1.getProductname());
					json.AddItem("originalPrice", Double.toString(orderItem1.getOriginalprice()));
					json.AddItem("unit", orderItem1.getUnit());
					json.AddItem("productRemark", orderItem1.getProductremark());
					json.AddItem("orderItemAmount", Integer.toString(orderItem1.getOrderitemamount()));
					json.AddItem("totalPrice", Double.toString(orderItem1.getOrderitemamount()*orderItem1.getLProduct().getOriginalprice()));
					ShortageOrder so= shortageOrderDAO.getShortageByProductAndOrder(orderItem1.getLOrder(),orderItem1.getLProduct());
					if(so!=null){
						json.AddItem("orderState", so.getShortagestate());
						
					}else{
						json.AddItem("orderState", "可分配");
					}
					json.ItemOK();
				}
				String jsonss = json.toString();
				//System.out.println("findProductDetails中的jsonss为："+jsonss);
				return jsonss;
			}
		}
	}
 
}

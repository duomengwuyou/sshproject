package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.neusoft.logistics.bean.FeedBackOrder;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.dao.inter.IOrderItemDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.ITopHotProducts;
import com.neusoft.logistics.utils.JSONHelper;

public class TopHotProductsService implements ITopHotProducts {

	private IOrderItemDAO orderItemDAO;
	public String getTopHotProducts() {
		// TODO Auto-generated method stub
		//调用数据库 获得排在前五的商品
		//将商品信息加到jason中去
		//返回
		List<Product> lists=orderItemDAO.getTopHotProducts();
		JSONHelper json=new JSONHelper();
		json.setSuccess(true);
		
		int i=1;
		for(Product p:lists){
			json.AddItem("rank",String.valueOf(i++));
			json.AddItem("productId", String.valueOf(p.getProductid()));
			json.AddItem("productName", p.getProductname());
			json.ItemOK();
		}
		return json.toString();
	}

	public IOrderItemDAO getOrderItemDAO() {
		return orderItemDAO;
	}

	public void setOrderItemDAO(IOrderItemDAO orderItemDAO) {
		this.orderItemDAO = orderItemDAO;
	}

	public String getTopHotProductsByTime(String startTime, String endTime) {
		
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
//		Date begin=new Date(0);
//		Date end=new Date(Long.MAX_VALUE);
// 
//		if(startTime!=null&&!startTime.equals("")){ 
//			begin=Date.valueOf(startTime);  
//		} 
//		if(endTime!=null&&!endTime.equals("")){  
//			end=Date.valueOf(endTime);	 
//		}
		
		//调用数据库 获得在该短时间里排在前五的商品
		List<Product> listsProduct = orderItemDAO.getTopHotProductsByTime(startTime, endTime);
	
		//将商品信息加到jason中去
		int i=1;
		for(Product p:listsProduct){
			json.AddItem("rank",String.valueOf(i++));
			json.AddItem("productId", String.valueOf(p.getProductid()));
			json.AddItem("productName", p.getProductname());
			json.ItemOK();
		}
		//返回
		return json.toString();
		
		
	}

}

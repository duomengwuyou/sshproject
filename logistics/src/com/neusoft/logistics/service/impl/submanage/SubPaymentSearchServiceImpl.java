package com.neusoft.logistics.service.impl.submanage;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.service.inter.submanage.ISubPaymentSearchService;
import com.neusoft.logistics.utils.JSONHelper;

public class SubPaymentSearchServiceImpl implements ISubPaymentSearchService{
	private ITaskOrderDAO taskOrderDao;
	private IOrderDAO orderDao;
	/**
	 * 得到商品统计信息
	 */
	public String getAllSubProductsStatistics(Substation substation,String start, String end, String productid) {
		List<TaskOrder> tasks = taskOrderDao.listTaksOrdersBySubstation(substation,start,end);
		List<OrderItem> items = new ArrayList<OrderItem>();
		
		//得到所有的预定条目
		for(TaskOrder t : tasks){
			for(Iterator<OrderItem> i = t.getLOrder().getLOrderitems().iterator(); i.hasNext();){
				items.add(i.next());
			}
		}
		JSONHelper json = new JSONHelper();
		 json.setSuccess(true);
		 boolean sign = false;
		 int j = 0;
		//传入的商品如果为空，返回所有商品的统计信息
		if(productid==null || productid ==""){
			 for(OrderItem o : items){
				 json.AddItem("id", String.valueOf(j));
				 json.AddItem("productId", String.valueOf(o.getLProduct().getProductid()));
				 json.AddItem("productName", o.getLProduct().getProductname());
				 json.AddItem("category_second", o.getSecondcategory());
				 json.AddItem("category_first", o.getFirstcatergory());
				 json.AddItem("sendAmount", String.valueOf(o.getOrderitemamount()));
				 json.AddItem("ordertype", o.getLOrder().getOrdertype());
				 json.AddItem("payState", "成功付款");
				 json.AddItem("totalGet", String.valueOf(o.getOriginalprice()*o.getOrderitemamount()));
				 json.AddItem("totalReturn", "0");
				 json.ItemOK();
				 sign = true;
				 j++;
			 }
		}else{
			//传入的商品信息不为空，返回特定商品信息	
			for(OrderItem o : items){
				if(o.getLProduct().getProductid() == Integer.parseInt(productid)){
					json.AddItem("id", String.valueOf(j));
					 json.AddItem("productId", String.valueOf(o.getLProduct().getProductid()));
					 json.AddItem("productName", o.getLProduct().getProductname());
					 json.AddItem("category_second", o.getSecondcategory());
					 json.AddItem("category_first", o.getFirstcatergory());
					 json.AddItem("sendAmount", String.valueOf(o.getOrderitemamount()));
					 json.AddItem("ordertype", o.getLOrder().getOrdertype());
					 json.AddItem("payState", "成功收款");
					 json.AddItem("totalGet", String.valueOf(o.getOriginalprice()*o.getOrderitemamount()));
					 json.AddItem("totalReturn", "0");
					// json.AddItem("totalStatistics", value);
					 json.ItemOK();
					 sign = true;
					 j++;
				}
			 }
		}
		//["productId","productName","category_second","category_first","sendAmount","payState","totalGet","totalReturn"];
	
		 String jsons = "";
		 if(sign){
			jsons = json.toString();
		 }else {
			jsons = "{success : true,data:[]}";
		 }
		return jsons;
	}

	public ITaskOrderDAO getTaskOrderDao() {
		return taskOrderDao;
	}

	public void setTaskOrderDao(ITaskOrderDAO taskOrderDao) {
		this.taskOrderDao = taskOrderDao;
	}

	public IOrderDAO getOrderDao() {
		return orderDao;
	}

	public void setOrderDao(IOrderDAO orderDao) {
		this.orderDao = orderDao;
	}

}

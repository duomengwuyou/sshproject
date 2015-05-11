package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.Warehouse;

public interface IOrderItemDAO extends IBaseDAO<OrderItem> {
	/**
	 * 根据商品名称和库房名称查询已领货的数量
	 * 
	 */
	public int getAllocatedQuantity(Product product, Warehouse warehouse);


	public List<Product> getTopHotProducts();
	public List<Product> getTopHotProductsByTime(String startTime, String endTime);

	/**
	 * 根据orderId查询order所对应的所有的orderItem
	 * @param id
	 * @return
	 */
	public List<OrderItem> findOrderItemByOrderId(int id); 

}

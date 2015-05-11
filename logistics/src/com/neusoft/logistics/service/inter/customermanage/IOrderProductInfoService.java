package com.neusoft.logistics.service.inter.customermanage;

import java.util.List;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.Substation;

public interface IOrderProductInfoService {

	public String getAllProducts();
	public String substationToJSON(List<Substation> substationList);
	public String findAllSubstation();
	public Product findProductById(int id);
	public String findProductByCategory(Category category);
	public void addOrder(Order order);  
}

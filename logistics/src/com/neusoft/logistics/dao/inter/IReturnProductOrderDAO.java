package com.neusoft.logistics.dao.inter;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.ReturnProductOrder;
import com.neusoft.logistics.bean.Warehouse;

public interface IReturnProductOrderDAO extends IBaseDAO<ReturnProductOrder> {
	/**
	 * 根据产品和库房来获得退回商品的总数量
	 * **/
	public int getReturnQuantityByProductAndWarehouse(Product product,
			Warehouse warehouse);
	

}

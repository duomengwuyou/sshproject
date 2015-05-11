package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.ShortageOrder;

public interface IShortageOrderDAO extends IBaseDAO<ShortageOrder> {

	List<ShortageOrder> findShortItemsByDateAscAndNotSolved();

	public ShortageOrder getShortageByProductAndOrder(Order order, Product product);

}

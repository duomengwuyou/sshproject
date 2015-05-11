package com.neusoft.logistics.dao.inter;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.SubstationInStorageOrder;
import java.sql.Date;
import java.util.List;
import com.neusoft.logistics.bean.SubstationInStorageOrderItem;

public interface ISubstationInStorageOrderItemDAO extends
		IBaseDAO<SubstationInStorageOrderItem> {
	/**
	 * 根据分站入库单号和产品获取分站入库单条目
	 * @param product
	 * @param substationInStorageOrder
	 * @return SubstationInStorageOrderItem
	 */
	public SubstationInStorageOrderItem findByProductSubstationInStorageOrder(Product product,SubstationInStorageOrder substationInStorageOrder);
	/**
	 * @see IOutStorageOrderItemDAO#findOutStorageOrder(Date, Date, String)
	 * **/
	public 	List<SubstationInStorageOrderItem> findInStorageOrder(Date begin, Date end, String product);
}

package com.neusoft.logistics.dao.inter;

import java.sql.Date;
import java.util.List;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;

public interface IPurchaseInStorageOrderItemDAO extends
IBaseDAO<PurchaseInStorageOrderItem> {
	/**
	 *注释 @see IOutStorageOrderItemDAO#findOutStorageOrder(Date, Date, String)
	 * **/
	public  List<PurchaseInStorageOrderItem> getItemsByPurchaseProductInStorageOrderId(int purchaseProductInStorageOrderId);
	public	List<PurchaseInStorageOrderItem> findPurchaseInStorageOrder(Date begin, Date end, String product);

	/**
	 * 获得已经订购还未到货的购货单条目
	 * **/
	public List<PurchaseInStorageOrderItem> getPurchasedProduct(Product product);

}

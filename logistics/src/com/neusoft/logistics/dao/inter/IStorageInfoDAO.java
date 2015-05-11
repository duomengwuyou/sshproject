package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Warehouse;

public interface IStorageInfoDAO extends IBaseDAO<StorageInfo> {
	/**
	 * 根据商品名字搜索储存信息，productName为空时，查询所有的存储信息
	 * **/
	public List<StorageInfo> findStorageInfoByProductName(String productName);
	/**
	 * 根据商品名字和库房名字搜索储存信息，productName和warehouseName为空时，查询所有的存储信息，其中一个为空时，按照另一个查询
	 * **/
	public List<StorageInfo> findStorageInfoByProductNameAndWarehouseName(
			String productName, String warehouseName); 
    /**
     * 根据商品查找库存
     * @param product
     * @return
     */
	public StorageInfo getStorageInfoByProduct(Product product,Warehouse warehouse); 
	public  List<StorageInfo> findStorageInfoByWarehouseProduct(Warehouse warehouse,Product product);
	/** 根据库房擦好找储存信息***/
	public List<StorageInfo> findByWarehouse(Warehouse warehouse);
	public StorageInfo getStorageInfoByProduct(Product product); 
}

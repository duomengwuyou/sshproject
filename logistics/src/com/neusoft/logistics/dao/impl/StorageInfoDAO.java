package com.neusoft.logistics.dao.impl;
//default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;

/**
 * Data access object (DAO) for domain model class StorageInfo.
 * @see .StorageInfo
 * @author MyEclipse Persistence Tools 
 */

public class StorageInfoDAO extends BaseHibernateDAO<StorageInfo> implements  IStorageInfoDAO{
	public StorageInfoDAO( ) {
		super(log, StorageInfo.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(StorageInfoDAO.class);
	//property constants
	public static final String WARNINGQUANTITY = "warningquantity";
	public static final String MAXQUANTITY = "maxquantity";
	public static final String REMAINQUANTITY = "remainquantity";


	public List<StorageInfo> findByWarningquantity(Object warningquantity) {
		return findByProperty(WARNINGQUANTITY, warningquantity);
	}

	public List<StorageInfo> findByMaxquantity(Object maxquantity) {
		return findByProperty(MAXQUANTITY, maxquantity);
	}

	public List<StorageInfo> findByRemainquantity(Object remainquantity) {
		return findByProperty(REMAINQUANTITY, remainquantity);
	}
	public StorageInfo getStorageInfoByProduct(Product product,Warehouse warehouse){
		List<StorageInfo> storageInfos=this.getSession().createQuery("from StorageInfo where LProduct=:product and LWarehouse=:warehouse").setEntity("product", product).setEntity("warehouse", warehouse).list();
		System.out.println(this.getClass()+" storageInfos.size="+storageInfos.size());
		return (storageInfos!=null&&storageInfos.size()>0)?storageInfos.get(0):null;
	}

	public List<StorageInfo> findStorageInfoByProductName(String productName) {
		// TODO Auto-generated method stub
		return productName==null?this.findAll():this.getSession().createQuery("from StorageInfo where LProduct.productname like :productname").setString("productname", "%"+productName+"%").list();
	}
	public List<StorageInfo> findStorageInfoByProductNameAndWarehouseName(
			String productName, String warehouseName) {
		if(productName!=null&&warehouseName!=null)
			return this.getSession().createQuery("from StorageInfo where LProduct.productname like :productname and LWarehouse.warehousename like :warehousename").setString("productname", "%"+productName+"%").setString("warehousename", "%"+warehouseName+"%").list();
		else if(productName!=null&&warehouseName==null)
			return this.getSession().createQuery("from StorageInfo where LProduct.productname like :productname").setString("productname", "%"+productName+"%").list();
		else if(productName==null&&warehouseName!=null)
			return this.getSession().createQuery("from StorageInfo where LWarehouse.warehousename like :warehousename").setString("warehousename", "%"+warehouseName+"%").list();
			return this.findAll();
	}
	public List<StorageInfo> findStorageInfoByWarehouseProduct(Warehouse warehouse,Product product){
		return this.getSession().createQuery("from StorageInfo s where s.LWarehouse =:warehouse and s.LProduct =:product").setEntity("warehouse", warehouse).setEntity("product", product).list();
	}

	public List<StorageInfo> findByWarehouse(Warehouse warehouse) {
		// TODO Auto-generated method stub
		return this.getSession().createQuery("from StorageInfo where LWarehouse=:warehouse").setEntity("warehouse", warehouse).list();
	}

	public StorageInfo getStorageInfoByProduct(Product product) {
		// TODO Auto-generated method stub
		List<StorageInfo> sis=this.getSession().createQuery("from StorageInfo where LWarehouse.warehousetype=:type and LProduct=:product").setString("type", "中心库房").setEntity("product", product).list();
		
		return (sis!=null&sis.size()>0)?sis.get(0):null;
	}
}
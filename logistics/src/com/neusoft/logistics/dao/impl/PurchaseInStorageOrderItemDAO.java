package com.neusoft.logistics.dao.impl;
//default package

import java.sql.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;
import com.neusoft.logistics.bean.PurchaseInstorageOrder;
import com.neusoft.logistics.dao.inter.IPurchaseInStorageOrderItemDAO;

/**
 * Data access object (DAO) for domain model class PurchaseInStorageOrderItem.
 * @see .PurchaseInStorageOrderItem
 * @author MyEclipse Persistence Tools 
 */

public class PurchaseInStorageOrderItemDAO extends BaseHibernateDAO<PurchaseInStorageOrderItem> implements IPurchaseInStorageOrderItemDAO  {
	public PurchaseInStorageOrderItemDAO( ) {
		super(log, PurchaseInStorageOrderItem.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(PurchaseInStorageOrderItemDAO.class);
	//property constants
	public static final String REALPURCHASEQUANTITY = "realpurchasequantity";
	public static final String ORDERITEMID = "purchaseProductInStorageOrder";


	public List<PurchaseInStorageOrderItem> findByRealpurchasequantity(Object realpurchasequantity) {
		return findByProperty(REALPURCHASEQUANTITY, realpurchasequantity);
	}



	public List<PurchaseInStorageOrderItem> findPurchaseInStorageOrder(
			Date begin, Date end, String product) {
		// TODO Auto-generated method stub
		if(begin==null&&end==null&&product!=null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where LProduct.productname like :productname").setString("productname", "%"+product+"%").list();
		else if(begin!=null&&end==null&&product!=null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where LProduct.productname like :productname and LPurchaseinstorageorder.purchasedate>=:begin").setString("productname", "%"+product+"%").setDate("begin", begin).list();
		else if(begin==null&&end!=null&&product!=null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where LProduct.productname like :productname and LPurchaseinstorageorder.purchasedate<=:end").setString("productname", "%"+product+"%").setDate("end", end).list();
		else if(begin!=null&&end!=null&&product!=null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where LProduct.productname like :productname and LPurchaseinstorageorder.purchasedate>=:begin and LPurchaseinstorageorder.purchasedate<=:end").setString("productname", "%"+product+"%").setDate("begin", begin).setDate("end", end).list();
		else if(begin!=null&&end==null&&product==null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where  LPurchaseinstorageorder.purchasedate>=:begin").setDate("begin", begin).list();
		else if(begin==null&&end!=null&&product==null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where LPurchaseinstorageorder.purchasedate<=:end").setDate("end", end).list();
		else if(begin!=null&&end!=null&&product==null)
			return this.getSession().createQuery("from PurchaseInStorageOrderItem where  LPurchaseinstorageorder.purchasedate>=:begin and LPurchaseinstorageorder.purchasedate<=:end").setDate("begin", begin).setDate("end", end).list();
		// TODO Auto-generated method stub
		return this.findAll();
	}


	public List<PurchaseInStorageOrderItem> getItemsByPurchaseProductInStorageOrderId(int purchaseProductInStorageOrderId){
		PurchaseInstorageOrder purchaseInstorageOrder = new PurchaseInstorageOrder();
		purchaseInstorageOrder.setPurchaseinstorageorderid(purchaseProductInStorageOrderId);
		return this.getSession().createQuery("from PurchaseInStorageOrderItem where LPurchaseinstorageorder=:purchaseInstorageOrder").setEntity("purchaseInstorageOrder",purchaseInstorageOrder).list();
	}



	/*public List<PurchaseInStorageOrderItem> getItemsByHasAllocatted() {
		// TODO Auto-generated method stub
		return this.getSession().createQuery("from PurchaseInStorageOrderItem where LPurchaseinstorageorder.productpurchasestate=:productpurchasestate").setString("productpurchasestate", "");
	}
*/
     
	
	

	public List<PurchaseInStorageOrderItem> getPurchasedProduct(Product product) {
		// TODO Auto-generated method stub
		return this.getSession().createQuery("from PurchaseInStorageOrderItem where LProduct=:product and LPurchaseinstorageorder.productpurchasestate=:state").setEntity("product", product).setString("state", "未到货").list();
	}



}
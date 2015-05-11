package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.PurchaseProductOrder;
import com.neusoft.logistics.dao.inter.IPurchaseProductOrderDAO;

/**
 * Data access object (DAO) for domain model class PurchaseProductOrder.
 * @see .PurchaseProductOrder
  * @author MyEclipse Persistence Tools 
 */

public class PurchaseProductOrderDAO extends BaseHibernateDAO<PurchaseProductOrder> implements IPurchaseProductOrderDAO  {
    public PurchaseProductOrderDAO( ) {
		super(log, PurchaseProductOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(PurchaseProductOrderDAO.class);
	//property constants
	public static final String PRODUCTQUANTITY = "productquantity";
	public static final String PURCHASEREMARK = "purchaseremark";


     

	public List<PurchaseProductOrder> findByProductquantity(Object productquantity) {
		return findByProperty(PRODUCTQUANTITY, productquantity);
	}
	
	public List<PurchaseProductOrder> findByPurchaseremark(Object purchaseremark) {
		return findByProperty(PURCHASEREMARK, purchaseremark);
	}
	
 
}
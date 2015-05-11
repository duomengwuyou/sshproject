package com.neusoft.logistics.dao.impl;
//default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;
import com.neusoft.logistics.bean.PurchaseInstorageOrder;
import com.neusoft.logistics.bean.ShortageOrder;
import com.neusoft.logistics.dao.inter.IPurchaseInstorageOrderDAO;

/**
 * Data access object (DAO) for domain model class PurchaseInstorageOrder.
 * @see .PurchaseInstorageOrder
 * @author MyEclipse Persistence Tools 
 */

public class PurchaseInstorageOrderDAO extends BaseHibernateDAO<PurchaseInstorageOrder> implements IPurchaseInstorageOrderDAO  {
	public PurchaseInstorageOrderDAO( ) {
		super(log, PurchaseInstorageOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(PurchaseInstorageOrderDAO.class);
	//property constants
	public static final String PRODUCTPURCHASESTATE = "productpurchasestate";
	public static final String PUCHASEREMARK = "puchaseremark";
	public List<PurchaseInstorageOrder> findByProductpurchasestate(Object productpurchasestate) {
		return findByProperty(PRODUCTPURCHASESTATE, productpurchasestate);
	}
	public List<PurchaseInstorageOrder> findByPuchaseremark(Object puchaseremark) {
		return findByProperty(PUCHASEREMARK, puchaseremark);
	}
	public void setHasFinished(PurchaseInstorageOrder purchaseInstorageOrder) {
		this.getSession().createSQLQuery("update SCOTT.L_PURCHASEINSTORAGEORDER　Set  PRODUCTPURCHASESTATE='已调拨' Where purchaseinstorageorderid="+purchaseInstorageOrder.getPurchaseinstorageorderid()).executeUpdate();
	}
}
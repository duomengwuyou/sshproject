package com.neusoft.logistics.dao.impl;
//default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.CancelOrder;
import com.neusoft.logistics.dao.inter.ICancelOrderDAO;

/**
 * Data access object (DAO) for domain model class CancelOrder.
 * @see .CancelOrder
 * @author MyEclipse Persistence Tools 
 */

public class CancelOrderDAO extends BaseHibernateDAO<CancelOrder> implements ICancelOrderDAO  {
	public CancelOrderDAO() {
		super(log, CancelOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(CancelOrderDAO.class);
	//property constants
	public static final String CANCELREASON = "cancelreason";

 

	public CancelOrder findById( java.lang.Long id) {
		log.debug("getting CancelOrder instance with id: " + id);
		try {
			CancelOrder instance = (CancelOrder) getSession()
			.get("CancelOrder", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}


	public List<CancelOrder> findByCancelreason(Object cancelreason) {
		return findByProperty(CANCELREASON, cancelreason);
	}



}
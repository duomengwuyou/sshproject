package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.OutStorageOrder;
import com.neusoft.logistics.dao.inter.IOutStorageOrderDAO;

/**
 * Data access object (DAO) for domain model class OutStorageOrder.
 * @see .OutStorageOrder
  * @author MyEclipse Persistence Tools 
 */

public class OutStorageOrderDAO extends BaseHibernateDAO<OutStorageOrder> implements IOutStorageOrderDAO  {
    public OutStorageOrderDAO() {
		super(log, OutStorageOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(OutStorageOrderDAO.class);
	//property constants
	public static final String OUTSTORAGEREMARK = "outstorageremark";

 
	public List<OutStorageOrder> findByOutstorageremark(Object outstorageremark) {
		return findByProperty(OUTSTORAGEREMARK, outstorageremark);
	}
	 
}
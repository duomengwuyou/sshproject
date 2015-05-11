package com.neusoft.logistics.dao.impl;
// default package

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.TakeProductOrder;
import com.neusoft.logistics.dao.inter.ITakeProductOrderDAO;

/**
 * Data access object (DAO) for domain model class TakeProductOrder.
 * @see .TakeProductOrder
  * @author MyEclipse Persistence Tools 
 */

public class TakeProductOrderDAO extends BaseHibernateDAO<TakeProductOrder> implements ITakeProductOrderDAO  {
    public TakeProductOrderDAO( ) {
		super(log, TakeProductOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(TakeProductOrderDAO.class);
	//property constants

 
}
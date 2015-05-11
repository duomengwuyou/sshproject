package com.neusoft.logistics.dao.impl;
//default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.ChangeProductOrder;
import com.neusoft.logistics.dao.inter.IChangeProductOrderDAO;

/**
 * Data access object (DAO) for domain model class ChangeProductOrder.
 * @see .ChangeProductOrder
 * @author MyEclipse Persistence Tools 
 */

public class ChangeProductOrderDAO extends BaseHibernateDAO<ChangeProductOrder> implements IChangeProductOrderDAO  {
	public ChangeProductOrderDAO() {
		super(log, ChangeProductOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(ChangeProductOrderDAO.class);
	//property constants
	public static final String CHANGEQUANTITY = "changequantity";
	public static final String CHANGEREASON = "changereason";

	public List<ChangeProductOrder> findByChangequantity(Object changequantity) {
		return findByProperty(CHANGEQUANTITY, changequantity);
	}

	public List<ChangeProductOrder> findByChangereason(Object changereason) {
		return findByProperty(CHANGEREASON, changereason);
	}


}
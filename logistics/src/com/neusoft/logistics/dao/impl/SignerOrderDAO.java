package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.SignerOrder;
import com.neusoft.logistics.dao.inter.ISignerOrderDAO;

/**
 * Data access object (DAO) for domain model class SignerOrder.
 * @see .SignerOrder
  * @author MyEclipse Persistence Tools 
 */

public class SignerOrderDAO extends BaseHibernateDAO<SignerOrder> implements ISignerOrderDAO  {
    public SignerOrderDAO( ) {
		super(log, SignerOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(SignerOrderDAO.class);
	//property constants
	public static final String CUSTOMERSIGNATURE = "customersignature";
	public static final String CUSTOMERFEEDBACK = "customerfeedback";
	public static final String SIGNEDORDERREMARK = "signedorderremark";
	public static final String DELIVERREQIUREMENT = "deliverreqiurement";

 
	public List<SignerOrder> findByCustomersignature(Object customersignature) {
		return findByProperty(CUSTOMERSIGNATURE, customersignature);
	}
	
	public List<SignerOrder> findByCustomerfeedback(Object customerfeedback) {
		return findByProperty(CUSTOMERFEEDBACK, customerfeedback);
	}
	
	public List<SignerOrder> findBySignedorderremark(Object signedorderremark) {
		return findByProperty(SIGNEDORDERREMARK, signedorderremark);
	}
	
	public List<SignerOrder> findByDeliverreqiurement(Object deliverreqiurement) {
		return findByProperty(DELIVERREQIUREMENT, deliverreqiurement);
	}
	 
}
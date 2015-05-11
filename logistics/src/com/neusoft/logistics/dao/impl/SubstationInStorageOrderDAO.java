package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.DispatchOrder;
import com.neusoft.logistics.bean.SubstationInStorageOrder;
import com.neusoft.logistics.dao.inter.ISubstationInStorageOrderDAO;

/**
 * Data access object (DAO) for domain model class SubstationInStorageOrder.
 * @see .SubstationInStorageOrder
  * @author MyEclipse Persistence Tools 
 */

public class SubstationInStorageOrderDAO extends BaseHibernateDAO<SubstationInStorageOrder> implements ISubstationInStorageOrderDAO {
    public SubstationInStorageOrderDAO( ) {
		super(log, SubstationInStorageOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(SubstationInStorageOrderDAO.class);
	//property constants
	public static final String INSTORAGEREMARK = "instorageremark";

 

	public List<SubstationInStorageOrder> findByInstorageremark(Object instorageremark) {
		return findByProperty(INSTORAGEREMARK, instorageremark);
	}
	public SubstationInStorageOrder findByDispatchorder(DispatchOrder dispatchorder){
		List<SubstationInStorageOrder> list = this.getSession().createQuery("from SubstationInStorageOrder s where s.LDispatchorder = :dispatchorder").setEntity("dispatchorder", dispatchorder).list();
		if(list.size()!=0){
			return list.get(0);
		}
		return null;
	}
}
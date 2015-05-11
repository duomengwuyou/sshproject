package com.neusoft.logistics.dao.impl;

// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.DispatchOrder;
import com.neusoft.logistics.dao.inter.IDispatchOrderDAO;

/**
 * Data access object (DAO) for domain model class DispatchOrder.
 * @see .DispatchOrder
  * @author MyEclipse Persistence Tools 
 */

public class DispatchOrderDAO extends BaseHibernateDAO<DispatchOrder>  implements IDispatchOrderDAO  {
    public DispatchOrderDAO( ) {
		super(log, DispatchOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(DispatchOrderDAO.class);
	//property constants
	public static final String DIPATCHORDERREMARK = "dipatchorderremark";


    
    
    public DispatchOrder findById( java.lang.Integer id) {
        log.debug("getting DispatchOrder instance with id: " + id);
        try {
            DispatchOrder instance = (DispatchOrder) getSession()
                    .get("DispatchOrder", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
    
    
	public List<DispatchOrder> findByDipatchorderremark(Object dipatchorderremark) {
		return findByProperty(DIPATCHORDERREMARK, dipatchorderremark);
	}
	
 
 
}
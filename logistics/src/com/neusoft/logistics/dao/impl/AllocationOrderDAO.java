package com.neusoft.logistics.dao.impl;
//default package

import java.sql.Date;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.neusoft.logistics.bean.AllocationOrder;
import com.neusoft.logistics.dao.inter.IAllocationOrderDAO;

/**
 * Data access object (DAO) for domain model class AllocationOrder.
 * @see .AllocationOrder
 * @author MyEclipse Persistence Tools 
 */

public class AllocationOrderDAO extends BaseHibernateDAO<AllocationOrder> implements IAllocationOrderDAO  {


	private static final Log log = LogFactory.getLog(AllocationOrderDAO.class);
	//property constants
	public static final String ALLOCATIONSTATE = "allocationstate";

	public AllocationOrderDAO() {
		super(log,AllocationOrder.class);
		// TODO Auto-generated constructor stub
	}

	public List<AllocationOrder> findByAllocationstate(Object allocationstate) {
		return findByProperty(ALLOCATIONSTATE, allocationstate);
	}
	public List<AllocationOrder> getAllocationOrderByDate(Date allocationdate){
		List<AllocationOrder> items;
		items = this.getSession().createQuery("from AllocationOrder where LOrder.requireddate <= :allocationdate").setDate("allocationdate", allocationdate).list();
		return items;
	}
}
package com.neusoft.logistics.dao.impl;
//default package

import java.sql.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.FeedBackOrder;
import com.neusoft.logistics.dao.inter.IFeedBackOrderDAO;

/**
 * Data access object (DAO) for domain model class FeedBackOrder.
 * @see .FeedBackOrder
 * @author MyEclipse Persistence Tools 
 */

public class FeedBackOrderDAO extends BaseHibernateDAO<FeedBackOrder> implements IFeedBackOrderDAO{

	public FeedBackOrderDAO() {
		super(log, FeedBackOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(FeedBackOrderDAO.class);
	//property constants
	public static final String TASKSTATE = "taskstate";
	public static final String SATISFACTION = "satisfaction";
	public static final String FEEDBACKREMARK = "feedbackremark";




	public List<FeedBackOrder> findByTaskstate(Object taskstate) {
		return findByProperty(TASKSTATE, taskstate);
	}

	public List<FeedBackOrder> findBySatisfaction(Object satisfaction) {
		return findByProperty(SATISFACTION, satisfaction);
	}

	public List<FeedBackOrder> findByFeedbackremark(Object feedbackremark) {
		return findByProperty(FEEDBACKREMARK, feedbackremark);
	}

	public List<FeedBackOrder> findByTime(Date begin, Date end) {
		// TODO Auto-generated method stub

		if(begin!=null&&end==null)
			return this.getSession().createQuery("from FeedBackOrder " +
			"where  taskorder.operatedate>=:begin").setDate("begin", begin).list();
		else  if(begin==null&&end!=null)
			return this.getSession().createQuery("from FeedBackOrder " +
			"where  taskorder.operatedate<=:end").setDate("end", end).list();
		else if(begin!=null&&end!=null)
			return this.getSession().createQuery("from FeedBackOrder " +
			"where  taskorder.operatedate>=:begin and taskorder.operatedate<=:end").setDate("begin", begin).setDate("end", end).list();
		return this.findAll();

	}



}
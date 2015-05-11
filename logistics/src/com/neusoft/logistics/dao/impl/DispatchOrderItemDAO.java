package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.DispatchOrderItem;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IDispatchOrderItemDAO;

/**
 * Data access object (DAO) for domain model class DispatchOrderItem.
 * @see .DispatchOrderItem
 * @author 周诗龙 
 * 分发单条目管理DAO
 */

public class DispatchOrderItemDAO extends BaseHibernateDAO<DispatchOrderItem> implements IDispatchOrderItemDAO {
    public DispatchOrderItemDAO() {
		super(log, DispatchOrderItem.class);
		// TODO Auto-generated constructor stub
	}


	private static final Log log = LogFactory.getLog(DispatchOrderItemDAO.class);
	//property constants
	public static final String PRODUCTQUANTITY = "productquantity";
	public static final String DISPATCHORDER = "dispatchorder";

 	public List<DispatchOrderItem> findByProductquantity(Object productquantity) {
		return findByProperty(PRODUCTQUANTITY, productquantity);
	}
 	public List<DispatchOrderItem> findByDispatchOrderId(int dispatchOrderId){
 		return findByProperty(DISPATCHORDER,dispatchOrderId);
 	}
// 	public List<DispatchOrderItem> findAllDispatchOrder() throws Exception{
// 		System.out.println("===================进入了findAllDispatchOrder开始=====================");
// 		List results = this.getSession().createQuery("from DispatchOrderItem").list();
// 		System.out.println("===================进入了findAllDispatchOrder进行了查询操作，查询结果有 "+results.size()+" 个=====================");
// 		if(results.size()!=0){
//			return results;
//		}else{
//			return null;
//		}
// 	}
}
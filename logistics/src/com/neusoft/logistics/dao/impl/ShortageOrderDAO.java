package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.ShortageOrder;
import com.neusoft.logistics.dao.inter.IShortageOrderDAO;

/**
 * Data access object (DAO) for domain model class ShortageOrder.
 * @see .ShortageOrder
  * @author MyEclipse Persistence Tools 
 */

public class ShortageOrderDAO extends BaseHibernateDAO<ShortageOrder> implements IShortageOrderDAO  {
    public ShortageOrderDAO( ) {
		super(log, ShortageOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(ShortageOrderDAO.class);
	//property constants
	public static final String SHORTAGEQUANTITY = "shortagequantity";
	public static final String SHORTAGESTATE = "shortagestate";


     

	public List<ShortageOrder> findByShortagequantity(Object shortagequantity) {
		return findByProperty(SHORTAGEQUANTITY, shortagequantity);
	}
	
	public List<ShortageOrder> findByShortagestate(Object shortagestate) {
		return findByProperty(SHORTAGESTATE, shortagestate);
	}

	public List<ShortageOrder> findShortItemsByDateAscAndNotSolved() {
		return this.getSession().createQuery("from ShortageOrder where shortagestate=:shortagestate order by LOrder.requireddate asc").setString("shortagestate", "缺货").list();
	}

	public ShortageOrder getShortageByProductAndOrder(Order order,
			Product product) {//and shortagestate=:state
		List<ShortageOrder> sos=this.getSession().createQuery("from ShortageOrder where LOrder=:order and LProduct=:product ").setEntity("order", order).setEntity("product", product).list();
		// TODO Auto-generated method stub
		for(int i = 0;i<sos.size();i++){
			System.out.println("!!!!!!!sos="+sos.get(i).getShortagestate());
		}
		
		return sos!=null&&sos.size()>0?sos.get(0):null;
 
	}
	
 
}
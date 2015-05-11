package com.neusoft.logistics.dao.impl;
//default package

import java.sql.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.OutStorageOrderItem;
import com.neusoft.logistics.dao.inter.IOutStorageOrderItemDAO;

/**
 * Data access object (DAO) for domain model class OutStorageOrderItem.
 * @see .OutStorageOrderItem
 * @author MyEclipse Persistence Tools 
 */

public class OutStorageOrderItemDAO extends BaseHibernateDAO<OutStorageOrderItem> implements IOutStorageOrderItemDAO  {
	public OutStorageOrderItemDAO() {
		super(log, OutStorageOrderItem.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(OutStorageOrderItemDAO.class);
	//property constants
	public static final String PRODUCTQUANTITY = "productquantity";




	public List<OutStorageOrderItem> findByProductquantity(Object productquantity) {
		return findByProperty(PRODUCTQUANTITY, productquantity);
	}




	public List<OutStorageOrderItem> findOutStorageOrder(Date begin, Date end,
			String product) {
		System.out.println(this.getClass()+" begin="+begin+" end="+end+" product="+product);
		if(begin==null&&end==null&&product!=null)
			return this.getSession().createQuery("from OutStorageOrderItem where LProduct.productname like :productname").setString("productname", "%"+product+"%").list();
		else if(begin!=null&&end==null&&product!=null)
			return this.getSession().createQuery("from OutStorageOrderItem where LProduct.productname like :productname and LOutstorageorder.outstoragedate>=:begin").setString("productname", "%"+product+"%").setDate("begin", begin).list();
		else if(begin==null&&end!=null&&product!=null)
			return this.getSession().createQuery("from OutStorageOrderItem where LProduct.productname like :productname and LOutstorageorder.outstoragedate<=:end").setString("productname", "%"+product+"%").setDate("end", end).list();
		else if(begin!=null&&end!=null&&product!=null)
			return this.getSession().createQuery("from OutStorageOrderItem where LProduct.productname like :productname and LOutstorageorder.outstoragedate>=:begin and LOutstorageorder.outstoragedate<=:end").setString("productname", "%"+product+"%").setDate("begin", begin).setDate("end", end).list();
		else if(begin!=null&&end==null&&product==null)
			return this.getSession().createQuery("from OutStorageOrderItem where  LOutstorageorder.outstoragedate>=:begin").setDate("begin", begin).list();
		else if(begin==null&&end!=null&&product==null)
			return this.getSession().createQuery("from OutStorageOrderItem where LOutstorageorder.outstoragedate<=:end").setDate("end", end).list();
		else if(begin!=null&&end!=null&&product==null)
			return this.getSession().createQuery("from OutStorageOrderItem where  LOutstorageorder.outstoragedate>=:begin and LOutstorageorder.outstoragedate<=:end").setDate("begin", begin).setDate("end", end).list();
		// TODO Auto-generated method stub
		return this.findAll();
	}

}
package com.neusoft.logistics.dao.impl;
// default package

import java.sql.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.SubstationInStorageOrder;
import com.neusoft.logistics.bean.SubstationInStorageOrderItem;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.ISubstationInStorageOrderItemDAO;

/**
 * Data access object (DAO) for domain model class SubstationInStorageOrderItem.
 * @see .SubstationInStorageOrderItem
  * @author MyEclipse Persistence Tools 
 */

public class SubstationInStorageOrderItemDAO extends BaseHibernateDAO<SubstationInStorageOrderItem> implements ISubstationInStorageOrderItemDAO  {
    public SubstationInStorageOrderItemDAO( ) {
		super(log, SubstationInStorageOrderItem.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(SubstationInStorageOrderItemDAO.class);
	//property constants
	public static final String PRODUCTQUANTITY = "productquantity";

 
	public List<SubstationInStorageOrderItem> findByProductquantity(Object productquantity) {
		return findByProperty(PRODUCTQUANTITY, productquantity);
	}
	public SubstationInStorageOrderItem findByProductSubstationInStorageOrder(Product product,SubstationInStorageOrder substationInStorageOrder){
		SubstationInStorageOrderItem s;
		List results = this.getSession().createQuery("from SubstationInStorageOrderItem s where s.LSubsationinstorageorder =:LSubsationinstorageorder" +
				" and s.LProduct =:LProduct").setEntity("LSubsationinstorageorder", substationInStorageOrder).setEntity("LProduct", product).list();
		if(results.size()!=0){
			return (SubstationInStorageOrderItem)results.get(0);
		}else{
			return null;
		}
	}


	public List<SubstationInStorageOrderItem> findInStorageOrder(Date begin,
			Date end, String product) {
		// TODO Auto-generated method stub
		if(begin==null&&end==null&&product!=null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where LProduct.productname like :productname").setString("productname", "%"+product+"%").list();
		else if(begin!=null&&end==null&&product!=null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where LProduct.productname like :productname and LSubsationinstorageorder.instoragedate>:begin").setString("productname", "%"+product+"%").setDate("begin", begin).list();
		else if(begin==null&&end!=null&&product!=null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where LProduct.productname like :productname and LSubsationinstorageorder.instoragedate<:end").setString("productname", "%"+product+"%").setDate("end", end).list();
		else if(begin!=null&&end!=null&&product!=null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where LProduct.productname like :productname and LSubsationinstorageorder.instoragedate>:begin and LSubsationinstorageorder.instoragedate<:end").setString("productname", "%"+product+"%").setDate("begin", begin).setDate("end", end).list();
		else if(begin!=null&&end==null&&product==null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where  LSubsationinstorageorder.instoragedate>:begin").setDate("begin", begin).list();
		else if(begin==null&&end!=null&&product==null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where LSubsationinstorageorder.instoragedate<:end").setDate("end", end).list();
		else if(begin!=null&&end!=null&&product==null)
			return this.getSession().createQuery("from SubstationInStorageOrderItem where  LSubsationinstorageorder.instoragedate>:begin and LSubsationinstorageorder.instoragedate<:end").setDate("begin", begin).setDate("end", end).list();
		// TODO Auto-generated method stub
		return this.findAll();
	}
	 
}
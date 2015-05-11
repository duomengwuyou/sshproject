package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.ReturnProductOrder;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IReturnProductOrderDAO;

/**
 * Data access object (DAO) for domain model class ReturnProductOrder.
 * @see .ReturnProductOrder
  * @author MyEclipse Persistence Tools 
 */

public class ReturnProductOrderDAO extends BaseHibernateDAO<ReturnProductOrder> implements IReturnProductOrderDAO {
    public ReturnProductOrderDAO() {
		super(log, ReturnProductOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(ReturnProductOrderDAO.class);
	//property constants
	public static final String RETURNQUANTITY = "returnquantity";
	public static final String RETURNREASON = "returnreason";
	public static final String FROMORDER = "fromorder";
	public static final String RETURNTOSUBWAREHOUSESTATE = "returntosubwarehousestate";
	public static final String RETURNTOCENTERWAREHOUSESTATE = "returntocenterwarehousestate";

 

	public List<ReturnProductOrder> findByReturnquantity(Object returnquantity) {
		return findByProperty(RETURNQUANTITY, returnquantity);
	}
	
	public List<ReturnProductOrder> findByReturnreason(Object returnreason) {
		return findByProperty(RETURNREASON, returnreason);
	}
	
	public List<ReturnProductOrder> findByFromorder(Object fromorder) {
		return findByProperty(FROMORDER, fromorder);
	}
	
	public List<ReturnProductOrder> findByReturntosubwarehousestate(Object returntosubwarehousestate) {
		return findByProperty(RETURNTOSUBWAREHOUSESTATE, returntosubwarehousestate);
	}
	
	public List<ReturnProductOrder> findByReturntocenterwarehousestate(Object returntocenterwarehousestate) {
		return findByProperty(RETURNTOCENTERWAREHOUSESTATE, returntocenterwarehousestate);
	}

	public int getReturnQuantityByProductAndWarehouse(Product product,
			Warehouse warehouse) {
		List<ReturnProductOrder> list=this.getSession().createQuery("from ReturnProductOrder where LProduct=:product and (LWarehouseByCenterwarehouse=:warehouse or LWarehouseBySubwarehouse=:warehouse) and (returntosubwarehousestate=:state or returntocenterwarehousestate=:state ) ")
				.setEntity("product", product).setEntity("warehouse", warehouse).setString("state", "入库").list();
		int quantity=0;
		System.out.println(this.getClass()+" list.size="+list.size());
		for(ReturnProductOrder rpo:list){
			quantity+=rpo.getReturnquantity();
		}
		// TODO Auto-generated method stub
		return quantity;
	}
	
 
}
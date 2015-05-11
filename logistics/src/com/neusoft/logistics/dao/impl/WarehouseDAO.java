package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;

/**
 * Data access object (DAO) for domain model class Warehouse.
 * @see .Warehouse
  * @author MyEclipse Persistence Tools 
 */

public class WarehouseDAO extends BaseHibernateDAO<Warehouse> implements IWarehouseDAO  {
    public WarehouseDAO( ) {
		super(log, Warehouse.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(WarehouseDAO.class);
	//property constants
	public static final String WAREHOUSENAME = "warehousename";
	public static final String WAREHOUSEADDRESS = "warehouseaddress";
	public static final String WAREHOUSETYPE = "warehousetype";


     
	public List<Warehouse> findByWarehousename(Object warehousename) {
		return findByProperty(WAREHOUSENAME, warehousename);
	}
	
	public List<Warehouse> findByWarehouseaddress(String warehouseaddress) {//findByProperty(WAREHOUSEADDRESS, warehouseaddress);
		return warehouseaddress==null?this.findAll():this.getSession().createQuery("from Warehouse where warehouseaddress like :warehouseadd").setString("warehouseadd", "%"+warehouseaddress+"%").list();
	}
	
	public List<Warehouse> findByWarehousetype(Object warehousetype) {
		return findByProperty(WAREHOUSETYPE, warehousetype);
	}

	public Warehouse getCenterWarehosue() {
		// TODO Auto-generated method stub
		List<Warehouse> warehouses=this.getSession().createQuery("from Warehouse where warehousetype=:type").setString("type","中心库房").list();
		System.out.println(this.getClass()+" warehouses.size="+warehouses.size());
		return (warehouses!=null&&warehouses.size()>0)?warehouses.get(0):null;
	}

	/*public List<Warehouse> findWarehouseByAddress(String add) {
		// TODO Auto-generated method stub
		return add==null?this.findAll():this.getSession().createQuery("");
	}*/
	 
}
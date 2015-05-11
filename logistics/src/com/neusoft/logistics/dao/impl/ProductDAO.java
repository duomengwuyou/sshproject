package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.dao.inter.IProductDAO;

/**
 * Data access object (DAO) for domain model class Product.
 * @see .Product
  * @author MyEclipse Persistence Tools 
 */

public class ProductDAO extends BaseHibernateDAO<Product> implements IProductDAO {
    public ProductDAO() {
		super(log, Product.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(ProductDAO.class);
	//property constants
	public static final String PRODUCTNAME = "productname";
	public static final String UNIT = "unit";
	public static final String ORIGINALPRICE = "originalprice";
	public static final String DISCOUNT = "discount";
	public static final String COSTPRICE = "costprice";
	public static final String PRODUCTTYPE = "producttype";
	public static final String MANUFACTURER = "manufacturer";
	public static final String RETURNABLE = "returnable";
	public static final String CHANGEABLE = "changeable";
	public static final String PRODUCTREMARK = "productremark";


    

	public List<Product> findByProductname(Object productname) {
		return findByProperty(PRODUCTNAME, productname);
	}
	
	public List<Product> findByUnit(Object unit) {
		return findByProperty(UNIT, unit);
	}
	
	public List<Product> findByOriginalprice(Object originalprice) {
		return findByProperty(ORIGINALPRICE, originalprice);
	}
	
	public List<Product> findByDiscount(Object discount) {
		return findByProperty(DISCOUNT, discount);
	}
	
	public List<Product> findByCostprice(Object costprice) {
		return findByProperty(COSTPRICE, costprice);
	}
	
	public List<Product> findByProducttype(Object producttype) {
		return findByProperty(PRODUCTTYPE, producttype);
	}
	
	public List<Product> findByManufacturer(Object manufacturer) {
		return findByProperty(MANUFACTURER, manufacturer);
	}
	
	public List<Product> findByReturnable(Object returnable) {
		return findByProperty(RETURNABLE, returnable);
	}
	
	public List<Product> findByChangeable(Object changeable) {
		return findByProperty(CHANGEABLE, changeable);
	}
	
	public List<Product> findByProductremark(Object productremark) {
		return findByProperty(PRODUCTREMARK, productremark);
	}
	
	public List<Product> findByCategory(Category category){
		if(category.getLCategory()==null){
			return this.getSession().createQuery("from Product where LCategory in (from Category where LCategory=:firstcategory)").setEntity("firstcategory", category).list();
		}else
			return this.getSession().createQuery("from Product where LCategory=:secondcategory").setEntity("secondcategory", category).list();
	}	
}
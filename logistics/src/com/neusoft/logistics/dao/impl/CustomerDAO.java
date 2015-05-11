package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.dao.inter.ICustomerDAO;

/**
 * Data access object (DAO) for domain model class Customer.
 * @see .Customer
  * @author MyEclipse Persistence Tools 
 */

public class CustomerDAO extends BaseHibernateDAO<Customer> implements  ICustomerDAO {
    public CustomerDAO( ) {
		super(log, Customer.class);
		// TODO Auto-generated constructor stub
	}
	private static final Log log = LogFactory.getLog(CustomerDAO.class);
	//property constants
	public static final String CUSTOMERNAME = "customername";
	public static final String IDCARD = "idcard";
	public static final String WORKPLACE = "workplace";
	public static final String PHONE = "phone";
	public static final String MOBILE = "mobile";
	public static final String ADDRESS = "address";
	public static final String CUSTOMERZIPCODE = "customerzipcode";
	public static final String EMAIL = "email";


	public List<Customer> findByCustomername(Object customername) {
		return findByProperty(CUSTOMERNAME, customername);
	}
	
	public List<Customer> findByIdcard(Object idcard) {
		return findByProperty(IDCARD, idcard);
	}
	
	public List<Customer> findByWorkplace(Object workplace) {
		return findByProperty(WORKPLACE, workplace);
	}
	
	public List<Customer> findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}
	
	public List<Customer> findByMobile(Object mobile) {
		return findByProperty(MOBILE, mobile);
	}
	
	public List<Customer> findByAddress(Object address) {
		return findByProperty(ADDRESS, address);
	}
	
	public List<Customer> findByCustomerzipcode(Object customerzipcode) {
		return findByProperty(CUSTOMERZIPCODE, customerzipcode);
	}
	
	public List<Customer> findByEmail(Object email) {
		return findByProperty(EMAIL, email);
	}
	
	public List<Customer> findCustomer(Customer customer){
		StringBuffer hql=new StringBuffer("from Customer where 1=1 ");
		if(customer.getCustomername()!=null&&!customer.getCustomername().equals("")){
			hql.append(" and customername='").append(customer.getCustomername()).append("'");
		} 
		if(customer.getMobile()!=null&&!customer.getMobile().equals("")){
			hql.append(" and mobile='").append(customer.getMobile()).append("'");
		}
		if(customer.getIdcard()!=null&&!customer.getIdcard().equals("")){
			hql.append(" and idcard='").append(customer.getIdcard()).append("'");
		} 
		//System.out.println("!!!!!!!!!!"+hql);
		return this.getSession().createQuery(hql.toString()).list();
	}

}
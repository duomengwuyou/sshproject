package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Supplier;
import com.neusoft.logistics.dao.inter.ISupplierDAO;

/**
 * Data access object (DAO) for domain model class Supplier.
 * @see .Supplier
  * @author MyEclipse Persistence Tools 
 */

public class SupplierDAO extends BaseHibernateDAO<Supplier> implements ISupplierDAO {
    public SupplierDAO( ) {
		super(log, Supplier.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(SupplierDAO.class);
	//property constants
	public static final String SUPPLIERNAME = "suppliername";
	public static final String SUPPLIERADD = "supplieradd";
	public static final String CONTACTPERSON = "contactperson";
	public static final String SUPPLIERTEL = "suppliertel";
	public static final String BANK = "bank";
	public static final String BANKACCOUNT = "bankaccount";
	public static final String FAX = "fax";
	public static final String SUPPLIERZIPCODE = "supplierzipcode";
	public static final String LEGALPERSON = "legalperson";
	public static final String SUPPLIERREMARK = "supplierremark";


     
	public List<Supplier> findBySuppliername(Object suppliername) {
		return findByProperty(SUPPLIERNAME, suppliername);
	}
	
	public List<Supplier> findBySupplieradd(Object supplieradd) {
		return findByProperty(SUPPLIERADD, supplieradd);
	}
	
	public List<Supplier> findByContactperson(Object contactperson) {
		return findByProperty(CONTACTPERSON, contactperson);
	}
	
	public List<Supplier> findBySuppliertel(Object suppliertel) {
		return findByProperty(SUPPLIERTEL, suppliertel);
	}
	
	public List<Supplier> findByBank(Object bank) {
		return findByProperty(BANK, bank);
	}
	
	public List<Supplier> findByBankaccount(Object bankaccount) {
		return findByProperty(BANKACCOUNT, bankaccount);
	}
	
	public List<Supplier> findByFax(Object fax) {
		return findByProperty(FAX, fax);
	}
	
	public List<Supplier> findBySupplierzipcode(Object supplierzipcode) {
		return findByProperty(SUPPLIERZIPCODE, supplierzipcode);
	}
	
	public List<Supplier> findByLegalperson(Object legalperson) {
		return findByProperty(LEGALPERSON, legalperson);
	}
	
	public List<Supplier> findBySupplierremark(Object supplierremark) {
		return findByProperty(SUPPLIERREMARK, supplierremark);
	}
	 
}
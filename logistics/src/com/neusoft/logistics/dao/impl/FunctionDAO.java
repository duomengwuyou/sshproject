package com.neusoft.logistics.dao.impl;
//default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Function;
import com.neusoft.logistics.bean.Role;
import com.neusoft.logistics.dao.inter.IFunctionDAO;

/**
 * Data access object (DAO) for domain model class Function.
 * @see .Function
 * @author MyEclipse Persistence Tools 
 */

public class FunctionDAO extends BaseHibernateDAO<Function> implements IFunctionDAO {
	public FunctionDAO() {
		super(log, Function.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(FunctionDAO.class);
	//property constants
	public static final String PARENT = "parent";
	public static final String FUNCTIONNAME = "functionname";
	public static final String ISLEAF = "isleaf";
	public static final String ICONCLS = "iconcls";
	public static final String PARENTID = "parentid"; 

	public List<Function> findByParent(Function parent) {
		return findByProperty(PARENT, parent);
	}

	public List<Function> findByFunctionname(Object functionname) {
		return findByProperty(FUNCTIONNAME, functionname);
	}

	public List<Function> findByIsleaf(Object isleaf) {
		return findByProperty(ISLEAF, isleaf);
	}

	public List<Function> findByIconcls(Object iconcls) {
		return findByProperty(ICONCLS, iconcls);
	}

	public List<Function> findByParentid(Object parentid) {
		return findByProperty(PARENTID, parentid);
	}
	
	public List<Function> findByParentidRoleid(int parentId,int roleid){
		Function function = new Function();
		Role tempRole = new Role();
		Function parent=new Function();
		parent.setFunctionid(parentId);
		tempRole.setRoleid(roleid);
		function.setParent(parent);
		function.setLRoleByRole(tempRole);
		//function.getParent().setFunctionid(parentId);
		//function.getLRoleByRole().setRoleid(roleid);
		
		//return findByExample(function);
		return this.getSession().createQuery("from Function where parent=:parent and LRoleByRole=:LRoleByRole").setEntity("parent", parent).setEntity("LRoleByRole", tempRole).list();
	}
	/*	public List<Function> findByParent(Function parent) {
		// TODO Auto-generated method stub
		return null;
	}
	 */
	public List<Function> findParentsByRole(Role role) {
		// TODO Auto-generated method stub
		return this.getSession().createQuery("from Function where Role=:role and isleaf=:isleaf")
		.setEntity("role", role).setInteger("isleaf", 0).list();
	}


}
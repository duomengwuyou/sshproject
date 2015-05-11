package com.neusoft.logistics.dao.impl;
// default package
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Role;
import com.neusoft.logistics.dao.inter.IRoleDAO;


/**
 * Data access object (DAO) for domain model class Role.
 * @see .Role
  * @author MyEclipse Persistence Tools 
 */

public class RoleDAO extends BaseHibernateDAO<Role> implements IRoleDAO {
    public RoleDAO() {
		super(log, Role.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(RoleDAO.class);
	//property constants
	public static final String ROLENAME = "rolename";

 

	public List<Role> findByRolename(Object rolename) {
		return findByProperty(ROLENAME, rolename);
	}
	
 
}
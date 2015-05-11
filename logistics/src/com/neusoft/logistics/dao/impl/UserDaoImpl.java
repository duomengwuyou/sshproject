package com.neusoft.logistics.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IUserDAO;

public class UserDaoImpl extends BaseHibernateDAO<User> implements IUserDAO {
	
	public UserDaoImpl( ) {
		super(log, User.class);
		// TODO Auto-generated constructor stub
	}

	public User findUser(int userid, String password) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("用户名为:"+userid+"  密码为："+password);
		List results = this.getSession().createQuery("from User u where u.userid=:userid and u.passwd=:passwd")
		.setInteger("userid", userid).setString("passwd", password).list();
		if(results.size()!=0){
			return (User)results.get(0);
		}else{
			return null;
		}
	}

	 private static final Log log = LogFactory.getLog(UserDaoImpl.class);
		//property constants
		public static final String USERNAME = "username";
		public static final String PASSWORD = "password";
		public static final String USERREMARK = "userremark";
		public List<User> findWarehouseManage() {
			// TODO Auto-generated method stub
			return null;
		}

 

		
}

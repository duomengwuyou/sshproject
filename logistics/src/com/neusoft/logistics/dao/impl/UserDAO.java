package com.neusoft.logistics.dao.impl;
// default package

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IUserDAO;


/**
 * Data access object (DAO) for domain model class User.
 * @see .User
  * @author MyEclipse Persistence Tools 
 */

public class UserDAO extends BaseHibernateDAO<User> implements IUserDAO  {
    public UserDAO( ) {
		super(log, User.class);
		// TODO Auto-generated constructor stub
	}
	private static final Log log = LogFactory.getLog(UserDAO.class);
	//property constants
	public static final String USERNAME = "username";
	public static final String PASSWD = "passwd";

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}
	public List<User> findByPasswd(Object passwd) {
		return findByProperty(PASSWD, passwd);
	}
	/**
	 * 根据用户名和密码查找用户
	 */
	public User findUser(int userid, String password) throws Exception {
		System.out.println("用户名为:"+userid+"  密码为："+password);
		List results = this.getSession().createQuery("from User u where u.userid=:userid and u.passwd=:passwd")
		.setInteger("userid", userid).setString("passwd", password).list();
		if(results.size()!=0){
			return (User)results.get(0);
		}else{
			return null;
		}
	}
	public List<User> findWarehouseManage() {
		// TODO Auto-generated method stub
		return this.getSession().createQuery("from User where LRole.rolename=:rolename").setString("rolename","分站库房管理员").list();
	}
}
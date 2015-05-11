package com.neusoft.logistics.dao.impl;
// default package

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.ISubstationDAO;

/**
 * Data access object (DAO) for domain model class Substation.
 * @see .Substation
  * @author MyEclipse Persistence Tools 
 */

public class SubstationDAO extends BaseHibernateDAO<Substation> implements ISubstationDAO  {
    public SubstationDAO( ) {
		super(log, Substation.class);
		// TODO Auto-generated constructor stub
	}
	private static final Log log = LogFactory.getLog(SubstationDAO.class);
	//property constants
	public static final String SUBSTATIONADD = "substationadd";
	public static final String SUBSTATIONTEL = "substationtel";
 
	public List<Substation> findBySubstationadd(Object substationadd) {
		return findByProperty(SUBSTATIONADD, substationadd);
	}
	
	public List<Substation> findBySubstationtel(Object substationtel) {
		return findByProperty(SUBSTATIONTEL, substationtel);
	}
	/**
	 * 李莎
	 * 得到一个分站所有的配送员
	 * @param substation
	 * @return
	 */
	public List<User> listAllDeliverman(Substation substation){
		
		List<User> users = this.getSession().createQuery("from User u where u.LRole.rolename=:rolename").setString("rolename", "配送员").list();
		List<User> rusers=new ArrayList<User>();
		for(User user:users){
			for(Substation sub:user.getLSubstations()){
				if(sub.equals(substation)){rusers.add(user);break;}
			}
		}	
		return rusers;
	} 
	/**
	 * 通过分站来查找到相应的分站
	 * @param user
	 * @return
	 */
	public List<Substation>  findByUser(User user){
		log.debug("findByUser clean "+Substation.class+" instance");
        try {
		System.out.println("到达查找substation界面");
		List<Substation> list =  this.getSession().createQuery("from Substation s where  :user in s.LUsers" ).setEntity("user", user).list();
		System.out.println("查找到了结果");
		System.out.println("查找到了结果的大小为："+list.size());
		return list;
        } catch (RuntimeException re) {
            log.error("findByUser failed", re);
            throw re;
        }
		
	}
}
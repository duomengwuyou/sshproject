package com.neusoft.logistics.dao.impl;
//default package

import java.io.Serializable;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.apache.commons.logging.Log;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import com.neusoft.logistics.dao.inter.IBaseDAO;


/**
 * Data access object (DAO) for domain model
 * @author 陈秀能
 */
public class BaseHibernateDAO<T>  extends HibernateDaoSupport implements IBaseDAO<T>  {

	private Log log;
	private Class<T> cls;
	public BaseHibernateDAO(Log log,Class<T> cls){
		this.log=log;
		this.cls=cls;
	}

	public void attachClean(T t)  {this.
		// TODO Auto-generated method stub
		log.debug("attaching clean "+cls.getName()+" instance");
        try {
            getSession().lock(t, LockMode.NONE);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
	}

	public void attachDirty(T t)  {
		// TODO Auto-generated method stub
		log.debug("attaching dirty "+cls.getName()+" instance");
        try {
            getSession().saveOrUpdate(t);
            log.debug("attach successful");
        } catch (RuntimeException re) {
            log.error("attach failed", re);
            throw re;
        }
	}

	public void delete(T t)  {
		// TODO Auto-generated method stub
		  log.debug("deleting "+cls.getName()+" instance");
	        try {
	            getSession().delete(t);
	            log.debug("delete successful");
	        } catch (RuntimeException re) {
	            log.error("delete failed", re);
	            throw re;
	        }
	}
//
	public List<T> findAll()  {
		// TODO Auto-generated method stub
		log.debug("finding all "+cls.getName()+" instances");
		try {
			//this.getHibernateTemplate().g
			String queryString = "from "+cls.getName();
	         Query queryObject = getSession().createQuery(queryString);
			 return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public List<T> findByExample(T t)  {
		// TODO Auto-generated method stub
		 log.debug("finding "+cls.getName()+" instance by example");
	        try {
	            List results = getSession()
	                    .createCriteria(t.getClass())
	                    .add(Example.create(t))
	            .list();
	            log.debug("find by example successful, result size: " + results.size());
	            return results;
	        } catch (RuntimeException re) {
	            log.error("find by example failed", re);
	            throw re;
	        }
	}

	public T findById(Serializable id)  {
		// TODO Auto-generated method stub
		log.debug("getting "+cls.getName()+" instance with id: " + id);
        try {
            T instance = (T) getSession().get(cls, id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
	}

	public List<T> findByProperty(String propertyName, Object value) {
		// TODO Auto-generated method stub
		log.debug("finding "+cls.getName()+" instance with property: " + propertyName
	            + ", value: " + value);
	      try {
	         String queryString = "from "+cls.getName()+" as model where model." 
	         						+ propertyName + "= ?";
	         Query queryObject = getSession().createQuery(queryString);
			 queryObject.setParameter(0, value);
			// System.out.println("query结果为："+((Function)queryObject.list().get(0)));
			 return queryObject.list();
	      } catch (RuntimeException re) {
	         log.error("find by property name failed", re);
	         throw re;
	      }
	}

	public T merge(T t)  {
		// TODO Auto-generated method stub
		log.debug("merging "+cls.getName()+" instance");
        try {
            T result = (T) getSession().merge(t);
            log.debug("merge successful");
            return result;
        } catch (RuntimeException re) {
            log.error("merge failed", re);
            throw re;
        }
	}

	public void save(T t)  {
		// TODO Auto-generated method stub
		log.debug("saving "+cls.getName()+" instance");
		try {
			getSession().save(t);
			//this.getHibernateTemplate().save(t);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}
	/**
	 * 获取数据库服务器里的当前时间
	 */
	 public Date currentDate() {
		Date date = null;
		ResultSet rs;
		try {
			rs = this.getSession().connection().prepareStatement("Select Sysdate From dual").executeQuery();
			if(rs.next()){
				date=rs.getDate(1);	
			}
		} catch (DataAccessResourceFailureException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return date;
	}
	/*public void commit() {
		// TODO Auto-generated method stub
		this.getSession().beginTransaction().commit();
		this.getSession().flush();
		this.getSession().close();
	}*/
 
}
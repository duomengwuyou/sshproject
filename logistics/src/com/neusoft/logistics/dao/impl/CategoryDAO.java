package com.neusoft.logistics.dao.impl;
//default package

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.dao.inter.ICategoryDAO;

/**
 * Data access object (DAO) for domain model class Category.
 * @see .Category
 * @author MyEclipse Persistence Tools 
 */

public class CategoryDAO extends BaseHibernateDAO<Category> implements ICategoryDAO {
	public CategoryDAO() {
		super(log, Category.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(CategoryDAO.class);
	//property constants
	public static final String CATEGORYNAME = "categoryname";
	public static final String PARENTCATEGORY = "LCategory";


	/*    
    public Category findById( java.lang.Long id) {
        log.debug("getting Category instance with id: " + id);
        try {
            Category instance = (Category) getSession()
                    .get("Category", id);
            return instance;
        } catch (RuntimeException re) {
            log.error("get failed", re);
            throw re;
        }
    }
	 */


	public List<Category> findByCategoryname(Object categoryname) {
		return findByProperty(CATEGORYNAME, categoryname);
	}


	public List<Category> listFirstCategories() {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" listFirstCategories");
		return this.getSession().createQuery("from Category where LCategory is null").list(); 
	}


	public List<Category> listSecondCategories(Category category) {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" listSecondCategories");
		if(category==null)return this.getSession().createQuery("from Category where LCategory is not null").list();
		System.out.println(this.getClass()+" category is not null");
		return this.getSession().createQuery("from Category where LCategory=:category").setEntity("category", category).list();
	}


	public Category getFirstCategoryBySecondCategory(Category secondCategory) {
		// TODO Auto-generated method stub
		//return this.findById(secondCategory.getCategoryid()).getLCategory();
		return secondCategory.getLCategory();
	}




}
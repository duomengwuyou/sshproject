package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.util.Iterator;
import java.util.List;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.ShortProductTotal;
import com.neusoft.logistics.dao.impl.ShortProductTotalDao;
import com.neusoft.logistics.dao.inter.ICategoryDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IQueryCategoryService;
import com.neusoft.logistics.utils.JSONHelper;

public class QueryCategoryServiceImpl implements IQueryCategoryService {
	private ICategoryDAO categoryDAO;

	public ICategoryDAO getCategoryDAO() {
		return categoryDAO;
	}

	public void setCategoryDAO(ICategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
	}

	private ShortProductTotalDao sptd;
	
	
	public ShortProductTotalDao getSptd() {
		return sptd;
	}

	public void setSptd(ShortProductTotalDao sptd) {
		this.sptd = sptd;
	}

	public String getFirstCategories() {
		// TODO Auto-generated method stub
		//System.out.println(categoryDAO.listParentCategories(null).size());
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		for(Category category:categoryDAO.listFirstCategories()){
			json.AddItem("categoryid", String.valueOf(category.getCategoryid()));
			json.AddItem("categoryname", category.getCategoryname());
			json.ItemOK();
		}
		return json.toString();
	}
	public String getSecondCategories(Category parentCategory) {
		// TODO Auto-generated method stub
		//System.out.println(categoryDAO.listParentCategories(null).size());
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		for(Category category:categoryDAO.listSecondCategories(parentCategory)){
			json.AddItem("categoryid", String.valueOf(category.getCategoryid()));
			json.AddItem("categoryname", category.getCategoryname());
			json.AddItem("parentcategory", category.getLCategory().getCategoryname());
			json.ItemOK();
		}
		return json.toString();
	}

	public String getFirstCategory(Category secondCategory) {
		// TODO Auto-generated method stub
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		Category category = categoryDAO.getFirstCategoryBySecondCategory(secondCategory);
		
			json.AddItem("categoryid", String.valueOf(category.getCategoryid()));
			json.AddItem("categoryname", category.getCategoryname());
			//json.AddItem("parentcategory", category.getLCategory().getCategoryname());
			json.ItemOK();
		
		return json.toString();
	}
	

}

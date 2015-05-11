package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.util.List;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.dao.inter.ICategoryDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IManageCategoryService;

public class ManageCategoryServiceImpl implements IManageCategoryService {
	private ICategoryDAO categoryDAO;

	public ICategoryDAO getCategoryDAO() {
		return categoryDAO;
	}

	public void setCategoryDAO(ICategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
	}

	public void addCategory(Category category) {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" aadd"); 
		/*if(category.getLCategory()!=null){
			//List<Category> cates=categoryDAO.findByProperty("categoryname",category.getLCategory().getCategoryname());
			category.setLCategory(categoryDAO.findById(category.));
		}*/
		categoryDAO.save(category); 
		//categoryDAO.commit();
	}

	public void delCategory(Category category) {
		// TODO Auto-generated method stub

	}

	public String modCategory(Category category) {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" categoryid="+category.getCategoryid());
		categoryDAO.findById(category.getCategoryid()).setCategoryname(category.getCategoryname());
		categoryDAO.findById(category.getCategoryid()).setLCategory(category.getLCategory());
		/*if(category.getLCategory()!=null){
			System.out.println(this.getClass()+" parentCategory="+category.getLCategory().getCategoryname());
			List<Category> cates=categoryDAO.findByProperty("categoryname",category.getLCategory().getCategoryname());
			if(cates!=null&&cates.size()>0)categoryDAO.findById(category.getCategoryid()).setLCategory(cates.get(0));
		}*/
		return "{success : true,data:[]}";
	}

	public String delCategory(String[] root) {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" root="+root.toString());
		for(int i=0;i<root.length;i++){
			categoryDAO.delete(categoryDAO.findById(Integer.valueOf(root[i])));
		}
		return "{success : true,data:[]}";
	}

}

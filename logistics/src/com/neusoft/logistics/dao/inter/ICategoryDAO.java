package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Category;

public interface ICategoryDAO extends IBaseDAO<Category> {
	/**
	 * 查询一级分类
	 * 
	 * **/
	public List<Category> listFirstCategories();
	/**
	 * 查询某个分类的二级分类，传入的参数为null时查询所有二级分类
	 * 
	 * **/
	public List<Category> listSecondCategories(Category category);
	public Category getFirstCategoryBySecondCategory(Category secondCategory);
}

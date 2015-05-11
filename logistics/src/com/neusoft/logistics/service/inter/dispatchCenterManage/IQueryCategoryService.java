package com.neusoft.logistics.service.inter.dispatchCenterManage;

import com.neusoft.logistics.bean.Category;

/**
 * 分类查询服务
 * @author 陈秀能
 * **/
public interface IQueryCategoryService {
	/**
	 * 获得一级分类
	 * **/
	public String getFirstCategories(); 
	/**
	 * 获得二级分类
	 * **/
	public String getSecondCategories(Category parentCategory);
	public String getFirstCategory(Category secondCategory);
}

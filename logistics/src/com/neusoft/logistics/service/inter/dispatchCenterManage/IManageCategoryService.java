package com.neusoft.logistics.service.inter.dispatchCenterManage;

import com.neusoft.logistics.bean.Category;
/**
 * 管理商品类型，包括增、删、改
 * @author 陈秀能
 * */
public interface IManageCategoryService {
	public void addCategory(Category category);
	public void delCategory(Category category);
	public String modCategory(Category category);
	public String delCategory(String[] root);
}

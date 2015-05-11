package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Product;

public interface IProductDAO extends IBaseDAO<Product> {

	public List<Product> findByCategory(Category category);
}

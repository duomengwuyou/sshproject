package com.neusoft.logistics.service.inter.dispatchCenterManage;

import com.neusoft.logistics.bean.Product;

public interface IManageProductService {
public String save(Product product);

public String delete(String[] root);

public String modify(int productId, String value, String field);
}

package com.neusoft.logistics.service.inter.customermanage;

import com.neusoft.logistics.bean.OrderItem;
public interface IProductDetailService {

/**
 * 获得商品详细信息
 * @罗荣博
 * @return
 */
	public String findProductDetails(int orderId);

}

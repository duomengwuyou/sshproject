package com.neusoft.logistics.service.inter.dispatchCenterManage;

import java.util.List;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.PurchaseProductOrder;
import com.neusoft.logistics.bean.ShortProductTotal;
/**
 * 进货管理 获取仓库和缺货单的总缺货商品信息
 * @author 龚玉斌
 * */
public interface IPurchaseProductService {
	public String getShortProductsTotal();
	public boolean addShortProductTotal(List<PurchaseProductOrder> lists);
	public boolean addPurchaseProductInStorageOrder(List<PurchaseProductOrder> lists);
}

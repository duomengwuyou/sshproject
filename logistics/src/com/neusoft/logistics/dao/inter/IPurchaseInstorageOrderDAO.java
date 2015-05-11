package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;
import com.neusoft.logistics.bean.PurchaseInstorageOrder;

public interface IPurchaseInstorageOrderDAO extends
		IBaseDAO<PurchaseInstorageOrder> {
	public void setHasFinished(PurchaseInstorageOrder purchaseInstorageOrder);
}

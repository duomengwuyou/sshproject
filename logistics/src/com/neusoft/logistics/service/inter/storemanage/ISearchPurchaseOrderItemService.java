package com.neusoft.logistics.service.inter.storemanage;

import java.sql.Date;

public interface ISearchPurchaseOrderItemService {
	 public String getItemsByPurchaseProductInStorageOrderId(int purchaseProductInStorageOrderId);
	 public boolean saveRealIntoQuantity ( int dispatchOrderId , int realIntoQuantity);
	 public boolean saveInStorage(int id,String state,Date date,String remark);
}

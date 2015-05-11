package com.neusoft.logistics.service.inter.dispatchCenterManage;

import com.neusoft.logistics.bean.Warehouse;
/**
 * @author 陈秀能
 * */
public interface IWarehouseService {

	public String searchWarehouseByAdd(String warehouseAdd);
	/**
	 * 保存库房设置
	 * */
	public String saveWarehouse(Warehouse warehouse);
	/**
	 * 修改库房设置
	 * */
	public String modifyWarehouse(Integer warehouseId, String field,
			String value);
	public String delete(String[] root);

}

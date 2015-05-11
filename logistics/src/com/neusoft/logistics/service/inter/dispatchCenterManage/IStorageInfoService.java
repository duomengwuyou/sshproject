package com.neusoft.logistics.service.inter.dispatchCenterManage;
/**
 * 库房储备服务
 * @author 陈秀能
 * */
public interface IStorageInfoService {
	/**
	 * 根据产品名称搜索库房储备设置，支持模糊搜索
	 * **/
	public String findStorageInfoByProductName(String productName);
	/**
	 * 根据商品名称，库房名称搜索库存量
	 * **/
	public String searchStorageAmount(String productName, String warehouseName);
	/**
	 * 修改库存信息
	 * **/
	public String modifyStorageInfo(Integer storageInfoId, String field,
			String value);
}

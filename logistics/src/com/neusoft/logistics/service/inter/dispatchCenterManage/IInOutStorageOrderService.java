package com.neusoft.logistics.service.inter.dispatchCenterManage;

public interface IInOutStorageOrderService {
	/**
	 * 根据开始时间，结束时间，产品名称查询出库，入库单，支持商品名称模糊查询，当3个参数都为null时查询所有出入库单，
	 * 当开始时间或者结束时间一个为null时，默认为当日，当两个都为null时，默认为所有出入库单
	 * **/
	public 	String getInOutStorageOrder(String beginTime, String endTime,
			String product);

}

package com.neusoft.logistics.service.inter.dispatchCenterManage;

public interface ITopHotProducts {
	public String getTopHotProducts();
	public String getTopHotProductsByTime(String startTime, String endTime);
}

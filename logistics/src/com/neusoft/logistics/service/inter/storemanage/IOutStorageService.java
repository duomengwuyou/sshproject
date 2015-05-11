package com.neusoft.logistics.service.inter.storemanage;

import com.neusoft.logistics.bean.User;

public interface IOutStorageService {
	public String getAllocationOrderByDate(String date);

	public void saveAllocation(String[] allocations,User user);

	public String showDetail(String[] allocationIds);
}

package com.neusoft.logistics.service.inter;

import com.neusoft.logistics.bean.User;

public interface IQueryUserService {

	public User findUserByNameAndPassword(int userid,String password);
	public String findWarehouseManage();
}

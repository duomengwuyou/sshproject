package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.User;

public interface IUserDAO extends IBaseDAO<User> {
	
	public User findUser(int userid,String password)throws Exception;

	public List<User> findWarehouseManage();
}

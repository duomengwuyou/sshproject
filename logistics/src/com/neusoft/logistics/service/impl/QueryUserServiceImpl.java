package com.neusoft.logistics.service.impl;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IUserDAO;
import com.neusoft.logistics.service.inter.IQueryUserService;
import com.neusoft.logistics.utils.JSONHelper;

public class QueryUserServiceImpl implements IQueryUserService{
	private IUserDAO userDAO;
	

	public IUserDAO getUserDAO() {
		return userDAO;
	}
	public void setUserDAO(IUserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public User findUserByNameAndPassword(int userid, String password) {
		// TODO Auto-generated method stub
		try {
			return userDAO.findUser(userid, password);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**获得所有的库房管理员**/
	public String findWarehouseManage() {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" findWarehouseManage");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); //分站库房管理员 
		for(User user:userDAO.findWarehouseManage()){
			json.AddItem("userId", String.valueOf(user.getUserid()));
			json.AddItem("Username", user.getUsername()); 
			json.ItemOK();
		} 
		System.out.println(this.getClass()+" ee"+json.toString());
		return json.toString();
	}
}

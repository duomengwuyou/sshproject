package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.bean.Warehouse;

public interface ISubstationDAO extends IBaseDAO<Substation> {
	public List<Substation>  findByUser(User user);

}

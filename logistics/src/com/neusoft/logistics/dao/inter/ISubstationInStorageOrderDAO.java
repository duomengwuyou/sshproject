package com.neusoft.logistics.dao.inter;

import com.neusoft.logistics.bean.DispatchOrder;
import com.neusoft.logistics.bean.SubstationInStorageOrder;

public interface ISubstationInStorageOrderDAO extends
		IBaseDAO<SubstationInStorageOrder> {
	public SubstationInStorageOrder findByDispatchorder(DispatchOrder dispatchorder);
}

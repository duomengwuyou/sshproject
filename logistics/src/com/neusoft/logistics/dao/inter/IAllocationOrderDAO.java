package com.neusoft.logistics.dao.inter;

import java.sql.Date;
import java.util.List;

import com.neusoft.logistics.bean.AllocationOrder;
/**
 * 调拨单
 * @author 陈秀能
 * */
public interface IAllocationOrderDAO extends IBaseDAO<AllocationOrder> {

	List<AllocationOrder> getAllocationOrderByDate(Date date);

}

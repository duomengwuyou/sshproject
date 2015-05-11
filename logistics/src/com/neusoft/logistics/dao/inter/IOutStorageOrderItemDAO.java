package com.neusoft.logistics.dao.inter;

import java.sql.Date;
import java.util.List;

import com.neusoft.logistics.bean.OutStorageOrderItem;

public interface IOutStorageOrderItemDAO extends IBaseDAO<OutStorageOrderItem> {
	/**
	 * 根据开始日期，结束日期，和商品名称搜索出库单条目
	 * 参数           状态       结果
	 * -----------------------------------
	 * begin          null
	 * end            null      所有出库单
	 * product        null
	 * ----------------------------------- 
	 * begin          ！null
	 * end            null      所有小于结束时间的出库单
	 * product        null
	 * ----------------------------------- 
	 * begin          null
	 * end            ！null      所有大于开始时间的出库单
	 * product        null
	 * ----------------------------------- 
	 * begin          ！null
	 * end            ！null      所有大于开始时间，小于结束时间的出库单
	 * product        null
	 * ----------------------------------- 
	 * begin          null
	 * end            null      所有该类似商品名字的出库单
	 * product        ！null
	 * ----------------------------------- 
	 * begin          ！null
	 * end            null      所有类似商品名字的，大于开始时间的出库单
	 * product        ！null
	 * ----------------------------------- 
	 * begin          null
	 * end            ！null      所有类似商品名字的，小于结束时间的出库单
	 * product        ！null
	 * ----------------------------------- 
	 * begin          ！null
	 * end            ！null      所有类似商品名字的，大于开始时间，小于结束时间的出库单
	 * product        ！null
	 * ----------------------------------- 
	 * 
	 * **/
	public	List<OutStorageOrderItem> findOutStorageOrder(Date begin, Date end, String product);

}

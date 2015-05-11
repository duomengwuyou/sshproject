package com.neusoft.logistics.service.inter.storemanage;

import java.sql.Date;

import com.neusoft.logistics.bean.User;

public interface ITaskOrderService {
	/**
	 * 根据任务单号来查找任务单
	 * @param taskOrderId
	 * @return String
	 * @throws Exception
	 */
	public String searchTaskOrder(int taskOrderId,User userTemp) throws Exception;
	//public String searchTaskOrder(int taskOrderId) throws Exception;
	/**
	 * 确定领货
	 * @param taskOrderId
	 * @param deliverman
	 * @param takeProductDate
	 * @return
	 */
	public boolean saveTakeProduct(int taskOrderId,String deliverman,Date  takeProductDate);
	/**
	 * 保存库存
	 * @param userTemp
	 * @param taskOrderId
	 * @return
	 */
	public boolean saveSubstationProduct(User userTemp,int taskOrderId );
}

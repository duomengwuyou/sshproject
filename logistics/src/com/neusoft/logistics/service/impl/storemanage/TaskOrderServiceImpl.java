package com.neusoft.logistics.service.impl.storemanage;

import java.sql.Date;
import java.util.Iterator;
import java.util.List;

import com.neusoft.logistics.bean.DispatchOrderItem;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.SubstationInStorageOrder;
import com.neusoft.logistics.bean.SubstationInStorageOrderItem;
import com.neusoft.logistics.bean.TakeProductOrder;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.ITakeProductOrderDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.dao.inter.IUserDAO;
import com.neusoft.logistics.service.inter.storemanage.ITaskOrderService;
import com.neusoft.logistics.utils.JSONHelper;

public class TaskOrderServiceImpl implements ITaskOrderService {
	private ITaskOrderDAO taskOrderDAO;
	private ITakeProductOrderDAO takeProductOrderDAO;
	private IUserDAO userDAO;
	private IStorageInfoDAO storageInfoDAO;
	private IOrderDAO orderDAO;
	
	public IStorageInfoDAO getStorageInfoDAO() {
		return storageInfoDAO;
	}

	public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
		this.storageInfoDAO = storageInfoDAO;
	}
	public IUserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(IUserDAO userDAO) {
		this.userDAO = userDAO;
	}
	public ITakeProductOrderDAO getTakeProductOrderDAO() {
		return takeProductOrderDAO;
	}

	public void setTakeProductOrderDAO(ITakeProductOrderDAO takeProductOrderDAO) {
		this.takeProductOrderDAO = takeProductOrderDAO;
	}

	public ITaskOrderDAO getTaskOrderDAO() {
		return taskOrderDAO;
	}

	public void setTaskOrderDAO(ITaskOrderDAO taskOrderDAO) {
		this.taskOrderDAO = taskOrderDAO;
	}

	public String searchTaskOrder(int taskOrderId,User userTemp) throws Exception{
		User user = userDAO.findById(userTemp.getUserid());
		Substation substation = null;
		if(user!=null){
			Iterator iterator = user.getLSubstations().iterator();
			if(iterator.hasNext()){
				substation = (Substation) iterator.next();
			}
			//substationList = substationDAO.findByUser(user);
		}
		System.out.println("进入searchTaskOrder");
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		int up = 0;
		if(taskOrderId<0){
			//System.out.println("taskOrderId<0");
			List<TaskOrder> list = taskOrderDAO.findAll();
			for(int i=0;i<list.size();i++){
				TaskOrder taskOrder = list.get(i);
				if(taskOrder.getTaskorderstate().equals("已分配")&&taskOrder.getLOrder().getLSubstationByDeliversubstation().getSubstationid()==substation.getSubstationid()){
					Iterator<OrderItem> iter = taskOrder.getLOrder().getLOrderitems().iterator();
					while(iter.hasNext()){
						up++;
						OrderItem orderItem = iter.next();
						json.AddItem("id", Integer.toString(up));
						//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
						json.AddItem("taskOrderId",Integer.toString(taskOrder.getTaskorderid()));
						json.AddItem("productName", orderItem.getProductname());
						json.AddItem("productQuantity", Integer.toString(orderItem.getOrderitemamount()));
						json.AddItem("taskOrderState", taskOrder.getTaskorderstate());
						json.ItemOK();
						sign = true;
					}
				}
			}
			String jsons = "";
			if(sign){
				jsons = json.toString();
				sign = false;
			}else {
				jsons = "{success : true,data:[]}";
			}
			up = 0;
			return jsons;
		}else{
			//System.out.println("taskOrderId》=0");
			TaskOrder taskOrder = taskOrderDAO.findById(taskOrderId);
			if(taskOrder.getTaskorderstate().equals("已分配")&&taskOrder.getLOrder().getLSubstationByDeliversubstation().getSubstationid()==substation.getSubstationid()){
				Iterator<OrderItem> iter = taskOrder.getLOrder().getLOrderitems().iterator();
				while(iter.hasNext()){
					up++;
					OrderItem orderItem = iter.next();
					json.AddItem("id", Integer.toString(up));
					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("taskOrderId",Integer.toString(taskOrder.getTaskorderid()));
					json.AddItem("productName", orderItem.getProductname());
					json.AddItem("productQuantity", Integer.toString(orderItem.getOrderitemamount()));
					json.AddItem("taskOrderState", taskOrder.getTaskorderstate());
					json.ItemOK();
					sign = true;
				}
			}
			String jsons = "";
			if(sign){
				jsons = json.toString();
				sign = false;
			}else {
				jsons = "{success : true,data:[]}";
			}
			return jsons;
		}
	}
	public boolean saveTakeProduct(int taskOrderId,String deliverman,Date  takeProductDate){
		//System.out.println("进入sureTakeProduct中");
		TakeProductOrder takeProductOrder = new TakeProductOrder();
		takeProductOrder.setDeliverman(deliverman);
		//System.out.println("deliverman为："+takeProductOrder.getDeliverman());
		TaskOrder taskOrder = taskOrderDAO.findById(taskOrderId);
		taskOrderDAO.modifyTastState(taskOrder.getTaskorderid(), "已领货");
		taskOrder.getLOrder().setOrderstate("已领货");
		//taskOrder.setTaskorderstate("已领货");
		takeProductOrder.setLTaskorder(taskOrder);
		//System.out.println("getTaskorderstate:"+takeProductOrder.getLTaskorder().getTaskorderstate());
		takeProductOrder.setTakedate(takeProductDate);
		//System.out.println("takeProductDate"+takeProductOrder.getTakedate());
		
		takeProductOrderDAO.save(takeProductOrder);
		return true;
	}
	//修改库存
	public boolean saveSubstationProduct(User userTemp,int taskOrderId ){
		User user = userDAO.findById(userTemp.getUserid());
		TaskOrder  taskOrder = taskOrderDAO.findById(taskOrderId);
		Order order = null;
		if(taskOrder != null){
			order = taskOrder.getLOrder();
		}
		
		List<Substation> substationList = null;
		Substation substation = null;
		if(user!=null){
			Iterator iterator = user.getLSubstations().iterator();
			if(iterator.hasNext()){
				substation = (Substation) iterator.next();
			}
			//substationList = substationDAO.findByUser(user);
		}
		if(substation!=null&&order!=null){
			Iterator iter = order.getLOrderitems().iterator();
			while(iter.hasNext()){
				OrderItem orderItem = (OrderItem) iter.next();
				List<StorageInfo> storageInfoList = storageInfoDAO.findStorageInfoByWarehouseProduct(substation.getLWarehouse(), orderItem.getLProduct());
				if(storageInfoList.size()==0){
					//System.out.println("+++++++++++++++++++++++++++++asdfsdfasdfasdf");
					return false;
				}else{
					//System.out.println("=============================asdfsdfasdfasdf");
					StorageInfo storageInfo = storageInfoList.get(0);
					storageInfo.setRemainquantity(storageInfo.getRemainquantity()-orderItem.getOrderitemamount());
				}
			}
		}
		return true;
	}

	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}
	
	
	
	
	
	
	
	
}
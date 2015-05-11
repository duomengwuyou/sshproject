package com.neusoft.logistics.service.impl.storemanage;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;


import com.neusoft.logistics.bean.DispatchOrder;
import com.neusoft.logistics.bean.DispatchOrderItem;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.SubstationInStorageOrder;
import com.neusoft.logistics.bean.SubstationInStorageOrderItem;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.IDispatchOrderDAO;
import com.neusoft.logistics.dao.inter.IDispatchOrderItemDAO;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.ISubstationDAO;
import com.neusoft.logistics.dao.inter.ISubstationInStorageOrderDAO;
import com.neusoft.logistics.dao.inter.ISubstationInStorageOrderItemDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.dao.inter.IUserDAO;
import com.neusoft.logistics.service.inter.storemanage.IDispatchOrderService;
import com.neusoft.logistics.utils.JSONHelper;

public class DispatchOrderServiceImpl implements IDispatchOrderService {
	private IDispatchOrderItemDAO dispatchOrderItemDAO;
	private ITaskOrderDAO taskOrderDAO;
	private ISubstationInStorageOrderDAO  substationInStorageOrderDAO;
	private ISubstationInStorageOrderItemDAO substationInStorageOrderItemDAO;
	private IOrderDAO orderDAO;
	private ISubstationDAO substationDAO;
	private IUserDAO userDAO;
	private IStorageInfoDAO storageInfoDAO;
	
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

	public ISubstationDAO getSubstationDAO() {
		return substationDAO;
	}

	public void setSubstationDAO(ISubstationDAO substationDAO) {
		this.substationDAO = substationDAO;
	}

	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	public ITaskOrderDAO getTaskOrderDAO() {
		return taskOrderDAO;
	}

	public void setTaskOrderDAO(ITaskOrderDAO taskOrderDAO) {
		this.taskOrderDAO = taskOrderDAO;
	}

	public ISubstationInStorageOrderItemDAO getSubstationInStorageOrderItemDAO() {
		return substationInStorageOrderItemDAO;
	}

	public void setSubstationInStorageOrderItemDAO(
			ISubstationInStorageOrderItemDAO substationInStorageOrderItemDAO) {
		this.substationInStorageOrderItemDAO = substationInStorageOrderItemDAO;
	}

	public ISubstationInStorageOrderDAO getSubstationInStorageOrderDAO() {
		return substationInStorageOrderDAO;
	}

	public void setSubstationInStorageOrderDAO(
			ISubstationInStorageOrderDAO substationInStorageOrderDAO) {
		this.substationInStorageOrderDAO = substationInStorageOrderDAO;
	}

	public IDispatchOrderItemDAO getDispatchOrderItemDAO() {
		return dispatchOrderItemDAO;
	}

	public void setDispatchOrderItemDAO(IDispatchOrderItemDAO dispatchOrderItemDAO) {
		this.dispatchOrderItemDAO = dispatchOrderItemDAO;
	}
	
	private IDispatchOrderDAO  dispatchOrderDAO;
	
	public IDispatchOrderDAO getDispatchOrderDAO() {
		return dispatchOrderDAO;
	}

	public void setDispatchOrderDAO(IDispatchOrderDAO dispatchOrderDAO) {
		this.dispatchOrderDAO = dispatchOrderDAO;
	}

	public String searchDispatchOrder(int dispatchOrderId, User userTemp) throws Exception{
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		Date date = dispatchOrderItemDAO.currentDate();
		User user = userDAO.findById(userTemp.getUserid());
		List<Substation> substationList = null;
		Substation substation = null;
		if(user!=null){
			Iterator iterator = user.getLSubstations().iterator();
			if(iterator.hasNext()){
				substation = (Substation) iterator.next();
			}
			//substationList = substationDAO.findByUser(user);
		}
		
		//java.util.Set<User> set=new HashSet<User>();
		//set.add(user);
		//查找到分站库房对象，为了根据分站库房找到相应的id
		
	   // List<Substation> substationList = substationDAO.findByProperty("LUsers", set);
	   // Substation substation = null;
	    //如果找到了分站库房，则将其赋值给substation
//	    if(substationList.size()>0){
//	    	substation = substationList.get(0);
//	    }
	    
	    if(substation!=null){
	    	System.out.println("得到的结果不为空："+substation.getSubstationadd());
	    	System.out.println("得到的结果不为空："+substation.getSubstationid());
	    	System.out.println("得到的结果不为空："+substation.getSubstationtel());
	    	System.out.println("！！！substation.getLWarehouse().getWarehouseaddress();的结果为："+substation.getLWarehouse().getWarehouseaddress());
	    }else{
	    	System.out.println("得到的结果为空伤不起：");
	    }
	    
		if(substation!=null&&dispatchOrderId<0){
			System.out.println("传来订单号小于零为："+dispatchOrderId);
			//根据分站库房找到分发单
			List<DispatchOrder> dispatchOrderList = dispatchOrderDAO.findByProperty("LWarehouse", substation.getLWarehouse());
			//根据找到的分发单找相应的条目
			List<DispatchOrderItem> list = new ArrayList<DispatchOrderItem>();
			for(int i=0;i<dispatchOrderList.size();i++){
				
				DispatchOrder dispatchOrder = dispatchOrderList.get(i);
				System.out.println("找到了分发单号："+dispatchOrder.getDispatchorderid());
				Iterator iter = (Iterator) dispatchOrder.getLDispatchorderitems().iterator();
				while(iter.hasNext()){
					DispatchOrderItem dispatchOrderItemTemp = (DispatchOrderItem) iter.next();
					System.out.println("找到了分发单对应的条目ID为："+dispatchOrderItemTemp.getDispatchorderitemid());
					list.add(dispatchOrderItemTemp);
					System.out.println("找到了分发单对应的条目数目数据插入完毕了");
				}
			}
			System.out.println("list的size为："+list.size());
			//List<DispatchOrderItem> list = dispatchOrderItemDAO.findByProperty("LDispatchorder", value);
			System.out.println("封装为JSON格式");
			for(int i=0;i<list.size();i++){
				DispatchOrderItem dispatchOrderItem = list.get(i);
				//根据分发单号查找分站入库单的信息，如果为0，则说明没有入库，如果找到分站入库单，则说明已经入库
				List<SubstationInStorageOrder> subsationInStorageOrderList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
				if(subsationInStorageOrderList.size()==0){
					System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0成立");
					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
					int realIntoQuantity = 0;
					SubstationInStorageOrder substationInStorageOrder = null;  
					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
					if(substationInStorageOrderDAOList.size()!=0){
						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
					}
					if(substationInStorageOrder!=null){
						SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
						if(substationInStorageOrderItem != null){
							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
						}
					}
					json.AddItem("realIntoQuantity",Integer.toString(dispatchOrderItem.getProductquantity()));
					json.AddItem("realIntoDate", date.toString());
					//json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
					json.AddItem("receiveFormRemark", "未入库");
					json.ItemOK();
					sign = true;
				}else{
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立");
					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成2");
					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立3");
					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立4");
					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立5");
					int realIntoQuantity = 0;
					SubstationInStorageOrder substationInStorageOrder = null;  
					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
					if(substationInStorageOrderDAOList.size()!=0){
						//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立6");
						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
					}
					SubstationInStorageOrderItem substationInStorageOrderItem = null;
					if(substationInStorageOrder!=null){
						//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立7");
						substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
						//分发单的入库时间
						json.AddItem("realIntoDate", substationInStorageOrder.getInstoragedate().toString());
						if(substationInStorageOrderItem != null){
							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
						}
					}
					json.AddItem("realIntoQuantity", Integer.toString(realIntoQuantity));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立8");
					
					//json.AddItem("realIntoDate", dispatchOrderItem.getLDispatchorder().getDipatchdate().toString());
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立8");
					//json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
					json.AddItem("receiveFormRemark", "已入库");
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
		}else if(substation!=null){
			//List<DispatchOrderItem> list = dispatchOrderItemDAO.findByProperty("LDispatchorder",dispatchOrderDAO.findById(dispatchOrderId));
			DispatchOrder dispatchOrderTemp = dispatchOrderDAO.findById(dispatchOrderId);
			if(dispatchOrderTemp==null||dispatchOrderTemp.getLWarehouse().getWarehouseid()!=substation.getLWarehouse().getWarehouseid()){
				return "{success : true,data:[]}";
			}
			System.out.println("传来分发单号不小于零为："+dispatchOrderId);
			//根据分站库房找到分发单
			List<DispatchOrder> dispatchOrderList = dispatchOrderDAO.findByProperty("LWarehouse", substation.getLWarehouse());
			//根据找到的分发单找相应的条目
			//List<DispatchOrderItem> list = new ArrayList<DispatchOrderItem>();
			//list = (List<DispatchOrderItem>) dispatchOrderTemp.getLDispatchorderitems();
			Iterator iter = dispatchOrderTemp.getLDispatchorderitems().iterator();
			while(iter.hasNext()){
				DispatchOrderItem dispatchOrderItem = (DispatchOrderItem) iter.next();
				//根据分发单号查找分站入库单的信息，如果为0，则说明没有入库，如果找到分站入库单，则说明已经入库
				List<SubstationInStorageOrder> subsationInStorageOrderList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
				if(subsationInStorageOrderList.size()==0){
					System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0成立");
					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
					int realIntoQuantity = 0;
					SubstationInStorageOrder substationInStorageOrder = null;  
					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
					if(substationInStorageOrderDAOList.size()!=0){
						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
					}
					if(substationInStorageOrder!=null){
						SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
						if(substationInStorageOrderItem != null){
							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
						}
					}
					json.AddItem("realIntoQuantity",Integer.toString(dispatchOrderItem.getProductquantity()));
					json.AddItem("realIntoDate", date.toString());
					//json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
					json.AddItem("receiveFormRemark", "未入库");
					json.ItemOK();
					sign = true;
				}else{
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立");
					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成2");
					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立3");
					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立4");
					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立5");
					int realIntoQuantity = 0;
					SubstationInStorageOrder substationInStorageOrder = null;  
					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
					if(substationInStorageOrderDAOList.size()!=0){
						//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立6");
						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
					}
					SubstationInStorageOrderItem substationInStorageOrderItem = null;
					if(substationInStorageOrder!=null){
						//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立7");
						substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
						//分发单的入库时间
						json.AddItem("realIntoDate", substationInStorageOrder.getInstoragedate().toString());
						if(substationInStorageOrderItem != null){
							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
						}
					}
					json.AddItem("realIntoQuantity", Integer.toString(realIntoQuantity));
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立8");
					
					//json.AddItem("realIntoDate", dispatchOrderItem.getLDispatchorder().getDipatchdate().toString());
					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立8");
					//json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
					json.AddItem("receiveFormRemark", "已入库");
					json.ItemOK();
					sign = true;
				}
			}
//			for(int i=0;i<dispatchOrderList.size();i++){
//				DispatchOrder dispatchOrder = dispatchOrderList.get(i);
//				System.out.println("找到了分发单号："+dispatchOrder.getDispatchorderid());
//				Iterator iter = (Iterator) dispatchOrder.getLDispatchorderitems().iterator();
//				while(iter.hasNext()){
//					DispatchOrderItem dispatchOrderItemTemp = (DispatchOrderItem) iter.next();
//					//System.out.println("找到了分发单对应的条目ID为："+dispatchOrderItemTemp.getDispatchorderitemid());
//					list.add(dispatchOrderItemTemp);
//					//System.out.println("找到了分发单对应的条目数目数据插入完毕了");
//				}
//			}
//			System.out.println("list的size为："+list.size());
			
//			for(int i=0;i<list.size();i++){
//				DispatchOrderItem dispatchOrderItem = list.get(i);
//				//根据分发单号查找分站入库单的信息，如果为0，则说明没有入库，如果找到分站入库单，则说明已经入库
//				List<SubstationInStorageOrder> subsationInStorageOrderList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//				if(subsationInStorageOrderList.size()==0){
//					System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0成立");
//					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
//					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
//					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
//					int realIntoQuantity = 0;
//					SubstationInStorageOrder substationInStorageOrder = null;  
//					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//					if(substationInStorageOrderDAOList.size()!=0){
//						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
//					}
//					if(substationInStorageOrder!=null){
//						SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
//						if(substationInStorageOrderItem != null){
//							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
//						}
//					}
//					json.AddItem("realIntoQuantity",Integer.toString(dispatchOrderItem.getProductquantity()));
//					json.AddItem("realIntoDate", date.toString());
//					//json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
//					json.AddItem("receiveFormRemark", "未入库");
//					json.ItemOK();
//					sign = true;
//				}else{
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立");
//					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成2");
//					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立3");
//					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立4");
//					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立5");
//					int realIntoQuantity = 0;
//					SubstationInStorageOrder substationInStorageOrder = null;  
//					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//					if(substationInStorageOrderDAOList.size()!=0){
//						//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立6");
//						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
//					}
//					SubstationInStorageOrderItem substationInStorageOrderItem = null;
//					if(substationInStorageOrder!=null){
//						//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立7");
//						substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
//						//分发单的入库时间
//						json.AddItem("realIntoDate", substationInStorageOrder.getInstoragedate().toString());
//						if(substationInStorageOrderItem != null){
//							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
//						}
//					}
//					json.AddItem("realIntoQuantity", Integer.toString(realIntoQuantity));
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立8");
//					
//					//json.AddItem("realIntoDate", dispatchOrderItem.getLDispatchorder().getDipatchdate().toString());
//					//System.out.println("++++++++++++++++subsationInStorageOrderList.size()==0不成立8");
//					//json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
//					json.AddItem("receiveFormRemark", "已入库");
//					json.ItemOK();
//					sign = true;
//				}
//				
//			}
			
//			for(int i=0;i<list.size();i++){
//				DispatchOrderItem dispatchOrderItem = list.get(i);
//				//根据分发单号查找分站入库单的信息，如果为0，则说明没有入库，如果找到分站入库单，则说明已经入库
//				List<SubstationInStorageOrder> subsationInStorageOrderList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//				if(subsationInStorageOrderList.size()==0){
//					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
//					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
//					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
//					int realIntoQuantity = 0;
//					SubstationInStorageOrder substationInStorageOrder = null;  
//					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//					if(substationInStorageOrderDAOList.size()!=0){
//						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
//					}
//					if(substationInStorageOrder!=null){
//						SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
//						if(substationInStorageOrderItem != null){
//							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
//						}
//					}
//					json.AddItem("realIntoQuantity",Integer.toString(dispatchOrderItem.getProductquantity()));
//					json.AddItem("realIntoDate", date.toString());
//					json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
//					json.ItemOK();
//					sign = true;
//				}else{
//					json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
//					//json.AddItem("dispatchOrderItemId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//					json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
//					json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
//					int realIntoQuantity = 0;
//					SubstationInStorageOrder substationInStorageOrder = null;  
//					List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//					if(substationInStorageOrderDAOList.size()!=0){
//						substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
//					}
//					SubstationInStorageOrderItem substationInStorageOrderItem = null;
//					if(substationInStorageOrder!=null){
//						substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
//						if(substationInStorageOrderItem != null){
//							realIntoQuantity = substationInStorageOrderItem.getProductquantity();
//						}
//					}
//					json.AddItem("realIntoQuantity", Integer.toString(realIntoQuantity));
//					json.AddItem("realIntoDate",date.toString());
//					json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
//					json.ItemOK();
//					sign = true;
//				}
//				DispatchOrderItem dispatchOrderItem = list.get(i);
//				json.AddItem("id", Integer.toString(dispatchOrderItem.getDispatchorderitemid()));
//				json.AddItem("dispatchOrderId",Integer.toString(dispatchOrderItem.getLDispatchorder().getDispatchorderid()));
//				json.AddItem("productName", dispatchOrderItem.getLProduct().getProductname());
//				json.AddItem("productQuantity", Integer.toString(dispatchOrderItem.getProductquantity()));
//				int realIntoQuantity = 0;
//				//SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder()).get(0);
//				SubstationInStorageOrder substationInStorageOrder = null;  
//				List substationInStorageOrderDAOList = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder());
//				if(substationInStorageOrderDAOList.size()!=0){
//					substationInStorageOrder = (SubstationInStorageOrder) substationInStorageOrderDAOList.get(0);
//				}
//				if(substationInStorageOrder!=null){
//					SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrder);
//					if(substationInStorageOrderItem != null){
//						realIntoQuantity = substationInStorageOrderItem.getProductquantity();
//					}
//				}
//				json.AddItem("realIntoQuantity", Integer.toString(realIntoQuantity));
//				//json.AddItem("realIntoQuantity", Integer.toString(substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(),substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder()).get(0)).getProductquantity()));
//				json.AddItem("realIntoDate",date.toString());
//				json.AddItem("receiveFormRemark", dispatchOrderItem.getLDispatchorder().getDipatchorderremark());
//				json.ItemOK();
//				sign = true;
//			}
			String jsons = "";
			if(sign){
				jsons = json.toString();
				sign = false;
			}else {
				jsons = "{success : true,data:[]}";
			}
			return jsons;
		}
		return null;
	}
	//保存真实入库信息
	public boolean saveRealIntoQuantity ( int dispatchOrderItemId , int realIntoQuantity){
		System.out.println("saveRealIntoQuantity中dispatchOrderItemId为："+dispatchOrderItemId);
		System.out.println("saveRealIntoQuantity中realIntoQuantity为："+realIntoQuantity);
		//SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.
		DispatchOrderItem dispatchOrderItem = dispatchOrderItemDAO.findById(dispatchOrderItemId);
		if(dispatchOrderItem==null)return false;
		else{
			//DispatchOrder dispatchOrder = dispatchOrderItemDAO.findByProperty("LDispatchorder", dispatchOrderItem)
			//dispatchOrderItem.setProductquantity(realIntoQuantity);
			//根据分发单号来查找相应的分站库房入库单。
			//System.out.println("ProductName为："+dispatchOrderItem.getLProduct().getProductname());
			//System.out.println("LDispatchorder的id为：："+dispatchOrderItem.getLDispatchorder().getDispatchorderid());
			//SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.findById(0);
			//List list = substationInStorageOrderDAO.findByProperty("subsationinstorageorderid", 12);
//			if(list.size()==0){
//				System.out.println("获取对象为空！");
//				return false;
//			}
			//SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.findByProperty("subsationinstorageorderid", 0).get(0);
			//根据分发单条目找到分发单，然后根据分发单找到相应的分站入库单
			System.out.println("根据分发单条目找到分发单，然后根据分发单找到相应的分站入库单!!!!");
			SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.findByDispatchorder(dispatchOrderItem.getLDispatchorder());
			//SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.findByProperty("LDispatchorder", dispatchOrderItem.getLDispatchorder()).get(0);
			System.out.println("根据分发单条目找到分发单，然后根据分发单找到相应的分站入库单");
			//如果分站库房入库单还没有该订单的入库记录，则新加一条；如果有该订单的入库记录，则更新原记录。
			if(substationInStorageOrder==null){
				System.out.println("分站入库单为空，没有找到！");
				//System.out.println("substationInStorageOrder为空，新加一个substationInStorageOrder！");
				//由于没有根据分发单找到看相应的分站入库单，则说明里面还没有相关的条目，则增加一条
				substationInStorageOrder = new SubstationInStorageOrder();
				Date date = substationInStorageOrderDAO.currentDate();
				substationInStorageOrder.setInstoragedate(date);
				substationInStorageOrder.setInstorageremark("已入库");
				substationInStorageOrder.setLDispatchorder(dispatchOrderItem.getLDispatchorder());
				substationInStorageOrderDAO.attachDirty(substationInStorageOrder);
				//为新建的库房入库单增加一个条目
				SubstationInStorageOrderItem substationInStorageOrderItem =  new SubstationInStorageOrderItem();
				substationInStorageOrderItem.setLProduct(dispatchOrderItem.getLProduct());
				substationInStorageOrderItem.setProductquantity(realIntoQuantity);
				substationInStorageOrderItem.setLSubsationinstorageorder(substationInStorageOrder);
				//substationInStorageOrderItemDAO
				substationInStorageOrderItemDAO.attachDirty(substationInStorageOrderItem);
			} else {
				//System.out.println("substationInStorageOrder不为空，新加一个substationInStorageOrderItem！");
				//如果substationInStorageOrderItem为空则说明入库的条目还没有这个产品，则需要新建一个条目;
				//如果入库条目有这个产品，则说明用户在修改入库产品的数量，则需要在原来的基础之上修改入库的产品数量
				System.out.println("如果入库条目有这个产品，则说明用户在修改入库产品的数量，则需要在原来的基础之上修改真实入库的产品数量");
				SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(), substationInStorageOrder);
				if(substationInStorageOrderItem!=null){
					//修改产品数量
					substationInStorageOrderItem.setProductquantity(realIntoQuantity);
					substationInStorageOrderItemDAO.attachDirty(substationInStorageOrderItem);
				}else{
					//增加一个条目
					substationInStorageOrderItem = new SubstationInStorageOrderItem();
					substationInStorageOrderItem.setLProduct(dispatchOrderItem.getLProduct());
					substationInStorageOrderItem.setProductquantity(realIntoQuantity);
					substationInStorageOrderItem.setLSubsationinstorageorder(substationInStorageOrder);
					substationInStorageOrderItemDAO.attachDirty(substationInStorageOrderItem);
				}
				//substationInStorageOrderItem.setLSubsationinstorageorder(substationInStorageOrder);
				
			}
			//dispatchOrderItemDAO.attachDirty(dispatchOrderItem);
		}
		//dispatchOrderDAO.findById(dispatchOrderId).setProductquantity(realIntoQuantity);
		return true;
	}
	//更新任务单和订单状态
	public boolean updateTaskOrderState(Substation substation){
		System.out.println("updateTaskOrderState正在执行中……………………………………");
		System.out.println("分站库房号为："+substation.getSubstationid());
		//如果该分发单号下的所有产品都已经到货，则修改状态
		//List<Order> list = orderDAO.findByProperty("LSubstationByDeliversubstation", substation);
		List<Order> list = orderDAO.findBySubstation(substation);
		for(int i=0;i<list.size();i++){
			System.out.println("!!!!!!!!!!!!!!!!!!!list不为空！");
			Order order = list.get(i);
			if(order.getOrderstate().equals("中心库房出库")||order.getOrderstate()=="中心库房出库"){
				System.out.println("!!!!!!!!!!!!!!!!!!!如果为中心库房出库！");
				order.setOrderstate("分站到货");
				//List<TaskOrder> taskOrderList = taskOrderDAO.findByProperty("LOrder", order);
				List<TaskOrder> taskOrderList = taskOrderDAO.findByOrder(order);
				System.out.println("!!!!!!!!!!!!!!!!!!!扛不住！");
				for(int j=0;j<taskOrderList.size();j++){
					System.out.println("!!!!!!!!!!!!!!!!!!!taskOrderList.size()为："+taskOrderList.size());
					TaskOrder taskOrder = taskOrderList.get(j);
					if(taskOrder!=null){
						System.out.println("!!!!!!!!!!!!!!!!!!!坤龙高能发生的！");
						taskOrderDAO.modifyTastState(taskOrder.getTaskorderid(), "可分配");
						//taskOrder.setTaskorderstate("可分配");
					}
				}
			}else{
				System.out.println("没有订单的状态为中心库房出库！");
				System.out.println("订单号为:"+order.getOrderid());
				System.out.println("订单的状态为:"+order.getOrderstate());
			}
		}
		return true;
	
	}
	//修改库存
	public boolean saveSubstationProduct(User userTemp,int dispatchOrderItemId , int realIntoQuantity){
		User user = userDAO.findById(userTemp.getUserid());
		//System.out.println("realIntoQuantity真实入库数量"+realIntoQuantity);
		DispatchOrderItem dispatchOrderItem = dispatchOrderItemDAO.findById(dispatchOrderItemId);
		List<Substation> substationList = null;
		Substation substation = null;
		if(user!=null){
			Iterator iterator = user.getLSubstations().iterator();
			if(iterator.hasNext()){
				substation = (Substation) iterator.next();
			}
			//substationList = substationDAO.findByUser(user);
		}
		if(substation!=null){
			SubstationInStorageOrder substationInStorageOrder = substationInStorageOrderDAO.findByDispatchorder(dispatchOrderItem.getLDispatchorder());
			//如果存在则说明只是修改数量而已，不存在则只是插入而已
			if(substationInStorageOrder == null){
				List<StorageInfo> storageInfoList = storageInfoDAO.findStorageInfoByWarehouseProduct(substation.getLWarehouse(), dispatchOrderItem.getLProduct());
				if(storageInfoList.size()==0){
					//如果插入的产品没有
					StorageInfo storageInfo = new StorageInfo();
					storageInfo.setLProduct(dispatchOrderItem.getLProduct());
					storageInfo.setLWarehouse(substation.getLWarehouse());
					storageInfo.setMaxquantity(40000);
					storageInfo.setRemainquantity(realIntoQuantity);
					//System.out.println("realIntoQuantity真实入库数量"+realIntoQuantity);
					storageInfo.setWarningquantity(20000);
					storageInfoDAO.save(storageInfo);
				}else{
					//如果插入的产品已经有
					StorageInfo storageInfo = storageInfoList.get(0);
					//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@realIntoQuantity真实入库数量"+realIntoQuantity);
					//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
					storageInfo.setRemainquantity(storageInfo.getRemainquantity()+realIntoQuantity);
					//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
				}
			}else{
				SubstationInStorageOrderItem substationInStorageOrderItem = substationInStorageOrderItemDAO.findByProductSubstationInStorageOrder(dispatchOrderItem.getLProduct(), substationInStorageOrder);
				if(substationInStorageOrderItem==null){
					List<StorageInfo> storageInfoList = storageInfoDAO.findStorageInfoByWarehouseProduct(substation.getLWarehouse(), dispatchOrderItem.getLProduct());
					if(storageInfoList.size()==0){
						StorageInfo storageInfo = new StorageInfo();
						storageInfo.setLProduct(dispatchOrderItem.getLProduct());
						storageInfo.setLWarehouse(substation.getLWarehouse());
						storageInfo.setMaxquantity(40000);
						//System.out.println("！！！！！！！！！！！！realIntoQuantity真实入库数量"+realIntoQuantity);
						storageInfo.setRemainquantity(realIntoQuantity);
						storageInfo.setWarningquantity(20000);
						storageInfoDAO.save(storageInfo);
					}else{
						StorageInfo storageInfo = storageInfoList.get(0);
						//System.out.println("---------------------------------realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
						storageInfo.setRemainquantity(storageInfo.getRemainquantity()+realIntoQuantity);
						//System.out.println("---------------------------------realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
					}
				}else{
					List<StorageInfo> storageInfoList = storageInfoDAO.findStorageInfoByWarehouseProduct(substation.getLWarehouse(), dispatchOrderItem.getLProduct());
					if(storageInfoList.size()==0){
						StorageInfo storageInfo = new StorageInfo();
						storageInfo.setLProduct(dispatchOrderItem.getLProduct());
						storageInfo.setLWarehouse(substation.getLWarehouse());
						storageInfo.setMaxquantity(40000);
						storageInfo.setRemainquantity(realIntoQuantity-substationInStorageOrderItem.getProductquantity());
						//System.out.println("=====================realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
						storageInfo.setWarningquantity(20000);
						storageInfoDAO.save(storageInfo);
					}else{
						StorageInfo storageInfo = storageInfoList.get(0);
						//System.out.println("++++++++++++++++++++realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
						storageInfo.setRemainquantity(storageInfo.getRemainquantity()+realIntoQuantity-substationInStorageOrderItem.getProductquantity());
						//System.out.println("++++++++++++++++++++realIntoQuantity真实入库数量"+storageInfo.getRemainquantity());
					}
				}
			}
		}
		return true;
	}

}
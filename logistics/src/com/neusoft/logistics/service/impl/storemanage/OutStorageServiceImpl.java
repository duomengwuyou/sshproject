package com.neusoft.logistics.service.impl.storemanage;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.neusoft.logistics.bean.AllocationOrder;
import com.neusoft.logistics.bean.DispatchOrder;
import com.neusoft.logistics.bean.DispatchOrderItem;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.OutStorageOrder;
import com.neusoft.logistics.bean.OutStorageOrderItem;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IAllocationOrderDAO;
import com.neusoft.logistics.dao.inter.IDispatchOrderDAO;
import com.neusoft.logistics.dao.inter.IDispatchOrderItemDAO;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.IOrderItemDAO;
import com.neusoft.logistics.dao.inter.IOutStorageOrderDAO;
import com.neusoft.logistics.dao.inter.IOutStorageOrderItemDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.ISubstationDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;
import com.neusoft.logistics.service.inter.storemanage.IOutStorageService;
import com.neusoft.logistics.utils.JSONHelper;

public class OutStorageServiceImpl implements IOutStorageService {
	private IAllocationOrderDAO allocationDAO;
	private IDispatchOrderDAO dispatchOrderDAO;
	private IDispatchOrderItemDAO dispatchOrderItemDAO;
	private IOutStorageOrderDAO outStorageOrderDAO;
	private IOutStorageOrderItemDAO outStorageOrderItemDAO;
	private IOrderDAO orderDAO;
	private IOrderItemDAO orderItemDAO;
	private ITaskOrderDAO taskOrderDAO;
	private IStorageInfoDAO storageInfoDAO;
	private ISubstationDAO substationDAO;
	private IWarehouseDAO warehouseDAO;
	public IDispatchOrderDAO getDispatchOrderDAO() {
		return dispatchOrderDAO;
	}

	public void setDispatchOrderDAO(IDispatchOrderDAO dispatchOrderDAO) {
		this.dispatchOrderDAO = dispatchOrderDAO;
	}

	public IDispatchOrderItemDAO getDispatchOrderItemDAO() {
		return dispatchOrderItemDAO;
	}

	public void setDispatchOrderItemDAO(IDispatchOrderItemDAO dispatchOrderItemDAO) {
		this.dispatchOrderItemDAO = dispatchOrderItemDAO;
	}

	public IOutStorageOrderDAO getOutStorageOrderDAO() {
		return outStorageOrderDAO;
	}

	public void setOutStorageOrderDAO(IOutStorageOrderDAO outStorageOrderDAO) {
		this.outStorageOrderDAO = outStorageOrderDAO;
	}

	public IOutStorageOrderItemDAO getOutStorageOrderItemDAO() {
		return outStorageOrderItemDAO;
	}

	public void setOutStorageOrderItemDAO(
			IOutStorageOrderItemDAO outStorageOrderItemDAO) {
		this.outStorageOrderItemDAO = outStorageOrderItemDAO;
	}

	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	public IOrderItemDAO getOrderItemDAO() {
		return orderItemDAO;
	}

	public void setOrderItemDAO(IOrderItemDAO orderItemDAO) {
		this.orderItemDAO = orderItemDAO;
	}

	public ITaskOrderDAO getTaskOrderDAO() {
		return taskOrderDAO;
	}

	public void setTaskOrderDAO(ITaskOrderDAO taskOrderDAO) {
		this.taskOrderDAO = taskOrderDAO;
	}

	public IStorageInfoDAO getStorageInfoDAO() {
		return storageInfoDAO;
	}

	public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
		this.storageInfoDAO = storageInfoDAO;
	}

	public ISubstationDAO getSubstationDAO() {
		return substationDAO;
	}

	public void setSubstationDAO(ISubstationDAO substationDAO) {
		this.substationDAO = substationDAO;
	}

	public IWarehouseDAO getWarehouseDAO() {
		return warehouseDAO;
	}

	public void setWarehouseDAO(IWarehouseDAO warehouseDAO) {
		this.warehouseDAO = warehouseDAO;
	}

	public IAllocationOrderDAO getAllocationDAO() {
		return allocationDAO;
	}

	public void setAllocationDAO(IAllocationOrderDAO allocationDAO) {
		this.allocationDAO = allocationDAO;
	}

	private String itemToJSON(List<AllocationOrder> items) {
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		if (items.size() > 0) {
			for (AllocationOrder o : items) {
				json.AddItem("allocationOrder", Integer.toString(o
						.getAllocationorderid()));
				json.AddItem("order", Integer.toString(o.getLOrder()
						.getOrderid()));
				json.AddItem("RequiredDate", (o.getLOrder().getRequireddate().toString()));
				json.AddItem("substation", (o.getLOrder().getLSubstationByDeliversubstation().getSubstationadd()));
				json.AddItem("warehouse", (o.getLOrder().getLSubstationByDeliversubstation().getLWarehouse().getWarehousename()));
				
				json
				.AddItem("allocationDate", o.getAllocationdate()
						.toString());
				json.AddItem("operator", o.getLUser().getUsername());
				json.AddItem("allocationState", o.getAllocationstate());
				json.ItemOK();
			}
		}
		json.setTotalCount(items.size());
		String jsons = "";
		jsons = json.toString();
		return jsons;
	}

	public String getAllocationOrderByDate(String date) {
		List<AllocationOrder> items;
		if (date == null || date.equals("")) {
			items = allocationDAO.findAll();
			return this.itemToJSON(items);
		} else {
			items = allocationDAO.getAllocationOrderByDate(Date.valueOf(date));
			return this.itemToJSON(items);
		}
	}

	public void saveAllocation(String[] allocations,User user) {

		OutStorageOrder oso=new OutStorageOrder();
		Set<DispatchOrder> dispatchOrders=new HashSet<DispatchOrder>();
		/**遍历所有分站**/
		for(Substation substaion:substationDAO.findAll()){		
			List<Order> orders=new ArrayList<Order>();
			/**遍历所有调拨单的订单，将投递分站和当前分站相同的订单加入orders**/
			for(String temp : allocations){
				Order order = allocationDAO.findById(Integer.parseInt(temp)).getLOrder();   
				if(order.getLSubstationByDeliversubstation().equals(substaion)){
					orders.add(order);
				}
			} 
			System.out.println(this.getClass()+" orders.size="+orders.size());
			Set<DispatchOrderItem> dois=new HashSet<DispatchOrderItem>(); 
			DispatchOrder dorder=new DispatchOrder(); 
			/**遍历相同投递分站的订单**/
			for(Order order:orders){
				/**遍历每个订单的订单条目，如果订单条目中商品在DispatchOrderItem中已存在，则增加DispatchOrderItem中该商品数量，否则新建DispatchOrderItem**/
				for(OrderItem orderItem:order.getLOrderitems()){ 
					if(dois==null||dois.size()==0){
						DispatchOrderItem doi2=new DispatchOrderItem();
						doi2.setLProduct(orderItem.getLProduct());
						doi2.setProductquantity(orderItem.getOrderitemamount());
						doi2.setLDispatchorder(dorder); 
						dois.add(doi2);
						System.out.println(this.getClass()+" dois.size1="+dois.size());
					}else{
						boolean isContained=false;
						for(DispatchOrderItem doi:dois){  
							if(doi.getLProduct().equals(orderItem.getLProduct())){ 
								doi.setProductquantity(doi.getProductquantity()+orderItem.getOrderitemamount());
								dois.add(doi);
								isContained=true;
								break;
							}
							System.out.println(this.getClass()+" dois.size2="+dois.size());
						}
						System.out.println(this.getClass()+" dois.size3="+dois.size());
						if(isContained==false){
							DispatchOrderItem doi2=new DispatchOrderItem();
							doi2.setLProduct(orderItem.getLProduct());
							doi2.setProductquantity(orderItem.getOrderitemamount());
							doi2.setLDispatchorder(dorder);
							dois.add(doi2);
							System.out.println(this.getClass()+" dois.size4="+dois.size());
						}
						System.out.println(this.getClass()+" dois.size5="+dois.size());
					}  
				}
			}  
			System.out.println(this.getClass()+" dois.size6="+dois.size());
			dorder.setLDispatchorderitems(dois);
			dorder.setDipatchdate(substationDAO.currentDate());  
			dorder.setLWarehouse(substaion.getLWarehouse());
			dorder.setLUserByDispatchman(user);
			//应该将库房管理员设置为Dispatchman
			dorder.setLUserByDispatchman(substaion.getLWarehouse().getLUser());
			dorder.setLUserByOperator(user); 
			dorder.setLOutstorageorder(oso); 
			dispatchOrders.add(dorder); 
		}
		Set<OutStorageOrderItem> osois=new HashSet<OutStorageOrderItem>(); 
		for(String temp : allocations){ 
			Order order = allocationDAO.findById(Integer.parseInt(temp)).getLOrder();  
			order.setOrderstate("中心库房出库");   
			for(TaskOrder taskOrder:taskOrderDAO.findByOrder(order)){
				taskOrderDAO.modifyTastState(taskOrder.getTaskorderid(),"已调度");
			}
			for(OrderItem orderItem:order.getLOrderitems()){
				if(osois==null||osois.size()==0){
					OutStorageOrderItem osoi2=new OutStorageOrderItem();
					osoi2.setProductquantity(orderItem.getOrderitemamount());
					osoi2.setLProduct(orderItem.getLProduct());
					osois.add(osoi2);
				}else{
					boolean isContained=false;
					for(OutStorageOrderItem osoi:osois){ 
						if(osoi.getLProduct().equals(orderItem.getLProduct())){ 
							osoi.setProductquantity(osoi.getProductquantity()+orderItem.getOrderitemamount());
							osois.add(osoi);
							isContained=true;
							break;
						}
						System.out.println(this.getClass()+" osois.size1="+osois.size());
					}
					if(isContained==false){ 
						OutStorageOrderItem osoi2=new OutStorageOrderItem();
						osoi2.setProductquantity(orderItem.getOrderitemamount());
						osoi2.setLProduct(orderItem.getLProduct());
						osois.add(osoi2);
					}
				} 
			}
		}
		for(OutStorageOrderItem osoi:osois){
			for(StorageInfo si:storageInfoDAO.findByWarehouse(warehouseDAO.getCenterWarehosue())){
				if(si.getLProduct().equals(osoi.getLProduct()))
					si.setRemainquantity(si.getRemainquantity()-osoi.getProductquantity());
			} 
			osoi.setLOutstorageorder(oso);
		}
		if(osois!=null&&osois.size()>0){
			oso.setLDispatchorders(dispatchOrders);
			oso.setOutstoragedate(substationDAO.currentDate()); 
			oso.setLOutstorageorderitems(osois);
			oso.setLWarehouse(warehouseDAO.getCenterWarehosue());
			outStorageOrderDAO.save(oso);
		}
		for(String temp : allocations){
			AllocationOrder allocation = allocationDAO.findById(Integer.parseInt(temp));   
			allocation.setAllocationstate("已调拨");
		} 
	}

	public String showDetail(String[] allocations) {
		/*OutStorageOrder outStorageOrder=new OutStorageOrder();
		List<Order> orders=new ArrayList<Order>();
		List<Warehouse> warehouses = warehouseDAO.findAll();
		Set<DispatchOrder> dispatchOrders=new HashSet<DispatchOrder>();
		Map<Warehouse,Set<Order>> myMap = new HashMap<Warehouse,Set<Order>>();
		//获得需要出库的所有订单及订单中所包含的所有分站对应的分库
		*//**
		 * 将需要出库的订单按照分库进行分组,分组后的结果存储在myMap结构中,分库作为键,orders为值
		 *//*
		for(String temp : allocations){
			Order order = allocationDAO.findById(Integer.parseInt(temp)).getLOrder(); 
			Warehouse tempWarehouse = order.getLSubstationByDeliversubstation().getLWarehouse();
			if(myMap.get(tempWarehouse)==null||myMap.get(tempWarehouse).size()==0){
				Set<Order> orders1 = new HashSet<Order>();
				orders1.add(order);
				myMap.put(tempWarehouse, orders1);
			}else{
				myMap.get(tempWarehouse).add(order);
			}
		}
		*//**
		 * 遍历myMap,生成相应的分发单
		 *//*
		for(int i=0;i<=warehouses.size()-1;i++){
			if(myMap.get(warehouses.get(i))!=null&&myMap.get(warehouses.get(i)).size()>0){
				DispatchOrder dispatcherOrder = new DispatchOrder();
				dispatcherOrder.setLWarehouse(warehouses.get(i));
				dispatcherOrder.setDipatchdate(substationDAO.currentDate());  
				//dispatcherOrder.setLUserByDispatchman(user);
				dispatcherOrder.setLUserByDispatchman(warehouses.get(i).getLUser());
				//dispatcherOrder.setLUserByOperator(user); 
				dispatcherOrder.setLOutstorageorder(outStorageOrder); 
				Set<Order> os = myMap.get(warehouses.get(i));
				Set<DispatchOrderItem> dispatchOrderItems=new HashSet<DispatchOrderItem>(); 
				if(os!=null&&os.size()>0){
					for(Order o : os){
						Set<OrderItem> items = o.getLOrderitems();
						if(items!=null&&items.size()>0){
							for(OrderItem item : items){
								if(dispatchOrderItems==null||dispatchOrderItems.size()==0){
									DispatchOrderItem dispatchOrderItem1=new DispatchOrderItem();
									dispatchOrderItem1.setLDispatchorder(dispatcherOrder);
									dispatchOrderItem1.setLProduct(item.getLProduct());
									dispatchOrderItem1.setProductquantity(item.getOrderitemamount());
									dispatchOrderItems.add(dispatchOrderItem1);
								}else{
									for(DispatchOrderItem doi:dispatchOrderItems){  
										if(doi.getLProduct().equals(item.getLProduct())){ 
											doi.setProductquantity(doi.getProductquantity()+item.getOrderitemamount());
										}else{ 
											DispatchOrderItem dispatchOrderItem2=new DispatchOrderItem();
											dispatchOrderItem2.setLProduct(item.getLProduct());
											dispatchOrderItem2.setProductquantity(item.getOrderitemamount());
											dispatchOrderItem2.setLDispatchorder(dispatcherOrder);
											dispatchOrderItems.add(dispatchOrderItem2);
										}
									}
								}
							}
						}
					}
				}
				dispatcherOrder.setLDispatchorderitems(dispatchOrderItems);
				dispatchOrders.add(dispatcherOrder);
			}
		}
		return this.dispatchOrdersToJSON(dispatchOrders);*/
		Set<DispatchOrder> dispatchOrders=new HashSet<DispatchOrder>();
		/**遍历所有分站**/
		for(Substation substaion:substationDAO.findAll()){		
			List<Order> orders=new ArrayList<Order>();
			/**遍历所有调拨单的订单，将投递分站和当前分站相同的订单加入orders**/
			for(String temp : allocations){
				Order order = allocationDAO.findById(Integer.parseInt(temp)).getLOrder();   
				if(order.getLSubstationByDeliversubstation().equals(substaion)){
					orders.add(order);
				}
			} 
			System.out.println(this.getClass()+" orders.size="+orders.size());
			Set<DispatchOrderItem> dois=new HashSet<DispatchOrderItem>(); 
			DispatchOrder dorder=new DispatchOrder(); 
			/**遍历相同投递分站的订单**/
			for(Order order:orders){
				/**遍历每个订单的订单条目，如果订单条目中商品在DispatchOrderItem中已存在，则增加DispatchOrderItem中该商品数量，否则新建DispatchOrderItem**/
				for(OrderItem orderItem:order.getLOrderitems()){ 
					if(dois==null||dois.size()==0){
						DispatchOrderItem doi2=new DispatchOrderItem();
						doi2.setLProduct(orderItem.getLProduct());
						doi2.setProductquantity(orderItem.getOrderitemamount());
						doi2.setLDispatchorder(dorder); 
						dois.add(doi2);
						System.out.println(this.getClass()+" dois.size1="+dois.size());
					}else{
						boolean isContained=false;
						for(DispatchOrderItem doi:dois){  
							if(doi.getLProduct().equals(orderItem.getLProduct())){ 
								doi.setProductquantity(doi.getProductquantity()+orderItem.getOrderitemamount());
								dois.add(doi);
								isContained=true;
								break;
							}
							System.out.println(this.getClass()+" dois.size2="+dois.size());
						}
						System.out.println(this.getClass()+" dois.size3="+dois.size());
						if(isContained==false){
							DispatchOrderItem doi2=new DispatchOrderItem();
							doi2.setLProduct(orderItem.getLProduct());
							doi2.setProductquantity(orderItem.getOrderitemamount());
							doi2.setLDispatchorder(dorder);
							dois.add(doi2);
							System.out.println(this.getClass()+" dois.size4="+dois.size());
						}
						System.out.println(this.getClass()+" dois.size5="+dois.size());
					}  
				}
			}  
			System.out.println(this.getClass()+" dois.size6="+dois.size());
			dorder.setLDispatchorderitems(dois);
			dorder.setDipatchdate(substationDAO.currentDate());  
			dorder.setLWarehouse(substaion.getLWarehouse());
			//dorder.setLUserByDispatchman(user);
			//应该将库房管理员设置为Dispatchman
			dorder.setLUserByDispatchman(substaion.getLWarehouse().getLUser());
			//dorder.setLUserByOperator(user); 
			//dorder.setLOutstorageorder(oso); 
			dispatchOrders.add(dorder); 
		}
		return this.dispatchOrdersToJSON(dispatchOrders);
	}

	private String dispatchOrdersToJSON(Set<DispatchOrder> dispatchOrders) {
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		int size=0;
		if (dispatchOrders.size() > 0) {
			int id = 1;
			for (DispatchOrder d : dispatchOrders){
				for(DispatchOrderItem i : (Set<DispatchOrderItem>)d.getLDispatchorderitems()){
					System.out.println("=====d.getLDispatchorderitems"+d.getLDispatchorderitems().size());
					json.AddItem("id",Integer.toString(id++));
					json.AddItem("warehouse",d.getLWarehouse().getWarehousename());
					json.AddItem("productId", Integer.toString(i.getLProduct().getProductid()));
					json.AddItem("productName", i.getLProduct().getProductname());
					json.AddItem("amount", Integer.toString(i.getProductquantity()));
					json.ItemOK();
					size++;
				}
			}
		}
		json.setTotalCount(size);
		String jsons = "";
		jsons = json.toString();
		return jsons;
	}
}

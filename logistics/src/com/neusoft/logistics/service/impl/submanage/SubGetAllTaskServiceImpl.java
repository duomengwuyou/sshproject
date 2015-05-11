package com.neusoft.logistics.service.impl.submanage;


import java.util.List;
import java.util.Set;


import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.service.inter.submanage.ISubGetAllTaskService;
import com.neusoft.logistics.utils.JSONHelper;
/**
 * 
 * @author 李莎
 * 得到一个分站所有的任务单
 * 根据任务单号得到任务单的详情
 * 分站分配配送员
 *
 */
public class SubGetAllTaskServiceImpl implements ISubGetAllTaskService{
	private ITaskOrderDAO taskOrderDao;
	private IOrderDAO orderDao;
	
	//得到任务单详情
	public String taskDetailInfo(int taskid){
		 TaskOrder task = taskOrderDao.findById(taskid);
		 Order order = orderDao.findById(task.getLOrder().getOrderid());
		 System.out.println(order.getOrderid()+"----------test");
		 
		 JSONHelper json = new JSONHelper();
		 json.setSuccess(true);
		 boolean sign = false;

		 json.AddItem("taskorderid", String.valueOf(taskid));
		 json.AddItem("taskstate", task.getTaskorderstate());
		 json.AddItem("tasktype", task.getTaskordertype());
		 json.AddItem("Order", String.valueOf(order.getOrderid()));
		 json.AddItem("orderstate", order.getOrderstate());
		 json.AddItem("ordertype", order.getOrdertype());
		 if(task.getLUserByDeliverman()==null){
			 json.AddItem("deliversubstation","无");
		 }else{
			 json.AddItem("deliversubstation", task.getLUserByDeliverman().getUsername());
		 }
		 json.AddItem("customername", order.getReceiveperson());
		 json.AddItem("requireddate", String.valueOf(order.getRequireddate()));
		 json.AddItem("receiveAdd", order.getReceiveadd());
		 json.ItemOK();
		 sign = true;
		 String jsons = "";
		 if(sign){
			jsons = json.toString();
		 }else {
			jsons = "{success : true,data:[]}";
		 }
		return jsons;
	}
	//得到任务单中商品详情
	public String taskProductInfo(int taskid){
		TaskOrder task = taskOrderDao.findById(taskid);
		Order order = orderDao.findById(task.getLOrder().getOrderid());
		Set<OrderItem> items = order.getLOrderitems();

		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		if(!items.isEmpty()){
			for(OrderItem  it: items) {
				json.AddItem("productId", String.valueOf(it.getLProduct().getProductid()));
				json.AddItem("parentCategory", it.getFirstcatergory());
				json.AddItem("category", it.getSecondcategory());
				json.AddItem("productName", it.getProductname());
				json.AddItem("originalPrice", String.valueOf(it.getOriginalprice()));
				json.AddItem("unit", it.getUnit());
				json.AddItem("productRemark", it.getProductremark());
				json.AddItem("orderItemAmount", String.valueOf(it.getOrderitemamount()));
				json.AddItem("totalPrice", String.valueOf((it.getOriginalprice() * it.getOrderitemamount())));
				json.AddItem("orderState", it.getLOrder().getOrderstate());
				json.ItemOK();		
			}  
			sign = true;
		}
		String jsons = "";
		 if(sign){
			jsons = json.toString();
		 }else {
			jsons = "{success : true,data:[]}";
		 }
		return jsons;
	}
	public IOrderDAO getOrderDao() {
		return orderDao;
	}

	public void setOrderDao(IOrderDAO orderDao) {
		this.orderDao = orderDao;
	}

	public ITaskOrderDAO getTaskOrderDao() {
		return taskOrderDao;
	}

	public void setTaskOrderDao(ITaskOrderDAO taskOrderDao) {
		this.taskOrderDao = taskOrderDao;
	}
	public String getSubAllTasks(Substation substation,String date, String type, String state){
		List<TaskOrder> tlist = taskOrderDao.listTaksOrdersBySubstation(substation, date, type, state);
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		for(TaskOrder to : tlist){
			//"taskOrderId","RequiredDate","taskOrderType","taskOrderState","delivermanId"
			json.AddItem("taskOrderId", Integer.toString(to.getTaskorderid()));
			json.AddItem("RequiredDate", String.valueOf(to.getLOrder().getRequireddate()));
			json.AddItem("taskOrderType", to.getTaskordertype());
			json.AddItem("taskOrderState", to.getTaskorderstate());
			if(to.getLUserByDeliverman()!=null){
				json.AddItem("delivermanId",to.getLUserByDeliverman().getUsername());
			}else{
				json.AddItem("delivermanId", "无");
			}	
			json.ItemOK();
			sign = true;
		}
		String jsons = "";
		if(sign){
			jsons = json.toString();
		}else {
			jsons = "{success : true,data:[]}";
		}
		return jsons;
	}
	public String getSubAllTasks(Substation substation,String date, String type, String state, String deliverman){
		List<TaskOrder> tlist = taskOrderDao.listTaksOrdersBySubstation(substation, date, type, state, deliverman);
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		for(TaskOrder to : tlist){
			//"taskOrderId","RequiredDate","taskOrderType","taskOrderState","delivermanId"
			json.AddItem("taskOrderId", Integer.toString(to.getTaskorderid()));
			json.AddItem("RequiredDate", String.valueOf(to.getLOrder().getRequireddate()));
			json.AddItem("taskOrderType", to.getTaskordertype());
			json.AddItem("taskOrderState", to.getTaskorderstate());
			if(to.getLUserByDeliverman()!=null){
				json.AddItem("delivermanId",to.getLUserByDeliverman().getUsername());
			}else{
				json.AddItem("delivermanId", "无");
			}	
			json.ItemOK();
			sign = true;
		}
		String jsons = "";
		if(sign){
			jsons = json.toString();
		}else {
			jsons = "{success : true,data:[]}";
		}
		return jsons;
	}
	public String getSubAllTasks(Substation substation) {	
		List<TaskOrder> tlist = taskOrderDao.listTaksOrdersBySubstation(substation);
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		for(TaskOrder to : tlist){
			//"taskOrderId","RequiredDate","taskOrderType","taskOrderState","delivermanId"
			json.AddItem("taskOrderId", Integer.toString(to.getTaskorderid()));
			json.AddItem("RequiredDate", String.valueOf(to.getLOrder().getRequireddate()));
			json.AddItem("taskOrderType", to.getTaskordertype());
			json.AddItem("taskOrderState", to.getTaskorderstate());
			if(to.getLUserByDeliverman()!=null){
				json.AddItem("delivermanId",to.getLUserByDeliverman().getUsername());
			}else{
				json.AddItem("delivermanId", "无");
			}	
			json.ItemOK();
			sign = true;
		}
		String jsons = "";
		if(sign){
			jsons = json.toString();
		}else {
			jsons = "{success : true,data:[]}";
		}
		return jsons;
	}
	/**
	 * 分站分配配送员
	 * @param taskorderid
	 * @param dilivermanid
	 * @return
	 */
	public int modifyDiliverman(int taskorderid, int dilivermanid ){
		taskOrderDao.modifyDiliverman(taskorderid, dilivermanid);
		int id = taskOrderDao.findById(taskorderid).getLOrder().getOrderid();
		//修改对应订单状态
		System.out.println(this.getClass()+" id="+id); 
		orderDao.modifyTastStatetoAllocated(id);
		return 1;		
	}
}

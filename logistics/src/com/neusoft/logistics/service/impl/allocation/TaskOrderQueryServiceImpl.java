package com.neusoft.logistics.service.impl.allocation;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.service.inter.allocation.ITaskOrderQueryService;
import com.neusoft.logistics.utils.JSONHelper;

/**
 * 
 * @author 宋延杰
 *
 */

public class TaskOrderQueryServiceImpl implements ITaskOrderQueryService {
	private ITaskOrderDAO taskOrderDAO;
	public ITaskOrderDAO getTaskOrderDAO() {
		return taskOrderDAO;
	}
	public void setTaskOrderDAO(ITaskOrderDAO taskOrderDAO) {
		this.taskOrderDAO = taskOrderDAO;
	}
	/**
	 * 转成json
	 */
	public String taskOrderToJSON(List<TaskOrder> taskOrderList){
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		String temp = null;
		if(taskOrderList.size()>0){
			for(TaskOrder t:taskOrderList){
				json.AddItem("taskOrderId", Integer.toString(t.getTaskorderid()));
				json.AddItem("orderId", Integer.toString(t.getLOrder().getOrderid()));
				temp = t.getLUserByDeliverman().getUsername();
				if(temp ==null){
					temp = "无";
				}
				json.AddItem("deliverman",temp );
				
				temp = t.getLUserByOperator().getUsername();
				if(temp ==null){
					temp = "无";
				}
				json.AddItem("taskOrderState", t.getTaskorderstate());
				json.AddItem("taskOrderType", t.getTaskordertype());
				json.AddItem("operator", temp);
				json.AddItem("operateDate", t.getOperatedate().toString());
				json.ItemOK();
			}
		}
		String jsons="";
		jsons = json.toString();
		return jsons;
	}
	/**
	 * 显示下拉框时的任务单号
	 */
	public String findAllOrderId(){
		List<TaskOrder> taskOrderList = taskOrderDAO.findAll();
		return this.taskOrderToJSON(taskOrderList);
	}
	/**
	 * 查询任务单 按照选定的条件（共七个条件）
	 */
	public String findTaskOrder(String requiredDate,String taskOrderId,String taskOrderType,String taskOrderState,String deliverSubstation,String custormerName,String receivePersonTel){

		List<TaskOrder> taskOrderList = taskOrderDAO.findAll();
		//临时用的
		List<TaskOrder> taskOrders=new ArrayList<TaskOrder>();
		//为了确定taskorders是否为空
		int count=0;
		if((requiredDate==null||requiredDate.equals(""))&&(taskOrderId==null||taskOrderId.equals(""))&&(taskOrderType==null||taskOrderType.equals(""))
				&&(taskOrderState==null||taskOrderState.equals(""))&&(deliverSubstation==null||deliverSubstation.equals(""))&&(custormerName==null||custormerName.equals(""))
				&&(receivePersonTel==null||receivePersonTel.equals(""))){
			return this.taskOrderToJSON(taskOrderList);
		}else{
			if(requiredDate!=null&&!"".equals(requiredDate)&&!(requiredDate.equals("完成日期"))){
				Date date=Date.valueOf(requiredDate);
				for(TaskOrder to:taskOrderList){
					if(to.getLOrder().getRequireddate().equals(date))
						taskOrders.add(to);
				}
				count++;
			}
			if(taskOrderId!=null&&!"".equals(taskOrderId)&&!(taskOrderId.equals("任务单号"))){
				if(count!=0)
					taskOrderList=taskOrders;
				taskOrders=new ArrayList<TaskOrder>();
				for(TaskOrder to:taskOrderList){
					if(to.getTaskorderid()==Integer.valueOf(taskOrderId))
						taskOrders.add(to);
				}
				count++;
			}
			if(taskOrderType!=null&&!"".equals(taskOrderType)&&!(taskOrderType.equals("任务单类型"))){
				if(count!=0)
					taskOrderList=taskOrders;
				taskOrders=new ArrayList<TaskOrder>();
				for(TaskOrder to:taskOrderList){
					if(to.getTaskordertype().equals(taskOrderType))
						taskOrders.add(to);
				}
				count++;
			}
			if(taskOrderState!=null&&!"".equals(taskOrderState)&&!(taskOrderState.equals("任务单状态"))){
				if(count!=0)
					taskOrderList=taskOrders;
				taskOrders=new ArrayList<TaskOrder>();
				for(TaskOrder to:taskOrderList){
					if(to.getTaskorderstate().equals(taskOrderState))
						taskOrders.add(to);
				}
				count++;
			}
			if(deliverSubstation!=null&&!"".equals(deliverSubstation)&&!(taskOrderState.equals("执行任务分站"))){
				if(count!=0)
					taskOrderList=taskOrders;
				taskOrders=new ArrayList<TaskOrder>();
				for(TaskOrder to:taskOrderList){
					if(to.getLOrder().getLSubstationByDeliversubstation().getSubstationid()==Integer.parseInt(deliverSubstation)){;
						taskOrders.add(to);
					}
				}
				count++;
			}
			if(custormerName!=null&&!"".equals(custormerName)&&!custormerName.equals("")){
				if(count!=0)
					taskOrderList=taskOrders;
				taskOrders=new ArrayList<TaskOrder>();
				for(TaskOrder to:taskOrderList){
					if(to.getLOrder().getLCustomer().getCustomername().equals(custormerName))
						taskOrders.add(to);
				}
				count++;
			}
			if(receivePersonTel!=null&&!"".equals(receivePersonTel)&&!receivePersonTel.equals("")){
				if(count!=0)
					taskOrderList=taskOrders;
				taskOrders=new ArrayList<TaskOrder>();
				for(TaskOrder to:taskOrderList){
					if(to.getLOrder().getReceivepersontel().equals(receivePersonTel))
						taskOrders.add(to);
				}
				count++;
			}
			return this.taskOrderToJSON(taskOrders);
		}
	}
}

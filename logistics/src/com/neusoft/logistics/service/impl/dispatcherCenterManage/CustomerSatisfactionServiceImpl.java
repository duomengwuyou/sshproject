package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.sql.Date;
import java.util.List;

import com.neusoft.logistics.bean.FeedBackOrder;
import com.neusoft.logistics.dao.inter.IFeedBackOrderDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.ICustomerSatisfactionService;
import com.neusoft.logistics.utils.JSONHelper;

public class CustomerSatisfactionServiceImpl implements
		ICustomerSatisfactionService {
	private IFeedBackOrderDAO feedBackOrderDAO;
	public String getAllCustomerSatisfaction() {
		// TODO Auto-generated method stub
		List<FeedBackOrder> lists=feedBackOrderDAO.findAll();
		JSONHelper json=new JSONHelper();
		json.setSuccess(true); 
		for(FeedBackOrder f:lists){
			json.AddItem("customerName", f.getTaskorder().getLOrder().getLCustomer().getCustomername());
			json.AddItem("customerId", String.valueOf(f.getTaskorder().getLOrder().getLCustomer().getCustomerid()));
			json.AddItem("satisfiedRatio", String.valueOf(f.getSatisfaction()));
			json.ItemOK();
		}
		return json.toString();
	}

	/**
	 * 通过用户选择开始结束时间查询用户满意度
	 */
	public String getCustomerSatisfaction(String beginTime, String endTime) {
		// TODO Auto-generated method stub
		
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		Date begin=new Date(0);
		Date end=new Date(Long.MAX_VALUE);
 
		if(beginTime!=null&&!beginTime.equals("")){ 
			begin=Date.valueOf(beginTime);  
		} 
		if(endTime!=null&&!endTime.equals("")){  
			end=Date.valueOf(endTime);	 
		}
		
		List<FeedBackOrder> lists=feedBackOrderDAO.findByTime(begin, end);
	
		for(FeedBackOrder f:lists){
			json.AddItem("customerName", f.getTaskorder().getLOrder().getLCustomer().getCustomername());
			json.AddItem("customerId", String.valueOf(f.getTaskorder().getLOrder().getLCustomer().getCustomerid()));
			json.AddItem("satisfiedRatio", String.valueOf(f.getSatisfaction()));
			json.ItemOK();
		}
		return json.toString();
	}

	public IFeedBackOrderDAO getFeedBackOrderDAO() {
		return feedBackOrderDAO;
	}

	public void setFeedBackOrderDAO(IFeedBackOrderDAO feedBackOrderDAO) {
		this.feedBackOrderDAO = feedBackOrderDAO;
	}



}

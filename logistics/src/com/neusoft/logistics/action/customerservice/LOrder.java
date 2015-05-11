package com.neusoft.logistics.action.customerservice;

import java.sql.Date;
import java.util.Set;

import com.neusoft.logistics.bean.Customer;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;

public class LOrder extends Order{
	private Date startTime;
	private Date endTime;
	
	public LOrder(){
		super();
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public LOrder(Substation LSubstationByCheckoutsubstation,
			Substation LSubstationByDeliversubstation, User LUser,
			Customer LCustomer, String orderstate, java.util.Date requireddate,
			java.util.Date orderdate, String ordertype, String receiveadd,
			String receiveperson, String receivepersontel,
			String receivepersonzip, int invoicerequired, String payer,
			String payeradd, String payertel, String payerzipcode,
			Set LTaskorders, Set LAllocationorders, Set LShortageorders,
			Set LCancelorders, Set LChangeproductorders, Set LOrderitems) {
		super(LSubstationByCheckoutsubstation, LSubstationByDeliversubstation, LUser,
				LCustomer, orderstate, requireddate, orderdate, ordertype, receiveadd,
				receiveperson, receivepersontel, receivepersonzip, invoicerequired,
				payer, payeradd, payertel, payerzipcode, LTaskorders,
				LAllocationorders, LShortageorders, LCancelorders,
				LChangeproductorders, LOrderitems);
		// TODO Auto-generated constructor stub
	}

	public LOrder(Date startTime, Date endTime) {
		super();
		this.startTime = startTime;
		this.endTime = endTime;
	}
	
}

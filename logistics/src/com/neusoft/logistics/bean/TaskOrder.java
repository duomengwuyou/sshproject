package com.neusoft.logistics.bean;
// default package

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * TaskOrder generated by MyEclipse Persistence Tools
 */

public class TaskOrder  implements java.io.Serializable {


    // Fields    

     private int taskorderid;
     private Order LOrder;
     private User LUserByDeliverman;
     private User LUserByOperator;
     private String taskorderstate;
     private String taskordertype;
     private Date operatedate;
     private Set LSignedorders = new HashSet(0);
     private Set LTakeproductorders = new HashSet(0);
     private FeedBackOrder LFeedbackorders;


    // Constructors

    /** default constructor */
    public TaskOrder() {
    }

    
    /** full constructor */
    public TaskOrder(Order LOrder, User LUserByDeliverman, User LUserByOperator, String taskorderstate, String taskordertype, Date operatedate, Set LSignedorders, Set LTakeproductorders) {
        this.LOrder = LOrder;
        this.LUserByDeliverman = LUserByDeliverman;
        this.LUserByOperator = LUserByOperator;
        this.taskorderstate = taskorderstate;
        this.taskordertype = taskordertype;
        this.operatedate = operatedate;
        this.LSignedorders = LSignedorders;
        this.LTakeproductorders = LTakeproductorders;
    }

   
    // Property accessors

    public int getTaskorderid() {
        return this.taskorderid;
    }
    
    public void setTaskorderid(int taskorderid) {
        this.taskorderid = taskorderid;
    }

    public Order getLOrder() {
        return this.LOrder;
    }
    
    public void setLOrder(Order LOrder) {
        this.LOrder = LOrder;
    }

    public User getLUserByDeliverman() {
        return this.LUserByDeliverman;
    }
    
    public void setLUserByDeliverman(User LUserByDeliverman) {
        this.LUserByDeliverman = LUserByDeliverman;
    }

    public User getLUserByOperator() {
        return this.LUserByOperator;
    }
    
    public void setLUserByOperator(User LUserByOperator) {
        this.LUserByOperator = LUserByOperator;
    }

    public String getTaskorderstate() {
        return this.taskorderstate;
    }
    
    public void setTaskorderstate(String taskorderstate) {
        this.taskorderstate = taskorderstate;
    }

    public String getTaskordertype() {
        return this.taskordertype;
    }
    
    public void setTaskordertype(String taskordertype) {
        this.taskordertype = taskordertype;
    }

    public Date getOperatedate() {
        return this.operatedate;
    }
    
    public void setOperatedate(Date operatedate) {
        this.operatedate = operatedate;
    }

    public Set getLSignedorders() {
        return this.LSignedorders;
    }
    
    public void setLSignedorders(Set LSignedorders) {
        this.LSignedorders = LSignedorders;
    }

    public Set getLTakeproductorders() {
        return this.LTakeproductorders;
    }
    
    public void setLTakeproductorders(Set LTakeproductorders) {
        this.LTakeproductorders = LTakeproductorders;
    }


	public FeedBackOrder getLFeedbackorders() {
		return LFeedbackorders;
	}


	public void setLFeedbackorders(FeedBackOrder feedbackorders) {
		LFeedbackorders = feedbackorders;
	}
    

}
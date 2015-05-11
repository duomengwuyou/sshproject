package com.neusoft.logistics.bean;
// default package
 
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * SubstationInStorageOrder generated by MyEclipse Persistence Tools
 */

public class SubstationInStorageOrder  implements java.io.Serializable {


    // Fields    

     private int subsationinstorageorderid;
     private DispatchOrder LDispatchorder;
     private Date instoragedate;
     private String instorageremark;
     private Set LSubsationinstorageorderitems = new HashSet(0);


    // Constructors

    /** default constructor */
    public SubstationInStorageOrder() {
    }

    
    /** full constructor */
    public SubstationInStorageOrder(DispatchOrder LDispatchorder, Date instoragedate, String instorageremark, Set LSubsationinstorageorderitems) {
        this.LDispatchorder = LDispatchorder;
        this.instoragedate = instoragedate;
        this.instorageremark = instorageremark;
        this.LSubsationinstorageorderitems = LSubsationinstorageorderitems;
    }

   
    // Property accessors

    public int getSubsationinstorageorderid() {
        return this.subsationinstorageorderid;
    }
    
    public void setSubsationinstorageorderid(int subsationinstorageorderid) {
        this.subsationinstorageorderid = subsationinstorageorderid;
    }

    public DispatchOrder getLDispatchorder() {
        return this.LDispatchorder;
    }
    
    public void setLDispatchorder(DispatchOrder LDispatchorder) {
        this.LDispatchorder = LDispatchorder;
    }

    public Date getInstoragedate() {
        return this.instoragedate;
    }
    
    public void setInstoragedate(Date instoragedate) {
        this.instoragedate = instoragedate;
    }

    public String getInstorageremark() {
        return this.instorageremark;
    }
    
    public void setInstorageremark(String instorageremark) {
        this.instorageremark = instorageremark;
    }

    public Set getLSubsationinstorageorderitems() {
        return this.LSubsationinstorageorderitems;
    }
    
    public void setLSubsationinstorageorderitems(Set LSubsationinstorageorderitems) {
        this.LSubsationinstorageorderitems = LSubsationinstorageorderitems;
    }
   








}
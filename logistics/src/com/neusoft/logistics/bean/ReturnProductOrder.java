package com.neusoft.logistics.bean;
// default package

import java.util.Date;


/**
 * ReturnProductOrder generated by MyEclipse Persistence Tools
 */

public class ReturnProductOrder  implements java.io.Serializable {


    // Fields    

     private int returnproductorderid;
     private Product LProduct;
     private Warehouse LWarehouseBySubwarehouse;
     private Warehouse LWarehouseByCenterwarehouse;
     private int returnquantity;
     private String returnreason;
     private int fromorder;
     private Date returndate;
     private String returntosubwarehousestate;
     private String returntocenterwarehousestate;


    // Constructors

    /** default constructor */
    public ReturnProductOrder() {
    }

    
    /** full constructor */
    public ReturnProductOrder(Product LProduct, Warehouse LWarehouseBySubwarehouse, Warehouse LWarehouseByCenterwarehouse, int returnquantity, String returnreason, int fromorder, Date returndate, String returntosubwarehousestate, String returntocenterwarehousestate) {
        this.LProduct = LProduct;
        this.LWarehouseBySubwarehouse = LWarehouseBySubwarehouse;
        this.LWarehouseByCenterwarehouse = LWarehouseByCenterwarehouse;
        this.returnquantity = returnquantity;
        this.returnreason = returnreason;
        this.fromorder = fromorder;
        this.returndate = returndate;
        this.returntosubwarehousestate = returntosubwarehousestate;
        this.returntocenterwarehousestate = returntocenterwarehousestate;
    }

   
    // Property accessors

    public int getReturnproductorderid() {
        return this.returnproductorderid;
    }
    
    public void setReturnproductorderid(int returnproductorderid) {
        this.returnproductorderid = returnproductorderid;
    }

    public Product getLProduct() {
        return this.LProduct;
    }
    
    public void setLProduct(Product LProduct) {
        this.LProduct = LProduct;
    }

    public Warehouse getLWarehouseBySubwarehouse() {
        return this.LWarehouseBySubwarehouse;
    }
    
    public void setLWarehouseBySubwarehouse(Warehouse LWarehouseBySubwarehouse) {
        this.LWarehouseBySubwarehouse = LWarehouseBySubwarehouse;
    }

    public Warehouse getLWarehouseByCenterwarehouse() {
        return this.LWarehouseByCenterwarehouse;
    }
    
    public void setLWarehouseByCenterwarehouse(Warehouse LWarehouseByCenterwarehouse) {
        this.LWarehouseByCenterwarehouse = LWarehouseByCenterwarehouse;
    }

    public int getReturnquantity() {
        return this.returnquantity;
    }
    
    public void setReturnquantity(int returnquantity) {
        this.returnquantity = returnquantity;
    }

    public String getReturnreason() {
        return this.returnreason;
    }
    
    public void setReturnreason(String returnreason) {
        this.returnreason = returnreason;
    }

    public int getFromorder() {
        return this.fromorder;
    }
    
    public void setFromorder(int fromorder) {
        this.fromorder = fromorder;
    }

    public Date getReturndate() {
        return this.returndate;
    }
    
    public void setReturndate(Date returndate) {
        this.returndate = returndate;
    }

    public String getReturntosubwarehousestate() {
        return this.returntosubwarehousestate;
    }
    
    public void setReturntosubwarehousestate(String returntosubwarehousestate) {
        this.returntosubwarehousestate = returntosubwarehousestate;
    }

    public String getReturntocenterwarehousestate() {
        return this.returntocenterwarehousestate;
    }
    
    public void setReturntocenterwarehousestate(String returntocenterwarehousestate) {
        this.returntocenterwarehousestate = returntocenterwarehousestate;
    }
   








}
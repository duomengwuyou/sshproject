package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.sql.Date;

import com.neusoft.logistics.bean.OutStorageOrderItem;
import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;
import com.neusoft.logistics.bean.SubstationInStorageOrderItem;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IOutStorageOrderItemDAO;
import com.neusoft.logistics.dao.inter.IPurchaseInStorageOrderItemDAO;
import com.neusoft.logistics.dao.inter.ISubstationInStorageOrderItemDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IInOutStorageOrderService;
import com.neusoft.logistics.utils.JSONHelper;
/**
 * 出入单查询
 * @author 陈秀能
 * **/
public class InOutStorageServiceImpl implements IInOutStorageOrderService {
	private IOutStorageOrderItemDAO outStorageOrderItemDAO;
	private ISubstationInStorageOrderItemDAO substationInStorageOrderItemDAO;
	private IPurchaseInStorageOrderItemDAO purchaseInStorageOrderItemDAO;



	public IOutStorageOrderItemDAO getOutStorageOrderItemDAO() {
		return outStorageOrderItemDAO;
	}

	public void setOutStorageOrderItemDAO(
			IOutStorageOrderItemDAO outStorageOrderItemDAO) {
		this.outStorageOrderItemDAO = outStorageOrderItemDAO;
	}

	public ISubstationInStorageOrderItemDAO getSubstationInStorageOrderItemDAO() {
		return substationInStorageOrderItemDAO;
	}

	public void setSubstationInStorageOrderItemDAO(
			ISubstationInStorageOrderItemDAO substationInStorageOrderItemDAO) {
		this.substationInStorageOrderItemDAO = substationInStorageOrderItemDAO;
	}

	public IPurchaseInStorageOrderItemDAO getPurchaseInStorageOrderItemDAO() {
		return purchaseInStorageOrderItemDAO;
	}

	public void setPurchaseInStorageOrderItemDAO(
			IPurchaseInStorageOrderItemDAO purchaseInStorageOrderItemDAO) {
		this.purchaseInStorageOrderItemDAO = purchaseInStorageOrderItemDAO;
	}

	public String getInOutStorageOrder(String beginTime, String endTime,
			String product) {
		System.out.println(this.getClass()+" getInOutStorageOrder");
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
		System.out.println(this.getClass()+" begin="+begin);
		System.out.println(this.getClass()+" end="+end);
		for(OutStorageOrderItem o:outStorageOrderItemDAO.findOutStorageOrder(begin,end,product)){
			json.AddItem("id", String.valueOf(o.getOutstorageorderitemid()));
			json.AddItem("style","出库单" );
			json.AddItem("OrderId",String.valueOf(o.getLOutstorageorder().getOutstorageorderid()) );
			json.AddItem("wareHouseName", o.getLOutstorageorder().getLWarehouse().getWarehousename());
			json.AddItem("productId", String.valueOf(o.getLProduct().getProductid()));
			json.AddItem("productName", o.getLProduct().getProductname());
			double costPrice=o.getLProduct().getCostprice();
			json.AddItem("costPrice", String.valueOf(costPrice));
			int quantity=o.getProductquantity();
			json.AddItem("Quantity", String.valueOf(quantity));
			json.AddItem("MoneyAmount", String.valueOf(quantity*costPrice));
			json.AddItem("Date", o.getLOutstorageorder().getOutstoragedate().toString());
			json.ItemOK();
		}
		for(SubstationInStorageOrderItem o:substationInStorageOrderItemDAO.findInStorageOrder(begin,end,product)){
			json.AddItem("id", String.valueOf(o.getSubsationinstorageorderitemid()));
			json.AddItem("style","入库单" );
			json.AddItem("OrderId", String.valueOf(o.getLSubsationinstorageorder().getSubsationinstorageorderid()));
			json.AddItem("wareHouseName", o.getLSubsationinstorageorder().getLDispatchorder().getLWarehouse().getWarehousename());
			json.AddItem("productId", String.valueOf(o.getLProduct().getProductid()));
			json.AddItem("productName", o.getLProduct().getProductname());
			double costPrice=o.getLProduct().getCostprice();
			json.AddItem("costPrice",String.valueOf(costPrice) );
			int quantity=o.getProductquantity();
			json.AddItem("Quantity", String.valueOf(quantity));
			json.AddItem("MoneyAmount",String.valueOf(costPrice*quantity) );
			json.AddItem("Date", String.valueOf(o.getLSubsationinstorageorder().getInstoragedate()));
			json.ItemOK();
		}
		for(PurchaseInStorageOrderItem o:purchaseInStorageOrderItemDAO.findPurchaseInStorageOrder(begin,end,product)){
			json.AddItem("id", String.valueOf(o.getPurchaseinstorageorderitemid()));
			json.AddItem("style","入库单" );
			json.AddItem("OrderId", String.valueOf(o.getLPurchaseinstorageorder().getPurchaseinstorageorderid()));
			Warehouse warehouse=null;
			if((warehouse= o.getLPurchaseinstorageorder().getLWarehouse())!=null){
			json.AddItem("wareHouseName",warehouse.getWarehousename());}else{
				json.AddItem("wareHouseName","");
			}
			json.AddItem("productId", String.valueOf(o.getLProduct().getProductid()));
			json.AddItem("productName",o.getLProduct().getProductname() ); 
			double costPrice=o.getLProduct().getCostprice();
			json.AddItem("costPrice", String.valueOf(costPrice));
			int quantity=o.getRealpurchasequantity();
			json.AddItem("Quantity",String.valueOf(quantity) );
			json.AddItem("MoneyAmount", String.valueOf(quantity*costPrice));
			json.AddItem("Date", String.valueOf(o.getLPurchaseinstorageorder().getPurchasedate()));
			json.ItemOK();
		}
		// TODO Auto-generated method stub
		return json.toString();
	}

}

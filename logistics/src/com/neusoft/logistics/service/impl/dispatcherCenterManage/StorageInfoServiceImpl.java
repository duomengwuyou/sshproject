package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.dao.inter.IOrderItemDAO;
import com.neusoft.logistics.dao.inter.IReturnProductOrderDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IStorageInfoService;
import com.neusoft.logistics.utils.JSONHelper;

public class StorageInfoServiceImpl implements IStorageInfoService {
	private IStorageInfoDAO storageInfoDAO;
	private IReturnProductOrderDAO returnProductOrderDAO;
	private IOrderItemDAO orderItemDAO;

	public IStorageInfoDAO getStorageInfoDAO() {
		return storageInfoDAO;
	}

	public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
		this.storageInfoDAO = storageInfoDAO;
	}
	
	public IReturnProductOrderDAO getReturnProductOrderDAO() {
		return returnProductOrderDAO;
	}

	public void setReturnProductOrderDAO(
			IReturnProductOrderDAO returnProductOrderDAO) {
		this.returnProductOrderDAO = returnProductOrderDAO;
	}

	public IOrderItemDAO getOrderItemDAO() {
		return orderItemDAO;
	}

	public void setOrderItemDAO(IOrderItemDAO orderItemDAO) {
		this.orderItemDAO = orderItemDAO;
	}

	public String findStorageInfoByProductName(String productName) {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" findStorageInfoByProductName");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		for(StorageInfo si:storageInfoDAO.findStorageInfoByProductName(productName)){
			json.AddItem("storageInfoId", String.valueOf(si.getStorageinfoid()));
			json.AddItem("productId", String.valueOf(si.getLProduct().getProductid()));
			json.AddItem("warehouseName", si.getLWarehouse().getWarehousename());
			json.AddItem("productName", si.getLProduct().getProductname());
			json.AddItem("warningQuantity",String.valueOf(si.getWarningquantity()) );
			json.AddItem("maxQuantity", String.valueOf(si.getMaxquantity()));
			json.AddItem("remainQuantity", String.valueOf(si.getRemainquantity()));
			json.ItemOK();
		}
		return json.toString();
	}

	public String searchStorageAmount(String productName, String warehouseName) {
		// TODO Auto-generated method stub
		System.out.println(this.getClass()+" searchStorageAmount");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		
		for(StorageInfo si:storageInfoDAO.findStorageInfoByProductNameAndWarehouseName(productName,warehouseName)){
			json.AddItem("id", String.valueOf(si.getStorageinfoid()));
			json.AddItem("productName", si.getLProduct().getProductname());
			json.AddItem("warehouseName", si.getLWarehouse().getWarehousename());
			int returnQuantity=returnProductOrderDAO.getReturnQuantityByProductAndWarehouse(si.getLProduct(),si.getLWarehouse());
			int allocatableQuantity=si.getRemainquantity();
			int allocatedQuantity=orderItemDAO.getAllocatedQuantity(si.getLProduct(),si.getLWarehouse());
			json.AddItem("totalQuantity", String.valueOf(returnQuantity+allocatableQuantity+allocatedQuantity));
			json.AddItem("returnQuantity", String.valueOf(returnQuantity));
			json.AddItem("allocateQuantity", String.valueOf(allocatedQuantity));
			json.AddItem("alreadyAllocateQuantity", String.valueOf(allocatableQuantity));
			json.ItemOK();
			//returnProductOrderDAO.getReturnQuantityByProductAndWarehouse(si.getLProduct(),si.getLWarehouse());
		}
		System.out.println(this.getClass()+" json="+json.toString());
		return json.toString();
	}

	public String modifyStorageInfo(Integer storageInfoId, String field,
			String value) {
		if(field.equals("warningQuantity")) storageInfoDAO.findById(storageInfoId).setWarningquantity(Integer.valueOf(value));
		else if(field.equals("maxQuantity"))storageInfoDAO.findById(storageInfoId).setMaxquantity(Integer.valueOf(value));
		else if(field.equals("remainQuantity"))storageInfoDAO.findById(storageInfoId).setRemainquantity(Integer.valueOf(value));
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

}

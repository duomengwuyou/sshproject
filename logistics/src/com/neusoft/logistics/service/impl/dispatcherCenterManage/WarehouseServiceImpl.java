package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IWarehouseService;
import com.neusoft.logistics.utils.JSONHelper;

public class WarehouseServiceImpl implements IWarehouseService {
	private IWarehouseDAO warehouseDAO; 

	public IWarehouseDAO getWarehouseDAO() {
		return warehouseDAO;
	}

	public void setWarehouseDAO(IWarehouseDAO warehouseDAO) {
		this.warehouseDAO = warehouseDAO;
	}

	public String searchWarehouseByAdd(String warehouseAdd) {
		System.out.println(this.getClass()+" searchWarehouse");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		for(Warehouse warehouse:warehouseDAO.findByWarehouseaddress(warehouseAdd)){
			json.AddItem("warehouseId",String.valueOf(warehouse.getWarehouseid()));
			json.AddItem("warehouseName",warehouse.getWarehousename() );
			json.AddItem("warehouseAddress",warehouse.getWarehouseaddress() );
			json.AddItem("warehouseType", warehouse.getWarehousetype());
			json.AddItem("warehouseManager", warehouse.getLUser().getUsername()); 
			json.ItemOK();
		}
		// TODO Auto-generated method stub
		return json.toString();
	}

	public String saveWarehouse(Warehouse warehouse) {
		if(warehouse.getWarehousetype().equals("中心库房")&&warehouseDAO.getCenterWarehosue()==null){
			//if(warehouseDAO.findByProperty("warehousetype", "中心库房")==null)
			warehouseDAO.save(warehouse);
		}else{
		    warehouseDAO.save(warehouse);
		}
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

	public String modifyWarehouse(Integer warehouseId, String field,
			String value) {
		if(field.equals("warehouseName"))warehouseDAO.findById(warehouseId).setWarehousename(value);
		else if(field.equals("warehouseAddress"))warehouseDAO.findById(warehouseId).setWarehouseaddress(value);
		else if(field.equals("warehouseManager")){
			User manager=new User();
			manager.setUserid(Integer.valueOf(value));
			warehouseDAO.findById(warehouseId).setLUser(manager);
		}
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

	public String delete(String[] root) {
		for(int i =0;i<root.length;i++){
			warehouseDAO.delete(warehouseDAO.findById(Integer.valueOf(root[i])));
		}
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}

}

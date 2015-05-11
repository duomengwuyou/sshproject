package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.sql.Date;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Supplier;
import com.neusoft.logistics.dao.inter.IProductDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IManageProductService;

public class ManageProductServiceImpl implements IManageProductService {
	private IProductDAO productDAO;
	private IStorageInfoDAO storageInfoDAO;
	private IWarehouseDAO warehouseDAO;

	public IWarehouseDAO getWarehouseDAO() {
		return warehouseDAO;
	}

	public void setWarehouseDAO(IWarehouseDAO warehouseDAO) {
		this.warehouseDAO = warehouseDAO;
	}

	public IProductDAO getProductDAO() {
		return productDAO;
	}

	public void setProductDAO(IProductDAO productDAO) {
		this.productDAO = productDAO;
	}

	public String save(Product product) {
		// TODO Auto-generated method stub.
		productDAO.save(product);
		StorageInfo si=new StorageInfo();
		si.setLProduct(product);
		si.setLWarehouse(warehouseDAO.getCenterWarehosue());
		si.setMaxquantity(20000);
		si.setRemainquantity(0);
		si.setWarningquantity(10);
		storageInfoDAO.save(si);
		return "{success : true,data:[]}";
	}

	public IStorageInfoDAO getStorageInfoDAO() {
		return storageInfoDAO;
	}

	public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
		this.storageInfoDAO = storageInfoDAO;
	}

	public String delete(String[] root) {
		System.out.println(this.getClass()+" root="+root.toString());
		// TODO Auto-generated method stub
		for(int i=0;i<root.length;i++){
			productDAO.delete(productDAO.findById(Integer.valueOf(root[i])));
		}
		return "{success : true,data:[]}";
	}

	public String modify(int productId, String value, String field) {
		if(field.equals("secondClassName")){
			Category c=new Category();
			c.setCategoryid(Integer.valueOf(value));
			productDAO.findById(productId).setLCategory(c);
		}else if(field.equals("productName")){
			productDAO.findById(productId).setProductname(value);
		}else if(field.equals("unit")){
			productDAO.findById(productId).setUnit(value);
		}else if(field.equals("originalPrice")){
			productDAO.findById(productId).setOriginalprice(Double.valueOf(value));
		}else if(field.equals("discount")){
			productDAO.findById(productId).setDiscount(Double.valueOf(value));
		}else if(field.equals("costPrice")){
			productDAO.findById(productId).setCostprice(Double.valueOf(value));
		}else if(field.equals("productType")){
			productDAO.findById(productId).setProducttype(value);
		}else if(field.equals("supplier")){
			Supplier s=new Supplier();
			s.setSupplierid(Integer.valueOf(value));
			productDAO.findById(productId).setLSupplier(s);
		}else if(field.equals("manufacturer")){
			productDAO.findById(productId).setManufacturer(value);
		}else if(field.equals("guaranteePeriod")){
			productDAO.findById(productId).setGuaranteeperiod(Date.valueOf(value));
		}else if(field.equals("returnable")){
			productDAO.findById(productId).setReturnable(value.equals("是")?1:0);
		}else if(field.equals("changeable")){
			productDAO.findById(productId).setChangeable(value.equals("是")?1:0);
		}else if(field.equals("productRemark")){
			productDAO.findById(productId).setProductremark(value);
		}
		// TODO Auto-generated method stub
		return "{success : true,data:[]}";
	}



}

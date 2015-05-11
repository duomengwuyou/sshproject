package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.dao.inter.IProductDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IQueryProductService;
import com.neusoft.logistics.utils.JSONHelper;

public class QueryProductServiceImpl implements IQueryProductService {
	private IProductDAO productDAO;
	
	public IProductDAO getProductDAO() {
		return productDAO;
	}

	public void setProductDAO(IProductDAO productDAO) {
		this.productDAO = productDAO;
	}

	public String getAllProducts() {
		System.out.println(this.getClass()+" getAllProducts");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		for(Product product:productDAO.findAll()){
			json.AddItem("productId", String.valueOf(product.getProductid()));
			json.AddItem("productName", product.getProductname());
			json.AddItem("firstClassName",product.getLCategory().getLCategory().getCategoryname());
			json.AddItem("secondClassName", product.getLCategory().getCategoryname());
			json.AddItem("unit", product.getUnit()); 
			json.AddItem("originalPrice", String.valueOf(product.getOriginalprice())); 
			json.AddItem("discount", String.valueOf(product.getDiscount())); 
			json.AddItem("costPrice", String.valueOf(product.getCostprice())); 
			json.AddItem("productType", product.getProducttype());
			json.AddItem("supplier", product.getLSupplier().getSuppliername());
			json.AddItem("manufacturer", product.getManufacturer());
			json.AddItem("guaranteePeriod", product.getGuaranteeperiod().toString());
			json.AddItem("returnable", product.getReturnable()==1?"可退货":"不可退货");
			json.AddItem("changeable", product.getChangeable()==1?"可换货":"不可换货");
			json.AddItem("productRemark", product.getProductremark());
			json.ItemOK();
		}
		// TODO Auto-generated method stub
		return json.toString();
	}

}

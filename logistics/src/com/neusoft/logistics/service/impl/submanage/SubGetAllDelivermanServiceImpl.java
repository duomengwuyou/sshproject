package com.neusoft.logistics.service.impl.submanage;

import java.util.List;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.impl.ProductDAO;
import com.neusoft.logistics.dao.impl.SubstationDAO;
import com.neusoft.logistics.service.inter.submanage.ISubGetAllDelivermanService;
import com.neusoft.logistics.utils.JSONHelper;
/**
 * 
 * @author 李莎
 * 得到分站所有的配送员
 *得到所有商品
 */
public class SubGetAllDelivermanServiceImpl implements ISubGetAllDelivermanService{
	
	private SubstationDAO  substationDAO;
	private ProductDAO productDao;
	
	public String getAllDeliverman(Substation substation) {
		List<User> users = substationDAO.listAllDeliverman(substation);
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		for(User u : users){
			
			json.AddItem("delivermanId", Integer.toString(u.getUserid()));
			json.AddItem("delivermanName", u.getUsername());
			json.ItemOK();
			sign = true;
		}
		String jsons = "";
		if(sign){
			jsons = json.toString();
		}else {
			jsons = "{success : true,data:[]}";
		}
		return jsons;
		
	}
	/**
	 * 得到所有商品信息
	 * @return
	 */
	public String getAllProducts(){
		List<Product> allproducts = productDao.findAll();
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		boolean sign = false;
		for(Product p: allproducts){		
			json.AddItem("productId2", Integer.toString(p.getProductid()));
			json.AddItem("productName2", p.getProductname());
			json.ItemOK();
			sign = true;
		}
		String jsons = "";
		if(sign){
			jsons = json.toString();
		}else {
			jsons = "{success : true,data:[]}";
		}
		return jsons;
	}
	public SubstationDAO getSubstationDAO() {
		return substationDAO;
	}
	public void setSubstationDAO(SubstationDAO substationDAO) {
		this.substationDAO = substationDAO;
	}
	public ProductDAO getProductDao() {
		return productDao;
	}
	public void setProductDao(ProductDAO productDao) {
		this.productDao = productDao;
	}

}

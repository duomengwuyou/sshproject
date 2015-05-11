package com.neusoft.logistics.service.impl.customermanage;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.neusoft.logistics.bean.Category;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.ShortageOrder;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.impl.SubstationDAO;
import com.neusoft.logistics.dao.inter.ICategoryDAO;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.IProductDAO;
import com.neusoft.logistics.dao.inter.IShortageOrderDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;
import com.neusoft.logistics.service.inter.customermanage.IOrderProductInfoService;
import com.neusoft.logistics.utils.JSONHelper;

public class OrderProductInfoServiceImpl implements IOrderProductInfoService {

	private IProductDAO productDAO;
	private ICategoryDAO categoryDAO;
	private IOrderDAO orderDAO;
	private IStorageInfoDAO storageInfoDAO;
	private IShortageOrderDAO shortageOrderDAO; 
	private IWarehouseDAO warehouseDAO;
	private SubstationDAO substationDAO;

	public SubstationDAO getSubstationDAO() {
		return substationDAO;
	}
	public void setSubstationDAO(SubstationDAO substationDAO) {
		this.substationDAO = substationDAO;
	}
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



	public ICategoryDAO getCategoryDAO() {
		return categoryDAO;
	}
	public void setCategoryDAO(ICategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
	}
	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}


	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}
	public IStorageInfoDAO getStorageInfoDAO() {
		return storageInfoDAO;
	}


	public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
		this.storageInfoDAO = storageInfoDAO;
	}

	public IShortageOrderDAO getShortageOrderDAO() {
		return shortageOrderDAO;
	}


	public void setShortageOrderDAO(IShortageOrderDAO shortageOrderDAO) {
		this.shortageOrderDAO = shortageOrderDAO;
	}


	public String getAllProducts(){
		List<Product> products = productDAO.findAll();
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);

		for(Product product:products){

			json.AddItem("firstcategoryName", product.getLCategory().getLCategory().getCategoryname());
			json.AddItem("secondcategoryName", product.getLCategory().getCategoryname());
			json.AddItem("productId", Integer.toString(product.getProductid()));
			json.AddItem("productName", product.getProductname());
			json.AddItem("unit", product.getUnit());
			json.AddItem("originalPrice", Double.toString(product.getOriginalprice()));
			json.AddItem("discount", Double.toString(product.getDiscount()));
			json.AddItem("productRemark", product.getProductremark());

			json.ItemOK();
		}
		json.setTotalCount(products.size());
		String jsons= "";
		jsons = json.toString();

		return jsons;
	}
	//得到货物分站投递

	public String substationToJSON(List<Substation> substationList){
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		if(substationList.size()>0){
			for(Substation s:substationList){
				json.AddItem("substationId",Integer.toString(s.getSubstationid()));
				json.AddItem("substationAdd", s.getSubstationadd());
				json.ItemOK();
			}

		}

		String jsons="";
		jsons = json.toString();
		return jsons;		
	}
	public String findAllSubstation(){
		List<Substation> substationList;
		substationList = substationDAO.findAll();
		return this.substationToJSON(substationList);
	}

	public Product findProductById(int id){
		return productDAO.findById(id);
	}
	//通过商品一级分类和商品二级分类得到商品
	public String findProductByCategory(Category category){ 
		List<Product> products = productDAO.findByCategory(categoryDAO.findById(category.getCategoryid()));
		JSONHelper json = new JSONHelper();
		json.setSuccess(true);
		for(Product product:products){
			json.AddItem("firstcategoryName", product.getLCategory().getLCategory().getCategoryname());
			json.AddItem("secondcategoryName", product.getLCategory().getCategoryname());
			json.AddItem("productId", Integer.toString(product.getProductid()));
			json.AddItem("productName", product.getProductname());
			json.AddItem("unit", product.getUnit());
			json.AddItem("originalPrice", Double.toString(product.getOriginalprice()));
			json.AddItem("discount", Double.toString(product.getDiscount()));
			json.AddItem("productRemark", product.getProductremark());
			json.ItemOK();
		}
		json.setTotalCount(products.size());
		String jsons="";
		jsons = json.toString();
		return jsons;
	}

	//添加订单
	public void addOrder(Order order){
		List<ShortageOrder> shortages = shortageOrderDAO.findAll();
		boolean temp=false; 
		boolean flag = false;
		Set<ShortageOrder> sos=new HashSet<ShortageOrder>();
		for(OrderItem orderItem:(Set<OrderItem>)(order.getLOrderitems())){
			//確定orderItem中的商品是否在缺貨單中已經存在
			for(ShortageOrder shortage:shortages){
				if(shortage.getLProduct().equals(orderItem.getLProduct())&&shortage.getShortagestate().equals("缺货")){
					
					flag = true;
					break;
				}
			}
			//存在的話，直接生成缺貨单
			if(flag){
					ShortageOrder shortageOrder = new ShortageOrder();
					shortageOrder.setLProduct(orderItem.getLProduct());
					shortageOrder.setShortagequantity(orderItem.getOrderitemamount());
					shortageOrder.setShortagestate("缺货");
					shortageOrder.setLOrder(order); 
					//shortageOrderDAO.save(shortageOrder);
					sos.add(shortageOrder);
					System.out.println(this.getClass()+" shortageOrder="+shortageOrder.getShortageorderid());
					temp=true;
			}else{
					System.out.println(this.getClass()+" product="+orderItem.getLProduct().getProductid());
					//StorageInfo si=storageInfoDAO.getStorageInfoByProduct(orderItem.getLProduct(),warehouseDAO.getCenterWarehosue());
					StorageInfo si=storageInfoDAO.getStorageInfoByProduct(orderItem.getLProduct());
					if(si==null){
						System.out.println(this.getClass()+" si==null");
						ShortageOrder shortageOrder = new ShortageOrder();
						shortageOrder.setLProduct(orderItem.getLProduct());
						shortageOrder.setShortagequantity(orderItem.getOrderitemamount());
						shortageOrder.setShortagestate("缺货");
						shortageOrder.setLOrder(order); 
						//shortageOrderDAO.save(shortageOrder);
						sos.add(shortageOrder);
						System.out.println(this.getClass()+" shortageOrder="+shortageOrder.getShortageorderid());
						temp=true;
					}else{
						System.out.println(this.getClass()+" si!=null");
						int remainQuantity =si.getRemainquantity();
						System.out.println(this.getClass()+" remainQuantity="+remainQuantity);
						if(orderItem.getOrderitemamount()>remainQuantity){
							ShortageOrder shortageOrder = new ShortageOrder();
							shortageOrder.setLProduct(orderItem.getLProduct());
							shortageOrder.setShortagequantity(orderItem.getOrderitemamount()-remainQuantity);
							shortageOrder.setShortagestate("缺货");
							shortageOrder.setLOrder(order); 
							sos.add(shortageOrder);
							//shortageOrderDAO.save(shortageOrder);
							temp=true;
						}
					}
				}
			orderItem.setLOrder(order);
		} 

		if(temp){
			order.setOrderstate("缺货");
			order.setLShortageorders(sos);
		}else{
			order.setOrderstate("可分配");
		}
		orderDAO.save(order);
	}

}

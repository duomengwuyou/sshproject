package com.neusoft.logistics.service.impl.dispatcherCenterManage;

import java.sql.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;
import com.neusoft.logistics.bean.PurchaseInstorageOrder;
import com.neusoft.logistics.bean.PurchaseProductOrder;
import com.neusoft.logistics.bean.ShortProductTotal;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.dao.inter.IProductDAO;
import com.neusoft.logistics.dao.inter.IPurchaseInStorageOrderItemDAO;
import com.neusoft.logistics.dao.inter.IPurchaseInstorageOrderDAO;
import com.neusoft.logistics.dao.inter.IPurchaseProductOrderDAO;
import com.neusoft.logistics.dao.inter.IShortProductTotalDao;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;
import com.neusoft.logistics.service.inter.dispatchCenterManage.IPurchaseProductService;
import com.neusoft.logistics.utils.JSONHelper;
/**
 * 进货管理 获取仓库和缺货单的总缺货商品信息
 * @author 龚玉斌
 */

public class PurchaseProductService implements IPurchaseProductService {

	private IShortProductTotalDao shortProductTotalDao;
	private IProductDAO productDAO;
	private IStorageInfoDAO storageInfoDAO;
	private IPurchaseProductOrderDAO purchaseProductOrderDAO;
	private IPurchaseInstorageOrderDAO purchaseInstorageOrderDAO;
	private IPurchaseInStorageOrderItemDAO purchaseInStorageOrderItemDAO;
	private IWarehouseDAO warehouseDAO;

	public IWarehouseDAO getWarehouseDAO() {
		return warehouseDAO;
	}

	public void setWarehouseDAO(IWarehouseDAO warehouseDAO) {
		this.warehouseDAO = warehouseDAO;
	}

	public IShortProductTotalDao getShortProductTotalDao() {
		return shortProductTotalDao;
	}

	public IPurchaseInstorageOrderDAO getPurchaseInstorageOrderDAO() {
		return purchaseInstorageOrderDAO;
	}

	public IPurchaseInStorageOrderItemDAO getPurchaseInStorageOrderItemDAO() {
		return purchaseInStorageOrderItemDAO;
	}

	public void setPurchaseInStorageOrderItemDAO(
			IPurchaseInStorageOrderItemDAO purchaseInStorageOrderItemDAO) {
		this.purchaseInStorageOrderItemDAO = purchaseInStorageOrderItemDAO;
	}

	public void setPurchaseInstorageOrderDAO(
			IPurchaseInstorageOrderDAO purchaseInstorageOrderDAO) {
		this.purchaseInstorageOrderDAO = purchaseInstorageOrderDAO;
	}

	public void setShortProductTotalDao(IShortProductTotalDao shortProductTotalDao) {
		this.shortProductTotalDao = shortProductTotalDao;
	}

	public IProductDAO getProductDAO() {
		return productDAO;
	}

	public void setProductDAO(IProductDAO productDAO) {
		this.productDAO = productDAO;
	}

	public IStorageInfoDAO getStorageInfoDAO() {
		return storageInfoDAO;
	}

	public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
		this.storageInfoDAO = storageInfoDAO;
	}


	public String getShortProductsTotal() {
		List<ShortProductTotal> lists;

		//进货dao中去获取缺货的productID和缺货数量
		lists=shortProductTotalDao.getShortProductsTotal();
		Product p;
		StorageInfo storageInfo;
		Date date = productDAO.currentDate();
		//遍历该缺货的list 通过productDao获取缺货商品的基本信息 赋值给缺货商品的product成员变量 
		for(ShortProductTotal s:lists){

			p=productDAO.findById(s.getProductId());

			storageInfo=storageInfoDAO.getStorageInfoByProduct(p,warehouseDAO.getCenterWarehosue());
			//s.setRemainQuantity(storageInfo.getRemainquantity());
			if(storageInfo!=null){
				System.out.print("进货Dao  "+"----------"+
						storageInfo.getLProduct().getProductid()+"  "+
						storageInfo.getLProduct().getProductname());
				System.out.print(" warning "+   storageInfo.getWarningquantity()+"  " );
				System.out.println("max " +     storageInfo.getMaxquantity()+"  " +
						"remain "+  storageInfo.getRemainquantity());

				s.setWarningQuantity(storageInfo.getWarningquantity());
				s.setMaxQuantity(storageInfo.getMaxquantity());
				s.setRemainQuantity(storageInfo.getRemainquantity());
				s.setProduct(p);
				s.setDate(date);
			}
		}
		//生成jason对象
		System.out.println("------"+this.getClass()+"--开始生成jason方法---");
		JSONHelper json=new JSONHelper(); 
		json.setSuccess(true); 
		System.out.println("------------------------");
		System.out.println("------------------------");

		for(ShortProductTotal s:lists){
			System.out.println("-----"+s.getProductId()+" "
					+s.getProduct().getLCategory().getCategoryname()+" "
					+s.getProduct().getProductname()+" "
					+s.getRemainQuantity()+" "
					+s.getWarningQuantity()+" "
					+s.getMaxQuantity()+" "
					+s.getShortQuantityTotal()+" "
					+s.getProduct().getUnit());
			int purchaseAmount=0;
			for(PurchaseInStorageOrderItem pisoi:purchaseInStorageOrderItemDAO.getPurchasedProduct(s.getProduct())){
				purchaseAmount+=pisoi.getLPurchaseproductorder().getProductquantity();
			}
			if(purchaseAmount-s.getShortQuantityTotal()<0){
				json.AddItem("productId", String.valueOf(s.getProductId()));
				//Syste
				json.AddItem("firstCatergory",s.getProduct().getLCategory().getLCategory().getCategoryname() );	
				json.AddItem("secondCategory", s.getProduct().getLCategory().getCategoryname());
				json.AddItem("productName", s.getProduct().getProductname());
				json.AddItem("remainQuantity", String.valueOf(s.getRemainQuantity()));
				json.AddItem("warningQuantity", String.valueOf(s.getWarningQuantity()));
				json.AddItem("maxQuantity", String.valueOf(s.getMaxQuantity()));
				json.AddItem("shortageQuantity", String.valueOf(s.getShortQuantityTotal()-purchaseAmount));
				json.AddItem("puchaseQuantity", String.valueOf(s.getShortQuantityTotal()-purchaseAmount));
				json.AddItem("unit", s.getProduct().getUnit());
				json.AddItem("purchaseDate", s.getDate().toString());
				json.ItemOK();
			}
		}
		System.out.println(this.getClass()+" json="+json.toString());
		// TODO Auto-generated method stub
		return json.toString();
	}


	/**
	 * 生成进货单 存入数据库
	 */
	public boolean addShortProductTotal(List<PurchaseProductOrder> lists) {
		if(lists.size()==0){
			return false;
		}
		for(PurchaseProductOrder t:lists){
			purchaseProductOrderDAO.save(t);
		}
		return true;
	}

	public IPurchaseProductOrderDAO getPurchaseProductOrderDAO() {
		return purchaseProductOrderDAO;
	}

	public void setPurchaseProductOrderDAO(
			IPurchaseProductOrderDAO purchaseProductOrderDAO) {
		this.purchaseProductOrderDAO = purchaseProductOrderDAO;
	}


	/**
	 * 生成入库单
	 */
	public boolean addPurchaseProductInStorageOrder(
			List<PurchaseProductOrder> lists) {
		// TODO Auto-generated method stub
		//生成入库单Item
		PurchaseInStorageOrderItem purchaseInStorageOrderItem;
		PurchaseInstorageOrder purchaseInstorageOrder=new PurchaseInstorageOrder();
		Set purchasepinstorageorderitems = new HashSet(0);
		for(PurchaseProductOrder  p: lists){
			purchaseInstorageOrder.setPurchasedate(p.getPurchaseDate());
			purchaseInStorageOrderItem = new PurchaseInStorageOrderItem();
			purchaseInStorageOrderItem.setLProduct(p.getLProduct());
			purchaseInStorageOrderItem.setLPurchaseproductorder(p);
			purchaseInStorageOrderItem.setRealpurchasequantity(p.getProductquantity());
			purchaseInStorageOrderItem.setLPurchaseinstorageorder(purchaseInstorageOrder);
			purchasepinstorageorderitems.add(purchaseInStorageOrderItem);
		}
		purchaseInstorageOrder.setProductpurchasestate("未到货");
		purchaseInstorageOrder.setPurchasedate(new Date(System.currentTimeMillis()));

		purchaseInstorageOrder.setLPurchasepinstorageorderitems(purchasepinstorageorderitems);
		//purchaseInstorageOrderDAO.attachDirty(purchaseInstorageOrder);
		purchaseInstorageOrderDAO.save(purchaseInstorageOrder);
		return true;
	}
}

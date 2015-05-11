package com.neusoft.logistics.service.impl.storemanage;
/**
 * 李亚方
 */
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.PurchaseInStorageOrderItem;
import com.neusoft.logistics.bean.ShortageOrder;
import com.neusoft.logistics.bean.StorageInfo;
import com.neusoft.logistics.dao.inter.IPurchaseInStorageOrderItemDAO;
import com.neusoft.logistics.dao.inter.IPurchaseInstorageOrderDAO;
import com.neusoft.logistics.dao.inter.IShortageOrderDAO;
import com.neusoft.logistics.dao.inter.IStorageInfoDAO;
import com.neusoft.logistics.dao.inter.IWarehouseDAO;
import com.neusoft.logistics.service.inter.storemanage.ISearchPurchaseOrderItemService;
import com.neusoft.logistics.utils.JSONHelper;

public class SearchPurchaseOrderItemServiceImpl implements ISearchPurchaseOrderItemService{
	

	    private IPurchaseInStorageOrderItemDAO purchaseInStorageOrderItemDAO;
	    private IPurchaseInstorageOrderDAO purchaseInstorageOrderDAO;
	    private IStorageInfoDAO storageInfoDAO;
	    private IShortageOrderDAO shortageOrderDAO;
	    private IWarehouseDAO warehouseDAO;
	 	public IWarehouseDAO getWarehouseDAO() {
			return warehouseDAO;
		}
		public void setWarehouseDAO(IWarehouseDAO warehouseDAO) {
			this.warehouseDAO = warehouseDAO;
		}
		public IShortageOrderDAO getShortageOrderDAO() {
			return shortageOrderDAO;
		}
		public void setShortageOrderDAO(IShortageOrderDAO shortageOrderDAO) {
			this.shortageOrderDAO = shortageOrderDAO;
		}
		public IStorageInfoDAO getStorageInfoDAO() {
			return storageInfoDAO;
		}
		public void setStorageInfoDAO(IStorageInfoDAO storageInfoDAO) {
			this.storageInfoDAO = storageInfoDAO;
		}
		public IPurchaseInStorageOrderItemDAO getPurchaseInStorageOrderItemDAO() {
			return purchaseInStorageOrderItemDAO;
		}
		public void setPurchaseInStorageOrderItemDAO(
				IPurchaseInStorageOrderItemDAO purchaseInStorageOrderItemDAO) {
			this.purchaseInStorageOrderItemDAO = purchaseInStorageOrderItemDAO;
		}
		public IPurchaseInstorageOrderDAO getPurchaseInstorageOrderDAO() {
			return purchaseInstorageOrderDAO;
		}
		public void setPurchaseInstorageOrderDAO(
				IPurchaseInstorageOrderDAO purchaseInstorageOrderDAO) {
			this.purchaseInstorageOrderDAO = purchaseInstorageOrderDAO;
		}
		private String itemToJSON(List<PurchaseInStorageOrderItem> items){
	     	JSONHelper json = new JSONHelper();
	         json.setSuccess(true);	
	         if(items.size()>0){
	         	for(PurchaseInStorageOrderItem i:items){
	             	json.AddItem("purchaseProductOrderItemId",Integer.toString(i.getPurchaseinstorageorderitemid()));
	             	json.AddItem("productId",Integer.toString(i.getLProduct().getProductid()));
	             	json.AddItem("productName",i.getLProduct().getProductname());
	             	json.AddItem("productQuantity",Integer.toString(i.getLPurchaseproductorder().getProductquantity()));
	             	json.AddItem("realIntoQuantity",Integer.toString(i.getRealpurchasequantity()));
	             	json.AddItem("purchaseProductOrderId",Integer.toString(i.getLPurchaseproductorder().getPurchaseproductorderid()));
	             //	System.out.println(this.getClass()+" id="+i.getLPurchaseinstorageorder().getPurchaseinstorageorderid());
	             	json.AddItem("purchaseProductInStorageOrderId", Integer.toString(i.getLPurchaseinstorageorder().getPurchaseinstorageorderid()));
	             	json.AddItem("productPurchaseState",(i.getLPurchaseinstorageorder().getProductpurchasestate()));
	             	json.ItemOK();
	             }
	         }
	         json.setTotalCount(items.size());
	         String jsons="";
	         jsons = json.toString();
	         return jsons;
	     }
		public String getItemsByPurchaseProductInStorageOrderId(int purchaseProductInStorageOrderId){
 		if(purchaseProductInStorageOrderId == 0){
 			List<PurchaseInStorageOrderItem> items = purchaseInStorageOrderItemDAO.findAll();
 			for(int i = 0;i <=items.size()-1;i++){
 				System.out.println("====lyf====="+items.get(i).getPurchaseinstorageorderitemid());
 			}
 			return this.itemToJSON(items);
 		}else{
 			List<PurchaseInStorageOrderItem> items = purchaseInStorageOrderItemDAO.findByProperty("LPurchaseinstorageorder",purchaseInstorageOrderDAO.findById(purchaseProductInStorageOrderId));
 			return this.itemToJSON(items);
 		}
 	}
 	public boolean saveRealIntoQuantity ( int purchaseProductInStorageOrderId , int realIntoQuantity){
 		purchaseInStorageOrderItemDAO.findById(purchaseProductInStorageOrderId).setRealpurchasequantity(realIntoQuantity);
 		return true;
 	}
 	public boolean saveInStorage(int id,String state,Date date,String remark){
 		/**
 		 * 修改购货入库单的基本信息
 		 */
 		purchaseInstorageOrderDAO.findById(id).setProductpurchasestate(state);
 		purchaseInstorageOrderDAO.findById(id).setPurchasedate(date);
 		purchaseInstorageOrderDAO.findById(id).setPuchaseremark(remark);
 		/**
 		 * 修改或添加商品库存量
 		 */
 		List<PurchaseInStorageOrderItem> items = purchaseInStorageOrderItemDAO.findByProperty("LPurchaseinstorageorder",purchaseInstorageOrderDAO.findById(id));
 		for(int i = 0;i < items.size();i++){
 			StorageInfo storageInfo =  storageInfoDAO.findStorageInfoByWarehouseProduct(warehouseDAO.getCenterWarehosue(), items.get(i).getLProduct()).get(0);
 			if(storageInfo==null){
 				StorageInfo temp = new StorageInfo();
 				temp.setLProduct(items.get(i).getLProduct());
 				temp.setLWarehouse(warehouseDAO.getCenterWarehosue());
 				temp.setMaxquantity(1000);
 				temp.setRemainquantity(items.get(i).getRealpurchasequantity());
 				temp.setWarningquantity(50);
 				storageInfoDAO.save(temp);
 			}else{
 				//System.out.println("出库的货物为"+items.get);
 				int update = items.get(i).getRealpurchasequantity()+storageInfo.getRemainquantity();
 				System.out.println();
 	 			storageInfo.setRemainquantity(update);
 			}
 		}
 		/**
 		 * 查出的缺货单满足以下两个条件
 		 * 1.排序按照所属订单要求完成的日期升序排列
 		 * 2.缺货单的状态为缺货
 		 */
 		List<ShortageOrder> shortageItems  = this.shortageOrderDAO.findShortItemsByDateAscAndNotSolved();
 		/**
 		 *将刚到的购货入库单放在一个虚拟的map中,为了方便修改缺货单的状态
 		 *修改缺货单的策略为：先满足生成时间比较早的缺货单
 		 */
 		//List<StorageInfo> storageInfos = storageInfoDAO.findByWarehouse(warehouseDAO.getCenterWarehosue());
 		Map<Product,Integer> virtualStore = new HashMap<Product,Integer>();
 		for(int i = 0;i < items.size();i++){
 			virtualStore.put(items.get(i).getLProduct(),items.get(i).getRealpurchasequantity());
 		}
 		System.out.println("=====lyf======缺货条目总数为"+shortageItems.size());
 		for(int i = 0;i < shortageItems.size();i++){
 			Product product = shortageItems.get(i).getLProduct();
 			if(virtualStore.get(product)!=null&&virtualStore.get(product).intValue()>=shortageItems.get(i).getShortagequantity()){
 				shortageItems.get(i).setShortagestate("已解决");
 				int temp = virtualStore.get(product).intValue()-shortageItems.get(i).getShortagequantity();
 				virtualStore.put(product,new Integer(temp));
 			}
 		}
		return true;
 	}
	public static void main(String args[]){
		Map<String,Integer> test = new HashMap<String,Integer>();
		test.put("apple", new Integer(1));
		test.put("pear",new Integer(2));
		test.put("apple", new Integer(3));
		test.put("apple", new Integer(4));
		System.out.println(test.get("apple").intValue());
	}
}


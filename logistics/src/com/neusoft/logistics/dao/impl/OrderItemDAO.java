package com.neusoft.logistics.dao.impl;
//default package

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.springframework.dao.DataAccessResourceFailureException;

import com.neusoft.logistics.bean.OrderItem;
import com.neusoft.logistics.bean.Product;
import com.neusoft.logistics.bean.Warehouse;
import com.neusoft.logistics.dao.inter.IOrderItemDAO;

/**
 * Data access object (DAO) for domain model class OrderItem.
 * @see .OrderItem
 * @author MyEclipse Persistence Tools 
 */

public class OrderItemDAO extends BaseHibernateDAO<OrderItem> implements IOrderItemDAO  {
	public OrderItemDAO() {
		super(log, OrderItem.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(OrderItemDAO.class);
	//property constants
	public static final String FIRSTCATERGORY = "firstcatergory";
	public static final String SECONDCATEGORY = "secondcategory";
	public static final String PRODUCTNAME = "productname";
	public static final String UNIT = "unit";
	public static final String ORIGINALPRICE = "originalprice";
	public static final String DISCOUNT = "discount";
	public static final String PRODUCTREMARK = "productremark";
	public static final String ORDERITEMAMOUNT = "orderitemamount";


	public List<OrderItem> findByFirstcatergory(Object firstcatergory) {
		return findByProperty(FIRSTCATERGORY, firstcatergory);
	}

	public List<OrderItem> findBySecondcategory(Object secondcategory) {
		return findByProperty(SECONDCATEGORY, secondcategory);
	}

	public List<OrderItem> findByProductname(Object productname) {
		return findByProperty(PRODUCTNAME, productname);
	}

	public List<OrderItem> findByUnit(Object unit) {
		return findByProperty(UNIT, unit);
	}

	public List<OrderItem> findByOriginalprice(Object originalprice) {
		return findByProperty(ORIGINALPRICE, originalprice);
	}

	public List<OrderItem> findByDiscount(Object discount) {
		return findByProperty(DISCOUNT, discount);
	}

	public List<OrderItem> findByProductremark(Object productremark) {
		return findByProperty(PRODUCTREMARK, productremark);
	}

	public List<OrderItem> findByOrderitemamount(Object orderitemamount) {
		return findByProperty(ORDERITEMAMOUNT, orderitemamount);
	}

	public int getAllocatedQuantity(Product product, Warehouse warehouse) {
		// TODO Auto-generated method stub
//		select employee.name,employee.DepNo from Employee as employee 
//		group by employee.DepNo select foo.id, avg( elements(foo.names) ), 
//		max( indices(foo.names) ) from eg.Foo foo group by foo.id 

		List<OrderItem> list=this.getSession().createQuery("from OrderItem where LProduct=:product and LOrder.LSubstationByDeliversubstation.LWarehouse=:warehouse and orderstate=:orderstate").setEntity("product", product).setEntity("warehouse", warehouse).setString("orderstate", "已领货").list();
		int quantity=0;
		for(OrderItem o:list){
			quantity+=o.getOrderitemamount();
		}
		return quantity;
	}

	public List<Product> getTopHotProducts() {
		// TODO Auto-generated method stub
		//获取最热商品
		ResultSet rs = null;
		
		List<Product> listsProduct = new ArrayList<Product>();
		try {
			rs = this.getSession().connection().prepareStatement(
//					"With topHotProduct As (select t.orderitemid, sum(t.orderitemamount) As totalAmount from l_orderitem t Group By  t.orderitemid Order By totalAmount Desc"+
//						")Select * From  l_orderitem t Where t.orderitemid In ( Select top.orderitemid From topHotProduct top Where rownum < 6)"
			"With topHotProduct As " +
			"(select t.product, sum(t.orderitemamount) As totalAmount " +
			"from l_orderitem t Group By  t.product Order By totalAmount Desc)" +
			" Select * " +
			"From  L_product p " +
			"Where p.productid In ( Select top.product From topHotProduct top Where rownum < 6)"	
			).executeQuery();

			listsProduct = new ArrayList<Product>();
			Product product=null;
			while(rs.next()){
				product=new Product();
				product.setProductid(rs.getInt("productid"));
				product.setProductname(rs.getString("productname"));
				listsProduct.add(product);
			}		
			System.out.println("在最热商品dao中，最热数量--------"+listsProduct.size()+"-------------");
		} catch (DataAccessResourceFailureException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listsProduct;
	}

	//按照开始结束时间填写
	public List<Product> getTopHotProductsByTime(String startTime,
			String endTime) {
		// TODO Auto-generated method stub
		ResultSet rs = null;
		
		List<Product> listsProduct = new ArrayList<Product>();

	
			if(startTime!=null && endTime!=null)
				try {
					String hql = "With topHotProduct As " +
					"(select t.product, sum(t.orderitemamount) As totalAmount " +
					"from l_orderitem t,L_ORDER orders " +
					"where orders.requireddate >=  to_date(\'" + startTime +"\','yyyy-mm-dd')"+
					"and orders.requireddate <= to_date(\'" + endTime +"\','yyyy-mm-dd')"+
					"Group By  t.product " +
					"Order By totalAmount Desc)" +
					" Select * " +
					"From  L_product p " +
					"Where p.productid In ( Select top.product From topHotProduct top Where rownum < 6)";
					System.out.println("Hql：按时间查 商品排行：  hql----"+hql);
					rs =  this.getSession().connection().prepareStatement(hql).executeQuery();
				} catch (DataAccessResourceFailureException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (HibernateException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (IllegalStateException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				};
			
			listsProduct = new ArrayList<Product>();
			Product product=null;
			try {
				while(rs.next()){
					product=new Product();
					product.setProductid(rs.getInt("productid"));
					product.setProductname(rs.getString("productname"));
					listsProduct.add(product);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		return listsProduct;
	}

	public List<OrderItem> findOrderItemByOrderId(int id) {
		// TODO Auto-generated method stub
		return null;
	}
}
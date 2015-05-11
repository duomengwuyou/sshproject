package com.neusoft.logistics.dao.impl;
//default package

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.ShortageOrder;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.dao.inter.IOrderDAO;

/**
 * Data access object (DAO) for domain model class Order.
 * @see .Order
 * @author 罗荣博
 */

public class OrderDAO extends BaseHibernateDAO<Order> implements IOrderDAO{

	private static final Log log = LogFactory.getLog(OrderDAO.class);
	//property constants
	public static final String ORDERSTATE = "orderstate";
	public static final String ORDERTYPE = "ordertype";
	public static final String RECEIVEADD = "receiveadd";
	public static final String RECEIVEPERSON = "receiveperson";
	public static final String RECEIVEPERSONTEL = "receivepersontel";
	public static final String RECEIVEPERSONZIP = "receivepersonzip";
	public static final String INVOICEREQUIRED = "invoicerequired";
	public static final String PAYER = "payer";
	public static final String PAYERADD = "payeradd";
	public static final String PAYERTEL = "payertel";
	public static final String PAYERZIPCODE = "payerzipcode";

	public OrderDAO() {
		super(log,Order.class);
		// TODO Auto-generated constructor stub
	}

	public List<Order> findByOrderstate(Object orderstate) {
		return findByProperty(ORDERSTATE, orderstate);
	}

	public List<Order> findByOrdertype(Object ordertype) {
		return findByProperty(ORDERTYPE, ordertype);
	}

	public List<Order> findByReceiveadd(Object receiveadd) {
		return findByProperty(RECEIVEADD, receiveadd);
	}

	public List<Order> findByReceiveperson(Object receiveperson) {
		return findByProperty(RECEIVEPERSON, receiveperson);
	}

	public List<Order> findByReceivepersontel(Object receivepersontel) {
		return findByProperty(RECEIVEPERSONTEL, receivepersontel);
	}

	public List<Order> findByReceivepersonzip(Object receivepersonzip) {
		return findByProperty(RECEIVEPERSONZIP, receivepersonzip);
	}

	public List<Order> findByInvoicerequired(Object invoicerequired) {
		return findByProperty(INVOICEREQUIRED, invoicerequired);
	}

	public List<Order> findByPayer(Object payer) {
		return findByProperty(PAYER, payer);
	}

	public List<Order> findByPayeradd(Object payeradd) {
		return findByProperty(PAYERADD, payeradd);
	}

	public List<Order> findByPayertel(Object payertel) {
		return findByProperty(PAYERTEL, payertel);
	}

	public List<Order> findByPayerzipcode(Object payerzipcode) {
		return findByProperty(PAYERZIPCODE, payerzipcode);
	}

	/**
	 * 带有参数的查询订单
	 * @author 罗荣博
	 */
	public List<Order> findOrderInfo(Order order,String startTime,String endTime) {

		StringBuffer hql = new StringBuffer("from Order where 1=1");

		//这里不能先将startTime转化为Date类型，因为如果前台传过来的时间为空的话，这里的null就不能转化为Date类型了
		//Date startDate = Date.valueOf(startTime);
		//Date endDate = Date.valueOf(endTime);
		
		if(startTime !=null && endTime == null){

			Date startDate = Date.valueOf(startTime);
			hql.append(" and orderdate >= to_date(\'").append(startDate).append("\','yyyy-mm-dd')");
		}else if(startTime == null && endTime != null){

			Date endDate = Date.valueOf(endTime);
			hql.append(" and orderdate <= to_date(\'").append(endDate).append("\','yyyy-mm-dd')");
		}else if(startTime != null && endTime != null){

			Date startDate = Date.valueOf(startTime);
			Date endDate = Date.valueOf(endTime);
			if(startDate.before(endDate)){
				hql.append(" and orderdate >= to_date(\'").append(startDate).append("\','yyyy-mm-dd') and orderdate <= to_date(\'").append(endDate).append("\','yyyy-mm-dd')");
			}else{
				return null;
			}
		}

		if(order.getOrderid()!= -1){
			hql.append(" and orderId=").append(order.getOrderid());
		}
		if(order.getOrdertype() != null && !order.getOrdertype().equals("全部")){
			hql.append(" and ordertype='").append(order.getOrdertype()).append("'");
		}
		if(order.getOrderstate()!=null){
			hql.append(" and orderstate='").append(order.getOrderstate()).append("'");
		}
		if(order.getLCustomer()!=null){
			hql.append(" and LCustomer.customername='").append(order.getLCustomer().getCustomername()).append("'");
		}
		if(order.getReceivepersontel()!=null){
			hql.append(" and receivepersontel='").append(order.getReceivepersontel()).append("'");
		}
		return this.getSession().createQuery(hql.toString()).list();

	}

	/**
	 * 查询所有的订单
	 * @author 罗荣博
	 */
	public List<Order> findAllOrders(){
		StringBuffer hql = new StringBuffer("from Order where 1=1");
		//System.out.println("findAllOrders"+this.getSession().createQuery(hql.toString()).list());
		return this.getSession().createQuery(hql.toString()).list();

	}


	/**
	 * 根据前台传递过来的id查询订单
	 * @author 罗荣博
	 */
	public List<Order> findOrderById(int id){

		StringBuffer hql = new StringBuffer("from Order where orderid = " + id + "");
		return this.getSession().createQuery(hql.toString()).list();

	}

	/**
	 * 宋延杰
	 * 通过完成日期和订单类型查询订单
	 */

	public List<Order> findByRequireddateAndOrdertype(String requiredDate,String orderType){

		StringBuffer hql = new StringBuffer("from Order where orderstate='可分配'");
		if(requiredDate!=null&&!"".equals(requiredDate)){
			hql.append(" and requireddate=to_date('").append(requiredDate).append("','yyyy-mm-dd')");
		}
		if(orderType!=null&&!"".equals(orderType)){
			hql.append(" and ordertype='").append(orderType).append("'");
		}
		return this.getSession().createQuery(hql.toString()).list();
	}
	/**
	 * 宋延杰
	 * 通过完成日期、订单类型、是否到货，查询订单
	 */
	public List<Order> findOrderByRequireddateAndOrdertypeAndShortageState(String requiredDate,String orderType,String shortageState){
		if(requiredDate.equals("完成日期")){
			requiredDate=null;
		}
		if((requiredDate!=null&&(!"".equals(requiredDate)))&&(orderType==null||orderType.equals(""))){
			Date date=Date.valueOf(requiredDate);
			List<Order> orders=new ArrayList<Order>();
			List<ShortageOrder> sos=this.getSession().createQuery("from ShortageOrder where shortagestate=:shortagestate and LOrder.requireddate=:date").setString("shortagestate", shortageState).setDate("date", date).list();
			for(ShortageOrder so:sos){
				if(so.getLOrder().getOrderstate().equals("缺货")){
					orders.add(so.getLOrder());
				}
			}
			return orders;
		}else if((requiredDate==null||requiredDate.equals(""))&&(orderType!=null&&(!"".equals(orderType)))){
			List<Order> orders=new ArrayList<Order>();
			List<ShortageOrder> sos=this.getSession().createQuery("from ShortageOrder where shortagestate=:shortagestate and LOrder.ordertype=:ordertype").setString("shortagestate", shortageState).setString("ordertype", orderType).list();
			for(ShortageOrder so:sos){
				if(so.getLOrder().getOrderstate().equals("缺货")){
					orders.add(so.getLOrder());
				}
			}
			return orders;
		}else if((requiredDate!=null&&(!"".equals(requiredDate)))&&orderType!=null&&(!"".equals(orderType))){
			Date date=Date.valueOf(requiredDate);
			List<Order> orders=new ArrayList<Order>();
			List<ShortageOrder> sos=this.getSession().createQuery("from ShortageOrder where shortagestate=:shortagestate and LOrder.ordertype=:ordertype and LOrder.requireddate=:date ").setString("shortagestate", shortageState).setDate("date", date).setString("ordertype", orderType).list();
			for(ShortageOrder so:sos){
				if(so.getLOrder().getOrderstate().equals("缺货")){
					orders.add(so.getLOrder());
				}
			}
			return orders;
		}
		List<Order> orders=new ArrayList<Order>();
		List<ShortageOrder> sos=this.getSession().createQuery("from ShortageOrder where shortagestate=:shortagestate ").setString("shortagestate", shortageState).list();
		for(ShortageOrder so:sos){
			if(so.getLOrder().getOrderstate().equals("缺货")){
				orders.add(so.getLOrder());
			}
		}
		return orders;
	}

	public void modifyTastState(int orderid) {
		this.getSession().createSQLQuery("update SCOTT.L_ORDER Set  ORDERSTATE='已完成' Where orderid="+orderid).executeUpdate();	
	}

	public void modifyTastStatetoAllocated(int orderid) {
		this.getSession().createSQLQuery("update SCOTT.L_ORDER Set  ORDERSTATE='已分配' Where orderid="+orderid).executeUpdate();	

	}
	public List<Order> findBySubstation(Substation substation){
		return this.getSession().createQuery("from Order o where o.LSubstationByDeliversubstation = :substation").setEntity("substation", substation).list();
	}

	public List<Order> findOrderByCustomer(int customerId){
		StringBuffer hql = new StringBuffer("from Order where customer = " + customerId + "");
		return this.getSession().createQuery(hql.toString()).list();
	}

}
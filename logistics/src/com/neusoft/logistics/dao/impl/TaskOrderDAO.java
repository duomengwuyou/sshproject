package com.neusoft.logistics.dao.impl;

import java.sql.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.classic.Session;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;

/**
 * Data access object (DAO) for domain model class TaskOrder.
 * @see .TaskOrder
 * @author MyEclipse Persistence Tools 
 */

public class TaskOrderDAO extends BaseHibernateDAO<TaskOrder> implements ITaskOrderDAO  {
	public TaskOrderDAO( ) {
		super(log, TaskOrder.class);
		// TODO Auto-generated constructor stub
	}

	private static final Log log = LogFactory.getLog(TaskOrderDAO.class);
	//property constants
	public static final String TASKORDERSTATE = "taskorderstate";
	public static final String TASKORDERTYPE = "taskordertype";



	public List<TaskOrder> findByTaskorderstate(Object taskorderstate) {
		return findByProperty(TASKORDERSTATE, taskorderstate);
	}

	public List<TaskOrder> findByTaskordertype(Object taskordertype) {
		return findByProperty(TASKORDERTYPE, taskordertype);
	}
	/**
	 * 李莎
	 * 得到一个分站的所有任务单
	 */
	public List<TaskOrder> listTaksOrdersBySubstation(Substation substation) {
		// TODO Auto-generated method stub
		return (List<TaskOrder>) this.getSession().createQuery("from TaskOrder where LOrder.LSubstationByDeliversubstation=:substation or LOrder.LSubstationByCheckoutsubstation=:substation")
		.setEntity("substation", substation).list();
	}
	public void modifyTastState(int taskorderId){
		this.getSession().createSQLQuery("update SCOTT.L_TASKORDER Set  TASKORDERSTATE='已完成' Where taskorderid="+taskorderId).executeUpdate();
	}
	 

	
	public void modifyTastState(int taskorderId,String state){
		this.getSession().createSQLQuery("update SCOTT.L_TASKORDER Set  TASKORDERSTATE='"+state+"' Where taskorderid="+taskorderId).executeUpdate();
	}
	/**
	 * 李莎
	 * 
	 * 分配配送员
	 */
	public int modifyDiliverman(int taskorderid, int dilivermanid) {
		this.getSession().createSQLQuery("update SCOTT.L_TASKORDER Set  TASKORDERSTATE='已分配', deliverman = "+dilivermanid+"Where taskorderid="+taskorderid).executeUpdate();
		return 1;
	}
	/**
	 * 李莎
	 * 根据参数查询任务单信息
	 */
	public List<TaskOrder> listTaksOrdersBySubstation(Substation substation,
			String date, String type, String state) {
		String hql = "from TaskOrder t where (LOrder.LSubstationByDeliversubstation=:substation or LOrder.LSubstationByCheckoutsubstation=:substation) ";
		if(date != ""){
			Date d = Date.valueOf(date);
			hql+= "and t.LOrder.requireddate = to_date(\'"+d+"','yyyy-mm-dd')";
		}
		if(type != ""){
			if(!type.equals("任意")){	
				hql+= "and t.taskordertype = '"+type +"' ";
			}
		}
		if(state != ""){
			if(!state.equals("任意")){
				hql+= "and t.taskorderstate = '"+ state+"'";
			}			
		}		
		return (List<TaskOrder>)this.getSession().createQuery(hql).setEntity("substation", substation).list();
	}
	/**
	 * 李莎
	 * 根据参数查询任务单信息(带配送员查询条件的)
	 */
	public List<TaskOrder> listTaksOrdersBySubstation(Substation substation,
			String date, String type, String state, String deliverman) {
		String hql = "from TaskOrder t where (LOrder.LSubstationByDeliversubstation=:substation or LOrder.LSubstationByCheckoutsubstation=:substation) ";
		if(date != ""){
			Date d = Date.valueOf(date);
			hql+= "and t.LOrder.requireddate = to_date(\'"+d+"','yyyy-mm-dd')";
		}
		if(type != ""){
			if(!type.equals("任意")){
				hql+= "and t.taskordertype = '"+type +"' ";
			}		
		}
		if(state != ""){
			if(!state.equals("任意")){
				hql+= "and t.taskorderstate = '"+state+"'";
			}	
		}
		if(deliverman != ""){
			hql+= "and t.LUserByDeliverman.userid = "+ Integer.parseInt(deliverman);
		}	
		return (List<TaskOrder>)this.getSession().createQuery(hql).setEntity("substation", substation).list();
	}
	/**
	 * 李莎 缴款查询
	 * 根据参数得到任务单
	 */
	public List<TaskOrder> listTaksOrdersBySubstation(Substation substation,
			String start, String end) {
		String hql = "from TaskOrder t where (LOrder.LSubstationByDeliversubstation=:substation or LOrder.LSubstationByCheckoutsubstation=:substation) ";
		if(start != "" && start != null && !start.equals("0")){
			Date d = Date.valueOf(start);
			hql+= "and t.LOrder.requireddate >= to_date(\'"+d+"','yyyy-mm-dd')";
		}
		if(end != "" && end != null){
			Date d2 = Date.valueOf(end);
			hql+= "and t.LOrder.requireddate <= to_date(\'"+d2+"','yyyy-mm-dd')";
		}
		hql+= "and t.taskorderstate = '已完成' ";
		return (List<TaskOrder>)this.getSession().createQuery(hql).setEntity("substation", substation).list();
	} 

	public List<TaskOrder> findByOrder(Order order) {
		// TODO Auto-generated method stub
		return this.getSession().createQuery("from TaskOrder t where t.LOrder=:order").setEntity("order", order).list();
	} 
	/**
	 * 宋延杰
	 * 获得最闲配送员
	 */
	public User getLessBusyDeliverman(int substationId) {
		Session s = (Session) this.getSession();
		//获取较闲的配送员
		List lists = null;
		//没有任务单的配送员
		lists = s.createSQLQuery("Select substationEmp.deliverman ,substationEmp.substation " +
				" From l_substationemployee substationEmp ,l_user t " +
				" Where substationEmp.substation = " +substationId+ 
				" And substationEmp.DELIVERMAN = t.USERID" +
				" And t.role = 8 "+
				" And substationEmp.deliverman " +
				" Not In( select torder.deliverman " +
				" from l_taskorder torder, l_substationemployee substationEmp   " +
				" Where  substationEmp.substation = " +substationId+
		" And torder.deliverman = substationEmp.deliverman)").list();

		//有任务单 但是 任务单最少的配送员
		if(lists.size()==0 || lists == null){
			lists = s.createSQLQuery("select torder.deliverman,Count (*) taskCount " +
					" from l_taskorder torder, l_substationemployee substationEmp,l_user t " +
					" Where  substationEmp.substation = " +substationId+
					" And torder.deliverman = substationEmp.deliverman  " +
					" Group By torder.deliverman " +
			" Order By taskCount asc").list(); 
		}

		Iterator iter = null;
		if(lists!=null)
			iter = lists.iterator();
		User u=new User();
		Object[] obj = (Object[])iter.next();
		//设置productID
		if(obj[0]!=null){
			int userId=Integer.valueOf(obj[0].toString());
			List results = this.getSession().createQuery("from User u where u.userid=:userid")
			.setInteger("userid", userId).list();
			if(results.size()!=0){
				return (User)results.get(0);
			}else{
				return null;
			}
		}
		return u;
	} 
	public void modifyTastStateToDispatch(int taskorderId) {
		// TODO Auto-generated method stub
		
	}



}
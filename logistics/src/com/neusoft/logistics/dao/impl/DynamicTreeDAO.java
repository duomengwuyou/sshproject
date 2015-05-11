package com.neusoft.logistics.dao.impl;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.neusoft.logistics.bean.Function;
import com.neusoft.logistics.dao.inter.IDynamicTreeDAO;
/**
 * 
 * @author 周诗龙
 * 获取指定父节点id的子节点信息
 *
 */
public class DynamicTreeDAO extends BaseHibernateDAO<Function> implements IDynamicTreeDAO {
	private static final Log log = LogFactory.getLog(DispatchOrderItemDAO.class);
	public DynamicTreeDAO( ) {
		super(log, Function.class);
		// TODO Auto-generated constructor stub
	}

	public List<String> getDtreeInfos(int parentID,int roleId){
		List<String> dtreeInfos = new ArrayList<String>();
		List results;
		if(roleId==0){
			results = this.getSession().createQuery("from Function f where f.parentid =:parentid").setInteger("parentid", parentID).list();
			for(int i=0;i<results.size();i++){
				Function function = (Function) results.get(i);
				dtreeInfos.add(Integer.toString((function.getFunctionid())));
				dtreeInfos.add(Integer.toString((function.getFunctionid())));
				dtreeInfos.add(function.getFunctionname());
				//dtreeInfos.add(function.getIsleaf());
				dtreeInfos.add(function.getIconcls());
			}
		}else{
			System.out.println("---------------双向表的问题------------------------");
			results = this.getSession().createQuery("from Function f , Role r where f.role.roleid = r.roleid and f.parentid =:parentid and r.roleid =:roleid ").setInteger("parentid", parentID).setInteger("roleid", roleId).list();
			Iterator ir = results.iterator();
			while (ir.hasNext()) {
				Object[] objs = (Object[]) ir.next();
				dtreeInfos.add(Integer.toString(((Function)objs[0]).getFunctionid()));
				dtreeInfos.add(Integer.toString(((Function)objs[0]).getFunctionid()));
				dtreeInfos.add(((Function)objs[0]).getFunctionname());
			//	dtreeInfos.add(((Function)objs[0]).getIsleaf());
				dtreeInfos.add(((Function)objs[0]).getIconcls());
			}
			//results = this.creatQuery("from Function f ").list();
			//sql = "select * from function where parentId = "+parentID+" and roleId = "+roleId;
		}
		
		return dtreeInfos;
	}
}

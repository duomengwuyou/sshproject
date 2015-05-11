package com.neusoft.logistics.service.impl.dynamictree;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.neusoft.logistics.bean.Function;
import com.neusoft.logistics.dao.inter.IDynamicTreeDAO;
import com.neusoft.logistics.dao.inter.IFunctionDAO;
import com.neusoft.logistics.service.inter.dynamictree.IDynamicTreeService;
import com.neusoft.logistics.utils.DTreeJSONHelper;
/**
 * 
 * @author 周诗龙
 * 动态生成指定父节点id的子结点的序列化的JSON
 *
 */
public class DynamicTreeService implements IDynamicTreeService{
//	private IDynamicTreeDAO dynamicTreeDAO;
//	
//	public IDynamicTreeDAO getDynamicTreeDAO() {
//		return dynamicTreeDAO;
//	}
//
//	public void setDynamicTreeDAO(IDynamicTreeDAO dynamicTreeDAO) {
//		this.dynamicTreeDAO = dynamicTreeDAO;
//	}
	private IFunctionDAO functionDAO;
	
	public IFunctionDAO getFunctionDAO() {
		return functionDAO;
	}

	public void setFunctionDAO(IFunctionDAO functionDAO) {
		this.functionDAO = functionDAO;
	}

	public String getDtreeInfos(int parentID,int roleId){
		String DTreeJSON="";
		DTreeJSONHelper json = new DTreeJSONHelper();
	//	List<String> list=dynamicTreeDAO.getDtreeInfos(parentID,roleId);
		System.out.println("DynamicTreeService中parentID为"+parentID);
	//	System.out.println("DynamicTreeService中list的值为："+list.toString());
		List<String> dtreeInfos = new ArrayList<String>();
		List results;
		if(roleId==0){
			results = (List) functionDAO.findByParent(functionDAO.findById(parentID));
			//results = this.getSession().createQuery("from Function f where f.parentid =:parentid").setInteger("parentid", parentID).list();
			for(int i=0;i<results.size();i++){
				Function function = (Function) results.get(i);
				dtreeInfos.add(Integer.toString((function.getFunctionid())));
				dtreeInfos.add(Integer.toString((function.getParent().getFunctionid())));
				dtreeInfos.add(function.getFunctionname());
				dtreeInfos.add(function.getIsleaf());
				dtreeInfos.add(function.getIconcls());
			}
		}else{
			System.out.println("---------------双向表的问题------------------------");
			System.out.println("父节点的id为parentID = "+parentID);
			System.out.println("角色的id为roleID = "+roleId);
			results = functionDAO.findByParentidRoleid(parentID, roleId);
			//results = this.getSession().createQuery("from Function f , Role r where f.role.roleid = r.roleid and f.parentid =:parentid and r.roleid =:roleid ").setInteger("parentid", parentID).setInteger("roleid", roleId).list();
			for(int i=0;i<results.size();i++){
				Function function = (Function) results.get(i);
				dtreeInfos.add(Integer.toString((function.getFunctionid())));
				dtreeInfos.add(Integer.toString((function.getParent().getFunctionid())));
				dtreeInfos.add(function.getFunctionname());
				dtreeInfos.add(function.getIsleaf());
				dtreeInfos.add(function.getIconcls());
			}
//			Iterator ir = results.iterator();
//			while (ir.hasNext()) {
//				Object[] objs = (Object[]) ir.next();
//				dtreeInfos.add(Integer.toString(((Function)objs[0]).getFunctionid()));
//				dtreeInfos.add(Integer.toString(((Function)objs[0]).getParent().getFunctionid()));
//				dtreeInfos.add(((Function)objs[0]).getFunctionname());
//				dtreeInfos.add(((Function)objs[0]).getIsleaf());
//				dtreeInfos.add(((Function)objs[0]).getIconcls());
//			}
			//results = this.creatQuery("from Function f ").list();
			//sql = "select * from function where parentId = "+parentID+" and roleId = "+roleId;
		}
		//System.out.println("DynamicTreeService中dtreeInfos的值为："+dtreeInfos.toString());
		for(int i=0;i<dtreeInfos.size();i+=5){
			json.addItem("id", dtreeInfos.get(i));
			json.addItem("parentid", dtreeInfos.get(i+1));
			json.addItem("text", dtreeInfos.get(i+2));
			json.addItem("leaf", dtreeInfos.get(i+3));
			json.addItem("iconCls", dtreeInfos.get(i+4));
			json.itemOk();
		}
		DTreeJSON = json.toString();
		System.out.println("Json中的数据为："+DTreeJSON);
		System.out.println("---------------双向表的问题结束结束！！！！！------------------------");
		return DTreeJSON;
	}
}

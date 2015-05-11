package com.neusoft.logistics.action.submanage;
import java.sql.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.impl.submanage.SubGetAllTaskServiceImpl;
/**
 * 
 * @author 李莎 
 * 得到分站所有的任务单(用于查询条件带配送员)
 *
 */
public class SubGetAllTaskAction2 extends DispatchAction{

    private SubGetAllTaskServiceImpl subGetAllTaskService;
    
	public SubGetAllTaskServiceImpl getSubGetAllTaskService() {
		return subGetAllTaskService;
	}

	public void setSubGetAllTaskService(
			SubGetAllTaskServiceImpl subGetAllTaskService) {
		this.subGetAllTaskService = subGetAllTaskService;
	}

	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");

	    //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
	    Iterator iterator = user.getLSubstations().iterator();
	    Substation substation = null;
	    
	    if(iterator.hasNext()){
	    	substation = (Substation)iterator.next();
	    }
	    
	    //从页面得到参数
	    String requredatesearch = request.getParameter("RequiredDate");
	    String tasktypesearch = request.getParameter("taskOrderType");
	    String taskstatesearch = request.getParameter("taskOrderState");
	    String deliverman = request.getParameter("deliverman");
	   
	    //调用服务层得到所有任务单的json信息
	    if(requredatesearch == null && tasktypesearch==null && taskstatesearch == null && deliverman == null){
	    	response.getWriter().print(subGetAllTaskService.getSubAllTasks(substation));
	    }else{
	    	response.getWriter().print(subGetAllTaskService.getSubAllTasks(substation, requredatesearch, tasktypesearch, taskstatesearch,deliverman));
	    }
		return null;
	}
}

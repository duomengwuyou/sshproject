package com.neusoft.logistics.action.storemanage;
import java.text.SimpleDateFormat;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.storemanage.ITaskOrderService;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class TakeProductAction extends DispatchAction {
	private ITaskOrderService taskOrderService;
	public ITaskOrderService getTaskOrderService() {
		return taskOrderService;
	}

	public void setTaskOrderService(ITaskOrderService taskOrderService) {
		this.taskOrderService = taskOrderService;
	}
	//根据任务单号来查询分站库房领货

	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String para = request.getParameter("tastkOrderId");
	  //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
	    int taskOrderId = -1;
	    if(para !=null&&!para.equals("")){
	    	taskOrderId = Integer.parseInt(para);
	    }
	    String str = taskOrderService.searchTaskOrder(taskOrderId,user);

//	    String str="{success:true,totalCount:2,data:[{id:'1',taskOrderId:'123456',productName:'大头皮鞋',productQuantity:'1000'}" +
//	    		",{id:'2',taskOrderId:'123456',productName:'李亚方牌沐浴露',productQuantity:'2000'}" +
//	    		",{id:'3',taskOrderId:'123454',productName:'罗荣博牌洗发水',productQuantity:'1000'}]}";
//	    
	    response.getWriter().print(str);
		return null;
	}
	/**
	 * 确定领货
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward doSureTakeProduct(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String para1 = request.getParameter("taskOrderId");
	    String deliverman = request.getParameter("deliverman");
	    String para2 = request.getParameter("takeProductDate");
	    //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
//	    System.out.println("获取的taskOrderId为："+para1);
//	    System.out.println("获取的deliverman为："+deliverman);
//	    System.out.println("获取的takeProductDate为："+para2);
	    int taskOrderId = -1;
	    //System.out.println("Date.parse(para2)e转化的格式为: " + Date.valueOf(para2));
	    Date takeProductDate =null ;
	    boolean flag = false;
	    //日期字符串date转换为Date格式
	    if(para2!=null&&!para2.equals("")){
	    	takeProductDate = Date.valueOf(para2);
	    }
	    if(para1!=null&&!para1.equals("")){
	    	taskOrderId = Integer.parseInt(para1);
	    }
	    if(deliverman!=null&&!deliverman.equals("")&&taskOrderId!=-1&&takeProductDate!=null){
	    	System.out.println("//////////////////在Action中是否已经进入保存商品界面");
	    	flag = taskOrderService.saveTakeProduct(taskOrderId, deliverman, takeProductDate);
	    	taskOrderService.saveSubstationProduct(user, taskOrderId);
	    	if(flag){
	    		response.getWriter().print("{success:true}");
	    	}else{
	    		response.getWriter().print("{success:false}");
	    	}
	    }
		return null;
	}
}

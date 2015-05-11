package com.neusoft.logistics.action.storemanage;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.Substation;
import com.neusoft.logistics.bean.User;
import com.neusoft.logistics.service.inter.storemanage.IDispatchOrderService;

public class SubstationIntoAction extends DispatchAction{
	private IDispatchOrderService dispatchOrderService;
	public IDispatchOrderService getDispatchOrderService() {
		return dispatchOrderService;
	}
	public void setDispatchOrderService(IDispatchOrderService dispatchOrderService) {
		this.dispatchOrderService = dispatchOrderService;
	}
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String para = request.getParameter("dispatchOrderId");
	    //System.out.println("==================SubstationIntoAction的doSearch方法===============");
	    //System.out.println("获取的dispatchOrderId为:"+para);
	    int dispatchOrderId = -1;
	    if(para != null&&!para.equals("")){
	    	dispatchOrderId = Integer.parseInt(para);
	    }
	    //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
	    String str = null;
	    if(user!=null){
	    	str = dispatchOrderService.searchDispatchOrder(dispatchOrderId,user);
	    }
	     
//	    String str="{success:true,totalCount:2,data:[{id:'1',dispatchOrderId:'123456',productName:'大头皮鞋',productQuantity:'1000',realIntoQuantity:'',realIntoDate:'2011-7-19',receiveFormRemark:'不错'}" +
//	    		",{id:'2',dispatchOrderId:'123456',productName:'李亚方牌沐浴露',productQuantity:'2000',realIntoQuantity:'',realIntoDate:'2011-7-19',receiveFormRemark:'不错'}" +
//	    		",{id:'3',dispatchOrderId:'123454',productName:'罗荣博牌洗发水',productQuantity:'1000',realIntoQuantity:'',realIntoDate:'2011-7-19',receiveFormRemark:'不错'}]}";
//	    
	    response.getWriter().print(str);
		return null;
	}
	public ActionForward doSubstationInto(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("==================SubstationIntoAction的doSubstationInto方法===============");
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    String para1 = request.getParameter("dispatchOrderItemId");
	    String para2 = request.getParameter("realIntoQuantity");
	    String para3 = request.getParameter("dispatchOrderId");
	    //System.out.println("==================SubstationIntoAction===============");
	    System.out.println("获取的dispatchOrderItemId为:"+para1);
	    System.out.println("获取的realIntoQuantity为:"+para2);
	    //通过session得到登陆用户所在的分站
	    HttpSession session = request.getSession();
	    User user = (User)session.getAttribute("user");
	    Iterator iterator = user.getLSubstations().iterator();
	    Substation substation = null;
	    if(iterator.hasNext()){
	    	substation = (Substation)iterator.next();
	    }
	    List<Integer>  dispatchOrderItemIdList = new ArrayList<Integer>();
	    List<Integer>  realIntoQuantityList = new ArrayList<Integer>();
	    if(substation!=null&&para1!=null&&!para1.equals("")&&para2!=null&&!para2.equals("")&&para3!=null&&!para3.equals("")){
	    	String[] root1 = para1.split(",");
	    	String[] root2 = para2.split(",");
			for(String temp:root1){
				dispatchOrderItemIdList.add(Integer.parseInt(temp));
			}
			for(String temp:root2){
				realIntoQuantityList.add(Integer.parseInt(temp));
			}
			for(int i=0;i<dispatchOrderItemIdList.size();i++){
				System.out.println("realIntoQuantityList.get(i):"+realIntoQuantityList.get(i));
				System.out.println("dispatchOrderItemIdList.get(i):"+dispatchOrderItemIdList.get(i));
				dispatchOrderService.saveSubstationProduct(user, dispatchOrderItemIdList.get(i), realIntoQuantityList.get(i));
				dispatchOrderService.saveRealIntoQuantity(dispatchOrderItemIdList.get(i), realIntoQuantityList.get(i));
				//dispatchOrderService.saveSubstationProduct(user, dispatchOrderItemIdList.get(i), realIntoQuantityList.get(i));
			}
			int dispatchOrderId = Integer.parseInt(para3);
			dispatchOrderService.updateTaskOrderState(substation);
			response.getWriter().print("{success:true}");
	    }
	    
//	    int realIntoQuantity = 0;
//	    int dispatchOrderItemId = -1;
//	    if(para1 != null&&!para1.equals("")){
//	    	dispatchOrderItemId = Integer.parseInt(para1);
//	    }
//	    if(para2 != null&&!para2.equals("")){
//	    	realIntoQuantity = Integer.parseInt(para2);
//	    }
//	    boolean flag= false;
//	    String str = null;
//	    if(dispatchOrderItemId!=0){
//	    	flag = dispatchOrderService.saveRealIntoQuantity(dispatchOrderItemId, realIntoQuantity);
//	    	//str = dispatchOrderService.searchDispatchOrder(dispatchOrderItemId);
//	    }
//	    String str="{success:true,totalCount:2,data:[{id:'1',dispatchOrderId:'123456',productName:'大头皮鞋',productQuantity:'1000',realIntoQuantity:'',realIntoDate:'2011-7-19',receiveFormRemark:'不错'}" +
//	    		",{id:'2',dispatchOrderId:'123456',productName:'李亚方牌沐浴露',productQuantity:'2000',realIntoQuantity:'',realIntoDate:'2011-7-19',receiveFormRemark:'不错'}" +
//	    		",{id:'3',dispatchOrderId:'123454',productName:'罗荣博牌洗发水',productQuantity:'1000',realIntoQuantity:'',realIntoDate:'2011-7-19',receiveFormRemark:'不错'}]}";
//	    
//	    response.getWriter().print(str);
		return null;
	}
}

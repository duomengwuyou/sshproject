package com.neusoft.logistics.action.dispatcherCenterManage.statisticInfo;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.service.inter.dispatchCenterManage.ICustomerSatisfactionService;
/**
 * PurchaseProductAction
 * @author 龚玉斌
 *
 */
public class CustomerSatisfactionAction extends DispatchAction{
		private ICustomerSatisfactionService customerSatisfactionService;
		public ActionForward doSearch(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			response.setContentType("text/json;charset=utf-8");
		    response.setCharacterEncoding("UTF-8");
		    request.setCharacterEncoding("UTF-8");
		    //获取页面查询 开始 结束时间
		    String startTime = request.getParameter("startTime");
		    String endTime = request.getParameter("endTime");
		    String str = null;
		    if(startTime==null && endTime==null)
		    	 str = customerSatisfactionService.getAllCustomerSatisfaction();
		    else
		    	str = customerSatisfactionService.getCustomerSatisfaction(startTime, endTime);
//		    String str="{success:true,totalCount:3,data:[{customerName:'宋延杰',customerId:'1',satisfiedRatio:'9'}" +
//		    		",{customerName:'张文华',customerId:'2',satisfiedRatio:'9'}" +
//		    		",{customerName:'李莎',customerId:'3',satisfiedRatio:'9'}]}";
		   
		    response.getWriter().print(str);
			return null;
		}
		
		
		public ICustomerSatisfactionService getCustomerSatisfactionService() {
			return customerSatisfactionService;
		}
		public void setCustomerSatisfactionService(
				ICustomerSatisfactionService customerSatisfactionService) {
			this.customerSatisfactionService = customerSatisfactionService;
		}
	}

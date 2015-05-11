package com.neusoft.logistics.action.submanage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.neusoft.logistics.bean.FeedBackOrder;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.dao.impl.FeedBackOrderDAO;
import com.neusoft.logistics.dao.impl.TaskOrderDAO;
import com.neusoft.logistics.service.impl.submanage.SubSaveFeedbackTaskServiceImpl;
/**
 * 
 * @author 李莎 
 * 保存分站回执信息
 *
 */
public class SubSaveFeedbackTaskAction extends DispatchAction{
	
	private SubSaveFeedbackTaskServiceImpl  saveFeedbackTaskService;
	
	public ActionForward doSearch(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/json;charset=utf-8");
	    response.setCharacterEncoding("UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    //从页面获得参数
	    String taskorderId = request.getParameter("signedOrder");
	    String state = request.getParameter("state");
	    String satisfaction = request.getParameter("satisfaction");
	    String feedBackRemark = request.getParameter("feedBackRemark");
		 System.out.println(this.getClass()+" before saveFeedBack");
	    //调用服务层的保存回执方法
	   int i =  saveFeedbackTaskService.saveFeedback(Integer.parseInt(taskorderId), state, Integer.parseInt(satisfaction), feedBackRemark);
	   if(i==1){
		   String str="{success:true}";
		   response.getWriter().print(str);
	   }
		return null;
	}
	public SubSaveFeedbackTaskServiceImpl getSaveFeedbackTaskService() {
		return saveFeedbackTaskService;
	}
	public void setSaveFeedbackTaskService(
			SubSaveFeedbackTaskServiceImpl saveFeedbackTaskService) {
		this.saveFeedbackTaskService = saveFeedbackTaskService;
	}
}

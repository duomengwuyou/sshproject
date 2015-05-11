package com.neusoft.logistics.service.impl.submanage;
 

import com.neusoft.logistics.bean.FeedBackOrder;
import com.neusoft.logistics.bean.Order;
import com.neusoft.logistics.bean.TaskOrder;
import com.neusoft.logistics.dao.inter.IFeedBackOrderDAO;
import com.neusoft.logistics.dao.inter.IOrderDAO;
import com.neusoft.logistics.dao.inter.ITaskOrderDAO;
import com.neusoft.logistics.service.inter.submanage.ISubSaveFeedbackTaskService;

public class SubSaveFeedbackTaskServiceImpl implements ISubSaveFeedbackTaskService{
	
	private IFeedBackOrderDAO feedbackDAO;
	private ITaskOrderDAO taskorderDAO;
	private IOrderDAO orderDAO;
	
	public IFeedBackOrderDAO getFeedbackDAO() {
		return feedbackDAO;
	}

	public void setFeedbackDAO(IFeedBackOrderDAO feedbackDAO) {
		this.feedbackDAO = feedbackDAO;
	}

	public ITaskOrderDAO getTaskorderDAO() {
		return taskorderDAO;
	}

	public void setTaskorderDAO(ITaskOrderDAO taskorderDAO) {
		this.taskorderDAO = taskorderDAO;
	}

	public IOrderDAO getOrderDAO() {
		return orderDAO;
	}

	public void setOrderDAO(IOrderDAO orderDAO) {
		this.orderDAO = orderDAO;
	}

	/**
	 * 保存回执信息
	 */
	public int saveFeedback(int taskorderId, String state, int satisfaction, String feedBackRemark) {

		FeedBackOrder feedback = new FeedBackOrder();
		TaskOrder task = taskorderDAO.findById(taskorderId); 
	
		feedback.setTaskorder(task);
		feedback.setSatisfaction(satisfaction);
		feedback.setTaskstate(state);
		feedback.setFeedbackremark(feedBackRemark);

		//更改对应的任务单和订单状态
		taskorderDAO.modifyTastState(taskorderId);
		orderDAO.modifyTastState(task.getLOrder().getOrderid());
		
		//保存回执信息
		feedbackDAO.save(feedback);
	
		return 1;
	}
}

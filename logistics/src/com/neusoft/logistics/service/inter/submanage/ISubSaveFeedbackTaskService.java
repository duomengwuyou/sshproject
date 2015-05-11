package com.neusoft.logistics.service.inter.submanage;


public interface ISubSaveFeedbackTaskService {
	public int saveFeedback(int taskorderId, String state, int satisfaction, String feedBackRemark);
}

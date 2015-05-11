package com.neusoft.logistics.dao.inter;

import java.sql.Date;
import java.util.List;

import com.neusoft.logistics.bean.FeedBackOrder;

public interface IFeedBackOrderDAO extends IBaseDAO<FeedBackOrder> {

	public List<FeedBackOrder> findByTime(Date begin,Date end);
}

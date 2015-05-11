package com.neusoft.logistics.dao.inter;
import java.util.List;

import com.neusoft.logistics.bean.Function;
/**
 * 
 * @author 周诗龙
 * 获取指定父节点id的子节点信息
 *
 */
public interface IDynamicTreeDAO extends IBaseDAO<Function> {
	public List<String> getDtreeInfos(int parentID,int roleId);
}

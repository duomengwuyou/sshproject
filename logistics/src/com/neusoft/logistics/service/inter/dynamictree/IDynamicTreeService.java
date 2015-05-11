package com.neusoft.logistics.service.inter.dynamictree;
import java.util.List;
/**
 * 
 * @author 周诗龙
 * 动态生成指定父节点id的子结点的序列化的JSON
 *
 */
public interface IDynamicTreeService {
	public String getDtreeInfos(int parentID,int roleId);
}

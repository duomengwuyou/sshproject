/**
 * 
 */
package com.neusoft.logistics.dao.inter;

import java.util.List;

import com.neusoft.logistics.bean.Function;
import com.neusoft.logistics.bean.Role;

/**
 * @author 陈秀能
 *
 */
public interface IFunctionDAO extends IBaseDAO<Function> {
	/**
	 * 根据父功能查找子功能
	 * */
	public List<Function> findByParent(Function parent);
	/**
	 * 根据角色查找一级功能，使用一级Function的getChildren()获得该功能下的所有子功能
	 * */
	public List<Function> findParentsByRole(Role role);
	public List<Function> findByParentidRoleid(int parentId,int roleid);
}

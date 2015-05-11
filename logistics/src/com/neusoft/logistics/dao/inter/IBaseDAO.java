package com.neusoft.logistics.dao.inter;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;
/**
 * 数据访问对象接口，封装了访问数据库的常用方法 
 * @author 陈秀能
 * **/
public interface IBaseDAO<T> {
	/**
	 * 保存对象 
	 * @param  t 要保存的对象
	 * **/
	public void save(T t);
	/**
	 * 删除对象 
	 * @param  t 要删除的对象
	 * **/
	public void delete(T t);
	/**
	 * 根据主键查找对象  
	 * @return T 要查找的对象 
	 * @param  id 对象主键
	 * **/
	public T findById(Serializable id);

	/**
	 * 根据属性查找对象 
	 * @return List<T> 对象列表
	 * @param  propertyName 属性名称
	 * @param  value 属性值
	 * */
	public List<T> findByProperty(String propertyName, Object value);
	/**
	 * 查找所有对象 
	 * @return List<T> 对象列表 
	 * */
	public List<T> findAll() ;
	/**
	 * 将传入的对象持久化并保存。 
	 * 如果对象未保存（Transient状态），调用save方法保存。如果对象已保存（Detached状态），调用update方法将对象与Session重新关联。
	 * @param t 要更新的对象 
	 * */
	public void attachDirty(T t) ;
	/**
	 * 根据存在属性查找，对于条件为null的属性不作为查找条件 
	 * @return List<T> 对象列表 
	 * @param t 查找的对象
	 * */
	public List<T> findByExample(T t);

	/**
	 * 将传入的对象状态设置为Transient状态  
	 * @param t 查找的对象
	 * */
	public void attachClean(T t) ;
	/**
	 * 将传入的detached状态的对象的属性复制到持久化对象中，并返回该持久化对象 
	 * 如果该session中没有关联的持久化对象，加载一个，如果传入对象未保存，保存一个副本并作为持久对象返回，传入对象依然保持detached状态。
	 * @param t 要保存的对象
	 * */
	public T merge(T t) ;
	/**
	 * 提交数据
	 * **/
	
	//public void commit(); 
	/**
	 * 获取数据库服务器里的当前时间
	 */
	 public Date currentDate();
}

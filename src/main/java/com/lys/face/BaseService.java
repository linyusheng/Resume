package com.lys.face;

import java.io.Serializable;
import java.util.List;

/**
 * 基本业务处理接口
 * @author between
 */
public interface BaseService<T> {
	/**
	 * 根据主键查找对象
	 * @param id
	 * @return
	 */
	T get(Integer id);
	/**
	 * 保存对象，返回主键
	 * @param o
	 * @return
	 */
	Serializable save(T o);
	/**
	 * 更新对象
	 * @param o
	 */
	void update(T o);
	/**
	 * 根据主键删除对象
	 * @param id
	 */
	void delete(Integer id);
	/**
	 * 查找所有对象
	 * @return
	 */
	List<T> findAll();
	
}

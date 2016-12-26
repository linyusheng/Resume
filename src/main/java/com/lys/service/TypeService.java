package com.lys.service;

import java.io.Serializable;
import java.util.List;

import com.lys.face.BaseService;
import com.lys.face.ITypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Type;

/**
 * 简历模板类型业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class TypeService implements ITypeService {
	
	@Autowired
	private BaseDAO<Type> baseDAO;

	public Type get(Integer id) {
		return baseDAO.get(Type.class, id);
	}

	public Serializable save(Type o) {
		return baseDAO.save(o);
	}

	public void update(Type o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Type> findAll() {
		return baseDAO.find("from Type");
	}
	
	

}

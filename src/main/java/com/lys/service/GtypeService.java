package com.lys.service;

import java.io.Serializable;
import java.util.List;

import com.lys.face.BaseService;
import com.lys.face.IGtypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Gtype;

/**
 * 商品类型业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class GtypeService implements IGtypeService {
	
	@Autowired
	private BaseDAO<Gtype> baseDAO;

	public Gtype get(Integer id) {
		return baseDAO.get(Gtype.class, id);
	}

	public Serializable save(Gtype o) {
		return baseDAO.save(o);
	}

	public void update(Gtype o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Gtype> findAll() {
		return baseDAO.find("from Gtype");
	}

}

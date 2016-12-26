package com.lys.service;

import java.io.Serializable;
import java.util.List;

import com.lys.face.BaseService;
import com.lys.face.IGuideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Guide;

/**
 * 技巧指导业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class GuideService implements IGuideService {
	
	@Autowired
	private BaseDAO<Guide> baseDAO;

	public Guide get(Integer id) {
		return baseDAO.get(Guide.class, id);
	}

	public Serializable save(Guide o) {
		return baseDAO.save(o);
	}

	public void update(Guide o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Guide> findAll() {
		return baseDAO.find("from Guide");
	}

}

package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IEduinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Eduinfo;

@Service
public class EduinfoService implements IEduinfoService {
	
	@Autowired
	private BaseDAO<Eduinfo> baseDAO;

	public Eduinfo get(Integer id) {
		return baseDAO.get(Eduinfo.class, id);
	}

	public Serializable save(Eduinfo o) {
		return baseDAO.save(o);
	}

	public void update(Eduinfo o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Eduinfo> findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 获取用户简历的教育背景
	 * @param id
	 * @return
	 */
	public List<Eduinfo> findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Eduinfo where uid = :id";
		return baseDAO.find(hql, params);
	}
	
}

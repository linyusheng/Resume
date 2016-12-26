package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IStuinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Stuinfo;

@Service
public class StuinfoService implements IStuinfoService {
	
	@Autowired
	private BaseDAO<Stuinfo> baseDAO;

	public Stuinfo get(Integer id) {
		return baseDAO.get(Stuinfo.class, id);
	}

	public Serializable save(Stuinfo o) {
		return baseDAO.save(o);
	}

	public void update(Stuinfo o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Stuinfo> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 获取用户简历的学生工作
	 * @param id
	 * @return
	 */
	public List<Stuinfo> findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Stuinfo where uid = :id";
		return baseDAO.find(hql, params);
	}
}

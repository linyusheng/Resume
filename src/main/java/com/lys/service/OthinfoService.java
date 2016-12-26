package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IOthinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Othinfo;

@Service
public class OthinfoService implements IOthinfoService {
	
	@Autowired
	private BaseDAO<Othinfo> baseDAO;

	public Othinfo get(Integer id) {
		return baseDAO.get(Othinfo.class, id);
	}

	public Serializable save(Othinfo o) {
		return baseDAO.save(o);
	}

	public void update(Othinfo o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Othinfo> findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 获取用户简历的其它信息
	 * @param id
	 * @return
	 */
	public List<Othinfo> findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Othinfo where uid = :id";
		return baseDAO.find(hql, params);
	}

}

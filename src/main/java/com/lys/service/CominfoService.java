package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.ICominfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Cominfo;

@Service
public class CominfoService implements ICominfoService {
	
	@Autowired
	private BaseDAO<Cominfo> baseDAO;

	public Cominfo get(Integer id) {
		return baseDAO.get(Cominfo.class, id);
	}

	public Serializable save(Cominfo o) {
		return baseDAO.save(o);
	}

	public void update(Cominfo o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Cominfo> findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 获取用户简历的比赛/项目
	 * @param id
	 * @return
	 */
	public List<Cominfo> findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Cominfo where uid = :id";
		return baseDAO.find(hql, params);
	}

}

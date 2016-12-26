package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IWorkinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Workinfo;

@Service
public class WorkinfoService implements IWorkinfoService {
	
	@Autowired
	private BaseDAO<Workinfo> baseDAO;

	@Override
	public Workinfo get(Integer id) {
		return baseDAO.get(Workinfo.class, id);
	}

	@Override
	public Serializable save(Workinfo o) {
		return baseDAO.save(o);
	}

	@Override
	public void update(Workinfo o) {
		baseDAO.update(o);
	}

	@Override
	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	@Override
	public List<Workinfo> findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 获取用户简历的实习/工作
	 * @param id
	 * @return
	 */
	public List<Workinfo> findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Workinfo where uid = :id";
		return baseDAO.find(hql, params);
	}

}

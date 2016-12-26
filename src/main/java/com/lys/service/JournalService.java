package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IJournalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Journal;

/**
 * 简历日志业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class JournalService implements IJournalService {
	
	@Autowired
	private BaseDAO<Journal> baseDAO;

	public Journal get(Integer id) {
		return baseDAO.get(Journal.class, id);
	}

	public Serializable save(Journal o) {
		return baseDAO.save(o);
	}

	public void update(Journal o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Journal> findAll() {
		return baseDAO.find("from Journal");
	}
	/**
	 * 统计日志量
	 * @return
	 */
	public Long count() {
		return baseDAO.count("select count(*) from Journal");
	}
	/**
	 * 查找用户的日志
	 * @param uid
	 * @return
	 */
	public List<Journal> findByUser(Integer uid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		String hql = "from Journal where uid = :uid";
		return baseDAO.find(hql, params);
	}
	
	
}

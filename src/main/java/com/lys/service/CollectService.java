package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.ICollectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Collect;


@Service
public class CollectService implements ICollectService {
	
	@Autowired
	private BaseDAO<Collect> baseDAO;

	public Collect get(Integer id) {
		return baseDAO.get(Collect.class, id);
	}

	public Serializable save(Collect o) {
		return baseDAO.save(o);
	}

	public void update(Collect o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Collect> findAll() {
		return baseDAO.find("from Collect");
	}
	/**
	 * 查找用户的收藏
	 * @param uid
	 * @return
	 */
	public List<Collect> findByUser(Integer uid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		String hql = "from Collect where uid = :uid";
		return baseDAO.find(hql,params);
	}
	/**
	 * 删除用户指定类型的收藏
	 */
	public void delete(Integer uid,String kind,Integer tid){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		params.put("kind", kind);
		params.put("tid", tid);
		String hql = "delete from Collect where uid = :uid and kind = :kind and tid = :tid";
		baseDAO.executeHql(hql,params);
	}
	/**
	 * 查找用户指定类型的收藏
	 */
	public List<Collect> findByUser(Integer uid,String kind){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		params.put("kind", kind);
		String hql = "from Collect where uid = :uid and kind = :kind";
		return baseDAO.find(hql,params);
	}


}

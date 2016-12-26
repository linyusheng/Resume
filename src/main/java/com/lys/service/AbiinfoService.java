package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.IAbiinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.lys.dao.BaseDAO;
import com.lys.entity.Abiinfo;
import com.lys.entity.Userinfo;
import com.lys.model.It;
import com.lys.model.Language;
import com.lys.model.MAbiinfo;

@Service
public class AbiinfoService implements IAbiinfoService {
	
	@Autowired
	private BaseDAO<Abiinfo> baseDAO;
	@Autowired
	private BaseDAO<String> stringDAO;

	public Abiinfo get(Integer id) {
		return baseDAO.get(Abiinfo.class, id);
	}

	public Serializable save(Abiinfo o) {
		return baseDAO.save(o);
	}

	public void update(Abiinfo o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Abiinfo> findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	/**
	 * 初始化
	 * @param user
	 */
	public void init(Userinfo user) {
		Abiinfo abiinfo = new Abiinfo(user.getUid(),"[]","[]","[]","[]","[]");
		save(abiinfo);
	}
	/**
	 * 获取用户简历的个人素质(转化后)
	 * @param id
	 * @return
	 */
	public MAbiinfo findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Abiinfo where uid = :id";
		Abiinfo abiinfo = baseDAO.get(hql, params);
		String languageAbility,itAbility,certificate,character,hobby;
		languageAbility=itAbility=certificate=character=hobby = "[]";
		if (abiinfo != null) {
			languageAbility = abiinfo.getLanguageAbility();
			itAbility = abiinfo.getItAbility();
			certificate = abiinfo.getCertificate();
			character = abiinfo.getCharacters();
			hobby = abiinfo.getHobby();
		}
		MAbiinfo m = new MAbiinfo();
		m.setLanguageAbility(JSON.parseArray(languageAbility, Language.class));
		m.setItAbility(JSON.parseArray(itAbility, It.class));
		m.setCertificate(JSON.parseArray(certificate, String.class));
		m.setCharacter(JSON.parseArray(character, String.class));
		m.setHobby(JSON.parseArray(hobby, String.class));
		return m;
	}
	/**
	 * 根据属性名称更新字段
	 * @param field
	 * @param userId
	 * @param data
	 */
	public void update(String field,Integer userId,String data) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", userId);
		params.put("lang", data);
		String hql = "update Abiinfo set " + field + " = :lang where uid = :uid";
		baseDAO.executeHql(hql, params);
	}
	/**
	 * 根据属性名称获取个人素质信息
	 * @param uid
	 * @return
	 */
	public String findByUserId(String field,Integer uid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		String sql = "select " + field + " from Abiinfo where uid = :uid";
		return stringDAO.find(sql, params).get(0);
	}
	
	
}

package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IHoninfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Honinfo;
import com.lys.entity.Userinfo;

@Service
public class HoninfoService implements IHoninfoService {
	
	@Autowired
	private BaseDAO<Honinfo> baseDAO;

	public Honinfo get(Integer id) {
		return baseDAO.get(Honinfo.class, id);
	}

	public Serializable save(Honinfo o) {
		return baseDAO.save(o);
	}

	public void update(Honinfo o) {
		//TODO:使用hibernate的update无法更新
		//baseDAO.update(o);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", o.getId());
		params.put("world", o.getWorldPrize());
		params.put("national", o.getNationalPrize());
		params.put("province", o.getProvincePrize());
		params.put("college", o.getCollegePrize());
		params.put("other", o.getOtherPrize());
		String hql = "update Honinfo set worldPrize=:world, nationalPrize=:national, provincePrize=:province, collegePrize=:college, otherPrize=:other where id=:id";
		baseDAO.executeHql(hql,params);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Honinfo> findAll() {
		return baseDAO.find("from Honinfo");
	}
	/**
	 * 初始化荣誉信息
	 */
	public void init(Userinfo userinfo) {
		Honinfo honinfo = new Honinfo(userinfo.getUid(),"","","","","");
		save(honinfo);
	}
	/**
	 * 获取用户简历的荣誉奖励
	 * @param id
	 * @return
	 */
	public Honinfo findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Honinfo where uid = :id";
		return baseDAO.get(hql, params);
	}
}

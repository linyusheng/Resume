package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IBaseinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Baseinfo;
import com.lys.entity.Userinfo;
import com.lys.util.Global;
import com.lys.util.Page;

@Service
public class BaseinfoService implements IBaseinfoService {
	
	@Autowired
	private BaseDAO<Baseinfo> baseDAO;

	public Baseinfo get(Integer id) {
		return baseDAO.get(Baseinfo.class, id);
	}

	public Serializable save(Baseinfo o) {
		return baseDAO.save(o);
	}

	public void update(Baseinfo o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Baseinfo> findAll() {
		return baseDAO.find("from Baseinfo");
	}
	/**
	 * 统计简历信息量
	 * @return
	 */
	public Long count() {
		return baseDAO.count("select count(*) from Baseinfo");
	}
	/**
	 * 初始化简历基本信息
	 * @param user
	 */
	public void init(Userinfo user) {
		Baseinfo baseinfo = new Baseinfo();
		baseinfo.setUid(user.getUid());
		baseinfo.setName(user.getAccount().substring(0, user.getAccount().indexOf("@")));
		baseinfo.setSex(1);
		baseinfo.setBirthDate("1995-01-01");
		baseinfo.setEmail(user.getAccount());
		baseinfo.setPhone("");
		baseinfo.setAddress("");
		baseinfo.setPostcode("");
		baseinfo.setPoliticsStatus(1);
		baseinfo.setFaceLargeFullUrl(Global.DEFAULT_HEAD);
		baseinfo.setUniversity("");
		baseinfo.setEducation("");
		baseinfo.setDegree("");
		baseinfo.setMajor("");
		baseinfo.setGraduation("");
		baseinfo.setTrade("");
		baseinfo.setPosition("");
		baseinfo.setCity("");
		baseinfo.setRname("");
		baseinfo.setKeyword("");
		baseinfo.setBrowseNum("");
		baseinfo.setCollectNum("");
		save(baseinfo);
	}
	/**
	 * 获取用户简历的基本信息
	 * @param id
	 * @return
	 */
	public Baseinfo findByUser(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		String hql= "from Baseinfo where uid = :id";
		return baseDAO.get(hql, params);
	}
	/**
	 * 修改用户头像
	 * @param uid
	 * @param head
	 * @return
	 */
	public boolean editHead(Integer uid,String head) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		params.put("head", head);
		String hql= "update Baseinfo set faceLargeFullUrl = :head where uid = :uid"; 
		return baseDAO.executeHql(hql,params) > 0 ? true : false;
	}
	/**
	 * 搜索简历
	 * @param key
	 * @return
	 */
	@Cacheable(value = "dayCache",key = "#key+'_'+#positionId+'_'+#educationId+'_'+#page.currentPage")
	public Map<String,Object> search(String key,Integer positionId,Integer educationId,Page page) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", "%%"+key.trim()+"%%");
		String hql = "from Baseinfo WHERE rname like :key and keyword like :key";
		if (positionId != null && positionId != 0) {
			params.put("pId", "%%"+positionId+"%%");
			hql += " and position like :pId";
		}
		if (educationId != null && educationId != 0) {
			params.put("eId", educationId+"");
			hql += " and education = :eId";
		}
		List<Baseinfo> list = baseDAO.find(hql, params, page.getCurrentPage(), page.getPageSize());
		Long totalRow = baseDAO.count("select count(*) " + hql, params);
		page.setTotalRow(totalRow.intValue());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("resumes", list);
		map.put("page", page);
		return map;
	}
}

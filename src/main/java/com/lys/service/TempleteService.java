package com.lys.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.ITempleteService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Templete;
import com.lys.model.MTemplete;
import com.lys.util.Page;

/**
 * 简历模板业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class TempleteService implements ITempleteService {
	
	@Autowired
	private BaseDAO<Templete> baseDAO;

	public Templete get(Integer id) {
		return baseDAO.get(Templete.class, id);
	}

	public Serializable save(Templete o) {
		return baseDAO.save(o);
	}

	public void update(Templete o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Templete> findAll() {
		return baseDAO.find("from Templete");
	}
	/**
	 * 统计模板量
	 * @return
	 */
	public Long count() {
		return baseDAO.count("select count(*) from Templete");
	}
	/**
	 * 批量删除
	 * @param ids
	 */
	public void deletes(String ids){
		baseDAO.executeHql("delete from Templete where tpId in ("+ids+")");
	}
	/**
	 * 批量查找
	 * @param ids
	 */
	public List<Templete> finds(String ids){
		return baseDAO.find("from Templete where tpId in("+ids+")");
	}
	/**
	 * 根据关键字查找简历模板
	 * @param q
	 * @return
	 */
	public Map<String,Object> search(String q,Page page,Integer p1) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("q", "%%"+q.trim()+"%%");
		String hql = "from Templete where isOpen = 1 and tpTitle like :q";
		if (p1 != 0) {
			hql += " and type.tid=:p1";
			params.put("p1", p1);
		}
		List<Templete> list = baseDAO.find(hql, params, page.getCurrentPage(), page.getPageSize());
		Long totalRow = baseDAO.count("select count(*) " + hql, params);
		page.setTotalRow(totalRow.intValue());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("templetes", copyList(list));
		map.put("page", page);
		return map;
	}
	/**
	 * 根据用户Id查找简历模板
	 * @param userId
	 * @return
	 */
	public List<Templete> find(Integer userId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		String hql = "from Templete where userinfo.uid = :userId";
		return baseDAO.find(hql, params);
	}
	/**
	 * 查找热门模板
	 * @return
	 */
	public List<Templete> findHotTempletes() {
		String hql = "from Templete";
		return baseDAO.find(hql,1,20);
	}
	/**
	 * 查找最新模板
	 * @return
	 */
	public List<Templete> findNewTempletes() {
		String hql = "from Templete";
		return baseDAO.find(hql,1,20);
	}
	/**
	 * 根据类型查找模板
	 * @param typeId
	 * @return
	 */
	public List<Templete> findByType(Integer typeId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("typeId", typeId);
		String hql = "from Templete where type.tid = :typeId";
		return baseDAO.find(hql,params,1,20);
	}
	/**
	 * 复制list
	 * @param list
	 * @return
	 */
	public List<MTemplete> copyList(List<Templete> list) {
		List<MTemplete> mList = new ArrayList<MTemplete>();
		for (Templete t : list) {
			MTemplete m = new MTemplete();
			BeanUtils.copyProperties(t, m, new String[]{"type","userinfo","grades"});
			m.setTid(t.getType().getTid());
			m.setTname(t.getType().getTname());
			m.setUid(t.getUserinfo().getUid());
			m.setNickname(t.getUserinfo().getNickname());
			mList.add(m);
		}
		return mList;
	}
	

}

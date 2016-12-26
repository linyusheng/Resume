package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Goods;
import com.lys.util.Page;

/**
 * 商品业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class GoodsService implements IGoodsService {
	
	@Autowired
	private BaseDAO<Goods> baseDAO;

	public Goods get(Integer id) {
		return baseDAO.get(Goods.class, id);
	}

	public Serializable save(Goods o) {
		return baseDAO.save(o);
	}

	public void update(Goods o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Goods> findAll() {
		return baseDAO.find("from Goods");
	}
	/**
	 * 统计积分商品量
	 * @return
	 */
	public Long count() {
		return baseDAO.count("select count(*) from Goods");
	}
	/**
	 * 批量查找
	 * @param ids
	 * @return
	 */
	public List<Goods> finds(String ids) {
		return baseDAO.find("from Goods where gid in("+ids+")");
	}
	/**
	 * 批量删除
	 * @param ids
	 */
	public void deletes(String ids) {
		baseDAO.executeHql("delete from Goods where gid in ("+ids+")");
	}
	/**
	 * 搜索商品
	 * @param key
	 * @param page
	 * @return
	 */
	public Map<String,Object> search(String key,Integer pId,Integer tId,Page page,Integer order) {
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("gname", "%%"+key+"%%");
		String hql = "from Goods where gname like :gname and isShow = true ";
		hql += jointHQL(pId, tId);
		String sort = order == 0 ? "order by gpoint asc" : "order by gpoint desc";
		hql += sort;
		//TODO
		System.out.println(hql);
		List<Goods> list =  baseDAO.find(hql, params, page.getCurrentPage(), page.getPageSize());
		Long totalRow = baseDAO.count("select count(*) " + hql, params);
		page.setTotalRow(totalRow.intValue());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("goods", list);
		map.put("page", page);
		return map;
	}
	/**
	 * 拼接HQL
	 * @param pId
	 * @param tId
	 * @return
	 */
	public String jointHQL(Integer pId,Integer tId) {
		StringBuilder hql = new StringBuilder("");
		if (pId != null) {
			switch (pId) {
				case 1:hql.append("and gpoint between 1 and 100 ");break;
				case 2:hql.append("and gpoint between 101 and 300 ");break;
				case 3:hql.append("and gpoint between 301 and 500 ");break;
				case 4:hql.append("and gpoint between 501 and 1000 ");break;
				case 5:hql.append("and gpoint > 1000 ");break;
				default:break;
			}
		}
		if (tId != null && tId != 0) {
			hql.append("and tid = "+tId+" ");
		}
		return hql.toString();
	}
	
}

package com.lys.service;

import java.io.Serializable;
import java.util.List;

import com.lys.dao.BaseDAO;
import com.lys.entity.Jcomment;

import com.lys.face.BaseService;
import com.lys.face.IJcommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 简历日志评论业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class JcommentService implements IJcommentService {
	
	@Autowired
	private BaseDAO<Jcomment> baseDAO;

	public Jcomment get(Integer id) {
		return baseDAO.get(Jcomment.class, id);
	}

	public Serializable save(Jcomment o) {
		return baseDAO.save(o);
	}

	public void update(Jcomment o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Jcomment> findAll() {
		return baseDAO.find("from Jcomment");
	}
	/**
	 * 根据日志id查找评论
	 * @param jid
	 * @return
	 */
	public List<Object[]> find(Integer jid) {
		String sql = "select j.*,u.uId,u.nickname,u.head from jcomment as j,userinfo as u where u.uId = j.uid and jid=" + jid;
		return baseDAO.findBySql(sql);
	}
	
}

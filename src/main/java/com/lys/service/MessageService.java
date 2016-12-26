package com.lys.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.IMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Message;
import com.lys.model.Notice;

/**
 * 通知业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class MessageService implements IMessageService {
	
	@Autowired
	private BaseDAO<Message> baseDAO;

	public Message get(Integer id) {
		return baseDAO.get(Message.class, id);
	}

	public Serializable save(Message o) {
		return baseDAO.save(o);
	}

	public void update(Message o) {
		baseDAO.update(o);
	}

	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}

	public List<Message> findAll() {
		return baseDAO.find("from Message");
	}
	/**
	 * 转换list
	 * @param sourceList
	 * @return
	 */
//	public List<Notice> copyList(List<Message> sourceList) {
//		List<Notice> objectList = new ArrayList<Notice>();
//		for (Message m : sourceList) {
//			Notice n = new Notice();
//			n.setId(m.getMid());
//			n.setIsreaded(m.getIsLook());
//			n.setInfo(m.getContent());
//			n.setKind(m.getKind());
//			n.setUrl("notice");
//			n.setTime(m.getTime());
//			objectList.add(n);
//		}
//		return objectList;
//	}
	/**
	 * 查找用户所有通知
	 * @param uid
	 * @return
	 */
	public List<Message> findByUser(Integer uid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		String hql = "from Message where uid = :uid and type = 1 order by time desc";
		return baseDAO.find(hql,params);
	}
	/**
	 * 查找用户所有未读通知
	 * @param uid
	 * @return
	 */
	public List<Message> findUnRead(Integer uid) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uid", uid);
		String hql = "from Message where uid = :uid and isreaded = 0 and type = 1 order by time desc";
		return baseDAO.find(hql,params);
	}
	/**
	 * 标记为已读
	 * @param ids
	 * @return
	 */
	public int markRead(String ids) {
		return baseDAO.executeHql("update Message set isreaded = 1 where id in("+ids+")");
	}
	/**
	 * 查找所有通知
	 * @return
	 */
	public List<Message> finds() {
		String hql = "from Message where type = 1 group by time";
		return baseDAO.find(hql);
	}
	/**
	 * 查找某条通知的相关用户
	 * @return
	 */
	public List<Message> findMessageUsers(String time) {
		String hql = "select u.account,m.isreaded from Message m,Userinfo u where m.uid=u.uid and type = 1 and time = '"+time+"'";
		return baseDAO.find(hql);
	}
	/**
	 * 查找反馈
	 * @return
	 */
	public List<Message> findAdvice() {
		String hql = "select m,u.account,u.head from Message m,Userinfo u where m.uid=u.uid and type = 0 order by time desc";
		return baseDAO.find(hql);
	}
	/**
	 * 批量删除(根据时间删除)
	 * @param times
	 */
	public void deletes(String[] times) {
		for (String time : times) {
			baseDAO.executeHql("delete from Message where time = '"+time+"'");
		}
		
	}
}

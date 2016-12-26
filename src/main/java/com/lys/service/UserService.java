package com.lys.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lys.face.BaseService;
import com.lys.face.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lys.dao.BaseDAO;
import com.lys.entity.Userinfo;
import com.lys.util.Global;
import com.lys.util.MD5;
import com.lys.util.Tool;

/**
 * 用户业务处理类
 * 
 * @author 林玉生
 * 
 * @since 2015-08-01
 * 
 * @version v1.0
 *
 */
@Service
public class UserService implements IUserService {
	
	@Autowired
	private BaseDAO<Userinfo> baseDAO;
	
	public Userinfo get(Integer id) {
		return baseDAO.get(Userinfo.class, id);
	}
	public Serializable save(Userinfo o) {
		return baseDAO.save(o);
	}
	public void update(Userinfo o) {
		baseDAO.update(o);
	}
	public void delete(Integer id) {
		baseDAO.delete(get(id));
	}
	public List<Userinfo> findAll() {
		return baseDAO.find("from Userinfo");
	}
	/**
	 * 初始化用户信息
	 * @param email
	 */
	public void init(String email,String pwd,String nickname) {
		Userinfo user = new Userinfo();
		user.setUtype("普通用户");
		user.setOpenId("");
		user.setAccount(email);
		user.setPwd(pwd);
		user.setNickname(nickname);
		user.setHead(Global.DEFAULT_HEAD);
		user.setLevel(1);
		user.setExp(1);
		user.setPoint(100);
		user.setBrowseNum(0);
		user.setQuestion("");
		user.setAnswer("");
		user.setUtime(Tool.getCurrentTime());
		user.setLoginTime(Tool.getCurrentTime());
		user.setEditNum(0);
		user.setStatus(false);
		user.setLastActivateTime(Tool.getHalfHourTime());
		user.setValidateCode(MD5.string2MD5(email));
		user.setIntegrity(10);
		save(user);
	}
	/**
	 * 根据账号查找用户
	 * @param account
	 * 
	 * @return
	 */
	public Userinfo getUser(String account) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("account", account);
		String hql = "from Userinfo where account = :account";
		return baseDAO.get(hql, params);
	}
	/**
	 * 根据账号和密码查找用户
	 * @param utype
	 * @param account
	 * @param password
	 * @return
	 */
	public Userinfo getUser(String utype,String account, String password) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("utype", utype);
		params.put("account", account);
		params.put("pwd", password);
		String hql = "from Userinfo where utype = :utype and account = :account and pwd = :pwd";
		return baseDAO.get(hql, params);
	}
	/**
	 * 修改用户头像
	 * @param id
	 * @param head
	 * @return
	 */
	public boolean editHead(Integer id,String head) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("head", head);
		String hql= "update Userinfo set head = :head where uid = :id"; 
		return baseDAO.executeHql(hql,params) > 0 ? true : false;
	}
	/**
	 * 设置密码
	 * @param id
	 * @param password
	 * @return
	 */
	public boolean setPwd(Integer id,String password){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("pwd", password);
		String hql= "update Userinfo set pwd = :pwd where uid = :id"; 
		return baseDAO.executeHql(hql,params) > 0 ? true : false;
	}
	/**
	 * 设置密码
	 * @param email
	 * @param password
	 * @return
	 */
	public boolean setPwd(String email,String password){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("email", email);
		params.put("pwd", password);
		String hql= "update Userinfo set pwd = :pwd where account = :email"; 
		return baseDAO.executeHql(hql,params) > 0 ? true : false;
	}
	/**
	 * 更新简历完整度
	 * @param id
	 * @param changeValue
	 */
	public void updateIntegrity(Integer id,Integer changeValue) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("integrity", get(id).getIntegrity()+changeValue);
		String hql= "update Userinfo set integrity = :integrity where uid = :id"; 
		baseDAO.executeHql(hql,params);
	}
	/**
	 * 批量查找用户
	 * @param ids
	 * @return
	 */
	public List<Userinfo> findByIds(String ids) {
		if (ids.isEmpty()) {
			return null;
		}else {
			String hql = "select uid,nickname,head from Userinfo where id in(" + ids + ")";
			return baseDAO.find(hql);
		}
	}
	/**
	 * 查找普通用户
	 * @param ids
	 * @return
	 */
	public List<Userinfo> findUser(String type) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("utype", type);
		String hql = "from Userinfo where utype =:utype";
		return baseDAO.find(hql,params);
	}
	/**
	 * 统计用户量
	 * @return
	 */
	public Long count() {
		return baseDAO.count("select count(*) from Userinfo where utype = '普通用户'");
	}
	/**
	 * 统计月注册量
	 * @return
	 */
	public Long countMonthRegister() {
		String sql = "select count(*) from Userinfo where utype = '普通用户' and DATE_FORMAT(uTime,'%Y-%m') = DATE_FORMAT(NOW(),'%Y-%m')";
		return baseDAO.count(sql);
	}
	
	/**
	 * 统计日注册量
	 * @return
	 */
	public Long countDayRegister() {
		String sql = "select count(*) from Userinfo where utype = '普通用户' and DATE_FORMAT(uTime,'%Y-%m-%d') = DATE_FORMAT(NOW(),'%Y-%m-%d')";
		return baseDAO.count(sql);
	}
	
	
	
	
	
	
	
}

package com.lys.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import com.lys.face.*;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.lys.entity.Goods;
import com.lys.entity.Message;
import com.lys.entity.Templete;
import com.lys.entity.Userinfo;
import com.lys.model.Ajax;
import com.lys.util.Global;
import com.lys.util.MD5;
import com.lys.util.SpringUtil;
import com.lys.util.Tool;

/**
 * 管理员访问控制类(类资源访问：/admin/*)
 * @author between
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController{

	private static Logger logger = Logger.getLogger(AdminController.class);
	
	@Autowired
	private IUserService userService;
	@Autowired
	private ITempleteService templeteService;
	@Autowired
	private IMessageService messageService;
	@Autowired
	private IBaseinfoService baseinfoService;
	@Autowired
	private IHoninfoService honinfoService;
	@Autowired
	private IAbiinfoService abiinfoService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IJournalService journalService;

	@RequestMapping(method = RequestMethod.GET)
	public String get() {
		return Global.ADMIN_INDEX;
	}
	/**
	 * 在线用户管理
	 * @return
	 */
	@RequestMapping("/onlineuserManage")
	public String onlineuserManage() {
		return Global.ADMIN_MANAGE_ONLINEUSER;
	}
	/**
	 * 用户管理
	 * @return
	 */
	@RequestMapping("/userManage")
	public String userManage() {
		return Global.ADMIN_MANAGE_USER;
	}
	/**
	 * 简历管理
	 * @return
	 */
	@RequestMapping("/resumeManage")
	public String resumeManage() {
		return Global.ADMIN_MANAGE_RESUME;
	}
	/**
	 * 模板管理
	 * @return
	 */
	@RequestMapping("/templeteManage")
	public String templeteManage() {
		return Global.ADMIN_MANAGE_TEMPLETE;
	}
	/**
	 * 通知管理
	 * @return
	 */
	@RequestMapping("/noticeManage")
	public String noticeManage() {
		return Global.ADMIN_MANAGE_NOTICE;
	}
	/**
	 * 商品管理
	 * @return
	 */
	@RequestMapping("/goodsManage")
	public String goodsManage() {
		return Global.ADMIN_MANAGE_GOODS;
	}
	/**
	 * 日志管理
	 * @return
	 */
	@RequestMapping("/journalManage")
	public String journalManage() {
		return Global.ADMIN_MANAGE_JOURNAL;
	}
	/**
	 * 论坛管理
	 * @return
	 */
	@RequestMapping("/bbsManage")
	public String bbsManage() {
		return Global.ADMIN_MANAGE_BBS;
	}
	/**
	 * 系统管理
	 * @return
	 */
	@RequestMapping("/systemManage")
	public String systemManage() {
		return Global.ADMIN_MANAGE_SYSTEM;
	}
	/**
	 * 信息统计
	 * @return
	 */
	@RequestMapping("/statisticsManage")
	public String statisticsManage() {
		return Global.ADMIN_MANAGE_STATISTICS;
	}
	
	/**
	 * 登陆
	 * @param account
	 * @param password
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/login")
	public Ajax login(String account,String password,HttpSession session) {
		Ajax ajax = new Ajax();
		if(account == null || password == null){
			ajax.setState("bad");
			ajax.setException("用户名或密码为空！");
		}else{
			Userinfo user = userService.getUser("管理员",account, MD5.string2MD5(password));
			if(user != null){
				session.setAttribute("admin", user);
				session.setAttribute("lock", null);
				ajax.setState("success");
				ajax.setReturnUrl("admin");
			}else {
				ajax.setState("bad");
				ajax.setException("用户名或密码错误！");
			}
		}
		return ajax;
	}
	/**
	 * 退出登录
	 * @param session
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return Global.ADMIN_LOGIN;
	}
	/**
	 * 锁住窗口
	 * @param session
	 * @return
	 */
	@RequestMapping("/lock")
	public String lock(HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("admin");
		if (user == null) {
			return "redirect:/admin/logout";
		}
		session.setAttribute("lock", "true");
		return Global.ADMIN_LOCK;
	}
	/**
	 * 解锁窗口
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/uplock")
	public Ajax uplock(String password,HttpSession session) {
		Ajax ajax = new Ajax();
		Userinfo user = (Userinfo)session.getAttribute("admin");
		//如果管理员未登录或者session已过期
		if (user == null) {
			ajax.setState("logout");
			ajax.setReturnUrl("admin/logout");
		}else if (password == null || password.equals("")) {
			ajax.setState("fail");
			ajax.setException("密码不能为空!");
		}else if (!MD5.string2MD5(password).equals(user.getPwd())) {
			ajax.setState("fail");
			ajax.setException("密码不正确!");
		}else {
			ajax.setState("success");
			ajax.setReturnUrl("admin");
			session.setAttribute("lock", null);
		}
		return ajax;
	}
	/**
	 * 修改管理员信息
	 * @param userinfo
	 * @param request
	 * @param session
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@ResponseBody
	@RequestMapping("/editInfo")
	public String editInfo(Userinfo userinfo,MultipartHttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		Userinfo user = (Userinfo)session.getAttribute("admin");
		MultipartFile multipartFile = request.getFile("file");
		//如果文件不为空
		if (multipartFile.getSize() != 0) {
			String realPath = request.getSession().getServletContext().getRealPath("/assets/image/head/");
			File file = new File(realPath);
			if (!file.exists()) {
				file.mkdirs();
			}
			//获取文件的后缀
			String suffix = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."));
	        // 使用UUID生成文件名称
	        String fileName = UUID.randomUUID().toString() + suffix;
	        //完整路径
	        realPath += File.separator + fileName;
	        file = new File(realPath);
			multipartFile.transferTo(file);
			//另存一份再工作空间下
			FileUtils.copyFile(file, new File("E:/MyEclipseWorkspaces/Resume/WebRoot/assets/image/head/"+fileName));
			//删除原来的头像
			String head = user.getHead();
			if (!head.equals(Global.DEFAULT_HEAD)) {
				Tool.deleteFile(System.getProperty("web.root") + head.replace("/", "\\"));
			}
			head = "assets/image/head/"+fileName;
			user.setHead(head);
		}
		if(userinfo.getAccount() != null && userinfo.getAccount().equals(user.getAccount())){
			user.setNickname(userinfo.getNickname());
			userService.update(user);
			session.setAttribute("admin", user);
		}else {
			return "fail";
		}
		return "success";
	}
	/**
	 * 修改管理员密码
	 * @param oldPsd
	 * @param newPsd
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/modifyPwd")
	public Ajax modifyPwd(String oldPsd,String newPsd,HttpSession session){
		Ajax ajax = new Ajax();
		Userinfo user = (Userinfo)session.getAttribute("admin");
		if(user == null){
			ajax.setState("fail");
			ajax.setException("未登录，请重新登陆！");
		}else{
			if (oldPsd == null || newPsd == null) {
				ajax.setState("fail");
				ajax.setException("密码不能为空");
			}else {
				if (!user.getPwd().equals(MD5.string2MD5(oldPsd))) {
					ajax.setState("fail");
					ajax.setException("旧密码不正确");
				}else {
					user.setPwd(MD5.string2MD5(newPsd));
					userService.update(user);
					ajax.setState("success");
				}
			}
		}
		return ajax;
	}
	/**
	 * 首页数据统计
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/count")
	public Map<String, Object> count() {
		Map<String, Object> map = new HashMap<String, Object>();
		//用户量
		map.put("userNum", userService.count());
		//当前在线用户量
		map.put("onlineUserNum", Global.ONLINEUSER.size());
		//月注册量
		map.put("monthRegisterNum", userService.countMonthRegister());
		//日注册量
		map.put("dayRegisterNum", userService.countDayRegister());
		//简历量
		map.put("resumeNum", baseinfoService.count());
		//模板量
		map.put("templeteNum", templeteService.count());
		//商品量
		map.put("goodsNum", goodsService.count());
		//日志量
		map.put("journalNum", journalService.count());
		return map;
	}
	/**
	 * 查找在线用户
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/onlineuser")
	public Map<String, Object> onlineUser() {
		Set<Userinfo> users = new HashSet<Userinfo>();
		for (HttpSession session : Global.ONLINEUSER) {
			Userinfo user = (Userinfo)session.getAttribute("user");
			users.add(user);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data",users);
		return map;
	}
	/**
	 * 注销在线用户(单注销，多注销)
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/logoutUser")
	public Ajax logoutUser(String ids) {
		Ajax ajax = new Ajax();
		if (ids == null) {
			ajax.setState("fail");
			ajax.setException("参数错误！");
		}else {
			String[] uids = ids.split(",");
			for (String uid : uids) {
				Iterator<HttpSession> iterator = Global.ONLINEUSER.iterator();
				while (iterator.hasNext()) {
					HttpSession session = (HttpSession) iterator.next();
					Userinfo user = (Userinfo)session.getAttribute("user");
					if (user.getUid() == Integer.parseInt(uid)) {
						session.invalidate();
						break;
					}
				}
			}
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 向用户发送通知(单发送，多发送)
	 * @param ids
	 * @param content
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/sendNotice")
	public Ajax sendNotice(String ids,String title,String content) {
		Ajax ajax = new Ajax();
		if (ids == null || content == null) {
			ajax.setState("fail");
			ajax.setException("参数错误！");
		}else {
			String[] uids = ids.split(",");
			Timestamp now = Tool.getCurrentTime();
			for (String uid : uids) {
				Message message = new Message();
				message.setUid(Integer.valueOf(uid));
				message.setType(1);
				message.setInfo(title);
				message.setDetail(content);
				short s = 0;
				message.setIsreaded(s);
				message.setTime(now);
				message.setKind(1);
				message.setUrl("notice");
				messageService.save(message);
			}
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 查找所有普通用户
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findUser")
	public Map<String, Object> findUser() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", userService.findUser("普通用户"));
		return map;
	}
	/**
	 * 管理员修改用户密码
	 * @param uid
	 * @param newPwd
	 * @param adminPwd
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/modifyUserPwd")
	public Ajax modifyUserPwd(Integer uid,String newPwd,String adminPwd,HttpSession session) {
		System.out.println(uid+"/"+newPwd+"/"+adminPwd);
		Ajax ajax = new Ajax();
		if (newPwd == null || newPwd.equals("") || adminPwd == null || adminPwd.equals("")) {
			ajax.setState("fail");
			ajax.setException("参数错误！");
		}else {
			Userinfo admin = (Userinfo)session.getAttribute("admin");
			if (!admin.getPwd().equals(MD5.string2MD5(adminPwd))) {
				ajax.setState("fail");
				ajax.setException("管理员密码错误！");
			}else {
				boolean r = userService.setPwd(uid, MD5.string2MD5(newPwd));
				if (r) {
					ajax.setState("success");
				}else {
					ajax.setState("fail");
					ajax.setException("修改出错，请重新操作！");
				}
			}
		}
		return ajax;
	}
	/**
	 * 管理员添加用户
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addUser")
	public Ajax addUser(Userinfo user) {
		Ajax ajax = new Ajax();
		if (userService.getUser(user.getAccount()) != null) {
			ajax.setState("fail");
			ajax.setException("该账号已存在！");
		}else {
			userService.init(user.getAccount(), MD5.string2MD5(user.getPwd()), user.getNickname());
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 管理员激活用户
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/activeUser")
	public Ajax activeUser(Integer uid) {
		Ajax ajax = new Ajax();
		if (uid == null) {
			ajax.setState("fail");
			ajax.setException("参数错误！");
		}else {
			Userinfo user = userService.get(uid);
			user.setStatus(true);
			userService.update(user);
			//初始化简历基本信息
			baseinfoService.init(user);
			honinfoService.init(user);
			abiinfoService.init(user);
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 查找所有简历模板
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findTemplete")
	public Map<String, Object> findTemplete() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Templete> list = templeteService.findAll();
		map.put("data", templeteService.copyList(list));
		return map;
	}
	/**
	 * 管理员修改模板信息
	 * @param t
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/modifyTemplete")
	public Ajax modifyTemplete(Templete t) {
		Ajax ajax = new Ajax();
		if (t == null || t.getTpId() == null) {
			ajax.setState("fail");
			ajax.setException("参数不能为空！");
		}else {
			Templete templete = templeteService.get(t.getTpId());
			templete.setType(t.getType());
			templete.setTpTitle(t.getTpTitle());
			templete.setIsOpen(t.getIsOpen());
			templete.setDownloadNum(t.getDownloadNum());
			templete.setClickNum(t.getClickNum());
			templete.setCollectNum(t.getCollectNum());
			templeteService.update(templete);
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 管理员删除模板(单删除，批量删除)
	 * @param tpId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteTemplete")
	public Ajax deleteTemplete(String ids) {
		Ajax ajax = new Ajax();
		if (ids == null) {
			ajax.setState("fail");
			ajax.setException("参数不能为空！");
		}else {
			List<Templete> list = templeteService.finds(ids);
			templeteService.deletes(ids);
			for (Templete t : list) {
				String file = System.getProperty("web.root") + t.getTpUrl();
				Tool.deleteFile(file);
			}
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 查找已发送的通知
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findMessage")
	public Map<String, Object> findMessage() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Message> list = messageService.finds();
		map.put("data", list);
		return map;
	}
	/**
	 * 查找某条通知的相关用户
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findMessageUsers")
	public List<Message> findMessageUsers(String time) {
		return messageService.findMessageUsers(time);
	}
	
	/**
	 * 管理员删除消息(单删除，批量删除)
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteMessage")
	public Ajax deleteMessage(String times) {
		System.out.println(times);
		Ajax ajax = new Ajax();
		if (times == null) {
			ajax.setState("fail");
			ajax.setException("参数不能为空！");
		}else {
			String[] arrayTimes = times.split(",");
			messageService.deletes(arrayTimes);
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 查找反馈
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findAdvice")
	public List<Message> findAdvice() {
		return messageService.findAdvice();
	}
	/**
	 * 查找所有商品
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findGoods")
	public Map<String, Object> findGoods() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", goodsService.findAll());
		return map;
	}
	/**
	 * 上下架商品
	 * @param goods
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/goodsOperator")
	public Ajax goodsOperator(Goods goods) {
		System.out.println(JSON.toJSONString(goods));
		Ajax ajax = new Ajax();
		if(goods == null){
			ajax.setState("fail");
			ajax.setException("参数错误！");
		}else{
			Goods g = goodsService.get(goods.getGid());
			g.setIsShow(goods.getIsShow());
			goodsService.update(g);
			ajax.setState("success");
		}
		return ajax;
	}
	/**
	 * 添加商品
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@ResponseBody
	@RequestMapping("/mergeGoods")
	public Ajax addGoods(Goods goods,MultipartHttpServletRequest request) {
		Ajax ajax = new Ajax();
		//如果参数对象是否为空
		if(goods == null){
			ajax.setState("fail");
			ajax.setException("参数不能为空！");
		}else {
			//添加,修改操作
			if(goods.getGid() == null){
				String picture = SpringUtil.upload(request, "/assets/image/goods/");
				goods.setGpicture(picture);
				goods.setGtime(Tool.getCurrentTime());
				goodsService.save(goods);
				ajax.setState("success");
			}else{
				Goods g = goodsService.get(goods.getGid());
				if(request.getFile("file").getSize() != 0){
					String picture = SpringUtil.upload(request, "/assets/image/goods/");
					//删除原来的商品图片
					Tool.deleteFile(System.getProperty("web.root") + g.getGpicture().replace("/", "\\"));
					g.setGpicture(picture);
				}
				g.setGname(goods.getGname());
				g.setTid(goods.getTid());
				g.setIsShow(goods.getIsShow());
				g.setGnum(goods.getGnum());
				g.setGpoint(goods.getGpoint());
				goodsService.update(g);
				ajax.setState("success");
			}
		}
		return ajax;
	}
	/**
	 * 删除商品
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteGoods")
	public Ajax deleteGoods(String ids) {
		Ajax ajax = new Ajax();
		if (ids == null) {
			ajax.setState("fail");
			ajax.setException("参数不能为空！");
		}else {
			List<Goods> list = goodsService.finds(ids);
			goodsService.deletes(ids);
			for (Goods g : list) {
				String file = System.getProperty("web.root") + g.getGpicture().replace("/", "\\");
				Tool.deleteFile(file);
			}
			ajax.setState("success");
		}
		return ajax;
	}
	
}

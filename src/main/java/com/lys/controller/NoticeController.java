package com.lys.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import com.lys.face.IMessageService;
import com.lys.util.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lys.entity.Message;
import com.lys.entity.Userinfo;

/**
 * 消息访问控制类(类资源访问：/notice/*)
 * @author between
 */
@Controller
@RequestMapping("/notice")
public class NoticeController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private IMessageService messageService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(HttpSession session,Model model){
		Userinfo user = (Userinfo)session.getAttribute("user");
		if(user == null){
			model.addAttribute("alertList", "[]") ;
		}else{
			List<Message> list = messageService.findByUser(user.getUid());
			String alertList = JSON.toJSONString(list);
			model.addAttribute("alertList", alertList) ;
		}
		return Global.PERSONAL_NOTICE;
	}
	
	/**
	 * 查找用户未读通知
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findUnRead")
	public List<Message> findUnRead(HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		return messageService.findUnRead(user.getUid());
	}
	/**
	 * 查找用户所有通知
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findByUser")
	public List<Message> findByUser(HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		return messageService.findByUser(user.getUid());
	}
	/**
	 * 标记通知为已读状态
	 * @param view
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/markRead")
	public Map<String, Object> markRead(String view) {
		System.out.println(view);
		Map<String, Object> map = new HashMap<String, Object>();
		if(view == null || view.equals("")){
			map.put("error","参数错误！");
		}else{
			messageService.markRead(view);
			map.put("error",false);
		}
		return map;
	}

}

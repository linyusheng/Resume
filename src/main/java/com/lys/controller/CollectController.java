package com.lys.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import com.lys.face.ICollectService;
import com.lys.face.ITempleteService;
import com.lys.util.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lys.entity.Collect;
import com.lys.entity.Templete;
import com.lys.entity.Userinfo;
import com.lys.util.Tool;

/**
 * 收藏访问控制类
 * @author between
 */
@Controller
@RequestMapping("/collect")
public class CollectController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(CollectController.class);
	
	@Autowired
	private ICollectService collectService;
	@Autowired
	private ITempleteService templeteService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(HttpSession session,Model model){
		Userinfo user = (Userinfo)session.getAttribute("user");
		if(user == null){
			model.addAttribute("saveList", "[]") ;
		}else{
			List<Collect> list = collectService.findByUser(user.getUid());
			String saveList = JSON.toJSONString(list);
			model.addAttribute("saveList", saveList) ;
		}
		return Global.PERSONAL_COLLECT;
	}
	
	/**
	 * 添加或取消收藏
	 * @param tid
	 * @param kind
	 * @param s
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/merge")
	public String merge(Integer tid,String kind,String s,HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		if(s.equals("yes")){
			//取消收藏
			collectService.delete(user.getUid(),kind,tid);
		}else{
			//添加收藏
			Collect collect = new Collect();
			collect.setUid(user.getUid());
			collect.setTid(tid);
			collect.setKind(kind);
			collect.setTime(Tool.getCurrentTime());
			if(kind.equals("mb")){
				Templete t = templeteService.get(tid);
				collect.setTitle(t.getTpTitle());
				collect.setUrl(t.getTpUrl());
			}
			collectService.save(collect);
		}
		return "success";
	}
	/**
	 * 查找用户某种类型的收藏
	 * @param kind
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findByKind")
	public List<Collect> findByKind(String kind,HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		return collectService.findByUser(user.getUid(), kind);
	}
	/**
	 * 根据收藏ID取消收藏
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/cancel")
	public List<Collect> cancel(Integer id,HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		collectService.delete(id);
		return collectService.findByUser(user.getUid());
	}
}

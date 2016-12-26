package com.lys.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lys.face.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lys.entity.Baseinfo;
import com.lys.entity.Cominfo;
import com.lys.entity.Eduinfo;
import com.lys.entity.Honinfo;
import com.lys.entity.Othinfo;
import com.lys.entity.Stuinfo;
import com.lys.entity.Userinfo;
import com.lys.entity.Workinfo;
import com.lys.model.Ajax;
import com.lys.model.MAbiinfo;
import com.lys.util.Global;
import com.lys.util.ITextUtil;
import com.lys.util.Page;

/**
 * 简历访问控制类(类资源访问：/resume/*)
 * @author between
 */
@Controller
@RequestMapping("/resume")
public class ResumeController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(ResumeController.class);

	@Autowired
	private IUserService userService;
	@Autowired
	private IBaseinfoService baseinfoService;
	@Autowired
	private IEduinfoService eduinfoService;
	@Autowired
	private IStuinfoService stuinfoService;
	@Autowired
	private IWorkinfoService workinfoService;
	@Autowired
	private ICominfoService cominfoService;
	@Autowired
	private IAbiinfoService abiinfoService;
	@Autowired
	private IHoninfoService honinfoService;
	@Autowired
	private IOthinfoService othinfoService;
	/**
	 * 获取用户简历信息
	 * @return
	 */
	@RequestMapping("/get")
	public String get(Model model,HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		if (user == null) {
			return "resume/wdjl";
		}
		Integer id = user.getUid();
		String baseinfo = JSON.toJSONString(baseinfoService.findByUser(id));
		String eduinfo = JSON.toJSONString(eduinfoService.findByUser(id));
		String stuinfo = JSON.toJSONString(stuinfoService.findByUser(id));
		String workinfo = JSON.toJSONString(workinfoService.findByUser(id));
		String cominfo = JSON.toJSONString(cominfoService.findByUser(id));
		String abiinfo = JSON.toJSONString(abiinfoService.findByUser(id));
		String honinfo = JSON.toJSONString(honinfoService.findByUser(id));
		String othinfo = JSON.toJSONString(othinfoService.findByUser(id));
		model.addAttribute("baseinfo", baseinfo);
		model.addAttribute("eduinfo",eduinfo);
		model.addAttribute("stuinfo",stuinfo);
		model.addAttribute("workinfo",workinfo);
		model.addAttribute("cominfo",cominfo);
		model.addAttribute("abiinfo",abiinfo);
		model.addAttribute("honinfo",honinfo);
		model.addAttribute("othinfo",othinfo);
		return "resume/wdjl";
	}
	/**
	 * 更新基本信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateBaseinfo")
	public Map<String, Integer> updateBaseinfo(@RequestBody String data) {
		Baseinfo baseinfo = JSON.parseObject(data, Baseinfo.class);
		baseinfoService.update(baseinfo);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("completion", userService.get(baseinfo.getUid()).getIntegrity());
		return map;
	}
	/**
	 * 更新教育背景
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateEduinfo")
	public Map<String, Integer> updateEduinfo(@RequestBody String data,HttpSession session){
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer uid = user.getUid();
		Integer integrity = user.getIntegrity();
		Eduinfo eduinfo = JSON.parseObject(data, Eduinfo.class);
		eduinfo.setUid(uid);
		if (eduinfo.getId() != null) {
			eduinfoService.update(eduinfo);
			map.put("new_id", 0);
		}else {
			Integer s = (Integer)eduinfoService.save(eduinfo);
			//更新简历完整度
			if(eduinfoService.findByUser(uid).size() == 1){
				integrity += 10;
				user.setIntegrity(integrity);
				userService.update(user);
				session.setAttribute("user", user);
			}
			map.put("new_id", s);
		}
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 删除教育背景
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteEduinfo")
	public Map<String, Integer> deleteEduinfo(@RequestBody String data,HttpSession session) {
		JSONObject object = JSON.parseObject(data);
		Integer id = (Integer)object.get("id");
		Integer uid = eduinfoService.get(id).getUid();
		Userinfo user = userService.get(uid);
		Integer integrity = user.getIntegrity();
		eduinfoService.delete(id);
		//更新简历完整度
		if(eduinfoService.findByUser(uid).size() == 0){
			integrity -= 10;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 更新学生工作信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateStuinfo")
	public Map<String, Integer> updateStuinfo(@RequestBody String data,HttpSession session){
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer uid = user.getUid();
		Integer integrity = user.getIntegrity();
		Stuinfo stuinfo = JSON.parseObject(data, Stuinfo.class);
		stuinfo.setUid(uid);
		if (stuinfo.getId() != null) {
			stuinfoService.update(stuinfo);
			map.put("new_id", 0);
		}else {
			Integer s = (Integer)stuinfoService.save(stuinfo);
			//更新简历完整度
			if(stuinfoService.findByUser(uid).size() == 1){
				integrity += 10;
				user.setIntegrity(integrity);
				userService.update(user);
				session.setAttribute("user", user);
			}
			map.put("new_id", s);
		}
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 删除学生工作信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteStuinfo")
	public Map<String, Integer> deleteStuinfo(@RequestBody String data,HttpSession session) {
		JSONObject object = JSON.parseObject(data);
		Integer id = (Integer)object.get("id");
		Integer uid = stuinfoService.get(id).getUid();
		Userinfo user = userService.get(uid);
		Integer integrity = user.getIntegrity();
		stuinfoService.delete(id);
		//更新简历完整度
		if(stuinfoService.findByUser(uid).size() == 0){
			integrity -= 10;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 更新实习工作信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateWorkinfo")
	public Map<String, Integer> updateWorkinfo(@RequestBody String data,HttpSession session){
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer uid = user.getUid();
		Integer integrity = user.getIntegrity();
		Workinfo workinfo = JSON.parseObject(data, Workinfo.class);
		workinfo.setUid(uid);
		if (workinfo.getId() != null) {
			workinfoService.update(workinfo);
			map.put("new_id", 0);
		}else {
			Integer s = (Integer)workinfoService.save(workinfo);
			//更新简历完整度
			if(workinfoService.findByUser(uid).size() == 1){
				integrity += 10;
				user.setIntegrity(integrity);
				userService.update(user);
				session.setAttribute("user", user);
			}
			map.put("new_id", s);
		}
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 删除实习工作信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteWorkinfo")
	public Map<String, Integer> deleteWorkinfo(@RequestBody String data,HttpSession session) {
		JSONObject object = JSON.parseObject(data);
		Integer id = (Integer)object.get("id");
		Integer uid = workinfoService.get(id).getUid();
		Userinfo user = userService.get(uid);
		Integer integrity = user.getIntegrity();
		workinfoService.delete(id);
		//更新简历完整度
		if(workinfoService.findByUser(uid).size() == 0){
			integrity -= 10;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 更新比赛项目信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateCominfo")
	public Map<String, Integer> updateCominfo(@RequestBody String data,HttpSession session) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer uid = user.getUid();
		Integer integrity = user.getIntegrity();
		Cominfo cominfo = JSON.parseObject(data, Cominfo.class);
		cominfo.setUid(uid);
		if (cominfo.getId() != null) {
			cominfoService.update(cominfo);
			map.put("new_id", 0);
		}else {
			Integer s = (Integer)cominfoService.save(cominfo);
			//更新简历完整度
			if(cominfoService.findByUser(uid).size() == 1){
				integrity += 10;
				user.setIntegrity(integrity);
				userService.update(user);
				session.setAttribute("user", user);
			}
			map.put("new_id", s);
		}
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 删除比赛项目信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteCominfo")
	public Map<String, Integer> deleteCominfo(@RequestBody String data,HttpSession session) {
		JSONObject object = JSON.parseObject(data);
		Integer id = (Integer)object.get("id");
		Integer uid = cominfoService.get(id).getUid();
		Userinfo user = userService.get(uid);
		Integer integrity = user.getIntegrity();
		cominfoService.delete(id);
		//更新简历完整度
		if(cominfoService.findByUser(uid).size() == 0){
			integrity -= 10;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 更新个人素质
	 * @param data
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateAbility")
	public Map<String, Integer> updateAbility(String field,@RequestBody String data,HttpSession session) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer userId = user.getUid();
		Integer integrity = user.getIntegrity();
		String oldData = abiinfoService.findByUserId(field,userId);
		abiinfoService.update(field,userId,data);
		//更新简历完整度，如果有不为空的字段，为简历完整度+3,否则简历完整度-3
		if(!data.equals("[]") && oldData.equals("[]")){
			integrity += 3;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);	
		}
		if (data.equals("[]") && !oldData.equals("[]")) {
			integrity -= 3;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);	
		}
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 更新荣誉奖励信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateHoninfo")
	public Map<String, Integer> updateHoninfo(@RequestBody String data,HttpSession session) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer uid = user.getUid();
		Integer integrity = user.getIntegrity();
		Honinfo honinfo = JSON.parseObject(data, Honinfo.class);
		Honinfo oldHoninfo = honinfoService.findByUser(uid);
		if (!honinfo.getWorldPrize().trim().equals("") && oldHoninfo.getWorldPrize().trim().equals("")) {
			integrity += 2;
		}else if(honinfo.getWorldPrize().trim().equals("") && !oldHoninfo.getWorldPrize().trim().equals("")) {
			integrity -= 2;
		}
		if (!honinfo.getNationalPrize().trim().equals("") && oldHoninfo.getNationalPrize().trim().equals("")) {
			integrity += 2;
		}else if(honinfo.getNationalPrize().trim().equals("") && !oldHoninfo.getNationalPrize().trim().equals("")) {
			integrity -= 2;
		}
		if (!honinfo.getProvincePrize().trim().equals("") && oldHoninfo.getProvincePrize().trim().equals("")) {
			integrity += 2;
		}else if(honinfo.getProvincePrize().trim().equals("") && !oldHoninfo.getProvincePrize().trim().equals("")) {
			integrity -= 2;
		}
		if (!honinfo.getCollegePrize().trim().equals("") && oldHoninfo.getCollegePrize().trim().equals("")) {
			integrity += 2;
		}else if(honinfo.getCollegePrize().trim().equals("") && !oldHoninfo.getCollegePrize().trim().equals("")) {
			integrity -= 2;
		}
		if (!honinfo.getOtherPrize().trim().equals("") && oldHoninfo.getOtherPrize().trim().equals("")) {
			integrity += 2;
		}else if(honinfo.getOtherPrize().trim().equals("") && !oldHoninfo.getOtherPrize().trim().equals("")) {
			integrity -= 2;
		}
		honinfoService.update(honinfo);
		//更新简历完整度
		user.setIntegrity(integrity);
		userService.update(user);
		session.setAttribute("user", user);
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 更新其它信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateOthinfo")
	public Map<String, Integer> updateOthinfo(@RequestBody String data,HttpSession session) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		Userinfo user =  (Userinfo)session.getAttribute("user");
		Integer uid = user.getUid();
		Integer integrity = user.getIntegrity();
		Othinfo othinfo = JSON.parseObject(data, Othinfo.class);
		othinfo.setUid(user.getUid());
		if (othinfo.getId() != null) {
			othinfoService.update(othinfo);
			map.put("new_id", 0);
		}else {
			Integer s = (Integer)othinfoService.save(othinfo);
			map.put("new_id", s);
			//更新简历完整度
			if(othinfoService.findByUser(uid).size() == 1){
				integrity += 7;
				user.setIntegrity(integrity);
				userService.update(user);
				session.setAttribute("user", user);
			}
		}
		map.put("completion", integrity);
		return map;
	}
	/**
	 * 删除其它信息
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteOthinfo")
	public Map<String, Integer> deleteOthinfo(@RequestBody String data,HttpSession session) {
		JSONObject object = JSON.parseObject(data);
		Integer id = (Integer)object.get("id");
		Integer uid = othinfoService.get(id).getUid();
		Userinfo user = userService.get(uid);
		Integer integrity = user.getIntegrity();
		othinfoService.delete(id);
		//更新简历完整度
		if(othinfoService.findByUser(uid).size() == 0){
			integrity -= 7;
			user.setIntegrity(integrity);
			userService.update(user);
			session.setAttribute("user", user);
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("completion", integrity);
		return map;
	}

	/**
	 * 预览简历
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/preview")
	public String preview(Integer id,Model model,HttpSession session) {
		String url = "resume/resume"; 
		if (id == null) {
			Userinfo user = (Userinfo)session.getAttribute("user");
			if (user == null) {
				return "resume/preview";
			}
			id = user.getUid();
			url = "resume/preview";
		}
		Baseinfo baseinfo = baseinfoService.findByUser(id);
		List<Eduinfo> eduinfo = eduinfoService.findByUser(id);
		List<Stuinfo> stuinfo = stuinfoService.findByUser(id);
		List<Workinfo> workinfo = workinfoService.findByUser(id);
		List<Cominfo> cominfo = cominfoService.findByUser(id);
		MAbiinfo abiinfo = abiinfoService.findByUser(id);
		Honinfo honinfo = honinfoService.findByUser(id);
		List<Othinfo> othinfo = othinfoService.findByUser(id);
		model.addAttribute("baseinfo",baseinfo);
		model.addAttribute("eduinfo",eduinfo);
		model.addAttribute("stuinfo",stuinfo);
		model.addAttribute("workinfo",workinfo);
		model.addAttribute("cominfo",cominfo);
		model.addAttribute("abiinfo",abiinfo);
		model.addAttribute("honinfo",honinfo);
		model.addAttribute("othinfo",othinfo);
		return url;
	}
	/**
	 * 导出简历(pdf格式)
	 * @param request
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/create")
	public void create(String id,HttpServletResponse response) throws IOException {
		String path = System.getProperty("web.root");
		path += "assets"+File.separator+"resume"+File.separator+id+".pdf";
		ITextUtil.HtmlToPdf("http://lys/Resume/resume/preview?id="+id,path);
		File file=new File(path);
		response.setHeader("Content-Disposition", "attachment;fileName="+id+".pdf");
        InputStream in=new FileInputStream(file);  
        OutputStream os=response.getOutputStream();  
        byte[] b=new byte[1024];  
        int i = -1;  
        while((i = in.read(b))>0){  
            os.write(b,0,i);  
        }
        os.close();
        in.close();
       
	}
	/**
	 * 个人设置
	 * @return
	 */
	@RequestMapping("/private")
	public String personalInfo(Model model,HttpSession session) {
		String url = "resume/private";
		Userinfo user = (Userinfo)session.getAttribute("user");
		if (user == null) {
			return url;
		}
		Integer id = user.getUid();
		Baseinfo baseinfo = baseinfoService.findByUser(id);
		model.addAttribute("personalInfo", JSON.toJSON(baseinfo));
		return url;
	}
	/**
	 * 修改工作意向
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/modifyPrivate")
	public Ajax modifyPrivate(@RequestBody String data) {
		Ajax ajax = new Ajax();
		JSONObject object = JSON.parseObject(data);
		Integer uid = (Integer)object.get("uid");
		String trade = format(object.getJSONArray("trade"));
		String position = format(object.getJSONArray("position"));
		String city = format(object.getJSONArray("city"));
		
		if (uid == null || trade == null || position == null || city == null) {
			ajax.setState("Bad");
			ajax.setException("数据不能为空");
		}else {
			Baseinfo baseinfo = baseinfoService.get(uid);
			baseinfo.setTrade(trade);
			baseinfo.setPosition(position);
			baseinfo.setCity(city);
			baseinfoService.save(baseinfo);
			ajax.setState("Success");
		}
		return ajax;
	}
	/**
	 * 格式化json数组："aa;bb;cc"
	 * @param a
	 * @return
	 */
	public String format(JSONArray a) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < a.size(); i++) {
			if (i == 0) {
				sb.append(a.get(i).toString());
			}else{
				sb.append(";");
				sb.append(a.get(i).toString());
			}
		}
		return sb.toString();
	}
	/**
	 * 搜索简历
	 * @param key
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/search")
	public Map<String,Object> search(String key,Integer positionId,Integer educationId,Integer currentPage,Integer pageSize) {
		Page page = new Page(currentPage,pageSize);
		return baseinfoService.search(key,positionId,educationId,page);
	}
	/**
	 * 浏览简历
	 * @param id
	 * @return
	 */
	@RequestMapping("/look")
	public String look(Integer id,Model model) {
		if(id == null){
			return Global.ERROR_404;
		}else{
			Baseinfo baseinfo = baseinfoService.findByUser(id);
			List<Eduinfo> eduinfo = eduinfoService.findByUser(id);
			List<Stuinfo> stuinfo = stuinfoService.findByUser(id);
			List<Workinfo> workinfo = workinfoService.findByUser(id);
			List<Cominfo> cominfo = cominfoService.findByUser(id);
			MAbiinfo abiinfo = abiinfoService.findByUser(id);
			Honinfo honinfo = honinfoService.findByUser(id);
			List<Othinfo> othinfo = othinfoService.findByUser(id);
			model.addAttribute("baseinfo",baseinfo);
			model.addAttribute("eduinfo",eduinfo);
			model.addAttribute("stuinfo",stuinfo);
			model.addAttribute("workinfo",workinfo);
			model.addAttribute("cominfo",cominfo);
			model.addAttribute("abiinfo",abiinfo);
			model.addAttribute("honinfo",honinfo);
			model.addAttribute("othinfo",othinfo);
			model.addAttribute("b",JSON.toJSONString(baseinfo));
			return Global.RESUME_DETAIL;
		}
	}
	/**
	 * 更新简历收藏
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateCollect")
	public String updateCollect(Integer id,String collectNum) {
		Baseinfo baseinfo = baseinfoService.get(id);
		baseinfo.setCollectNum(collectNum);
		baseinfoService.update(baseinfo);
		return "success";
	}
	
}

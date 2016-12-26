package com.lys.controller;

import java.util.List;

import com.lys.face.IGuideService;
import com.lys.util.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lys.entity.Guide;
import com.lys.util.Tool;

/**
 * 技巧指导访问控制类
 * @author between
 */
@Controller
@RequestMapping("/guide")
public class GuideController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(GuideController.class);
	
	@Autowired
	private IGuideService guideService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(){
		return Global.GUIDE_INDEX;
	}
	
	/**
	 * 获取技巧指导内容
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/get")
	public List<Guide> findAll() {
		return guideService.findAll();
	}
	/**
	 * 添加技巧指导项
	 */
	@RequestMapping("/add")
	public void add() {
		for (int i = 1; i < 17; i++) {
			Guide guide = new Guide();
			guide.setUrl("assets/image/guide/"+i+".jpg");
			guide.setIsShow((short)1);
			guide.setTime(Tool.getCurrentTime());
			guideService.save(guide);
		}
		
	}

}

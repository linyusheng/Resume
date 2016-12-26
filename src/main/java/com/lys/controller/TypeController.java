package com.lys.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lys.face.ITypeService;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.lys.entity.Type;
import com.lys.util.Global;

/**
 * @author between
 */
@Controller
@RequestMapping("/type")
public class TypeController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(TypeController.class);
	
	@Autowired
	private ITypeService typeService;
	
	/**
	 * 静态化模板类型为json文件
	 * @throws IOException 
	 */
	@RequestMapping("/static")
	public void staticType(HttpServletResponse response) throws IOException {
		List<Type> list = typeService.findAll();
		String type = JSON.toJSONString(list);
		//设置文件存放路径
		String path = System.getProperty("web.root") + "assets" + File.separator + "json" + File.separator + "type.json";
		FileOutputStream fos = new FileOutputStream(path);
		OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
		PrintWriter o = new PrintWriter(osw);
		o.println(type);
		o.close();
		//复制该json文件到工作空间
		File destFile = new File(Global.WORKSPACE_TEMPLETE_TYPE_URL);
		FileUtils.copyFile(new File(path), destFile);
	}

}

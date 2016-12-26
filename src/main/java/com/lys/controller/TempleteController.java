package com.lys.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lys.face.ITempleteService;
import com.lys.face.ITypeService;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lys.entity.Templete;
import com.lys.entity.Type;
import com.lys.entity.Userinfo;
import com.lys.model.MTemplete;
import com.lys.util.Global;
import com.lys.util.Page;
import com.lys.util.Tool;

/**
 * 简历模板访问控制类(类资源访问：/templete/*)
 * @author between
 */
@Controller
@RequestMapping("/templete")
public class TempleteController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(TempleteController.class);
	
	@Autowired
	private ITypeService typeService;
	
	@Autowired
	private ITempleteService templeteService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(){
		return Global.TEMPLETE_INDEX;
	}
	
	/**
	 * 上传简历模板
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@RequestMapping("/upload")
	public String upload(String title,Integer tid,Integer isOpen,HttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile multipartFile = multipartRequest.getFile("file");
		String realPath = request.getSession().getServletContext().getRealPath("/assets/templete/");
		File file = new File(realPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		//获取文件的后缀
		String suffix = multipartFile.getOriginalFilename().substring(
				multipartFile.getOriginalFilename().lastIndexOf("."));
        // 使用UUID生成文件名称
        String fileName = UUID.randomUUID().toString() + suffix;
        //完整路径
        realPath += File.separator + fileName;
        file = new File(realPath);
		multipartFile.transferTo(file);
		//另存一份再工作空间下
		FileUtils.copyFile(file, new File("E:/MyEclipseWorkspaces/Resume/WebRoot/assets/templete/"+fileName));
		Templete templete = new Templete();
		Type type = new Type();
		type.setTid(tid);
		Userinfo user = (Userinfo)session.getAttribute("user");
		templete.setUserinfo(user);
		templete.setType(type);
		templete.setTpTitle(title);
		templete.setIsOpen(isOpen == 1 ? true : false);
		templete.setTpSize(multipartFile.getSize());
		templete.setTpUrl("assets/templete/"+fileName);
		templete.setTpTime(Tool.getCurrentTime());		
		templete.setClickNum(0);
		templete.setCollectNum(0);
		templete.setDownloadNum(0);
		templeteService.save(templete);
		return "redirect:/templete/index";
	}
	/**
	 * 下载模板
	 * @param id
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping("/download")
	public void download(Integer id,HttpServletResponse response) throws IOException {
		Templete templete = templeteService.get(id);
		String pathname = System.getProperty("web.root") + templete.getTpUrl();
		//拼接新的文件名：标题+文件后缀名
		String filename = templete.getTpTitle() + pathname.substring(pathname.lastIndexOf("."));
		//解决中文无法显示问题
		filename = new String(filename.getBytes(),"ISO8859-1");
		response.setContentType("text/octet-stream");
		response.setHeader("Content-Disposition", "attachment;fileName="+filename);
		InputStream in = new FileInputStream(pathname);
		OutputStream os = response.getOutputStream();
		byte[] b = new byte[1024];
		int i = -1;
		while((i = in.read(b)) != -1){
			os.write(b, 0, i);
		}
		os.close();
		in.close();
	}
	/**
	 * 根据条件查找简历模板
	 * @param key
	 */
	@ResponseBody
	@RequestMapping("/find")
	public List<MTemplete> find(String key) {
		List<Templete> list = null;
		if(key.equals("hot")) {
			list = templeteService.findHotTempletes();
		}else if(key.equals("new")) {
			list = templeteService.findNewTempletes();
		}else {
			list = templeteService.findByType(Integer.valueOf(key));
		}
		return templeteService.copyList(list);
	}
	/**
	 * 查看模板详细信息
	 * @param id
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(Integer id,Model model){
		if (id == null) {
			return Global.ERROR_404;
		}
		Templete templete = templeteService.get(id);
		model.addAttribute("t", templete);
		return "templete/detail";
	}
	/**
	 * 搜索模板
	 * @param key
	 * @param currentPage
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/search")
	public Map<String,Object> search(String key,Integer currentPage,Integer pageSize,Integer p1) {
		Page page = new Page(currentPage,pageSize);
		return templeteService.search(key, page, p1);
	}
	/**
	 * 查找所有模板
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findAll")
	public Map<String, Object> findAll() {
		List<Templete> list = templeteService.findAll();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", templeteService.copyList(list));
		return map;
	}
	/**
	 * 统计模板量
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/count")
	public Long count(){
		return templeteService.count();
	}

}

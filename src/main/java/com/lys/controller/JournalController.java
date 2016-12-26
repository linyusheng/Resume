package com.lys.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lys.face.IJcommentService;
import com.lys.face.IJournalService;
import com.lys.face.IUserService;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lys.entity.Jcomment;
import com.lys.entity.Journal;
import com.lys.entity.Userinfo;
import com.lys.util.Global;
import com.lys.util.Tool;

/**
 * 简历日志访问控制类
 * @author between
 */
@Controller
@RequestMapping("/journal")
public class JournalController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(JournalController.class);
	
	@Autowired
	private IUserService userService;
	@Autowired
	private IJournalService journalService;
	@Autowired
	private IJcommentService jcommentService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(){
		return Global.PERSONAL_JOURNAL;
	}

	/**
	 * 编写日志
	 * @return
	 */
	@RequestMapping("/write")
	public String write() {
		return Global.PERSONAL_JOURNAL_WRITE;
	}
	/**
	 * 添加日志
	 * @return
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@RequestMapping("/add")
	public String add(String title,String content,HttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile multipartFile = multipartRequest.getFile("file");
		String realPath = request.getSession().getServletContext().getRealPath("/assets/image/journal/");
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
		//复制文件到工作空间
		FileUtils.copyFile(file, new File("E:/MyEclipseWorkspaces/Resume/WebRoot/assets/image/journal/"+fileName));
		Userinfo user = (Userinfo)session.getAttribute("user");
		Journal journal = new Journal();
		journal.setUserinfo(user);
		journal.setTitle(title);
		journal.setContent(content);
		journal.setUrl("assets/image/journal/"+fileName);
		journal.setKeyword("简历  优秀  高效");
		journal.setBrowseNum("");
		journal.setPraiseNum("");
		journal.setTime(Tool.getCurrentTime());
		journalService.save(journal);
		return "redirect:/journal";
	}
	/**
	 * 查找个人日志信息
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/find")
	public List<Journal> find(HttpSession session) {
		Userinfo user = (Userinfo)session.getAttribute("user");
		List<Journal> list = null;
		if (user == null) {
			
		}else {
			list = journalService.findByUser(user.getUid());
		}
		return list;
	}
	/**
	 * 进入日志详情页
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail() {
		return Global.PERSONAL_JOURNAL_DETAIL;
	}
	/**
	 * 查找简历日志详情
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/get")
	public Map<String, Object> get(Integer id) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (id == null) {
			map.put("state", "bad");
		}else {
			Journal journal = journalService.get(id);
			map.put("state", "success");
			map.put("journal", journal);
			map.put("browsers", userService.findByIds(journal.getBrowseNum()));
			map.put("comments", jcommentService.find(id));
		}
		return map;
	}
	/**
	 * 添加日志评论
	 * @param jid
	 * @param content
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addComment")
	public Map<String, Object> addComment(Integer jid,String content,HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(jid == null || content == null){
			map.put("tip", "参数错误！");
		}else {
			Userinfo user = (Userinfo)session.getAttribute("user");
			Jcomment jcomment = new Jcomment();
			jcomment.setUid(user.getUid());
			jcomment.setJid(jid);
			jcomment.setContent(content);
			jcomment.setTime(Tool.getCurrentTime());
			jcommentService.save(jcomment);
			map.put("comments", jcommentService.find(jid));
			map.put("tip", "评论成功！");
		}
		return map;
	}

}

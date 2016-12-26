package com.lys.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lys.face.IAbiinfoService;
import com.lys.face.IBaseinfoService;
import com.lys.face.IHoninfoService;
import com.lys.face.IUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lys.entity.Userinfo;
import com.lys.model.Ajax;
import com.lys.util.Global;
import com.lys.util.MD5;
import com.lys.util.EmailUtil;
import com.lys.util.Tool;
import com.lys.util.VerifyCode;

/**
 * 用户访问控制类(类资源访问：/user/*)
 * @author between
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private IUserService userService;
	@Autowired
	private IBaseinfoService baseinfoService;
	@Autowired
	private IHoninfoService honinfoService;
	@Autowired
	private IAbiinfoService abiinfoService;
	
	
	/**
	 * 修改头像
	 * @param session
	 * @param request
	 * @return 
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@ResponseBody
	@RequestMapping("/face")
	public void editHead(Userinfo userifo,MultipartHttpServletRequest request,HttpSession session) throws IllegalStateException, IOException {
		MultipartFile multipartFile = request.getFile("file");
		String realPath = request.getSession().getServletContext().getRealPath("/assets/image/head/");
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
		//删除原来的头像
		Userinfo user = (Userinfo)session.getAttribute("user");
		String head = user.getHead();
		if (!head.equals(Global.DEFAULT_HEAD)) {
			Tool.deleteFile(System.getProperty("web.root") + head.replace("/", "\\"));
		}
		head = "assets/image/head/"+fileName;
		baseinfoService.editHead(user.getUid(), head);
		userService.editHead(user.getUid(), head);
		user.setHead(head);
		session.setAttribute("user", user);
	}
	/**
	 * 获取用户基本信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/get")
	public Userinfo get(){
		return userService.getUser("a@qq.com");
	}
	/**
	 * 生成验证码
	 * @param request
	 * @param response
	 */
	@RequestMapping("/verifyCode")
	public void verifyCode(HttpServletRequest request, HttpServletResponse response) {
		try {
			VerifyCode.getVerifyCode(request, response);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 登陆
	 * @param email
	 * @param rememberPass
	 * @param data
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/login")
	public Ajax login(String email,String rememberPass,@RequestBody String data,HttpSession session) {
		Ajax ajax = new Ajax();
		JSONObject object = JSON.parseObject(data);
		String pw = (String)object.get("pw");
		Userinfo user = userService.getUser("普通用户", email, pw);
		if (user == null) {
			ajax.setState("Bad");
			ajax.setException("用户名或密码错误");
		}else {
			ajax.setState("Success");
			//ajax.setReturnUrl("active.jsp");
			user.setLoginTime(Tool.getCurrentTime());
			userService.update(user);
			session.setAttribute("user", user);
			//将当前session添加到在线用户session中
			Global.ONLINEUSER.add(session);
		}
		return ajax;
	}
	/**
	 * 注册
	 * @param email
	 * @param code
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/register")
	public Ajax register(String email,String code,HttpSession session) {
		Ajax ajax = new Ajax();
		String verifyCode = (String)session.getAttribute("verifyCode");
		if (!code.toLowerCase().equals(verifyCode.toLowerCase())) {
			ajax.setState("Bad");
			ajax.setException("验证码不正确");
		}else {
			Userinfo user = userService.getUser(email);
			if (user != null) {
				ajax.setState("Bad");
				ajax.setException("用户名已存在");
			}else {
				userService.init(email,"","");
				EmailUtil.sendRegisterEmail(email, MD5.string2MD5(email));
				ajax.setState("Success");
				ajax.setReturnUrl("https://mail.qq.com");
			}
		}
		return ajax;
	}
	/**
	 * 激活账号
	 * @param email
	 * @param code
	 * @return
	 */
	@RequestMapping("/activate")
	public String activate(String email,String validateCode,Model model) {
		Userinfo user = userService.getUser(email);
		//验证用户是否存在
		if (user != null) {
			//验证用户激活状态
			if (!user.getStatus()) {
				Date currentTime = new Date();
				//验证链接是否过期
				if (currentTime.before(user.getLastActivateTime())) {
					//验证激活码是否正确
					if (validateCode.equals(user.getValidateCode())) {
						user.setStatus(true);
						userService.update(user);
						model.addAttribute("email", email);
						model.addAttribute("info", "账号激活成功！即将跳转...");
					}else {
						model.addAttribute("info", "激活码不正确！");
					}
				}else {
					model.addAttribute("info", "激活码已过期！");
				}
			}else {
				model.addAttribute("info", "邮箱已激活，请登录！");
			}
		}else{
			model.addAttribute("info", "该邮箱未注册（邮箱地址不存在）！");
		}
		return "active";
	}
	/**
	 * 跳转到设置密码页
	 * @param email
	 * @param model
	 * @return
	 */
	@RequestMapping("/toPwdPage")
	public String toPwdPage(String email,Model model) {
		model.addAttribute("email", email);
		return "setPwd";
	}
	/**
	 * 设置密码
	 * @param email
	 * @param password
	 */
	@ResponseBody
	@RequestMapping("/setPwd")
	public Ajax setPwd(@RequestBody String data,HttpSession session) {
		Ajax ajax = new Ajax();
		JSONObject object = JSON.parseObject(data);
		String email = (String)object.get("email");
		String password = (String)object.get("password");
		password = MD5.string2MD5(password);
		boolean result = userService.setPwd(email, password);
		if (result) {
			Userinfo user = userService.getUser("普通用户", email, password);
			user.setLoginTime(Tool.getCurrentTime());
			user.setNickname(email.substring(0, email.indexOf("@")));
			userService.save(user);
			//初始化简历基本信息
			baseinfoService.init(user);
			honinfoService.init(user);
			abiinfoService.init(user);
			session.setAttribute("user", user);
			ajax.setState("success");
			ajax.setReturnUrl("./");
		}else {
			ajax.setState("fail");
		}
		return ajax;
	}
	/**
	 * 找回密码
	 * @param email
	 * @param code
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findPass")
	public Ajax findPass(String email,String code) {
		Ajax ajax = new Ajax();
		
		return ajax;
	}
	/**
	 * 注销
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "success";
	}
	/**
	 * 修改密码
	 * @param data
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/modifyPwd")
	public Ajax modifyPwd(@RequestBody String data) {
		Ajax ajax = new Ajax();
		JSONObject object = JSON.parseObject(data);
		Integer uid = (Integer)object.get("uid");
		String oldPass = (String)object.get("oldPass");
		String pass = (String)object.get("pass");
		if (uid == null || oldPass == null || pass == null) {
			ajax.setState("Bad");
			ajax.setException("数据不能为空");
		}else {
			Userinfo user = userService.get(uid);
			if (!user.getPwd().equals(oldPass)) {
				ajax.setState("Bad");
				ajax.setException("旧密码不正确");
			}else {
				userService.setPwd(uid, pass);
				ajax.setState("Success");
			}
		}
		return ajax;
	}

	/**
	 * 积分经验
	 * @return
	 */
	@RequestMapping("/point")
	public String point() {
		return Global.PERSONAL_POINT;
	}
	
}

package com.lys.controller;

import java.util.List;
import java.util.Random;


import com.lys.face.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lys.entity.Abiinfo;
import com.lys.entity.Baseinfo;
import com.lys.entity.Goods;
import com.lys.entity.Honinfo;
import com.lys.entity.Journal;
import com.lys.entity.Templete;
import com.lys.entity.Type;
import com.lys.entity.Userinfo;
import com.lys.util.MD5;
import com.lys.util.Tool;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 测试访问控制类(类资源访问：/test/*)
 * @author between
 */
@Controller
@RequestMapping("/test")
public class TestController {
	
	@Autowired
	private IUserService userService;
	@Autowired
	private ITypeService typeService;
	@Autowired
	private ITempleteService templeteService;
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
	@Autowired
	private IJcommentService jcommentService;

	@ResponseBody
	@RequestMapping(method = RequestMethod.GET)
	public String get(){
		return "success";
	}

	/**
	 * 添加模板测试数据
	 */
	@RequestMapping("/addTemplete")
	public void addTemplete() {
		List<Type> types = typeService.findAll();
		for (Type type : types) {
			for (int i = 0; i < 30; i++) {
				Templete templete = new Templete();
				Userinfo userinfo = new Userinfo();
				userinfo.setUid(1);
				templete.setClickNum(0);
				templete.setCollectNum(0);
				templete.setDownloadNum(0);
				templete.setIsOpen(true);
				templete.setTpSize(Long.valueOf(62754));
				templete.setTpTime(Tool.getCurrentTime());
				templete.setTpTitle(type.getTname()+"简历模板");
				templete.setTpUrl("assets/templete/25377c30-4f00-43f2-9ae0-712a791b29f4.pdf");
				templete.setType(type);
				templete.setUserinfo(userinfo);
				templeteService.save(templete);
			}
		}
	}
	/**
	 * 添加用户测试数据
	 */
	@RequestMapping("/addUser")
	public void addUser() {
		char first = 'b', last = 'z';
		int firstNum = (int) first;
		int lastNum = (int) last;
		for (int i = firstNum; i < lastNum; i++) {
			String email = (char)i+"@qq.com";
			userService.init(email,MD5.string2MD5(email.substring(0, email.indexOf("@"))),email.substring(0, email.indexOf("@")));
		}
		for (int i = 1; i < 101; i++) {
			String email = i+"@qq.com";
			userService.init(email,MD5.string2MD5(email.substring(0, email.indexOf("@"))),email.substring(0, email.indexOf("@")));
		}
	}
	/**
	 * 修改用户测试数据
	 */
	@RequestMapping("/editUser")
	public void editUser() {
		List<Userinfo> userinfos = userService.findAll();
		for (Userinfo user : userinfos) {
			userService.update(user);
		}
	}
	/**
	 * 添加简历基本信息测试数据
	 */
	@RequestMapping("/addBaseinfo")
	public void addBaseinfo() {
		List<Userinfo> userinfos = userService.findAll();
		for (Userinfo userinfo : userinfos) {
			baseinfoService.init(userinfo);
		}
	}
	/**
	 * 修改简历基本信息测试数据
	 */
	@RequestMapping("/editBaseinfo")
	public void editBaseinfo() {
		List<Baseinfo> baseinfos = baseinfoService.findAll();
		for (Baseinfo baseinfo : baseinfos) {
			Random random = new Random();
			int ran = random.nextInt(5)+1;
			baseinfo.setEducation(ran+"");
			baseinfoService.update(baseinfo);
		}
	}
	/**
	 * 添加简历荣誉信息测试数据
	 */
	@RequestMapping("/addHoninfo")
	public void addHoninfo() {
		for (int i = 1; i < 126; i++) {
			Honinfo honinfo = new Honinfo(i,"","","","","");
			honinfoService.save(honinfo);
		}
	}
	/**
	 * 添加简历个人素质信息
	 */
	@RequestMapping("/addAbiinfo")
	public void addAbiinfo() {
		for (int i = 1; i < 126; i++) {
			Abiinfo abiinfo = new Abiinfo(i,"[]","[]","[]","[]","[]");
			abiinfoService.save(abiinfo);
		}
	}
	/**
	 * 添加商品信息
	 */
	@RequestMapping("/addGoods")
	public void	addGoods() {
		for(int i = 0; i < 300;i++){
			Goods goods = new Goods();
			goods.setGname("");
			goods.setGpoint(100);
			goods.setGpicture("assets/image/goods/"+i+1+".jpg");
			goods.setGnum(20);
			goods.setGtime(Tool.getCurrentTime());
			goodsService.save(goods);
		}
	}
	/**
	 * 修改商品信息
	 */
	@RequestMapping("/editGoods")
	public void	editGoods() {
		int i = 1;
		List<Goods> gList = goodsService.findAll();
		for (Goods goods : gList) {
			if(i == 6){
				i = 1;
			}
			goods.setGpicture("assets/image/goods/"+i+".jpg");
			i++;
			goodsService.update(goods);
		}
	}
	/**
	 * 添加日志信息
	 * @return
	 */
	@RequestMapping("/addJournal")
	public void addJournal() {
		Userinfo user = new Userinfo();
		user.setUid(1);
		for (int i = 1; i < 30; i++) {
			Journal journal = new Journal();
			journal.setUserinfo(user);
			journal.setTitle("如何编写优秀的简历？");
			journal.setContent("啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊");
			journal.setUrl("assets/image/journal/1.jpg");
			journal.setKeyword("简历  优秀  高效");
			journal.setTime(Tool.getCurrentTime());
			journalService.save(journal);
		}
	}

	public static void main(String[] args) {
		for (int i = 0; i < 125; i++) {
			StringBuilder s = new StringBuilder("");
			for (int j = 0; j < 5; j++) {
				Random random = new Random(i+j);
				int ran = random.nextInt(36)+1;
				if(j == 0){
					s.append(ran);
				}else{
					s.append(";"+ran);
				}
			}
			System.out.println(s.toString());
		}
	}
}

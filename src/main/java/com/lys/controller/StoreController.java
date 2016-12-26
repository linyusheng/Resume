package com.lys.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lys.face.IExchangeService;
import com.lys.face.IGoodsService;
import com.lys.face.IGtypeService;
import com.lys.face.IUserService;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.lys.entity.Exchange;
import com.lys.entity.Goods;
import com.lys.entity.Gtype;
import com.lys.entity.Userinfo;
import com.lys.model.Ajax;
import com.lys.util.FileEveryDaySerialNumber;
import com.lys.util.Global;
import com.lys.util.Page;
import com.lys.util.SerialNumber;
import com.lys.util.Tool;

/**
 * 积分商城访问控制类
 * @author between
 */
@Controller
@RequestMapping("/store")
public class StoreController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IGtypeService gtypeService;
	@Autowired
	private IExchangeService exchangeService;
	@Autowired
	private IUserService userService;

	@RequestMapping(method = RequestMethod.GET)
	public String get(){
		return Global.STORE_INDEX;
	}
	
	/**
	 * 静态化商品类型为json文件
	 * @throws IOException 
	 */
	@RequestMapping("/staticType")
	public void staticType(HttpServletResponse response) throws IOException {
		List<Gtype> list = gtypeService.findAll();
		String type = JSON.toJSONString(list);
		//设置文件存放路径
		String path = System.getProperty("web.root") + "assets" + File.separator + "json" + File.separator + "gtype.json";
		FileOutputStream fos = new FileOutputStream(path);
		OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
		PrintWriter o = new PrintWriter(osw);
		o.println(type);
		o.close();
		//复制该json文件到工作空间
		File destFile = new File(Global.WORKSPACE_GOODS_TYPE_URL);
		FileUtils.copyFile(new File(path), destFile);
	}
	/**
	 * 搜索商品列表
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/search")
	public Map<String,Object> search(String key,Integer pId,Integer tId,Integer currentPage,Integer pageSize,Integer order) {
		Page page = new Page(currentPage,pageSize);
		return goodsService.search(key,pId,tId,page,order);
	}
	/**
	 * 兑换商品
	 * @param gid
	 * @param num
	 * @param address
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/exchange")
	public Ajax exchange(Integer gid,Integer num,String address,HttpSession session) {
		Ajax ajax = new Ajax();
		if (gid == null || num == null || address == null) {
			ajax.setState("bad");
			ajax.setException("参数不能为空");
			return ajax;
		}
		Userinfo user = (Userinfo)session.getAttribute("user");
		Integer myPoint = user.getPoint();
		Goods goods = goodsService.get(gid);
		if(myPoint < goods.getGpoint() * num){
			ajax.setState("bad");
			ajax.setException("用户积分不足");
			return ajax;
		}
		//添加兑换记录
		Exchange exchange = new Exchange();
		exchange.setUserinfo(user);
		exchange.setGoods(goods);
		exchange.setEcount(num);
		exchange.setEaddress(address);
		SerialNumber s = new FileEveryDaySerialNumber(6,Global.ORDER_NUMBER);
		exchange.setEnumber(s.getSerialNumber());
		exchange.setEtime(Tool.getCurrentTime());
		exchangeService.save(exchange);
		//更新用户积分
		user.setPoint(user.getPoint() - goods.getGpoint() * num);
		userService.update(user);
		session.setAttribute("user", user);
		//更新商品库存
		goods.setGnum(goods.getGnum() - num);
		goodsService.update(goods);
		ajax.setState("success");
		return ajax;
	}
	/**
	 * 查找所有模板
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/findAll")
	public Map<String, Object> findAll() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Goods> list = goodsService.findAll();
		map.put("data", list);
		System.out.println(JSON.toJSONString(map));
		return map;
	}
}

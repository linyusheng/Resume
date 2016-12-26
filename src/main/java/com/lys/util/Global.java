package com.lys.util;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;

/**
 * 全局属性定义
 * 
 * @author 林玉生
 *
 */
public class Global {
	/**
	 * 错误页
	 */
	public final static String ERROR_404 = "error/404";
	
	public final static String ERROR_500 = "error/500";
	
	public final static String ERROR_DENY = "error/deny";
	
	/**
	 * 首页
	 */
	public final static String INDEX = "index";
	
	/**
	 * 简历页
	 */
	public final static String RESUME_DETAIL = "resume/detail";
	
	/**
	 * 模板库页
	 */
	public final static String TEMPLETE_INDEX = "templete/index";
	
	public final static String TEMPLETE_DETAIL = "templete/detail";
	
	public final static String TEMPLETE_PREVIEW = "templete/preview";
	
	/**
	 * 积分商城页
	 */
	public final static String STORE_INDEX = "store/index";
	
	/**
	 * 论坛交流页
	 */
	public final static String BBS_INDEX = "bbs/index";
	
	/**
	 * 技巧指导页
	 */
	public final static String GUIDE_INDEX = "guide/index";
	
	/**
	 * 个人中心
	 */
	public final static String PERSONAL_POINT = "personal/point";
	
	public final static String PERSONAL_NOTICE = "personal/notice";
	
	public final static String PERSONAL_COLLECT = "personal/collect";
	
	public final static String PERSONAL_JOURNAL = "personal/journal";
	
	public final static String PERSONAL_JOURNAL_WRITE = "personal/journal_add";
	
	public final static String PERSONAL_JOURNAL_DETAIL = "personal/journal_detail";
	
	/**
	 * 存储在线用户session
	 */
	public static Set<HttpSession> ONLINEUSER = new HashSet<HttpSession>();
	
	/**
	 * 管理员页
	 */
	public final static String ADMIN_INDEX = "admin/index";

	public final static String ADMIN_LOGIN = "admin/login";
	
	public final static String ADMIN_LOCK = "admin/lock";
	
	public final static String ADMIN_MANAGE_ONLINEUSER = "admin/manage-onlineuser";
	
	public final static String ADMIN_MANAGE_USER = "admin/manage-user";
	
	public final static String ADMIN_MANAGE_RESUME = "admin/manage-resume";
	
	public final static String ADMIN_MANAGE_TEMPLETE = "admin/manage-templete";
	
	public final static String ADMIN_MANAGE_NOTICE = "admin/manage-notice";
	
	public final static String ADMIN_MANAGE_GOODS = "admin/manage-goods";
	
	public final static String ADMIN_MANAGE_JOURNAL = "admin/manage-journal";
	
	public final static String ADMIN_MANAGE_BBS = "admin/manage-bbs";
	
	public final static String ADMIN_MANAGE_SYSTEM = "admin/manage-system";
	
	public final static String ADMIN_MANAGE_STATISTICS = "admin/manage-statistics";
	/**
	 * 头像默认存储路径
	 */
	public final static String DEFAULT_HEAD = "assets/image/head/default.jpg";
	/**
	 * 存储于工作空间文件路径
	 */
	public final static String WORKSPACE_TEMPLETE_TYPE_URL = "E:/MyEclipseWorkspaces/Resume/WebRoot/assets/json/type.json";
	
	public final static String WORKSPACE_GOODS_TYPE_URL = "E:/MyEclipseWorkspaces/Resume/WebRoot/assets/json/gtype.json";
	
	/**
	 * 订单号文件存储路径:tomcat的bin目录下
	 */
	public final static String ORDER_NUMBER = "number.txt";
}

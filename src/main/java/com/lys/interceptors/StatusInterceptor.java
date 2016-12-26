package com.lys.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.lys.entity.Userinfo;

/**
 * 状态拦截器(登陆拦截和锁屏拦截)
 * @author 林玉生
 *
 */
public class StatusInterceptor implements HandlerInterceptor{

	private static Logger logger = LoggerFactory.getLogger(StatusInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		logger.info("请求资源：{},开始时间：{}",request.getRequestURI(),System.currentTimeMillis());
		HttpSession session = request.getSession();
		Userinfo user = (Userinfo)session.getAttribute("admin");
		//如果管理员未登录，重定向到登陆页
		if (user == null) {
			response.sendRedirect("admin/logout");
			return false;
		}
		//如果管理员登陆且已锁定窗口
		String lock = (String)session.getAttribute("lock");
		if (lock != null) {
			response.sendRedirect("lock");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("请求资源：{},结束时间：{}",request.getRequestURI(),System.currentTimeMillis());
		
	}

}

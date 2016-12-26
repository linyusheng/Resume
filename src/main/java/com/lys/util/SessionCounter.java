package com.lys.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * session记录监听器
 * @author between
 */
public class SessionCounter implements HttpSessionListener{

	private static Logger logger = LoggerFactory.getLogger(SessionCounter.class);

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		ServletContext sc = se.getSession().getServletContext();
		Integer numSessions = (Integer)sc.getAttribute("numSessions");
		if(numSessions == null){
			numSessions = new Integer(1);
		}else{
			numSessions++;
		}
		logger.debug("创建session：{}",se.getSession().getId());
		sc.setAttribute("numSessions", numSessions);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		ServletContext sc = se.getSession().getServletContext();
		Integer numSessions = (Integer)sc.getAttribute("numSessions");
		if(numSessions == null){
			numSessions = new Integer(0);
		}else{
			numSessions--;
		}
		//注销的同时移除在线用户
		Iterator<HttpSession> iterator = Global.ONLINEUSER.iterator();
		while (iterator.hasNext()) {
			HttpSession session = (HttpSession) iterator.next();
			if(session == se.getSession()){
				iterator.remove();
				break;
			}
		}
		logger.debug("销毁session：{}"+se.getSession().getId());
		sc.setAttribute("numSessions", numSessions);
	}
	

}

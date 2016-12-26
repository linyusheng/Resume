package com.lys.filter;

import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 主机过滤器
 * @author between
 *
 */
public class HostFilter implements Filter{

	private static Logger logger = Logger.getLogger(HostFilter.class);
	
	private String[] allowHosts = null;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		allowHosts = filterConfig.getInitParameter("allow").split(",");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		String host = request.getRemoteHost();
		logger.info("请求主机IP：" + host);
		boolean r = Arrays.asList(allowHosts).contains(host);
		if (r) {
			chain.doFilter(request, response);
		}else {
			request.getRequestDispatcher("/error/deny.jsp").forward(request, response);
		}
	}

	@Override
	public void destroy() {

	}

}

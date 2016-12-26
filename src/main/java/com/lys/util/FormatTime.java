package com.lys.util;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 转换时间格式工具类
 * 
 * @author between
 *
 */
public class FormatTime {
	
	/**
	 * 将Date类型转换成yyyy-MM-dd格式
	 * 
	 * @return
	 */
	public static String Format1(Date date) {
		//HH：24小时制时间显示  hh:12小时制时间显示
		Format f = new SimpleDateFormat("yyyy-MM-dd");
		return f.format(date);
	}

}

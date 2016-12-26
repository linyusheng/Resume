package com.lys.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * Spring工具类
 * 
 * @author 林玉生
 *
 */
public class SpringUtil {
	
	/**
	 * 上传单文件，文件域name默认为file
	 * @param request
	 * @param path /assets/image/head/
	 * @return /assets/image/head/591b8f2b-55da-43e2-9e9e-b6873d6face5.jpg
	 */
	public static String upload(MultipartHttpServletRequest request,String path) {
		MultipartFile mt = request.getFile("file");
		String realPath = request.getSession().getServletContext().getRealPath(path);
		File file = new File(realPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		//获取文件的后缀
		String suffix = mt.getOriginalFilename().substring(mt.getOriginalFilename().lastIndexOf("."));
        // 使用UUID生成文件名称
        String fileName = UUID.randomUUID().toString() + suffix;
        //完整路径
        realPath += File.separator + fileName;
        file = new File(realPath);
		try {
			mt.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return path.substring(1) + fileName;
	}
}

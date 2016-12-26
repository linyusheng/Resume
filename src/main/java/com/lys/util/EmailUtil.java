package com.lys.util;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 发送邮件工具类
 * @author between
 *
 */
public class EmailUtil {
	
	public static final String HOST = "smtp.qq.com";  
    public static final String PROTOCOL = "smtp";     
    public static final int PORT = 25;  
    public static final String FROM = "2275755329@qq.com";
    public static final String PWD = "FBAGLLF";			
    
    /**
     * 获取连接会话对象
     * @return
     */
    private static Session getSession() {  
        Properties props = new Properties();  
        props.put("mail.smtp.host", HOST);//设置服务器地址  
        props.put("mail.store.protocol" , PROTOCOL);//设置协议  
        props.put("mail.smtp.port", PORT);//设置端口  
        props.put("mail.smtp.auth" , "true");  
          
        Authenticator authenticator = new Authenticator() {  
  
            @Override  
            protected PasswordAuthentication getPasswordAuthentication() {  
                return new PasswordAuthentication(FROM, MD5.convertMD5(PWD));  
            }  
              
        };  
        Session session = Session.getDefaultInstance(props , authenticator);  
          
        return session;  
    }  
    
    /**
     * 发送邮件
     * @param toEmail	目标邮箱
     * @param subject	邮件标题
     * @param content	邮件内容
     */
    public static void send(String toEmail ,String subject, String content) {
        Session session = getSession();  
        try {  
            // Instantiate a message  
            Message msg = new MimeMessage(session);  
   
            //Set message attributes  
            msg.setFrom(new InternetAddress(FROM));  
            InternetAddress[] address = {new InternetAddress(toEmail)};  
            msg.setRecipients(Message.RecipientType.TO, address);  
            msg.setSubject(subject);
            msg.setSentDate(new Date());  
            msg.setContent(content , "text/html;charset=utf-8");  
   
            //Send the message  
            Transport.send(msg);  
        }  
        catch (MessagingException mex) {  
            mex.printStackTrace();  
        }  
    }
    /**
     * 发送注册邮件
     * @param email
     * @param validateCode
     */
    public static void sendRegisterEmail(String email,String validateCode) {
    	//邮件标题
    	String subject = "[简历网] 注册邮箱验证";
    	//邮件的内容  
        StringBuffer sb=new StringBuffer();
        sb.append("您收到这封邮件，是因为在简历网注册新用户时使用了您的Email地址。<br />");
        sb.append("如果您并没有访问过我们的网站，请忽略这封邮件，并立刻删除。您不需要退订或进行其他进一步的操作。<br />");
        sb.append("----------------------------------------------------------------------<br />");
        sb.append("帐号注册说明<br />");
        sb.append("----------------------------------------------------------------------<br />");
        sb.append("点击下面的链接即可完成您的帐号注册：<br />");
        sb.append("<a href=\"http://lys/Resume/user/activate?email=");  
        sb.append(email);   
        sb.append("&validateCode=");   
        sb.append(validateCode);  
        sb.append("\">http://lys/Resume/user/activate?email=");   
        sb.append(email);  
        sb.append("&validateCode=");
        sb.append(validateCode);  
        sb.append("</a><br />"); 
        sb.append("(如果上面不是链接形式，请将地址手工粘贴到浏览器地址栏再访问)<br />");
        sb.append("为避免验证失效，请使用申请注册时使用的浏览器打开该链接。<br />邮件验证时间为30分钟，若超过时间则需要重新申请注册。");
        //发送邮件
        send(email,subject, sb.toString());
    }
    
}

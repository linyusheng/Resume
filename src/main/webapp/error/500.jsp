<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>简历网</title>
    
  </head>
  
  <body style="text-align: center;">
    <h1>噢哦，服务器好像发生了点问题耶^_^</h1>
    <a href="./">返回首页</a>
  </body>
</html>

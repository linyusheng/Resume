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
	<style>
	img{width:915px;height:567px;display:block;margin:0 auto;}
	</style>
  </head>
  
  <body style="text-align: center;">
    <a href="./"><img src="assets/image/404.png"></a>
  </body>
</html>

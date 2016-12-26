<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <form action="./user/add" method="post">
    	<label>账号：</label>
    	<input type="email" name="account" required/>
    	<label>密码：</label>
    	<input type="password" name="password" required/>
    	<label>密保问题：</label>
    	<select name="">
    		<option value="1">你的父亲的名字？</option>
    		<option value="2">你的母亲的名字？</option>
    	</select>
    	<input type="text" required/>
    	<input type="submit" value="注册">
    </form>
  </body>
</html>

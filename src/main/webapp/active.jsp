<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    	body{background-color: #F2F4F8;}
    	h1,p{text-align: center;}
    </style>
  </head>
  
  <body>
  	
  	<h1>${info}</h1>
  	<c:if test="${email == null}">
  		<p><a href="./">点击回到简历网</a></p>
  	</c:if>
  	<c:if test="${email != null}">
  		<script type="text/javascript">
  			window.setTimeout(function(){
  				location.href="user/toPwdPage?email=${email}";
  			}, 2000);
  		</script>
  	</c:if>	
  </body>
</html>

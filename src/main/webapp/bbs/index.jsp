<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.math.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en" class="no-js ng-app:App" ng-app="App" id="ng-app">

	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" cotent="IE=edge,chrome=1" />
		<meta name="renderer" content="webkit">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<title>论坛交流-简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="css/store.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
		
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/modal.jsp"></jsp:include>

			<div id="page-wrapper">
				
				<div id="kz-web" class="fadeIn animated" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(247, 247, 247);">
                    <div class="page-main">
						<div class="page-main-wrap">
						</div>
                	</div>
                
	                <jsp:include page="../public/footer.jsp"></jsp:include>
	                
                
                </div>
			</div>
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
	</body>

</html>
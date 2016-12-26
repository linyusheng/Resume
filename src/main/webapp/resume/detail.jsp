<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<title>简历详情 - 简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet" />
		<link href="css/jl_pre.css" rel="stylesheet" />
		
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">

			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>

			<div id="page-wrapper">
				<div id="kz-web" class="fadeIn animated">
					<data id="uid" class="hide">${user.uid}</data>
					<data id="b" class="hide">${b}</data>
					<div class="panel" style="width:80%;margin:15px auto;" ng-controller="resumeCtrl">
						<div class="panel-heading text-center">{{b.rname}}</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-xs-2"><span style="color:#a6a6a6;">来源：</span>{{b.name}}</div>
								<div class="col-xs-2"><span style="color:#a6a6a6;">浏览量：</span>{{b.browseNum | getArrayLength}}</div>
								<div class="col-xs-2"><span style="color:#a6a6a6;">收藏量：</span>{{b.collectNum | getArrayLength}}</div>
								<div class="col-xs-4"><span style="color:#a6a6a6;">适合：</span>{{b.position | getPosition}}</div>
								<div ng-show="isShow">
									<div class="col-xs-2" ng-show="!isCollect">未收藏 <i class="fa fa-star-o" title="点击收藏" style="font-size:16px;cursor: pointer;" ng-click="collect()"></i></div>
									<div class="col-xs-2" ng-show="isCollect">已收藏 <i class="fa fa-star" title="点击取消收藏" style="font-size:16px;cursor: pointer;" ng-click="collect()"></i></div>
								</div>
								<!-- <div class="col-xs-3">
									评级：
	            					<i class="fa fa-star"></i>
		            				<i class="fa fa-star"></i>
		            				<i class="fa fa-star"></i>
		            				<i class="fa fa-star"></i>
		            				<i class="fa fa-star-o"></i>
								</div> -->
							</div>
						</div>
					</div>	
					<jsp:include page="resume.jsp"></jsp:include>
					
					<!-- <div class="panel" style="width:80%;margin:15px auto;">
						<div class="panel-heading">评级</div>
						<div class="panel-body">
							<div class="row"></div>
						</div>
					</div> -->
					
					<jsp:include page="../public/footer.jsp"></jsp:include>
					<jsp:include page="../public/modal.jsp"></jsp:include>
					
				</div>
			</div>
			
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="js/detail.js"></script>
	</body>

</html>
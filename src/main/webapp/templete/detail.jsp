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
		<title>简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="assets/css/typeahead.min.css" rel="stylesheet">
		<link href="css/bootstrap-tagsinput.css" rel="stylesheet">
		<link href="css/templete.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
		
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>

			<div id="page-wrapper">
				
				<div id="kz-web" class="fadeIn animated" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(247, 247, 247);">
                    <div class="page-main">
						<div class="page-main-wrap">
						    
							<div class="page-header-wrap">
				                <div class="page-header">
				                    <h3 class="heading">${t.tpTitle}</h3>
				                </div>
						        <div class="panel article-info-panel">
									<div class="panel-body">
										<div class="article-logo">
											<i class="fa fa-file-text-o"></i>
										</div>
										<div class="row article-info-box">
											<div class="col-xs-4">
												<p class="text-ellipsis">
													<span class="article-info-label">来源 : </span> 
													<span><a href="">${t.userinfo.nickname}</a></span>
												</p>
		
												<p class="text-ellipsis">
													<span class="article-info-label">类型 : </span> 
													<span id="holdTime">${t.type.tname}</span>
												</p>
		
												<p class="text-ellipsis remove margin bottom">
													<span class="article-info-label">发布时间 : </span> 
													<span><f:formatDate value="${t.tpTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
												</p>
											</div>
											<div class="col-xs-4">
												<p class="text-ellipsis">
													<span class="article-info-label">下载次数 :</span> 
													<span>${t.downloadNum}</span>
												</p>
		
												<p class="text-ellipsis">
													<span class="article-info-label">点击次数 :</span> 
													<span>${t.clickNum}</span>
												</p>
		
												<p class="text-ellipsis remove margin bottom">
													<span class="article-info-label">收藏次数 :</span> 
													<span>${t.collectNum}</span>
												</p>
											</div>
											<div class="col-xs-4">
												<p class="text-ellipsis">
													<span class="article-info-label">收藏 : </span> 
													<span>
														<i class="fa fa-star-o text-warning cxxt-save-icon" title="点击收藏"></i>
													</span>
												</p>
												<p class="text-ellipsis">
													<span class="article-info-label">下载 : </span> 
													<span>
														<i class="fa fa-download text-info" title="点击下载" ></i>
													</span>
												</p>
												<p class="text-ellipsis remove margin bottom">
													<span class="article-info-label">评级 : </span> 
													<span>
														<i class="fa fa-star text-info" title="点击评级" ></i>
														<i class="fa fa-star text-info" title="点击评级" ></i>
														<i class="fa fa-star-o text-info" title="点击评级" ></i>
														<i class="fa fa-star-o text-info" title="点击评级" ></i>
														<i class="fa fa-star-o text-info" title="点击评级" ></i>
													</span>
												</p>
											</div>
										</div>
									</div>
								</div>
						    </div>
							

							<div class="panel">
						        <iframe src="${t.tpUrl}" id="main" width="100%" height="500" style="border:0;"></iframe>
							</div>
						</div>
                	</div>
                
	                <jsp:include page="../public/footer.jsp"></jsp:include>
	                <jsp:include page="../public/modal.jsp"></jsp:include>
	                <jsp:include page="../public/templete_modal.jsp"></jsp:include>
                
                </div>
			</div>
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="js/templete.js"></script>
	</body>

</html>
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
		<title>首页-简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="assets/css/typeahead.min.css" rel="stylesheet">
		<link href="css/bootstrap-tagsinput.css" rel="stylesheet">
		<link href="css/index.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
		
			<jsp:include page="public/top.jsp"></jsp:include>
			<jsp:include page="public/left.jsp"></jsp:include>
			
			<div id="page-wrapper">
				<div id="kz-web" class="fadeIn animated" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(247, 247, 247);">
                    <div class="page-main" ng-controller="resumeCtrl">
						<div class="page-main-wrap">
							<div class="page-header-right"></div>
							<div class="page-header-wrap">
						        <div class="row">
						            <div class="col-sm-12">
						                <div class="page-header">
						                    <h3 class="heading">简历搜索系统</h3>
						                    <span class="text-ellipsis">从海量简历样本中，筛选出您最满意的简历</span>
						                </div>
						            </div>
						        </div>
						        <div class="row">
						            <div class="col-sm-12">
					                    <div class="page-search">
					                        <div class="input-group">
					                            <div class="input-group-btn">
					                                <button type="button" class="btn toggle-search-type dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">简历<i class="fa fa-caret-down"></i></button>
					                                <ul class="dropdown-menu dropdown-search-type">
					                                    <li><a href="templete">模板</a></li>
					                                </ul>
					                            </div>
					                            <input type="text" class="form-control" id="key">
					                            <span class="icon"><i class="fa fa-search"></i></span>
					
					                            <span class="input-group-btn">
					                                <button class="btn btn-success" id="btn-search" ng-click="page.currentPage=1;search()">搜&nbsp;索</button>
					                            </span>
					                        </div>
					                    </div>
						                <p class="text-ellipsis hot-word-div">
						                    <span class="hot-word hot-word-focus">热门搜索：</span>
                                            <a href="javascript:void(0);" class="hot-word">软件</a>
                                            <a href="javascript:void(0);" class="hot-word">机械</a>
                                            <a href="javascript:void(0);" class="hot-word">电子</a>
                                            <a href="javascript:void(0);" class="hot-word">服务业</a>
                                            <a href="javascript:void(0);" class="hot-word">广告</a>
                                            <a href="javascript:void(0);" class="hot-word">销售</a>
                                            <a href="javascript:void(0);" class="hot-word">策划</a>
                                            <a href="javascript:void(0);" class="hot-word">金融</a>
                                            <a href="javascript:void(0);" class="hot-word">贸易</a>
                                            <a href="javascript:void(0);" class="hot-word">通信</a>
                                            <a href="javascript:void(0);" class="hot-word">计算机</a>
                                            <a href="javascript:void(0);" class="hot-word">医药</a>
                                            <a href="javascript:void(0);" class="hot-word">酒店</a>
                                            <a href="javascript:void(0);" class="hot-word">文员</a>
                                            <a href="javascript:void(0);" class="hot-word">生物</a>
                                            <a href="javascript:void(0);" class="hot-word">化工</a>
                                            <a href="javascript:void(0);" class="hot-word">财会</a>
                                            <a href="javascript:void(0);" class="hot-word">管理</a>
                                            <a href="javascript:void(0);" class="hot-word">建筑</a>
                                            <a href="javascript:void(0);" class="hot-word">园林</a>
                                            <a href="javascript:void(0);" class="hot-word">装饰</a>
                                            <a href="javascript:void(0);" class="hot-word">材料</a>
                                            <a href="javascript:void(0);" class="hot-word">土木</a>
                                            <a href="javascript:void(0);" class="hot-word">建筑</a>
	                                    </p>
						            </div>
						        </div>
						    </div>
							
							<div class="panel selected-panel" ng-controller="selectPanel">
								<div class="selected-row">
						    		<div class="selected-title">职位类型:</div>
						    		<div class="selected-content">
						                <a class="selected-cell" href="javascript:;" ng-class="{true:'active'}[p.id==pId]" ng-click="filter_position(p.id)" ng-repeat="p in positions">{{p.name}}</a>
						            </div>
						    		<div class="selected-option">
						                <div ng-show="selectedDisplay[0] == '0'" ng-click="clickMore(0)">
						                    <span>更多</span> <i class="fa fa-caret-down text-success"></i>
						                </div>
						                <div ng-show="selectedDisplay[0] == '1'" ng-click="clickMore(0)">
						                    <span>收起</span> <i class="fa fa-caret-up text-success"></i>
						                </div>
						            </div>
						    	</div>
						    	<div class="selected-row">
						    		<div class="selected-title">学历要求:</div>
						    		<div class="selected-content">
						                <a class="selected-cell" href="javascript:;" ng-class="{true:'active'}[e.id==eId]" ng-click="filter_education(e.id)" ng-repeat="e in educations">{{e.name}}</a>
						            </div>
						    	</div>
								
						    </div>
							
						    <div class="panel">
						        <div class="panel-heading nav-search">简历筛选结果</div>
						        <div class="panel-body">
						            	<div ng-repeat="r in resumes" class="col-xs-6">
						            		<div class="resume">
						            			<a href="#" class="col-xs-2"><i class="fa fa-file-text-o"></i></a>
							            		<div class="detail col-xs-10">
							            			<div class="row">
							            				<div class="col-xs-6"><a href="resume/look?id={{r.uid}}" target="_blank">{{r.rname}}</a></div>
							            				<div class="col-xs-6">来源：<a href="#">{{r.name}}</a></div>
							            			</div>
							            			<div class="row">
							            				<div class="col-xs-6">收藏量：{{r.collectNum | getArrayLength}}</div>
							            				<div class="col-xs-6">浏览量：{{r.browseNum | getArrayLength}}</div>
							            			</div>
							            			<div class="row">
							            				<div class="col-xs-12">适合：{{r.position | getPosition}}</div>
							            			</div>
							            		</div>
						            		</div>
						            	</div>
										<!-- 分页条  -->
							            <div class="pagination-wrap">
							                <div class="pull-left xjh-search-pagetext">
							                   	 搜索到 <span class="text-success">{{page.totalRow}}</span> 份简历。
							                </div>
							                
							                <ul class="pagination pull-right remove margin bottom" ng-show="page.totalPage != 0" data-toggle="tooltip" data-placement="bottom" data-original-title="键盘 ↑ ↓ 键可滚动 ←→键可翻页哦">
							                    <li class="paginate_button previous" ng-class="{true:'disabled'}[page.currentPage==1]">
							                    	<a href="javascript:void(0);" ng-click="prev()"><i class="fa fa-angle-left"></i></a>
							                    </li>
							                    
							                    <li class="paginate_button" ng-class="{true:'active'}[page.currentPage==p]" ng-repeat="p in pages">
							                    	<a href="javascript:void(0);" ng-click="searchPage(p)">{{p}}</a>
							                    </li>
							                    
							                    <li class="paginate_button next" ng-class="{true:'disabled'}[page.currentPage==page.totalPage]">
							                    	<a href="javascript:void(0);" ng-click="next()"><i class="fa fa-angle-right"></i></a>
							                    </li>
							                </ul>
							            </div>

						        </div>
						    </div>
						    
						    
						</div>
                	</div>
                	
	                <jsp:include page="public/footer.jsp"></jsp:include>
	                <jsp:include page="public/modal.jsp"></jsp:include>
                
                </div>
			</div>
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="js/index.js"></script>
	</body>

</html>
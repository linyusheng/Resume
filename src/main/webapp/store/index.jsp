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
		<title>积分商城-简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="css/store.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
		
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/modal.jsp"></jsp:include>
			
			<div id="page-wrapper" ng-controller="goodsCtrl">
				<div id="kz-web" class="fadeIn animated" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(247, 247, 247);">
					<!-- 搜索栏 -->
					<div class="row nav_search">
						<div class="col-sm-3"></div>
			            <div class="col-sm-6">
		                    <div class="page-search">
		                        <div class="input-group">
		                            <input type="text" class="form-control" id="key" placeholder="搜索您喜欢的商品">
		                            <span class="icon"><i class="fa fa-search"></i></span>
		                            <span class="input-group-btn">
		                                <button class="btn btn-success" id="btn-search" ng-click="page.currentPage=1;search()" >搜&nbsp;索</button>
		                            </span>
		                        </div>
		                    </div>
			            </div>
			            
			            <div class="col-sm-3">
			            	<c:if test="${user != null}">
			            		<div class="myPoint">
			            		<i class="fa fa-user text-success"></i>
			            		我的积分：<span class="text-success">${user.point}</span>
			            	</div>
			            	</c:if>
			            </div>
			        </div>
			        <!-- 筛选条件 -->
			        <div class="panel selected-panel" ng-controller="selectPanel">
				    	<div class="selected-header">
				    		<div class="col-xs-10">商品筛选（共搜到<span class="text-success">{{page.totalRow}}</span>款商品）</div>
				    		<div class="col-xs-2">
				    			排序方式：
				    			<button class="btn btn-success" ng-show="order == 0" ng-click="sort(1)">
				    				积分值&nbsp;<i class="fa fa-caret-up"></i>
				    			</button>
				    			<button class="btn btn-success" ng-show="order == 1" ng-click="sort(0)">
				    				积分值&nbsp;<i class="fa fa-caret-down"></i>
				    			</button>
				    		</div>
				    	</div>
				    	<div class="selected-row">
				    		<div class="selected-title">积分范围:</div>
				    		<div class="selected-content">
				                <a class="selected-cell" href="javascript:;" ng-class="{true:'active'}[p.id==pId]" ng-click="filter_point(p.id)" ng-repeat="p in pointScope">{{p.name}}</a>
				            </div>
				    	</div>
				    	<div class="selected-row">
				    		<div class="selected-title">商品类型:</div>
				    		<div class="selected-content">
				                <a class="selected-cell" href="javascript:;" ng-class="{true:'active'}[t.id==tId]" ng-click="filter_type(t.id)" ng-repeat="t in types">{{t.name}}</a>
				            </div>
				            <div class="selected-option">
				                <div ng-show="selectedDisplay[1] == '0'" ng-click="clickMore(1)">
				                    <span>更多</span> <i class="fa fa-caret-down text-success"></i>
				                </div>
				                <div ng-show="selectedDisplay[1] == '1'" ng-click="clickMore(1)">
				                    <span>收起</span> <i class="fa fa-caret-up text-success"></i>
				                </div>
				            </div>
				    	</div>
				    </div>
					<!-- 商品列表 -->
					<div class="goods">
						<div class="goods_detail" ng-repeat="g in goods">
							<div class="goods_detail_img">
								<img ng-src="{{g.gpicture}}" width="210" height="210">
							</div>
							<div class="goods_detail_title">
								<a href="#" title="{{g.gname}}">{{g.gname | split}}</a>
							</div>
							<div class="goods_detail_point">
								积分：<span>{{g.gpoint}}</span>
								<c:if test="${user == null}">
									<button class="btn btn-success pull-right exchange" data-toggle="modal" data-target="#userModal" ng-click="switchView('login')">兑换</button>
								</c:if>
								<c:if test="${user != null}">
									<button class="btn btn-success pull-right exchange" data-toggle="modal" data-target="#exchangeModal" ng-click="exchange(g)">兑换</button>
								</c:if>
							</div>
						</div>
						<div class="goods_null" ng-show="page.totalPage == 0">
							<i></i>
							<p>对不起，没有找到您想要的商品。</p>
						</div>
					</div>
					<!-- 分页条  -->
		            <div class="pagination-wrap" ng-show="page.totalPage != 0">
		                <div class="pull-left xjh-search-pagetext">
		                   	 共搜索到 <span class="text-success">{{page.totalRow}}</span> 款商品。
		                </div>
		                <ul class="pagination pull-right remove margin bottom" data-toggle="tooltip" data-placement="bottom" data-original-title="键盘 ↑ ↓ 键可滚动 ←→键可翻页哦">
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
					<jsp:include page="../public/footer.jsp"></jsp:include>
					<jsp:include page="../public/modal_exchange.jsp"></jsp:include>
				</div>
			</div>
		</div>
		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="js/store.js"></script>
	</body>

</html>
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
		<title>消息中心 - 简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="css/main.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
			
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>
			
			<div id="page-wrapper">
				<div id="kz-web" class="fadeIn animated">
					
					<jsp:include page="../public/logoutTip.jsp"></jsp:include>
					
					<c:if test="${user != null}">
						<div class="row">
                        	<div class="page-header">
		                        <h3 class="heading"><i class="fa fa-bell-o"></i>消息中心</h3>
		                        <p>平台所有的消息提醒都汇聚于消息中心，方便做统一处理</p>
	                    	</div>
	            		</div>
	            		<data class="hide" id="alertList">${alertList}</data>
						<div class="row" ng-controller="AlertList" ng-cloak>
						    <div class="col-md-2 alert-nav">
						        <div class="list-group" id="alert-form">
						            <a href="javascript:;" class="list-group-item" ng-repeat="type in typeArr"
						               ng-class="{active:currentType == type.id}" ng-click="setCurrentType(type.id)">
						                <span class="badge badge-warning" ng-show="typeUnreadCount[type.id]">{{typeUnreadCount[type.id]}}</span>
						                <i class="fa {{type.icon}} fa-fw"></i> {{type.string}}
						            </a>
						        </div>
						    </div>
						    <!-- alert-form -->
						    <div class="col-md-10 alert-list">
						        <div class="panel panel-default" ng-show="!showDetail">
						            <a href="javascript:void(0)" class="pull-right padding left right allread" ng-click="markAllAlertRead()">
						                <i class="fa fa-check"></i> 全部已读</a>
						            <div class="panel-heading alert-heading" ng-bind="currentType | typeStrFilter"></div>
						            <div class="panel-body alert-content reset padding-all" ng-show="itemCount">
						                <ul class="remove padding left margin bottom">
						                    <li class="alert-detail"
						                        ng-repeat="alert in alertList| typeListFilter:currentType | slice:currentPage * pageSize:(currentPage + 1) * pageSize"
						                        ng-click="readAlert(alert.id);showAlert(alert);">
						                        <i class="fa {{alert.kind| icoFilter}} fa-fw pull-left"></i>
						                        <p ng-bind-html="alert.info | infoFilter"></p>
						                        <div class="badge badge-danger" ng-hide="alert.isreaded">未读</div>
						                        <span class="pull-right alert-time" ng-bind="alert.time | limitTo:16"></span>
						                    </li>
						                </ul>
						                <ul class="pagination pull-right margin top bottom right" ng-show="pageCount != 1">
						                    <li class="previous" ng-class="{'disabled': currentPage == 0}">
						                        <a href="#" ng-click="setCurrentPage(currentPage - 1)"><i class="fa fa-angle-left"></i></a></li>
						                    <li ng-repeat="n in []| range:pageCount" ng-class="{active:currentPage == $index}">
						                        <a href="#" ng-click="setCurrentPage($index)">{{$index + 1}}</a></li>
						                    <li class="next" ng-class="{'disabled': currentPage == pageCount - 1}">
						                        <a href="#" ng-click="setCurrentPage(currentPage + 1)"><i class="fa fa-angle-right"></i></a></li>
						                </ul>
						            </div>
						            <div class="panel-body" ng-hide="itemCount">
						                <div class="text-center text-muted margin top bottom"><strong>- 没有消息 -</strong></div>
						            </div>
						        </div>
						        <div class="pannel panel-default" ng-show="showDetail">
						    		<a href="javascript:void(0)" class="pull-right allread" style="padding:0 15px 0 15px;" ng-click="showDetail=false">
						                <i class="fa fa-reply"></i> 返回列表</a>
						            <div class="panel-heading" style="padding:10px 15px;font-size:15px;font-weight: 900;">消息详情</div>
						    		<div class="panel-body" style="min-height:430px;background: #fff;">
						    			<div class="text-center"><h4>{{a.info}}</h4></div>
						    			<div class="text-center">{{a.time}}</div>
						    			<div>{{a.detail}}</div>
						    		</div>
						    	</div>
						    </div>
						</div>
					</c:if>
					
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
		<script src="js/notice.js"></script>
		<script type="text/javascript">
		    $('#kz-web').scroll(function(){
	            if($('#kz-web').scrollTop() > ($('#preach-head').height()-15)){
                    $('.alert-nav').css(
                            'top', $('#kz-web').scrollTop() - $('#preach-head').height() + 15
                    );
	            }
	            else {
                    $('.alert-nav').css('top', 0);
	            }
		    });
		</script>
		
	</body>

</html>
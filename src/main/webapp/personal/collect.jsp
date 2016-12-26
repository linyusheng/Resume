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
		<title>收藏中心 - 简历网</title>
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
		                        <h3 class="heading"><i class="fa fa-star"></i>收藏中心</h3>
		
		                        <p>平台所有的收藏信息都汇聚于收藏中心，方便做统一处理</p>
		                    </div>
            			</div>
            			<data class="hide" id="saveList">${saveList}</data>
						<div class="row" ng-controller="SaveList" ng-cloak>
						    <div class="col-md-2 save-nav">
						        <div class="list-group" id="save-form">
						            <a href="javascript:;" class="list-group-item"
						               ng-repeat="type in typeArr" ng-class="{active:currentType == type.id}" ng-click="setCurrentType(type.id)">
						                <i class="fa fa-star"></i> {{type.string}}
						            </a>
						        </div>
						    </div>
						    <!-- save-form -->
						    <div class="col-md-7 save-list">
						        <div class="panel panel-default">
						            <div class="panel-heading" ng-bind="currentType | typeStrFilter"></div>
						            <div class="panel-body save-content reset padding-all" ng-show="itemCount">
						                <table class="table save-content remove margin bottom">
						                    <tbody class="save-body">
						                        <tr class="save-detail" ng-repeat="save in saveList| typeListFilter:currentType | slice:currentPage * pageSize:(currentPage+1)*pageSize">
						                            <td class="save-sort"><i class="fa fa-star fa-fw"></i>{{save.kind| typeStrFilter}}</td>
						                            <td class="save-intro"><p><span class="save-title" ng-click="openNew(save.url)">{{save.title}}</span></p></td>
						                            <td class="save-time">{{save.time| limitTo:16}}</td>
						                            <td class="save-button" ng-click="cancel(save.id)">取消收藏</td>
						                        </tr>
						                    </tbody>
						                </table>
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
						                <div class="text-center text-muted margin top bottom"><strong>- 没有收藏 -</strong></div>
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
		<script src="js/collect.js"></script>
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
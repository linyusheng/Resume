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
		<title>经验积分 - 简历网</title>
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
	                        	<h3 class="heading"><i class="fa fa-trophy"></i>积分经验</h3>
	                        	<p>会员使用简历网会慢慢增加经验和积分，积分可兑换奖励</p>
                    		</div>
            			</div>
            			<data class="hide" id="pointData">{"exp":"${user.exp}","point":"${user.point}","resume":"${user.integrity}","pclogin":20,"applogin":20,"read":"1"}</data>
						<div class="row">
						    <div class="col-lg-9">
						        <div class="panel panel-default">
						            <div class="panel-heading">我的经验</div>
						            <div class="panel-body" ng-controller="ExpTable">
						                <div class="row" ng-controller="PointInfo">
						                    <div class="point-img">
						                        <a href="javascript:void(0)">
						                            <img class="img-circle" src="${user.head}" alt="个人头像" /></a>
						                    </div>
						                    <div class="col-xs-9 col-md-8">
						                        <h5>
						                            <!-- 用户等级水滴 -->
						                            等级：<strong class="lead margin right text-danger" ng-bind="level"></strong>
						                            <span ng-repeat="n in []| range:redTint" ng-cloak><i class="fa fa-tint fa-lg text-danger"></i> </span>
						                            <span ng-repeat="n in []| range:yellowTint" ng-cloak><i class="fa fa-tint fa-lg text-warning"></i> </span>
						                            <span ng-repeat="n in []| range:greenTint" ng-cloak><i class="fa fa-tint fa-lg text-success"></i> </span>
						
						                            <i class="margin left right"></i>
						                            积分：<strong class="lead text-danger" ng-bind="point"></strong>
						                        </h5>
						                        <div class="row">
						                            <div class="point-progress col-xs-11">
						                                <div class="progress progress-striped active margin bottom">
						                                    <div class="progress-bar progress-bar-warning"
						                                         data-toggle="tooltip" data-placement="bottom" data-original-title="经验：{{expPercentage}}%" data-container="body"
						                                         role="progressbar" aria-valuenow="{{expPercentage}}" ng-style="{ 'width' : expPercentage + '%'}"></div>
						                                </div>
						                            </div>
						                            <p class="col-xs-1 text-muted ng-cloak">{{exp}}/{{thisLevelExp}}</span></p>
						                        </div>
						                    </div>
						                </div>
						                <div class="row">
						                    <div class="col-xs-7">
						                        <h5 class="margin bottom">获得经验规则：</h5>
						                        <div class="row">
						                            <p class="col-xs-5"><i class="fa fa-fw fa-circle text-success"></i> 简历完善程度100%</p>
						                            <p class="col-xs-5 text-danger" ng-cloak>已获得 {{resume}}</p>
						                        </div>
						                        <div class="row">
						                            <p class="col-xs-5"><i class="fa fa-fw fa-circle text-success"></i> 每天登录+20</p>
						                            <p class="col-xs-5 text-danger" ng-cloak>今天已积累 {{pclogin}}</p>
						                        </div>
						                        <div class="row">
						                            <p class="col-xs-5"><i class="fa fa-fw fa-circle text-success"></i> 平台信息查看一篇+1</p>
						                            <p class="col-xs-5 text-danger" ng-cloak>今天已积累 {{read}}</p>
						                        </div>
						                        <div class="row">
						                            <p class="col-xs-5"><i class="fa fa-fw fa-circle text-success"></i> <!-- 移动版每天登录 -->上传优秀模板+20</p>
						                            <p class="col-xs-5 text-danger" ng-cloak>今天已积累 {{applogin}}</p>
						                        </div>
						                    </div>
						                    <div class="col-xs-4">
						                        <h5 class="margin bottom">等级换算规则：</h5>
						                        <div class="margin left right">
						                            <p>
						                                <i class="fa fa-tint fa-lg text-success"></i>
						                                <i class="fa fa-tint fa-lg text-success"></i>
						                                <i class="fa fa-tint fa-lg text-success"></i>
						                                <i class="fa fa-tint fa-lg text-success"></i>
						                                <i class="fa fa-chevron-right text-muted margin left right"></i>
						                                <i class="fa fa-tint fa-lg text-warning"></i>
						                            </p>
						                            <p>
						                                <i class="fa fa-tint fa-lg text-warning"></i>
						                                <i class="fa fa-tint fa-lg text-warning"></i>
						                                <i class="fa fa-tint fa-lg text-warning"></i>
						                                <i class="fa fa-tint fa-lg text-warning"></i>
						                                <i class="fa fa-chevron-right text-muted margin left right"></i>
						                                <i class="fa fa-tint fa-lg text-danger"></i>
						                            </p>
						                        </div>
						                        <p class="text-muted">每四颗蓝水滴变成一颗黄水滴</p>
						                        <p class="text-muted">每四颗黄水滴变成一颗红水滴</p>
						                    </div>
						                </div>
						            </div>
						        </div>
						        <div class="panel panel-default">
						            <div class="panel-heading">我的积分</div>
						            <div class="panel-body">
						                <h5>积分来源：</h5>
						                <p><i class="fa fa-fw fa-circle text-success"></i> 用户每增加100经验，则自动获得1点积分。
						                </p>
						                <p><i class="fa fa-fw fa-circle text-success"></i> 充值中心可购买积分。<!--<a href="javascript:void(0)" data-modal-page="points" data-toggle="modal" data-target="#userModal">立即充值</a>-->
						                </p>
						                <br/>
						                <h5>积分作用：</h5>
						                <p><i class="fa fa-fw fa-circle text-success"></i> 兑换简历“投递配额”，一点积分可兑换五个投递配额。<!-- <a href="javascript:void(0)" data-modal-page="points" data-toggle="modal" data-target="#pointModal">立即兑换</a> -->
						                </p>
						                <p><i class="fa fa-fw fa-circle text-success"></i> 兑换奖品，不同的奖品需要不同数量的积分来兑换。</p>
						                <p><i class="fa fa-fw fa-circle text-success"></i> 兑换简历模板，优秀的简历模板需要积分来兑换。</p>
						            </div>
						        </div>
						    </div>
						</div>
					</c:if>
					
					<jsp:include page="../public/footer.jsp"></jsp:include>
					<jsp:include page="../public/modal.jsp"></jsp:include>
					<jsp:include page="../public/point_modal.jsp"></jsp:include>
					
				</div>
			</div>
			
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="js/point.js"></script>
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
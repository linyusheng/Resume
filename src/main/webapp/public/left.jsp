<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 边栏 -->
<nav class="navbar-default navbar-static-side hidden-xs" role="navigation">
	<c:if test="${user != null }">
		<!-- 边栏 已登录 -->
		<data class="hide" id="myInfo">{"uid":"${user.uid}","uname":"${user.nickname}","exp":${user.exp}}</data>
		<div class="sidebar-user">
			<div class="user-intro">
				<div class="user-img">
					<a href="point" title="进入个人中心"><img src="<%=basePath%>${user.head}" alt="个人头像"></a>
				</div>
				<div class="user-info" ng-controller="PointInfo">
					<h5 class="user-name"><a href="point" title="进入个人中心">${user.nickname}</a></h5>
					<!-- 用户等级水滴 -->
					<div class="user-level">
						<p class="level-title">Lv.
							<span ng-bind="level"></span>
						</p>
						<div class="level-drip" ng-cloak>
							<span ng-repeat="n in []| range:redTint"><i class="level-1"></i> </span>
							<span ng-repeat="n in []| range:yellowTint"><i class="level-2"></i> </span>
							<span ng-repeat="n in []| range:greenTint"><i class="level-3"></i> </span>
						</div>
					</div>
					<!-- 用户等级水滴 -->
					<div class="progress progress-striped">
						<div class="progress-bar progress-bar-warning" data-toggle="tooltip" data-placement="bottom" data-original-title="经验：{{expPercentage}}%" data-container="body" role="progressbar" aria-valuenow="{{expPercentage}}" ng-style="{ 'width' : expPercentage + '%'}"></div>
					</div>
				</div>
			</div>
			<div class="user-resume">
				<a href="resume/get" class="resume-complete">我的简历</a>
				<div class="easy-pie danger pull-right right" data-percent="${user.integrity}%" data-toggle="tooltip" data-placement="bottom" data-original-title="完善的简历可以提高求职成功率哦！">
					<div class="percent">0</div>
				</div>
				<span class="pull-right">简历完善度</span>
			</div>
		</div>
	</c:if>
	<c:if test="${user == null }">
		<!-- 边栏 未登录 -->
		<div class="sidebar-login">
        	<div class="sidebar-status">
                 <div class="xjh-status">
                     <i class="fa fa-folder-open fa-3x"></i>
                     <p class="xjh-status-title">简历模板总数</p>
                     <p class="xjh-status-num" ng-bind="tpNum"></p>
                 </div>
             </div>
             <div class="sidebar-user-action">
                 <a href="javascript:void(0)" class="btn btn-sm btn-warning" data-toggle="modal" data-target="#userModal" ng-click="switchView('register')">注&nbsp;&nbsp;册</a>
                 <a id="loginBtn" href="javascript:void(0)" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#userModal" ng-click="switchView('login')">登&nbsp;&nbsp;录</a>
             </div>
         </div>
	</c:if>
	
	<!-- 边栏 子导航 -->
	<div class="sidebar-menu">

		<ul class="nav">
			<li>
				<a href="user/point">
					<i class="fa fa-angle-right fa-fw"></i> 积分经验 
				</a>
			</li>
			<li>
				<a href="notice">
					<i class="fa fa-angle-right fa-fw"></i> 消息中心
				 </a>
			</li>
			<li>
				<a href="collect">
					<i class="fa fa-angle-right fa-fw"></i> 收藏中心
				</a>
			</li>
		 	<li>
				<a href="journal">
					<i class="fa fa-angle-right fa-fw"></i> 日志空间
				</a>
			</li> 
			<li>
				<a href="resume/private">
					<i class="fa fa-angle-right fa-fw"></i> 个人设置
				</a>
			</li>
			<li>
				<a href="resume/get">
				<i class="fa fa-angle-right fa-fw"></i> 我的简历 </a>
			</li>
			<li class="side-menu-bottom"></li>
		</ul>
	</div>
</nav>
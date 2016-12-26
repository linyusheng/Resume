<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 顶栏 -->
<nav class="navbar navbar-default navbar-static-top" role="navigation">
	<!-- 顶栏 左栏 -->
	<div class="navbar-header">
		<a href="./"><i class="fa fa-file-text-o fa-fw"></i>简历网</a>
	</div>
	<!-- 顶栏 右栏 -->
	<ul class="navbar-top-links navbar-right navbar-tool-btn hidden-xs" ng-cloak>
		<c:if test="${user != null }">
			<!-- 顶栏 右栏 通知 -->
			<li class="dropdown" ng-controller="NavAlertList">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">
					<i class="fa fa-bell fa-fw"></i>
					<span class="badge badge-notification badge-warning animated fadeIn" ng-show="alertNum" ng-bind="alertNum"></span>
				</a>
				<ul class="dropdown-menu dropdown-alerts animated fadeInUp">
					<li class="alerts-title not-close">
						<span>消息提醒</span>
						<a href="javascript:void(0)" class="pull-right" title="全部标记为已读" ng-click="markAllRead()"><i class="fa fa-check"></i></a>
					</li>
					<li class="not-close" ng-repeat="alert in alertArr| limitTo:pageSize" ng-cloak>
						<a target="_blank" href="{{alert.url}}" ng-click="markRead($index)">
							<div>
								<!-- <i class="fa {{alert.kind| navAlertIcoFilter}} fa-fw"></i> -->
								<i class="fa fa-bell fa-fw"></i>
								<p ng-bind-html="alert.info | navAlertInfoFilter"></p>
								<span class="pull-right text-muted small" ng-bind="alert.time | readableTimeFilter"></span>
							</div>
						</a>
					</li>
					<li class="alerts-title not-close" ng-hide="alertArr.length">
						<div class="text-center text-muted margin top bottom"><strong>- 没有新通知 -</strong></div>
					</li>

					<li>
						<a class="text-center" href="notice">
							<strong>查看所有消息</strong>
						</a>
					</li>
				</ul>
			</li>
			<!-- 顶栏 右栏 用户 -->
			<li class="dropdown">
				<a class="dropdown-toggle user" data-toggle="dropdown" href="#">
					<i class="fa fa-user fa-fw"></i> <i class="fa fa-angle-down"></i>
				</a>
				<ul class="dropdown-menu animated fadeInUp">
					<li>
						<a href="point">
							<i class="fa fa-user fa-fw"></i> 个人中心
						</a>
					</li>
					<li class="notBorder">
						<a href="resume/get">
							<i class="fa fa-file-text-o fa-fw"></i> 我的简历
						</a>
					</li>
					<li class="notBorder">
						<a href="resume/private">
							<i class="fa fa-gear fa-fw"></i> 个人设置
						</a>
					</li>
					<li>
						<a href="javascript:void(0)" ng-click="logout()">
							<i class="fa fa-sign-out fa-fw"></i> 退出登录
						</a>
					</li>
				</ul>
			</li>
		</c:if>
		<c:if test="${user == null }">
			<!-- 顶栏 右栏 用户 未登录 -->
			<li class="dropdown">
				<a class="dropdown-toggle user" data-toggle="dropdown" href="#">
					<i class="fa fa-user fa-fw"></i> <i class="fa fa-angle-down"></i>
				</a>
				<ul class="dropdown-menu animated fadeInUp">
					<li>
						<a href="javascript:void(0)" data-toggle="modal" data-target="#userModal" ng-click="switchView('login')">
							<i class="fa fa-sign-in fa-fw"></i> 用户登录
						</a>
					</li>
					<li class="notBorder">
						<a href="javascript:void(0)" data-toggle="modal" data-target="#userModal" ng-click="switchView('register')">
							<i class="fa fa-book fa-fw"></i> 用户注册
						</a>
					</li>
				</ul>
			</li>
		</c:if>
	</ul>

	<ul class="navbar-top-links navbar-right navbar-main-menu hidden-xs" ng-cloak>
		<li>
			<a href=".">首&nbsp;&nbsp;页</a>
		</li>
		<li>
			<a href="templete">模板库</a>
		</li>
		<li>
			<a href="store">积分商城</a>
		</li>
		<!-- <li>
			<a href="bbs">论坛交流</a>
		</li> -->
		<li>
			<a href="guide">技巧指导</a>
		</li>
	</ul>
</nav>
<!-- 全局提示 -->
<div class="global-alert alert alert-dismissable">
	<button class="close" aria-hidden="true" data-dismiss="alert" type="button">×</button>
	<span></span>
</div>
<!-- loading -->
<div class="la-ball-spin-clockwise la-2x" style="color:#0f69e7;position:fixed;top:50%;left:50%;z-index: 999;display:none;">
	<div></div>
	<div></div>
	<div></div>
	<div></div>
	<div></div>
	<div></div>
	<div></div>
	<div></div>
</div>


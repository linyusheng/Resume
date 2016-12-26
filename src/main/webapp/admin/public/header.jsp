<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">
		<!-- BEGIN LOGO -->
		<div class="page-logo" style="line-height: 46px;text-align: center;font-size:16px;color: #FFF7EB;">
			简历网后台管理系统CMS
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
		</a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<div class="top-menu">
			<ul class="nav navbar-nav pull-right">
				<!-- BEGIN NOTIFICATION DROPDOWN -->
				<li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
						<i class="icon-envelope-open"></i>
						<span class="badge badge-default noticeNum"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<p>您有<span class="noticeNum"></span>个新反馈</p>
						</li>
						<li>
							<ul class="dropdown-menu-list scroller" id="noticeList" style="height: 250px;"></ul>
						</li>
						<li class="external">
							<a href="admin/noticeManage">查看所有反馈<i class="m-icon-swapright"></i></a>
						</li>
					</ul>
				</li>
				<!-- END NOTIFICATION DROPDOWN -->
				<!-- BEGIN INBOX DROPDOWN -->
				<!-- <li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
						<i class="icon-envelope-open"></i>
						<span class="badge badge-default">
			4 </span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<p>
								You have 12 new messages
							</p>
						</li>
						<li>
							<ul class="dropdown-menu-list scroller" style="height: 250px;">
								<li>
									<a href="inbox.html?a=view">
										<span class="photo">
							<img src="assets/admin/layout/img/avatar2.jpg" alt=""/>
							</span>
										<span class="subject">
							<span class="from">
							Lisa Wong </span>
										<span class="time">
							Just Now </span>
										</span>
										<span class="message">
							Vivamus sed auctor nibh congue nibh. auctor nibh auctor nibh... </span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
										<span class="photo">
							<img src="assets/admin/layout/img/avatar3.jpg" alt=""/>
							</span>
										<span class="subject">
							<span class="from">
							Richard Doe </span>
										<span class="time">
							16 mins </span>
										</span>
										<span class="message">
							Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
										<span class="photo">
							<img src="assets/admin/layout/img/avatar1.jpg" alt=""/>
							</span>
										<span class="subject">
							<span class="from">
							Bob Nilson </span>
										<span class="time">
							2 hrs </span>
										</span>
										<span class="message">
							Vivamus sed nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
										<span class="photo">
							<img src="assets/admin/layout/img/avatar2.jpg" alt=""/>
							</span>
										<span class="subject">
							<span class="from">
							Lisa Wong </span>
										<span class="time">
							40 mins </span>
										</span>
										<span class="message">
							Vivamus sed auctor 40% nibh congue nibh... </span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
										<span class="photo">
							<img src="assets/admin/layout/img/avatar3.jpg" alt=""/>
							</span>
										<span class="subject">
							<span class="from">
							Richard Doe </span>
										<span class="time">
							46 mins </span>
										</span>
										<span class="message">
							Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
									</a>
								</li>
							</ul>
						</li>
						<li class="external">
							<a href="inbox.html">
					See all messages <i class="m-icon-swapright"></i>
					</a>
						</li>
					</ul>
				</li> -->
				<!-- END INBOX DROPDOWN -->
				<!-- BEGIN USER LOGIN DROPDOWN -->
				<li class="dropdown dropdown-user">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
						<img alt="" class="img-circle hide1" src="${admin.head}" />
						<span class="username username-hide-on-mobile">${admin.nickname} </span>
						<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="#myInfoModal" data-toggle="modal">
								<i class="icon-user"></i> 个人信息 </a>
						</li>
						<li>
							<a href="#modifyPwdModal" data-toggle="modal">
								<i class="icon-pencil"></i> 修改密码 </a>
						</li>
						</li>
						<li>
							<a href="admin/lock">
								<i class="icon-lock"></i> 锁定窗口 </a>
						</li>
					</ul>
				</li>
				<!-- END USER LOGIN DROPDOWN -->
				<!-- BEGIN QUICK SIDEBAR TOGGLER -->
				<li class="dropdown dropdown-quick-sidebar-toggler">
					<a href="admin/logout" class="dropdown-toggle" title="注销">
						<i class="icon-logout"></i>
					</a>
				</li>
				<!-- END QUICK SIDEBAR TOGGLER -->
			</ul>
		</div>
		<!-- END TOP NAVIGATION MENU -->
	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<div class="clearfix"></div>
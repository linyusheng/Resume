<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
	<div class="page-sidebar navbar-collapse collapse">
		<!-- BEGIN SIDEBAR MENU -->
		<ul class="page-sidebar-menu" data-auto-scroll="true" data-slide-speed="200">
			<li class="sidebar-toggler-wrapper">
				<div class="sidebar-toggler"></div>
			</li>
			<li class="sidebar-search-wrapper">
				<form class="sidebar-search " action="extra_search.html" method="POST">
					<a href="javascript:;" class="remove">
						<i class="icon-close"></i>
					</a>
					<!-- <div class="input-group">
						<input type="text" class="form-control" placeholder="Search...">
						<span class="input-group-btn">
							<a href="javascript:;" class="btn submit"><i class="icon-magnifier"></i></a>
						</span>
					</div> -->
				</form>
			</li>
		</ul>
		<!-- END SIDEBAR MENU -->
	</div>
</div>
<!-- END SIDEBAR -->
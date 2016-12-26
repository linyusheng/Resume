<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
	<!--<![endif]-->
	<!-- BEGIN HEAD -->

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title>简历网</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="width=device-width, initial-scale=1.0" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<!-- BEGIN GLOBAL MANDATORY STYLES -->
		<link href="assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="assets/global/css/components.css" rel="stylesheet" type="text/css" />
		<link href="assets/global/css/plugins.css" rel="stylesheet" type="text/css" />
		<link href="assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css" />
		<link href="assets/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
		<!-- END GLOBAL MANDATORY STYLES -->
		<!-- BEGIN PAGE LEVEL STYLES -->
		<link href="assets/admin/pages/css/lock.css" rel="stylesheet" type="text/css" />
		<!-- END PAGE LEVEL STYLES -->
	</head>
	<!-- END HEAD -->
	<!-- BEGIN BODY -->

	<body>
		<div class="page-lock">
			<div class="page-logo">
				<h1 class="blue">简历网CMS</h1>
			</div>	
			<div class="page-body">
				<img class="page-lock-img" src="${admin.head }" alt="">
				<div class="page-lock-info">
					<h1>${admin.nickname }</h1>
					<span class="email">${admin.account } </span>
					<span class="locked">已锁 </span>
					<form class="form-inline">
						<div class="input-group input-medium">
							<input type="password" class="form-control" name="password" placeholder="密码">
							<span class="input-group-btn">
								<button type="submit" class="btn blue icn-only"><i class="m-icon-swapright m-icon-white"></i></button>
							</span>
						</div>
						<!-- /input-group -->
						<div class="relogin">
							<a href="admin/logout">不是${admin.nickname } ? </a>
						</div>
					</form>
				</div>
			</div>
			<div class="page-footer-custom">
				2015 &copy; 简历网. by between.
			</div>
		</div>
		<!-- BEGIN CORE PLUGINS -->
		<!--[if lt IE 9]>
		<script src="assets/global/plugins/respond.min.js"></script>
		<script src="assets/global/plugins/excanvas.min.js"></script> 
		<![endif]-->
		<script src="assets/global/plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
		<script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="assets/global/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
		<script src="assets/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
		<!-- END CORE PLUGINS -->
		<script src="assets/admin/pages/scripts/lock.js"></script>
		<script>
			jQuery(document).ready(function() {    
			    Lock.init();
			});
		</script>
		<!-- END JAVASCRIPTS -->
	</body>

	<!-- END BODY -->

</html>

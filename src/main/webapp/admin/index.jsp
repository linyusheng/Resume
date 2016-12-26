<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
	<!--<![endif]-->
	<!-- BEGIN HEAD -->

	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title>简历网</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<jsp:include page="public/global-style.jsp"></jsp:include>
	</head>
	<!-- END HEAD -->
	<!-- BEGIN BODY -->

	<body class="page-header-fixed page-quick-sidebar-over-content">
		<jsp:include page="public/header.jsp"></jsp:include>
		<!-- BEGIN CONTAINER -->
		<div class="page-container">
			<jsp:include page="public/sidebar.jsp"></jsp:include>
			<!-- BEGIN CONTENT -->
			<div class="page-content-wrapper">
				<div class="page-content">
					<!-- BEGIN PAGE HEADER-->
					<div class="page-bar">
						<ul class="page-breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="admin">首页 </a>
							</li>
						</ul>
					</div>
					<!-- END PAGE HEADER-->
					<!-- BEGIN 主体内容 -->
					<div class="row">
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat blue-madison">
								<div class="visual">
									<i class="fa fa-users"></i>
								</div>
								<div class="details">
									<div class="number" id="userNum"></div>
									<div class="desc">系统用户量</div>
								</div>
								<a class="more" href="admin/userManage">
									查看更多<i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat red-intense">
								<div class="visual">
									<i class="fa fa-rss"></i>
								</div>
								<div class="details">
									<div class="number" id="onlineUserNum"></div>
									<div class="desc">当前在线用户</div>
								</div>
								<a class="more" href="admin/onlineuserManage">
									查看更多 <i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat green-haze">
								<div class="visual">
									<i class="fa fa-user"></i>
								</div>
								<div class="details">
									<div class="number" id="monthRegisterNum"></div>
									<div class="desc">本月注册量</div>
								</div>
								<a class="more" href="admin/userManage">
									查看更多 <i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat purple-plum">
								<div class="visual">
									<i class="fa fa-user"></i>
								</div>
								<div class="details">
									<div class="number" id="dayRegisterNum"></div>
									<div class="desc">今日注册量</div>
								</div>
								<a class="more" href="admin/userManage">
									查看更多<i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat purple-plum">
								<div class="visual">
									<i class="fa fa-file-text"></i>
								</div>
								<div class="details">
									<div class="number" id="resumeNum"></div>
									<div class="desc">简历量</div>
								</div>
								<a class="more" href="admin/resumeManage">
									查看更多<i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat green-haze">
								<div class="visual">
									<i class="icon-wallet"></i>
								</div>
								<div class="details">
									<div class="number" id="templeteNum"></div>
									<div class="desc">模板量</div>
								</div>
								<a class="more" href="admin/templeteManage">
									查看更多<i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat red-intense">
								<div class="visual">
									<i class="fa fa-shopping-cart"></i>
								</div>
								<div class="details">
									<div class="number" id="goodsNum"></div>
									<div class="desc">商品量</div>
								</div>
								<a class="more" href="admin/goodsManage">
									查看更多 <i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
							<div class="dashboard-stat blue-madison">
								<div class="visual">
									<i class="fa fa-bookmark"></i>
								</div>
								<div class="details">
									<div class="number" id="journalNum"></div>
									<div class="desc">简历日志量</div>
								</div>
								<a class="more" href="admin/journalManage">
									查看更多<i class="m-icon-swapright m-icon-white"></i>
								</a>
							</div>
						</div>
					</div>
					<!-- END 主体内容 -->

				</div>
			</div>
			<!-- END CONTENT -->
		</div>
		<!-- END CONTAINER -->
		<jsp:include page="public/footer.jsp"></jsp:include>
		<jsp:include page="public/modal.jsp"></jsp:include>
		<jsp:include page="public/global-script.jsp"></jsp:include>
		<script src="assets/admin/pages/scripts/index.js" type="text/javascript"></script>
		<script>
			jQuery(document).ready(function() {
				Metronic.init(); 		// init metronic core componets
				Layout.init(); 			// init layout
				Public.init();
				$.get('admin/count',{},function(r){
					// 初始化
					$('#userNum').attr('data-to',r.userNum);
					$('#onlineUserNum').attr('data-to',r.onlineUserNum);
					$('#monthRegisterNum').attr('data-to',r.monthRegisterNum);
					$('#dayRegisterNum').attr('data-to',r.dayRegisterNum);
					$('#resumeNum').attr('data-to',r.resumeNum);
					$('#templeteNum').attr('data-to',r.templeteNum);
					$('#goodsNum').attr('data-to',r.goodsNum);
					$('#journalNum').attr('data-to',r.journalNum);
					// 开启时间滚动器
  					$('.number').each(count);  
  
				});
			});
			
		</script>
		<!-- END JAVASCRIPTS -->
	</body>

	<!-- END BODY -->

</html>
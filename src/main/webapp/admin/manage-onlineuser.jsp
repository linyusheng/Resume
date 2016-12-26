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
		<!-- BEGIN PAGE LEVEL STYLES -->
		<link href="assets/global/plugins/jquery-tags-input/jquery.tagsinput.css" rel="stylesheet" type="text/css" />
		<link href="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
		<!-- END PAGE LEVEL STYLES -->
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
						<ul class="page-breadcrumb"></ul>
					</div>
					<!-- END PAGE HEADER-->
					<!-- BEGIN 主体内容-->
					<div class="row">
						<div class="col-md-12">
							<!-- BEGIN 在线用户管理-->
							<div class="portlet box blue">
								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-rss"></i>当前在线用户
									</div>
									<div class="actions">
										<a href="javascript:;" class="btn purple btn-sm" id="refresh">
											<i class="fa fa-refresh"></i> 刷新</a>
										<a href="javascript:;" class="btn red btn-sm" id="logouts">
											<i class="fa fa-trash-o"></i> 批量注销 </a>
										<a href="javascript:;" class="btn green btn-sm" id="notices">
											<i class="fa fa-send"></i> 批量通知 </a>
									</div>
								</div>
								<div class="portlet-body" id="portlet-body">
									<table class="table table-striped table-bordered table-hover" id="onlineUserTable">
										<thead>
											<tr>
												<th class="table-checkbox">
													<input type="checkbox" class="group-checkable" data-set="#onlineUserTable .checkboxes" />
												</th>
												<th>用户名</th>
												<th>账号</th>
												<th>最近登陆时间</th>
												<th>在线时长</th>
												<th width="200">操作</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
							<!-- END 在线用户管理-->
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
		<!-- BEGIN 发送消息modal -->
		<div class="modal fade" id="sendNoticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="portlet box green" style="border: none;">
					<div class="portlet-title">
						<div class="caption"><i class="fa fa-send"></i>发送通知</div>
						<div class="tools">
							<a class="close" href="javascript:;" data-dismiss="modal"></a>
						</div>
					</div>
					<div class="portlet-body form">
						<form role="form" id="send-notice-form">
							<div class="form-body">
								<br />
								<div class="form-group">
									<label class="col-xs-3 control-label text-right" style="line-height: 32px;">目标用户</label>
									<div class="col-xs-8 input-group">
										<input type="text" class="form-control tags" id="target-user">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label text-right" style="line-height: 32px;">通知标题</label>
									<div class="col-xs-8 input-group">
										<input type="text" class="form-control" id="title" required="required">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label text-right" style="line-height: 32px;">通知内容</label>
									<div class="col-xs-8 input-group">
										<textarea class="form-control" rows="4" cols="" required="required"></textarea>
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-3">
										<span class="btn green" id="send-notice-submit-btn">提交</span>
										<span class="btn default pull-right" data-dismiss="modal">取消</span>
										<input type="reset" id="reset" style="display:none;" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- END 发送消息modal -->
		<jsp:include page="public/global-script.jsp"></jsp:include>
		<!-- BEGIN PAGE LEVEL SCRIPTS -->
		<script type="text/javascript" src="assets/global/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/bootbox/bootbox.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
		<script src="assets/admin/pages/scripts/manage-onlineuser.js" type="text/javascript"></script>
		<!-- END PAGE LEVEL SCRIPTS -->
		<script>
			jQuery(document).ready(function() {
				Metronic.init(); // init metronic core componets
				Layout.init(); // init layout
				Public.init();
				Managed.init();
			});
		</script>
		<!-- END JAVASCRIPTS -->
	</body>

	<!-- END BODY -->

</html>

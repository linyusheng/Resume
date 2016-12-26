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
							<!-- BEGIN 用户信息管理-->
							<div class="portlet box blue">
								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-user"></i>用户信息管理
									</div>
									<div class="actions">
										<a href="javascript:;" class="btn purple btn-sm reload" id="refresh">
											<i class="fa fa-refresh"></i> 刷新</a>
										<a href="javascript:;" class="btn blue-steel btn-sm" id="add-btn">
											<i class="fa fa-plus"></i> 添加 </a>
										<a href="javascript:;" class="btn green btn-sm" id="notices">
											<i class="fa fa-send"></i> 批量通知 </a>
										<!-- <a href="javascript:;" class="btn btn-danger btn-sm" id="deletes-btn">
											<i class="fa fa-trash-o"></i> 批量删除 </a> -->
										<div class="btn-group">
											<a class="btn btn-primary btn-sm" href="#" data-toggle="dropdown">
												<i class="fa fa-cogs"></i> 选项 <i class="fa fa-angle-down"></i>
											</a>
											<ul class="dropdown-menu pull-right">
												<li>
													<a href="javascript:;"><i class="fa fa-print"></i> 打印	</a>
												</li>
												<li>
													<a href="javascript:;"><i class="fa fa-file-pdf-o"></i> 另存为PDF</a>
												</li>
												<li>
													<a href="javascript:;"><i class="fa fa-file-excel-o"></i> 导出Excel</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="portlet-body" id="portlet-body">
									<table class="table table-striped table-bordered table-hover" id="userinfoTable">
										<thead>
											<tr>
												<th class="table-checkbox">
													<input type="checkbox" class="group-checkable" data-set="#userinfoTable .checkboxes" />
												</th>
												<th>用户名</th>
												<th>账号</th>
												<th>等级</th>
												<th>积分</th>
												<th>经验</th>
												<th>简历完整度</th>
												<th>注册状态</th>
												<th width="190">操作</th><!-- 240 -->
											</tr>
										</thead>
									</table>
								</div>
							</div>
							<!-- END 用户信息管理-->
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
		<!-- BEGIN 修改用户密码modal -->
		<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="portlet box blue" style="border: none;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-pencil"></i>修改用户(<span class="name"></span>)的密码
						</div>
						<div class="tools">
							<a class="close" href="javascript:;" data-dismiss="modal"></a>
						</div>
					</div>
					<div class="portlet-body form">
						<form role="form" id="edit-user-pwd-form">
							<div class="form-body">
								<br />
								<input type="hidden" name="uid" />
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-6">
										<div class="alert alert-warning" style="padding: 7px; margin-bottom: 0;">本操作将覆盖用户原有的密码，需谨慎！</div>
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-6">
										<span class="input-group-addon">
										<i class="fa fa-lock"></i>
										</span>
										<input type="password" class="form-control" name="newPwd" required placeholder="新密码">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-6">
										<span class="input-group-addon">
										<i class="fa fa-lock"></i>
										</span>
										<input type="password" class="form-control" name="confirmPwd" required placeholder="确认密码">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-6">
										<span class="input-group-addon">
										<i class="fa fa-lock"></i>
										</span>
										<input type="password" class="form-control" name="adminPwd" required placeholder="管理员密码">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-3">
										<button type="submit" class="btn blue">提交</button>
										<button type="button" class="btn default pull-right" data-dismiss="modal">取消</button>
										<input type="reset" style="display:none;" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- END 修改用户密码modal -->
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
										<textarea class="form-control" rows="4" cols="" required="required" maxlength="300"></textarea>
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
		<!-- BEGIN 添加用户modal -->
		<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="portlet box blue" style="border: none;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-plus"></i>添加用户
						</div>
						<div class="tools">
							<a class="close" href="javascript:;" data-dismiss="modal"></a>
						</div>
					</div>
					<div class="portlet-body form">
						<form role="form" id="add-user-form">
							<div class="form-body">
								<br />
								<div class="form-group">
									<label class="col-xs-3 control-label text-right" style="line-height: 32px;">账号</label>
									<div class="col-xs-6 input-group">
										<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
										<input type="email" name="account" class="form-control" placeholder="请输入正确的邮箱账号" required="required">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label text-right" style="line-height: 32px;">密码</label>
									<div class="col-xs-6 input-group">
										<span class="input-group-addon"><i class="fa fa-lock"></i></span>
										<input type="password" name="pwd" class="form-control" placeholder="不能少于6位" required="required">
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label text-right" style="line-height: 32px;">姓名</label>
									<div class="col-xs-6 input-group">
										<span class="input-group-addon"><i class="fa fa-user"></i></span>
										<input type="text" name="nickname" class="form-control" placeholder="用户姓名" required="required">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group col-xs-offset-3 col-xs-3">
										<button type="submit" class="btn blue">提交</button>
										<!-- <input type="submit" class="btn blue" value="提交" /> -->
										<input type="button" class="btn default pull-right" data-dismiss="modal" value="取消" />
										<input type="reset" style="display:none;" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- END 添加用户modal -->
		<!-- BEGIN 预览简历-->
		<div class="modal fade modal-scroll modal-overflow" id="previewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" id="resume"></div>
		</div>
		<!-- END 预览简历-->
		<jsp:include page="public/global-script.jsp"></jsp:include>
		<!-- BEGIN PAGE LEVEL SCRIPTS -->
		<script type="text/javascript" src="assets/global/plugins/pdfobject.js"></script>
		<script type="text/javascript" src="assets/global/plugins/jquery-tags-input/jquery.tagsinput.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/bootbox/bootbox.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
		<script src="assets/admin/pages/scripts/manage-user.js" type="text/javascript"></script>
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
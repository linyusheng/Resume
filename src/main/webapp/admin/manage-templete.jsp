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
							<!-- BEGIN 模板管理-->
							<div class="portlet box blue">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-wallet"></i>模板管理
									</div>
									<div class="actions">
										<a href="javascript:;" class="btn purple btn-sm reload" id="refresh">
											<i class="fa fa-refresh"></i> 刷新</a>
										<!--<a href="javascript:;" class="btn green btn-sm" id="add-btn">
											<i class="fa fa-plus"></i> 添加 </a>-->
										<a href="javascript:;" class="btn btn-danger btn-sm" id="deletes-btn">
											<i class="fa fa-trash-o"></i> 批量删除 </a>
										<div class="btn-group">
											<a class="btn btn-primary btn-sm" href="#" data-toggle="dropdown">
												<i class="fa fa-cogs"></i> 选项 <i class="fa fa-angle-down"></i>
											</a>
											<ul class="dropdown-menu pull-right">
												<li>
													<a href="javascript:;">
														<i class="fa fa-print"></i> 打印
													</a>
												</li>
												<li>
													<a href="javascript:;">
														<i class="fa fa-file-pdf-o"></i> 另存为PDF
													</a>
												</li>
												<li>
													<a href="javascript:;">
														<i class="fa fa-file-excel-o"></i> 导出Excel
													</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="portlet-body" id="portlet-body">
									<table class="table table-striped table-bordered table-hover" id="templeteTable">
										<thead>
											<tr>
												<th class="table-checkbox">
													<input type="checkbox" class="group-checkable" data-set="#templeteTable .checkboxes" />
												</th>
												<th>标题</th>
												<th>类型</th>
												<th>上传者</th>
												<th>文件大小</th>
												<th>是否公开</th>
												<th>下载量</th>
												<th>点击量</th>
												<th>收藏量</th>
												<th>上传时间</th>
												<th>操作</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
							<!-- END 模板管理-->
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
		<!-- BEGIN 修改modal -->
		<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="portlet box blue" style="border: none;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-pencil"></i>修改模板信息
						</div>
						<div class="tools">
							<a class="close" href="javascript:;" data-dismiss="modal"></a>
						</div>
					</div>
					<div class="portlet-body form">
						<form class="form-horizontal" role="form" id="myInfo_form">
							<input type="hidden" name="tpId" />
							<div class="form-body">
								<br />
								<div class="row">
									<div class="form-group">
										<label class="col-xs-4 control-label text-right">模板标题</label>
										<div class="col-xs-6 input-group">
											<input type="text" class="form-control" placeholder="不能为空" name="tpTitle" required="required">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-xs-4 control-label text-right">模板类型</label>
										<div class="col-xs-3 input-group">
											<select name="type.tid" class="form-control"></select>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-xs-4 control-label text-right">是否公开</label>
										<div class="col-xs-6" style="padding-top: 7px;padding-left: 0;">
											<input type="checkbox" checked />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-xs-4 control-label text-right">下载量</label>
										<div class="col-xs-2 input-group">
											<input type="text" class="form-control" name="downloadNum">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-xs-4 control-label text-right">点击量</label>
										<div class="col-xs-2 input-group">
											<input type="text" class="form-control" name="clickNum">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<label class="col-xs-4 control-label text-right">收藏量</label>
										<div class="col-xs-2 input-group">
											<input type="text" class="form-control" name="collectNum">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="form-group">
										<div class="input-group col-xs-offset-4 col-xs-3">
											<button type="submit" class="btn blue">提交</button>
											<button type="button" class="btn default pull-right" data-dismiss="modal">取消</button>
										</div>
									</div>
								</div>
								
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- END 修改modal -->
		<!-- BEGIN 预览简历-->
		<div class="modal fade modal-scroll modal-overflow" id="previewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" id="resume"></div>
		</div>
		<!-- END 预览简历-->
		<jsp:include page="public/global-script.jsp"></jsp:include>
		<!-- BEGIN PAGE LEVEL SCRIPTS -->
		<script type="text/javascript" src="assets/global/plugins/pdfobject.js"></script>
		<script type="text/javascript" src="assets/global/plugins/bootbox/bootbox.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
		<script src="assets/admin/pages/scripts/manage-templete.js" type="text/javascript"></script>
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
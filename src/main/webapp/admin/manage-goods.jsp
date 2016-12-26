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
			<div class="page-content-wrapper" ng-controller="ContentCtrl">
				<div class="page-content">
					<!-- BEGIN PAGE HEADER-->
					<div class="page-bar">
						<ul class="page-breadcrumb"></ul>
					</div>
					<!-- END PAGE HEADER-->
					<!-- BEGIN 主体内容-->
					<!-- BEGIN 放大图片 -->
					<img src="" id="bigPic" width="240" height="240" style="display: none;position: fixed;z-index: 1;"/>
					<!-- END 放大图片 -->
					<div class="row">
						<div class="col-md-12">
							<!-- BEGIN 用户信息管理-->
							<div class="portlet box blue">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-basket"></i>商城管理
									</div>
									<div class="actions">
										<a href="javascript:;" class="btn purple btn-sm reload" id="refresh">
											<i class="fa fa-refresh"></i> 刷新</a>
										<a href="javascript:;" class="btn green btn-sm" id="add-btn">
											<i class="fa fa-plus"></i> 添加 </a>
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
									<table class="table table-striped table-bordered table-hover" id="goodsTable">
										<thead>
											<tr>
												<th class="table-checkbox">
													<input type="checkbox" class="group-checkable" data-set="#goodsTable .checkboxes" />
												</th>
												<th>缩略图</th>
												<th>商品描述</th>
												<th>商品类型</th>
												<th>库存量</th>
												<th>兑换积分</th>
												<th>是否上架</th>
												<th>发布时间</th>
												<th width="180">操作</th>
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
		<!-- BEGIN 添加商品modal -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="portlet box blue" style="border: none;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-plus"></i>添加商品
						</div>
						<div class="tools">
							<a class="close" href="javascript:;" data-dismiss="modal"></a>
						</div>
					</div>
					<div class="portlet-body form">
						<form class="form-horizontal" role="form" enctype="multipart/form-data">
							<div class="form-body">
								<br />
								<div class="row form-group">
									<div class="col-xs-8 col-xs-offset-2">
										<div class="input-group">
											<span class="input-group-addon">描述</span>
											<input type="text" class="form-control" name="gname" required="required">
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-10 col-xs-offset-2">
										<div class="input-group">
											<div class="fileinput fileinput-new" data-provides="fileinput">
												<div class="input-group input-large">
													<span class="input-group-addon">图片</span>
													<div class="form-control uneditable-input span3" data-trigger="fileinput">
														<i class="fa fa-file fileinput-exists"></i>&nbsp; 
														<span class="fileinput-filename"></span>
													</div>
													<span class="input-group-addon btn default btn-file">
														<span class="fileinput-new">选择文件</span>
														<span class="fileinput-exists"> 更改 </span>
														<input type="file" name="file" required="required">
													</span>
													<a href="#" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> 移除 </a>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-4 col-xs-offset-2">
										<div class="input-group">
											<span class="input-group-addon">类型</span>
											<select name="tid" class="form-control"></select>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">上架</span>
											<select name="isShow" class="form-control">
												<option value="1">是</option>
												<option value="0">否</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-4 col-xs-offset-2 ">
										<div class="input-group">
											<span class="input-group-addon">库存</span>
											<input type="number" class="form-control" name="gnum" required="required">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">积分</span>
											<input type="number" class="form-control" name="gpoint" required="required">
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-2 col-xs-offset-2">
										<button type="submit" class="btn blue">保存 </button>
										<input type="reset" style="display:none;" />
									</div>
									<div class="col-xs-2">
										<button type="button" class="btn default pull-right" data-dismiss="modal">取消</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- END 添加商品modal -->
		<!-- BEGIN 修改商品modal -->
		<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="portlet box blue" style="border: none;">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-pencil"></i>修改商品信息
						</div>
						<div class="tools">
							<a class="close" href="javascript:;" data-dismiss="modal"></a>
						</div>
					</div>
					<div class="portlet-body form">
						<form class="form-horizontal" role="form" enctype="multipart/form-data">
							<input type="hidden" name="gid">
							<div class="form-body">
								<br />
								<div class="row form-group">
									<div class="col-xs-8 col-xs-offset-2">
										<div class="input-group">
											<span class="input-group-addon">描述</span>
											<input type="text" class="form-control" name="gname" required="required">
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-10 col-xs-offset-2">
										<div class="input-group">
											<div class="fileinput fileinput-new" data-provides="fileinput">
												<div class="input-group input-large">
													<span class="input-group-addon">图片</span>
													<div class="form-control uneditable-input span3" data-trigger="fileinput">
														<i class="fa fa-file fileinput-exists"></i>&nbsp; 
														<span class="fileinput-filename"></span>
													</div>
													<span class="input-group-addon btn default btn-file">
														<span class="fileinput-new">选择文件</span>
														<span class="fileinput-exists"> 更改 </span>
														<input type="file" name="file">
													</span>
													<a href="#" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput"> 移除 </a>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-4 col-xs-offset-2">
										<div class="input-group">
											<span class="input-group-addon">类型</span>
											<select name="tid" class="form-control"></select>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">上架</span>
											<select name="isShow" class="form-control">
												<option value="1">是</option>
												<option value="0">否</option>
											</select>
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-4 col-xs-offset-2 ">
										<div class="input-group">
											<span class="input-group-addon">库存</span>
											<input type="number" class="form-control" name="gnum" required="required">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">积分</span>
											<input type="number" class="form-control" name="gpoint" required="required">
										</div>
									</div>
								</div>
								<div class="row form-group">
									<div class="col-xs-2 col-xs-offset-2">
										<button type="submit" class="btn blue">保存 </button>
										<input type="reset" style="display:none;" />
									</div>
									<div class="col-xs-2">
										<button type="button" class="btn default pull-right" data-dismiss="modal">取消</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- END 修改商品modal -->
		<jsp:include page="public/global-script.jsp"></jsp:include>
		<!-- BEGIN PAGE LEVEL SCRIPTS -->
		<script type="text/javascript" src="assets/global/plugins/bootbox/bootbox.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
		<script src="assets/admin/pages/scripts/manage-goods.js" type="text/javascript"></script>
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
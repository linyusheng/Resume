<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- BEGIN 个人信息modal -->
<div class="modal fade" id="myInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="portlet box blue" style="border: none;">
			<div class="portlet-title">
				<div class="caption">
					<i class="fa fa-user"></i>个人信息
				</div>
				<div class="tools">
					<a class="close" href="javascript:;" data-dismiss="modal"></a>
				</div>
			</div>
			<div class="portlet-body form">
				<form role="form" enctype="multipart/form-data">
					<div class="form-body">
						<br />
						<div class="row form-group">
							<label class="col-xs-3 control-label text-right" style="line-height: 32px;">邮箱账号</label>
							<div class="col-xs-6 input-group">
								<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
								<input type="text" class="form-control" name="account" placeholder="账号" value="${admin.account }" readonly="readonly">
							</div>
						</div>
						<div class="row form-group">
							<label class="col-xs-3 control-label text-right" style="line-height: 32px;">真实姓名</label>
							<div class="col-xs-6 input-group">
								<span class="input-group-addon">
								<i class="fa fa-user"></i>
								</span>
								<input type="text" class="form-control" name="nickname" placeholder="真实姓名" value="${admin.nickname }">
							</div>
						</div>
						<div class="row form-group">
							<label class="col-xs-3 control-label text-right" style="line-height: 32px;">修改头像</label>
							<div class="fileinput fileinput-new" data-provides="fileinput">
								<div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 200px; height: 150px;"></div>
								<div>
									<span class="btn default btn-file">
										<span class="fileinput-new">选择图片</span>
										<span class="fileinput-exists">更改</span>
										<input type="file" name="file">
									</span>
									<a href="#" class="btn red fileinput-exists" data-dismiss="fileinput">删除</a>
								</div>
							</div>
						</div>
						<div class="row form-group">
							<div class="input-group col-xs-offset-3 col-xs-3">
								<button type="submit" class="btn blue">提交</button>
								<button type="button" class="btn default pull-right" data-dismiss="modal">取消</button>
								<!-- <input type="reset" id="reset" style="display:none;" /> -->
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- END 个人信息modal -->
<!-- BEGIN 修改密码modal -->
<div class="modal fade" id="modifyPwdModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="portlet box blue" style="border: none;">
			<div class="portlet-title">
				<div class="caption">
					<i class="fa fa-pencil"></i>修改密码
				</div>
				<div class="tools">
					<a class="close" href="javascript:;" data-dismiss="modal"></a>
				</div>
			</div>
			<div class="portlet-body form">
				<form role="form">
					<div class="form-body">
						<br />
						<div class="form-group">
							<div class="input-group col-xs-offset-3 col-xs-6">
								<span class="input-group-addon">
								<i class="fa fa-lock"></i>
								</span>
								<input type="password" class="form-control" name="oldPsd" required placeholder="原密码">
							</div>
						</div>
						<div class="form-group">
							<div class="input-group col-xs-offset-3 col-xs-6">
								<span class="input-group-addon">
								<i class="fa fa-lock"></i>
								</span>
								<input type="password" class="form-control" name="newPsd" required placeholder="新密码">
							</div>
						</div>
						<div class="form-group">
							<div class="input-group col-xs-offset-3 col-xs-6">
								<span class="input-group-addon">
								<i class="fa fa-lock"></i>
								</span>
								<input type="password" class="form-control" name="confirmPsd" required placeholder="确认密码">
							</div>
						</div>
						<div class="form-group">
							<div class="input-group col-xs-offset-3 col-xs-3">
								<button type="submit" class="btn blue">提交</button>
								<button type="button" class="btn default pull-right" data-dismiss="modal">取消</button>
								<input type="reset" class="reset" style="display:none;" />
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- END 修改密码modal -->
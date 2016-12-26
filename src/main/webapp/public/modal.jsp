<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${user==null}">

<!-- 登陆，注册，注册成功，忘记密码，忘记密码提示 -->
<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<!-- 登录框 -->
		<div class="modal-content" ng-show="modalView == 'login'">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">登&nbsp;&nbsp;录</h4>
			</div>
			<div class="modal-body">
				<div class="modal-user-left">
					<form id="form-user-login" name="userLogin" novalidate>
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<i class="fa fa-lg fa-user fa-fw"></i>
									<input name="email" type="text" placeholder="请输入登录邮箱" ng-model="email" class="form-control" required autofill />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<i class="fa fa-lg fa-lock fa-fw"></i>
									<input name="password" type="password" placeholder="请输入密码" ng-model="password" class="form-control" required autofill />
								</div>
							</div>
						</div>
						<div class="row">
							<h5 class="col-xs-12 text-muted remove margin top">
                                <a href="javascript:void(0)" class="pull-left" ng-click="toggleRememberPassword()">
                                    <i class="fa" ng-class="rememberPassword?'fa-check-square':'fa - square'"></i> 记住我</a>
                                <a href="javascript:void(0)" class="pull-right" ng-click="switchView('forgetPassword')">忘记密码？</a>
                            </h5>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<h5 class="text-danger" ng-bind="errorMessage"></h5>
							</div>
							<div class="col-xs-6">
								<button class="btn btn-success btn-block" ng-click="login()" data-btn-loading="loading" data-loading-text="正在登录">登&nbsp;&nbsp;录</button>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-user-right">
					<h5 class="text-muted">我还没有账号</h5>
					<button class="btn btn-danger btn-block modal-topbutton" ng-click="switchView('register')">免费注册</button>
					<h5 class="text-muted">我是管理员</h5>
					<a href="admin" class="btn btn-warning btn-block">后台入口</a>
				</div>
			</div>
		</div>
		<!-- 注册框 -->
		<div class="modal-content" ng-show="modalView == 'register'">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">注&nbsp;&nbsp;册</h4>
			</div>
			<div class="modal-body">
				<div class="modal-user-left">
					<form id="form-user-register" name="userRegister" novalidate>
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<i class="fa fa-lg fa-user fa-fw"></i>
									<input name="email" type="text" placeholder="请输入注册邮箱" ng-model="email" class="form-control" required autofill />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-7">
								<div class="form-group">
									<i class="fa fa-lg fa-tasks fa-fw"></i>
									<input name="verifyCode" type="text" placeholder="请输入验证码" ng-model="code" class="form-control" required autocomplete="off" />
								</div>
							</div>
							<div class="col-xs-5">
								<a href="javascript:void(0)" title="点击更换验证码" ng-click="refreshVerifyCode()">
									<img class="verify-code" data-baseurl="./user/verifyCode" /></a>
							</div>
						</div>
						<div class="row">
							<h5 class="col-xs-12 text-muted remove margin top">注册后可享受为你提供的更多功能哦！</h5>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<h5 class="text-danger" ng-bind="errorMessage"></h5>
							</div>
							<div class="col-xs-6">
								<button class="btn btn-danger btn-block" ng-click="register()" data-btn-loading="loading" data-loading-text="正在注册">注&nbsp;&nbsp;册</button>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-user-right">
					<h5 class="text-muted">我已有账号</h5>
					<button class="btn btn-success btn-block modal-topbutton" ng-click="switchView('login')">立即登录</button>
					<h5 class="text-muted">我是管理员</h5>
					<a href="admin" class="btn btn-warning btn-block">后台入口</a>
				</div>
			</div>
		</div>

		<!-- 注册成功 -->
		<div class="modal-content" ng-show="modalView == 'registerNotice'">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">注&nbsp;&nbsp;册</h4>
			</div>
			<div class="modal-body">
				<div class="modal-user-left">
					<h5 style="display: inline-block">我们已经向</h5>
					<h4 class="text-success" style="display: inline-block" ng-bind="email"> </h4>

					<h5>发送了验证邮件</h5>
					<p>登录邮箱并点击验证链接即可继续注册</p>
					<a class="btn btn-success btn-block" ng-href="{{openMailUrl}}" target="_blank"><i class="fa fa-envelope"></i> &nbsp;登录邮箱验证</a>
				</div>
				<div class="modal-user-right">
					<h5>没有收到激活邮件？</h5>
					<p><i class="fa fa-circle text-warning"></i> 尝试到垃圾邮件、广告邮件目录找找看</p>
					<p><i class="fa fa-circle text-warning"></i> 您QQ邮箱设置了反垃圾拒收，可暂时关闭</p>
					<p><i class="fa fa-circle text-warning"></i> 拼写有误？<a href="javascript:void(0)" ng-click="switchView('register')">换个邮箱</a></p>
					<p><i class="fa fa-circle text-warning"></i> 换了邮箱依旧没有收到？<a href="http://wpa.qq.com/msgrd?v=3&uin=2275755329&site=qq&menu=yes" target="_blank">联系客服</a></p>
				</div>
			</div>
		</div>

		<!-- 忘记密码表单 -->
		<div class="modal-content" ng-show="modalView == 'forgetPassword'">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">忘记密码</h4>
			</div>
			<div class="modal-body">
				<div class="modal-user-left">
					<form id="form-user-register" name="userForgetPassword" novalidate>
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<i class="fa fa-lg fa-user fa-fw"></i>
									<input name="email" type="text" placeholder="请输入注册邮箱" ng-model="email" class="form-control" required autofill />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-7">
								<div class="form-group">
									<i class="fa fa-lg fa-tasks fa-fw"></i>
									<input name="verifyCode" type="text" placeholder="请输入验证码" ng-model="code" class="form-control" required autocomplete="off" />
								</div>
							</div>
							<div class="col-xs-5">
								<a href="javascript:void(0)" title="点击更换验证码" ng-click="refreshVerifyCode()">
									<img class="verify-code" data-baseurl="./user/verifyCode" /></a>
							</div>
						</div>
						<div class="row">
							<h5 class="col-xs-12 text-muted remove margin top">
								通过邮箱来重置密码。
                                <a href="javascript:void(0)" class="pull-right" ng-click="switchView('login')">返回登录</a>
                            </h5>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<h5 class="text-danger" ng-bind="errorMessage"></h5>
							</div>
							<div class="col-xs-6">
								<button class="btn btn-danger btn-block" ng-click="forgetPassword()" data-btn-loading="loading" data-loading-text="正在处理">重置密码</button>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-user-right">
					<div class="modal-user-right">
						<h5 class="text-muted">我还没有账号</h5>
						<button class="btn btn-danger btn-block modal-topbutton" ng-click="switchView('register')">免费注册</button>
						<h5 class="text-muted">我是管理员</h5>
						<a href="admin" class="btn btn-warning btn-block">后台入口</a>
					</div>
				</div>
			</div>
		</div>
		<!-- 忘记密码提示 -->
		<div class="modal-content" ng-show="modalView == 'forgetPasswordNotice'">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">忘记密码</h4>
			</div>
			<div class="modal-body" id="modal-body">
				<div class="modal-user-left">
					<h5 style="display: inline-block">我们已经向</h5>
					<h4 class="text-success" style="display: inline-block" ng-bind="email"> </h4>

					<h5>发送了验证邮件</h5>
					<p>登录邮箱并点击验证链接即可重置密码</p>
					<a class="btn btn-success btn-block" ng-href="{{openMailUrl}}" target="_blank"><i class="fa fa-envelope"></i> &nbsp;登录邮箱验证</a>
				</div>
				<div class="modal-user-right">
					<h5>没有收到激活邮件？</h5>
					<p><i class="fa fa-circle text-warning"></i> 尝试到垃圾邮件、广告邮件目录找找看</p>
					<p><i class="fa fa-circle text-warning"></i> 您QQ邮箱设置了反垃圾拒收，可暂时关闭</p>
					<p><i class="fa fa-circle text-warning"></i> 拼写有误？<a href="javascript:void(0)" ng-click="switchView('register')">换个邮箱</a></p>
					<p><i class="fa fa-circle text-warning"></i> 换了邮箱依旧没有收到？<a href="http://wpa.qq.com/msgrd?v=3&uin=2275755329&site=qq&menu=yes" target="_blank">联系客服</a></p>
				</div>
			</div>
		</div>
	</div>
</div>

</c:if>

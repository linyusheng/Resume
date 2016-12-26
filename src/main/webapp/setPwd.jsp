<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title>简历网-设置密码</title>
	<link rel="stylesheet" type="text/css" href="assets/css/base.min.css">
	<style type="text/css">
		body{background-color: #999;}
		#userModal .modal-body{padding: 30px 125px 40px !important;}
		#userModal .modal-user-left{border:0;}
		
	</style>
  </head>
  
  <body ng-app="App" ng-controller="formCtrl">
	<div class="modal fade in" id="userModal" tabindex="-1" role="dialog" aria-hidden="false" style="display: block;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">设置密码</h4>
				</div>
				<div class="modal-body">
					<div class="modal-user-left">
						<form id="form-user-login" name="userLogin" novalidate="" class="ng-pristine ng-invalid ng-invalid-required">
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<i class="fa fa-lg fa-lock fa-fw"></i>
										<input name="password" type="password" placeholder="请输入新密码" ng-model="password" class="form-control ng-pristine ng-invalid ng-invalid-required" required="" autofill="">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="form-group">
										<i class="fa fa-lg fa-lock fa-fw"></i>
										<input name="newPassword" type="password" placeholder="请输入确认密码" ng-model="newPassword" class="form-control ng-pristine ng-invalid ng-invalid-required" required="" autofill="">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<button class="btn btn-success btn-block" ng-click="commit()" data-btn-loading="loading" data-loading-text="正在提交">确&nbsp;&nbsp;定</button>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<h5 class="text-danger ng-binding" ng-bind="errorMessage"></h5>
								</div>
							</div>
							<data class="hide" id="email">${email}</data>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
  	<script type="text/javascript" src="assets/js/angular.min.js"></script>
  	<script type="text/javascript">
  		var app = angular.module('App',[]);
  		app.controller('formCtrl',['$scope','$http',function($scope,$http){
  			$scope.password = '',$scope.newPassword = '';
  			$scope.commit = function(){
	  			if( $scope.userLogin.password.$setValidity("length",$scope.password.length >= 6),
	  				$scope.userLogin.password.$setValidity("equals",$scope.password == $scope.newPassword),
	  				$scope.userLogin.$valid){
	  				var data = {};
	  				data.email = document.getElementById("email").innerText;
	  				data.password = $scope.password;
	  				$http.post('user/setPwd',data).success(function(d){
	  					console.info(d);
	  					d.state == "success" ? location.href = d.returnUrl : $scope.errorMessage="* 密码设置失败";
	  				});
	  			}else{
	  				$scope.userLogin.password.$error.required ? $scope.errorMessage="* 密码不能为空" : 
	  				$scope.userLogin.newPassword.$error.required ? $scope.errorMessage="* 确认密码不能为空" : 
	  				$scope.userLogin.password.$error.length ? $scope.errorMessage="* 密码长度不能小于6位" : 
	  				$scope.userLogin.password.$error.equals ? $scope.errorMessage="* 密码和确认密码不一致" : $scope.errorMessage="";
	  			}
  			};
  		}]);
  	</script>
  </body>
</html>

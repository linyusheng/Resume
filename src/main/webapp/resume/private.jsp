<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en" class="no-js ng-app:App" ng-app="App" id="ng-app">

	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" cotent="IE=edge,chrome=1" />
		<meta name="renderer" content="webkit">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<title>个人设置 - 简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="css/main.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
			
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>
			
			<div id="page-wrapper">
				<div id="kz-web" class="fadeIn animated">
					
					<jsp:include page="../public/logoutTip.jsp"></jsp:include>
					
					<c:if test="${user != null}">
						<div class="row">
							<div class="page-header">
								<h3 class="heading">
									<i class="fa fa-pencil-square"></i>个人设置
								</h3>
								<p>修改个人账号密码，设置行业、职位、目标城市等工作意向</p>
							</div>
						</div>
						<data class="hide" id="personalInfo">${personalInfo}</data>
<!-- 						{"uid":"277874","uname":"林玉生","sex":"0","university":"1423","education":"3","degree":"1","major":"1","graduation":"2016","trade":"1:4","position":"4","city":"288;269;270","email":"2275755329@qq.com"} -->
						<div class="row">
						    <div class="col-lg-9">
						        <div class="panel panel-default">
						            <div class="panel-heading">账号信息</div>
						            <form name="modifyPassword" role="form" ng-controller="modifyPasswordController" ng-class="{'submitted':submitted}" novalidate >
						                <div class="panel-body form-horizontal">
						                    <div class="form-group">
						                        <label for="input-email" class="fixed-width control-label">登录邮箱</label>
						                        <div class="col-xs-6">
						                            <div class="input-group">
						                                <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw-small"></i></span>
						                                <span class="form-control" disabled ng-bind="email" />
						                            </div>
						                        </div>
						                        <h5 class="col-xs-2 toggle in modify-password">
						                            <a class="dropdown-toggle" data-toggle="collapse" href=".modify-password">修改密码</a>
						                        </h5>
						                    </div>
						                    <div class="collapse modify-password">
						                        <div class="form-group">
						                            <label for="input-password" class="fixed-width control-label">原始密码</label>
						                            <div class="col-xs-6">
						                                <div class="input-group">
						                                    <span class="input-group-addon"><i class="fa fa-key fa-fw-small"></i></span>
						                                    <input name="oldPassword" type="password" password-correct class="form-control" required
						                                           ng-model="value.oldPassword" />
						                                </div>
						                            </div>
						                            <h5 class="col-xs-4">
						                                <span class="text-danger" ng-show="submitted && modifyPassword.oldPassword.$error.required"
						                                      ng-bind="errors.passwordRequired"></span>
						                                <span class="text-danger" ng-show="!modifyPassword.oldPassword.$error.required && modifyPassword.oldPassword.$error.correct"
						                                      ng-bind="errors.passwordCorrect"></span>
						                            </h5>
						                        </div>
						                        <div class="form-group">
						                            <label for="input-password" class="fixed-width control-label">新密码</label>
						                            <div class="col-xs-6">
						                                <div class="input-group">
						                                    <span class="input-group-addon"><i class="fa fa-key fa-fw-small"></i></span>
						                                    <input name="newPassword" type="password" password-strength class="form-control" required
						                                           data-toggle="tooltip" data-placement="bottom" title="密码为6-20位数字、字母或符号"
						                                           ng-model="value.newPassword" />
						                                </div>
						                            </div>
						                            <h5 class="col-xs-4">
						                                <span class="margin right ng-hide" ng-show="modifyPassword.newPassword.$dirty">
						                                    <i class="fa fa-lock fa-lg" ng-class="strength>=3 ? 'text-success' : (strength >= 2 ? 'text-warning' : 'text-danger') "></i>
						                                    <i class="fa fa-lock fa-lg" ng-class="strength>=3 ? 'text-success' : (strength >= 2 ? 'text-warning' : 'text-muted') "></i>
						                                    <i class="fa fa-lock fa-lg" ng-class="strength>=3 ? 'text-success' : 'text - muted' "></i>
						                                </span>
						                                <span class="text-danger ng-hide" ng-show="submitted && modifyPassword.newPassword.$error.required"
						                                      ng-bind="errors.passwordRequired"></span>
						                                <span class="text-danger" ng-show="!modifyPassword.newPassword.$error.required && modifyPassword.newPassword.$error.strength"
						                                      ng-bind="errors.passwordStrength"></span>
						                            </h5>
						                        </div>
						                        <div class="form-group">
						                            <label for="input-confirm-password" class="fixed-width control-label">确认密码</label>
						                            <div class="col-xs-6">
						                                <div class="input-group">
						                                    <span class="input-group-addon"><i class="fa fa-key fa-fw-small"></i></span>
						                                    <input name="confirmPassword" type="password" password-match class="form-control" required ng-model="value.confirmPassword"/>
						                                </div>
						                            </div>
						                            <h5 class="col-xs-4">
						                                <span class="text-danger" ng-show="submitted && modifyPassword.confirmPassword.$error.required"
						                                      ng-bind="errors.confirmPasswordRequired"></span>
						                                <span class="text-danger" ng-show="modifyPassword.confirmPassword.$dirty && !modifyPassword.confirmPassword.$error.required && modifyPassword.confirmPassword.$error.match"
						                                      ng-bind="errors.confirmPasswordMatch"></span>
						                            </h5>
						                        </div>
						                        <div class="row">
						                            <div class="col-xs-3">
						                                <a href="javascript:void(0)" class="btn btn-success pull-right" ng-click="submit()">修改密码</a>
						                            </div>
						                            <div class="col-xs-3">
						                                <h5>
						                                    <a href=".modify-password" class="dropdown-toggle" data-toggle="collapse">取消</a>
						                                </h5>
						                            </div>
						                            <h5 class="col-xs-6 text-danger" ng-bind="errorMessage"></h5>
						                        </div>
						                    </div>
						                </div>
						            </form>
						        </div>
						
						        <div class="panel panel-default">
						            <div class="panel-heading">基本信息</div>
						            <div class="panel-body form-horizontal" ng-controller="basicInfoController">
						                <div class="row">
						                    <div class="col-xs-6 col-xl-4">
						                        <div class="form-group">
						                            <label for="input-uname" class="fixed-width control-label">姓名</label>
						                            <div class="fixed-width">
						                                <input name="name" type="text" class="form-control" disabled ng-model="name" />
						                            </div>
						                        </div>
						                    </div>
						
						                    <div class="col-xs-6 col-xl-4">
						                        <div class="form-group">
						                            <label for="input-sex" class="fixed-width control-label">性别</label>
						                            <div class="fixed-width">
						                                <a href="javascript:void(0);" class="btn disabled"
						                                   ng-class="{'btn-success':sex == 1,'btn-default':sex != 1}">男</a>
						                                <a href="javascript:void(0);"  class="btn disabled"
						                                   ng-class="{'btn-success':sex == 2,'btn-default':sex != 2}">女</a>
						                            </div>
						                        </div>
						                    </div>
						
						                    <div class="col-xs-6 col-xl-4">
						                        <div class="form-group">
						                            <label for="input-university" class="fixed-width control-label">毕业院校</label>
						                            <div class="fixed-width">
						                                <input name="university" type="text" class="form-control" disabled ng-model="university" />
						                            </div>
						                        </div>
						                    </div>
						
						                    <div class="col-xs-6 col-xl-4">
						                        <div class="form-group">
						                            <label for="input-education" class="fixed-width control-label">学历</label>
						                            <div class="fixed-width">
						                                <input name="education" type="text" class="form-control" disabled ng-model="education" />
						                            </div>
						                        </div>
						                    </div>
						
						                    <div class="col-xs-6 col-xl-4">
						                        <div class="form-group">
						                            <label for="input-major" class="fixed-width control-label">专业</label>
						                            <div class="fixed-width">
						                                <input name="major" type="text" class="form-control" disabled ng-model="major" />
						                            </div>
						                        </div>
						                    </div>
						                    <div class="col-xs-6 col-xl-4">
						                        <div class="form-group">
						                            <label for="input-graduation" class="fixed-width control-label">毕业年份</label>
						                            <div class="fixed-width">
						                                <input name="graduation" type="text" class="form-control" disabled ng-model="graduation" />
						                            </div>
						                        </div>
						                    </div>
						                    <h5 class="col-xs-offset-1">注：在 <a href="resume/get">我的简历</a> 中可以修改个人基本信息。</h5>
						                </div>
						            </div>
						        </div>
						
						        <div class="panel panel-default">
						            <div class="panel-heading">工作意向</div>
						            <form name="workIntent" role="form" ng-controller="workIntentController" ng-class="{'submitted':submitted}" novalidate >
						                <div class="panel-body form-horizontal">
						                    <div class="form-group">
						                        <label for="input-trade" class="fixed-width control-label">行业</label>
						                        <div class="col-xs-8" ng-controller="tradeList">
						                            <span class="form-control dropdown-toggle" myrequired data-toggle="dropdown" ng-model="displayValue" ng-bind="displayValue"></span>
						                            <div class="dropdown-menu dropup dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close" role="menu">
						                                <div class="selected-box">
						                                    <span ng-repeat="item in selectedItems">{{item.name}}
						                                        <a href="javascript:void(0);" ng-click="click(item, $event)"><i class="fa fa-times"></i></a></span>
						                                </div>
						                                <div class="item-box">
						                                    <div class="row" ng-repeat="cate in list">
						                                        <h5 class="col-xs-2 text-success text-right remove padding right">{{cate.title}}</h5>
						                                        <div class="col-xs-10 btn-fluid-list">
						                                            <span class="width-split-4" ng-repeat="item in cate.items">
						                                                <a href="javascript:void(0);" class="btn" ng-class="{'selected':isSelected(item)}"
						                                                   ng-click="click(item, $event)" ng-bind="item.name"></a>
						                                            </span>
						                                        </div>
						                                    </div>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="form-group">
						                        <label for="input-position" class="fixed-width control-label">职位</label>
						                        <div class="col-xs-8" ng-controller="positionList">
						                            <span class="form-control dropdown-toggle" myrequired data-toggle="dropdown" ng-model="displayValue" ng-bind="displayValue"></span>
						                            <div class="dropdown-menu dropup dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close" role="menu">
						                                <div class="selected-box">
						                                    <span ng-repeat="item in selectedItems">{{item.name}}
						                                        <a href="javascript:void(0);" ng-click="click(item, $event)"><i class="fa fa-times"></i></a></span>
						                                </div>
						                                <div class="item-box btn-fluid-list">
						                                    <span class="width-split-4" ng-repeat="item in list">
						                                        <a href="javascript:void(0);" class="btn" ng-class="{'selected':isSelected(item)}"
						                                           ng-click="click(item, $event)" ng-bind="item.name"></a>
						                                    </span>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="form-group">
						                        <label for="input-city" class="fixed-width control-label">目标城市</label>
						                        <div class="col-xs-8" ng-controller="cityList">
						                            <span class="form-control dropdown-toggle" myrequired data-toggle="dropdown" ng-model="displayValue" ng-bind="displayValue"></span>
						                            <div class="dropdown-menu dropup dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close" role="menu">
						                                <div class="selected-box">
						                                    <span ng-repeat="item in selectedItems">{{item.name}}
						                                        <a href="javascript:void(0);" ng-click="click(item, $event)"><i class="fa fa-times"></i></a></span>
						                                </div>
						                                <div class="item-box">
						                                    <div class="row" ng-repeat="cate in list">
						                                        <h5 class="col-xs-2 text-success text-right">{{cate.title}}</h5>
						                                        <div class="col-xs-10 btn-fluid-list">
						                                            <span class="width-split-6" ng-repeat="item in cate.items">
						                                                <a href="javascript:void(0);" class="btn" ng-class="{'selected':isSelected(item)}"
						                                                   ng-click="click(item, $event)" ng-bind="item.name"></a>
						                                            </span>
						                                        </div>
						                                    </div>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                    <div class="row" ng-show="workIntent.$dirty">
						                        <div class="col-xs-3">
						                            <a href="javascript:void(0)" class="btn btn-success pull-right" ng-click="submit()">确认修改</a>
						                        </div>
						                        <div class="col-xs-3">
						                            <h5>
						                                <a href="javascript:void(0)" ng-click="reset()">取消</a>
						                            </h5>
						                        </div>
						                        <h5 class="col-xs-6 text-danger" ng-bind="errorMessage"></h5>
						                    </div>
						                </div>
						        </div>
						    </div>
						</form>
						</div>
					</c:if>
					
					<jsp:include page="../public/footer.jsp"></jsp:include>
					<jsp:include page="../public/modal.jsp"></jsp:include>
					
				</div>
			</div>
			
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="js/private.js"></script>
	</body>

</html>
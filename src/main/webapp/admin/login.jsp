<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title>简历网</title>
		<link rel="stylesheet" type="text/css" href="css/font-awesome/style.css"/>
		<link rel="stylesheet" type="text/css" href="css/animate.min.css">
		<link rel="stylesheet" type="text/css" href="css/login.css" />
		<script type="text/javascript" src="js/jquery.min.js" ></script>
		<script>
			$(function(){
				$('#account,#password').focus(function(){
					$('#container').removeClass("animated tada fadeInDown");
					$('.msg').html("");
				});
				$('form').submit(function(){
					$('#submit').val('登录...');
					$.post('admin/login', $('form').serialize(), function(r) {
						if (r.state == 'success') {
							location.href = r.returnUrl;
						} else {
							$('#submit').val('登录');
							$('#container').removeClass("animated tada fadeInDown").addClass('animated tada');
							$('.msg').html(r.exception);
						}
					});
					return false;
				});
			});
		</script>
	</head>

	<body>
		<div class="loginbox pop_fadein animated fadeInDown" id="container">
			<div class="title">
				<div class="logo">简历网后台管理系统</div>
				<div class='info'>—— V1.0</div>
			</div>
			<form>
				<div class="inputs">
					<div>
						<span><i class="icon-user"></i></span>
						<input id="account" name='account' type="text" placeholder="账号" required/> 
					</div>
					<div>
						<span><i class="icon-lock"></i></span>
						<input id="password" name='password' type="password" placeholder="密码" required />
					</div>
				</div>
				<div class="actions">
					<input type="submit" id="submit" value="登录" />
				</div>
				<div class="msg"></div>
				<div style="clear:both;"></div>
				<div class='guest'>
					<a href="./">返回简历网<i class='icon-arrow-right'></i></a>
				</div>
			</form>
		</div>
		<a href=""></a>
	</body>

</html>
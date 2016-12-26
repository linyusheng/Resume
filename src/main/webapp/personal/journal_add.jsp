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
		<title>日志空间 - 简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="assets/bootstrap-summernote/summernote.css" rel="stylesheet">
		<link href="css/main.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
			
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>
			
			<div id="page-wrapper" style="background-color: #fff;">
				<div id="kz-web" class="fadeIn animated">
					
					<jsp:include page="../public/logoutTip.jsp"></jsp:include>
					
					<c:if test="${user != null}">
						<div class="row">
                        	<div class="col-sm-10">
		                        <h3 class="heading"><i class="fa fa-tags"></i>日志空间——写日志</h3>
		                        <p>将你的简历编写心得记录在日志空间中，分享给更多有需要的人</p>
		                    </div>
		                    <div class="col-sm-2">
		                    	<a href="journal" class="btn btn-success btn-lg" style="margin-top:22px;"><i class="fa fa-list"></i> 我的日志</a>
		                    </div>
            			</div>
            			<hr>
						<div class="journalEdit">
							<form id="journalForm" action="journal/add" enctype="multipart/form-data" method="post">
								<div class="row">
									<div class="col-xs-2 text-right">标题</div>
									<div class="col-xs-6">
										<input class="form-control" type="text" name="title" required="required">
									</div>
								</div>
								<div class="row">
									<div class="col-xs-2 text-right">封面</div>
									<div class="col-xs-6">
										<div class="input-group">
											<input class="form-control" type="text" id="filename" readonly="readonly" onclick="$('#file').click()">
											<span class="input-group-btn">
												<button class="btn btn-success" onclick="$('#file').click()">选择文件</button>
											</span>
											<input id="file" name="file" type="file" class="hide" onchange="$('#filename').val($(this).val())">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-2 text-right">正文</div>
									<div class="col-xs-9">
										<div class="summernote"></div>
										<textarea class="hide" id="content" name="content"></textarea>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-2 text-right"></div>
									<div class="col-xs-9">
										<input type="submit" class="btn btn-success" value="发表">
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
		<script src="assets/bootstrap-summernote/summernote.min.js"></script>
		<script type="text/javascript">
		    $('#kz-web').scroll(function(){
	            if($('#kz-web').scrollTop() > ($('#preach-head').height()-15)){
                    $('.alert-nav').css(
                            'top', $('#kz-web').scrollTop() - $('#preach-head').height() + 15
                    );
	            }
	            else {
                    $('.alert-nav').css('top', 0);
	            }
		    });
		    $(function(){
				$('.summernote').summernote({
					height :300
				});
				$('#journalForm').submit(function(){
					var v = $('.summernote').code();
					$('#content').html(v);
				});
			});
		</script>
	</body>

</html>
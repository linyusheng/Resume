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
		<link href="assets/css/timeline.css" rel="stylesheet">
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
		                        <h3 class="heading"><i class="fa fa-tags"></i>日志空间——我的日志</h3>
		                        <p>将你的简历编写心得记录在日志空间中，分享给更多有需要的人</p>
		                    </div>
		                    <div class="col-sm-2">
		                    	<a href="journal/write" class="btn btn-success btn-lg" style="margin-top:22px;"><i class="fa fa-edit"></i> 写日志</a>
		                    </div>
            			</div>
            			<hr>
						<!-- BEGIN PAGE CONTENT-->
						<div class="row" ng-controller="journalCtrl">
							<div class="col-md-12">
								<ul class="timeline">
									<li ng-repeat="j in journals" ng-class="{'timeline-noline':journals.length == $index+1}" class="{{colors[$index % 6]}}">
										<div class="timeline-time">
											<span class="date">{{j.time | date:'yyyy/MM/dd'}} </span>
											<span class="time">{{j.time | date:'HH:mm'}} </span>
										</div>
										<div class="timeline-icon">
											<i class="fa fa-bookmark"></i>
										</div>
										<div class="timeline-body">
											<h2><a href="journal/detail?id={{j.jid}}">{{j.title}}</a></h2>
											<div class="timeline-content">
												<img class="timeline-img pull-left" ng-src="{{j.url}}" alt="" width="75" height="75">
												{{j.content}}
											</div>
											<div class="timeline-footer">
												<ul class="list-inline">
													<li>
														<i class="fa fa-thumbs-o-up"></i>
														<a ng-if="j.praiseNum == ''" class="nav-link">0 个赞 </a>
														<a ng-if="j.praiseNum != ''" class="nav-link">{{j.praiseNum.split(',').length}} 个赞 </a>
													</li>
													<li>
														<i class="fa fa-comments"></i>
														<a href="#" class="nav-link">{{j.jcomments.length}} 人评论 </a>
													</li>
													<li class="pull-right">
														<a href="journal/detail?id={{j.jid}}" class="nav-link pull-right">
															查看详情 <i class="fa fa-arrow-circle-right"></i>
														</a>
													</li>
												</ul>
												
											</div>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<!-- END PAGE CONTENT-->
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
		<script type="text/javascript">
			App.controller('journalCtrl', ['$scope','$http', function($scope,$http) {
				$scope.colors = ['timeline-blue','timeline-yellow','timeline-green','timeline-grey','timeline-red','timeline-purple'];
				$scope.journals = [];
				$('.la-ball-spin-clockwise').show();
				$http.get('journal/find',{cache:false}).success(function(data){
					//将时间转换为Date类型
					for(var i=0;i < data.length;i++){
						data[i].time = new Date(data[i].time);
					}
					$scope.journals = data;
					$('.la-ball-spin-clockwise').hide();
				});
			}]);
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
		</script>
	</body>

</html>
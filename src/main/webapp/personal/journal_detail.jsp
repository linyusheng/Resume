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
		<link href="assets/css/blog.css" rel="stylesheet">
		<link href="assets/css/news.css" rel="stylesheet">
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
						<div class="row col-md-12 blog-page" ng-controller="journalCtrl">
							<div class="col-md-9 article-block">
								<h3>{{journal.title}}</h3>
								<div class="blog-tag-data">
									<div class="row">
										<div class="col-md-6">
											<ul class="list-inline blog-tags">
												<li>
													<i class="fa fa-tags" data-toggle="tooltip" data-original-title="标签"></i>
													<a ng-repeat="k in journal.keyword.split(',')">{{k}}</a>
												</li>
											</ul>
										</div>
										<div class="col-md-6 blog-tag-data-inner">
											<ul class="list-inline">
												<li>
													<i class="fa fa-thumbs-o-up"></i>
													<a ng-if="journal.praiseNum == ''">0 个赞 </a>
													<a ng-if="journal.praiseNum != ''">{{journal.praiseNum.split(',').length}} 个赞 </a>
												</li>
												<li>
													<i class="fa fa-comments"></i>
													<a>{{comments.length}} 条评论 </a>
												</li>
												<li>
													<i class="fa fa-calendar"></i>
													<a>发表于： {{journal.time}}</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<!--end news-tag-data-->
								<div>
									<p>
										 At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non libero consectetur adipiscing elit magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat. Pellentesque viverra vehicula sem ut volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non libero magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat.
									</p>
									<blockquote class="hero">
										<p>
											 Lorem ipsum dolor sit amet, consectetur adipiscing elit posuere erat a ante.
										</p>
										<small>Someone famous <cite title="Source Title">Source Title</cite></small>
									</blockquote>
									<p>
										 Ut non libero magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat. Eserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio lorem ipsum dolor sit amet, consectetur adipiscing elit. At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non libero consectetur adipiscing elit magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat. Pellentesque viverra vehicula sem ut volutpat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non libero magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat. Ut non libero consectetur adipiscing elit magna. Sed et quam lacus. Fusce condimentum eleifend enim a feugiat. Pellentesque viverra vehicula sem ut volutpa
									</p>
								</div>
								<hr>
								<h3 ng-if="comments.length == 0">暂无评论</h3>
								<h3 ng-if="comments.length != 0">评论</h3>
								<div class="media" ng-repeat="c in comments">
									<a href="#" class="pull-left">
									<img alt="{{c[6]}}" ng-src="{{c[7]}}" class="media-object">
									</a>
									<div class="media-body">
										<h4 class="media-heading">
											{{c[6]}}
											<span>{{c[4]}} / <a href="#">{{$index+1}}楼 </a></span>
										</h4>
										<p>{{c[3]}}</p>
									</div>
									<hr>
								</div>
								
								<div class="post-comment">
									<h3>发表评论</h3>
									<div class="form-group">
										<textarea class="col-md-10 form-control" rows="7" required="required" placeholder="不少于10个字"></textarea>
									</div>
									<button class="btn btn-success" ng-click="submit()" style="margin-top:15px;">提交</button>
								</div>
							</div>
							<!-- 附属信息 -->
							<div class="col-md-3 col-sm-4 blog-sidebar">
								<h3>最近浏览</h3>
								<div class="row" style="text-align: center;">
									<div class="col-md-3" ng-repeat="b in browsers">
										<img alt="{{b[1]}}" ng-src="{{b[2]}}" width="50" height="50" style="border-radius:50%;">
										<a href="">{{b[1]}}</a>
									</div>
								</div>
							</div>
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
		    App.controller('journalCtrl', ['$scope','$http', function($scope,$http) {
		    	$scope.journal = {};
		    	$scope.comments = [];
		    	$scope.browsers = [];
		    	//获取参数
				var param = location.search;
				var id = param.substring(param.lastIndexOf("=")+1,param.length);
				var url = 'journal/get?id='+id;
				$('.la-ball-spin-clockwise').show();
				$http.get(url ,{cache:false}).success(function(data){
					$scope.journal = data.journal;
					$scope.comments = data.comments;
					$scope.browsers = data.browsers;
					$('.la-ball-spin-clockwise').hide();
				});
				//发表评论
				$scope.submit = function(){
					if($('textarea').val().length < 10){
						globalAlert('至少输入10个字！');
					}else{
						var params = {jid:id, content:$('textarea').val()};
						$http({method:'GET',url:'journal/addComment',params:params}).success(function(data){
							$scope.comments = data.comments;
							globalAlert(data.tip);
							$('textarea').val('');
						}).error(function(data){
							globalAlert('发生错误！');
						});
					}
				};
			}]);
		</script>
	</body>

</html>
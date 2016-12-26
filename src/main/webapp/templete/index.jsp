<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.math.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>
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
		<title>模板库-简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="assets/css/typeahead.min.css" rel="stylesheet">
		<link href="css/bootstrap-tagsinput.css" rel="stylesheet">
		<link href="css/templete.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
		
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>

			<div id="page-wrapper">
				
				<div id="kz-web" class="fadeIn animated" style="border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(247, 247, 247);">
                    <div class="page-main" ng-controller="templeteCtrl">
						<div class="page-main-wrap">
						    <div class="page-header-right">
						    	<button class="btn btn-success" data-toggle="modal" data-target="#templeteModal">
						    		<i class="fa fa-upload"></i>
						    		上传我的模板
						    	</button>
						    </div>
							<div class="page-header-wrap">
						        <div class="row">
						            <div class="col-sm-12">
						                <div class="page-header">
						                    <h3 class="heading">模板搜索系统</h3>
						                    <span class="text-ellipsis">从海量简历样本中，筛选出您最满意的模板</span>
						                </div>
						            </div>
						        </div>
						        <div class="row">
						            <div class="col-sm-12">
					                    <div class="page-search">
					                        <div class="input-group">
					                            <div class="input-group-btn">
					                                <button type="button" class="btn toggle-search-type dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">模板<i class="fa fa-caret-down"></i></button>
					                                <ul class="dropdown-menu dropdown-search-type">
					                                    <li><a href="#">简历</a></li>
					                                </ul>
					                            </div>
					                            <input type="text" class="form-control" id="key">
					                            <span class="icon"><i class="fa fa-search"></i></span>
					
					                            <span class="input-group-btn">
					                                <button class="btn btn-success" id="btn-search" ng-click="page.currentPage=1;search()">搜&nbsp;索</button>
					                            </span>
					                        </div>
					                    </div>
						                <p class="text-ellipsis hot-word-div">
						                    <span class="hot-word hot-word-focus">热门搜索：</span>
                                            <a href="javascript:void(0);" class="hot-word">软件</a>
                                            <a href="javascript:void(0);" class="hot-word">机械</a>
                                            <a href="javascript:void(0);" class="hot-word">电子</a>
                                            <a href="javascript:void(0);" class="hot-word">服务业</a>
                                            <a href="javascript:void(0);" class="hot-word">广告</a>
                                            <a href="javascript:void(0);" class="hot-word">销售</a>
                                            <a href="javascript:void(0);" class="hot-word">策划</a>
                                            <a href="javascript:void(0);" class="hot-word">金融</a>
                                            <a href="javascript:void(0);" class="hot-word">贸易</a>
                                            <a href="javascript:void(0);" class="hot-word">通信</a>
                                            <a href="javascript:void(0);" class="hot-word">计算机</a>
                                            <a href="javascript:void(0);" class="hot-word">医药</a>
                                            <a href="javascript:void(0);" class="hot-word">酒店</a>
                                            <a href="javascript:void(0);" class="hot-word">文员</a>
                                            <a href="javascript:void(0);" class="hot-word">生物</a>
                                            <a href="javascript:void(0);" class="hot-word">化工</a>
                                            <a href="javascript:void(0);" class="hot-word">财会</a>
                                            <a href="javascript:void(0);" class="hot-word">管理</a>
                                            <a href="javascript:void(0);" class="hot-word">建筑</a>
                                            <a href="javascript:void(0);" class="hot-word">园林</a>
                                            <a href="javascript:void(0);" class="hot-word">装饰</a>
                                            <a href="javascript:void(0);" class="hot-word">材料</a>
                                            <a href="javascript:void(0);" class="hot-word">土木</a>
                                            <a href="javascript:void(0);" class="hot-word">建筑</a>
	                                    </p>
						            </div>
						        </div>
						    </div>
						    <div class="panel selected-panel" ng-controller="selectPanel">
						    	<div class="selected-row">
						    		<div class="selected-title">专业类型:</div>
						    		<div class="selected-content">
						                <a class="selected-cell" href="javascript:;" ng-class="{true:'active'}[type.tid==param1]" ng-click="filter1(type.tid)" ng-repeat="type in types">{{type.tname}}</a>
						            </div>
						    		<div class="selected-option">
						                <div ng-show="selectedDisplay[0] == '0'" ng-click="clickMore(0)">
						                    <span>更多</span> <i class="fa fa-caret-down text-success"></i>
						                </div>
						                <div ng-show="selectedDisplay[0] == '1'" ng-click="clickMore(0)">
						                    <span>收起</span> <i class="fa fa-caret-up text-success"></i>
						                </div>
						            </div>
						    	</div>
						    </div>
						    
						    <div class="panel">
						        <div class="panel-heading">模板筛选结果</div>
						        <div class="panel-body">
						            <table class="table" id="mainInfoTable">
						                <thead class="preach-thead">
						                    <tr>
						                        <c:if test="${user != null}"><th class="xjh-save">收藏</th></c:if>
						                        <th class="xjh-title">模板标题</th>
						                        <th class="xjh-type">类型</th>
						                        <th class="xjh-click">大小</th>
						                        <th class="xjh-holdtime">来源</th>
						                        <th class="xjh-place">下载量</th>
						                        <th class="xjh-click">点击量</th>
						                        <th class="xjh-click">收藏量</th>
						                        <th class="xjh-posttime">发布时间</th>
						                        <th class="xjh-option">操作</th>
						                    </tr>
						                </thead>
										<data id="uid" class="hide">${user.uid}</data>
						                <tbody class="preach-tbody">
						                	<tr ng-repeat="t in templetes">
						                		<c:if test="${user != null}">
					                			 <td class="preach-tbody-sc">
						                        	<i class="fa fa-star-o fa-lg text-warning preach-tbody-sc-icon" data-id="{{t.tpId}}" data-collect="no" ng-show="!isCollect(t.tpId)"></i>
						                        	<i class="fa fa-star fa-lg text-warning preach-tbody-sc-icon" data-id="{{t.tpId}}" data-collect="yes" ng-show="isCollect(t.tpId)"></i>
						                        </td>
						                		</c:if>
						                        <td class="preach-tbody-title">
						                        	<div class="text-success company">{{t.tpTitle}}{{t.tpId}}</div>
						                        </td>
						                        <td class="text-left">{{t.tname}}</td>
						                         <td class="text-left">{{t.tpSize / 1024 | number : 1}}KB</td>
						                        <td class="text-left">{{t.nickname}}</td>
						                        <td class="preach-tbody-addre" title="">{{t.downloadNum}}</td>
						                        <td class="text-left">{{t.clickNum}}</td>
						                        <td class="text-left">{{t.collectNum}}</td>
						                        <td class="xjh-posttime">
						                            <span class="hold-ymd">{{t.tpTime}}</span>
						                        </td>
						                        <td class="xjh-option">
					                                <a href="templete/download?id={{t.tpId}}" class="ignoreAction text-success" data-toggle="tooltip" role="button" title="" data-original-title="下载">
					                                    <i class="fa fa-download text-success"></i>
					                                </a>&nbsp;
													<a href="{{t.tpUrl}}" target="_blank" class="ignoreAction text-success" data-toggle="tooltip" role="button" title="" data-original-title="预览">
					                                    <i class="fa fa-eye text-success"></i>
					                                </a>
						                        </td>
						                    </tr>
						            	</tbody>
						            </table>
						                        
						            <!-- 分页条  -->
						            <div class="pagination-wrap">
						                <div class="pull-left xjh-search-pagetext">
						                   	 搜索到 <span class="text-success">{{page.totalRow}}</span> 个模板。
						                </div>
						                
						                <ul class="pagination pull-right remove margin bottom" ng-show="page.totalPage != 0" data-toggle="tooltip" data-placement="bottom" data-original-title="键盘 ↑ ↓ 键可滚动 ←→键可翻页哦">
						                    <li class="paginate_button previous" ng-class="{true:'disabled'}[page.currentPage==1]">
						                    	<a href="javascript:void(0);" ng-click="prev()"><i class="fa fa-angle-left"></i></a>
						                    </li>
						                    
						                    <li class="paginate_button" ng-class="{true:'active'}[page.currentPage==p]" ng-repeat="p in pages">
						                    	<a href="javascript:void(0);" ng-click="searchPage(p)">{{p}}</a>
						                    </li>
						                    
						                    <li class="paginate_button next" ng-class="{true:'disabled'}[page.currentPage==page.totalPage]">
						                    	<a href="javascript:void(0);" ng-click="next()"><i class="fa fa-angle-right"></i></a>
						                    </li>
						                </ul>
						            </div>
						        </div>
						    </div>
						</div>
                	</div>
                
	                <jsp:include page="../public/footer.jsp"></jsp:include>
	                <jsp:include page="../public/modal.jsp"></jsp:include>
	                <jsp:include page="../public/templete_modal.jsp"></jsp:include>
                
                </div>
			</div>
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="assets/js/typeahead.js"></script>
		<script src="assets/js/bootstrap-filestyle.js"></script>
		<script src="js/bootstrap-tagsinput.js"></script>
		<script src="js/ui-bootstrap-tpls-0.13.0.min.js"></script>
		<script src="js/templete.js"></script>
	</body>

</html>
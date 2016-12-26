<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${user!=null}">
<style>
#templeteModal .row{font-size:16px;margin-bottom:15px;line-height: 32px;}
#templeteModal .row .col-xs-4{text-align: right;}
</style>
<!-- 上传简历模板 -->
<div class="modal fade in" id="templeteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" ng-controller="templeteUploadCtrl">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">上传模板</h4>
			</div>
			<div class="modal-body">
				<form action="templete/upload" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-xs-4">模板描述</div>
						<div class="col-xs-5">
							<input type="text" name="title" class="form-control" required/>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-4">模板类型</div>
						<div class="col-xs-5">
							<select class="form-control" name="tid">
								<option ng-repeat="type in types" value="{{type.tid}}">{{type.tname}}</option>
	                        </select>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-4">选择模板</div>
						<div class="col-xs-5">
							<input type="text" class="form-control" id="filename" onclick="$('#file').click();" placeholder="点击浏览" />
							<input type="file" class="hide" name="file" id="file" onchange="$('#filename').val(this.value)"/>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-4">是否公开</div>
						<div class="col-xs-6">
							<input type="hidden" name="isOpen" ng-model="isOpen" ng-init="isOpen=1" value="{{isOpen}}"/>
							<a href="" class="btn fixed-width" ng-class="{'btn-success':isOpen==1,'btn-default':isOpen!=1}" ng-click="isOpen=1">是</a>
							<a href="" class="btn fixed-width" ng-class="{'btn-success':isOpen==0,'btn-default':isOpen!=0}" ng-click="isOpen=0">否</a>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-2 col-xs-offset-4">
							<input class="col-xs-12 btn btn-success" type="submit" value="上传"/>
						</div>
						<div class="col-xs-2">
							<input class="col-xs-12 btn btn-default" type="button" value="取消" data-dismiss="modal"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

</c:if>
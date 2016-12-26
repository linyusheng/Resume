<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${user!=null}">

<!-- 上传头像 -->
<div class="modal fade in" id="headModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" ng-controller="headUploadCtrl">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">上传头像</h4>
			</div>
			<div class="modal-body">
				<div class="headPic">
					<style>
						#face-image-picker div {
							overflow: visible !important;
						}
					</style>
					<div class="webuploader-cropper" data-server-url="user/face">
						<input type="hidden" id="face-image" name="Face[image]" data-folder="face">
						<p>
							<span id="face-image-picker">选择图片</span>
							<button id="face-image-upload" class="btn btn-primary" style="display:none;">上传图片</button>
							<div id="face-image-progress" class="progress" style="display:none;">
								<div class="progress-bar progress-bar-success" role="progressbar"></div>
							</div>
						</p>
						<div class="img-thumbnail">
							<div class="face-image-img-preview" style="height:120px; width:120px;">
								<img ng-src="{{face_full_url}}" alt="" />
							</div>
						</div>
						<div class="face-image-cropper-wrapper" style="display:none;">
							<div class="img-container" style="max-height:300px;">
								<img src="" alt="">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</c:if>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${user!=null}">
<!--兑换商品 -->
<div class = "modal fade" id = "exchangeModal" tabindex = "-1" role = "dialog" aria-hidden = "true">
    <div class = "modal-dialog">
        <div class = "modal-content">
        	<data id="myPoint" class="hide">${user.point}</data>
            <div class = "modal-header">
                <button type = "button" class = "close" data-dismiss = "modal" aria-hidden = "true" ng-click="cancel()">×</button>
                <h4 class = "modal-title">商品兑换</h4>
            </div>
            <div class = "modal-body" id = "modal-body">
                <div class = "row">
                    <div class="col-xs-5">
                    	<img ng-src="{{curGoods.gpicture}}" width="210" height="210" alt="{{curGoods.gname}}">
                    </div>
                    <div class="col-xs-7">
                    	<div style="margin-bottom: 18px;">{{curGoods.gname}}</div>
                    	<div style="margin-bottom: 18px;">
                    		积分：<span class="text-success" style="margin-right:60px;">{{curGoods.gpoint}}</span>
                    		库存：<span class="text-success">{{curGoods.gnum}}</span>
                    	</div>
                    	<div style="margin-bottom: 20px;line-height: 32px;">
                    		<div class="col-xs-3" style="padding-left:0;">选择数量：</div>
                    		<div class="input-group col-xs-5">
                    			<span class="input-group-addon" ng-click="minus()"><i class="fa fa-minus text-success"></i></span>
	                    		<input class="form-control" type="text" id="count" ng-model="count" ng-blur="checkCount()" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
	                    		<span class="input-group-addon" ng-click="add()"><i class="fa fa-plus text-success"></i></span>
                    		</div>
                    	</div>
                    	<div style="margin-bottom: 20px;line-height: 32px;">
                    		<div class="col-xs-3" style="padding-left:0;">配送地址：</div>
                    		<div class="input-group col-xs-9">
	                    		<input class="form-control" type="text" width="30" id="address" ng-model="address" ng-blur="blur()" placeholder="请填写正确的配送地址"/>
                    		</div>
                    	</div>
                    	<div style="margin-bottom: 15px;color:#999">积分不够，<a href="#">去充值</a></div>
                    </div>
                </div>
                <div class="row" style="margin-top:15px;">
                    <div class="col-xs-5">
                        <h5 class="text-danger text-center" ng-bind = "errorMessage"></h5>
                    </div>
                    <div class = "col-xs-7">
                        <a href = "javascript:void(0)" class = "btn btn-primary btn-wide" data-btn-loading = "loading" data-loading-text = "确&nbsp;&nbsp;定" ng-class = "{'disabled':!submited}" ng-click = "submit()">确&nbsp;&nbsp;定</a>
                        <a href = "javascript:void(0)" class = "btn btn-default btn-wide" data-dismiss = "modal" ng-click = "cancel()">取&nbsp;&nbsp;消</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</c:if>
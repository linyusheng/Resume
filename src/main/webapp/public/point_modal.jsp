<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${user!=null}">

<!--积分兑换 -->
<div class = "modal fade" id = "pointModal" tabindex = "-1" role = "dialog" aria-hidden = "true">
    <div class = "modal-dialog">
        <div class = "modal-content" ng-controller = "Posttimes">
            <div class = "modal-header">
                <button type = "button" class = "close" data-dismiss = "modal" aria-hidden = "true">×</button>
                <h4 class = "modal-title">投递配额兑换</h4>
            </div>
            <div class = "modal-body" id = "modal-body">
                <div class = "text-center form-group">
                    <h5>我有<span ng-bind = "myPoint"></span>个积分，<span>1</span>点积分可兑换<span>5</span>个投递配额</h5>
                </div>
                <div class = "text-center form-group">
                    <h5 style = "width:56px;display:inline-block">我要用</h5>
                    <div style = "width:50px;display:inline-block">
                        <input name = "point" type = "text" maxlength = "2" class = "form-control" ng-model = "point" />
                    </div>
                    <h5 style = "width:190px;display:inline-block">个积分，兑换 <span ng-bind = "posttimes"></span> 个投递配额</h5>
                </div>
                <div class = "row text-center">
                    <div class = "col-xs-5">
                        <h5 class = "text-danger" ng-bind = "errorMessage"></h5>
                    </div>
                    <div class = "col-xs-7">
                        <a href = "javascript:void(0)" class = "btn btn-default btn-wide" data-dismiss = "modal">取&nbsp;
                            &nbsp;
                            消</a>
                        <a href = "javascript:void(0)" class = "btn btn-primary btn-wide" data-btn-loading = "loading" data-loading-text = "确&nbsp;&nbsp;定" ng-class = "{'disabled':!point}" ng-click = "submit()">确&nbsp;
                            &nbsp;
                            定</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</c:if>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${user == null}">
	<div class="panel panel-default">
	    <div class="panel-heading">您还没有登录 </div>
	    <div class="panel-body">登录后才能继续操作哦。</div>
	</div>
</c:if>


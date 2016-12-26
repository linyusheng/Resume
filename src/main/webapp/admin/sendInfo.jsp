<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>发送消息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  	<center>在线咨询</center>
  	<form action="send">
  		<label>消息：</label>
  		<input name="info"></input>
  		<label></label>
  		<input type="submit" value="提交" onclick="start()"/>
  	</form>
    <script type="text/javascript">
	    var webSocket =
	      new WebSocket('ws://localhost:8080/Resume/send');
	 
	    webSocket.onerror = function(event) {
	      onError(event);
	    };
	 
	    webSocket.onopen = function(event) {
	      onOpen(event);
	    };
	 
	    webSocket.onmessage = function(event) {
	      onMessage(event);
	    };
	 
	    function onMessage(event) {
	      document.getElementById('messages').innerHTML
	        += '<br />' + event.data;
	    }
	 
	    function onOpen(event) {
	      document.getElementById('messages').innerHTML
	        = 'Connection established';
	    }
	 
	    function onError(event) {
	      alert(event.data);
	    }
	 
	    function start() {
	      webSocket.send('hello');
	      return false;
	    }
	  </script>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'preview.jsp' starting page</title>
    <script type="text/javascript" src="assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.media.js"></script>
    <script type="text/javascript">  
	    $(function() {  
	        $('a.media').media({width:800, height:600}); 
	    });
	</script>
    
  </head>
  
  <body>
    <a class="media" href="assets/resume/1.pdf">预览简历</a>
  </body>
</html>

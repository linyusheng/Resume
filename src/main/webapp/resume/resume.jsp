<%@page import="com.lys.entity.Eduinfo"%>
<%@page import="com.lys.util.Tool"%>
<%@ page import="com.lys.entity.Baseinfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>" />
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <style type="text/css">
        *{padding: 0px;margin: 0px;}
        body{background: #FFF;}
        .tool_bar{width: 100%;height: 54px;background: #2D2A2A;opacity:0.7;position: fixed;z-index: 20;bottom: 0;text-align: center;}
        .jl_down{width: 105px;height: 35px;line-height: 35px;background: #fff;border-radius: 5px;color: #23bab5;position: fixed;bottom: 10px;z-index: 20;left: 46%;text-align: center;cursor: pointer;}
        .jl_down:hover{color: #fff;background: #23bab5}
        .jl_wrapper{width: 80%;margin: 20px auto;font-size: 13px;background: #fff;padding: 15px;position: relative;}
        .base_info{position: relative;}
        .base_info tr{height: 30px;line-height:30px;font-size:14px;margin-bottom: 15px;}
        .base_info h3{font-size: 40px;text-align: center;font-weight: normal;letter-spacing: 16px; margin:0;}
        .gray{color: #999;font-weight: normal;padding: 0px;font-size: 13px;}
        .title{font-size: 16px;font-weight:bold;color:rgb(51, 51, 51);border-bottom: 1px solid #2CCDC8;display:block;height: 40px;line-height: 50px;}
        table {padding: 8px 0;display: block;}
        .info_1 table:last-child,
        .info_2 table:last-child{border-bottom: 1px solid #eee;}
        table td{vertical-align:top;font-size: 14px;}
        .case_info{padding-left: 8px;padding-top: 4px;}
        .info_1 tr{height: 20px;}
        .td_1{width: 130px;}
        .info_1 .td_2{width: 280px;padding: 0px 8px;}
        .info_1 .td_3{width: 220px;padding: 0px 8px;}
        .info_1 .td_4{text-align: right;width: 150px;padding-left: 8px;}
        .info_2 .td_2{width: 666px;padding-left: 8px;}
    </style>
</head>
<body style="font-family: SimSun;">
	<!-- HEAD -->
	<div class="jl_wrapper">
	<div class="base_info">
	    <h3>${baseinfo.name}</h3>
	    <table style="border-bottom:0;">
	        <tbody>
	        <tr>
	            <th class="gray" width="80">基本情况：</th>
	            <td width="530">
            	<% 
            		Baseinfo baseinfo = (Baseinfo)request.getAttribute("baseinfo");
            		List<Eduinfo> eduinfo = (List<Eduinfo>)request.getAttribute("eduinfo");
            		//性别
            		out.print(baseinfo.getSex()==1 ? "男 | " : "女 | ");
            		//年龄
            		String birth_date = baseinfo.getBirthDate();
            		int birth = Integer.parseInt(birth_date.split("-")[0]);
            		int now = Integer.parseInt(Tool.getCurrentDate().split("-")[0]);
            		int age = now - birth;
            		out.print(age+"岁 | ");
            		if(!eduinfo.isEmpty()){
		            	out.print(eduinfo.get(0).getEndTime().toString().split("-")[0]+"届毕业生 | ");
            		}
            		switch(baseinfo.getPoliticsStatus()){
            			case 1:out.print("共青团员");break;
						case 2:out.print("中共党员");break;
						case 3:out.print("群众");break;
						case 4:out.print("民主党员");break;
            		}
            	%>
	            </td>
	            <td rowspan="5"> <img src="<%=basePath%>${baseinfo.faceLargeFullUrl}" style="width: 150px;height: 150px; border-radius: 3px;" /></td>
	        </tr>
	        <tr>
	            <th class="gray">最高学历：</th>
	            <td>
    			<%
    				if(eduinfo.isEmpty()){
    					out.print("未知 · 未知 [未知]");
    				}else{
	    				out.print(eduinfo.get(0).getCollegeName() + " . ");
	    				switch(eduinfo.get(0).getDegree()){
	    					case 1:out.print("中专");break;
	    					case 2:out.print("大专");break;
	    					case 3:out.print("本科");break;
	    					case 4:out.print("硕士");break;
	    					case 5:out.print("博士");break;
	    				}
	    				out.print(" [ " + eduinfo.get(0).getMajorName() + "]");
    				}
    			%>
	            </td>
	        </tr>
	        <tr>
	            <th class="gray">联系电话：</th>
	            <td>${baseinfo.phone}</td>
	        </tr>
	        <tr>
	            <th class="gray">电子邮箱：</th>
	            <td>${baseinfo.email}</td>
	        </tr>
	        <tr>
	            <th class="gray">通讯地址：</th>
	            <td>${baseinfo.address} [${baseinfo.postcode}]</td>
	        </tr>
	        </tbody>
	    </table>
	</div>
	<c:if test="${!eduinfo.isEmpty()}">
	<div class="info_1">
	    <div class="title"> 教育背景   </div>
    	<c:forEach var="e" items="${eduinfo}">
	        <table>
		        <tr>
		            <td class="gray td_1">
		            	<f:formatDate pattern="yyyy.MM" value="${e.startTime}"/>-
		            	<f:formatDate pattern="yyyy.MM" value="${e.endTime}"/>
		            </td>
		            <td class="td_2">${e.collegeName}</td>
		            <td class="td_3">${e.majorName}</td>
		            <td class="td_4">
		            	<c:choose>
		            		<c:when test="${e.degree==1}">中专</c:when>
		            		<c:when test="${e.degree==2}">大专</c:when>
		            		<c:when test="${e.degree==3}">本科</c:when>
		            		<c:when test="${e.degree==4}">硕士</c:when>
		            		<c:when test="${e.degree==5}">博士</c:when>
		            	</c:choose>
		            	<span class="gray">
		            		<c:choose>
			            		<c:when test="${e.rank==1}">(前10%)</c:when>
			            		<c:when test="${e.rank==2}">(前30%)</c:when>
			            		<c:when test="${e.rank==3}">(前50%)</c:when>
			            		<c:when test="${e.rank==4}">其它</c:when>
			            	</c:choose>
		            	</span>
		            </td>
		        </tr>
		        <tr>
		            <td></td>
		            <td colspan="3" class="gray case_info">${e.detail}</td>
		        </tr>
		    </table>
	    </c:forEach>
	</div>
	</c:if>
	<c:if test="${!stuinfo.isEmpty()}">
	<div class="info_1">
	    <div class="title">学生工作 </div>
    	<c:forEach var="s" items="${stuinfo}">
	        <table >
		        <tr>
		            <td class="gray td_1">
		            	<f:formatDate pattern="yyyy.MM" value="${s.startTime}"/>-
			            <f:formatDate pattern="yyyy.MM" value="${s.endTime}"/>
		            </td>
		            <td class="td_2">${s.collegeName}</td>
		            <td class="td_3">${s.department}</td>
		            <td class="td_4">${s.position}</td>
		        </tr>
		        <tr>
		            <td></td>
		            <td colspan="3" class="gray case_info">${s.performance}</td>
		        </tr>
		    </table>
	    </c:forEach>
	</div>
	</c:if>
	<c:if test="${!workinfo.isEmpty()}">
	<div class="info_1">
	    <div class="title">实习/工作</div>
    	<c:forEach var="w" items="${workinfo}">
	        <table>
		        <tr>
		            <td class="gray td_1">
		            	<f:formatDate pattern="yyyy.MM" value="${w.startTime}"/>-
			            <f:formatDate pattern="yyyy.MM" value="${w.endTime}"/>
		            </td>
		            <td class="td_2">
		            	${w.companyName}
		            	<span class="gray">
		            		<c:choose>
			            		<c:when test="${w.companyScale==1}">(50人以内)</c:when>
			            		<c:when test="${w.companyScale==2}">(50-100人)</c:when>
			            		<c:when test="${w.companyScale==3}">(100-300人)</c:when>
			            		<c:when test="${w.companyScale==4}">(300-1000人)</c:when>
			            		<c:when test="${w.companyScale==5}">(1000-2000人)</c:when>
			            		<c:when test="${w.companyScale==6}">(2000-3000人)</c:when>
			            		<c:when test="${w.companyScale==7}">(3000人以上)</c:when>
			            	</c:choose>
		            	</span>
		            </td>
		            <td class="td_3">
		            	<c:choose>
		            		<c:when test="${w.workType==1}">全职</c:when>
		            		<c:when test="${w.workType==2}">兼职</c:when>
		            		<c:when test="${w.workType==3}">实习</c:when>
		            	</c:choose>
		            </td>
		            <td class="td_4">${w.positionName}</td>
		        </tr>
		        <tr>
		            <td></td>
		            <td colspan="3" class="gray case_info">${w.detail}</td>
		        </tr>
	    	</table>
    	</c:forEach>
	</div>
	</c:if>
	<c:if test="${!cominfo.isEmpty()}">
	<div class="info_1">
	    <div class="title">比赛/项目 </div>
	    <c:forEach var="c" items="${cominfo}">
	        <table>
		        <tr>
		            <td class="gray td_1">
		            	<f:formatDate pattern="yyyy.MM" value="${c.startTime}"/>-
			            <f:formatDate pattern="yyyy.MM" value="${c.endTime}"/>
		            </td>
		            <td class="td_2">
		            	${c.projectName}
		            	<span class="gray">
		            		<c:choose>
			            		<c:when test="${c.projectScale==1}">(1-3人)</c:when>
			            		<c:when test="${c.projectScale==2}">(4-10人)</c:when>
			            		<c:when test="${c.projectScale==3}">(11-20人)</c:when>
			            		<c:when test="${c.projectScale==4}">(20人以上)</c:when>
			            	</c:choose>
		            	</span>
		            </td>
		            <td class="td_3">${c.projectSource}</td>
		            <td class="td_4">${c.positionName}</td>
		        </tr>
		        <tr>
		            <td></td>
		            <td colspan="3" class="gray case_info">
		            	${c.detail}<br />${c.performance}
		            </td>
		        </tr>
		    </table>
		</c:forEach>
	</div>
	</c:if>
	<c:if test="${!abiinfo.languageAbility.isEmpty() || !abiinfo.itAbility.isEmpty() || !abiinfo.certificate.isEmpty() || !abiinfo.character.isEmpty() || !abiinfo.hobby.isEmpty()}">
	<div class="info_2">
	    <div class="title">个人素质 </div>
	    <c:if test="${!abiinfo.languageAbility.isEmpty()}">
        <table>
	        <tr>
	            <td class="gray td_1">语言能力</td>
	            <td class="td_2">
	            	<c:forEach var="l" items="${abiinfo.languageAbility}">
	            		${l.language}
	            		听说 
	            		<c:choose>
		            		<c:when test="${l.verbal==1}">一般</c:when>
		            		<c:when test="${l.verbal==2}">良好</c:when>
		            		<c:when test="${l.verbal==3}">精通</c:when>
		            	</c:choose>
		            	、读写
		            	<c:choose>
		            		<c:when test="${l.writing==1}">一般</c:when>
		            		<c:when test="${l.writing==2}">良好</c:when>
		            		<c:when test="${l.writing==3}">精通</c:when>
		            	</c:choose>
		            	${l.detail}<br />
	            	</c:forEach>
	            </td>
	        </tr>
    	</table>
    	</c:if>
    	<c:if test="${!abiinfo.itAbility.isEmpty()}">
        <table>
	        <tr>
	            <td class="gray td_1">计算机能力</td>
	            <td class="td_2">
	            	精通: 
	            	<c:forEach var="i" items="${abiinfo.itAbility}">
		            	<c:if test="${i.ability==2}">${i.skill} </c:if>
	            	</c:forEach>
	            	<br />熟悉:
	            	<c:forEach var="i" items="${abiinfo.itAbility}">
		            	<c:if test="${i.ability==1}">${i.skill} </c:if>
	            	</c:forEach>
	            	
	            </td>
	        </tr>
	    </table>
	    </c:if>
	    <c:if test="${!abiinfo.certificate.isEmpty()}">
        <table>
	        <tr>
	            <td class="gray td_1">专业证书</td>
	            <td class="td_2">
	            	<c:forEach var="c" items="${abiinfo.certificate}">
	            		${c} 
	            	</c:forEach>
	            </td>
	        </tr>
	    </table>
	    </c:if>
	    <c:if test="${!abiinfo.character.isEmpty()}">
        <table>
	        <tr>
	            <td class="gray td_1">性格特点</td>
	            <td class="td_2">
	            	<c:forEach var="c" items="${abiinfo.character}">
	            		${c} 
	            	</c:forEach>
	            </td>
	        </tr>
	    </table>
	    </c:if>
	    <c:if test="${!abiinfo.hobby.isEmpty()}">
	    <table>
	        <tr>
	            <td class="gray td_1">爱好特长</td>
	            <td class="td_2">
	            	<c:forEach var="h" items="${abiinfo.hobby}">
	            		${h} 
	            	</c:forEach>
	            </td>
	        </tr>
	    </table>
	    </c:if>
	</div>
	</c:if>
	
	<c:if test="${honinfo.worldPrize!='' || honinfo.nationalPrize!='' || honinfo.provincePrize!='' || honinfo.collegePrize!='' || honinfo.otherPrize!=''}">
	<div class="info_2">
	    <div class="title">荣誉奖励</div>
    	<c:if test="${honinfo.worldPrize!=''}">
    		<table>
		        <tr>
		            <td class="gray td_1">世界级</td>
		            <td class="td_2">${honinfo.worldPrize}</td>
		        </tr>
		    </table>
    	</c:if>
    	<c:if test="${honinfo.nationalPrize!=''}">
    		<table>
		        <tr>
		            <td class="gray td_1">国家级</td>
		            <td class="td_2">${honinfo.nationalPrize}</td>
		        </tr>
		    </table>
    	</c:if>
    	<c:if test="${honinfo.provincePrize!=''}">
    		<table>
		        <tr>
		            <td class="gray td_1">省部级</td>
		            <td class="td_2">${honinfo.provincePrize}</td>
		        </tr>
		    </table>
    	</c:if>
    	<c:if test="${honinfo.collegePrize!=''}">
    		<table>
		        <tr>
		            <td class="gray td_1">校级奖</td>
		            <td class="td_2">${honinfo.collegePrize}</td>
		        </tr>
		    </table>
    	</c:if>
    	<c:if test="${honinfo.otherPrize!=''}">
    		<table>
		        <tr>
		            <td class="gray td_1">其他奖</td>
		            <td class="td_2">${honinfo.otherPrize}</td>
		        </tr>
		    </table>
    	</c:if>
	</div>
	</c:if>
	<c:if test="${!othinfo.isEmpty()}">
	<div class="info_2">
	    <div class="title">其他信息</div>
	    <c:forEach var="o" items="${othinfo}">
		    <table>
		        <tr>
		            <td class="gray td_1">${o.title}</td>
		            <td class="td_2">${o.detail}</td>
		        </tr>
		    </table>
	    </c:forEach>
	    </div>
	</div>
	</c:if>
</body>
</html>
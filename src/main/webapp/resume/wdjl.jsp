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
		<title>我的简历 - 简历网</title>
		<link href="assets/css/base.min.css" rel="stylesheet">
		<link href="css/bootstrap-tagsinput.css" rel="stylesheet">
		<link href="assets/css/cropper.css" rel="stylesheet">
		<link href="css/jl_pre.css" rel="stylesheet">
		<link href="css/wdjl.css" rel="stylesheet">
		<style>[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak {display: none !important;}</style>
	</head>

	<body style="overflow: hidden;" data-home-url="./" data="1442150955">
		<div id="wrapper" ng-controller="UserManager">
			
			<jsp:include page="../public/top.jsp"></jsp:include>
			<jsp:include page="../public/left.jsp"></jsp:include>
			
			<div id="page-wrapper">
				<div id="kz-web" class="fadeIn animated">
				
				<jsp:include page="../public/logoutTip.jsp"></jsp:include>
				
				<c:if test="${user != null}">	
					<div class="row">
						<div class="page-header">
							<h3 class="heading"><i class="fa fa-user"></i>我的简历</h3>
						</div>
					</div>
					<data class="hide" id="baseInfo">${baseinfo}</data>
					<data class="hide" id="eduInfo">${eduinfo}</data>
					<data class="hide" id="stuInfo">${stuinfo}</data>
					<data class="hide" id="workInfo">${workinfo}</data>
					<data class="hide" id="comInfo">${cominfo}</data>
					<data class="hide" id="abiInfo">${abiinfo}</data>
					<data class="hide" id="honInfo">${honinfo}</data>
					<data class="hide" id="fileInfo">[]</data>
					<data class="hide" id="othInfo">${othinfo}</data>
					<div class="row">

						<div class="info_wrapper" ng-controller="userCtrl" scroll-spy="" data-target="#kz-web" data-scroll-offset="95">
							<div class="panel panel-default" id="base_info" ng-controller="updateBaseCtrl">
								<div class="panel-heading">
									基本信息
									<button ng-show="!loadBase.status" class="padding left right  add_more_box add_more" ng-click="editBaseInfo();"><i class="fa fa-pencil"></i> 编辑</button>
								</div>
								<div class="panel-body">
									<div class="base_info animated fadeIn" ng-show = "!loadBase.status">
							            <div class="row">
							                <div class="headphoto">
							                    <img class="img-circle" ng-src="{{baseInfo.face_large_full_url}}">
							                    <p class="text-success margin top"
							                       data-toggle="modal" data-target="#headModal" >上传头像</p>
							                </div>
							                <div class="col-xs-9 row">
							                    <div class="col-xs-12 margin bottom">
							                        <span class="person_name" ng-bind="baseInfo.name"></span>
							                        <span class="text-gray" ng-show="baseInfo.sex=='1'">男</span>
							                        <span class="text-gray" ng-show="baseInfo.sex=='2'">女</span>
							                    </div>
							                    <div class="col-xs-6 margin bottom">
							                        <span class="person_label">出生年月</span>
							                        <span class="person_content" ng-bind="baseInfo.birth_date"></span>
							                    </div>
							                    <div class="col-xs-6 margin bottom">
							                        <span class="person_label">政治面貌</span>
							                        <span class="person_content" ng-bind="poliItems[baseInfo.politics_status].name"></span>
							                    </div>
							                    <div class="col-xs-6 margin bottom">
							                        <span class="person_label">手机号码</span>
							                        <span class="person_content" ng-bind="baseInfo.phone"></span>
							                    </div>
							                    <div class="col-xs-6 margin bottom">
							                        <span class="person_label">接收邮箱</span>
							                        <span class="person_content" ng-bind="baseInfo.email"></span>
							                    </div>
							                    <div class="col-xs-12 margin bottom">
							                        <span class="person_label">通信地址</span>
							                        <span class="person_content" ng-bind="baseInfo.address+'['+baseInfo.postcode+']'"></span>
							                    </div>
							                </div>
							            </div>
							        </div>
									<form  name="updateBaseForm" role="form" ng-if="loadBase.status"  novalidate  ng-class="{'submitted':submitted}" >
							            <div class="content_add form-horizontal animated fadeIn"  style="display:none">
							                <div class="form-group">
							                    <label for="" class="col-xs-2 text-right add_form_label">姓名</label>
							                    <div class="col-xs-3">
							                        <input type="text" class="form-control" id="form_name" ng-model="baseInfo.name" disabled>
							                        <a href="" class="btn  form_sex fixed-width" ng-class="{'btn-success':baseInfo.sex=='1','btn-default':baseInfo.sex!='1'}" ng-click="baseInfo.sex='1'">男</a>
							                        <a href="" class="btn  form_sex fixed-width" ng-class="{'btn-success':baseInfo.sex=='2','btn-default':baseInfo.sex!='2'}" ng-click="baseInfo.sex='2'">女</a>
							                    </div>
							                    <label for="" class="col-xs-2 text-right add_form_label">出生年月</label>
							                    <div class="col-xs-3">
							                        <div class="input-group">
							
							                        <input type="date" class="form-control" ng-model="baseInfo.birth_date" />
							
							<!--                            <span class="input-group-addon cal-icon span_date"  data-toggle="dropdown" ng-mouseenter="dateInit(birthArray[0])"><i class="fa fa-calendar"></i></span>-->
							<!--									<span class="form-control dropdown-toggle span_date" data-toggle="dropdown" ng-model="baseInfo.birth_date" ng-bind="baseInfo.birth_date" name="birth_date" myrequired ng-mouseenter="dateInit(birthArray[0])"-->
							<!--                                        ></span>-->
							<!--                            <div class="dropdown-menu  animated fadeIn not-close date_drop" role="menu" >-->
							<!--                                <ul class="date_year">-->
							<!--                                    <li ng-repeat="year in birthdata.years"  ng-bind="year.name" ng-class="{active:year.name==birthArray[0]}" ng-click="birthArray[0]=year.name;birthArray[1]='00'"></li>-->
							<!--                                </ul>-->
							<!--                                <ul class="date_month">-->
							<!--                                    <li ng-repeat="month in birthdata.months" ng-bind="month.name" ng-class="{active:month.id==birthArray[1]}" ng-click="birthArray[1]=month.id;baseInfo.birth_date=birthArray.join('-')"></li>-->
							<!--                                </ul>-->
							<!--                            </div>-->
							                        </div>
							                    </div>
							                </div>
							                <div class="form-group">
							                    <label for="" class="col-xs-2 text-right add_form_label">手机</label>
							                    <div class="col-xs-3">
							                        <input type="text" class="form-control" ng-model="baseInfo.phone" required ng-pattern="/[0-9]/" ng-minlength="11" ng-maxlength="11" name="phone">
							
							                        <div class="tip" ng-show="submitted && updateBaseForm.phone.$dirty && updateBaseForm.phone.$invalid">
							                            <span ng-show="!updateBaseForm.phone.$error.required &&!updateBaseForm.phone.$pristine"><i class="fa fa-exclamation-circle"></i>请输入11位手机号码</span>
							                        </div>
							                    </div>
							                    <label for="" class="col-xs-2 text-right add_form_label">政治面貌</label>
							                    <div class="col-xs-3">
							                        <div class="input-group">
							                            <span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="poliItems[baseInfo.politics_status].name" ng-bind="poliItems[baseInfo.politics_status].name" ></span>
							                            <span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
							                            <div class="dropdown-menu poli_box animated fadeIn" role="menu" >
							                                <ul>
							                                    <li ng-repeat = "poliItem in poliItems" ng-bind="poliItem.name" ng-click = "baseInfo.politics_status = poliItem.id;"></li>
							                                </ul>
							                            </div>
							                        </div>
							                    </div>
							                </div>
							                <div class="form-group">
							                    <label for="" class="col-xs-2 text-right add_form_label">电子邮箱</label>
							                    <div class="col-xs-3">
							                        <input type="email" class="form-control"  ng-model="baseInfo.email"  required   ng-pattern="/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/" name="email">
							                        <div class="tip" ng-show="submitted &&  updateBaseForm.email.$dirty && updateBaseForm.email.$invalid">
							
							                            <span ng-show="!updateBaseForm.email.$error.required &&!updateBaseForm.email.$pristine"><i class="fa fa-exclamation-circle"></i>请输入正确的邮箱</span>
							                        </div>
							                    </div>
							
							                    <label for="" class="col-xs-2 text-right add_form_label">邮编</label>
							                    <div class="col-xs-3">
							                        <input type="text" class="form-control" ng-model="baseInfo.postcode"  required name="postcode" ng-mixlength="6" ng-minlength="6" ng-pattern="/[0-9]/">
							                        <div class="tip" ng-show="submitted &&  updateBaseForm.postcode.$dirty && updateBaseForm.postcode.$invalid">
							                            <span ng-show="!updateBaseForm.postcode.$error.required &&!updateBaseForm.postcode.$pristine"><i class="fa fa-exclamation-circle"></i>请输入6位邮编</span>
							                        </div>
							                    </div>
							                </div>
							                <div class="form-group">
							                    <label for="" class="col-xs-2 text-right add_form_label" >通信地址</label>
							                    <div class="col-xs-8">
							                        <input type="text" class="form-control" ng-model="baseInfo.address" name=
							                        "address" required>
							
							                    </div>
							                </div>
							                <div class="form-group">
							                    <div class="col-xs-2 col-xs-offset-2">
							                        <button type="submit" class="col-xs-12 btn btn-success add_save" ng-click="updateBaseInfo();">保存</button>
							                    </div>
							                    <div class="col-xs-2">
							                        <button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="reset();">取消</button>
							                    </div>
							                </div>
							            </div>
							        </form>
								</div>
							</div>
							<div class="panel panel-default" id="edu_info" ng-controller="eduInfoCtrl">
								<div class="panel-heading">
									教育背景
									<button ng-show="cur==null" class="padding left right add_more add_more_box" ng-click="add();majorListClick(array[cur].department)" ;><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-if="!array.length">
										<button ng-click="add();" class="text-success add_more"><i class="fa fa-plus-circle text-success"></i>添加教育背景</button>
									</div>
									<form name="eduForm" ng-if="cur!=null" novalidate ng-class="{'submitted':submitted}">
										<div class="content_add form-horizontal">
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">学校</label>
												<div class="col-xs-4">
													<span class='form-control dropdown-toggle' data-toggle='dropdown' ng-model='array[cur].college_name' ng-bind='array[cur].college_name' myrequired></span>
													<div class='dropdown-menu university_drop animated fadeIn not-close' role='menu'>
														<ul class='list'>
															<li ng-repeat='city in unidata' ng-bind='city.name' ng-model='city.name' ng-click='array[cur].college_prov=$index;' ng-class='{active:$index==array[cur].college_prov}'></li>
														</ul>
														<ul class='university'>
															<li ng-repeat='university in unidata[array[cur].college_prov].uni' ng-bind='university.name' ng-model='university.name' ng-class='{active:university.name == array[cur].college_name}' ng-click='array[cur].college_name=university.name;array[cur].college_id=university.id;'></li>
														</ul>
													</div>
												</div>

												<label for="" class="col-xs-2 text-right add_form_label">学历</label>
												<div class="col-xs-2">
													<div class="input-group">
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="eduBgItems[array[cur].degree].name" ng-bind="eduBgItems[array[cur].degree].name" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu" style="width: 122px;min-width: 50px;">
															<ul>
																<li ng-repeat="eduBgItem in eduBgItems" ng-bind="eduBgItem.name" ng-click="array[cur].degree=eduBgItem.id"></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">专业名称</label>
												<div class="col-xs-9 reset padding right left">
													<div class="input-group edu_major_1">
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="majorLists[array[cur].department-1].name" ng-bind="majorLists[array[cur].department-1].name" style="width:69px" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu" style="width: 95px;min-width: 50px;">
															<ul>
																<li ng-repeat="majorList in majorLists" ng-bind="majorList.name" ng-click="array[cur].department=majorList.id;majorListClick(array[cur].department);" ng-class="{active:majorList.id == array[cur].department}"></li>
															</ul>
														</div>
													</div>
													<div class="input-group edu_major_2">
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="majorItems[array[cur].major_type-1].name" ng-bind="majorItems[array[cur].major_type-1].name" ng-click="majorListClick(array[cur].department)" style="width:169px" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu">
															<ul>
																<li ng-repeat="majorMajor in  majorMajors" ng-bind="majorMajor.name" ng-click="array[cur].major_type=majorMajor.id" ng-class="{active:array[cur].major_type==majorMajor.id}"></li>
															</ul>
														</div>
													</div>
													<div class="input-group edu_major_3">
														<input type="text" class="form-control" ng-model="array[cur].major_name" required name="major" required>
														<div class="tip" ng-show="submitted && eduForm.major.$dirty && eduForm.major.$invalid">
															<span ng-show="eduForm.major.$error.required"><i class="fa fa-exclamation-circle"></i>必填</span>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">就读时间</label>
												<div class="col-xs-4">
													<div class="edu_date">
														<div class="input-group">
															<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
															<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].start_time" ng-bind="array[cur].start_time" name="start_time" myrequired></span>
															<div class="dropdown-menu  dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
																<ul class="date_year">
																	<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].start_time.substr(0,4)}" ng-click="setTime('start_time', year.name, 0)"></li>
																</ul>
																<ul class="date_month">
																	<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].start_time.substr(5,2)}" ng-click="setTime('start_time', 0, month.id)"></li>
																</ul>
															</div>
														</div>
													</div>
													<div class="text-gray" style="float:left;display:inline-block;margin:0px 3px;height:32px;line-height:32px">至</div>
													<div class="edu_date">
														<div class="input-group">
															<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
															<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].end_time" ng-bind="array[cur].end_time" myrequired></span>
															<div class="dropdown-menu  dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
																<ul class="date_year">
																	<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].end_time.substr(0,4)}" ng-click="setTime('end_time', year.name, 0)"></li>
																</ul>
																<ul class="date_month">
																	<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].end_time.substr(5,2)}" ng-click="setTime('end_time', 0, month.id)"></li>
																</ul>
															</div>
														</div>
													</div>
													<datetip></datetip>
												</div>

												<label for="" class="col-xs-2 text-right add_form_label">专业排名</label>
												<div class="col-xs-2">
													<div class="input-group">

														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="gradeItems[array[cur].rank].name" ng-bind="gradeItems[array[cur].rank].name" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu" style="width:122px;min-width:60px">
															<ul>
																<li ng-repeat="gradeItem in gradeItems" ng-bind="gradeItem.name" ng-class="{active:array[cur].rank==gradeItem.id}" ng-click="array[cur].rank=gradeItem.id"></li>
															</ul>

														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">主修课程</label>
												<div class="col-xs-8">
													<textarea class="form-control" rows="3" ng-model="array[cur].detail"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-xs-2 col-xs-offset-2">
													<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="save();">保存</button>
												</div>
												<div class="col-xs-2">
													<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancel();">取消</button>
												</div>
											</div>

										</div>
									</form>
									<div class="content_info" ng-if="cur==null">
										<ul class="case_box" ng-repeat="item in array | orderBy:'-end_time'">
											<li class="case">
												<div class="row">
													<div class="col-xs-2 case_time text-gray" ng-bind="item.start_time+'-'+item.end_time"></div>
													<div class="col-xs-10 reset padding left">
														<div class="row">
															<div class="col-xs-6" ng-bind="item.college_name"></div>
															<div class="col-xs-4" ng-bind="item.major_name"></div>
															<div class="col-xs-2  text-right">{{eduBgItems[item.degree].name}}
																<span class="text-gray" ng-bind="'('+gradeItems[item.rank].name+')'"></span>
															</div>
														</div>
														<div class="row">
															<div class="col-xs-12 case_info text-gray" ng-bind-html="nl2br(item.detail)"></div>
														</div>
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="edit(item.id)"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="remove(item.id)">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="panel panel-default" id="stu_info" ng-controller="stuInfoCtrl">
								<div class="panel-heading">
									学生工作
									<button ng-show="cur==null" class="padding left right add_more add_more_box" ng-click="add();"><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-if="!array.length">
										<button class="text-success add_more" ng-click="add();"><i class="fa fa-plus-circle text-success"></i>添加学生工作</button>
									</div>
									<form ng-if="cur!=null" ng-class="{'submitted':submitted}" name="stuForm">
										<div class="content_add form-horizontal">
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">学校</label>
												<div class="col-xs-6">
													<span class='form-control dropdown-toggle' data-toggle='dropdown' ng-model='array[cur].college_name' ng-bind='array[cur].college_name' myrequired></span>
													<div class='dropdown-menu university_drop animated fadeIn not-close' role='menu'>
														<ul class='list'>
															<li ng-repeat='city in unidata' ng-bind='city.name' ng-model='city.name' ng-click='array[cur].college_prov=$index;' ng-class='{active:$index==array[cur].college_prov}'></li>
														</ul>
														<ul class='university'>
															<li ng-repeat='university in unidata[array[cur].college_prov].uni' ng-bind='university.name' ng-model='university.name' ng-class='{active:university.name == array[cur].college_name}' ng-click='array[cur].college_name=university.name;array[cur].college_id=university.id;'></li>
														</ul>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">部门</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].department" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">职位名称</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].position" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">参与时间</label>
												<div class="stu_date">
													<div class="input-group">
														<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].start_time" ng-bind="array[cur].start_time" name="start_time" myrequired></span>
														<div class="dropdown-menu  dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
															<ul class="date_year">
																<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].start_time.substr(0,4)}" ng-click="setTime('start_time', year.name, 0)"></li>
															</ul>
															<ul class="date_month">
																<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].start_time.substr(5,2)}" ng-click="setTime('start_time', 0, month.id)"></li>
															</ul>
														</div>
													</div>
													<datetip></datetip>
												</div>
												<div class="text-gray" style="float:left;display:inline-block;margin:0px 3px;height:32px;line-height:32px">至</div>
												<div class="stu_date">
													<div class="input-group">
														<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].end_time" ng-bind="array[cur].end_time" myrequired></span>
														<div class="dropdown-menu  dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
															<ul class="date_year">
																<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].end_time.substr(0,4)}" ng-click="setTime('end_time', year.name, 0)"></li>
															</ul>
															<ul class="date_month">
																<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].end_time.substr(5,2)}" ng-click="setTime('end_time', 0, month.id)"></li>
															</ul>
														</div>
													</div>
												</div>

											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">职位表现</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="3" ng-model="array[cur].performance"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-xs-2 col-xs-offset-2">
													<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="save();">保存</button>
												</div>
												<div class="col-xs-2">
													<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancel();">取消</button>
												</div>
											</div>
										</div>
									</form>
									<div class="content_info" ng-if="cur==null">
										<ul class="case_box" ng-repeat="item in array | orderBy:'-start_time'">
											<li class="case">
												<div class="row">
													<div class="col-xs-2 case_time text-gray" ng-bind="item.start_time+'-'+item.end_time"></div>
													<div class="col-xs-10  reset padding left">
														<div class="row">
															<div class="col-xs-6" ng-bind="item.college_name"></div>
															<div class="col-xs-4" ng-bind="item.department"></div>
															<div class="col-xs-2 text-right" ng-bind="item.position"></div>
														</div>
														<div class="row">
															<div class="col-xs-12 case_info text-gray" ng-bind-html="nl2br(item.performance)"></div>
														</div>
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="edit(item.id)"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>

												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="remove(item.id)">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
										</ul>
									</div>
								</div>

							</div>
							<div class="panel panel-default" id="work_info" ng-controller="jobExperienceCtrl">
								<div class="panel-heading">
									实习/工作
									<button ng-show="cur==null" class="padding left right add_more add_more_box" ng-click="add()"><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-if="!array.length">
										<button class="text-success add_more" ng-click="add()"><i class="fa fa-plus-circle text-success"></i>添加实习/工作</button>
									</div>

									<form ng-if="cur!=null" ng-class="{'submitted':submitted}" name="workForm">
										<div class="content_add form-horizontal">
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">经历类型</label>
												<div class="col-xs-3 reset padding right">
													<div class="input-group">
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="typeItems[array[cur].work_type].name" ng-bind="typeItems[array[cur].work_type].name" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu">
															<ul>
																<li ng-repeat="typeItem in typeItems" ng-bind="typeItem.name" ng-click="array[cur].work_type=typeItem.id"></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">公司名称</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].company_name" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">公司规模</label>
												<div class="col-xs-3 reset padding right">
													<div class="input-group">

														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="comSizeItems[array[cur].company_scale].name" ng-bind="comSizeItems[array[cur].company_scale].name" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu">
															<ul>
																<li ng-repeat="comSizeItem in comSizeItems" ng-bind="comSizeItem.name" ng-click="array[cur].company_scale=comSizeItem.id"></li>
															</ul>
														</div>

													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">职位名称</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].position_name" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">在职时间</label>
												<div class="stu_date">
													<div class="input-group">
														<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].start_time" ng-bind="array[cur].start_time" name="start_time" myrequired></span>
														<div class="dropdown-menu  dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
															<ul class="date_year">
																<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].start_time.substr(0,4)}" ng-click="setTime('start_time', year.name, 0)"></li>
															</ul>
															<ul class="date_month">
																<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].start_time.substr(5,2)}" ng-click="setTime('start_time', 0, month.id)"></li>
															</ul>
														</div>
													</div>
													<datetip></datetip>
												</div>
												<div class="text-gray" style="float:left;display:inline-block;margin:0px 3px;height:32px;line-height:32px">至</div>
												<div class="stu_date">
													<div class="input-group">
														<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].end_time" ng-bind="array[cur].end_time" myrequired></span>
														<div class="dropdown-menu  dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
															<ul class="date_year">
																<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].end_time.substr(0,4)}" ng-click="setTime('end_time', year.name, 0)"></li>
															</ul>
															<ul class="date_month">
																<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].end_time.substr(5,2)}" ng-click="setTime('end_time', 0, month.id)"></li>
															</ul>
														</div>
													</div>
												</div>

											</div>
											<div class="form-group">
												<label class="col-xs-2 text-right add_form_label">工作描述</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="3" ng-model="array[cur].detail"> </textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-xs-2 col-xs-offset-2">
													<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="save();">保存</button>
												</div>
												<div class="col-xs-2">
													<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancel();">取消</button>
												</div>
											</div>
										</div>
									</form>
									<div class="content_info" ng-if="cur==null">
										<ul class="case_box" ng-repeat="item in array | orderBy:'-start_time'">
											<li class="case">
												<div class="row">
													<div class="col-xs-2 case_time text-gray" ng-bind="item.start_time+'-'+item.end_time"></div>
													<div class="col-xs-10 reset padding left">
														<div class="row">
															<div class="col-xs-6">{{item.company_name}} &nbsp; <span class="text-gray" ng-bind="comSizeItems[item.company_scale].name"> </span></div>
															<div class="col-xs-3" ng-bind="typeItems[item.work_type].name"></div>
															<div class="col-xs-3 text-right" ng-bind="item.position_name"></div>
														</div>
														<div class="row">
															<div class="col-xs-12 case_info text-gray" ng-bind-html="nl2br(item.detail)"></div>
														</div>
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="edit(item.id)"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="remove(item.id)">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
										</ul>
									</div>

								</div>
							</div>
							<div class="panel panel-default" id="com_info" ng-controller="comInfoCtrl">
								<div class="panel-heading">
									比赛/项目
									<button ng-show="cur==null" class="padding left right add_more add_more_box" ng-click="add();"><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-if="!array.length">
										<button class="text-success add_more" ng-click="add();"><i class="fa fa-plus-circle text-success"></i>添加比赛/项目</button>
									</div>
									<form ng-if="cur!=null" ng-class="{'submitted':submitted}" name="comForm">
										<div class="content_add form-horizontal">
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">比赛/项目名称</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].project_name" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">比赛/项目规模</label>
												<div class="col-xs-3 reset padding right">
													<div class="input-group">
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="comSizeItems[array[cur].project_scale].name" ng-bind="comSizeItems[array[cur].project_scale].name" myrequired></span>
														<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
														<div class="dropdown-menu poli_box" role="menu">
															<ul>
																<li ng-repeat="comSizeItem in comSizeItems" ng-bind="comSizeItem.name" ng-click="array[cur].project_scale=comSizeItem.id"></li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">比赛/项目来源</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].project_source" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">担任职务</label>
												<div class="col-xs-6">
													<input type="text" class="form-control" ng-model="array[cur].position_name" required>
												</div>
											</div>
											<div class="form-group">

												<label for="" class="col-xs-2 text-right add_form_label">比赛/项目时间</label>
												<div class="stu_date">
													<div class="input-group">
														<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].start_time" ng-bind="array[cur].start_time" name="start_time[0]" myrequired></span>
														<div class="dropdown-menu  dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
															<ul class="date_year">
																<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].start_time.substr(0,4)}" ng-click="setTime('start_time', year.name, 0)"></li>
															</ul>
															<ul class="date_month">
																<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].start_time.substr(5,2)}" ng-click="setTime('start_time', 0, month.id)"></li>
															</ul>
														</div>
													</div>
													<datetip></datetip>
												</div>
												<div class="text-gray" style="float:left;display:inline-block;margin:0px 3px;height:32px;line-height:32px">至</div>
												<div class="stu_date">
													<div class="input-group">
														<span class="input-group-addon cal-icon" data-toggle="dropdown"><i class="fa fa-calendar"></i></span>
														<span class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="array[cur].end_time" ng-bind="array[cur].end_time" myrequired></span>
														<div class="dropdown-menu  dropdown-menu-wide dropdown-menu-multiselect animated fadeIn not-close date_drop" role="menu">
															<ul class="date_year">
																<li ng-repeat="year in yeardata.years" ng-bind="year.name" ng-class="{active:year.name==array[cur].end_time.substr(0,4)}" ng-click="setTime('end_time', year.name, 0)"></li>
															</ul>
															<ul class="date_month">
																<li ng-repeat="month in yeardata.months" ng-bind="month.name" ng-class="{active:month.id==array[cur].end_time.substr(5,2)}" ng-click="setTime('end_time', 0, month.id)"></li>
															</ul>
														</div>
													</div>
												</div>

											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">比赛/项目简介</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="3" ng-model="array[cur].detail"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">职责与业绩</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="3" ng-model="array[cur].performance"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-xs-2 col-xs-offset-2">
													<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="save();">保存</button>
												</div>
												<div class="col-xs-2">
													<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancel();">取消</button>
												</div>
											</div>
										</div>
									</form>
									<div class="content_info" ng-if="cur==null">
										<ul class="case_box" ng-repeat="item in array | orderBy:'-start_time'">
											<li class="case">
												<div class="row">
													<div class="col-xs-2 case_time text-gray" ng-bind="item.start_time+'-'+item.end_time"></div>
													<div class="col-xs-10 reset padding left">
														<div class="row">
															<div class="col-xs-6">{{item.project_name}} &nbsp; <span class="text-gray" ng-bind="comSizeItems[item.project_scale].name"> </span></div>
															<div class="col-xs-4" ng-bind="item.project_source"></div>
															<div class="col-xs-2 text-right" ng-bind="item.position_name"></div>

														</div>
														<div class="row">
															<div class="col-xs-12 case_info text-gray" ng-bind-html="nl2br(item.detail)"></div>
															<div class="col-xs-12 case_info text-gray" ng-bind-html="nl2br(item.performance)"></div>
														</div>
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="edit(item.id);"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>

												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="remove(item.id)">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>

							<div class="panel panel-default" id="abi_info" ng-controller="personalQualityCtrl">
								<div class="panel-heading">
									个人素质
									<button ng-show="cur==null" class="padding left right add_more add_more_box" ng-click="cur='index'"><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-hide="(cur!=null) || languageAbility.length || itAbility[1].length || itAbility[2].length || cert.length || char.length || hobby.length">
										<button class="text-success add_more" ng-click="cur='index'"><i class="fa fa-plus-circle text-success"></i>添加个人素质</button>
									</div>
									<div class="content_add form-horizontal" ng-show="cur=='index'">
										<div class="main_abi">
											<div class="form-group">
												<button class="btn btn-default col-xs-2 col-xs-offset-1" ng-click="cur='lang'">语言能力</button>
												<button class="btn btn-default col-xs-2 col-xs-offset-1" ng-click="cur='it'">计算机能力</button>
											</div>
											<div class="form-group">
												<button class="btn btn-default col-xs-2 col-xs-offset-1" ng-click="cur='cert'">专业证书</button>
												<button class="btn btn-default col-xs-2 col-xs-offset-1" ng-click="cur='char'">性格特点</button>
												<button class="btn btn-default col-xs-2 col-xs-offset-1" ng-click="cur='hobby'">爱好特长</button>
											</div>
											<div class="form-group">
												<button type="button" class="col-xs-2 col-xs-offset-1 btn btn-success add_cancel" ng-click="cur=null">取消</button>
											</div>
										</div>
									</div>
									<div class="content_info">
										<div class="case_box">
											<div class="case" ng-show="cur==null && languageAbility">
												<div class="row">
													<div class="col-xs-2 text-gray">语言能力</div>
													<div class="col-xs-10 reset padding left">
														<div ng-repeat="lang in languageAbility" ng-bind="'语言: '+lang.language+'; 听说: '+ranks[lang.verbal].name+'; 读写: '+ranks[lang.writing].name+'; '+lang.detail"></div>
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="cur='lang';"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="languageAbility=[];updateLanguageAbility()">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</div>
											<form ng-show="cur=='lang'" ng-class="{'submitted':submitted}" name="langForm">
												<div class="content_update form-horizontal">
													<div ng-repeat="lang in languageAbility" class="lang_case">
														<div class="form-group">
															<label class="lang_label text-right">语言</label>
															<div class="lang_case1">
																<div class="input-group">
																	<span myrequired class="form-control dropdown-toggle" data-toggle="dropdown" ng-model="lang.language" ng-bind="lang.language"></span>
																	<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
																	<div class="dropdown-menu poli_box animated fadeIn" role="menu" style="width: 95px;min-width: 50px;">
																		<ul>
																			<li ng-repeat="langList in langLists" ng-bind="langList" ng-click="lang.language=langList" ng-class="{active:langList == lang.language}"></li>
																		</ul>
																	</div>
																</div>
															</div>
															<label class="lang_label text-right">听说</label>
															<div class="lang_case2">
																<div class="input-group">
																	<span myrequired class="form-control dropdown-toggle" data-toggle="dropdown" ng-bind="ranks[lang.verbal].name" ng-model="ranks[lang.verbal].name"></span>
																	<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
																	<div class="dropdown-menu poli_box animated fadeIn" role="menu" style="width: 75px;min-width: 50px;">
																		<ul ng-repeat="rank in ranks">
																			<li ng-bind="rank.name" ng-click="lang.verbal=rank.id" ng-class="{active:rank.id == lang.verbal}"></li>
																		</ul>
																	</div>
																</div>
															</div>
															<label class="lang_label text-right">读写</label>
															<div class="lang_case2">
																<div class="input-group">
																	<span myrequired class="form-control dropdown-toggle" data-toggle="dropdown" ng-bind="ranks[lang.writing].name" ng-model="ranks[lang.writing].name"></span>
																	<span class="input-group-addon cal-icon dropdown-toggle" data-toggle="dropdown"><i class="fa fa-sort-desc"></i></span>
																	<div class="dropdown-menu poli_box animated fadeIn" role="menu" style="width: 85px;min-width: 50px;">
																		<ul ng-repeat="rank in ranks">
																			<li ng-bind="rank.name" ng-click="lang.writing=rank.id;" ng-class="{active:rank.id == lang.writing}"></li>
																		</ul>
																	</div>
																</div>
															</div>

															<label class="lang_label text-right">其他说明</label>
															<div class="lang_case3">
																<input class="form-control" ng-model="lang.detail" ng-bind="lang.detail" />
															</div>

															<button class="text-success lang_del" ng-click="delLang($index)"><i class="fa fa-times"></i>删除</button>
														</div>
													</div>
													<div class="form-group">
														<div class="col-xs-2">
															<button type="button" class="text-success lang_add" ng-click="addLang()">添加新条目</button>
														</div>
														<div class="lang_btn">
															<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="updateLanguageAbility()">保存</button>
														</div>
														<div class="lang_btn">
															<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancelLanguageAbility()">取消</button>
														</div>
													</div>
												</div>
											</form>
										</div>
										<div class="case_box">
											<!-- <li class="case" ng-show="!loadAbi.updateS[1]"> -->
											<li class="case" ng-show="cur==null && (itAbility[1] || itAbility[2])">
												<div class="row">
													<div class="col-xs-2 text-gray">计算机能力</div>
													<div class="col-xs-10 reset padding left" ng-bind-html="'精通： '+itAbility[2].join('，')+'<br />熟悉： '+itAbility[1].join('，')">
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="cur='it'"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="itAbility={1:[],2:[]};updateItAbility();">删除</button>
													<!-- "comskill":{"familiar":[],"master":[]} -->
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
											<form ng-show="cur=='it'" ng-class="{'submitted':submitted}" name="itForm">
												<div class="content_update form-horizontal">
													<div class="form-group">
														<label for="" class="col-xs-2 text-right add_form_label">精通</label>
														<div class="col-xs-8">
															<bootstrap-tagsinput ng-model="itAbility[2]" maxChars="10" maxTags="10" tagclass="label label-primary" trimValue="true" typeahead-source="popularIt">
															</bootstrap-tagsinput>
														</div>
													</div>
													<div class="form-group">
														<label for="" class="col-xs-2 text-right add_form_label">熟悉</label>
														<div class="col-xs-8">
															<bootstrap-tagsinput ng-model="itAbility[1]" maxChars="10" maxTags="10" tagclass="label label-primary" trimValue="true" typeahead-source="popularIt">
															</bootstrap-tagsinput>
															<p class="col-xs-8 text-gray">输入词语后按下回车键生成词条保存</p>
														</div>
													</div>
													<div class="form-group">
														<div class="col-xs-2 col-xs-offset-2">
															<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="updateItAbility();">保存</button>
														</div>
														<div class="col-xs-2">
															<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancelItAbility();">取消</button>
														</div>
													</div>
												</div>
											</form>
										</div>
										<div class="case_box">
											<li class="case" ng-show="cur==null && cert">
												<div class="row">
													<div class="col-xs-2 text-gray">专业证书</div>
													<div class="col-xs-10 reset padding left" ng-bind="cert.join('，')">
													</div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="cur='cert'"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="cert=[];updateCert();">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
											<form ng-show="cur=='cert'" ng-class="{'submitted':submitted}" name="certForm">
												<div class="content_update form-horizontal">
													<div class="form-group">
														<label for="" class="col-xs-2 text-right add_form_label">专业证书</label>
														<div class="col-xs-8">
															<bootstrap-tagsinput ng-model="cert" maxChars="10" maxTags="10" tagclass="label label-primary" trimValue="true" typeahead-source="popularCert">
															</bootstrap-tagsinput>
															<p class="col-xs-8 text-gray">输入词语后按下回车键生成词条保存</p>
														</div>
													</div>

													<div class="form-group">
														<div class="col-xs-2 col-xs-offset-2">
															<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="updateCert();">保存</button>
														</div>
														<div class="col-xs-2">
															<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancelCert();">取消</button>
														</div>
													</div>
												</div>
											</form>
										</div>
										<div class="case_box">
											<li class="case" ng-show="cur==null && char">
												<div class="row">
													<div class="col-xs-2 text-gray">性格特点</div>
													<div class="col-xs-10 reset padding left" ng-bind="char.join('，')"></div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="cur='char'"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="char=[];updateChar();">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
											<form ng-show="cur=='char'" ng-class="{'submitted':submitted}" name="charForm">
												<div class="content_update form-horizontal">
													<div class="form-group">
														<label for="" class="col-xs-2 text-right add_form_label">性格特点</label>
														<div class="col-xs-8">
															<bootstrap-tagsinput ng-model="char" maxChars="10" maxTags="10" tagclass="label label-primary" trimValue="true" typeahead-source="popularChar">
															</bootstrap-tagsinput>
															<p class="col-xs-8 text-gray">输入词语后按下回车键生成词条保存</p>
														</div>
													</div>
													<div class="form-group">
														<div class="col-xs-2 col-xs-offset-2">
															<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="updateChar();">保存</button>
														</div>
														<div class="col-xs-2">
															<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancelChar();">取消</button>
														</div>
													</div>
												</div>

											</form>
										</div>
										<div class="case_box">
											<li class="case" ng-show="cur==null && hobby">
												<div class="row">
													<div class="col-xs-2 text-gray">爱好特长</div>
													<div class="col-xs-10 reset padding left" ng-bind="hobby.join('，')"></div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="cur='hobby'"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>
												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="hobby=[];updateHobby();">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
											<form ng-show="cur=='hobby'" ng-class="{'submitted':submitted}" name="hobbyForm">
												<div class="content_update form-horizontal">
													<div class="form-group">
														<label for="" class="col-xs-2 text-right add_form_label">爱好特长</label>
														<div class="col-xs-8">
															<!--                                <textarea class="form-control" rows="3" ng-model="hobby" required></textarea>-->
															<bootstrap-tagsinput ng-model="hobby" maxChars="10" maxTags="10" tagclass="label label-primary" trimValue="true" typeahead-source="popularHobby">
															</bootstrap-tagsinput>
															<p class="col-xs-8 text-gray">输入词语后按下回车键生成词条保存</p>
														</div>
													</div>
													<div class="form-group">
														<div class="col-xs-2 col-xs-offset-2">
															<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="updateHobby();">保存</button>
														</div>
														<div class="col-xs-2">
															<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancelHobby();">取消</button>
														</div>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<div class="panel panel-default" id="hon_info" ng-controller="honInfoCtrl">
								<div class="panel-heading">
									荣誉奖励
									<button ng-show="!open" class="padding left right add_more add_more_box" ng-click="add();"><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-show="!open && !(info.world_prize || info.national_prize || info.province_prize || info.college_prize || info.other_prize)">
										<button class="text-success add_more" ng-click="add();"><i class="fa fa-plus-circle text-success"></i>添加荣誉奖励</button>
									</div>
									<form ng-if="open" ng-class="{'submitted':submitted}" name="honForm">
										<div class="content_add form-horizontal">
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">世界级</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="2" ng-model="info.world_prize"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">国家级</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="2" ng-model="info.national_prize"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">省部级</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="2" ng-model="info.province_prize"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">校级奖</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="2" ng-model="info.college_prize"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">其他奖</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="2" ng-model="info.other_prize"></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-xs-2 col-xs-offset-2">
													<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="save();">保存</button>
												</div>
												<div class="col-xs-2">
													<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancel();">取消</button>
												</div>
											</div>
										</div>
									</form>
									<div class="content_info" ng-if="!open">
										<p class="row" ng-if="info.world_prize">
											<span class="col-xs-2 text-gray">世界级</span>
											<span class="col-xs-10 reset padding left" ng-bind="info.world_prize"></span>
										</p>
										<p class="row" ng-if="info.national_prize">
											<span class="col-xs-2 text-gray">国家级</span>
											<span class="col-xs-10 reset padding left" ng-bind="info.national_prize"></span>
										</p>
										<p class="row" ng-if="info.province_prize">
											<span class="col-xs-2 text-gray">省部级</span>
											<span class="col-xs-10 reset padding left" ng-bind="info.province_prize"></span>
										</p>
										<p class="row" ng-if="info.college_prize">
											<span class="col-xs-2 text-gray">校级奖</span>
											<span class="col-xs-10 reset padding left" ng-bind="info.college_prize"></span>
										</p>
										<p class="row" ng-if="info.other_prize">
											<span class="col-xs-2 text-gray">其他奖</span>
											<span class="col-xs-10 reset padding left" ng-bind="info.other_prize"></span>
										</p>
									</div>
								</div>
							</div>
							<!--        TODO 附件上传-->
							<div class="panel panel-default" id="oth_info" ng-controller="othInfoCtrl">
								<div class="panel-heading">
									其他信息
									<button ng-show="cur==null" class="padding left right add_more add_more_box" ng-click="add();"><i class="fa fa-plus"></i> 添加</button>
								</div>
								<div class="panel-body">
									<div class="content_empty" ng-if="!array.length">
										<button class="text-success add_more" ng-click="add();"><i class="fa fa-plus-circle text-success"></i>添加其他信息</button>
									</div>
									<form ng-if="cur!=null" ng-class="{'submitted':submitted}" name="othForm">
										<div class="content_add form-horizontal">
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">标题</label>
												<div class="col-xs-3">
													<input type="text" class="form-control" ng-model="array[cur].title" required>
												</div>
											</div>
											<div class="form-group">
												<label for="" class="col-xs-2 text-right add_form_label">内容</label>
												<div class="col-xs-7">
													<textarea class="form-control" rows="2" ng-model="array[cur].detail" required></textarea>
												</div>
											</div>
											<div class="form-group">
												<div class="col-xs-2 col-xs-offset-2">
													<button type="button" class="col-xs-12 btn btn-success add_save" ng-click="save();">保存</button>
												</div>
												<div class="col-xs-2">
													<button type="button" class="col-xs-12 btn btn-default add_cancel" ng-click="cancel();">取消</button>
												</div>
											</div>
										</div>
									</form>

									<div class="content_info" ng-if="cur==null">
										<ul class="case_box" ng-repeat="item in array">
											<li class="case">
												<div class="row">
													<div class="col-xs-2 " ng-bind="item.title"></div>
													<div class="col-xs-10 reset padding left" ng-bind="item.detail"></div>
												</div>
												<div class="edit_box">
													<button class="text-success case_edit" ng-click="edit(item.id)"><i class="fa fa-pencil"></i>编辑</button>
													<button class="text-success case_del"><i class="fa fa-times"></i>删除</button>

												</div>
												<div class="del_tip">
													<p>确定要删除此条信息吗</p>
													<button class="btn btn-success del_tip_del" ng-click="remove(item.id)">删除</button>
													<button class="btn btn-default del_tip_cancel">取消</button>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>

							<div class="jl_pre jl_bottom ng-scope">
								<div class="row">
									<div style="display:inline-block;padding-left:8px;">
										简历完整度
										<span class="text-success"> ${user.integrity}%</span>
									</div>
									<div style="display:inline-block; float:right; padding-right:8px">
										<a href="resume/preview" target="_blank" class="btn btn-success pull-left"><i class="fa fa-fw fa-eye"></i> 预览</a>
										<a href="resume/create?id=1" target="_blank" class="btn btn-warning pull-right"><i class="fa fa-fw fa-eye"></i> 导出</a>
									</div>
								</div>

								<div class="progress progress-striped row" style="display: block;" id="persent">
									<div class="progress-bar progress-bar-success" role="progressbar" style="width: ${user.integrity}%;"></div>
								</div>
							</div>

						</div>

						<ul class="list-group item_nav nav_float nav " role="tablist" id="item_nav">
							<li class="jl_pre ng-scope">
								<div class="row">
									<div style="display:inline-block;padding-left:8px;">
										简历完整度
										<span class="text-success"> ${user.integrity}%</span>
									</div>
								</div>
								<div class="progress progress-striped row" style="display: block;" id="persent">
									<div class="progress-bar progress-bar-success" role="progressbar" style="width: ${user.integrity}%;"></div>
								</div>
								<div style="overflow: auto">
									<a href="resume/preview" target="_blank" class="btn btn-success pull-left"><i class="fa fa-fw fa-eye"></i> 预览</a>
									<a href="resume/create?id=${user.uid}" target="_blank" class="btn btn-warning pull-right"><i class="fa fa-fw fa-file-pdf-o"></i> 导出</a>
								</div>
							</li>

							<li class="list-group-item active">
								<a href="#base_info" prevent-default="" scroll-to="base_info"><i class="fa  fa-user"></i> 基本信息</a>
							</li>
							<li class="list-group-item">
								<a href="#edu_info" prevent-default="" scroll-to="edu_info"><i class="fa fa-book"></i> 教育背景</a>
							</li>
							<li class="list-group-item">
								<a href="#stu_info" prevent-default="" scroll-to="stu_info"><i class="fa  fa-building-o"></i> 学生工作</a>
							</li>
							<li class="list-group-item">
								<a href="#work_info" prevent-default="" scroll-to="work_info"><i class="fa fa-briefcase"></i> 工作/实习</a>
							</li>
							<li class="list-group-item">
								<a href="#com_info" prevent-default="" scroll-to="com_info"><i class="fa fa-credit-card"></i> 比赛/项目</a>
							</li>
							<li class="list-group-item">
								<a href="#abi_info" prevent-default="" scroll-to="abi_info"><i class="fa fa-bar-chart-o"></i> 个人素质</a>
							</li>
							<li class="list-group-item">
								<a href="#hon_info" prevent-default="" scroll-to="hon_info"><i class="fa  fa-trophy"></i> 荣誉奖励</a>
							</li>
							<!-- <li class="list-group-item">
					         	<a href="#file_info"><i class="fa fa-paperclip  "></i> 附件/作品</a>
					        </li>  -->
							<li class="list-group-item">
								<a href="#oth_info" prevent-default="" scroll-to="oth_info"><i class="fa  fa-picture-o"></i> 其他信息</a>
							</li>
						</ul>

					</div>
				</c:if>
				
				<jsp:include page="../public/footer.jsp"></jsp:include>
				<jsp:include page="../public/modal.jsp"></jsp:include>
				<jsp:include page="../public/head_modal.jsp"></jsp:include>
			
				</div>
			</div>
			
		</div>

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/angular.min.js"></script>
		<script src="assets/js/plugin.min.js"></script>
		<script src="assets/js/app.min.js"></script>
		<script src="assets/js/typeahead.js"></script>
		<script src="js/bootstrap-tagsinput.js"></script>
		<script src="assets/js/webuploader.min.js"></script>
		<script src="assets/js/cropper.js"></script>
		<script src="assets/js/bootstrap-filestyle.js"></script>
		<script src="js/ui-bootstrap-tpls-0.13.0.min.js"></script>
		<script src="js/wdjl.js"></script>
	</body>

</html>
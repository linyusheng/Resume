$(function(){
//	$('.nav-search ul li a:first').css('color','#f76120');
//	var a = $('.nav-search ul li a');
//	a.click(function(){
//		a.css('color','#333');
//		$(this).css('color','#f76120');
//	});
	//给搜索框添加回车事件
	$('#key').bind('keypress',function(event){
		if(event.keyCode == "13"){
			$('#btn-search').trigger("click");
		}
	});
	$('.hot-word-div a').click(function(){
		$('#key').val($(this).text());
		$('#btn-search').trigger("click");
	});
});
App.controller('selectPanel', ['$scope', function ($scope) {
	//选择更多功能块
	$scope.selectedDisplay = ['0','0'];
    $scope.clickMore = function(index) {
    	if($scope.selectedDisplay[index] == '0'){
    		$(".selected-content").eq(index).css('height','auto');
    	}else{
    		$(".selected-content").eq(index).css('height','24px');
    	}
        $scope.selectedDisplay[index] = ($scope.selectedDisplay[index] == '0') ? '1' : '0';
    };
}]);
App.controller('resumeCtrl',['$scope','$http',function($scope,$http){
	//筛选条件
	$scope.pId = 0,$scope.eId = 0;
	$http.get('assets/json/position.json',{cache:true}).success(function(data){
		$scope.positions = data;
		$scope.positions.unshift({"id":0,"name":"不限"});
	});
	$scope.educations = [{'id':0,'name':'不限'},{'id':1,'name':'博士'},{'id':2,'name':'硕士'},{'id':3,'name':'本科'},{'id':4,'name':'大专'}];
	$scope.filter_position = function(p){
		console.info(p);
		$scope.pId = p;
		$scope.search();
	};
	$scope.filter_education = function(e){
		$scope.eId = e;
		$scope.search();
	};
	$scope.resumes = [];
	$scope.pages = [],
	$scope.page = {
		totalRow:0,
		pageSize:10,
		currentPage:1,
		totalPage:0
	};
	//简历搜索
	$scope.search  = function(){
		$('.la-ball-spin-clockwise').show();
		var url = 'resume/search?key='+$('#key').val()+"&currentPage="+$scope.page.currentPage+"&pageSize="+$scope.page.pageSize;
		url += '&positionId='+$scope.pId;
		url += '&educationId='+$scope.eId;
		$http.get(url,{cache: false}).success(function(data){
			$scope.page = data.page;
			$scope.resumes = data.resumes;
			$scope.pages = [];
			if($scope.page.totalPage > 9){
				if($scope.page.currentPage <= 5){
					for(var i = 1;i <= 9;i++){
						$scope.pages.push(i);
					}
				}else{
					if($scope.page.currentPage+4 <= $scope.page.totalPage){
						for(var i = $scope.page.currentPage-4;i <= $scope.page.currentPage+4;i++){
							$scope.pages.push(i);
						}
					}else{
						for(var i = $scope.page.totalPage-9;i <= $scope.page.totalPage;i++){
							$scope.pages.push(i);
						}
					}
				}
			}else{
				for(var i = 1;i <= $scope.page.totalPage;i++){
					$scope.pages.push(i);
				}
			}
			$('.la-ball-spin-clockwise').hide();
		});
	};
	$scope.searchPage = function(p){
		$scope.page.currentPage = p;
		$scope.search();
	};
	$scope.prev = function(){
		if($scope.page.currentPage > 1){
			$scope.page.currentPage--;
			$scope.search();
		}
	};
	$scope.next = function(){
		if($scope.page.currentPage < $scope.page.totalPage){
			$scope.page.currentPage++;
			$scope.search();
		}
	};
	$scope.search();
}]);
//截取字符串里id个数
App.filter('getArrayLength',function(){
	return function(input){
		if(input == '' || input == null){
			return 0;
		}
		return input.split(",").length;
	};
});
//获取职位类型
App.filter('getPosition',function(){
	return function(input){
		if(input == '' || input == null){
			return '无';
		}
		var data = [{"id":"1","name":"财务"},{"id":"2","name":"审计"},{"id":"3","name":"金融"},{"id":"4","name":"技术研发"},{"id":"5","name":"咨询/顾问"},{"id":"6","name":"产品"},{"id":"7","name":"运营"},{"id":"8","name":"质量管理"},{"id":"9","name":"项目管理"},{"id":"10","name":"销售"},{"id":"11","name":"商务拓展"},{"id":"12","name":"渠道/分销"},{"id":"13","name":"客户服务"},{"id":"14","name":"市场营销"},{"id":"15","name":"公关"},{"id":"16","name":"生产/制造"},{"id":"17","name":"编辑/文案"},{"id":"18","name":"管理"},{"id":"19","name":"人力资源"},{"id":"20","name":"法律"},{"id":"21","name":"行政"},{"id":"22","name":"教师"},{"id":"23","name":"培训"},{"id":"24","name":"贸易/进出口"},{"id":"25","name":"采购"},{"id":"26","name":"物流/供应链"},{"id":"27","name":"医疗/健康"},{"id":"28","name":"艺术"},{"id":"29","name":"设计/创意"},{"id":"30","name":"工程"},{"id":"31","name":"物业管理"},{"id":"32","name":"科研"},{"id":"33","name":"翻译"},{"id":"34","name":"公务员"},{"id":"35","name":"技术支持"},{"id":"36","name":"其他"}];
		var p = [];
		var s = input.split(";");
		for(var i = 0;i < s.length; i++){
			p.push(data[s[i]-1].name);
		}
		
		return p.toString();
	};
});
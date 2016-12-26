App.controller('resumeCtrl',['$scope','$http',function($scope,$http){
	$scope.uid = $('#uid').html();
	$scope.b = JSON.parse($('#b').html());
	if($scope.uid == ''){
		$scope.isShow = false;
	}else{
		if($scope.uid == $scope.b.uid){
			$scope.isShow = false;
		}else{
			$scope.isShow = true;
			$scope.isCollect = false;
			var ids = $scope.b.collectNum.split(",");
			ids.forEach(function(v){
				if(v == $scope.uid){
					$scope.isCollect = true;
				}
			});
		}
	}
	
	$scope.collect = function(){
		var ids = $scope.b.collectNum.split(",");
		if($scope.isCollect){
			ids.splice($.inArray($scope.uid,ids),1);
		}else{
			ids.push($scope.uid);
		}
		var url = 'resume/updateCollect?id='+$scope.b.id+"&collectNum="+ids.toString();
		$http.get(url,{cache:false}).success(function(r){
			$scope.b.collectNum = ids.toString();
		});
		$scope.isCollect = !$scope.isCollect;
	};
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
App.controller('guideCtrl',['$scope','$http',function($scope,$http){
	$scope.guides = [];
	$http.get('guide/get',{cache:true}).success(function(data){
		//将数据划分为4列
		var i = data.length % 4;
		var j = parseInt(data.length / 4);
		$scope.guides.push(data.slice(0,j+i));
		$scope.guides.push(data.slice(j+i,j*2+i));
		$scope.guides.push(data.slice(j*2+i,j*3+i));
		$scope.guides.push(data.slice(j*3+i,j*4+i));
		
	});
}]);
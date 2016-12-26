
App.controller('SaveList', ['$scope','$http', function($scope,$http) {
	$scope.pageSize = 10;
	$scope.saveList = JSON.parse($('#saveList').html());
	$scope.currentPage = 0;
	$scope.itemCount = $scope.saveList.length;
	$scope.pageCount = Math.ceil($scope.itemCount/$scope.pageSize);
	$scope.currentType = '';

	$scope.typeArr = [
		{id:'', string:'全部收藏'},
		{id:'mb', string:'模板'},
		{id:'sp', string:'商品'},
		{id:'rz', string:'日志'},
	];

	$scope.setItemCount = function() {
		if ($scope.currentType == '') {
			$scope.itemCount = $scope.saveList.length;
		} else {
			var count = 0;
			$scope.saveList.forEach(function(i) {
				if (i.kind == $scope.currentType)
					count += 1;
				$scope.itemCount = count;
			});
		}
		$scope.pageCount = Math.ceil($scope.itemCount/$scope.pageSize);
	};

	$scope.setCurrentType = function(id) {
		$scope.currentType = id;
		$scope.currentPage = 0;
		$scope.setItemCount();
	};

	$scope.setCurrentPage = function(page) {
		if (page<0 || page>=$scope.pageCount)
			return ;
		$scope.currentPage = page;
	};

	$scope.openNew = function(url) {
		window.open(url);
	};
	
	$scope.cancel = function(id){
		var url = "collect/cancel?id="+id;
		$http.get(url,{cache:false}).success(function(r){
			$scope.saveList = r;
		});
	};
	
	
}]);

App.filter('typeStrFilter', function() {
	return function(index) {
		var typeStrArr = {'':'全部收藏', 'mb':'模板', 'sp':'商品', 'rz':'日志'};
		return typeStrArr[index];
	};
});

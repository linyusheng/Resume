
App.controller('AlertList', ['$scope', '$http', function($scope, $http) {
	$scope.pageSize = 10;
	$scope.alertList = JSON.parse($('#alertList').html());
	$scope.currentPage = 0;
	$scope.itemCount = $scope.alertList.length;
	$scope.pageCount = Math.ceil($scope.itemCount/$scope.pageSize);
	$scope.currentType = 0;
	$scope.typeUnreadCount = {0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0};
	$scope.showDetail = false;
	$scope.a = {};

	$scope.updateTypeUnreadCount = function() {
		$scope.typeUnreadCount = {0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0};
		$scope.alertList.forEach(function(i) {
			if (i.isreaded == 0) {
				$scope.typeUnreadCount[0] += 1;
				$scope.typeUnreadCount[i.kind] += 1;
			}
		});
	};
	$scope.updateTypeUnreadCount();

	$scope.typeArr = [
		{id:'0', string:'全部消息', icon:'fa-bell'},
		{id:'1', string:'系统消息', icon:'fa-cog'},
		{id:'2', string:'订阅消息', icon:'fa-envelope'},
		{id:'3', string:'简历消息', icon:'fa-file-text-o'},
		{id:'4', string:'留言消息', icon:'fa-comment'},
		{id:'5', string:'评论消息', icon:'fa-comments'},
	];

	$scope.setItemCount = function() {
		if ($scope.currentType == 0) {
			$scope.itemCount = $scope.alertList.length;
		} else {
			var count = 0;
			$scope.alertList.forEach(function(i) {
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
		$scope.showDetail = false;
	};

	$scope.setCurrentPage = function(page) {
		if (page<0 || page>=$scope.pageCount)
			return ;
		$scope.currentPage = page;
	};

	$scope.openNew = function(url) {
		window.open(url);
	};
	
	$scope.showAlert = function(alert){
		$scope.a = alert;
		$scope.showDetail = true;
	};
	

	$scope.param = {};
	$scope.readAlert = function(id) {
		for (var i=0; i<$scope.alertList.length; i++) {
			if ($scope.alertList[i].id == id) {
				if ($scope.alertList[i].isreaded == 0) {
					$scope.alertList[i].isreaded = 1;
					$scope.communicate(id);
				}
			}
		}
		$scope.updateTypeUnreadCount();
	};
	$scope.markAllAlertRead = function() {
		var ids = [];
		for (var i=0; i<$scope.alertList.length; i++) {
			if($scope.currentType != 0){
				if ($scope.alertList[i].isreaded == 0 && $scope.alertList[i].kind == $scope.currentType) {
					$scope.alertList[i].isreaded = 1;
					ids.push($scope.alertList[i].id);
				}
			}else{
				if ($scope.alertList[i].isreaded == 0) {
					$scope.alertList[i].isreaded = 1;
					ids.push($scope.alertList[i].id);
				}
			}
		}
		if (ids.length)
			$scope.communicate(ids);
		$scope.updateTypeUnreadCount();
	};
	$scope.communicate = function(viewIds){
		var homeUrl = $('body').data('home-url');
		var ajaxUrl = homeUrl + "notice/markRead";
		var params = {};
		params.view = viewIds.toString();
		$http({method: 'GET', url:ajaxUrl, params:params }).success(function(data){
			if (data.error) {
				console.log(data.error);
			}
		});
	};

}]);

App.filter('typeStrFilter', function() {
	return function(index) {
		var typeStrArr = {'0':'全部消息', '1':'系统消息','2':'订阅消息', '3':'简历消息', '4':'留言消息', '5':'评论消息'};
		return typeStrArr[index];
	};
});

App.filter('icoFilter', function() {
	return function(index) {
		var iconArr = {'0':'fa-bell', '1':'fa-cog', '2':'fa-envelope', '3':'fa-file-text-o', '4':'fa-comment', '5':'fa-comments'};
		return iconArr[index];
	};
});

App.filter('infoFilter', ['$sce', function($sce) {
	return function(info) {
		return $sce.trustAsHtml(info.replace(/<s>/g, " <span class='color'>").replace(/<\/s>/g, " </span>"));
	};
}]);

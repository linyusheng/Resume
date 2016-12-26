$(function(){
	//给搜索框添加回车事件
	$('#key').bind('keypress',function(event){
		if(event.keyCode == "13"){
			$('#btn-search').trigger("click");
		}
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
App.controller('goodsCtrl',['$scope','$http',function($scope,$http){
	//筛选条件
	$scope.pId = 0,$scope.tId = 0,$scope.order = 0;
	$scope.pointScope = [{'id':0,'name':'不限'},{'id':1,'name':'1-100'},{'id':2,'name':'100-300'},{'id':3,'name':'300-500'},{'id':4,'name':'500-1000'},{'id':5,'name':'1000以上'}];
	$http.get('assets/json/gtype.json',{cache:true}).success(function(data){
		$scope.types = data;
		$scope.types.unshift({"id":0,"name":"不限"});
	});
	$scope.filter_point = function(p){
		$scope.pId = p;
		$scope.search();
	};
	$scope.filter_type = function(t){
		$scope.tId = t;
		$scope.search();
	};
	$scope.sort = function(o){
		$scope.order = o;
		$scope.search();
	};
	//商品列表
	$scope.goods = [];
	$scope.pages = [],
	$scope.page = {
		totalRow:0,
		pageSize:10,
		currentPage:1,
		totalPage:0
	};
	$scope.search = function(){
		$('.la-ball-spin-clockwise').show();
		var url = 'store/search?key='+$('#key').val();
		url += "&pId="+$scope.pId;
		url += "&tId="+$scope.tId;
		url += "&currentPage="+$scope.page.currentPage;
		url += "&pageSize="+$scope.page.pageSize;
		url += "&order="+$scope.order;
		$http.get(url,{cache:false}).success(function(data){
			$scope.page = data.page;
			$scope.goods = data.goods;
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
	//商品兑换
	$scope.myPoint = $('#myPoint').text();
	$scope.count = 1;
	$scope.address = '';
	$scope.curGoods = {};
	$scope.exchange = function(g){
		$scope.curGoods = g;
		if(g.gnum == 0){
			$scope.errorMessage = '* 此商品已无库存';
			$scope.submited = false;
			$('#address').attr('disabled',true);
		}else{
			$('#address').attr('disabled',false);
		}
	};
	$scope.add = function(){
		if($scope.curGoods.gnum > $scope.count){
			$scope.count++;
		}else{
			$scope.count = $scope.curGoods.gnum;
		}
	};
	$scope.minus = function(){
		if($scope.count > 1){
			$scope.count--;
		}else{
			$scope.count = 1;
		}
	};
	$scope.checkCount = function(){
		if($scope.curGoods.gnum < $scope.count){
			$scope.count = $scope.curGoods.gnum;
		}
		if($scope.count < 1){
			$scope.count = 1;
		}
	};
	$scope.submited = false;
	$scope.blur = function(){
		if($scope.address == ''){
			$scope.errorMessage = '* 配送地址不能为空';
			$scope.submited = false;
		}else{
			$scope.errorMessage = '';
			$scope.submited = true;
		}
	};
	$scope.submit = function(){
		var totalPoint = $scope.curGoods.gpoint * $scope.count;
		if($scope.myPoint < totalPoint){
			$scope.errorMessage = '* 用户积分不足';
			return;
		}
		$scope.loading = true;
		var params = {gid:$scope.curGoods.gid,num:$scope.count,address:$scope.address};
		$http({method: 'GET', url: 'store/exchange', params: params}).success(function (data) {
			$scope.loading = false;
			if(data.state == 'bad'){
				$scope.errorMessage = '* ' + data.exception;
			}else{
				$('#exchangeModal').modal('hide');
				globalAlert('兑换成功！');
				setTimeout("location.reload()",1000);
			}
		}).error(function (data) {
			$scope.loading = false;
			
		});
	};
	$scope.cancel = function(){
		$scope.count = 1;
		$scope.address = '';
		$scope.errorMessage = '';
		$scope.submited = true;
	};
}]);
//截取字符串长度
App.filter('split',function(){
	return function(input){
		if(input == null || input == ''){
			return '';
		}
		if(input.length > 30){
			return input.substring(0,30);
		}else{
			return input;
		}
	};
});
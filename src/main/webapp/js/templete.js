$(function(){
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
	//收藏
	$('#mainInfoTable').on('click','.preach-tbody-sc-icon',function(){
		var icon = $(this);
		var tid = icon.data('id');
		var collect = icon.attr('data-collect');
		var d = {tid:tid,kind:'mb',s:collect};
		$.post("collect/merge",d,function(r){
			if(collect == "yes"){
				icon.removeClass('fa-star').addClass("fa-star-o");
				icon.attr('data-collect',"no");
			}else{
				icon.removeClass('fa-star-o').addClass("fa-star");
				icon.attr('data-collect',"yes");
			}
		});
	});
});
App.controller('templeteUploadCtrl',['$scope','$http',function($scope,$http){
	$http.get('assets/json/type.json',{cache:true}).success(function(data){
		$scope.types = data;
	});
}]);
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
App.controller('templeteCtrl',['$scope','$http',function($scope,$http){
	//专业类型
	$http.get('assets/json/type.json',{cache:true}).success(function(data){
		$scope.types = data;
		$scope.types.unshift({"tid":0,"tname":"不限"});
	});

	$scope.param1 = 0;
	$scope.param2 = 0;
	
	$scope.filter1 = function(v){
		$scope.param1 = v;
		$scope.search();
	};
	
	$scope.templetes = [],
	$scope.pages = [],
	$scope.page = {
		totalRow:0,
		pageSize:10,
		currentPage:1,
		totalPage:0
	};
	
	$scope.search = function(){
		var uid = $('#uid').html();
		if(uid !== ''){
			//查找用户模板收藏
			$http.get('collect/findByKind?kind=mb',{cache:false}).success(function(data){
				$scope.collects = data;
			});
		}
		
		$('.la-ball-spin-clockwise').show();
		var url = 'templete/search?key='+$('#key').val()+"&currentPage="+$scope.page.currentPage+"&pageSize="+$scope.page.pageSize;
		url += "&p1="+$scope.param1;
		$http.get(url,{cache: false}).success(function(data){
			$scope.page = data.page;
			$scope.templetes = data.templetes;
			//时间截取
			for(var i in $scope.templetes){
				var s = $scope.templetes[i].tpTime.split(' ');
				$scope.templetes[i].tpTime = s[0];
			}
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
	$scope.isCollect = function(id){
		var r = false;
		for(var i=0;i<$scope.collects.length;i++){
			if(id == $scope.collects[i].tid){
				r = true;
				break;
			}
		}
		return r;
	};
	
	$scope.search();
	
}]);

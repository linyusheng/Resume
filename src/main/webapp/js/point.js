
App.controller('ExpTable', ['$scope', function ($scope) {
        var data = JSON.parse($('#pointData').html());

        $scope.point = data.point;

        $scope.resume = data.resume;
        $scope.pclogin = data.pclogin;
        $scope.read = data.read;
        $scope.applogin = data.applogin;
    }]);

App.controller('Posttimes', ['$scope', '$http', function ($scope, $http) {
        var data = JSON.parse($('#pointData').html());
        $scope.myPoint = data.point;
        $scope.point = 1;
        $scope.$watch(
                function ($scope) {
                    $scope.posttimes = 5 * $scope.point;
                }
        );
        $scope.submit = function () {
            var homeUrl = $('body').data('home-url');
            var ajaxUrl = homeUrl + "ajax/charge";
            var params = {};
            params.point = $scope.point;
            //var info = JSON.parse($('#myInfo').html());
            //params.uid = info.uid;
            $scope.loading = true;
            $http({method: 'GET', url: ajaxUrl, params: params})
                    .success(function (data) {
                        $scope.loading = false;
                        console.log(data);
                        if (data.state.state == 'Bad') {
                            $scope.errorMessage = "* " + data.exception.ex;
                        }
                        else
                        {
                            $scope.errorMessage = '';
                            $('#pointModal').modal('hide')
                            globalAlert('兑换成功');
                            $scope.myPoint -= 1;
                            //window.location.reload();
                        }
                        //window.location.href = '';
                    })
                    .error(function (data) {
                        $scope.loading = false;
                        $scope.errorMessage = "* 服务器错误";
                        console.log(data);
                    });
        };
    }]);

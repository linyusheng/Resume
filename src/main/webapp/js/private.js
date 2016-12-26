
App.directive('passwordCorrect', [function () {
        return {
            require: 'ngModel',
            link: function (scope, ele, attrs, ctrl) {
                scope.$watch('value.oldPassword', function () {
                    ctrl.$setValidity('correct', true);
                });
            }
        }
    }]);

App.directive('passwordStrength', [function () {
        return {
            require: 'ngModel',
            link: function (scope, ele, attrs, ctrl) {
                var measureStrength = function (p) {
                    if (((/^\d+$/).exec(p) != null) || (p.length < 6)) {
                        return 1;
                    } else if (((/\d/).exec(p) != null) && ((/\w/).exec(p) != null) && ((/[^\w]/).exec(p) != null) || (p.length > 12)) {
                        return 3;
                    } else {
                        return 2;
                    }
                };

                scope.$watch(attrs.ngModel, function () {
                    var password = scope.value.newPassword;
                    if (typeof (password) == 'string') {
                        scope.strength = measureStrength(password);
                        ctrl.$setValidity('strength', scope.strength >= 2);
                    }
                });
            }
        }
    }]);

App.directive('passwordMatch', [function () {
        return {
            require: 'ngModel',
            link: function (scope, ele, attrs, ctrl) {
                scope.$watchCollection('[value.newPassword, value.confirmPassword]', function () {
                    var match = (scope.value.newPassword == scope.value.confirmPassword);
                    scope.match = match;
                    ctrl.$setValidity('match', match);
                });
            }
        }
    }]);

App.directive('myrequired', [function () {
        return {
            //restrict: 'A',
            require: 'ngModel',
            link: function (scope, ele, attrs, ctrl) {
                scope.$watch(attrs.ngModel, function () {
                    ctrl.$setValidity('required', ctrl.$modelValue);
                });
            }
        }
    }]);

App.controller('tradeList', ['$scope', '$http', function ($scope, $http) {
        $scope.list = [];
        var info = JSON.parse($('#personalInfo').html());
        if (info.trade == '') {
            $scope.selectedIds = [];
        } else {
            if (info.trade[0] == ';') {
                info.trade = info.trade.substring(0, 1);
            }
            $scope.selectedIds = info.trade.split(';');
        }

        $scope.selectedItems = [];
        $scope.selectedNames = [];
        $scope.displayValue = '';

        $http.get('assets/json/trade.json', {cache: true}).success(function (data) {
            var tmpData = {};
            data.trade.forEach(function (item) {
                if (!(item.type in tmpData))
                    tmpData[item.type] = [];
                item.id = item.type + ':' + item.id;
                tmpData[item.type].push(item);
            });
            var mergeData = [];

            data.list.forEach(function (item) {
                mergeData.push({title: item.name, items: tmpData[item.id]});
            });
            $scope.list = mergeData;

            $scope.selectedIds.forEach(function (id) {
                data.trade.forEach(function (item) {
                    if (id == item.id) {
                        $scope.selectedNames.push(item.name);
                        $scope.selectedItems.push(item);
                    }
                });
            });

            $scope.$parent.value.trade = $scope.selectedIds;
            $scope.displayValue = $scope.selectedNames.join(', ');
        });
        $scope.click = function (item, $event) {
            var index = $scope.selectedIds.indexOf(item.id);
            if (index != -1) {
                $scope.selectedItems.splice(index, 1);
                $scope.selectedIds.splice(index, 1);
                $scope.selectedNames.splice(index, 1);
            } else {
                if ($scope.selectedItems.length < 5) {
                    $scope.selectedItems.push(item);
                    $scope.selectedIds.push(item.id);
                    $scope.selectedNames.push(item.name);
                }
            }
            $scope.displayValue = $scope.selectedNames.join(', ');
            $scope.$parent.value.trade = $scope.selectedIds;
            $scope.$parent.workIntent.$setDirty();
            $event.stopPropagation();
        };
        $scope.isSelected = function (item) {
            return ($scope.selectedIds.indexOf(item.id) != -1);
        }
    }]);

App.controller('positionList', ['$scope', '$http', function ($scope, $http) {
        $scope.list = [];
        var info = JSON.parse($('#personalInfo').html());
        if (info.position == '') {
            $scope.selectedIds = [];
        } else {
            if (info.position[0] == ';') {
                info.position = info.position.substring(0, 1);
            }
            $scope.selectedIds = info.position.split(';');
        }

        $scope.selectedItems = [];
        $scope.selectedNames = [];
        $scope.displayValue = '';
        $http.get('assets/json/position.json', {cache: true}).success(function (data) {
            $scope.list = data;

            $scope.selectedIds.forEach(function (id) {
                data.forEach(function (item) {
                    if (id == item.id) {
                        $scope.selectedNames.push(item.name);
                        $scope.selectedItems.push(item);
                    }
                });
            });

            $scope.$parent.value.position = $scope.selectedIds;
            $scope.displayValue = $scope.selectedNames.join(', ');
        });
        $scope.click = function (item, $event) {
            var index = $scope.selectedIds.indexOf(item.id);
            if (index != -1) {
                $scope.selectedItems.splice(index, 1);
                $scope.selectedIds.splice(index, 1);
                $scope.selectedNames.splice(index, 1);
            } else {
                if ($scope.selectedItems.length < 5) {
                    $scope.selectedItems.push(item);
                    $scope.selectedIds.push(item.id);
                    $scope.selectedNames.push(item.name);
                }
            }
            $scope.displayValue = $scope.selectedNames.join(', ');
            $scope.$parent.value.position = $scope.selectedIds;
            $scope.$parent.workIntent.$setDirty();
            $event.stopPropagation();
        };
        $scope.isSelected = function (item) {
            return ($scope.selectedIds.indexOf(item.id) != -1);
        }
    }]);

App.controller('cityList', ['$scope', '$http', function ($scope, $http) {
        $scope.list = [];
        var info = JSON.parse($('#personalInfo').html());
        if (info.city == '') {
            $scope.selectedIds = [];
        } else {
            if (info.city[0] == ';') {
                info.city = info.city.substring(0, 1);
            }
            $scope.selectedIds = info.city.split(';');
        }

        $scope.selectedItems = [];
        $scope.selectedNames = [];
        $scope.displayValue = '';
        $http.get('assets/json/city.json', {cache: true}).success(function (data) {
            var mergeData = [];
            data.list.forEach(function (item) {
                if (item == 'hot') {
                    mergeData.push({title: '热门城市', items: data.city[item]});
                } else {
                    mergeData.push({title: item, items: data.city[item]});
                }
            });
            $scope.list = mergeData;

            $scope.selectedIds.forEach(function (id) {
                data.list.forEach(function (cate) {
                    data.city[cate].forEach(function (item) {
                        if (id == item.id && $scope.selectedNames.indexOf(item.name) == -1) {
                            $scope.selectedNames.push(item.name);
                            $scope.selectedItems.push(item);
                        }
                    });
                });
            });

            $scope.$parent.value.city = $scope.selectedIds;
            $scope.displayValue = $scope.selectedNames.join(', ');
        });
        $scope.click = function (item, $event) {
            var index = $scope.selectedIds.indexOf(item.id);
            if (index != -1) {
                $scope.selectedItems.splice(index, 1);
                $scope.selectedIds.splice(index, 1);
                $scope.selectedNames.splice(index, 1);
            } else {
                if ($scope.selectedItems.length < 5) {
                    $scope.selectedItems.push(item);
                    $scope.selectedIds.push(item.id);
                    $scope.selectedNames.push(item.name);
                }
            }
            $scope.displayValue = $scope.selectedNames.join(', ');
            $scope.$parent.value.city = $scope.selectedIds;
            $scope.$parent.workIntent.$setDirty();
            $event.stopPropagation();
        };
        $scope.isSelected = function (item) {
            return ($scope.selectedIds.indexOf(item.id) != -1);
        }
    }]);

App.controller('modifyPasswordController', ['$scope', '$http', function ($scope, $http) {
        $scope.errors = {
            passwordCorrect: "原始密码错误",
            passwordRequired: "请输入密码",
            passwordStrength: "密码安全性较低",
            confirmPasswordRequired: "请再次输入密码",
            confirmPasswordMatch: "两次密码不一致"
        };

        var info = JSON.parse($('#personalInfo').html());
        $scope.uid = info.uid;
        $scope.email = info.email;

        $scope.submitted = false;
        $scope.value = {};
        $scope.submit = function () {
            $scope.submitted = true;
            if ($scope.modifyPassword.$valid) {
                var params = {};
                var data = {};
                data.uid = info.uid;
                data.oldPass = hex_md5($scope.value.oldPassword);
                data.pass = hex_md5($scope.value.newPassword);

                $scope.loading = false;
                var homeUrl = $('body').data('home-url');
                var ajaxUrl = homeUrl + "user/modifyPwd";
                $http({method: "post", url: ajaxUrl, params: params, data: data})
                        .success(function (data) {
                            $scope.loading = true;
                            console.log(data);
                            if (data.state == 'Bad') {
                                $scope.errorMessage = "* " + data.exception;
                                $scope.modifyPassword.oldPassword.$setValidity('correct', false);
                            }
                            else
                            {
                                $scope.errorMessage = '';
                                globalAlert('修改成功');
                                $scope.modifyPassword.$setPristine();
                            }
                        })
                        .error(function (data) {
                            $scope.loading = true;
                            console.log(data);
                        });
            } else {
                $('form[name=modifyPassword] input.ng-invalid').first().focus();
            }
        }
    }]);

App.controller('basicInfoController', ['$scope', '$http', function ($scope, $http) {
        var info = JSON.parse($('#personalInfo').html());
        $scope.name = info.name;
        $scope.sex = info.sex;
        $http.get('assets/json/university.json', {cache: true}).success(function (data) {
            for (var i = 0; i < data.university.length; i++) {
                if (data.university[i].id == info.university) {
                    $scope.university = data.university[i].name;
                    break;
                }
            }
        });
        $http.get('assets/json/major.json', {cache: true}).success(function (data) {
            for (var i = 0; i < data.list.length; i++) {
                if (data.list[i].id == info.degree) {
                    $scope.major = data.list[i].name + '-';
                    break;
                }
            }
            for (var i = 0; i < data.major.length; i++) {
                if (data.major[i].id == info.major) {
                    $scope.major += data.major[i].name;
                    break;
                }
            }
        });
        var educationList = {'1': '高中/中专', '2': '大专', '3': '本科', '4': '硕士', '5': '博士'};
        console.info(info.education);
        $scope.education = educationList[info.education];

        //var season = {'0':'春', '1':'秋', undefined:''};
        $scope.graduation = info.graduation.slice(0, 4) + '年';

    }]);

App.controller('workIntentController', ['$scope', '$http', function ($scope, $http) {
        $scope.submitted = false;
        var info = JSON.parse($('#personalInfo').html());
        $scope.value = {};
        $scope.submit = function () {
            $scope.submitted = true;
            if ($scope.workIntent.$valid) {
                var params = {};
                var data = {};
                data.uid = info.uid;
                data.trade = $scope.value.trade;
                data.position = $scope.value.position;
                data.city = $scope.value.city;
                $scope.loading = true;
                var homeUrl = $('body').data('home-url');
                var ajaxUrl = homeUrl + 'resume/modifyPrivate';
                $http({method: "post", url: ajaxUrl, params: params, data: data})
                        .success(function (data) {
                            $scope.loading = false;
                            if (data.state == 'Bad') {
                                $scope.errorMessage = "* " + data.exception;
                            }
                            else
                            {
                                $scope.errorMessage = '';
                                globalAlert('修改成功');
                                $scope.workIntent.$setPristine();
                            }
                        })
                        .error(function (data) {
                            $scope.loading = false;
                            $scope.errorMessage = "* 服务器错误";
                            console.log(data);
                        });
            } else {
                $('form[name=workIntent] input.ng-invalid').first().focus();
            }
        };
        $scope.reset = function () {
            $scope.submitted = false;
            $scope.workIntent.$setPristine();
        }
    }]);

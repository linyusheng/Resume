


$(document).ready(function(){

    //右侧导航栏 滑动
//    $('#kz-web').scrollspy();

    var posflag = false;
    $('#kz-web').scroll(function(){
        if($('#kz-web').scrollTop() > 95){
            if(!posflag){
                $('#item_nav').removeClass('nav_float').addClass('nav_fixed');
                posflag=true;
            }
        }
        else {
            if(posflag){
                $('#item_nav').removeClass('nav_fixed').addClass('nav_float');
                posflag=false;
            }
        }
    });


    //不可同时编辑两个表单
    function btnDisabled(){
//		console.log("disabled");
        $('.add_more').attr('disabled','disabled');
        $('.case_edit').attr('disabled','disabled');
        $('.case_edit').css('cursor','default');
        $('.case_del').attr('disabled','disabled');
        $('.case_del').css('cursor','default');
		$(".add_more").removeClass("add_more_box");
		$(".edit_box").hide();
		$(".case").addClass("disable");
    }
    function btnAbled(){
        $('.add_more').removeAttr('disabled');
        $('.case_edit').removeAttr('disabled');
        $('.case_edit').css('cursor','pointer');
        $('.case_del').removeAttr('disabled');
        $('.case_del').css('cursor','pointer');
		$(".add_more").addClass("add_more_box");
		$(".edit_box").show();
		$(".case").removeClass("disable");
    }
    $(document).on('click', '.add_more', function() {
        btnDisabled();
        $('.content_add').css('display','block')
    });
    $(document).on('click', '.add_save', function() {
        btnAbled();
    });
    $(document).on('click', '.add_cancel', function() {
        btnAbled();
    });
    $(document).on('click', '.case_edit', function() {
        btnDisabled();
    });
    $(document).on('click', '.case_del', function() {
        var del_tip = $(this).parents('.case_box').find('.del_tip');
        del_tip.fadeIn('200');
        del_tip.find('.del_tip_del').click(function(){
            del_tip.fadeOut('200');
        });
        del_tip.find('.del_tip_cancel').click(function(){
            del_tip.fadeOut('200');
        })
    });


    $(document).on('click', '.lang_del', function() {
        $(this).parents('.lang_case').fadeOut('300');
    });
//not-close 
    $(document).on('click', '.not-close', function() {
        return false;
    });
});

//json格式变换
function jsonToArray(jsonList){
    var jsonItems = {};
    for(var jsonNum in jsonList){
        var jsonItem = {};
        jsonItem.id = jsonNum;
        jsonItem.name = jsonList[jsonNum];
        jsonItems[jsonNum] = jsonItem;
    }
    return jsonItems;
}
function yearList(max,len){
    yearLists = [];
    for(var i=0;i<len;i++){
        yearListItem={};
        yearListItem.id = i.toString();
        yearListItem.name = (max-i).toString();
        yearLists.push(yearListItem);
    }
    return yearLists;
}


function dateToArray(date){
    var tempArray = date.split('.');
    var array = new Array(date);
    return array.concat(tempArray);
}
function arrayToDate(array){
    return array[0].toString()
}
var monthList = [ {id:'01',name:'一月'},{id:'02',name:'二月'},{id:'03',name:'三月'},
    {id:'04',name:'四月'},{id:'05',name:'五月'},{id:'06',name:'六月'},
    {id:'07',name:'七月'},{id:'08',name:'八月'},{id:'09',name:'九月'},
    {id:'10',name:'十月'},{id:'11',name:'十一月'},{id:'12',name:'十二月'}
];
var birthYearList = yearList(2005,30); /*2005-1970*/
var otherYearList = yearList(2018,20); /*2018-1998*/

App.directive('myrequired', [function () {
    return {
        //restrict: 'A',
        require: 'ngModel',
        link: function(scope, ele, attrs, ctrl) {
            scope.$watch(attrs.ngModel, function () {
                ctrl.$setValidity('required', ctrl.$modelValue);
            });
        }
    }
}]);
App.directive('datetip', function() {
    return {
        restrict:'AE',

        template:
            "<div class='tip' ng-show='submitted && !dateFlag.status'>"+
                "<span><i class='fa fa-exclamation-circle'></i>结束时间不能早于开始时间</span>"+
                "</div>",
    }
});
App.controller('userCtrl',['$scope','$http',function($scope,$http) {

    $scope.yeardata = {
        years:otherYearList,
        months:monthList,
    }
    // $scope.dateInit= function(){
    // 	$(".date_year").scrollTop(60);
    // 	console.log($(".date_year").scrollTop());
    // }

    //年份 偏移 待定
    //angular ng-click drowdown ??
    $scope.dateInit= function(year){
        $(document).on('click', '.span_date', function() {
            var i = 2015 - year;
            $(".date_year").scrollTop(i*30-50);
        });
    }
    //起始时间 终止时间 判断
    $scope.dateFlag = {
        status:true
    }
    $scope.dateJudge = function(start_time,end_time){
        (start_time>end_time)?($scope.dateFlag.status = false):($scope.dateFlag.status = true)
    }
    $http.get('assets/json/college.json', {cache: true}).success(function(data){
        $scope.unidata = [];
        for(var i=0;i<data.list.length;i++){
            var temData = {};
            temData.id = i;
            temData.name = data.list[i];
            temData.uni = [];
            for(var j=0;j<data.university.length;j++){
                if(data.list[i] == data.university[j].part){
                    temData.uni.push(data.university[j]);

                }
            }
            $scope.unidata.push(temData);
        }
    })

}]);
App.controller('updateBaseCtrl',['$scope','$http',function($scope,$http) {
    var userBaseInfo=JSON.parse($('#baseInfo').text());
    $scope.baseMaster = userBaseInfo;
    $scope.baseInfo = angular.copy($scope.baseMaster);
    $scope.submitted = false;
    $scope.loadBase = {status:false}

    var poliJsonList ={'1':'共青团员','2':'中共党员','3':'群众','4':'民主党员'};
    var poliArrayItems = jsonToArray(poliJsonList);
    $scope.poliItems = poliArrayItems;
    $scope.birthdata = {
        years:birthYearList,
        months:monthList,
    }
    $scope.birthArray = $scope.baseInfo.birthDate?$scope.baseInfo.birthDate.split('-'):['1995','01','01'];

    $scope.editBaseInfo = function(){
        $scope.loadBase.status = true;
    }
    $scope.reset=function(){
        $scope.loadBase.status = false;
        $scope.submitted = false;
        $scope.baseInfo = angular.copy($scope.baseMaster);
    }
    $scope.updateBaseInfo = function(){
        $scope.submitted = true;
        if ($('form[name=updateBaseForm]').hasClass('ng-valid')) {
            $scope.baseMaster= angular.copy($scope.baseInfo);
            $scope.loadBase.status = false;
            var csrf = $('head meta[name=csrf-token]').attr('content');
            console.info($scope.baseMaster);
            $http.post('resume/updateBaseinfo', $scope.baseMaster).success(function(data){
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
            $scope.submitted = false;
        } else {
            $('form[name=updateBaseForm] .ng-invalid').first().focus();
        }
    }
    $scope.dateInit= function(date){
        var year = parseInt(date.substr(0,4));
        $(document).on('click', '.span_date', function() {
            var i = 2000 - year;
            $(".date_year").scrollTop(i*30-50);
        });
    }
}]);

App.controller('eduInfoCtrl',['$scope','$http',function($scope,$http) {
    $scope.cur = null;
    $scope.oriData=JSON.parse($('#eduInfo').text());
    $scope.array=angular.copy($scope.oriData);

    $http.get('assets/json/college.json', {cache: true}).success(function(data){
        for(var i=0;i<$scope.array.length;i++){
            for(var j=0;j<data.university.length;j++){
                if(data.university[j].name == $scope.array[i].college_name){
                    $scope.array[i].college_id = data.university[j].id;
                    for(var k=0;k<data.list.length;k++){
                        if(data.list[k] == data.university[j].part){
                            $scope.array[i].college_prov = k;
                        }
                    }
                }
            }
        }
        $scope.oriData=angular.copy($scope.array);
    });

    $http.get('assets/json/major.json', {cache: true}).success(function(data){
        $scope.majorLists = data.list;
        $scope.majorItems = data.major;
        $scope.majorListClick = function(index){
            $scope.majorMajors = [];
            for(var i=0;i<data.major.length;i++){
                if(data.major[i].degree == index){
                    $scope.majorMajors.push(data.major[i]);
                }
            }
            if($scope.majorMajors.length) {
                var flag = 0;
                for(var j=0;j<$scope.majorMajors.length;j++) {
                    if($scope.majorMajors[j].id == $scope.array[$scope.cur].major_type) {
                        flag = 1;
                    }
                }
                if(flag == 0) {
                    $scope.array[$scope.cur].major_type=$scope.majorMajors[0].id;
                }
            }
        };
        for(var i=0;i<$scope.array.length;i++){
            for(var j=0;j<data.major.length;j++){
                if(data.major[j].id == $scope.array[i].major_type){
                    $scope.array[i].department = data.major[j].degree;
                }
            }
        }
        $scope.oriData=angular.copy($scope.array);

    });
    var eduBgList ={'1':'中专','2':'大专','3':'本科','4':'硕士','5':'博士'};
    var eduBgArrayItems = jsonToArray(eduBgList);
    $scope.eduBgItems = eduBgArrayItems;
    var gradeList ={'1':'前10%','2':'前30%','3':'前50%','4':'其他'};
    var gradeArrayItems = jsonToArray(gradeList);
    $scope.gradeItems = gradeArrayItems;

    $scope.submitted = false;

    $scope.setTime = function(field, year, month){
        if(year) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = year + '.' + $scope.array[$scope.cur][field].substr(5,2);
            } else {
                $scope.array[$scope.cur][field] = year + '.' + '01';
            }
        }
        if(month) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = $scope.array[$scope.cur][field].substr(0,4) + '.' + month;
            } else {
                $scope.array[$scope.cur][field] = '2015' + '.' + month;
            }
        }
        ($scope.array[$scope.cur].start_time>$scope.array[$scope.cur].end_time)?($scope.dateFlag.status = false):($scope.dateFlag.status = true);
    };

    $scope.add = function(){
        $scope.cur = $scope.array.length;
        $scope.array.push({'college_name':'', 'college_prov':0, 'start_time':'2014.09','end_time':'2015.06','department':'','degree':'','rank':'','detail':''});
    };

    $scope.cancel = function(){
        $scope.cur = null;
        $scope.array=angular.copy($scope.oriData);
        $scope.submitted = false;
    };

    $scope.edit = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                $scope.cur = i;
                break;
            }
        }
    };
    $scope.remove = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                var data = {'id':id, '_delete':true};
                $http.post('resume/deleteEduinfo', data).success(function(data){
                    $scope.array.splice(i,1);
                    $scope.oriData=angular.copy($scope.array);
                    if(data.completion) {
                        refreshCompletion(data.completion);
                    }
                });
                break;
            }
        }
    };

    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=eduForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;

            var data = angular.copy($scope.array[$scope.cur]);
            data.start_time = data.start_time.replace('.','-')+'-01';
            data.end_time = data.end_time.replace('.','-')+'-01';
            $http.post('resume/updateEduinfo', data).success(function(data){
            	console.info(data.completion);
                if(data.new_id){
                    $scope.array[$scope.cur].id = data.new_id;
                }
                $scope.oriData=angular.copy($scope.array);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=eduForm] input.ng-invalid').first().focus();
        }
    }

    $scope.nl2br = function(str) {
        return str.replace(new RegExp('\n','gm'),'<br />')
    }

}]);

App.controller('stuInfoCtrl',['$scope','$http',function($scope,$http) {
    $scope.cur = null;
    $scope.oriData=JSON.parse($('#stuInfo').text());
    $scope.array=angular.copy($scope.oriData);

    $http.get('assets/json/college.json', {cache: true}).success(function(data){
        for(var i=0;i<$scope.array.length;i++){
            for(var j=0;j<data.university.length;j++){
                if(data.university[j].name == $scope.array[i].college_name){
                    $scope.array[i].college_id = data.university[j].id;
                    for(var k=0;k<data.list.length;k++){
                        if(data.list[k] == data.university[j].part){
                            $scope.array[i].college_prov = k;
                        }
                    }
                }
            }
        }
        $scope.oriData=angular.copy($scope.array);
    });

    $scope.submitted = false;

    $scope.setTime = function(field, year, month){
        if(year) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = year + '.' + $scope.array[$scope.cur][field].substr(5,2);
            } else {
                $scope.array[$scope.cur][field] = year + '.' + '01';
            }
        }
        if(month) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = $scope.array[$scope.cur][field].substr(0,4) + '.' + month;
            } else {
                $scope.array[$scope.cur][field] = '2015' + '.' + month;
            }
        }
        ($scope.array[$scope.cur].start_time>$scope.array[$scope.cur].end_time)?($scope.dateFlag.status = false):($scope.dateFlag.status = true);
    };

    $scope.add = function(){
        $scope.cur = $scope.array.length;
        $scope.array.push({'college_name':'', 'college_prov':0, 'position':'','department':'','start_time':'2014.09','end_time':'2015.06','performance':''});
    };

    $scope.cancel = function(){
        $scope.cur = null;
        $scope.array=angular.copy($scope.oriData);
        $scope.submitted = false;
    };

    $scope.edit = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                $scope.cur = i;
                break;
            }
        }
    };
    $scope.remove = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                var data = {'id':id, '_delete':true};
                $http.post('resume/deleteStuinfo', data).success(function(data){
                    $scope.array.splice(i,1);
                    $scope.oriData=angular.copy($scope.array);
                    if(data.completion) {
                        refreshCompletion(data.completion);
                    }
                });
                break;
            }
        }
    };


    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=stuForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;

            var data = angular.copy($scope.array[$scope.cur]);
            data.start_time = data.start_time.replace('.','-')+'-01';
            data.end_time = data.end_time.replace('.','-')+'-01';

            $http.post('resume/updateStuinfo', data).success(function(data){
                if(data.new_id){
                    $scope.array[$scope.cur].id = data.new_id;
                }
                $scope.oriData=angular.copy($scope.array);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });

        } else {
            $('form[name=stuForm] input.ng-invalid').first().focus();
        }
    }

    $scope.nl2br = function(str) {
        return str.replace(new RegExp('\n','gm'),'<br />')
    }
}]);


App.controller('jobExperienceCtrl',['$scope','$http',function($scope,$http) {
    $scope.cur = null;
    $scope.oriData=JSON.parse($('#workInfo').text());
    $scope.array=angular.copy($scope.oriData);
    var comSizeList = {'1':'50人以内','2':'50-100人','3':'100-300人','4':'300-1000人','5':'1000-2000人','6':'2000-3000人','7':'3000人以上'};
    var comSizeArrayItems = jsonToArray(comSizeList);
    var typeList = {'1':'全职','2':'兼职','3':'实习'};
    var typeArrayItems = jsonToArray(typeList);
    $scope.submitted = false;

    $scope.comSizeItems = comSizeArrayItems;
    $scope.typeItems = typeArrayItems;

    $scope.setTime = function(field, year, month){
        if(year) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = year + '.' + $scope.array[$scope.cur][field].substr(5,2);
            } else {
                $scope.array[$scope.cur][field] = year + '.' + '01';
            }
        }
        if(month) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = $scope.array[$scope.cur][field].substr(0,4) + '.' + month;
            } else {
                $scope.array[$scope.cur][field] = '2015' + '.' + month;
            }
        }
        ($scope.array[$scope.cur].start_time>$scope.array[$scope.cur].end_time)?($scope.dateFlag.status = false):($scope.dateFlag.status = true);
    };
    $scope.add = function(){
        $scope.cur = $scope.array.length;
        $scope.array.push({'work_type':'1','company_name':'','company_scale':'1','position_name':'','start_time':'2014.09','end_time':'2015.06','detail':''});
    };
    $scope.cancel = function(){
        $scope.cur = null;
        $scope.array=angular.copy($scope.oriData);
        $scope.submitted = false;

    };
    $scope.edit = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                $scope.cur = i;
                break;
            }
        }
    };
    $scope.remove = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                var data = {'id':id, '_delete':true};
                $http.post('resume/deleteWorkinfo', data).success(function(data){
                    $scope.array.splice(i,1);
                    $scope.oriData=angular.copy($scope.array);
                    if(data.completion) {
                        refreshCompletion(data.completion);
                    }
                });
                break;
            }
        }
    };

    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=workForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;

            var data = angular.copy($scope.array[$scope.cur]);
            data.start_time = data.start_time.replace('.','-')+'-01';
            data.end_time = data.end_time.replace('.','-')+'-01';

            $http.post('resume/updateWorkinfo', data).success(function(data){
                if(data.new_id){
                    $scope.array[$scope.cur].id = data.new_id;
                }
                $scope.oriData=angular.copy($scope.array);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=workForm] input.ng-invalid').first().focus();
        }
    }
    $scope.nl2br = function(str) {
        return str.replace(new RegExp('\n','gm'),'<br />')
    }
}]);

App.controller('comInfoCtrl',['$scope','$http',function($scope,$http) {
    $scope.cur = null;
    $scope.oriData=JSON.parse($('#comInfo').text());
    $scope.array=angular.copy($scope.oriData);

    var comSizeList ={'1':'1-3人','2':'4-10人','3':'11-20人','4':'20人以上'};
    $scope.comSizeItems = jsonToArray(comSizeList);
    $scope.submitted = false;

    $scope.setTime = function(field, year, month){
        if(year) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = year + '.' + $scope.array[$scope.cur][field].substr(5,2);
            } else {
                $scope.array[$scope.cur][field] = year + '.' + '01';
            }
        }
        if(month) {
            if($scope.array[$scope.cur] && $scope.array[$scope.cur][field]) {
                $scope.array[$scope.cur][field] = $scope.array[$scope.cur][field].substr(0,4) + '.' + month;
            } else {
                $scope.array[$scope.cur][field] = '2015' + '.' + month;
            }
        }
        ($scope.array[$scope.cur].start_time>$scope.array[$scope.cur].end_time)?($scope.dateFlag.status = false):($scope.dateFlag.status = true);
    };
    $scope.add = function(){
        $scope.cur = $scope.array.length;
        $scope.array.push({'project_name':'','project_scale':'1','project_source':'','position_name':'','start_time':'2014.09','end_time':'2015.06','detail':'',performance:''});
    };
    $scope.cancel = function(){
        $scope.cur = null;
        $scope.array=angular.copy($scope.oriData);
        $scope.submitted = false;
    };
    $scope.edit = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                $scope.cur = i;
                break;
            }
        }
    };
    $scope.remove = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                var data = {'id':id, '_delete':true};
                $http.post('resume/deleteCominfo', data).success(function(data){
                    $scope.array.splice(i,1);
                    $scope.oriData=angular.copy($scope.array);
                    if(data.completion) {
                        refreshCompletion(data.completion);
                    }
                });
                break;
            }
        }
    };

    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=comForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;

            var data = angular.copy($scope.array[$scope.cur]);
            data.start_time = data.start_time.replace('.','-')+'-01';
            data.end_time = data.end_time.replace('.','-')+'-01';

            $http.post('resume/updateCominfo', data).success(function(data){
                if(data.new_id){
                    $scope.array[$scope.cur].id = data.new_id;
                }
                $scope.oriData=angular.copy($scope.array);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=comForm] input.ng-invalid').first().focus();
        }
    };
    $scope.nl2br = function(str) {
        return str.replace(new RegExp('\n','gm'),'<br />')
    }

}]);

App.directive('bootstrapTagsinput', [function() {
    function getItemProperty(scope, property) {
        if (!property)
            return undefined;

        if (angular.isFunction(scope.$parent[property]))
            return scope.$parent[property];

        return function(item) {
            return item[property];
        };
    }

    return {
        restrict: 'EA',
        scope: {
            model: '=ngModel'
        },
        template: '<select multiple></select>',
        replace: false,
        link: function(scope, element, attrs) {
            $(function() {
                if (!angular.isArray(scope.model))
                    scope.model = [];

                var select = $('select', element);
                var typeaheadSourceArray = attrs.typeaheadSource ? attrs.typeaheadSource.split('.') : null;
                var typeaheadSource = typeaheadSourceArray ?
                    (typeaheadSourceArray.length > 1 ?
                        scope.$parent[typeaheadSourceArray[0]][typeaheadSourceArray[1]]
                        : scope.$parent[typeaheadSourceArray[0]])
                    : null;

                select.tagsinput(scope.$parent[attrs.options || ''] || {
                    typeahead : {
                        source   : angular.isFunction(typeaheadSource) ? typeaheadSource : null,
                        matcher: function(){return true},
                        afterSelect: function(val) { console.log(val);this.$element.val(""); },
                        minLength:1,
                        delay:1
                    },
                    maxChars: getItemProperty(scope, attrs.maxChars),
                    maxTags: getItemProperty(scope, attrs.maxTags),
                    trimValue: getItemProperty(scope, attrs.trimValue),
                    itemValue: getItemProperty(scope, attrs.itemvalue),
                    itemText : getItemProperty(scope, attrs.itemtext),
                    confirmKeys : getItemProperty(scope, attrs.confirmkeys) ? JSON.parse(attrs.confirmkeys) : [13,32,188],
                    tagClass : angular.isFunction(scope.$parent[attrs.tagclass]) ? scope.$parent[attrs.tagclass] : function(item) { return attrs.tagclass; }
                });

                for (var i = 0; i < scope.model.length; i++) {
                    select.tagsinput('add', scope.model[i]);
                }

                select.on('itemAdded', function(event) {
                    if (scope.model.indexOf(event.item) === -1){
                        scope.model.push(event.item);
                        scope.$apply();
                    }
                });

                select.on('itemRemoved', function(event) {
                    var idx = scope.model.indexOf(event.item);
                    if (idx !== -1){
                        scope.model.splice(idx, 1);
                        scope.$apply();
                    }
                });

                // create a shallow copy of model's current state, needed to determine
                // diff when model changes
                var prev = scope.model.slice();
                scope.$apply("model", function() {
                    var added = scope.model.filter(function(i) {return prev.indexOf(i) === -1;}),
                        removed = prev.filter(function(i) {return scope.model.indexOf(i) === -1;}),
                        i;
                    prev = scope.model.slice();

                    // Remove tags no longer in binded model
                    for (i = 0; i < removed.length; i++) {
                        select.tagsinput('remove', removed[i]);
                    }

                    // Refresh remaining tags
                    select.tagsinput('refresh');

                    // Add new items in model as tags
                    for (i = 0; i < added.length; i++) {
                        select.tagsinput('add', added[i]);
                    }
                }, true);
            });
        }
    };
}]);


App.controller('personalQualityCtrl',['$scope','$http',function($scope,$http) {

    $scope.cur = null;
    $scope.oriData=JSON.parse($('#abiInfo').text());

    $scope.languageAbility=angular.copy($scope.oriData.languageAbility);
    $scope.itAbility={1:[],2:[]};
    for(var i=0;i<$scope.oriData.itAbility.length;i++){
        $scope.itAbility[$scope.oriData.itAbility[i].ability].push($scope.oriData.itAbility[i].skill);
    }
    $scope.cert=angular.copy($scope.oriData.certificate);
    $scope.char=angular.copy($scope.oriData.character);
    $scope.hobby=angular.copy($scope.oriData.hobby);

    var rank ={'1':'一般','2':'良好','3':'精通'};
    $scope.ranks = jsonToArray(rank);
    $http.get('assets/json/language.json', {cache: true}).success(function(data){
        $scope.langLists = data;
    });

    $scope.addLang = function() {
        $scope.languageAbility.push({'language':'英语','verbal':'1','writing':'1','detail':''});
    };
    $scope.delLang = function(index){
        $scope.languageAbility.splice(index,1);
    };

    $scope.popularLanguage = function(query) {
        return $http({
            url: '/data/language-ability',
            method: "GET",
            params: {query:query}
        });
    };

    $scope.popularIt = function(query) {
        return $http({
            url: '/data/it-ability',
            method: "GET",
            params: {query:query}
        });
    };

    $scope.popularCert = function(query) {
        return $http({
            url: '/data/cert',
            method: "GET",
            params: {query:query}
        });
    };

    $scope.popularChar = function(query) {
        return $http({
            url: '/data/char',
            method: "GET",
            params: {query:query}
        });
    };
    $scope.popularHobby = function(query) {
        return $http({
            url: '/data/hobby',
            method: "GET",
            params: {query:query}
        });
    };

    $scope.cancelLanguageAbility = function(){
        $scope.cur = null;
        $scope.languageAbility=angular.copy($scope.oriData.languageAbility);
        $scope.submitted = false;
    };
    $scope.updateLanguageAbility = function(){
        $scope.submitted = true;
        var form = $('form[name=langForm]');
        if (form.hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;
            var data = $scope.languageAbility;
            $http.post('resume/updateAbility?field=languageAbility', data).success(function(data){
                $scope.oriData.languageAbility=angular.copy(data);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }

            });
        } else {
            form.find('input.ng-invalid').first().focus();
        }
    };

    $scope.cancelItAbility = function(){
        $scope.cur = null;
        $scope.itAbility={1:[],2:[]};
        for(var i=0;i<$scope.oriData.itAbility.length;i++){
            $scope.itAbility[$scope.oriData.itAbility[i].ability].push($scope.oriData.itAbility[i].skill);
        }
        $scope.submitted = false;
    };
    $scope.updateItAbility = function(){
        $scope.submitted = true;
        var form = $('form[name=itForm]');
        if (form.hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;
            var data = [];
            for(var i=0;i<$scope.itAbility[1].length;i++) {
                data.push({ability:1,skill:$scope.itAbility[1][i]})
            }
            for(var i=0;i<$scope.itAbility[2].length;i++) {
                data.push({ability:2,skill:$scope.itAbility[2][i]})
            }
            $http.post('resume/updateAbility?field=itAbility', data).success(function(data){
                $scope.oriData.itAbility=angular.copy(data);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            form.find('input.ng-invalid').first().focus();
        }
    };

    $scope.cancelCert = function(){
        $scope.cur = null;
        $scope.cert=angular.copy($scope.oriData.certificate);
        $scope.submitted = false;
    };
    $scope.updateCert = function(){
        $scope.submitted = true;
        var form = $('form[name=certForm]');
        if (form.hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;
            var data = $scope.cert;
            $http.post('resume/updateAbility?field=certificate', data).success(function(data){
                $scope.oriData.certificate=angular.copy($scope.cert);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            form.find('input.ng-invalid').first().focus();
        }
    };

    $scope.cancelChar = function(){
        $scope.cur = null;
        $scope.char=angular.copy($scope.oriData.character);
        $scope.submitted = false;
    };
    $scope.updateChar = function(){
        $scope.submitted = true;
        var form = $('form[name=charForm]');
        if (form.hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;
            var data = $scope.char;
            $http.post('resume/updateAbility?field=characters', data).success(function(data){
                $scope.oriData.character=angular.copy($scope.char);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            form.find('input.ng-invalid').first().focus();
        }
    };

    $scope.cancelHobby = function(){
        $scope.cur = null;
        $scope.hobby=angular.copy($scope.oriData.hobby);
        $scope.submitted = false;
//        $('form[name=hobbyForm] bootstrap-tagsinput').tagsinput('refresh');
    };
    $scope.updateHobby = function(){
        $scope.submitted = true;
        var form = $('form[name=hobbyForm]');
        if (form.hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;
            var data = $scope.hobby;
            $http.post('resume/updateAbility?field=hobby', data).success(function(data){
                $scope.oriData.hobby=angular.copy($scope.hobby);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=hobbyForm] input.ng-invalid').first().focus();
        }
    };
}]);

App.controller('honInfoCtrl',['$scope','$http',function($scope,$http) {
    $scope.open = false;
    $scope.oriData=JSON.parse($('#honInfo').text());
    $scope.info=angular.copy($scope.oriData);
    $scope.submitted = false;

    $scope.add = function(){
        $scope.open = true;
        if(!$scope.info) {
        $scope.info = {world_prize:'',national_prize:'',province_prize:'',college_prize:'',other_prize:''};
        }
    };
    $scope.cancel = function(){
        $scope.open = false;
        $scope.info=angular.copy($scope.oriData);
        $scope.submitted = false;
    };
    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=honForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;
            var data = angular.copy($scope.info);
            $http.post('resume/updateHoninfo', data).success(function(data){
                $scope.oriData=angular.copy($scope.info);
                $scope.open = false;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=honForm] input.ng-invalid').first().focus();
        }
    };

}]);
//angular.module('App', ['ngFileUpload']);
App.controller('fileInfoCtrl',['$scope','$http', function($scope,$http) {
    $scope.cur = null;
    $scope.oriData=JSON.parse($('#fileInfo').text());
    $scope.array=angular.copy($scope.oriData);

    $scope.submitted = false;

    $scope.add = function(){
        $scope.cur = $scope.array.length;
        $scope.array.push({'title':'','detail':''});
    };
    $scope.cancel = function(){
        $scope.cur = null;
        $scope.array=angular.copy($scope.oriData);
        $scope.submitted = false;
    };
    $scope.edit = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                $scope.cur = i;
                break;
            }
        }
    };
    $scope.remove = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                var data = {'id':id, '_delete':true};
                $http.post('/update/attachment', data).success(function(data){
                    $scope.array.splice(i,1);
                    $scope.oriData=angular.copy($scope.array);
                    if(data.completion) {
                        refreshCompletion(data.completion);
                    }
                });
                break;
            }
        }
    };

    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=fileForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;

            var data = angular.copy($scope.array[$scope.cur]);

            $http.post('/update/attachment', data).success(function(data){
                if(data.new_id){
                    $scope.array[$scope.cur].id = data.new_id;
                }
                $scope.oriData=angular.copy($scope.array);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=othForm] input.ng-invalid').first().focus();
        }
    };
}]);
App.controller('othInfoCtrl',['$scope','$http',function($scope,$http) {
    $scope.cur = null;
    $scope.oriData=JSON.parse($('#othInfo').text());
    $scope.array=angular.copy($scope.oriData);

    $scope.submitted = false;

    $scope.add = function(){
        $scope.cur = $scope.array.length;
        $scope.array.push({'title':'','detail':''});
    };
    $scope.cancel = function(){
        $scope.cur = null;
        $scope.array=angular.copy($scope.oriData);
        $scope.submitted = false;
    };
    $scope.edit = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                $scope.cur = i;
                break;
            }
        }
    };
    $scope.remove = function(id){
        for(var i=0;i<$scope.array.length;i++){
            if ($scope.array[i].id == id){
                var data = {'id':id, '_delete':true};
                $http.post('resume/deleteOthinfo', data).success(function(data){
                    $scope.array.splice(i,1);
                    $scope.oriData=angular.copy($scope.array);
                    if(data.completion) {
                        refreshCompletion(data.completion);
                    }
                });
                break;
            }
        }
    };

    $scope.save = function(){
        $scope.submitted = true;
        if ($('form[name=othForm]').hasClass('ng-valid') && $scope.dateFlag.status) {
            $scope.submitted = false;

            var data = angular.copy($scope.array[$scope.cur]);

            $http.post('resume/updateOthinfo', data).success(function(data){
                if(data.new_id){
                    $scope.array[$scope.cur].id = data.new_id;
                }
                $scope.oriData=angular.copy($scope.array);
                $scope.cur = null;
                if(data.completion) {
                    refreshCompletion(data.completion);
                }
            });
        } else {
            $('form[name=othForm] input.ng-invalid').first().focus();
        }
    };

}]);
App.controller('headUploadCtrl',['$scope','$http',function($scope,$http) {
	var userBaseInfo=JSON.parse($('#baseInfo').text());
	$scope.face_large_full_url = userBaseInfo.face_large_full_url;
}]);



(function( factory ) {
    if ( !window.jQuery ) {
        alert('jQuery is required.')
    }

    jQuery(function() {
        factory.call( null, jQuery );
    });
})(function( $ ) {
// -----------------------------------------------------
// ------------ START ----------------------------------
// -----------------------------------------------------


    var uploaders = $('.webuploader-cropper');
    var swf_url = uploaders.data('swf-url'),
        server_url = uploaders.data('server-url');
    uploaders.each(function(){
        //console.log($(this));
        var image_id = $(this).find('input:hidden').attr('id');
        var preview = $(this).find('.'+image_id+'-img-preview');
        var widthpx = preview.css('width');
        var heightpx = preview.css('height');
        var thumb_size = [widthpx.substring(0,widthpx.length-2), heightpx.substring(0,heightpx.length-2)];


// ---------------------------------
// ---------  Uploader -------------
// ---------------------------------
        var Uploader1 = (function() {

            // -------setting-------
            // 如果使用原始大小，超大的图片可能会出现 Cropper UI 卡顿，所以这里建议先缩小后再crop.
            var FRAME_WIDTH = 400;

            var _ = WebUploader;
            var Uploader = _.Uploader;
            var uploader, file;

            if ( !Uploader.support() ) {
                alert( 'Web Uploader 不支持您的浏览器！');
                throw new Error( 'WebUploader does not support the browser you are using.' );
            }

            // hook,
            // 在文件开始上传前进行裁剪。
            Uploader.register({
                'before-send-file': 'cropImage'
            }, {

                cropImage: function( file ) {

                    var data = file._cropData,
                        image, deferred;

                    file = this.request( 'get-file', file );
                    deferred = _.Deferred();

                    image = new _.Lib.Image();

                    deferred.always(function() {
                        image.destroy();
                        image = null;
                    });
                    image.once( 'error', deferred.reject );
                    image.once( 'load', function() {
                        data.scale = data.scale * thumb_size[0] / data.width;
                        data.x = data.x * thumb_size[0] / data.width;
                        data.y = data.y * thumb_size[0] / data.width;
                        data.width = thumb_size[0];
                        data.height = thumb_size[1];
                        image.crop( data.x, data.y, data.width, data.height, data.scale );
                    });

                    image.once( 'complete', function() {
                        var blob, size;

                        // 移动端 UC / qq 浏览器的无图模式下
                        // ctx.getImageData 处理大图的时候会报 Exception
                        // INDEX_SIZE_ERR: DOM Exception 1
                        try {
                            blob = image.getAsBlob();
                            size = file.size;
                            file.source = blob;
                            file.size = blob.size;

                            file.trigger( 'resize', blob.size, size );

                            deferred.resolve();
                        } catch ( e ) {
                            console.log( e );
                            // 出错了直接继续，让其上传原始图片
                            deferred.resolve();
                        }
                    });

                    file._info && image.info( file._info );
                    file._meta && image.meta( file._meta );
                    image.loadFromBlob( file.source );
                    return deferred.promise();
                }
            });

            return {
                init: function( selectCb ) {
                    uploader = new Uploader({
                        pick: {
                            id: '#'+image_id+'-picker',
                            multiple: false
                        },

                        // 设置用什么方式去生成缩略图。
                        thumb: {
                            quality: 70,

                            // 不允许放大
                            allowMagnify: true,

                            // 是否采用裁剪模式。如果采用这样可以避免空白内容。
                            crop: false
                        },

                        accept: {
                            title: 'Images',
                            extensions: 'gif,jpg,jpeg,bmp,png',
                            mimeTypes: 'image/*'
                        },
                        // 禁掉分块传输，默认是开起的。
                        chunked: false,

                        // 禁掉上传前压缩功能，因为会手动裁剪。
                        compress: false,

                        // fileSingleSizeLimit: 2 * 1024 * 1024,

                        server: server_url,
                        swf: swf_url,
                        duplicate: true,
                        formData : {
                            folder : $('#'+image_id).data('folder')
                        },
                        //fileNumLimit: 1,
                        onError: function() {
                            var args = [].slice.call(arguments, 0);
                            alert(args.join('\n'));
                        }
                    });

                    uploader.on('fileQueued', function( _file ) {
                        file = _file;

                        $('.'+image_id+'-cropper-wrapper').show();
                        //$('#'+image_id+'-picker').hide();
                        $('#'+image_id+'-upload').show();

                        uploader.makeThumb( file, function( error, src ) {

                            if ( error ) {
                                alert('不能预览');
                                return;
                            }

                            selectCb( src );

                        }, FRAME_WIDTH, 1 );   // 注意这里的 height 值是 1，被当成了 100% 使用。
                    });

                    uploader.on('uploadSuccess', function(_file, _resp){
                        //console.log(_file, _resp);
                        var progress = $( '#'+image_id+'-progress').hide();
                        $('#'+image_id).val(_resp);
                        location.reload();
                    });

                    // 文件上传过程中创建进度条实时显示。
                    uploader.on( 'uploadProgress', function( file, percentage ) {
                        var progress = $( '#'+image_id+'-progress').show().find('.progress-bar');
                        progress.css( 'width', percentage * 100 + '%' );
                    });

                },

                crop: function( data ) {

                    var scale = Croper.getImageSize().width / file._info.width;
                    data.scale = scale;

                    file._cropData = {
                        x: data.x1,
                        y: data.y1,
                        width: data.width,
                        height: data.height,
                        scale: data.scale
                    };
                },

                upload: function() {
                    uploader.upload();
                }

            }
        })();

// ---------------------------------
// ---------  Crpper ---------------
// ---------------------------------
        var Croper = (function() {
            var container = $('.'+image_id+'-cropper-wrapper');
            var $image = container.find('.img-container img');
            var btn = $('#'+image_id+'-upload');
            var isBase64Supported, callback;

            $image.cropper({
                aspectRatio: thumb_size[0] / thumb_size[1],
                preview: '.'+image_id+'-img-preview',
                done: function(data) {
                    // console.log(data);
                }
            });

            function srcWrap( src, cb ) {

                // we need to check this at the first time.
                if (typeof isBase64Supported === 'undefined') {
                    (function() {
                        var data = new Image();
                        var support = true;
                        data.onload = data.onerror = function() {
                            if( this.width != 1 || this.height != 1 ) {
                                support = false;
                            }
                        }
                        data.src = src;
                        isBase64Supported = support;
                    })();
                }

                if ( isBase64Supported ) {
                    cb( src );
                } else {
                    alert("预览出错");

                }
            }

            btn.on('click', function() {
                callback && callback($image.cropper("getData"));
                $('.'+image_id+'-cropper-wrapper').hide();
                //$('#'+image_id+'-picker').hide();
                $('#'+image_id+'-upload').hide();
                $('.headphoto img').attr('src', $('.headphoto img').attr('src') + '?');

                return false;
            });

            return {
                setSource: function( src ) {

                    // 处理 base64 不支持的情况。
                    // 一般出现在 ie6-ie8
                    srcWrap( src, function( src ) {
                        $image.cropper("setImgSrc", src);
                    });

                    //container.removeClass('webuploader-element-invisible');

                    return this;
                },

                getImageSize: function() {
                    var img = $image.get(0);
                    return {
                        width: img.naturalWidth,
                        height: img.naturalHeight
                    }
                },

                setCallback: function( cb ) {
                    callback = cb;
                    return this;
                },

                disable: function() {
                    $image.cropper("disable");
                    return this;
                },

                enable: function() {
                    $image.cropper("enable");
                    return this;
                }
            }

        })();


// ------------------------------
// -----------logic--------------
// ------------------------------
        //var container = $('.'+image_id+'uploader-container');

        Uploader1.init(function( src ) {

            Croper.setSource( src );

            // 隐藏选择按钮。
            //container.addClass('webuploader-element-invisible');

            // 当用户选择上传的时候，开始上传。
            Croper.setCallback(function( data ) {
                Uploader1.crop(data);
                Uploader1.upload();
            });
        });

    });


// -----------------------------------------------------
// ------------ END ------------------------------------
// -----------------------------------------------------
});

function refreshCompletion(val)
{
    $('.jl_pre span.text-success').html(val+'%');
    $('.jl_pre .progress-bar').css('width', val+'%');

}


App.directive('scrollSpy', function($timeout){
    return {
        restrict: 'A',
        link: function(scope, elem, attr) {
            var offset = parseInt(attr.scrollOffset, 10)
            if(!offset) offset = 10;
            var selector = attr.target;
            $(selector).scrollspy({ "offset" : offset});
            scope.$watch(attr.scrollSpy, function(value) {
                $timeout(function() {
                    $(selector).scrollspy('refresh', { "offset" : offset})
                }, 1);
            }, true);
        }
    }
});

App.directive('preventDefault', function() {
    return function(scope, element, attrs) {
        jQuery(element).click(function(event) {
            event.preventDefault();
        });
    }
});

App.directive("scrollTo", ["$window", function($window){
    return {
        restrict : "AC",
        compile : function(){

            function scrollInto(elementId) {
                if(!elementId) $window.scrollTo(0, 0);
                //check if an element can be found with id attribute
                var el = document.getElementById(elementId);
                if(el) el.scrollIntoView();
            }

            return function(scope, element, attr) {
                element.bind("click", function(event){
                    scrollInto(attr.scrollTo);
                });
            };
        }
    };
}]);

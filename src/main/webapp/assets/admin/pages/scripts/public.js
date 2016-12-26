var Public = function() {

	var init = function() {
		var url = location.pathname.substr(8);
		var menus = [{
			'url': 'admin',
			'icon': 'icon-home',
			'name': '首页'
		},{
			'url': 'admin/onlineuserManage',
			'icon': 'fa fa-rss',
			'name': '在线用户'
		}, {
			'url': 'admin/userManage',
			'icon': 'icon-user',
			'name': '用户管理'
		}/*, {
			'url': 'admin/resumeManage',
			'icon': 'fa fa-file-text-o',
			'name': '简历管理'
		}*/, {
			'url': 'admin/templeteManage',
			'icon': 'icon-wallet',
			'name': '模板管理'
		}, {
			'url': 'admin/noticeManage',
			'icon': 'icon-bell',
			'name': '通知管理'
		}, {
			'url': 'admin/goodsManage',
			'icon': 'icon-basket',
			'name': '商品管理'
		}/*, {
			'url': 'admin/journalManage',
			'icon': 'icon-note',
			'name': '日志管理'
		}, {
			'url': 'admin/bbsManage',
			'icon': 'fa fa-comments',
			'name': '论坛管理'
		}, {
			'url': 'admin/systemManage',
			'icon': 'icon-settings',
			'name': '系统管理'
		}, {
			'url': 'admin/statisticsManage',
			'icon': 'icon-bar-chart',
			'name': '信息统计'
		}*/];
		//生成左侧导航项
		$.each(menus, function(i,val) {
			$('.page-sidebar-menu').append("<li><a href='"+val.url+"'><i class='"+val.icon+"'></i><span class='title'>"+val.name+"</span></a></li>");
		});
		//激活菜单栏样式
		$('.page-sidebar-menu > li > a').each(function() {
			if (url == $(this).attr("href")) {
				$(this).parent().addClass("active open");
				$(this).append("<span class='selected'></span>");
			}
		});
		//中间导航项
		if(url != menus[0].url){
			for(var m in menus){
				if(url == menus[m].url){
					$('.page-breadcrumb').append("<li><i class='"+menus[0].icon+"'></i> <a href='"+menus[0].url+"'>"+menus[0].name+"</a><i class='fa fa-angle-right'></i></li>");
					$('.page-breadcrumb').append("<li><i class='"+menus[m].icon+"'></i> <a href='"+menus[m].url+"'>"+menus[m].name+"</a></li>");
				}
			}
		}
		//初始化通知插件设置
		toastr.options = {
		  "closeButton": true,
		  "debug": false,
		  "positionClass": "toast-top-center",
		  "onclick": null,
		  "showDuration": "1000",
		  "hideDuration": "1000",
		  "timeOut": "3000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		};
	}
	
	var formSubmit = function(){
		//新反馈
		$.get('admin/findAdvice',{},function(r){
			$('.noticeNum').text(r.length);
			if(r.length == 0){
				$('#noticeList').append("<li><a>暂无反馈！</a></li>");
				$('.external').hide();
			}else{
				$.each(r,function(i,v){
					var li = "<li>"+
							 "	<a href='admin/noticeManage'>"+
							 "		<img alt='"+v[1]+"' src='"+v[2]+"' width='30' height='30'> ";
					if(v[0].info.length < 12){
						li += v[0].info + "</a></li>";
					}else{
						li += v[0].info.substring(0, 12) + "...</a></li>";
					}
					$('#noticeList').append(li);
				});
			}
		});
		
		//修改个人信息
		$('#myInfoModal form').submit(function(e) {
			var formData = new FormData($(this)[0]);
			$.ajax({
				url : 'admin/editInfo',
				type : 'POST',
				cache : false,
				data : formData,
				processData : false,
				contentType : false
			}).done(function(r) {
				if(r == "success"){
					location.reload();
				}else{
					toastr['error']("修改失败！", "");
				}
			}).fail(function(r) {
				toastr['error']("修改失败！", "");
			});
			return false;
		});
		//修改密码
		$('#modifyPwdModal form').submit(function(e) {
			if($("input[name='newPsd']").val() != $("input[name='confirmPsd']").val()){
				toastr['error']("密码不一致！", "");
				return false;
			}
			$.post('admin/modifyPwd',$(this).serialize(),function(r){
				if(r.state == "success"){
					$("#modifyPwdModal").modal("hide");
					toastr['success']("修改成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			});
			return false;
		});
		//对话框关闭重置表单
		$('#modifyPwdModal').on('hide.bs.modal', function () {
			$(".reset").click();
		});
	}
	
	return {

		init: function() {
			init();
			formSubmit();
		}
	};

}();
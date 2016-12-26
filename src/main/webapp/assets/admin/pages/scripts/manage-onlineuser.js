var Managed = function() {

	var Table = function() {

		var $table = $('#onlineUserTable');

		var table = $table.DataTable({
			"ajax": "admin/onlineuser",
			"columns": [
				{"data": "uid"},
				{"data": "nickname"},
				{"data": "account"},
				{"data": "loginTime"},
				{"data": "exp"},
				{"data": "uid"}
			],
			"lengthMenu": [
				[8, 15, 20, -1],
				[8, 15, 20, "所有"]
			],
			"pageLength": 8,
			"language": {
				"url": "assets/global/plugins/datatables/Chinese.json"
			},
			"columnDefs": [{
				'orderable': false,
				'targets': [0,-1]
			}, {
				"searchable": false,
				"targets": [0,-1]
			},{
				"render": function(data,type,row){
					return 	"<div class='checker'>"+
							"	<span>"+
							"		<input type='checkbox' class='checkboxes' value='"+data+"' />"+
							"	</span>"+
							"</div>";
				},
				"targets":0
			},{
				"render": function(data,type,row){
					var logintime = new Date(row.loginTime);
					var now = new Date();
					var r = now.getTime() - logintime.getTime(); //毫秒差
					var m = r / (60 * 1000);	//分钟差
					return 	parseInt(m)+"分钟";
				},
				"targets":-2
			},{
				"render": function(data,type,row){
					return 	"<a href='javascript:;' class='btn btn-xs red logout'><i class='fa fa-times'></i> 注销 </a>" + 
							"<a href='javascript:;' class='btn btn-xs green send-notice'><i class='fa fa-send'></i> 通知 </a>";
				},
				"targets":-1
			}],
			"order": [
					[1, "asc"]
			]
		});
		
		//单选
		$table.on('change','.checkboxes',function(){
			var checked = $(this).is(':checked');
			if (checked) {
				$(this).attr("checked", true).parent().addClass('checked');
			} else {
				$(this).attr("checked", false).parent().removeClass('checked');
			}
		});
		
		//全选
		$table.find('.group-checkable').change(function() {
			var set = jQuery(this).attr("data-set");
			var checked = jQuery(this).is(":checked");
			jQuery(set).each(function() {
				if (checked) {
					$(this).attr("checked", true).parent().addClass('checked');
				} else {
					$(this).attr("checked", false).parent().removeClass('checked');
				}
			});
			jQuery.uniform.update(set);
		});
		
		//注销
		$table.on('click','.logout',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			var ids = [row.uid];
			bootbox.dialog({
                message: "<i class='fa fa-exclamation-triangle'></i>你确定要注销"+row.nickname+"用户么？注销后将影响用户操作，请谨慎操作！",
                title: "警告",
                buttons: {
                  danger: {
                    label: "确定",
                    className: "red",
                    callback: function() {
                    	$.post('admin/logoutUser',{ids:ids.toString()},function(r){
                    		if(r.state == 'success'){
                    			table.ajax.reload();
								toastr['success']("注销成功！", "");
                    		}else{
								toastr['error'](r.exception, "");
                    		}
                    	});
                    }
                  },
                  main: {
                    label: "取消",
                    className: "primary",
                    callback: function() {
                    	
                    }
                  }
                }
            });
		});
		
		//发送通知
		var uids = [];
		$('#target-user').tagsInput({
			width: 'auto',
			defaultText: '',
			interactive:false
		});
		$table.on('click','.send-notice',function(){
			//清除对话框的表单数据
			$('#reset').click();
			$('#target-user').removeTag();
			uids = [];
			//获取当前行数据
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			uids.push(row.uid);
			$('#target-user').addTag(row.account);
			$('#sendNoticeModal').modal('show');
		});
		$('#send-notice-submit-btn').click(function(){
			var title = $('#title').val();
			var content = $("#send-notice-form textarea").val();
			if(content == ""){
				toastr['warning']("发送内容不能为空！", "");
			}else{
				$.post("admin/sendNotice",{ids:uids.toString(),title:title,content:content},function(r){
					$('#sendNoticeModal').modal('hide');
					if(r.state == "success"){
						toastr['success']("发送成功！", "");
					}else{
						toastr['error'](r.exception, "");
					}
				});
			}
		});
		
		//刷新
		$('#refresh').click(function(){
			 Metronic.blockUI({
			 	target: "#portlet-body",
			 	message:"加载中..."
			 });
			 window.setTimeout(function(){
			 	Metronic.unblockUI("#portlet-body");
			 },1000);
			table.ajax.reload();
			//更新全选按钮状态					
			$table.find('.group-checkable').attr("checked", false).parent().removeClass('checked');
		});
		
		//批量注销
		$('#logouts').click(function(){
			var ids = [],rows = [];
			$table.find('.checkboxes').each(function(){
				if($(this).is(':checked')){
					//保存id
					ids.push($(this).val());
					//保存当前行
					rows.push($(this).parents('tr'));
				}
			});
			if(ids.length == 0){
				toastr['warning']("请选择您需要注销的用户！", "");
			}else{
				bootbox.dialog({
                    message: "<i class='fa fa-exclamation-triangle'></i>你确定要注销这些用户么？注销后将影响用户操作，请谨慎操作！",
                    title: "警告",
                    buttons: {
                      danger: {
                        label: "确定",
                        className: "red",
                        callback: function() {
                        	console.info(ids);
							//更新全选按钮状态					
							$table.find('.group-checkable').attr("checked", false).parent().removeClass('checked');
		                	$.post('admin/logoutUser',{ids:ids.toString()},function(r){
		                		if(r.state == 'success'){
		                			table.ajax.reload();
									toastr['success']("注销成功！", "");
		                		}else{
									toastr['error'](r.exception, "");
		                		}
		                	});
                        }
                      },
                      main: {
                        label: "取消",
                        className: "primary",
                        callback: function() {
                          
                        }
                      }
                    }
                });
			}
		});
		
		//批量通知
		$('#notices').click(function(){
			var ids = [],tags = [];
			$table.find('.checkboxes').each(function(){
				if($(this).is(':checked')){
					//保存选择的uid
					ids.push($(this).val());
					//保存选择的account
					tags.push(table.row($(this).parents('tr')).data().account);
				}
			});
			if(ids.length == 0){
				toastr['warning']("请选择您需要发送通知的用户！", "");
			}else{
				//清除对话框的表单数据
				$('#reset').click();
				$('#target-user').removeTag();
				uids = ids;
				//获取当前行数据
				$('#target-user').importTags(tags.toString());
				$('#sendNoticeModal').modal('show');
			}
		});
		
	}

	return {

		init: function() {
			if (!jQuery().DataTable) {
				return;
			}

			Table();
		}

	};

}();



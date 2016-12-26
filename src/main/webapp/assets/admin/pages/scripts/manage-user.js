var Managed = function() {

	var Table = function() {

		var $table = $('#userinfoTable');
		var table = $table.DataTable({
			"ajax": "admin/findUser",
			"columns": [
				{"data":"uid"},
				{"data":"nickname"},
				{"data":"account"},
				{"data":"level"},
				{"data":"point"},
				{"data":"exp"},
				{"data":"integrity"},
				{"data":"status"},
				{"data":null}
			],
			"lengthMenu": [
				[8, 15, 20, -1],
				[8, 15, 20, "所有"]
			],
			"pageLength": 8,
			"language": {
				"url": 'assets/global/plugins/datatables/Chinese.json'
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
					return data+"%";
				},
				"targets":6
			},{
				"render": function(data,type,row){
					if(data){
						return "<span class='label label-success'>已激活 </span>";
					}else{
						return "<span class='label label-warning'>未激活 </span><a class='label label-info pull-right'>点击激活</a>";
					}
				},
				"targets":-2
			},{
				"render": function(data,type,row){
					return	"<a href='javasrcipt:;' class='btn btn-xs blue modify'><i class='fa fa-pencil'></i> 修改</a>"+
				 			"<a href='javasrcipt:;' class='btn btn-xs green send-notice'><i class='fa fa-send'></i> 通知 </a>"+
//				 			"<a href='javasrcipt:;' class='btn btn-xs red delete'><i class='fa fa-trash-o'></i> 删除 </a>"+
				 			"<a href='javasrcipt:;' class='btn btn-xs green-haze preview'><i class='fa fa-file-text-o'></i> 预览 </a>";
				},
				"targets":-1
			}],
			"order": [
					[1, "asc"]
			] // 设置第一列作为默认的排序为升序
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
		
		//修改用户密码
		$table.on('click','.modify',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			$('#modifyModal').find("span.name").text(row.nickname);
			$('#modifyModal').find("input[type='hidden']").val(row.uid);
			$('#modifyModal').modal('show');
		});
		$('#modifyModal').on('hide.bs.modal', function () {
			$(this).find("input[type='reset']").click();
		});
		$('#edit-user-pwd-form').submit(function(){
			var newPwd = $(this).find("input[name='newPwd']").val();
			var confirmPwd = $(this).find("input[name='confirmPwd']").val();
			if(newPwd != confirmPwd){
				toastr['error']("密码不一致！", "");
				return false;
			}
			$.post('admin/modifyUserPwd',$(this).serialize(),function(r){
				if(r.state == "success"){
					$('#modifyModal').modal('hide');
					toastr['success']("修改成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			});
			return false;
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
		
		//删除用户信息
		$table.on('click','.delete',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			bootbox.dialog({
                message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除"+row.nickname+"用户么？删除后所有信息将无法撤销,请谨慎操作！",
                title: "警告",
                buttons: {
                  danger: {
                    label: "确定",
                    className: "red",
                    callback: function() {
                      	table.row(tr).remove().draw(false);
						toastr['success']("删除成功！", "");
//                        	$.post('admin/deleteUser',{uid:row.uid},function(r){
//                        		if(r == 'success'){
//                        			table.row(tr).remove().draw(false);
//									toastr['success']("删除成功！", "");
//                        		}else{
//									toastr['error']("删除失败！", "");
//                        		}
//                        	});
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
		
		//预览简历
		$table.on('click','.preview',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			var h = window.innerHeight;
			var url = "assets/resume/1.pdf";
			new PDFObject({
				url: url,
				height: h
			}).embed('resume');
			$('#previewModal').modal('show');
		});
		
		//激活用户
		$table.on('click','.label-info',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			$.post('admin/activeUser',{uid:row.uid},function(r){
				if(r.state == 'success'){
					table.ajax.reload();
					toastr['success']("成功激活用户！", "");
				}else{
					toastr['error'](e.exception, "");
				}
			});
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
		
		//添加用户
		$('#add-btn').click(function(){
			$('#addUserModal').find("input[type='reset']").click();
			$('#addUserModal').modal('show');
		});
		$('#addUserModal').find('form').submit(function(){
			if($(this).find("input[name='pwd']").val().length < 6){
				toastr['error']("密码长度不能少于6位！", "");
				return false;
			}
			$.post('admin/addUser',$(this).serialize(),function(r){
				if(r.state == 'success'){
					table.ajax.reload();
					$('#addUserModal').modal('hide');
					toastr['success']("添加用户成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			});
			return false;
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
		
		//批量删除
		$('#deletes-btn').click(function(){
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
				toastr['warning']("请选择您需要删除的用户！", "");
			}else{
				bootbox.dialog({
                    message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这些用户么？删除后所有信息将无法撤销,请谨慎操作！",
                    title: "警告",
                    buttons: {
                      danger: {
                        label: "确定",
                        className: "red",
                        callback: function() {
                          	table.rows(rows).remove().draw(false);
							toastr['success']("删除成功！", "");
							//更新全选按钮状态					
							$table.find('.group-checkable').attr("checked", false).parent().removeClass('checked');
//			                	$.post('admin/deleteUsers',{ids:ids.toString()},function(r){
//			                		if(r == 'success'){
//			                			table.rows(rows).remove().draw(false);
//										toastr['success']("删除成功！", "");
//			                		}else{
//										toastr['error']("删除失败！", "");
//			                		}
//			                	});
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
		
	}

	return {

		//main function to initiate the module
		init: function() {
			if (!jQuery().dataTable) {
				return;
			}
			
			Table();
		}

	};

}();



var Managed = function() {

	var Table = function() {
		
		var types = {'1':'系统消息','2':'订阅消息', '3':'简历消息', '4':'留言消息', '5':'评论消息'};
		var $table = $('#noticeTable');
		var table = $table.DataTable({
			"ajax": "admin/findMessage",
			"columns": [
				{"data":"time"},
				{"data":"info"},
				{"data":"kind"},
				{"data":"time"},
				{"data":"id"}
			],
			"lengthMenu": [
				[8, 15, 20, -1],
				[8, 15, 20, "所有"]
			],
			"pageLength": 8,
			"language": {
				"url": 'admin/Chinese.json'
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
					if(data.length > 40){
						data = data.substr(0,40) + "...";
					}
					return data;
				},
				"targets":1
			},{
				"render": function(data,type,row){
					return types[data];
				},
				"targets":2
			},{
				"render": function(data,type,row){
					return  "<a href='javasrcipt:;' class='btn btn-xs blue look'><i class='fa fa-eye'></i> 详情</a>" +
							"<a href='javasrcipt:;' class='btn btn-xs red delete'><i class='fa fa-trash-o'></i> 删除 </a>";
				},
				"targets":-1
			}],
			"order": [
				[3, "desc"]
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
		
		//查看通知详情
		$table.on('click','.look',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			$.get('admin/findMessageUsers',{time:row.time},function(r){
				var users = "";
				$.each(r,function(i,v){
					var account = v[0];
					var isreaded = v[1] ? '已读' : '未读';
					users += "<span class='label label-info'>"+account+"("+isreaded+")</span> ";
				});
				$("#users").html(users);
			});
			$("#title").html(row.info);
			$("#type").html(types[row.kind]);
			$("#detail").html(row.detail);
			$("#time").html(row.time);
			$('#lookModal').modal('show');
		});
		
		//删除
		$table.on('click','.delete',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			bootbox.dialog({
                message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这条通知么？",
                title: "警告",
                buttons: {
                  danger: {
                    label: "确定",
                    className: "red",
                    callback: function() {
                    	$.post('admin/deleteMessage',{times:row.time},function(r){
                    		if(r.state == 'success'){
                    			table.ajax.reload();
								toastr['success']("删除成功！", "");
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
		
		//批量删除
		$('#deletes-btn').click(function(){
			var times = [];
			$table.find('.checkboxes').each(function(){
				if($(this).is(':checked')){
					times.push($(this).val());
				}
			});
			if(times.length == 0){
				toastr['warning']("请选择您需要删除的通知！", "");
			}else{
				bootbox.dialog({
                    message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这些通知么？删除后所有信息将无法撤销,请谨慎操作！",
                    title: "警告",
                    buttons: {
                      danger: {
                        label: "确定",
                        className: "red",
                        callback: function() {
                        	$.post('admin/deleteMessage',{times:times.toString()},function(r){
                        		if(r.state == 'success'){
                        			table.ajax.reload();
    								toastr['success']("删除成功！", "");
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
		

	}

	return {

		init: function() {
			if (!jQuery().dataTable) {
				return;
			}
			
			Table();
		}

	};

}();



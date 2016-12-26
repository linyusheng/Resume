var Managed = function() {

	var Table = function() {

		var $table = $('#templeteTable');
		var table = $table.DataTable({
			"ajax": "admin/findTemplete",
			"columns": [
				{"data":"tpId"},
				{"data":"tpTitle"},
				{"data":"tname"},
				{"data":"nickname"},
				{"data":"tpSize"},
				{"data":"isOpen"},
				{"data":"downloadNum"},
				{"data":"clickNum"},
				{"data":"collectNum"},
				{"data":"tpTime"},
				{"data":"tpId"}
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
					return parseInt(data / 1024) + " KB";
				},
				"targets":4
			},{
				"render": function(data,type,row){
					if(data){
						return "<span class='label label-success'>公开 </span>";
					}else{
						return "<span class='label label-warning'>保密 </span>";
					}
				},
				"targets":5
			},{
				"render": function(data,type,row){
					return 	"<a href='javasrcipt:;' class='btn btn-xs purple preview'><i class='fa fa-eye'></i> 预览 </a>"+
							"<a href='javasrcipt:;' class='btn btn-xs blue modify'><i class='fa fa-pencil'></i> 修改</a>"+
							"<a href='javasrcipt:;' class='btn btn-xs red delete'><i class='fa fa-trash-o'></i> 删除 </a>"+
							"<a href='templete/download?id="+data+"' class='btn btn-xs green-haze'><i class='fa fa-download'></i> 下载 </a>";
				},
				"targets":-1
			}],
			"order": [
					[3, "asc"]
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
		
		//初始化模板类型
		$.getJSON('assets/json/type.json',function(r){
			$.each(r, function(i,val) {
				$('#modifyModal select').append("<option value='"+val.tid+"'>"+val.tname+"</option>");
			});
		});
		//修改简历模板
		$table.on('click','.modify',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			//设值
			$("#modifyModal input[name='tpId']").val(row.tpId);
			$("#modifyModal input[name='tpTitle']").val(row.tpTitle);
			$('#modifyModal select').val(row.tid);
			$("#modifyModal input[name='nickname']").val(row.nickname);
			if(row.isOpen){
				$("#modifyModal input[type='checkbox']").parent().addClass('checked');
			}else{
				$("#modifyModal input[type='checkbox']").parent().removeClass('checked');
			}
			$("#modifyModal input[name='downloadNum']").val(row.downloadNum);
			$("#modifyModal input[name='clickNum']").val(row.clickNum);
			$("#modifyModal input[name='collectNum']").val(row.collectNum);
			$('#modifyModal').modal('show');
		});
		$("#modifyModal form").submit(function(){
			var checkbox = $("#modifyModal input[type='checkbox']");
			var checked = checkbox.parent().hasClass('checked');
			var data = $(this).serialize() + "&isOpen=" + checked;
			$.post('admin/modifyTemplete',data,function(r){
				if(r.state == 'success'){
					table.ajax.reload();
					$("#modifyModal").modal("hide");
					toastr['success']("修改成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			});
			return false;
		});
		
		//删除
		$table.on('click','.delete',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			bootbox.dialog({
                message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这条模板么？删除后所有信息将无法撤销,请谨慎操作！",
                title: "警告",
                buttons: {
                  danger: {
                    label: "确定",
                    className: "red",
                    callback: function() {
                    	$.post('admin/deleteTemplete',{ids:row.tpId},function(r){
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
		
		//预览
		$table.on('click','.preview',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			new PDFObject({
				url: row.tpUrl,
				height: window.innerHeight
			}).embed('resume');
			$('#previewModal').modal('show');
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
				toastr['warning']("请选择您需要删除的模板！", "");
			}else{
				bootbox.dialog({
                    message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这些模板么？删除后所有信息将无法撤销,请谨慎操作！",
                    title: "警告",
                    buttons: {
                      danger: {
                        label: "确定",
                        className: "red",
                        callback: function() {
							//更新全选按钮状态					
							$table.find('.group-checkable').attr("checked", false).parent().removeClass('checked');
		                	$.post('admin/deleteTemplete',{ids:ids.toString()},function(r){
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

		//main function to initiate the module
		init: function() {
			if (!jQuery().dataTable) {
				return;
			}
			
			Table();
		}

	};

}();



var Managed = function() {

	var Table = function() {
		
		var types = [];
		$.getJSON('assets/json/gtype.json',function(data){
			types = data;
		})
		var $table = $('#goodsTable');
		var table = $table.DataTable({
			"ajax": "admin/findGoods",
			"columns": [
				{"data":"gid"},
				{"data":"gpicture"},
				{"data":"gname"},
				{"data":"tid"},
				{"data":"gnum"},
				{"data":"gpoint"},
				{"data":"isShow"},
				{"data":"gtime"},
				{"data":"gid"}
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
					return 	"<img class='look' src='"+data+"' width='40' height='40' style='cursor: pointer;'/>";
				},
				"targets":1
			},{
				"render": function(data,type,row){
					if(data.length > 40){
						data = data.substr(0,40) + "...";
					}
					return 	data;
				},
				"targets":2
			},{
				"render": function(data,type,row){
					var name;
					$.each(types,function(i,val){
						if(val.id == data){
							name = val.name;
						}
					});
					return name;
				},
				"targets":3
			},{
				"render": function(data,type,row){
					if(data){
						return "<span class='label label-success'>已上架 </span>";
					}else{
						return "<span class='label label-warning'>未上架 </span>";
					}
				},
				"targets":-3
			},{
				"render": function(data,type,row){
					var r = "<a href='javasrcipt:;' class='btn btn-xs blue modify'><i class='fa fa-pencil'></i> 修改</a>";
					if(row.isShow){
						r += "<a href='javasrcipt:;' class='btn btn-xs yellow operator'><i class='fa fa-arrow-down'></i> 下架 </a>";
					}else{
						r += "<a href='javasrcipt:;' class='btn btn-xs green-haze operator'><i class='fa fa-arrow-up'></i> 上架 </a>";
					}
					r += "<a href='javasrcipt:;' class='btn btn-xs red delete'><i class='fa fa-trash-o'></i> 删除 </a>";
					return r;
				},
				"targets":-1
			}],
			"order": [
					[7, "desc"]
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
		
		//放大商品图
		$table.on('mouseover mouseout','.look',function(event){
			var src = $(this).attr('src');
			$('#bigPic').attr('src',src);
			//鼠标悬浮
			if(event.type == "mouseover"){
				var top = $(this).offset().top - $(document).scrollTop();
				var left = $(this).offset().left + 45;
				$('#bigPic').css({
					'left':left,
					'top':top,
				}).show();
			//鼠标离开
			}else if(event.type == "mouseout"){
				$('#bigPic').hide();
			}
		});
		
		//初始化商品类型
		$.getJSON('assets/json/gtype.json',function(r){
			$.each(r, function(i,val) {
				$("#addModal select[name='tid'],#modifyModal select[name='tid']").append("<option value='"+val.id+"'>"+val.name+"</option>");
			});
		});
		
		//修改商品信息
		$table.on('click','.modify',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			var form = $('#modifyModal form');
			form.find("input[name='gid']").val(row.gid);
			form.find("input[name='gname']").val(row.gname);
			form.find("select[name='tid']").val(row.tid);
			form.find("select[name='isShow']").val(row.isShow ? 1 : 0);
			form.find("input[name='gnum']").val(row.gnum);
			form.find("input[name='gpoint']").val(row.gpoint);
			$('#modifyModal').modal('show');
		});
		$('#modifyModal form').submit(function(){
			var formData = new FormData($(this)[0]);
			$.ajax({
				url : 'admin/mergeGoods',
				type : 'POST',
				cache : false,
				data : formData,
				processData : false,
				contentType : false
			}).done(function(r) {
				if(r.state == 'success'){
					$('#modifyModal').modal('hide');
					table.ajax.reload();
					toastr['success']("修改成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			}).fail(function(r) {
				toastr['error'](r, "");
			});
			return false; 
		});
		
		//上、下架商品
		$table.on('click','.operator',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			$.post('admin/goodsOperator',{gid:row.gid,isShow:!row.isShow},function(r){
				if(r.state == "success"){
					table.ajax.reload();
					toastr['success']("下架成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			});
		});
		
		//删除
		$table.on('click','.delete',function(){
			var tr = $(this).parents('tr');
			var row = table.row(tr).data();
			bootbox.dialog({
                message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这个商品么？删除后所有信息将无法撤销,请谨慎操作！",
                title: "警告",
                buttons: {
                  danger: {
                    label: "确定",
                    className: "red",
                    callback: function() {
                    	$.post('admin/deleteGoods',{ids:row.gid},function(r){
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
		
		//添加
		$('#add-btn').click(function(){
			$("#addModal input[type='reset']").click();
			$('#addModal').modal('show');
		});
		$('#addModal form').submit(function(){
			var formData = new FormData($(this)[0]);
			$.ajax({
				url : 'admin/mergeGoods',
				type : 'POST',
				cache : false,
				data : formData,
				processData : false,
				contentType : false
			}).done(function(r) {
				if(r.state == 'success'){
					$('#addModal').modal('hide');
					table.ajax.reload();
					toastr['success']("添加成功！", "");
				}else{
					toastr['error'](r.exception, "");
				}
			}).fail(function(r) {
				toastr['error'](r, "");
			});
			return false; 
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
				toastr['warning']("请选择您需要删除的商品！", "");
			}else{
				bootbox.dialog({
                    message: "<i class='fa fa-exclamation-triangle'></i>你确定要删除这些商品么？删除后所有信息将无法撤销,请谨慎操作！",
                    title: "警告",
                    buttons: {
                      danger: {
                        label: "确定",
                        className: "red",
                        callback: function() {
                        	$.post('admin/deleteGoods',{ids:ids.toString()},function(r){
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



var Lock = function () {

    return {
        //main function to initiate the module
        init: function () {

             $.backstretch([
		        "assets/admin/pages/media/bg/1.jpg",
    		    "assets/admin/pages/media/bg/2.jpg",
    		    "assets/admin/pages/media/bg/3.jpg",
    		    "assets/admin/pages/media/bg/4.jpg"
		        ], {
		          fade: 1000,
		          duration: 8000
		      });
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
		    $('form').submit(function(){
		    	if($("input[name='password']").val() == ''){
		    		toastr['error']("密码不能为空！", "");
		    		return false;
		    	}
		    	$.post('admin/uplock',$('form').serialize(),function(r){
					if(r.state == "fail"){
						toastr['error'](r.exception, "");
			    	}else{
			    		location.href = r.returnUrl;
			    	}
			    });
			    return false;
		    });
        }

    };

}();
// javascript document
var xmlhttp = false;
if (window.XMLHttpRequest) { 									//Mozilla、Safari等浏览器
	xmlhttp = new XMLHttpRequest();
} 
else if (window.ActiveXObject) { 								//IE浏览器
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}
	}
}

//xml传递get
function xmlsendget(url)
{
	xmlhttp.open('get', url, true);
	xmlhttp.onreadystatechange = function()
	{
		if (xmlhttp.readyState == 4)
		{
			if (xmlhttp.status == 200)
			{
				var msg = xmlhttp.responseText;
				// alert(msg);
				var dataObj = eval("("+msg+")");
				act = dataObj.act.act;
				//console.log(dataObj);
				if (act === 'changeSave') reChangeSave(dataObj);
				 else if (act === 'changeIgnore') reChangeIgnore(dataObj);
				 else if (act === 'changeChat') reChangeChat(dataObj);
			}
		}
	};
	xmlhttp.send(null);
}

//xml传递post
function xmlsendpost(url, post)
{
	xmlhttp.open('post', url, true);
	xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xmlhttp.onreadystatechange = function()
	{
		if (xmlhttp.readyState == 4)
		{
			if (xmlhttp.status == 200)
			{
				var msg = xmlhttp.responseText;
				// alert(msg);
				var dataObj = eval("("+msg+")");
				act = dataObj.act.act;
				//console.log(dataObj);
				// if (act === 'login') reLogin(dataObj);
			}
		}
	};
	xmlhttp.send(post);
}

//修改我的收藏
function changeIgnore(iid, state)
{
	var url = '/ajax.php?act=changeIgnore&iid=' + iid + '&state=' + state;
	xmlsendget(url);
}
//修改我的收藏
function reChangeIgnore(dataObj)
{
	if (dataObj.state.state == 'OK')
	{
		var elm = $('#info' + dataObj.data.iid).hide();
	}
	else
	{
		console.log(dataObj.exception.ex);	
	}
}
//加入群聊
function changeChat(iid)
{
	var url = '/ajax.php?act=change-chat&iid=' + iid;
	xmlsendget(url);
}

function reChangeChat(dataObj)
{
	if (dataObj.state.state == 'OK')
	{
		globalAlert("加入群聊成功, 请到APP客户端参加讨论");
		$(this).attr("data-chat","1");
        $(this).attr("data-original-title","您已加入该群聊");
	}
	else
	{
		globalAlert(dataObj.exception.ex);
	}

}

//修改我的收藏
function changeSave(iid, state)
{
	var url = '/ajax.php?act=changeSave&iid=' + iid + '&state=' + state;
	xmlsendget(url);
}
//修改我的收藏
function reChangeSave(dataObj)
{
	if (dataObj.state.state == 'OK')
	{
		var elm = _('save' + dataObj.data.iid) || _('saveBtn');
        var saveStr = _('saveBtn') && _('saveBtn').parentNode.getElementsByTagName("div")[0];
        if (dataObj.data.state == 'add'){
			elm.className = elm.className.replace('fa-star-o ', 'fa-star ');
			elm.setAttribute('data-is-save', 1);
			elm.parentNode.title = '点击取消收藏';
            if (saveStr) {
                saveStr.innerHTML = '已收藏';
            }
        }else{
			elm.className = elm.className.replace('fa-star ', 'fa-star-o ');
			elm.setAttribute('data-is-save', 0);
			elm.parentNode.title = '点击收藏该信息';
            if (saveStr) {
                saveStr.innerHTML = '收藏';
            }
        }
	}
	else
	{
		console.log(dataObj.exception.ex);
		// _("notice_mask").style.display='block';
		// _("reNoticeInfo").innerHTML=dataObj.exception.ex;
		
	}
}

// 删除我的收藏
function delSave(iid)
{
	var url = '/ajax.php?act=delsave&iid=' + iid;
	xmlsendget(url);
}
// 删除我的收藏
function reDelSave(dataObj)
{
	if (dataObj.act.act == 'delsave')
	{
		if (dataObj.state.state == 'OK')
		{
			var obs = _('save' + dataObj.info.iid) || _('saveBtn');
			if (obs.className === 'ico_2_on'){
				obs.className = 'ico_2';
			}else{
				obs.className = 'sub_keep';
			}
			obs.getElementsByTagName('a')[0].title = '点击收藏本条消息';
		}
	}
}


// 登录
function login()
{
	var url = '/login.php?act=login&uname=' + encodeURIComponent(_('username').value);
	xmlsendpost(url, 'pw=' + encodeURIComponent(_('userpass').value));
}
// 登录
function reLogin(dataObj)
{
	if (dataObj.act.act == 'login')
	{
		if (dataObj.state.state == 'OK')
		{
			window.location.reload();
		}
		else
		{
			_('reInfo').innerHTML = dataObj.exception.ex;
			_('loginSubmit').className = "button";
			_('loginSubmit').value = "确 定";
		}
	}
}

// 注销
function logout()
{
	var url = '/login.php?act=logout';
	xmlsendget(url);
}
// 注销
function reLogout(dataObj)
{
	if (dataObj.act.act == 'logout')
	{
		if (dataObj.state.state == 'OK')
		{
			window.location.reload();
		}
	}
}


// 回复留言
function reply()
{
	var tid = _('tid').value;
	var post = encodeURIComponent(_('messageText').value);
	var url = '/api/reply.php?tid=' + tid + '&message=' + post ;
	//alert(url);
	xmlsendget(url);
	
}
// 回复留言
function reReply(dataObj)
{
	if (dataObj.act.act == 'reply')
	{
		if (dataObj.state.state == 'OK')
		{
			_('reMessageInfo').innerHTML = dataObj.msg;
			_('message_mask').style.display = 'none';
			_('messageText').value = '';
			var src = _('bbsframe').src;
			_('bbsframe').src = src;
			_('reMessageInfo').innerHTML = '';
		}
		else
		{
			_('reMessageInfo').innerHTML = dataObj.exception.ex;
		}
	}
}


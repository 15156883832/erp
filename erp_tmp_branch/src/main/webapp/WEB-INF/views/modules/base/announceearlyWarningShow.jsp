<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/easyui.css"/>

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title> </title>
</head>
<body>
<div class="popupBox sysNotice editeNoticewew warnMsg" >
	<h2 class="popupHead">
		预警消息
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	 <div class="popupContainer pos-r" >
        <div class="popupMain warnMsgContain" style="margin-top:15px;margin-left:30px;margin-right:30px;margin-buttom:15px;">
            <p class="">
                ${sitealarm.content }
            </p>
            <span class="warnMsgTime_ mt-10" >服务时间：<fmt:formatDate value="${sitealarm.createTime }" pattern="yyyy-MM-dd HH-mm-ss"/></span>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
	
	$(function(){
		$('.editeNoticewew').popup();
	})

</script> 
</body>
</html>
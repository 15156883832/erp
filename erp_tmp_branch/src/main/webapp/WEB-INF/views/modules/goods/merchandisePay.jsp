<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>重新提交</title>
 <meta name="decorator" content="base"/>
 <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
</head>
<body>

<div class="popupBox w-520 chukuBox">
	<h2 class="popupHead">
		详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pd-15">
			<div class="cl mb-10">
				<label class="f-l text-r w-80">订单编号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.number }"/>
				<label class="f-l text-r w-100">商品名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.good_name }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">购买数量：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.purchase_num }"/>
				<label class="f-l text-r w-100">购买价格：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.good_amount }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">收件人：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.customer_name }"/>
				<label class="f-l text-r w-100">联系方式：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.customer_contact }"/>
			</div>

			<div class="cl mb-10">
				<label class="f-l text-r w-80">收件地址：</label>
				<input type="text" class="input-text w-380 f-l readonly" readonly="readonly" value="${rds.columns.customer_address }"/>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<label class="f-l text-r w-80">物流名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.logistics_name }"/>
				<label class="f-l text-r w-100">物流单号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${rds.columns.logistics_no }"/>
			</div>
			
			<div class="text-c mt-25">
				<a href="javascript:closeDiv();" class="sfbtn sfbtn-opt3 w-70 mr-5">关闭</a>
			</div>
		</div>
	</div>
</div>

<!--_footer 作为公共模版分离出去-->
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->

<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>

<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript">
	$(function(){

	$('.chukuBox').popup();	
	})

	
	function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
	}
	
	function cancel(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});	
		$.closeDiv($(".resubmitBox"))
	}
	
	$(".closePopup").on("click",function(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});		
	});

	function closeDiv(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$.closeDiv($(".chukuBox"));
	}
	function close(){
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$.closeDiv($(".logistics"));
	}
</script> 
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>配件条形码</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/print_sf.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery-migrate-1.4.1.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/JsBarcode.all.min.js"></script>
<script type="text/javascript">
	function printOrder() {
		document.getElementById("btn").style.display="none";
		$(".printpage").jqprint({
			debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
			importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
			printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
			operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
		});
		
	}
	$(function(){
		var code = '${pofr.code}';
		showTiao(code);
	});
	
	function showTiao(code){
		JsBarcode("#barcode", code, {
			format: "CODE128",
			width:4,
			height:40,
			displayValue: true
		});
	}
</script>
</head>
<body>

<div class="printpage wrap">
	<div class="w-480" style="margin:auto;">
		<h2 class="popupHead text-c " >
				配件条形码
		</h2>
		<div class="popupMain mb-30">
			<div class="mb-10 text-c codebox">
				<img id="barcode">
			</div>
			<div class="pos-r pl-80 mb-10">
				<span class="pos w-80 text-r">旧件名称：</span>
				<p class="">${pofr.name}</p>
			</div>
			<div class="pos-r pl-80 mb-10">
				<span class="pos w-80 text-r">旧件型号：</span>
				<p class="">${pofr.version}</p>
			</div>
			<div class=" cl">
				<div class="w-220 f-l" >
					<label class="f-l text-r w-80">旧件品牌：</label>
					<p class="lh-26 f-l">${pofr.brand}</p>
				</div>
				<div class="w-220 f-r" >
					<label class="f-l text-r w-80">是否原配：</label>
					<p class="lh-26 f-l"><c:if test="${pofr.yrpzFlag eq '1'}">是</c:if><c:if test="${pofr.yrpzFlag eq '2'}">否</c:if></p>
				</div>
				<div class="w-220 f-l" >
					<label class="f-l text-r w-80">工单编号：</label>
					<p class="lh-26 f-l">${pofr.number}</p>
				</div>
				<div class="w-220 f-r" >
					<label class="f-l text-r w-80">服务工程师：</label>
					<p class="lh-26 f-l">${pofr.employeName}</p>
				</div>
				<div class="w-220 f-l" >
					<label class="f-l text-r w-80">用户姓名：</label>
					<p class="lh-26 f-l">${pofr.customerName}</p>
				</div>
				<div class="w-220 f-r" >
					<label class="f-l text-r w-80">用户电话：</label>
					<p class="lh-26 f-l">${pofr.customerMobile}</p>
				</div>
			</div>
		</div>
		<input type="button" value="打印" id="btn" onclick="printOrder();" class="btn-print" style="width:100px;display:block;margin:10px auto;height:30px; line-height:30px;"/>
	</div>
</div>

</body>
</html>
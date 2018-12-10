<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title></title>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/print_sf.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery-migrate-1.4.1.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/JsBarcode.all.min.js"></script>

<script type="text/javascript">
	function printOrder() {
	//	document.getElementById("btn").style.display="none";
		$(".printpage1").jqprint({
			debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
			importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
			printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
			operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
		});
		
	}
	$(function(){
		var code = '${fitting.code}';
		
		showTiao(code);
	});
	
	function showTiao(code){
        $('.barcode').empty().qrcode({width: 110, height: 110, text:code});
        

        $("canvas").attr("id", "erw");
        var canvas = document.getElementById('erw');
        var context = canvas.getContext('2d');
        context.lineWidth = 5;
        context.strokeStyle = '#ffffff';
        context.stroke();

       // var image = new Image();
        $(".myImg").attr("src",canvas.toDataURL("image/png"));
	}
</script>
</head>
<body>
		<h2 class="mb-15 text-c " >
				配件二维码
		</h2>
		<div class="text-c"  id="btn" >
			<input type="button" value="打印"  onclick="printOrder();" class="btn-print" style="width:100px;display:inline-block;height:30px; line-height:30px; border:1px solid #ccc"/>
		<span style="margin-left:25px; color:red; font-size:14px;">建议使用谷歌浏览器</span>
		</div>
<c:forEach var="b" begin="0" end="${size }" step="1"  varStatus="stat">
<div class="wrap printpage1 cl" style="margin: -4px auto 0; font-size:12px;">
		<div class="" style="">
		<c:choose>
		<c:when test="${stat.index*14+13 <number}">
		<c:forEach  begin="${stat.index*14}" end="${stat.index*14+13}" > 
			<div class="f-l pd-5" style="width:50%;">
				<div class="codeBox cl" style="border:1px solid #000 ;height: 130px">
				<!-- 条码 -->
					<div class="codeimgBox">
						<div style="width:100px; height:100px;" class="barcode hide"></div>
						<img src="" style="width:95px; height:95px;" class="myImg"/>
						<p class="text-c tiaoCode">${fitting.code}</p>
					</div>
					<div class="" >
						<p class="pos-r pl-50"><span class="pos w-50 text-r lh-22">名称：</span><span class="lh-20">${fitting.name}</span> </p>
						<p class="pos-r pl-50 h-40 cl"><span class="pos w-50 text-r lh-22">型号：</span><span class="lh-20">${fitting.version}</span> </p>
						<p class="pos-r pl-50 "><span class="pos w-50 text-r lh-22">品牌：</span><span class="lh-20">${fitting.brand}</span>&nbsp;库位：<span class="lh-20">${fitting.location}</span></p>
						<p class="pos-r pl-50 "><span class="pos w-50 text-r lh-22">适用：</span><span class="lh-20">${fitting.suitCategory}</span></p>
					</div>
				</div>
			</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
		<c:forEach  begin="${stat.index*14}" end="${number-1}" > 
			<div class="f-l pd-5" style="width:50%">
				<div class="codeBox cl" style="border:1px solid #000;height: 130px">
				<!-- 条码 -->
					<div class="codeimgBox">
						<div style="width:100px; height:100px;" class="barcode hide"></div>
						<img src="" style="width:95px; height:95px;" class="myImg"/>
						<p class="text-c tiaoCode">${fitting.code}</p>
					</div>
					<div class="" >
						<p class="pos-r pl-50"><span class="pos w-50 text-r lh-22">名称：</span><span class="lh-20">${fitting.name}</span> </p>
						<p class="pos-r pl-50 h-40 cl"><span class="pos w-50 text-r lh-22">型号：</span><span class="lh-20">${fitting.version}</span> </p>
						<p class="pos-r pl-50 "><span class="pos w-50 text-r lh-22">品牌：</span><span class="lh-20">${fitting.brand}</span>&nbsp;库位：<span class="lh-20">${fitting.location}</span></p>
						<p class="pos-r pl-50 "><span class="pos w-50 text-r lh-22">适用：</span><span class="lh-20">${fitting.suitCategory}</span></p>
						
					</div>
				</div>
			</div>
			</c:forEach>
		</c:otherwise>
		</c:choose>
	
		</div>
	
</div>
<div style="page-break-after:always;"></div>
</c:forEach>
		
</body>
</html>
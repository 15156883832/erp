<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>重新提交</title>
 <meta name="decorator" content="base"/>
</head>
<body>

<div class="popupBox spOprocess logistics">
	<h2 class="popupHead">
		物流信息
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain">
			<div class="pcontent">
			<c:forEach items="${mapss }" var="map">
				<div class="llbox bk-gray">
					<h3 class="lltitle cl">物流信息 
					<span class="f-r mr-10">单号：${map.key}</span>
					<span class="f-r mr-20">名称：${logistucsName}</span>
					</h3>
					<div class="nologistics hide">商品尚未发货</div>
					<ul class="logisticslist pt-5 pb-5" style="min-height: 200px;max-height: 400px;overflow: auto">
						<c:forEach items="${map.value }" var="log" varStatus="idx">
						
						<c:choose>
						<c:when test="${idx.first}">
						<li>
							<div class="lltime">${log.key}</div>
							<div class="lladdress lladdr currentSeq"><i class="icon_seq"></i> ${log.value }</div>
						</li>
						</c:when>
						<c:otherwise>
						<li>
							<div class="lltime">${log.key}</div>
							<div class="lladdress lladdr "><i class="icon_seq"></i> ${log.value }</div>
						</li>
						</c:otherwise>
						</c:choose>
						</c:forEach>
						
						<c:choose>
						<c:when test="${confirmTime eq ''}"></c:when>
						<c:when test="${confirmTime eq null }"></c:when>
						<c:otherwise>
						<li>
							<div class="lltime">${confirmTime}</div>
							<div class="lladdress lladdr"><i class="icon_seq"></i> 已发货</div>
						</li>
						</c:otherwise>
						</c:choose>
						
					</ul>
				</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="text-c btbWrap">
			<a href="javascript:close();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
		</div>
	</div>
</div>


<!--_footer 作为公共模版分离出去-->
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery.jqGrid.src.revised.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<!--/_footer 作为公共模版分离出去-->

<script type="text/javascript">
	$(function(){
	
		$('.logistics').popup({fixedHeight:false});
	})
	
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
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base"/>
<title>续费</title>
</head>
<body>
<!-- 历史订单 -->
<div class="shadeBg" style="z-index:9999;"></div>
<!--<div class="renewBox">
	<a href="javascript:;" class="btnClose"></a>
	<i class="dateline">会员还有<span>3</span>天到期</i>
	<span class="discount discount5"></span>
	<a href="javascript:;" class="btnRenew">立即续费</a>
</div>-->

<c:choose>
	<c:when test="${xufeiInfo.discount == 5 or xufeiInfo.discount == 6}">
		<div class="renewBox ">
			<a href="javascript:;" class="btnClose" onclick="closeAndSaveRemind();"></a>
			<div class="discountWrap56 pos-r ml-20">
				<i class="italic dateline">会员还有<i>${xufeiInfo.leftDays}</i>天到期</i>
				<span class="discount discount${xufeiInfo.discount}"></span>
				<i class="italic disNumber ">会员到期后续费仅享<i>8折</i>优惠</i>
			</div>
			<div class="btnRenewWrap">
				<a href="javascript:;" class="btnRenew" onclick="showXuFei();">立即续费</a>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="renewBox">
			<a href="javascript:;" class="btnClose" onclick="closeAndSaveRemind();"></a>
			<div class="discountWrap8 pos-r ml-20">
				<i class="italic dateline">会员还有<i>${xufeiInfo.leftDays}</i>天到期</i>
				<span class="discount discount8"></span>
			</div>
			<div class="btnRenewWrap">
				<a href="javascript:;" class="btnRenew" onclick="showXuFei();">立即续费</a>
			</div>
		</div>
	</c:otherwise>
</c:choose>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
	
//	$(function(){
//		$('#Hui-article-box',window.top.document).css({'z-index':'1999'});
//		$.setPos($('.renewBox'));
//	})

    $(function(){
        $('#Hui-article-box',window.top.document).css({'z-index':'1999'});
        $.setPos($('.renewBox'));
    });

    function closeRemind() {
        var topWin = window.top;
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index);
        $("div.loadBg", $(topWin.document)).remove();
    }
    function closeAndSaveRemind() {
        parent.saveLastRemind(function () {});
        closeRemind();
    }
    function showXuFei() {
        var pLayer = parent.layer;
        closeAndSaveRemind();
        pLayer.open({
            type: 2,
            content: '${ctx}/reminder/showXufei',
            //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0
        });
    }

</script> 
</body>
</html>
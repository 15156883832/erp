<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<title>平台商品-平台合作商品</title>
</head>
<body>
<div class="popupBox yjorderDetail">
	<h2 class="popupHead">
		订单详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15">
			<div class="">
				<div class="f-14 lh-22 mt-15 mb-15">
					订单编号：<span id="dingdanNo">${rds.columns.number }</span>
					<span class="icon_State ml-10">
				<c:if test="${rds.columns.status eq '1'}">待审核</c:if>
				<c:if test="${rds.columns.status eq '2'}">
					<c:if test="${rds.columns.bstatus eq '3'}">待提货</c:if>
					<c:if test="${rds.columns.bstatus eq '4'}">已提货</c:if>
				</c:if>
				<c:if test="${rds.columns.status eq '4'}">未通过</c:if>
					</span>
				</div>
				<table class="table table-bg table-border table-bordered table-sdrk">
					<thead>
					<tr>
						<th>商品信息</th>
						<th class="w-130">订单金额（元）</th>
						<th class="w-130">下单时间</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>
							<div class="pd-15">
								<div class="cl">
								<c:forEach items="${imgs }" var="img" varStatus="ind">
									<div id="dImgs" class="f-l yjImgWrap">
										<img src="${prototypeStaticImgPath}${img }" class="prototypeImg" />
									</div>
									</c:forEach>
									<div class="f-l w-400 pt-15">
										<p id="dShowMgr" class="f-18 lh-30">${rds.columns.poname }/${rds.columns.model }</p>
										<p id="dRemarks" class="c-666">${rds.columns.remarks }</p>
									</div>
								</div>
								<div class="line-dashed mb-10 mt-15"></div>
								<div class="cl lh-20">
									<p id="dBrand" class="f-l w-270">${rds.columns.brand }</p>
									<p id="dCategory" class="f-l w-240">${rds.columns.category }</p>
								</div>
								
								<div id="dAddress" class="cl lh-20">
								${rds.columns.address }
								</div>
							</div>
						</td>
						<td id="dSalePrice" class="text-c">${rds.columns.purchase_amount }</td>
						<td id="dXdTime" class="text-c">${rds.columns.create_times }</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="text-c mt-40">
				<a href="javascript:cancelShowDesk();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$(".yjorderDetail").popup({closeSelfOnly:true});
});


function cancelShowDesk() {
	$.closeAllDiv();
}

</script>
</body>
</html>
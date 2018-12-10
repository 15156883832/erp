<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/> 
<title>区域管理-区域人员管理</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox sysNotice editeNotice" style="z-index: 199;">
	<h2 class="popupHead">
		分享明细
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>

	<div class="popupContainer">
				<div class="popupMain pd-15">	
		<div class=" text-c tableWrap" style="overflow:auto;max-height:400px;border-right:1px solid #ccc;">
				<table class="table table-bg table-border table-bordered text-c table-sdrk" id="bjStock_table" style="table-layout: fixed; width:840px">
					<thead>
						<tr>
							<th style="width: 70px">区域</th>
							<th style="width:80px">服务商名称</th>
							<th style="width: 100px;">联系人</th>
							<th style="width: 120px">联系电话</th>
							<th style="width: 120px">登录账号</th>
							<th style="width: 200px">详细地址</th>
							<th style="width: 150px">分享时间</th>
						</tr>
					</thead>
					<tbody class="" >
						<c:forEach var="item" items="${list}">
							<tr>
								<td >${item.columns.province}</td>
								<td class="text-l">${item.columns.name }</td>
								<td >${item.columns.contacts }</td>
								<td >${item.columns.telephone }</td>
								<td >${item.columns.loginName }</td>
								<td title="${item.columns.address }" class="text-overflow" >${item.columns.address }</td>
								<td >${item.columns.create_time }</td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>	
			</div>
		<div class="text-c mt-20">

				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">关闭</a>
			</div>


</div>
</div>

</div>

<script type="text/javascript">

	$(function(){

	
	
	$('.editeNotice').popup(); 
	});
	function closeds(){
		   //window.location.href="${ctx}/order/unit"
		$.closeDiv($('.editeNotice'));
	}




</script> 
</body>
</html> 
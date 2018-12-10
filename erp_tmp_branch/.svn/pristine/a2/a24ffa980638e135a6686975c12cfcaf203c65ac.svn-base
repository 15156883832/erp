<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>备件详情</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style type="text/css">
/* .webuploader-pick{
	background:#fff;
	padding:0;
	color: #0e8ee7;
} */
.webuploader-pick{
	background:none;
	color:#22a0e6;	
	padding:0;
	
}
/* .spimg1{ border:none;} */
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
.spimg2 .webuploader-pick{
	width:80px;
	height:80px;
}

.webuploader-pick img{
	width:100%;
	height:100%;
	position:absolute;
	left:0;
	top:0;
}
</style>
</head>

<body>
<!-- 审核申请 -->
<div class="popupBox shsqbox" >
	<h2 class="popupHead">
		备件详情
		<a href="javascript:;" class="sficon closePopup" id="topOne"></a>
	</h2>
	<div class="popupContainer pb-40">
		<div class="popupMain pos-r">
			<div class="pcontent">
			<div class="cl mb-5">
				<label class="f-l">&#12288;申请人：</label>
				<input type="text" class="input-text w-140 readonly f-l"  readonly="readonly" value="${fa.employeName }" />
				<input type="hidden" id="emNamId"  value="${fa.employeId }" />
				<label class="f-l w-90">申请时间：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="<fmt:formatDate value='${fa.createTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
			</div>
			<c:choose>
			<c:when test="${fa.orderNumber eq '' }">
			</c:when>
			<c:when test="${fa.orderNumber eq null }">
			</c:when>
			<c:otherwise>
				<h3 class="modelHead mb-10">工单信息</h3>
			<div class="cl mb-10">
				<label class="f-l">工单编号：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" id="orderNumber" value="${order.columns.number }" />
				<input type="text" hidden="hidden" class="input-text w-140 readonly f-l" id="orderType" readonly="readonly" value="${order.columns.order_type }" />
				<label class="f-l w-90">家电信息：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.columns.appliance_brand }${order.columns.appliance_category }"/>
				<label class="f-l w-90">家电型号：</label>
				<input id="applianceVersion" type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.columns.appliance_model }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l">保修类型：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${fmtWT}" />
				<label class="f-l w-90">用户姓名：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.columns.customer_name }"/>
				<label class="f-l w-90">联系方式：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.columns.customer_mobile }"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l">详细地址：</label>
				<input type="text" class="input-text w-370 readonly f-l" readonly="readonly" value="${order.columns.customer_address }" />
				<label class="f-l w-90">报修时间：</label>
				<input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="<fmt:formatDate value='${order.columns.repair_time }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
			</div>
			</c:otherwise>
		</c:choose>
		
			<h3 class="modelHead mb-10">
				备件信息
			</h3>

			<div class="cl mb-10">
				<div class="f-l w-400">
					<div class="f-l mb-10">
						<label class="f-l">备件条码：</label>
						<input type="hidden" value="${fa.id }" id="id"/>
						<input type="hidden" value="${fitting.id }" id="fittingId"/>
						<input type="text" class="input-text w-130 f-l readonly" readonly="readonly" value="${fa.fittingCode }" id="fittingCode"/>
						<input type="hidden" value="${fa.fittingCode }" id="fittingCode1"/>
						<label class="w-90 f-l">备件名称：</label>
						<input type="text" class="input-text w-110 f-l readonly" readonly="readonly" value="${fitting == null ? fa.fittingName : fitting.name }" id="fittingName"/>
					</div>

					<div class="f-l mb-10">
						<label class="f-l">备件型号：</label>
						<input type="text" class="input-text w-130 f-l readonly" readonly="readonly" value="${fitting == null ? fa.fittingVersion : fitting.version }" id="fittingVersion"/>
						<label class="w-90 f-l">适用品类：</label>
						<input type="text" class="input-text w-110 f-l readonly" readonly="readonly" value="${fitting == null ? fa.suitCategory : fitting.suitCategory }" id="suitCategory"/>
					</div>
					<div class="f-l mb-10">
						<label class="f-l">家电型号：</label>
						<div class=" w-130 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" value="${fa.suitMode }" />
						</div>
						<label class="w-90 f-l">申请数量：</label>
						<div class="priceWrap w-110 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" value="${fa.fittingApplyNum }" />
							<span class="unit">件</span>
						</div>
					</div>
					<div class="f-l mb-10">
						<label class="f-l">当前库存：</label>
						<div class="priceWrap w-130 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" value="${fitting.warning }" id="fittingWarning"/>
							<span class="unit">件</span>
						</div>
						<label class="w-90 f-l">审核数量：</label>
						<div class="priceWrap w-110 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly"  id="fittingAuditNum" value="${auditNum }"/>
							<span class="unit">件</span>
						</div>
					</div>
					<div class="f-l mb-10">
						<label class="f-l">返还旧件：</label>
						<select class="select w-130 readonly" id="oldFittingFlag" disabled>
							<c:choose>
								<c:when test="${fa.oldFittingFlag eq '0' }">
									<option value="">请选择</option>
									<option value="0" selected="selected">无需返还</option>
									<option value="1">需要返还</option>
								</c:when>
								<c:when test="${fa.oldFittingFlag eq '1' }">
									<option value="">请选择</option>
									<option value="0">无需返还</option>
									<option value="1" selected="selected">需要返还</option>
								</c:when>
								<c:otherwise>
									<option value="">请选择</option>
									<option value="0">无需返还</option>
									<option value="1">需要返还</option>
								</c:otherwise>
							</c:choose>
						</select>

					</div>
					<div class="f-l mb-10">
						<label class="f-l">申请备注：</label>
						<input type="text" class="input-text f-l readonly w-330 " readonly="readonly"   id="" value="${fa.employeFeedback}" title=""/>
					</div>
					<div class="f-l">
						<label class="f-l">审核备注：</label>
						<textarea class="input-text w-330 f-l h-50 readonly" readonly="readonly" id="auditMarks" name="employeFeedback">${fa.auditMarks}</textarea>
						<%--<input type="text" class="input-text f-l  w-330 h-50"   id="auditMarks" value="${fa.auditMarks}" title=""/>--%>
					</div>
				</div>
				<div class="f-r mb-10 w-260 " id="spimg1">
					<label class="f-l">图片：</label>
					<div class="f-l" style="width:220px">
						<c:forEach items="${fittingApplyImgs}" var="item">
							<div class="imgbox f-l mr-10 mb-10 spimg1">
								<img src="${commonStaticImgPath}${item}" />
							</div>
						</c:forEach>
					</div>
					<c:if test="${not hasApplyImgs}">
						<div class="f-l" style="width:220px">
							<div class="imgbox f-l mr-10 mb-10 ">
								<img src="${ctxPlugin}/static/h-ui.admin/images/img-default.png" />
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<c:if test="${fa.message !=null && fa.message != '' }">
				<h3 class="modelHead">申请反馈</h3>
				<div class="sqfkbox pt-10 ">
					<div class="h-50 bk-gray readonly">
						<c:forEach var="pros" items="${fns:getFittingProcess(fa.message)}">
						<c:set value="${pros.name }" var="name"></c:set>
								<p>
									<span class="time">${pros.time}</span>
									<span> ${pros.name}</span>
									<span> ：${pros.content}</span>
								</p>
					    </c:forEach>
					    <input type="hidden" value="${name}" id="nametest" />
					</div>
				</div>
			</c:if> 
		</div>
		</div>
		<div class="text-c btnWrap ">
			<a href="javascript:closeDetail();" class="sfbtn sfbtn-opt3 w-70 mr-5">关闭</a>
		</div>

	</div>
</div>


<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript">
	var ck = /^\d+(\.\d+)?$/;
	var exit="ok";
	$(function(){
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");
		
		$('.shsqbox').popup({fixedHeight:false});
		
		$('#fittingAuditNum').blur(function () {
			var fittiNum = $("#fittingAuditNum").val();
			var ficount = $("#fittingWarning").val();
			if (isBlank(fittiNum)) {
				layer.msg("请输入审核数量");
			} else if(ck.test(fittiNum)){
			    if(parseFloat(fittiNum)>parseFloat(ficount)){
			    	layer.msg("库存数量不足");
			    }
			}else{
				layer.msg("申请数量大于0");
			}
		});
		
		//检验条码是否存在并带出相应的信息
		$('#fittingCode').change(function () {
			var code = $("#fittingCode").val();
			if (!isBlank(code)) {
				$.ajax({
					type: "POST",
					url: "${ctx}/fitting/getfitting",
					data: {code:code},
					dataType: "json",
					success: function (data) {
						var obj = eval('data');
						if (obj.co == '1') {
							$("#fittingId").val(obj.record.columns.id);
							$("#suitCategory").val(obj.record.columns.suit_category);
							$("#oldFittingFlag").val(obj.record.columns.refund_old_flag);
							$("#fittingVersion").val(obj.record.columns.version);
							$("#fittingName").val(obj.record.columns.name);
							
							maxpj = parseFloat(obj.record.columns.warning);
							if (maxpj <= 0) {
								layer.msg('该配件已无库存');
								$("#fittingWarning").val(0);
							}else{
								$("#fittingWarning").val(obj.record.columns.warning);
							}
						} else {
						    // 配件条码不存在的时候，领导决定不清空已经有的信息。
							layer.msg("该条码配件不存在");
							exit = "no";
						}
					}
				});
			} else {
				layer.msg("请输入配件条码");
			}
		});
	});

    $("#topOne").on("click",function(){
		parent.search();
	});
	
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}
	
	 $('#spimg1').imgShow();
	
	 function closeDetail(){
		 $.closeDiv($(".shsqbox"));
	 }
</script> 
</body>
</html>
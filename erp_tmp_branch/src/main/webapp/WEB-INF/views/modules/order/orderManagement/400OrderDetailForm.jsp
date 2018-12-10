<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style>
 	.webuploader-pick{
		background:none;
		color:#22a0e6;
		width:80px;
		padding:0;
		height:80px;
	}
	.webuploader-pick img{
		width:100px;
		height:100px;
		position:absolute;
		left:0;
		top:0;
	}
</style>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.dateformat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb" style="width: 970px;">
	<h2 class="popupHead">
		工单详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain" >
			<div class="pcontent" style="padding-right: 20px;">
				<div class="tabBarP">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
					<%--
					<c:if test="${order400.columns.is_convert eq 0 }">
						<a href="javascript:;" onclick="zzj()" class=" f-r sfbtn sfbtn-opt w-80">转自接</a>
					</c:if>
					--%>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">工单编号：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.number }" />
						<input type="hidden" value="${order400.columns.id }" id="order400Id" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">服务类型：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.service_type }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">服务方式：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.mode }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">信息来源：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" unselectable="on" value="${order400.columns.origin }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">用户姓名：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_name }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">联系方式1：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_mobile }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">联系方式2：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_telephone }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">联系方式3：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.customer_telephone2 }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="pos-r txtwrap1">
						<label class="lb lb1">详细地址：</label>
						<input type="text" class="input-text readonly" style="width:367px" disabled="disabled"  value="${order400.columns.customer_address }"/>
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">家电品牌：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order400.columns.appliance_brand }"/>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">家电品类：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order400.columns.appliance_category }"/>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">预约日期：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value="${order400.columns.promise_time }" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">时间要求：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.promise_limit }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1 h-50">
						<label class="lb lb1">服务描述：</label>
						<textarea type="text" class="input-text h-50 readonly" style="width:367px" disabled="disabled"  value="">${order400.columns.customer_feedback }</textarea>
					</div>
					<div class="f-l pos-r txtwrap2 h-50">
						<label class="lb lb2">备注：</label>
						<textarea type="text" class="input-text h-50 readonly" style="width:370px" disabled="disabled" value="">${order400.columns.remarks }</textarea>
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">产品型号：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_model }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">产品数量：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_num }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">内机条码：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_barcode }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">外机条码：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_machine_code }" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">购买日期：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.appliance_buy_time }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">保修类型：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.warranty_type }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">重要程度：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.important }"  />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">报修时间：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value="${order400.columns.repair_time }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					</div>
				</div>
				<div class="cl mt-10">
					<div class="f-l pos-r txtwrap1">
						<label class="lb lb1">登记人：</label>
						<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.create_by }" />
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">服务过程：</label>
						<input type="text" class="input-text readonly" style="width: 595px;" disabled="disabled" value="${order400.columns.measures_description }" />
					</div>
				</div>
				<div id="serviceSub" class="mt-25">
				<div class="tabBarP mt-15">
					<a href="javascript:;" class="tabswitch current">派工信息</a>
					<a href="javascript:showSYMsg();" class="tabswitch">配件使用</a>
					<a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
				</div>
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">派工时间：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value="${order400.columns.dispatch_time }" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务工程师：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order400.columns.employe1 }${order400.columns.employe2 }${order400.columns.employe3 }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">工单状态：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.status }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">故障现象：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.malfunction_type }" />
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">收费总额：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务收费：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">辅材收费：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled"  />
								<span class="unit">元</span>
							</div>
						</div>
						
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">延保收费：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled"  />
								<span class="unit">元</span>
							</div>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="pos-r txtwrap1 pr-5">
							<label class="lb lb1">反馈内容：</label>
							<div class="readonly processWrap2">
								<p class="processItem">
									<span class="time"><fmt:formatDate value="${order400.columns.feedback_time }" pattern="yyyy-MM-dd HH:mm:ss"/>  </span>
									<span>${order400.columns.feedback }</span>
								</p>
								<!-- <p class="processItem">
									<span class="time">2017-04-26  10:12  </span>
									<span>张三：需要回去拿配件，已和用户沟通过，明天上门维修</span>
								</p> -->
							</div>
						</div>
					</div>
				</div>
				<div class="tabCon">
					<div style="width: 820px;overflow: auto;">
					<table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
						<caption>工单关联配件使用</caption>
						<thead>
							<tr>
								<th class="w-180">备件条码</th>
								<th class="w-260">备件名称</th>
								<th class="w-120">备件型号</th>
								<th class="w-120">备件型号</th>
								<th class="w-90">最新入库价格</th>
								<th class="w-80">工程师价格</th>
								<th class="w-50">数量</th>
								<th class="w-70">收费金额</th>
								<th class="w-70">状态</th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
				<div class="tabCon">
					<div >
						<table class="table table-border table-bordered table-bg table-relatedorder">
							<caption>工单关联旧件信息</caption>
							<thead>
								<tr>
									<th class="w-160">旧件条码</th>
									<th class="w-150">旧件名称</th>
									<th class="w-160">旧件型号</th>
									<th class="w-70">旧件品牌</th>
									<th class="w-60">是否原配</th>
									<th class="w-60">登记数量</th>
									<th class="w-70">状态</th>
									<th class="w-120">登记时间</th>
								</tr>
							</thead>
							<tbody class="oldtbody">
							</tbody>
						</table>
					</div>
					<div class="cl mt-10 pos-r txtwrap1" id="oldfittingimg">
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef" ></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
$(function(){
	$.Huitab("#serviceSub .tabBarP .tabswitch","#serviceSub .tabCon","current","click","0");
	$('.orderdetailVb').popup({fixedHeight:false});
});

//获取配件信息
//获取工单关联备件使用信息
function showSYMsg() {
	var orderNumber = "${order400.columns.number}";
	var str = "";
	var imgstr = "";
	var img = [];
	$.ajax({
		url: "${ctx}/order/showSYMsg",
		data: {orderNumber:orderNumber, remark: 'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
		dataType: 'json',
		async: false,
		success: function (result) {
			$("#pjsy").html("<caption>工单关联配件使用</caption>" +
					"<thead>" +
					"<tr>" +
					"<th class='w-180'>备件条码</th>" +
					"<th class='w-260'>备件名称</th>" +
					"<th class='w-120'>备件型号</th>" +
                "<th class='w-90'>最新入库价格</th>" +
                "<th class='w-80'>工程师价格</th>" +
                "<th class='w-70'>零售价格</th>" +
					"<th class='w-50'>数量</th>" +
					"<th class='w-70'>收费金额</th>" +
					"<th class='w-70'>状态</th>" +
					"</tr>" +
					"</thead>");

			if (result.list.length > 0) {
				$.each(result.list, function (index, val) {
					str += "<tr>" +
							"<td class='w-140'>" + val.columns.fitting_code + "</td>" +
							"<td class='w-300'>" + val.columns.fitting_name + "</td>" +
							"<td class='w-120'>" + val.columns.fitting_version + "</td>" +
                        "<td class='text-c w-90'>" + val.columns.site_price + "</td>" +
                        "<td class='text-c w-80'>" + val.columns.employe_price + "</td>" +
                        "<td class='text-c w-70'>" + val.columns.customer_price + "</td>" +
							"<td class='w-50'>×" + val.columns.used_num + "</td>" +
							"<td class='w-70'>" + val.columns.collection_money + "</td>";
					if (val.columns.status == "1") {
						str += "<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
					} else if (val.columns.status == "2") {
						str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
					}
				});
			} else {
				$(".showimg").html("");
			}

			$("#pjsy").append(str);
		}
	});
}

//获取工单关联旧件信息
function showOldFitting(){
	var orderNumber = "${order400.columns.number}";
	var str="";
	var imgstr="";
	$.ajax({
		url:"${ctx}/order/showOldFitting",
		data:{orderNumber:orderNumber},
		dataType:'json',
		async:false,
		success:function(result){
			$(".oldtbody").empty();
			$("#oldfittingimg").html("<label class='lb lb1'>旧件图片：</label>");
			if(result.list.length>0){
			$.each(result.list,function(index,val){
				str+="<tr>"+
				"<td class='w-180'>"+val.columns.code+"</td>"+
				"<td class='w-260'>"+val.columns.name+"</td>"+
				"<td class='w-120'>"+val.columns.version+"</td>"+
				"<td class='w-100'>"+val.columns.brand+"</td>";
				if(val.columns.yrpz_flag=="1"){
					str+="<td class='w-70'>是</td>";
				}else if(val.columns.yrpz_flag=="2"){
					str+="<td class='w-70'>否</td>";
				}
				str+= "<td class='w-50'>×"+val.columns.num+"</td>";
				if(val.columns.status=="0"){
					str+="<td class='w-70'>已登记</td>";
				}else if(val.columns.status=="1"){
					str+="<td class='w-70'>已入库</td>";
				}else if(val.columns.status=="3"){
					str+="<td class='w-70'>已返厂</td>";
				}else if(val.columns.status=="4"){
					str+="<td class='w-70'>已报废</td>";
				}
				str+= "<td class='w-50'>"+val.columns.cateTime+"</td>";
					str+="</tr class='w-100'>";


                var images=val.columns.img.split(",");
                for(var i=0;i<images.length;i++){
                    imgstr+= "<div class='f-l mr-10'><div class='imgWrap w-120 text-c'><img src='${commonStaticImgPath}"+images[i]+"'></img>";
                    imgstr+= "<p class='lh-20'>"+val.columns.cateTime+" </p></div></div>";
                }
			});	
				
			}else{
				$("#oldfittingimg").html("");
			}
			
			$(".oldtbody").append(str);
            jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                $("#oldfittingimg").append(imgstr);
                $('#oldfittingimg').imgShow();
            });
			return;
		}
		
	});
}
</script> 
</body>
</html>
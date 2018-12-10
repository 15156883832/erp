<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<title>平台商品-平台合作商品</title>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">

					<form action="${ctx}/order/queryTimes/querylist" id="searchForm" method="post">
							<input type="hidden" name="page" id="pageNo" value="${page.pageNo}"> 
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							
							<div>
								<table id="table-waitdispatch" class="table"></table>
								<div class="cl pt-10">
									<div class="f-r">
										<div class="pagination"></div>
									</div>
								</div>
							</div>
						</form>

					<div class="mt-10 text-c tableWrap">
					<table class="table table-bg table-border table-bordered table-sdrk" style="table-layout: fixed;">
						<thead>
							<tr>
								<th class="w-100">服务商名称</th>
								<th class="w-90">工单编号</th>
								<th class="w-90">用户姓名</th>
								<th class="w-130">用户联系方式</th>
								<th class="w-120">用户住址</th>
								<th class="w-80">信息来源</th>
								<th class="w-80">服务类型</th>
								<th class="w-80">家电品类</th>
								<th class="w-80">服务状态</th>
								<th class="w-80">标记类型</th>
								<th class="w-100">服务工程师</th>
								<th class="w-80">家电品牌</th>
								<th class="w-80">家电型号</th>
								<th class="w-80">家电条码</th>
								<th class="w-80">保修类型</th>
								<th class="w-80">重要程度</th>
								<th class="w-80">服务方式</th>
								<th class="w-80">工单来源</th>
								<th class="w-80">预约日期</th>
								<th class="w-80">交单情况</th>
								<th class="w-80">工单收费</th>
								<th class="w-80">是否交款</th>
								<th class="w-120">最大报修时间</th>
								<th class="w-120">最小报修时间</th>
								<th class="w-120">最小完工时间</th>
								<th class="w-120">最大完工时间</th>
								<th class="w-120">最小派工时间</th>
								<th class="w-120">最大派工时间</th>
								<th class="w-80">登记人</th>
								<th class="w-80">全部工单</th>
								<th class="w-80">待派工</th>
								<th class="w-80">维修中</th>
								<th class="w-100">待回访结算</th>
								<th class="w-80">历史工单</th>
								<th class="w-80">暂不派工</th>
								<th class="w-80">拒接工单</th>
								<th class="w-80">今日预约</th>
								<th class="w-80">待接工单</th>
								<th class="w-80">预警工单</th>
								<th class="w-80">待件工单</th>
								<th class="w-80">待回访工单</th>
								<th class="w-80">待结算工单</th>
								<th class="w-80">完工工单</th>
								<th class="w-80">无效工单列表</th>
								<th class="w-80">修改工单</th>
								<th class="w-80">无效按钮</th>
								<th class="w-80">暂不派工</th>
								<th class="w-80">反馈封单</th>
								<th class="w-80">标记工单</th>
								<th class="w-80">打印工单</th>
							</tr>
						</thead>
				<tbody>
				<c:forEach var="item" items="${page.list}">
					<tr>
						<td>
							${item.columns.name}
						</td>
						<td>${item.columns.number_count}</td>
						<td>${item.columns.customer_name_count }</td>
						<td>${item.columns.customer_mobile_count }</td>
						<td>${item.columns.customer_address_count}</td>
						<td>${item.columns.origin_count}</td>
						<td>${item.columns.service_type_count	}</td>
						<td>${item.columns.application_category_count}</td>
						<td>${item.columns.status_count}</td>
						<td>${item.columns.flag_count}</td>
						<td>${item.columns.employe_count}</td>
						<td>${item.columns.application_brand_count}</td>
						<td>${item.columns.appliance_model_count}</td>
						<td>${item.columns.appliance_barcode_count}</td>
						<td>${item.columns.warranty_type_count}</td>
						<td>${item.columns.level_count}</td>
						<td>${item.columns.service_mode_count}</td>
						<td>${item.columns.order_type_count}</td>
						<td>${item.columns.promise_time_count}</td>
						<td>${item.columns.return_card_count}</td>
						<td>${item.columns.order_cost_count}</td>
						<td>${item.columns.whether_collection_count}</td>
						<td>${item.columns.repair_time_max_count}</td>
						<td>${item.columns.repair_time_count}</td>
						<td>${item.columns.end_time_count}</td>
						<td>${item.columns.end_time_max_count}</td>
						<td>${item.columns.dispatch_time_count}</td>
						<td>${item.columns.dispatch_time_max_count}</td>
						<td>${item.columns.messenger_name_count}</td>
						<td>${item.columns.whole_order_count}</td>
						<td>${item.columns.dpg_order_count}</td>
						<td>${item.columns.during_order_count}</td>
						<td>${item.columns.stayvisit_order_count}</td>
						<td>${item.columns.history_order_count}</td>
						<td>${item.columns.zbpg_order_count}</td>
						<td>${item.columns.jjgd_order_count}</td>
						<td>${item.columns.jryy_order_count}</td>
						<td>${item.columns.djgd_order_count}</td>
						<td>${item.columns.yjgd_order_count}</td>
						<td>${item.columns.daijgd_order_count}</td>
						<td>${item.columns.dhf_order_count}</td>
						<td>${item.columns.djs_order_count}</td>
						<td>${item.columns.ywg_order_count}</td>
						<td>${item.columns.wx_order_count}</td>
						<td>${item.columns.update_order_count}</td>
						<td>${item.columns.invalid_order_count}</td>
						<td>${item.columns.temporarily_order_count}</td>
						<td>${item.columns.feedback_order_count}</td>
						<td>${item.columns.sign_order_count}</td>
						<td>${item.columns.print_order_count}</td>

					</tr>
					</c:forEach>
					<tr>
					<td colspan="50" ></td>
					</tr>
					<tr>
						<td>
							总数
						</td>
						<td>${rds.columns.number_count}</td>
						<td>${rds.columns.customer_name_count }</td>
						<td>${rds.columns.customer_mobile_count }</td>
						<td>${rds.columns.customer_address_count}</td>
						<td>${rds.columns.origin_count}</td>
						<td>${rds.columns.service_type_count	}</td>
						<td>${rds.columns.application_category_count}</td>
						<td>${rds.columns.status_count}</td>
						<td>${rds.columns.flag_count}</td>
						<td>${rds.columns.employe_count}</td>
						<td>${rds.columns.application_brand_count}</td>
						<td>${rds.columns.appliance_model_count}</td>
						<td>${rds.columns.appliance_barcode_count}</td>
						<td>${rds.columns.warranty_type_count}</td>
						<td>${rds.columns.level_count}</td>
						<td>${rds.columns.service_mode_count}</td>
						<td>${rds.columns.order_type_count}</td>
						<td>${rds.columns.promise_time_count}</td>
						<td>${rds.columns.return_card_count}</td>
						<td>${rds.columns.order_cost_count}</td>
						<td>${rds.columns.whether_collection_count}</td>
						<td>${rds.columns.repair_time_max_count}</td>
						<td>${rds.columns.repair_time_count}</td>
						<td>${rds.columns.end_time_count}</td>
						<td>${rds.columns.end_time_max_count}</td>
						<td>${rds.columns.dispatch_time_count}</td>
						<td>${rds.columns.dispatch_time_max_count}</td>
						<td>${rds.columns.messenger_name_count}</td>
						<td>${rds.columns.whole_order_count}</td>
						<td>${rds.columns.dpg_order_count}</td>
						<td>${rds.columns.during_order_count}</td>
						<td>${rds.columns.stayvisit_order_count}</td>
						<td>${rds.columns.history_order_count}</td>
						<td>${rds.columns.zbpg_order_count}</td>
						<td>${rds.columns.jjgd_order_count}</td>
						<td>${rds.columns.jryy_order_count}</td>
						<td>${rds.columns.djgd_order_count}</td>
						<td>${rds.columns.yjgd_order_count}</td>
						<td>${rds.columns.daijgd_order_count}</td>
						<td>${rds.columns.dhf_order_count}</td>
						<td>${rds.columns.djs_order_count}</td>
						<td>${rds.columns.ywg_order_count}</td>
						<td>${rds.columns.wx_order_count}</td>
						<td>${rds.columns.update_order_count}</td>
						<td>${rds.columns.invalid_order_count}</td>
						<td>${rds.columns.temporarily_order_count}</td>
						<td>${rds.columns.feedback_order_count}</td>
						<td>${rds.columns.sign_order_count}</td>
						<td>${rds.columns.print_order_count}</td>

					</tr>
				</tbody>	
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="pagination">${page}</div>
	</div>

<script type="text/javascript">
	
	$(function(){
		initTableH();
	});
	
	window.onresize = function(){
		initTableH();
	};
	
	function initTableH(){
		var tHeight = $('.sfpagebg').height()-200;
		$('.tableWrap').css({
			'max-height':tHeight,
			'overflow':'auto',
		})
	}
	
	function search(){
		$("#searchForm").submit();
	}
	
	function jsClearForm() {
		$("#searchForm :input[type='text']").each(function () { 
		$(this).val(""); 
		}); 
		
		$("select").val(""); 

	}
	
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
    	return false;
    }
	

</script> 
</body>
</html>
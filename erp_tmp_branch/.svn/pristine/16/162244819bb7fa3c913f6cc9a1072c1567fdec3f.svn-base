<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<p class="f-r pb-5">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
							<a href="javascript:resert();" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm" action="${ctx}/order/getFactoryReturnOrder" method="post">
							 <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>		
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">工单编号：</th>
										<td><input type="text" class="input-text" name="number" id="number" value="${map.number }"/>
										</td>
										<th style="width: 76px;" class="text-r">服务类型：</th>
										<td><input type="text" class="input-text" name="serviceType" id="serviceType" value="${map.serviceType }"/>
										</td>
										<th style="width: 76px;" class="text-r">报修时间：</th>
										<td colspan="5">
											<input type="text" class="input-text Wdate w-140" style="width: 120px;" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="repairTimeMin" name="repairTimeMin"  value="${map.repairTimeMin }"/>
											至
											<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" class="input-text Wdate w-140" style="width: 120px;"  id="repairTimeMax" name="repairTimeMax"  value="${map.repairTimeMax }"/>
											<label style="width:76px;">完工时间：</label>
											<input type="text" class="input-text Wdate w-140" style="width: 120px;"  onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="endTimeMin" name="endTimeMin"  value="${map.endTimeMin }"/>
											至
											<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" class="input-text Wdate w-140" style="width: 120px;"  id="endTimeMax" name="endTimeMax"  value="${map.endTimeMax }"/>
										
										</td>
										
									</tr>
									<tr>
										<th style="width: 76px;" class="text-r">回访时间：</th>
										<td colspan="3">
											<input type="text" class="input-text Wdate w-140" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="visistTimeMin" name="visistTimeMin"  value="${map.visistTimeMin }"/>
											至
											<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" class="input-text Wdate w-140" id="visistTimeMax" name="visistTimeMax"  value="${map.visistTimeMax }"/>
										</td>
									</tr>
								</table>
							</div>
						</form>


						<div class="mt-10" style="overflow: auto;">
							<table id="table-waitdispatch"
								class="table table-bg table-border table-bordered text-c">
								<thead>
									<tr class="text-c">
										<th width="160px">工单编号</th>
										<th width="160px">回访时间</th>
										<th width="100px">回访人</th>
									<c:forEach items="${visitList }" var="vis">
										<th width="100px">${vis.return_visit_content }</th>
									</c:forEach>
										<th width="100px">服务类型</th>
										<th width="100px">服务方式</th>
										<th width="100px">服务品类</th>
										<th width="120px">用户姓名</th>
										<th width="120px">联系电话</th>
										<th width="140px">地址</th>
									</tr>
								</thead>
								<tbody id="allList">
									<c:forEach items="${page.list }" var="lis">
										<tr>
											<td><a href="javascript:showOrderDetail('${lis.number }');" class="c-0383dc">${lis.number }</a></td>
											<td>${lis.visistTime }</td>
											<td>${lis.createName }</td>
											<c:forEach items="${lis.details }" var="det">
												<td>${det.visit_item_val }</td>
											</c:forEach>
											<td>${lis.serviceType }</td>
											<td>
												<c:choose>
													<c:when test="${lis.serviceMode eq '1' }">上门</c:when>
													<c:otherwise>拉修</c:otherwise>
												</c:choose>
											</td>
											<td>${lis.applianceCategory }</td>
											<td>${lis.customerName }</td>
											<td>${lis.customerMobile }</td>
											<td>${lis.customerAddress }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- pagination -->
							<div class="cl pt-10">
								<div class="f-r"></div>
							</div>
							<!-- pagination -->
							<div class="h-30 pagination pr-10" >
								<!-- 分页 -->${page}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
	<script type="text/javascript">

	
		$(function() {
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
	
		});
		
		function showOrderDetail(id){
		    layer.open({
		        type : 2,
		        content:'${ctx}/order/orderDispatch/historyform?id='+id,
		        title:false,
		        area: ['100%','100%'],
		        closeBtn:0,
		        shade:0,
		        fadeIn:0,
		        anim:-1
		    });
		}
		
		$('#close').on('click',function(){
			$.closeDiv($('.gdjsbb'));
		});
		
		function resert(){
			$("#repairTimeMin").val('');
		}

		function search(){
			$("#searchForm").submit();
		}
		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
		}
	</script>
	
</body>
</html>
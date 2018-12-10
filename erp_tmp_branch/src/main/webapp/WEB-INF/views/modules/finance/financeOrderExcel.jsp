<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<sfTags:pagePermission authFlag="FINANCEMGM_FINANCEREPORT_ORDERREPORT_TAB" html='<a class="btn-tabBar"  href="${ctx }/finance/financeOrderExcel/orderHeaderList">工单报表</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FINANCEMGM_FINANCEREPORT_GOODSREPORT_TAB" html='<a class="btn-tabBar current"  href="${ctx }/finance/financeOrderExcel/headerList">商品报表</a>'></sfTags:pagePermission>
			
			<p class="f-r btnWrap">
				<a href="javascript:loadList();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm" action="${ctx}/finance/revenue/goods" method="post">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="10">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">销售人员：</th>
							<td>
								<span class="select-box">
									<select class="select" name="placingName" id="placingName">
										<option value="">请选择</option>
										<c:forEach items="${placingNameList }" var="pnList">
											<option value="${pnList }">${pnList }</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">零售时间：</th>
							<td colspan="3">
								<input type="text" class="input-text Wdate w-140" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="placingOrderTime" name = "placingOrderTime"/>
								至
								<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" class="input-text Wdate w-140" id="placingOrderTime1" name = "placingOrderTime1"/>
							</td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="pt-10 pb-5 cl">
			</div>
			
			<div>
				<table id="table-waitdispatch" class="table table-bg table-border table-bordered">
					<thead>
						<tr class="text-c">
							<th width="100px">销售人员</th>
							<th width="200px">实收金额</th>
							<th width="140px">提成金额</th>
							<th width="100px">零售成本</th>
							<th width="200px">零售利润</th>
							<th width="140px">操作</th>
						</tr>
					</thead>
					<tbody id="allList"> 
						
					</tbody> 
				</table>
				<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					<!-- pagination -->
			</div>
			<%-- <div class="pagination" >${page}</div> --%>
		</div>
	</div>
</div>
</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
	
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
var rId;
var ifFk;
var ifSuccess;
var poTime3

$(function(){
 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
 	loadList();
});


 
function loadList(){
	var placingName = $("#placingName").val();
	var poTime = $("#placingOrderTime").val();
	var poTime1 = $("#placingOrderTime1").val();
	
	$.ajax({
		type:"post",
		url:"${ctx}/finance/financeOrderExcel/loadList",
		data:{placingName:placingName,
			poTime:poTime,
			poTime1:poTime1},
		success:function(result){
			$("#allList").empty();
			for(var i=0;i<result.length;i++){
				if(result[i].emName!=undefined){
					$("#allList").append(
					'<tr class="text-c">'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result[i].emName+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result[i].confirmAmount+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result[i].salesCommissions+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result[i].lsChengben+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result[i].lsLsrun+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" ><a onclick="changeCurrrent(\''+result[i].emName+'\')"  class="c-0383dc"><i class="sficon sficon-view"></i>查看明细<a/></div>'+
						'</td>'+
					'</tr>'
					)
				}
			}
			for(var i=0;i<result.length;i++){
				if(result[i].confirmAmountAll!=undefined){
					$("#allList").append(
							'<tr class="text-c">'+
								'<td class="text-c" >'+
									'<div class="" style="text-align:center" >合计</div>'+
								'</td>'+
								'<td class="text-c" >'+
									'<div class="" style="text-align:center" >'+result[i].confirmAmountAll+'</div>'+
								'</td>'+
								'<td class="text-c" >'+
									'<div class="" style="text-align:center" >'+result[i].salesCommissionsAll+'</div>'+
								'</td>'+
								'<td class="text-c" >'+
									'<div class="" style="text-align:center" >'+result[i].lscbAll+'</div>'+
								'</td>'+
								'<td class="text-c" >'+
									'<div class="" style="text-align:center" >'+result[i].lslrAll+'</div>'+
								'</td>'+
								'<td class="text-c" >'+
									'<div class="" style="text-align:center" ><a onclick="changeCurrrent1()"  class="c-0383dc"><i class="sficon sficon-view"></i>查看明细<a/></div>'+
								'</td>'+
							'</tr>'
							)
				}
			} 
			
		}
 	})
}

function changeCurrrent(emName){
	$("#placingName").val(emName);
	$("#searchForm").submit();
	var aSide = $('#Hui-aside', parent.document);
	aSide.children('.menu_dropdown').find('li').removeClass('current');
	aSide.children('.menu_dropdown').find('a[data-title="服务商收支明细"]').parent('li').addClass('current');
}

function  changeCurrrent1(){
	$("#searchForm").submit();
	var aSide = $('#Hui-aside', parent.document);
	aSide.children('.menu_dropdown').find('li').removeClass('current');
	aSide.children('.menu_dropdown').find('a[data-title="服务商收支明细"]').parent('li').addClass('current');
}
 	
</script>
	
</body>
</html>
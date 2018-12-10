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
					<sfTags:pagePermission authFlag="FINANCEMGM_FINANCEREPORT_ORDERREPORT_TAB" html='<a class="btn-tabBar current" href="${ctx }/finance/financeOrderExcel/orderHeaderList">工单报表</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FINANCEMGM_FINANCEREPORT_GOODSREPORT_TAB" html='<a class="btn-tabBar "  href="${ctx }/finance/financeOrderExcel/headerList">商品报表</a>'></sfTags:pagePermission>
						
						
						<p class="f-r btnWrap">
							<a href="javascript:loadList();" class="sfbtn sfbtn-opt"><i
								class="sficon sficon-search"></i>查询</a> <a href="javascript:resert();"
								class="sfbtn sfbtn-opt resetSearchBtn"><i
								class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm" action="${ctx}/finance/revenue/order" method="post">
							<input type="hidden" name="page" id="pageNo" value="1"> <input
								type="hidden" name="rows" id="pageSize" value="10">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<%-- <th style="width: 76px;" class="text-r">服务工程师：</th>
										<td><span class="select-box"> <select
												class="select" name="employeName" id="employeName">
													<option value="">请选择</option>
													<c:forEach items="${employeList }" var="emList">
														<option value="${emList }">${emList }</option>
													</c:forEach>
											</select>
										</span></td> --%>
										<th style="width: 76px;" class="text-r">保修类型：</th>
										<td><span class="select-box">
											 <select
												class="select" name="warrantyType" id="warrantyType">
													<option value="">请选择</option>
													<option value="1">保内</option>
													<option value="2">保外</option>
													<!-- <option value="3">保外转保内</option> -->
											</select>
										</span></td>
										<th style="width: 76px;" class="text-r">家电品牌：</th>
										<td><input type="text" class="input-text"
											name="applianceBrand" id="applianceBrand" /></td>
										<th style="width: 76px;" class="text-r">家电品类：</th>
										<td><input type="text" class="input-text"
											name="applianceCategory" id="applianceCategory" /></td>
									</tr>
									<tr>
										<th style="width: 76px;" class="text-r">报修时间：</th>
										<td colspan="1"><input type="text"
											class="input-text Wdate w-140"
											onFocus="WdatePicker({onpicking: cDayFuncmin,readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"
											id="repairTimeMin" value="${repairTimeMin}" name="repairTimeMin" /> 至 <input type="text"
											onFocus="WdatePicker({onpicking: cDayFuncmax,readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" value="${repairTimeMax }"
											class="input-text Wdate w-140" id="repairTimeMax"
											name="repairTimeMax" /></td>
										<th style="width: 76px;" class="text-r">完工时间：</th>
										<td colspan="1"><input type="text"
											class="input-text Wdate w-140"
											onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"
											id="endTimeMin" name="endTimeMin" /> 至 <input type="text"
											onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"
											class="input-text Wdate w-140" id="endTimeMax" name="endTimeMax" /></td>
									</tr>
								</table>
							</div>
						</form>

						<div class="pt-10 pb-5 cl"></div>

						<div>
							<table id="table-waitdispatch"
								class="table table-bg table-border table-bordered">
								<thead>
									<tr class="text-c">
										<th width="100px">工单总数</th>
										<th width="200px">实收金额</th>
										<th width="140px">已结算工单</th>
										<th width="100px">结算金额</th>
										<th width="140px">操作</th>
									</tr>
								</thead>
								<tbody id="allList">

								</tbody>
							</table>
							<!-- pagination -->
							<div class="cl pt-10">
								<div class="f-r"></div>
							</div>
							<!-- pagination -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 工单结算报表 -->
<div class="popupBox gdjsbb">
	<h2 class="popupHead">
		工单结算报表
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pd-15">
			<div class="mb-10 cl">
				<strong class="f-14"><div id="timeRange"></div></strong>
				<a href="${ctx}/finance/financeOrderExcel/export?formPath=/a/finance/financeOrderExcel/export" class="sfbtn sfbtn-opt f-r ml-10" ><i class="sficon sficon-export "></i>导出</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt f-r" ><i class="sficon sficon-print"></i>打印</a>
			</div>
			
			<div class="mt-10 text-c tableWrap">
				<div class="tableLabel">
					<table class="table table-bg table-bordered table-sdrk" style="border-bottom: 0;">
						<thead>
							<tr>
								<th style="width: 25%;">工程师姓名</th>
								<th style="width: 25%;">已结算工单数</th>
								<th style="width: 25%;">未结算工单数</th>
								<th style="width: 25%;">结算金额（元）</th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="tableBody">
					<table class="table table-border table-bordered" id="table_body">
						<tbody class="" id="jsOrderDetail">
							<!-- <tr>
								<td>12131000000236</td>
								<td >备件01</td>
								<td>20</td>
								<td>10</td>
							</tr> -->
						</tbody>
					</table>	
				</div>
				<div class="tableLabel tableFoot">
					<table class="table table-border table-bordered">
						<tfoot class="bg-eee" id="hejiFoot">
							
						</tfoot>
					</table>
				</div>
			</div>
			
			<div class="text-c mt-15">
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="close">关闭</a>
			</div>
		</div>
	</div>
</div>

<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">
		提示
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
			</div>
		</div>
	</div>
</div>
	
	
	
	<script type="text/javascript">
		var orderCount = '${orderCount}';
		var confirmMoney = '${confirmMoney}';
		var yjsOrderCount = '${yjsOrderCount}';
		var sumMoney = '${sumMoney}';
	
	
		$(function() {
			$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
				if(result=="showPopup"){
					
					$(".vipPromptBox").popup();
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
				}
			});
			 $('#repairTimeMin').bind('blur', function() {
			        dealRepairTime();
			    })
			    $('#repairTimeMax').bind('blur', function() {
			        dealRepairTime();
			    })
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
			loadList();
		});
		
		function isBlank(val) {
		    if(val==null || $.trim(val)=='' || val == undefined) {
		        return true;
		    }
		    return false;
		}
		
		function loadList(){
			if(!dealRepairTime()){
				return;
			}
			$.ajax({
				type:"post",
				url:"${ctx}/finance/financeOrderExcel/loadOrderList",
				data:$("#searchForm").serializeJson(),
				success:function(result){
					$("#allList").empty();
					$("#allList").append(
					'<tr class="text-c">'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result.orderCount+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result.confirmMoney+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" >'+result.yjsOrderCount+'</div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" ><a style="color:blue" >'+result.sumMoney+'</a></div>'+
						'</td>'+
						'<td class="text-c" >'+
							'<div class="" style="text-align:center" ><a onclick="changeCurrrent()"  class="c-0383dc"><i class="sficon sficon-view"></i>查看明细<a/></div>'+
						'</td>'+
					'</tr>')
				}
		 	})
		}
		
		function changeCurrrent(){
			$("#searchForm").submit();
			var aSide = $('#Hui-aside', parent.document);
			aSide.children('.menu_dropdown').find('li').removeClass('current');
			aSide.children('.menu_dropdown').find('a[data-title="服务商收支明细"]').parent('li').addClass('current');
		}
		
		/*结算金额明细*/
		// 在弹出弹出框后调用
		function initTableHeight(){
			var maxHeight = 380;
			$('#table_body tr').last().children('td').css({'border-bottom':'0'});
			var tableHeight = $('#table_body').height();
			if( tableHeight >maxHeight){
				$('.tableBody').css({
					'height':maxHeight,
					'overflow-y':'auto',
					'overflow-x':'hidden',
					'padding-left':'17px',
					'position':'relative',
					'left':'-17px',
					'width':$('.tableBody').width()+17,
				});
				$('#table_body').width($('.tableLabel').width()-1);
			}
		}
		
		function employeOrderDetail(){
			$("#timeRange").empty();
			var t1 = $("#endTimeMin").val();
			var t2 = $("#endTimeMax").val();
			if(t1=="" && t2==""){
				$("#timeRange").append('<span>所有工单结算报表</span>');
			}else if(t1=="" && t2 != "" ){
				$("#timeRange").append('<span>'+t2+'之前工单结算报表</span>');
			}else if(t1 !="" && t2 == ""){
				$("#timeRange").append('<span>'+t1+'之后工单结算报表</span>');
			}else if(t1 !="" && t2 != ""){
				$("#timeRange").append('<span>'+t1+'到'+t2+'工单结算报表</span>');
			}
			$.ajax({
				type:"post",
				url:"${ctx}/finance/financeOrderExcel/employeOrderDetail",
				data:$("#searchForm").serializeJson(),
				success:function(result){
					$("#jsOrderDetail").empty();
					$("#hejiFoot").empty();
				for(var i=0;i<result.list.length;i++){
					$("#jsOrderDetail").append(
						'<tr>'+
						'<td>'+result.list[i].columns.name+'</td>'+
						'<td >'+result.list[i].columns.yjs+'</td>'+
						'<td>'+result.list[i].columns.wjs+'</td>'+
						'<td>'+result.list[i].columns.tatol+'</td>'+
					'</tr>');
				}
				$("#hejiFoot").append(
					'<tr>'+
						'<td>合计</td>'+
						'<td >'+result.yjsOrderCount+'</td>'+
						'<td>'+result.wjsOrderCount+'</td>'+
						'<td>'+result.jsMoenyAll+'</td>'+
					'</tr>');
					
				$('.gdjsbb').popup();
				initTableHeight();
					
				}
			})
		}
		
		$('#close').on('click',function(){
			$.closeDiv($('.gdjsbb'));
		})
		
		function resert(){
			$("#repairTimeMin").val('${repairTimeMin }');
		    $("#repairTimeMax").val('${repairTimeMax }');
		}
		
		function jumpToVIP(){
			layer.open({
				type : 2,
				content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
				title:false,
				area: ['100%','100%'],
				closeBtn:0,
				shade:0,
				anim:-1 
			});
		}
		
		function dealRepairTime(){
			var repairTimeMin = $("#repairTimeMin").val();
		    var repairTimeMax = $("#repairTimeMax").val();
		    if(isBlank(repairTimeMin)){
		        layer.msg("报修时间查询起始时间不能为空！");
				return false;
			}
		    if(isBlank(repairTimeMax)){
		        layer.msg("报修时间查询结束时间不能为空！");
		        return false;
		    }
		    if(repairTimeMin.substring(0,4)!=repairTimeMax.substring(0,4)){
		        layer.msg("报修时间查询不能跨年！");
				return false;
			}
			return true;

		}


		function dealRepairTimeOne(dp,type){
		    if(type=='min'){
		        var repairTimeMax = $("#repairTimeMax").val();
		        if(isBlank(dp)){
		            layer.msg("报修时间查询起始时间不能为空！");
		            return false;
		        }
		        if(isBlank(repairTimeMax)){
		            layer.msg("报修时间查询结束时间不能为空！");
		            return false;
		        }
		        if(dp.substring(0,4)!=repairTimeMax.substring(0,4)){
		            layer.msg("报修时间查询不能跨年！");
		            return false;
		        }
		        return true;
			}else{
		        var repairTimeMin = $("#repairTimeMin").val();
		        if(isBlank(repairTimeMin)){
		            layer.msg("报修时间查询起始时间不能为空！");
		            return false;
		        }
		        if(isBlank(dp)){
		            layer.msg("报修时间查询结束时间不能为空！");
		            return false;
		        }
		        if(dp.substring(0,4)!=repairTimeMin.substring(0,4)){
		            layer.msg("报修时间查询不能跨年！");
		            return false;
		        }
		        return true;
			}
		}

		function cDayFuncmin(dp){
		    var date = dp.cal.getNewDateStr();
		    dealRepairTimeOne(date,"min");
		}

		function cDayFuncmax(dp){
		    var date = dp.cal.getNewDateStr();
		    dealRepairTimeOne(date,"max");
		}
		
		
	</script>
	
</body>
</html>
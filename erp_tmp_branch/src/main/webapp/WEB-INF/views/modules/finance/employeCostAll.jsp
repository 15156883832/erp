<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

<meta name="decorator" content="base" />
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
<style type="text/css">
.has-switch {
	min-width: 70px;
}

.has-switch span, .has-switch label {
	padding-top: 0;
	padding-bottom: 0;
	line-height: 22px;
	height: 22px;
}

</style>
</head>

<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait" style="padding-bottom: 0">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_TAB" html='<a class="btn-tabBar " href="${ctx}/finance/revenue/order">工单收支明细</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_SEEDETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx}/finance/revenue/toEmployeDetail">工程师结算明细</a>'></sfTags:pagePermission>

					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt">
							<i class="sficon sficon-search"></i>
							查询
						</a>
						<a href="javascript:reset();" class="sfbtn sfbtn-opt resetSearchBtn" id="reset">
							<i class="sficon sficon-reset"></i>
							重置
						</a>
					</p>
				</div>
				<div class='mb-10'>
					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_DETAILED_TAB" html='<a class="mr-15 active__" href="${ctx}/finance/revenue/toEmployeDetail">工程师结算明细</a>'></sfTags:pagePermission>
					<span class='line_'></span>
					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_STATISTICS_TAB" html='<a class="ml-15 " href="${ctx}/finance/revenue/toEmpJSCount">工程师结算统计</a>'></sfTags:pagePermission>
				
				</div>
				<form id="searchForm" action="${ctx}/finance/revenue/toCostAll" method="post">
					<input type="hidden" name="page" id="pageNo" value="1">
					<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
					<div class="bk-gray pt-10 pb-5">
						<input type="hidden" name="siteId" id="siteId" value="${siteId }">
						<table class="table table-search">
							<tr>
								<th style="width: 76px;" class="text-r">服务工程师：</th>
								<td>
									<span class="">
										<select class="select select-box" name="employeName" id="employeName" value="${map1.employeName }">
											<option value="">请选择</option>
											<c:forEach items="${empList }" var="emList">
												<option value="${emList.columns.id }" <c:if test="${map1.employeName == emList.columns.id }">selected="selected"</c:if>>${emList.columns.name }<c:if
														test="${emList.columns.status=='3' }">（已离职）</c:if></option>
											</c:forEach>
										</select>
									</span>
								</td>
								<th style="width: 76px;" class="text-r">报修时间：</th>
								<td colspan="3">
									<input type="text" onfocus="WdatePicker({onpicking: cDayFuncmin,maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="${map1.repairTimeMin }" class="input-text Wdate  w-140" style="width:140px">
									至
									<input type="text" onfocus="WdatePicker({onpicking: cDayFuncmax,minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="repairTimeMax" name="repairTimeMax" value="${map1.repairTimeMax }" class="input-text Wdate  w-140" style="width:140px">
								</td>
								<td colspan="4">
									<label class="text-r " style="margin-left: -12px">结算归属日期：</label>
									<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'settlementTimeMax\')||\'%y-%M-%d\'}'})" id="settlementTimeMin" name="settlementTimeMin" value="${settlementTimeMin }" class="input-text Wdate  w-140" style="width:140px">
									至
									<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'settlementTimeMin\')}',maxDate:'%y-%M-%d'})" id="settlementTimeMax" name="settlementTimeMax" value="${settlementTimeMax }" class="input-text Wdate  w-140" style="width:140px">
								</td> 
								
							</tr>
							<tr >
								
								<th style="width: 76px;" class="text-r">完工时间：</th>
								<td colspan="3">
									<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="endTimeMin" name="endTimeMin" value="${endTimeMin }" class="input-text Wdate  w-140" style="width:140px">
									至
									<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="endTimeMax" name="endTimeMax" value="${endTimeMax }" class="input-text Wdate  w-140" style="width:140px">
									
								</td>
							</tr>
						</table>
					</div>
				</form>
				<div class="pt-10 pb-5 cl">
					<div class="f-l tabBarP2">
						<a class="radiobox  mr-15" onclick="huizong1()"  >明细</a>
						<a class="radiobox radiobox-selected"  onclick="huizong()" >汇总</a>
					</div>
					<div class="f-r">
						<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_EXPORT_BTN"
							html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					</div>
				</div>
				<div>
					<div class="boxWrap" id="boxWrapHead">
						<table class="table table-bg table-border table-bordered table-sdrk" id="huizongtable">
							<thead>
								<tr>
									<th style="width: 8%;">序号</th>
									<th style="width: 23%;">服务工程师</th>
									<th style="width: 23%;">结算金额</th>
									<th style="width: 23%;">当日支付</th>
									<th style="width: 23%;">应发金额</th>
								</tr>
							</thead>
							<tbody id="countCost">
								<c:forEach items="${page.list}" var="pl" varStatus="idx">
									<tr>
										<td style="width: 8%;text-align:center;">${idx.index + 1 }</td>
										<td style="width: 23%;text-align:center;">${pl.columns.employe_name }</td>
										<td style="width: 23%;text-align:center;">${pl.columns.allMoney }</td>
										<td style="width: 23%;text-align:center;">${pl.columns.todayMoney }</td>
										<td style="width: 23%;text-align:center;">${pl.columns.relMoney }</td>
									</tr> 
								</c:forEach> 
							</tbody>
						</table>
					</div>
					<!-- <div class="boxWrap" id="boxWrapTable">
						<table class="table table-border table-bordered text-c"  style="border-top: 0;">
							
						</table>
					</div> -->
					
					
					<div class="cl mt-10">
						<!-- 分页 -->
						<div class="pagination">${page}</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
	<script type="text/javascript">

	$(function(){
	    $('#repairTimeMin').bind('blur', function() {
	        dealRepairTime();
	    })
	    $('#repairTimeMax').bind('blur', function() {
	        dealRepairTime();
	    })
		
	//	$('.gcsjsmxhzWrap').popup();
		$.setPos($('.gcsjsmxhzWrap'));
		initTableH();
	    $('#employeName').select2();
	    $(".selection").css("width","140px");
	})


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

	function search(){
	    if(!dealRepairTime()){
			return;
		}
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$('#pageNo').val('1');
		$('#searchForm').submit();
	}

	function page(n, s) {
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return;
	}

	function initTableH(){
		var h2 = $('#boxWrapTable table').height();
		if(h2 > 470){
			$('#boxWrapHead').css({'padding-right':'17px'});
		}
	}

	function exports(){
		var idArr=document.getElementById("huizongtable").rows.length ;
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
					 location.href="${ctx}/finance/revenue/employeCostAllExport?maps="+$("#searchForm").serialize();
				 }
			});
		}else{
			 location.href="${ctx}/finance/revenue/employeCostAllExport?maps="+$("#searchForm").serialize();
		}

	}


	function isBlank(val) {
	    if(val==null || $.trim(val)=='' || val == undefined) {
	        return true;
	    }
	    return false;
	}

	function huizong(){
		window.location.href="${ctx}/finance/revenue/toCostAll?map="+$("#searchForm").serialize();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	}

	function huizong1(){
		window.location.href="${ctx}/finance/revenue/toEmployeDetail?map="+$("#searchForm").serialize();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
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
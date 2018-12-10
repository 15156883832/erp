<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统公告管理</title>
	<meta name="decorator" content="base"/>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/highcharts.js"></script>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/exporting.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin }/static/h-ui.admin/css/easyui.css" />
	<script src="${ctxPlugin }/static/h-ui.admin/js/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
	<style type="text/css">
		.stockboxCur{
			background:  #e7eff5;
			position: relative;
			border-bottom: 1px solid #e7eff5;
		}
		.stockboxCur:before{
			content: '';
			position: absolute;
			left: -1px;
			top: -1px;
			right: -1px;
			height: 3px;
			background: #0e8ee7;
		}

	</style>
</head>
<body>
<div class="sfpagebg bk-gray" style="overflow: hidden;"><div class="sfpage">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="STATISTIC_STOCKSTAT_STOCKSTORE_TAB" html='<a class="btn-tabBar current" href="${ctx}/statistic/stockStat">备件库存</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="STATISTIC_STOCKSTAT_GOODSTORE_TAB" html='<a class="btn-tabBar" href="${ctx}/statistic/goodsStat">商品库存</a>'></sfTags:pagePermission>
		</div>
		<div class="mt-10 cl" id="allHeader">
			<div class="f-l pl-20 pt-15 pb-15 bk-gray  bgstyle" onclick="stockComStatistics(1,this)"  style="width: 28%;border-right: 0;cursor:pointer;">
				<div class="stockbox stockbox1">
					<p class="money"><strong id="complanyPrice">￥0 </strong></p>
					<p class="money-lb">公司库存总资产</p>
				</div>
			</div>
			<div class="f-l pl-20 pt-15 pb-15 bk-gray stockboxCur bgstyle" style="width: 28%;border-right: 0;cursor:pointer;" onclick="stockComStatistics(2,this)">
				<div class="stockbox stockbox5">
					<p class="money"><strong id="empPrice">￥0</strong></p>
					<p class="money-lb">工程师库存总资产</p>
				</div>
			</div>
			<div class="f-l pl-20 pt-15 pb-15 bk-gray  bgstyle" style="width: 44%;cursor:pointer;" onclick="stockComStatistics(3,this)">
				<div class="stockbox stockbox6">
					<p class="money"><strong id="oldPrice">￥0</strong></p>
					<div class="cl">
						<p class="money-lb f-l">旧件库存总资产</p>
						<p class="f-l c-666">（注：旧件状态为“已入库”的旧件才会被纳入统计）</p>
					</div>
				</div>
			</div>
		</div>

	<%--<div class="mt-10 bk-gray pd-15">
			<div class="stockbox stockbox1">
				<p class="money"><strong>￥${stockMap.totalAsset }</strong></p>
				<p class="money-lb">库存总资产</p>
			</div>
		</div>--%>
		<div class="tabCon" >
		<form action=""  id="cx">
			<input type="hidden" name="page" id="pageNo" value="1">
			<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
			<div class="cl mt-15">
				<input type="hidden" name="whoStatistics" id="whoStatistics" value="2">
				<label class="f-l">备件条码：</label>
				<input type="text" class="input-text f-l w-140" id="fittingCode" value="${fittingCode }"  name="fittingCode"/>
				<label class="f-l w-90 text-r">备件名称：</label>
				<input type="text" class="input-text f-l w-140" id="fittingName" value="${fittingName }"  name="fittingName"/>
				<p class="f-r">
					<a href="javascript:search();" class="sfbtn sfbtn-opt" ><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
					<sfTags:pagePermission authFlag="STATISTIC_STOCKSTAT_STOCKSTORE_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</p>
			</div>
		</form>
		<div class="mt-10 text-c tableWrap1">
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					<!-- pagination -->
			</div>
			</div>
	
	</div>
</div></div></div>

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
    var whoStatistic="1";
    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';	
	$(function(){
		 $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
				if(result=="showPopup"){
					$(".vipPromptBox").popup();
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
				}
			});
        $.post("${ctx}/statistic/getStocksCounts",function(result){
			$("#complanyPrice").text("￥"+result.complanyPrice.toFixed("2"));
			$("#empPrice").text("￥"+result.empPrice.toFixed("2"));
			$("#oldPrice").text("￥"+result.oldPrice.toFixed("2"));
        });
        $(".lastheader").hide();
        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        initSfGrid();
        
    });
	
	function initSfGrid(){
		var tableHeight_=$(window).height()-300;
		$("#table-waitdispatch").sfGrid({
			url : '${ctx}/statistic/fitList',
			sfHeader: defaultHeader,
			sfSortColumns: sortHeader,
			postData:$("#cx").serialize(),
			rownumbers:true,
			shrinkToFit:true,
			height:tableHeight_,
			gridComplete:function(){
				_order_comm.gridNum();
				if($("#table-waitdispatch").find("tr").length>1){
					$(".ui-jqgrid-hdiv").css("overflow","hidden");
				}else{
					$(".ui-jqgrid-hdiv").css("overflow","auto");
				}
			}
		});
	}
	
	window.onresize = function(){
		var tableHeight_=$(window).height()-300
		$("#table-waitdispatch").setGridHeight(tableHeight_);
	}

	function exports(){
		var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
					 location.href="${ctx}/statistic/exportsStock?"+$("#cx").serialize()+"&formPath=/a/statistic/stockStat";
				 }
		
			});
		}else{
			location.href="${ctx}/statistic/exportsStock?"+$("#cx").serialize()+"&formPath=/a/statistic/stockStat";
		}
	
	};
	
	function search(){
		var pageSize = $("#pageSize").val();
		if($.trim(pageSize)=='' || pageSize==null){
			$("#pageSize").val(20);
		}
	    $("#table-waitdispatch").sfGridSearch({
	        postData: $("#cx").serializeJson()
	    });
	}
	
	function stockComStatistics(idx,eva){
		$("#whoStatistics").val(idx);
	    window.location.href="${ctx}/statistic/stockStat?map="+$("#cx").serialize();
	}
	
	function reset(){
		$("#fittingCode").val('');
		$("#fittingName").val('');
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

	function isBlank(val) {
		if(val==null || $.trim(val)=='' || val == undefined) {
			return true;
		}
		return false;
	} 
	
	function fmtifyuanpei(rowData){
		if(rowData.yrpz_flag=='1'){
			return "是";
		}
		if(rowData.yrpz_flag=='2'){
			return "否";
		}
		return "";
	}


</script> 
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<title>维修单记录</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<style type="text/css">
.webuploader-pick{
	width:44px;
	height:20px;
	line-height:20px;
	padding:0;
	overflow:visible;
}

.webuploader-pick img{
	width:100%;
	height:100%;
	position:absolute;
	left:0;
	top:0;
}
	.btn-import .webuploader-pick{
		background: none;
		color: #fff;
	}
	lable{ display: inline-block}
</style>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="JIESUANDANGAN_SITE_JIESUANDANRECORD_TAB" html='<a class="btn-tabBar current" href="${ctx }/order/orderSettlement/getODSMTInWCheckForFacTab">家电协会</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="ptype" value="${ptype}"/>
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">结算单状态：</th>
							<td>
								<select class="select w-140" name="recordStatus">
									<option value="">请选择</option>
									<option value="0" ${reviewStatus eq 0 ?'selected':''}>待审核</option>
									<option value="1" ${reviewStatus eq 1 ?'selected':''}>审核不通过</option>
									<option value="2" ${reviewStatus eq 2 ?'selected':''}>已审核</option>
									<option value="3" ${reviewStatus eq 3 ?'selected':''}>已付款</option>
								</select>
							</td>
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
								<input type="text" class="input-text" name= "serviceType"/>
							</td>
							<th style="width: 76px;" class="text-r">
								报修时间：
							</th>
							<td colspan="5">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">

								<lable style="width: 76px;" class="text-r">完工时间：</lable>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})"  id="endTimeMin" name="endTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="endTimeMax" name="endTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="JIESUANDANGAN_SITE_JIESUANDANRECORD_RESUBMOT_BTN" html='<a href="javascript:reSubmit();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>重新录入</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>
					<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HUNDRANDORDER_HEADSET_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<div class="cl pt-10">
					<div class="f-r">
						<div class="pagination"></div>
					</div>
				</div>
			</div>
</div>

<!-- 表头设置 -->
<div class="">
	<div>
		<h2></h2>
	</div>
</div>
</div>
</div>
<script type="text/javascript">
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
$(function(){
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
	$('#setHeadersBtn').click(function(){
		$('.addHeaders').tableHeaderSetting({
			id:id,
			defaultId: defaultId,
			sfHeader: defaultHeader,
			sfSortColumns: sortHeader,
			tableHeaderSaveUrl:'${ctx}/operate/site/saveTableHeader'
		}).popup();
	});
});

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/orderSettlement/getODSMTInWCheckForFacList',
		sfHeader: defaultHeader,
		sfSortColumns:sortHeader,
		rownumbers:true,
        postData: $("#searchForm").serializeJson(),
		gridComplete:function(){
			_order_comm.gridNum();
			if($("#table-waitdispatch").find("tr").length>1){
				$(".ui-jqgrid-hdiv").css("overflow","hidden");
			}else{
				$(".ui-jqgrid-hdiv").css("overflow","auto");
			}
		},loadComplete:function(){
			$(".page-sel").find("select").append("<option value='200'>200</option>");
		}
	});
}


function fmtOrderNo(rowData){
	return '<a href="javascript:showDetail(\''+rowData.number+'\');" class="c-0383dc">'+rowData.number+'</a>';
}

/*重新提交*/
function reSubmit(){
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length < 1) {
        layer.msg("请选择数据！");
        return;
    }else if(idArr.length>1){
        layer.msg("一次只能选择一条数据！");
        return;
	}
    var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr);
    if(rowData.review_status!='待审核' && rowData.review_status!='审核不通过'){
		layer.msg("该工单状态不可重新录入！");
	}else{
        layer.open({
            type: 2,
            content: '${ctx}/order/orderSettlement/reRepairSubmitPage?number=' + rowData.number,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
	}

}

function reloadGride() {
    $("#table-waitdispatch").trigger("reloadGrid");
}

function recordStatus(rowData){
    if(rowData.review_status=='0'){
        return "待审核";
	}else if(rowData.review_status=='1'){
        return "审核不通过";
	}else if(rowData.review_status=='2'){
		return "已审核";
	}else if(rowData.review_status=='3'){
        return "已支付";
	}else{
	    return "---";
	}
}

function showDetail(number){
	layer.open({
		type : 2,
		content:'${ctx}/order/orderSettlement/getSettlementOrderDetail?number='+number,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1 
	});
}

function search(){
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}


function isBlank(val){
	if(val==null || $.trim(val)==""){
		return true;
	}
	return false;
}

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		$("#table-waitdispatch").sfGridSearch({
	        postData: $("#searchForm").serializeJson()
	    });
	}
}


function exports(){
    var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var nowM = hours * 60 + minutes;
    var start = 7 * 60 + 30;
    var end = 11 * 60 + 30;
    if (nowM >= start && nowM <= end) {
        layer.msg("温馨提醒：系统使用高峰期7:30-11:30,请在其它时间导入、导出！谢谢！");
        return false;
    }

    var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
    var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
    if(idArr>10000){
        $('body').popup({
            level:3,
            title:"导出",
            content:content,
            fnConfirm :function(){
                location.href="${ctx}/order/orderSettlement/export?formPath=/a/order/orderSettlement/getODSMTInWCheckForFacTab&&maps="+$("#searchForm").serialize();
            }
        });
    }else{
        location.href="${ctx}/order/orderSettlement/export?formPath=/a/order/orderSettlement/getODSMTInWCheckForFacTab&&maps="+$("#searchForm").serialize();
    }
}

</script>

</body>
</html>
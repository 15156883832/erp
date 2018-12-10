<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>全部工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>  
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>--%>

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
	<style type="text/css">
		.SelectBG{
			background-color:#ffe6e2;
		}
	</style>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
			<form id="searchForm">
				<input type="hidden" class="input-text" name="comp" id="ordercomp" value="${comp }"/>
				<input type="hidden" class="input-text" name="type" id="ordercomp" value="${type}"/>
			</form>
		<div class="page-orderWait">
			<div class="tabBar cl mb-10">
				<a class="btn-tabBar current" href="javascript:;">ERP工单</a>
			</div>
			<div class="mb-10">
				<table id="table_order1" class="table"></table>
			</div>
			
			<div class="tabBar cl mb-10">
				<a class="btn-tabBar current" href="javascript:;">400工单</a>
			</div>
			<div class="mb-10">
				<table id="table_order400" class="table"></table>
			</div>
		</div>
	</div></div>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
var tableWidth ;
$(function(){
	tableWidth = $('.sfpagebg').width()-30 ;
 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
	initSfGrid400();
	
	$(window).resize(function(){   
		var tableWidth = $('.sfpagebg').width()-30 ;
		
     	$("#table_order1").setGridWidth(tableWidth);
     	$("#table_order400").setGridWidth(tableWidth);

    });
	
});

function initSfGrid(){
	$("#table_order1").sfGrid({
		url : '${ctx}/order/getorderQuick',
		sfHeader: eval('${headerData.tableHeader}'),
		sfSortColumns:'${headerData.sortHeader}',
		postData:{'comp':'${comp}','type':'${type}'},
		multiselect:false,
		width:tableWidth,
	   	height:200
	});
}

function initSfGrid400(){
	
	$("#table_order400").sfGrid({
		url : '${ctx}/order/getorderQuick400',
		sfHeader: eval('${headerData400.tableHeader}'),
		sfSortColumns:'${headerData400.sortHeader}',
		postData:{'comp':'${comp}','type':'${type}'},
		multiselect:false,
		width:tableWidth,
	   	height:200
	});
}

function manyidu(rowData){
	var serviceAt = rowData.service_attitude; 
	if(serviceAt=="1"){
		return "十分不满意";
	}
	if(serviceAt=="2"){
		return "不满意";
	}
	if(serviceAt=="3"){
		return "一般";
	}
	if(serviceAt=="4"){
		return "满意";
	}
	if(serviceAt=="5"){
		return "十分满意";
	}
	if(serviceAt=='6'){
        return "无效回访 ";
    }
    if(serviceAt=='7'){
        return "回访未成功";
    }
    return "";
}

function search(){
    $("#table_order1").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
    $("#table_order400").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}


//是否交款
 function fmtWhetherCollection(rowData) {
  	if (rowData.status == "3" || rowData.status == "4" ) {//|| rowData.status == "5"
  		if ("0" == rowData.whether_collection || "2" == rowData.whether_collection) {
  			if('${fns:checkBtnPermission("ORDERMGM_ALLORDER_ALLORDER_RETURNMONEYCONFIRM_BTN")}' === 'true'){
  				return "<a style='color:blue;' onclick='confirmCollection(\"" + rowData.id + "\",\"" + rowData.auxiliary_cost + "\",\"" + rowData.serve_cost + "\",\"" + rowData.warranty_cost + "\",\"" + rowData.callback_cost + "\")'>确认</a>";
  			}else{
   				return "否";
   			}
 			} else if ("1" == rowData.whether_collection) {
 			return "是";
  		} else {
  			return "--";
  		}
  	} else {
  		return "--";
  	}
  }
  

 function fmtRC(rowData) {//交单情况
 	if (rowData.status == "3" || rowData.status == "4" || rowData.status == "5" || rowData.status == "8" ) {
 		if ("0" == rowData.return_card || "2" == rowData.return_card) {
 			if('${fns:checkBtnPermission("ORDERMGM_ALLORDER_ALLORDER_RETURNCARDCONFIRM_BTN")}' === 'true'){
 				return "<a style='color:blue;' onclick='confirmCard(\"" + rowData.id + "\")'>确认</a>";
 			}else{
 				return "否";
 			}
 		} else if ("1" == rowData.return_card) {
 			return "是";
 		} else {
 			return "--";
 		}
 	} else {
 		return "--";
 	}
 }
  
function showDetail400(id,migration){
	$("#table_order400").jqGrid('resetSelection');
	 $("#table_order400").jqGrid('setSelection',id);
	var url = '${ctx}/order/ChangeSelfOrder/order400Form?id='+id;
    if(migration=='2017'){
    	url = '${ctx}/order/ChangeSelfOrder/oldOrder400Form?id='+id;
		layer.open({
			type : 2,
			content:url,
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			fadeIn:0,
			anim:-1
		});
	}else{
        layer.open({
            type : 2,
            content:url,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
	}
}

function showDetail(id,migration){
	$("#table_order1").jqGrid('resetSelection');
	 $("#table_order1").jqGrid('setSelection',id);
    if(migration=='2017'){
        var detailform=layer.open({
            type : 2,
            content:'${ctx}/order2017/orderDispatch/order2017form?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
	}else{
        batchFormIndex = layer.open({
            type : 2,
            content:'${ctx}/order/orderDispatch/Wholeform?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
	}
}

function marks(rowData){
    var origin = marks2(rowData);
    if(rowData.flag) {
        var flag = "<span class='oState state-refuse' title='标记工单：" + rowData.flag_desc + "'></span>";
        return flag + origin;
	} else {
        return origin;
	}
}

function marks2(rowData){
	if(rowData.is_convert==0){
		return '<span>'+rowData.status+'</span>';
	}else if(rowData.is_convert==1){
		return '<span><i class="oState state-yzzj"></i>'+rowData.status+'</span>';
	}else if(rowData.is_convert==2){
		return '<span>已删除</span>';
	}
}


function fmtOrderNo(rowData){
	var html = '';
		html += '<a href="javascript:showDetail(\''+rowData.id+'\',\''+rowData.migration+'\');" class="c-0383dc">'+rowData.number+'</a>';
	return html;
}

function gdbh(rowData){
	return '<a href="javascript:showDetail400(\''+rowData.id+'\',\''+rowData.migration+'\');" class="c-0383dc">'+rowData.number+'</a>';
}

function employes(rowData){
	var emps="";
	if($.trim(rowData.employe1)!="" && $.trim(rowData.employe1)!=null){
		emps=rowData.employe1;
	}
	if($.trim(rowData.employe2)!="" && $.trim(rowData.employe2)!=null){
		if(emps==""){
			emps=rowData.employe2;
		}else{
			emps=emps+","+rowData.employe2;
		}
	}
	if($.trim(rowData.employe3)!="" && $.trim(rowData.employe3)!=null){
		if(emps==""){
			emps=rowData.employe3;
		}else{
			emps=emps+","+rowData.employe3;
		}
	}
	return emps;
}

function servieType(rowData){
	if(rowData.service_type != "" && rowData.service_type != null){
		return '<span>'+rowData.service_type+'</span>';
	}else{
		if(rowData.c_service_type != "null" && rowData.c_service_type != "" && rowData.c_service_type != null){
			return '<span>'+rowData.c_service_type+'</span>';
		}else{
			return '<span></span>';
		}
		
	}
}

function closeBatchForm() {
	layer.close(batchFormIndex);
}

function numerCheck(){
	$.post("${ctx}/order/getOrderTabCount",{tab:"wxz"},function(result){
		$("#tab_c1").text(result.c1);
		$("#tab_c2").text(result.c2);
		$("#tab_c3").text(result.c3);
		$("#tab_c4").text(result.c4);
	});
}

function reAccount(rowData){
	var html = '';
	/* var autoFlag = '${fns:checkBtnPermission("ORDERMGM_ALLORDER_ALLORDER_CONFIRMACCOUNT_BTN")}';
	if( autoFlag == true){ */
	if(rowData.record_account=='1'){
		html='是';
	}else{
		html='否';
	}
	//}
	return html;
}

function fmtOrderAppliance(rowData){
	if(rowData.appliance_brand!=null&&rowData.appliance_category!=null){
		return rowData.appliance_brand+rowData.appliance_category;
	}else if(rowData.appliance_brand==null){
		return rowData.appliance_category;
	}else{
		return rowData.appliance_brand;
	}
}


function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}


function fmtTotalMoney(rowData){
    return rowData.auxiliary_cost + rowData.serve_cost + rowData.warranty_cost;
}

function fmtWxReason(rowData){
	var type = rowData.disable_type;
	if(type=='0'){
		return "";
	}
	if(type=='1'){
		return "重复";		
	}
	if(type=='2'){
		return "机器已好";
	}
	if(type=='3'){
		return "费用高不修";
	}
	if(type=='4'){
		return "用户没时间 ";
	}
	if(type=='5'){
		return "其他原因";
	}
	return "";
}

</script>
	
</body>
</html>
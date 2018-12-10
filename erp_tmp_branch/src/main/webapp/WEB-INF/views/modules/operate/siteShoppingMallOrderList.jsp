<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>

   <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar current" href="${ctx}/statistic/getShoppingMallOrder">商城订单</a>
			<p class="f-r btnWrap">
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			
			
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
								<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
					<tr>
							<th  style="width: 76px;" class="text-r">订单状态：</th>
							<td>
							<span class="select-box">
									<select class="select" name="status" >
		                            <option value="">请选择</option>
		                            <option value="2" ${map.status eq 2?'selected':''}>待发货</option>
		                            <option value="3" ${map.status eq 3?'selected':''}>已发货</option>
		                            <option value="4" ${map.status eq 4?'selected':''}>已签收</option>
		                        </select>
							</span>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
                              <input type="text" class="input-text" onkeydown="enterEvent(event)" name= "contact"/>
							</td>
							<th style="width: 90px;" class="text-r ">
								 <select name="quikSelectName" class="select">
		                            <option value="">请选择</option>
		                            <option value="0" >客户姓名</option>
		                            <option value="1" >详细地址</option>
		                            <option value="2" >商品名称</option>
		                            <option value="3" >订单编号</option>
		                            <option value="4" >推荐服务商</option>
		                            <option value="5" >推荐工程师</option>
		                        </select>
							</th>
							<td>
							<input type="text" name="quikSelectValue" class="input-text" >
							</td>
							
							<th  style="width: 76px;" class="text-r">销售时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'placingOrderTimeMax\')||\'%y-%M-%d\'}'})" id="placingOrderTimeMin" name="placingOrderTimeMin"  value="" class="input-text Wdate w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'placingOrderTimeMin\')}',maxDate:'%y-%M-%d'})" id="placingOrderTimeMax" name="placingOrderTimeMax"  value="" class="input-text Wdate w-140" style="width:140px">
							</td>
							
							</tr>
							</table>
							</div>
							
							
							<div class="pt-10 pb-5 cl">
				<div class="f-l">
			<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="addOrderNew();" id="btnAddnew"><i class="sficon sficon-add"></i>新建工单</a>

				</div>
											<div class="f-r">
					<!-- <a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a> -->
				</div>		
			</div>
				<div>
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
					<div class="cl pt-10">
							<div class="f-l">

						</div>
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					<!-- pagination -->
				</div>
			</form>

	</div>
</div>

</div>
</div>


<!--_footer 作为公共模版分离出去-->


<!--_footer 作为公共模版分离出去-->

<script type="text/javascript">

var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();

});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/statistic/getShoppingMallOrderList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		multiselect: true,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
}

function fmtStatus(rowData){
	var status = rowData.status;
	if("2" == status){
		return "待发货";
	}else if("3" == status){
		return "已发货";
	}else if("4" == status){
		return "已签收";
	}
}
function fmtIsnewOrder(rowData){
	var status = rowData.is_new_order;
	if("1" == status){
		return "是";
	}else {
		return "否";
	}
}
function fmtGoodName(rowData){
	var detail = rowData.detail;
	var name = "";
	$.each(detail,function(){
		if(isBlank(name)){
			name = this.columns.good_name;
		}else{
			name =name +","+ this.columns.good_name;
		}
	})
	return name;
}

var adpoting = false;
function addOrderNew() {
	 if (adpoting) {
         return;
     }
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length != 1) {
        layer.msg("请选择一条数据！");
    } else {
    	var rowData = $("#table-waitdispatch").jqGrid('getRowData',idArr[0]);
    	if($.trim(rowData.status) !='已签收'){
			layer.msg("非已签收订单不可新建安装单！");    		
    	return
    	}else if($.trim(rowData.is_new_order) =='是'){
    		 layer.msg('该订单已经新建了安装单，不可重复新建！');		
        	return
    	}
    	 $('body').popup({
             level: '3',
             type: 2,  // 提示是否进行某种操作
             content: '您确定要新建安装工单吗？',
             fnConfirm: function () {
                 adpoting = true;
                 $.ajax({
                     type: "POST",
                     url: "${ctx}/statistic/saveOrder",
                     data: {
                         orderId: idArr[0]
                     },
                     success: function (data) {
                         if (data.code ==200) {
                             layer.msg('新建安装单成功!');
                             search();
                         }else if(data.code == 205){
                        	 layer.msg('该订单已经新建了安装单，不可重复新建！');	
                         } else {
                             layer.msg('新建安装单失败!');
                         }

                     },
                     complete: function () {
                         adpoting = false;
                     }
                 });
             }
    	 });
    	}
    }

function jsClearForm() {
	$("#searchForm :input[type='text']").each(function () { 
	$(this).val(""); 
	}); 
	
	$("select").val(""); 
	$(".textbox-value").val("");
	 

}
function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });

}
function isBlank(val) {
    if(val==null || val=='' || val == undefined) {
        return true;
    }
    return false;
}

function exports(){
	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/operate/ordercount/export2?formPath=/a/operate/ordercount&&maps="+$("#searchForm").serialize();
			 }
	
		});
	}else{
		location.href="${ctx}/operate/ordercount/export2?formPath=/a/operate/ordercount&&maps="+$("#searchForm").serialize();
	}

}

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		search();
	}
}


</script>
  </body>
</html>
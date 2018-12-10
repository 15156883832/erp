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
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEAPPLY_TAB" html='<a class="btn-tabBar "  href="${ctx }/fitting/fittingApply/getApplyList">待审核<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEOUTPUT_TAB" html='<a class="btn-tabBar current"  href="${ctx }/fitting/fittingApply/ThelibraryHeader">待出库<sup  id="tab_c2">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_TAB" html='<a class="btn-tabBar" href="${ctx }/fitting/fittingApply/ApplyallHeader">全部申请</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ONROAD_TAB" html='<a class="btn-tabBar" href="${ctx }/fitting/fittingApply/fittingInRoad">备件在途<sup  id="tab_c3">0</sup></a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">备件条码：</th>
							<td>
								<input type="text" class="input-text" name= "fittingCode"/>
							</td>
							<th style="width: 76px;" class="text-r">备件名称：</th>
							<td>
								<input type="text" class="input-text" name = "fittingName"/>
							</td>
							<th style="width: 76px;" class="text-r">保修类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="warrantyType">
										<option value="">请选择</option>
										<option value="1">保内</option>
										<option value="2">保外</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">申请人：</th>
							<td>
								<input type="text" class="input-text" name = "employeName"/>
							</td>
					
							<td colspan="2">
                            	<label class="text-r" style="margin-left: 24px;" >工单编号：</label>
                                <input type="text" class="input-text" name="orderNumber"/>
                            </td>
								</tr>
						<tr>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name="customerMobile" />
							</td>
						    <th style="width: 76px;" class="text-r">备件品牌：</th>
                            <td>
                                <input type="text" class="input-text" name="suitBrand"/>
                            </td>

							<th style="width: 76px;" class="text-r">适用品类：</th>
							<td>
								<span class="select-box">
									<select class="select" name="suitCategory">
										<option value="">请选择</option>
										<c:forEach var="category" items="${listR}">
											<option value="${category.columns.name}">${category.columns.name}</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">家电品牌：</th>
							<td>
								<span class=" w-140">
									<select class="select easyui-combobox" id="applianceBrand" style="width:100%;height:25px">
										<c:forEach var="brand" items="${brandList}">
											<option value="${brand.key}">${brand.key}</option>
										</c:forEach>
									</select>
									<input type="hidden" name="applianceBrand"/>
								</span>
							</td>
							<td colspan="2">
                               	<label class="text-r" >备件计划状态：</label>
                                  <span class="select-box" > 
                                  		<select class="select" name="fapStatus">
											<option value="">请选择</option>
											<option value="1">已提交</option>
											<option value="2">已入库</option>
									</select>
								</span>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
								<span class=" w-140">
									<select class="select easyui-combobox" id="applianceCategory" style="width:100%;height:25px">
										<c:forEach var="category" items="${applianceCategory}">
											<option value="${category.columns.name}">${category.columns.name}</option>
										</c:forEach>
									</select>
									<input type="hidden" name="applianceCategory"/>
								</span>
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_PLOUTSTOCK_BTN" html='<a href="javascript:batchOutStock();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-plck"></i>批量出库</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEOUTPUT_SETHEADER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
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

	<div class="popupBox drtsBox">
		<h2 class="popupHead">
			提示
			<a href="javascript:closeDrtsBox();" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain">
				<div class="w-520" id="errorMessage">
				</div>
			</div>
			<div class="text-c mt-20 mb-15">
				<a href="javascript:closeDrtsBox();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
			</div>
		</div>
	</div>
	

<!-- 手动入库 -->
<div class="popupBox bjsdrkbox bjjhbox" style="width: 900px;">
	<h2 class="popupHead">
		备件出库
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<table class="table table-border table-bordered table-bg table-sdrk">
					<thead>
					<tr>
						<th class="w-130">备件条码</th>
						<th class="w-120">备件名称</th>
						<th class="w-100">备件型号</th>
						<th class="w-80">适用品类</th>
						<th class="w-80">审核数量</th>
						<th class="w-160">审核备注</th>
						<th class="w-100">申请人</th>
						<th class="w-80">操作</th>
					</tr>
					</thead>
					<tbody id="sdrk_tbd"></tbody>
				</table>
				
			</div>
		</div>
		<div class="text-c btnWrap">
		<span class="chukudaying hide">
			<a href="javascript:batchOutStockingq();" class="sfbtn sfbtn-opt3 w-100">批量出库</a>
			 <a href="javascript:prinTurnBackss();" class="sfbtn sfbtn-opt w-100 ">出库并打印</a> 
		</span>
		<span class="querenchuku hide">
			<a href="javascript:beijianchuku();" class="sfbtn sfbtn-opt3 w-70 ">确认出库</a>
			 <a href="javascript:prinTurnBack();" class="sfbtn sfbtn-opt w-100 ">出库并打印</a> 
		</span>
			
			<a href="javascript:closeDrtsBox();" class="sfbtn sfbtn-opt w-70">关闭</a>
		</div>
	</div>
</div>
	<form action="${ctx}/printFitting/printappStocklist" id="printForm" target="_blank" method="post">
	<input type="hidden" name="fittingappId" value="" id="fittingappId"/>
	</form>
<script type="text/javascript">
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID

$(function () {
    $.post("${ctx}/fitting/twoStatusCount", function (result) {
        $("#tab_c1").text(result[0].sh);
        $("#tab_c2").text(result[1].ck);
        $("#tab_c3").text(result[2].zt);
    });

    $.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
    $.tabfold("#moresearch", ".moreCondition", 1, "click");
    $('#setHeadersBtn').click(function () {
        $('.addHeaders').tableHeaderSetting({
            id: id,
            defaultId: defaultId,
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            tableHeaderSaveUrl: '${ctx}/operate/site/saveTableHeader'
        }).popup();
    });

    initSfGrid();
    $("#applianceCategory").combobox('clear');
    $("#applianceBrand").combobox('clear');
});

function prinTurnBackss(){
	var id = [] ;
	 $(".fittingapplyId").each(function(){
		 id.push($(this).val());
	 	  });
	if(id.length <1){
		  layer.msg("请选择数据！");
	}
   if (batchOutStocking) {
       return;
   }
   batchOutStocking = true;
   $.ajax({
       type: "POST",
       url: "${ctx}/fitting/fittingApply/batchOutStock",
       data: {
           id: id
       },
       success: function (result) {
           if (result.code === "200") {
        	   $("#fittingappId").val(result.msg);  
               layer.msg("批量出库成功！");
               prinfitting();
               closeDrtsBox();
           }else if(result.code === '203'){
        	   $("#fittingappId").val(result.msg);  
           		closeDrtsBox();
               $("#errorMessage").html(result.errMsg);
               prinfitting();
               $(".drtsBox").popup();
			} else {
               layer.msg("批量出库失败！");
           }
           search();
       },
       complete: function () {
           batchOutStocking = false;
       }
   });
  
}

function prinfitting(){
	var fi = $("#fittingappId").val();
	if(isBlank(fi)){
		return
	}
	 $("#printForm").submit();
}
function prinTurnBack(){
	 var id=$(".fittingapplyId").val();
	 if(isBlank(id)){
		 layer.msg("数据有误！");
		 return
	 }
      $("#fittingappId").val(id);       	
      beijianchuku();
   	$("#printForm").submit();
}

function isBlank(val) {
    if (val == null || val == '' || val == undefined) {
        return true;
    }
    return false;
}


$(".resetSearchBtn").on("click",function(){
    $('#applianceCategory').combobox('setValues',"");
    $('#applianceBrand').combobox('setValues',"");
});

function initSfGrid() {
    $("#table-waitdispatch").sfGrid({
        multiselect: true,
        url: '${ctx}/fitting/fittingApply/Thelibrary',
        sfHeader: defaultHeader,
        sfSortColumns: sortHeader,
        rownumbers : true,
		gridComplete : function() {
			_order_comm.gridNum();
		}
    });
}


function fmtOper(rowData){
	var html = '';
	var fitName = rowData.fitting_name;
	if('${fns:checkBtnPermission("FITTINGMGM_FITAPPLY_WAITEOUTPUT_OUTPUT")}' === 'true'){
        if (fitName && fitName.indexOf("'") !== -1) {
            fitName = fitName.replace(/'/g, '');
        }
		html = '<a href="javascript:Thelibrary(\''+rowData.id+'\',\''+fitName+'\',\''+rowData.fitting_version+'\',\''+rowData.fitting_audit_num+'\',\''+rowData.fitting_code+'\',\''+rowData.warning+'\',\''+rowData.audit_marks+'\',\''+rowData.old_fitting_flag+'\',\''+rowData.suit_category+'\',\''+rowData.employe_name+'\');"  class="oState state-qrck c-0383dc">出库</a>';
		//html += '<a href="javascript:RejectFitting(\''+rowData.id+'\',\''+fitName+'\',\''+rowData.fitting_version+'\',\''+rowData.old_fitting_flag+'\');"  class="ml-10 c-0383dc"><i class="sficon sficon-bohui"></i>驳回</a>';
	}
	if('${fns:checkBtnPermission("FITTINGMGM_WAITOUTPUT_FITAPPLY_REJECT_BTN")}' === 'true'){
        if (fitName && fitName.indexOf("'") !== -1) {
            fitName = fitName.replace(/'/g, '');
        }
		html += '<a href="javascript:RejectFitting(\''+rowData.id+'\',\''+fitName+'\',\''+rowData.fitting_version+'\',\''+rowData.fitting_audit_num+'\');"  class="ml-10 c-0383dc"><i class="sficon sficon-bohui"></i>驳回</a>';
	}	
	return html;
}
//出库
var outStocking = false;

function beijianchuku(){
	 if (outStocking) {
         return;
     }
	 var id=$(".fittingapplyId").val();
	 if(isBlank(id)){
		 layer.msg("数据有误！");
	 }
     outStocking = true;
     $.ajax({
         type: "POST",
         url: "${ctx}/fitting/fittingApply/thelibraryApply",
         data: {
             id: id
         },
         success: function (result) {
        	 if (result.code == "500") {
                 layer.msg("该备件已经出库，请刷新页面！");
             }else if (result.code == "401") {
                 layer.msg("审核数量要求大于0！");
             } else if (result.code == "402") {
                 layer.msg("审核数量要大于审核通过待出库数量！");
             } else if (result.code == "200") {
                 layer.msg("出库成功！");
                 search();
                 closeDrtsBox();
             } else if (result.code === '203') {
                 $("#errorMessage").html(result.errMsg);
                 closeDrtsBox();
                 $(".drtsBox").popup();
             } else {
                 layer.msg("出库失败，请检查！");
                 return false;
             }
         },
         complete: function () {
             outStocking = false;
         }
     });
}

function Thelibrary(id, name, version, auditNum, fitting_code,warning,marks,old,suit_category,employe_name) {
    if (parseFloat(auditNum) > parseFloat(warning)) {
        layer.msg("库存数量不足");
    } else {
    	 $("#sdrk_tbd").empty();
    
    	 if(suit_category == 'null' || isBlank(suit_category) ){
    		 suit_category ="";
    	 }
    	var html ="";
    	html +='<tr>';
    	html +='<td class="text-c w-130"><input type="hidden" value="'+id+'" class="fittingapplyId">'+fitting_code+'</td>';
    	html +='<td class="text-c w-120">'+name+'</td>';
    	html +='<td class="text-c w-100">'+version+'</td>';
    	html +='<td class="text-c w-80">'+suit_category+'</td>';
    	html +='<td class="text-c w-100">'+auditNum+'</td>';
    	html +='<td class="text-c w-160">'+marks+'</td>';
    	html +='<td class="text-c w-100">'+employe_name+'</td>';
    	html +='<td class="text-c w-80">--</td>';
    	html +='</tr>';
    	//<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>
    	  $("#sdrk_tbd").append(html);
    	  $(".querenchuku").removeClass("hide");
    	  $(".chukudaying").addClass("hide");
    	$(".bjjhbox").popup();
    }
}

function deleteTR(z){
    $(z).parent('td').parent('tr').remove();
    var id = [] ;
	 $(".fittingapplyId").each(function(){
		 id.push($(this).val());
	 	  });
	if(id.length <1){
		  layer.msg("请选择数据！");
		  closeDrtsBox();
	}
}


//驳回
function RejectFitting(id, name, version, auditNum) {
    var content = "确认" + name + "(" + version + ")*" + auditNum + "驳回？";
    $('body').popup({
        level: 3,
        title: "驳回审核通过",
        content: content,
        fnConfirm: function () {
            if (outStocking) {
                return;
            }
            outStocking = true;
            $.ajax({
                type: "POST",
                url: "${ctx}/fitting/fittingApply/RejectFittingApply",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.code == "200") {
                        layer.msg("驳回成功！");
                        search();
                    } else {
                        layer.msg("驳回失败，请检查！");
                    }
                },
                complete: function () {
                    outStocking = false;
                }
            });
        }
    });
}

function fmtStatus(rowData) {
    if (rowData.warranty_type == 1) {
        return "<span>保内</span>";
    } else if (rowData.warranty_type == 2) {
        return "<span>保外</span>";
    } else {
        return "<span>---</span>";
    }
    return "<span>---</span>";
}

function search() {
    var valCategory = $('#applianceCategory').combobox('getValues');
    $("input[name='applianceCategory']").val(valCategory);
    var valBrand = $('#applianceBrand').combobox('getValues');
    $("input[name='applianceBrand']").val(valBrand);
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

var batchOutStocking = false;

function batchOutStockingq(){
	var id = [] ;
	 $(".fittingapplyId").each(function(){
		 id.push($(this).val());
	 	  });
	if(id.length <1){
		  layer.msg("请选择数据！");
	}
    if (batchOutStocking) {
        return;
    }
    batchOutStocking = true;
    $.ajax({
        type: "POST",
        url: "${ctx}/fitting/fittingApply/batchOutStock",
        data: {
            id: id
        },
        success: function (result) {
            if (result.code === "200") {
                layer.msg("批量出库成功！");
            }else if(result.code === '203'){
            	closeDrtsBox();
                console.log(result);
                $("#errorMessage").html(result.errMsg);
                $(".drtsBox").popup();
			} else {
                layer.msg("批量出库失败！");
            }
            search();
        },
        complete: function () {
            batchOutStocking = false;
        }
    });
}

function batchOutStock() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length < 1) {
        layer.msg("请选择数据！");
    } else {
    	
   	 $("#sdrk_tbd").empty();
 	var html ="";
 	for(var i = 0;i<idArr.length;i++){
 		var rowData = $('#table-waitdispatch').jqGrid('getRowData',idArr[i]);
	 	html +='<tr>';
	 	html +='<td class="text-c w-130"><input type="hidden" value="'+idArr[i]+'" class="fittingapplyId">'+rowData.fitting_code+'</td>';
	 	html +='<td class="text-c w-120">'+rowData.fitting_name+'</td>';
	 	html +='<td class="text-c w-100">'+rowData.fitting_version+'</td>';
	 	html +='<td class="text-c w-80">'+rowData.suit_category+'</td>';
	 	html +='<td class="text-c w-100">'+rowData.fitting_audit_num+'</td>';
	 	html +='<td class="text-c w-160">'+rowData.audit_marks+'</td>';
	 	html +='<td class="text-c w-100">'+rowData.employe_name+'</td>';
	 	html +='<td class="text-c w-80"><a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>';
	 	html +='</tr>';
 	}
 	 $("#sdrk_tbd").append(html);
 	  $(".chukudaying").removeClass("hide");
	  $(".querenchuku").addClass("hide");
 	$(".bjjhbox").popup();
    }
}

function closeDrtsBox(){
    search();
    $.closeAllDiv();
}

function planStatus(rowData){
	if(rowData.fapStatus=='0'){
		return "待提交";
	}
	if(rowData.fapStatus=='1'){
		return "已提交";
	}
	if(rowData.fapStatus=='2'){
		return "已入库";
	}
	return "";
}

</script>
	
</body>
</html>
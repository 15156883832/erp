<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>全部工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEAPPLY_TAB" html='<a class="btn-tabBar "  href="${ctx }/fitting/fittingApply/getApplyList">待审核<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEOUTPUT_TAB" html='<a class="btn-tabBar"  href="${ctx }/fitting/fittingApply/ThelibraryHeader">待出库<sup  id="tab_c2">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_TAB" html='<a class="btn-tabBar current" href="${ctx }/fitting/fittingApply/ApplyallHeader">全部申请</a>'></sfTags:pagePermission>
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
							<th style="width: 76px;" class="text-r">申请状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="status">
										<option value="">请选择</option>
										<option value="0">待审核</option>
										<option value="1">缺件中</option>
										<option value="2">待出库</option>
										<option value="4">已完成</option>
										<option value="5">已取消</option>
										<option value="6">审核未通过</option>

									</select>
								</span>
							</td>
						</tr>
						<tr>
							
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name="orderNumber" />
							</td>
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
							<td colspan="2">
								<label class="text-r" style="margin-left: -12px;" >备件计划状态：</label>
								<span class="select-box" >
                               		<select class="select" name="fapStatus">
										<option value="">请选择</option>
										<option value="1">备件在途</option>
										<option value="2">已入库</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">申请时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-140">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="" class="input-text Wdate w-140">
							</td>

						</tr>
					</table>
				</div>
				<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_ENGINEERAPPLY_BTN" html='<a href="javascript:addbjsq();" class="sfbtn sfbtn-opt f-l" id="btn-gcssq"><i class="sficon sficon-gcsapplication"></i>工程师备件领取登记</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_PLOUTSTOCK_BTN" html='<a href="javascript:batchOutStock();" class="sfbtn sfbtn-opt2 f-l"><i class="sficon sficon-plck"></i>批量出库</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_SETHEADER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
								
			</div>
			</form>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-l">
						<span class="c-f55025">注：</span>
							<span class="oState state-quejian1 mr-10">缺件中</span>
							<span class="oState state-quejian2 mr-10">缺件在途</span>
							<span class="oState state-quejian mr-10">缺件已到</span>
					</div>
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					<!-- pagination -->
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
	
<!-- 添加申请 -->
<div class="popupBox addbjsq">
	<h2 class="popupHead">
		添加工程师备件领取登记
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
	<form action="" id="fittingForm">
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="f-l w-100"><em class="mark">*</em>工  程  师：</label>
					<input type="hidden" id="employeName" name="employeName"/>
					<select class="select f-l w-140" name="employeId" id="employeId" datatype="*" nullmsg ="请选择工程师">
						<option value="">请选择</option>
						<c:forEach items="${emps}" var="emp">
							<option value="${emp.columns.id}">${emp.columns.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100"><em class="mark">*</em>备件条码：</label>
					<span class="w-380 f-l">
						<select class="select w-380" name="fittingCode" id="fittingCode" datatype="*" nullmsg="请选择备件条码" >
						</select>
					</span>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100"><em class="mark">*</em>备件名称：</label>
					<input type="hidden" name="fittingName" id="fitName" value=""/>
					<span class="w-380 f-l">
						<select class="select w-380"  id="fittingName" datatype="*" nullmsg="请选择备件名称" >
						</select>
					</span>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">备件型号：</label>
					<input type="hidden" id="fittingId" name="fittingId" value="${fit.id}"/>
					<input type="text" class="input-text w-140 f-l readonly" name="fittingVersion" id="fittingVersion" readonly="readonly" value="${fit.version}"/>
					<label class="f-l w-100">备件类型：</label>
					<c:if test="${fit.type eq '1'}">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="fittingType" value="配件"/>
					</c:if>
					<c:if test="${fit.type eq '2'}">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="fittingType" value="耗材"/>
					</c:if>
					<c:if test="${fit.type ne '1' && fit.type ne '2'}">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="fittingType" value=""/>
					</c:if>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">库存数量：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" readonly="readonly" name="fittingWarning" value="${fit.warning}"/>
						<span class="unit">件</span>
					</div>

					<label class="f-l w-100"><em class="mark">*</em>申请数量：</label>
					<div class="priceWrap w-140 f-l ">
						<input type="text" class="input-text" name="fittingApplyNum" id="fittingApplyNum" datatype="*" nullmsg="请输入申请数量"/>
						<span class="unit">件</span>
					</div>
				</div>

				<div class="cl mb-10">
					<label class="f-l w-100">工单编号：</label>
					<input type="hidden" name="orderId"/>
					<span class="w-140 f-l">
					<select class="select f-l w-140" name="orderNumber" id="orderNumber">
						<option value="">请选择</option>
						<c:forEach items="${orderList}" var="orders">
							<option value="${orders.columns.number}">${orders.columns.number}</option>
						</c:forEach>
					</select>
					</span>
					<label class="f-l w-100">用户姓名：</label>
					<input type="text" class="input-text w-140 f- readonly" readonly="readonly" name="customerName"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">联系方式：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="customerM" name="customerMobile"/>

					<label class="f-l w-100">家电品类：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="applianceCategory"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">家电型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="applianceModel"/>

					<label class="f-l w-100">保修类型：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="warrantyType"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">备  注：</label>
					<textarea class="input-text w-380 h-50" name="employeFeedback"></textarea>
				</div>
				<div class="mt-25 text-c">
					<a href="javascript:;" id="fittingBut" class="sfbtn sfbtn-opt3 w-110 mr-5 fittingBut" onclick="change(1)">保存，继续添加</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5 fittingBut" onclick="change(2)">保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closed()">取消</a>
				</div>
			</div>
		</form>
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
<script type="text/javascript">
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
var ck = /^\d+(\.\d+)?$/

$(function(){
	$('#btn-gcssq').goHelp('${ctx}/helpindex/indexHelp?a=bjsqsh');
	$.post("${ctx}/fitting/twoStatusCount",function(result){
		$("#tab_c1").text(result[0].sh);
		$("#tab_c2").text(result[1].ck);
		$("#tab_c3").text(result[2].zt);
	});

	$("#fittingName").mouseenter(function(){
        $(this).prev().combobox("showPanel");
        $(".combobox-item").css({"white-space":"nowrap"});
	});

	$('#employeId').select2();
	$('#orderNumber').select2();

	$("#employeId").next(".select2").find(".selection").css("width","140px");
    $("#orderNumber").next(".select2").find(".selection").css("width","140px");
 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");

    $.tabfold("#moresearch",".moreCondition",1,"click");
    $('#setHeadersBtn').click(function(){
		$('.addHeaders').tableHeaderSetting({
			id:id,
			defaultId: defaultId,
			sfHeader: defaultHeader,
			sfSortColumns: sortHeader,
			tableHeaderSaveUrl:'${ctx}/operate/site/saveTableHeader'
		}).popup();
	});
	initSfGrid();
    initializeCodeAndName();
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

function closeDrtsBox(){
    search();
    $.closeAllDiv();
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
                closeDrtsBox();
            }else if(result.code === '203'){
            	closeDrtsBox();
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
var checkf = true;
function batchOutStock() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length < 1) {
        layer.msg("请选择数据！");
    } else {
   	 $("#sdrk_tbd").empty();
 	var html ="";
 	for(var i = 0;i<idArr.length;i++){
 		var rowData = $('#table-waitdispatch').jqGrid('getRowData',idArr[i]);
 		if(rowData.status != "待出库"){
  			checkf = false;
  			break            
  		}
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
 	  if(!checkf){
  		  layer.msg("选择的数据中含有不为待出库！");
  		return 
  	  }
 	 $("#sdrk_tbd").append(html);
 	  $(".chukudaying").removeClass("hide");
	  $(".querenchuku").addClass("hide");
 	$(".bjjhbox").popup();
    }
}

$(".resetSearchBtn").on("click",function(){
    $('#applianceCategory').combobox('setValues',"");
    $('#applianceBrand').combobox('setValues',"");
});

function initializeCodeAndName(){
    $(".addbjsq").find("#fittingCode").select2({
        ajax: {
            type: 'post',
            url: '${ctx}/fitting/stock/getFittingsBySelect',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term 请求参数
                    page: params.page
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                for (var i = 0; i < data.list.length; i++) {
                    var code = data.list[i].columns.code;
                    itemList.push({id: code, text: code});
                }
                return {
                    results: itemList,//itemList
                    pagination: {
                        more: (params.page * 10) < data.total_count
                    }
                };
            },
            cache: false
        },
        placeholder: '请输入搜索',//默认文字提示
        language: "zh-CN",
        tags: false,//允许手动添加
        //allowClear: true,//允许清空
        escapeMarkup: function (markup) {
            return markup;
        }, // 自定义格式化防止xss注入
        minimumInputLength: 3,//最少输入多少个字符后开始查询
        formatResult: function formatRepo(repo) {
            return repo.text;
        }, // 函数用来渲染结果
        formatSelection: function formatRepoSelection(repo) {
            return repo.text;
        } // 函数用于呈现当前的选择
    });
    $(".addbjsq").find("#fittingName").select2({
        ajax: {
            type: 'post',
            url: '${ctx}/fitting/stock/getFittingsNameBySelect',
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term 请求参数
                    page: params.page
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                for (var i = 0; i < data.list.length; i++) {
                    var code = data.list[i].columns.code;
                    var name = data.list[i].columns.name+"【库存："+data.list[i].columns.warning+"】";
                    itemList.push({id: code, text: name});
                }
                return {
                    results: itemList,//itemList
                    pagination: {
                        more: (params.page * 10) < data.total_count
                    }
                };
            },
            cache: false
        },
        placeholder: '请输入搜索',//默认文字提示
        language: "zh-CN",
        tags: false,//允许手动添加
        //allowClear: true,//允许清空
        escapeMarkup: function (markup) {
            return markup;
        }, // 自定义格式化防止xss注入
        minimumInputLength: 1,//最少输入多少个字符后开始查询
        formatResult: function formatRepo(repo) {
            return repo.text;
        }, // 函数用来渲染结果
        formatSelection: function formatRepoSelection(repo) {
            return repo.text;
        } // 函数用于呈现当前的选择
    });
    $("#fittingCode").next(".select2").find(".selection").css("width","380px");
    $("#fittingName").next(".select2").find(".selection").css("width","380px");
}

var fal='1';
$("#fittingName").on("change",function(){
    var code = $(this).select2("val");
    if(fal=="2"){
        return;
    }
    if (!isBlank(code)) {
        $.ajax({
            type: "POST",
            url: "${ctx}/fitting/getfitting",
            data: "code=" + code,
            dataType: "json",
            success: function (data) {
                fal="2";//防止互相影响
                var obj = eval('data');
                if (obj.co == '1') {
                    $("#fittingId").val(obj.record.columns.id);
                    $("#fittingVersion").val(obj.record.columns.version);

                    $("#fittingCode").empty().append('<option value='+obj.record.columns.code+'>'+obj.record.columns.code+'</option>');
                    $("#select2-fittingCode-container").empty().append(obj.record.columns.name);

                    $("#fitName").val($("#fittingName").select2('data')[0].text);

                    var type= obj.record.columns.type;
                    if(type == '1'){
                        $("#fittingType").val("备件");
                    }else if (type=='2'){
                        $("#fittingType").val("耗材");
                    }
                    maxpj = parseFloat(obj.record.columns.warning);
                    $("input[name='fittingWarning']").val(maxpj);
                    if (maxpj < 0.1) {
                        layer.msg('该配件已无库存');
                    }
                } else {
                    layer.msg("该条码配件不存在");
                    $("#fittingId").val('');
                    $("#fittingVersion").val('');
                    $("#fittingName").val('');
                    $("#fittingType").val('');

                }
            },
            complete:function(){
                fal="1";
            }
        });
    } else {
        clear();
        layer.msg("请选择配件名称");

    }
})


$("#fittingCode").on("change",function(){
    var code = $(this).select2("val");
    if(fal=="2"){
        return;
    }
    if (!isBlank(code)) {
        $.ajax({
            type: "POST",
            url: "${ctx}/fitting/getfitting",
            data: "code=" + code,
            dataType: "json",
            success: function (data) {
                fal="2";//防止互相影响
                var obj = eval('data');
                if (obj.co == '1') {
                    $("#fittingId").val(obj.record.columns.id);
                    $("#fittingVersion").val(obj.record.columns.version);

                    $("#fittingName").empty().append('<option value='+obj.record.columns.code+'>'+obj.record.columns.name+'</option>');
                    $("#select2-fittingName-container").empty().append(obj.record.columns.name);

                    var type= obj.record.columns.type;
                    $("#fitName").val($("#fittingName").select2('data')[0].text);
                    if(type == '1'){
                        $("#fittingType").val("备件");
                    }else if (type=='2'){
                        $("#fittingType").val("耗材");
                    }
                    maxpj = parseFloat(obj.record.columns.warning);
                    $("input[name='fittingWarning']").val(maxpj);
                    if (maxpj < 0.1) {
                        layer.msg('该配件已无库存');
                    }
                } else {
                    layer.msg("该条码配件不存在");
                    $("#fittingId").val('');
                    $("#fittingVersion").val('');
                    $("#fittingName").val('');
                    $("#fittingType").val('');

                }
            },
            complete:function(){
                fal="1";
            }
        });
    } else {
        clear();
        layer.msg("请选择配件条码");

    }
});

function clear(){
    fal="2";//防止互相影响
    $("#fittingCode").empty();
    $("#select2-fittingCode-container").empty();
    $("#fittingName").empty();
    $("#select2-fittingName-container").empty();
    $("#fittingVersion").val("");
    $("#fittingType").val("");
    $("input[name='fittingWarning']").val("");
    fal="1";//防止互相影响
}


$("#employeId").on("change",function(){
    if(fal=="2"){
        return;
    }
    $("input[name='customerName']").val("");
    $("#customerM").val("");
    $("input[name='applianceCategory']").val("");
    $("input[name='applianceModel']").val("");
	$("input[name='warrentyType']").val("");
    $("input[name='orderId']").val("");
    var  html='<option value="">请选择</option>';
    $("#orderNumber").empty().append(html);

    var employId=$(this).select2("val");
    var employName=$(this).find("option:selected").text();
    $("#employeName").val(employName);
    if (!isBlank(employId)) {
        $.ajax({
            type: "POST",
            url: "${ctx}/fitting/fittingApply/getOrderByEmp",
            data: {
                employId:employId,
                employName:employName
            },
            dataType: "json",
            success: function (data) {
                var obj = eval('data');
                if(obj!=null){
					var html='';
					html+='<option value="">请选择</option>';
					for(var i=0;i<obj.length;i++){
                        html+=' <option value="'+obj[i].columns.number+'">'+obj[i].columns.number+'</option>';
                    }
                    $("#orderNumber").empty().append(html);
				}
            }
        });
    } else {
        layer.msg("请选择工程师");

    }
})


$("#orderNumber").on("change",function(){
    var number=$(this).select2("val");
    var employeId=$("#employeId").val();
    if (!isBlank(number)) {
        $.ajax({
            type: "POST",
            url: "${ctx}/fitting/fittingApply/getOrderByNumber",
            data: {
                number:number,
                employeId:employeId
			},
            dataType: "json",
            success: function (data) {
                $("input[name='orderId']").val(data.columns.id);
                $("input[name='customerName']").val(data.columns.customer_name);
                $("#customerM").val(data.columns.customer_mobile);
                $("input[name='applianceCategory']").val(data.columns.appliance_category);
                $("input[name='applianceModel']").val(data.columns.appliance_model);
                if (data.columns.warranty_type == "1") {
                    $("input[name='warrentyType']").val("保内");
                } else if (data.columns.warranty_type == "2") {
                    $("input[name='warrentyType']").val("保外");
                } else {
                    $("input[name='warrentyType']").val("");
                }
            }
        });
    } else {
        layer.msg("请输入工单编号");

    }
})

//工程师申请
function addbjsq(){
    layer.open({
        type: 2,
        content: '${ctx}/fitting/stock/addEmployeFittingApply',
        title: false,
        area: ['100%', '100%'],
        closeBtn: 0,
        shade: 0,
        fadeIn: 0,
        anim: -1
    });
}

var chang="1";
function change(va){
	chang=va;
}

$("#fittingApplyNum").blur(function(){
    if(isBlank($("#fittingApplyNum").val())){
        layer.msg("请输入申请数量！");
    }else if(!ck.test($("#fittingApplyNum").val())){
		layer.msg("申请数量格式不正确！");
	}
});

function reloadPage(){
    $('#table-waitdispatch').trigger("reloadGrid");
}

var fa=false;
$('#fittingForm').Validform({
	btnSubmit: ".fittingBut",
	tiptype: function(msg){
			if(msg != ""){
			layer.msg(msg);
			}
		},
	callback: function (form) {
	    if(fa){
            return;
        }else if(isBlank($("#fittingApplyNum").val())){
			layer.msg("请输入申请数量！");
		}else if($("#fittingApplyNum").val()=="0"){
            layer.msg("请重新输入申请数量！");
        }else if (ck.test($("#fittingApplyNum").val())) {
		    fa=true;
            $.ajax({
                url: "${ctx}/fitting/fittingApply/saveFittingApply",
                type: "POST",
                data: form.serialize(),
                success: function (data) {
                    if (data.noInventory) {
                        layer.msg("库存不足");
                    } else {
                        layer.msg("添加成功");
                        search();
                        if(chang!="1"){
                            $.closeDiv($('.addbjsq'));
                        }
                        fal="2";//防止互相影响
                        $("#fittingName").empty();
                        $("#select2-fittingName-container").empty();
                        $("#fittingCode").empty();
                        $("#select2-fittingCode-container").empty();
                        $("#employeId").val(null).trigger("change");
                        $('#fittingForm').find("input").val("");
                        $('#fittingForm').find("select").val("");
                        var  html='<option value="">请选择</option>';
                        $("#orderNumber").empty().append(html);
                        $("textarea[name='employeFeedback']").val("");
                    }
                },
				complete:function(){
                    fa=false;
                    fal="1";//防止互相影响
				}
            });
        } else {
            layer.msg("申请数量格式不正确");
        }
        return false;
    }
});

function fmtOper(row){
	var html = '';

	 if(row.status == 0 || row.status == 1){
		 if('${fns:checkBtnPermission("FITTINGMGM_FITAPPLY_ALLAPPLY_APPLY_BTN")}' === 'true'){

             if (row.status == 1 && parseFloat(row.fitting_apply_num) < parseFloat(row.warning)) {
                 html = '<span class="oState state-quejian " title="缺件已到"></span><span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\',\'' + row.fitting_id + '\');">审核</a></span>';
             }else if(row.status == 1 && parseFloat(row.fitting_apply_num) > parseFloat(row.warning) && row.fapStatus == 1){
                 html = '<span class="oState state-quejian2 " title="缺件在途"></span><span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\',\'' + row.fitting_id + '\');">审核</a></span>';
             }else if(row.status == 1 && parseFloat(row.fitting_apply_num) > parseFloat(row.warning) && row.fapStatus == 2){
                 html = '<span class="oState state-quejian1 " title="缺件中"></span><span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\',\'' + row.fitting_id + '\');">审核</a></span>';
             }else if(row.status == 1 && parseFloat(row.fitting_apply_num) > parseFloat(row.warning) && isBlank(row.fapStatus)){
                 html = '<span class="oState state-quejian1 " title="缺件中"></span><span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\',\'' + row.fitting_id + '\');">审核</a></span>';
             } else {
                 html = '<span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\',\'' + row.fitting_id + '\');">审核</a></span>';
             }
			}
			return html;
		}else if(row.status == 2){
			 if('${fns:checkBtnPermission("FITTINGMGM_FITAPPLY_ALLAPPLY_OUTPUT_BTN")}' === 'true'){
				 html = '<span class="oState state-qrck c-0383dc"><a href="javascript:Thelibrary(\''+row.id+'\',\''+fitName+'\',\''+row.fitting_version+'\',\''+row.fitting_audit_num+'\',\''+row.fitting_code+'\',\''+row.warning+'\',\''+row.audit_marks+'\',\''+row.old_fitting_flag+'\',\''+row.suit_category+'\',\''+row.employe_name+'\');">出库</a></span>';
			//	 html = '<a href="javascript:Thelibrary(\''+rowData.id+'\',\''+fitName+'\',\''+rowData.fitting_version+'\',\''+rowData.fitting_audit_num+'\',\''+rowData.fitting_code+'\',\''+rowData.warning+'\',\''+rowData.audit_marks+'\',\''+rowData.old_fitting_flag+'\',\''+rowData.suit_category+'\',\''+rowData.employe_name+'\');"  class="oState state-qrck c-0383dc">出库</a>';
				}
			return html;
		}

	return '<a onclick="seeDetail(\''+row.id+'\')" class="c-0e8ee7 w-90 text-l "><i class="sficon  sficon-view"></i>查看详情</a>';
}


//审核
function Toexamine(id,fittingId) {
	$.ajax({
		type : "POST",
		url : "${ctx}/fitting/employeFitting/checkEmployeFitting",
		data :{
			fittingId :fittingId
		},
		success : function(data) {
		 if(data == true){
				Hxskjlk(id);
			}else{
				$('body').popup({
        			level: '3',
        			type:2,  
        			closeSelfOnly: true,
        			content: '该工程师库存中有此备件（'+data+'），您确定继续审核吗？',
        			fnConfirm: function () {
        				Hxskjlk(id);
        			},
        			fnCancel: function () {
        			}
        		});
			} 

		},
        complete: function() {
            adpoting = false;
        }
	});
	
 
}

function Hxskjlk(id){
	  layer.open({
          type: 2,
          content: '${ctx}/fitting/fittingApply/form?id=' + id,
          title: false,
          area: ['100%', '100%'],
          closeBtn: 0,
          shade: 0,
          anim: -1
      });
}

//seeDetail：查看详情
function seeDetail(id) {
	layer.open({
		type: 2,
		content: '${ctx}/fitting/fittingApply/seeDetailForm?id=' + id,
		title: false,
		area: ['100%', '100%'],
		closeBtn: 0,
		shade: 0,
		anim: -1
	});
}


function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		multiselect:true,
		url : '${ctx}/fitting/fittingApply/Applyall',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		rownumbers : true,
		gridComplete : function() {
			_order_comm.gridNum();
		}
	});
}

function fmtWartype(row){
	if(row.warranty_type == 2){
		return "<span>保外</span>";
	}else if(row.warranty_type == 1){
		return "<span>保内</span>";
	}else{
		return "<span>---</span>";
	}
	return "<span></span>";
}

function fmtOrderNo(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\');">'+rowData.number+'</a>';
}

function showDetail(id){
	layer.open({
		type : 2,
		content:'${ctx}/order/orderDispatch/form?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1
	});
}

function fmtStatus(row){
	if((row.status == 0 || row.status == 1)){
        return '<span class="oState state-waitVerify2">待审核</span>';
	}else if(row.status == 2){
		return '<span class="oState state-waitCk">待出库</span>';
	}else if(row.status == 3){
		return '<span class="oState state-waitLq">待领取</span>';
	}else if(row.status == 4){
		return '<span  class="oState state-finished">已完成</span>';
	}else if(row.status == 5){
		return '<span class="oState state-canceled">已取消</span>';
	}else if(row.status == 6){
		return "<span class='oState state-verify2nopass'>审核未通过</span>";
	}
	return "<span></span>";
}

function fittingInRoad(fittingApplyId){
    location.href = "${ctx }/fitting/fittingApply/fittingInRoad?applyId="+fittingApplyId;
}

function search(){
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
function addNew(){
	layer.open({
		type : 2,
		content:'${ctx}/order/form',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1
	});
}


$(".addbjsq").find(".closePopup").on("click",function(){
    $("#fittingName").empty();
    $("#select2-fittingName-container").empty();
    $("#fittingCode").empty();
    $("#select2-fittingCode-container").empty();
});

function closed(){
    $("#fittingName").empty();
    $("#select2-fittingName-container").empty();
    $("#fittingCode").empty();
    $("#select2-fittingCode-container").empty();
	$.closeDiv($(".addbjsq"))
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
				 location.href="${ctx}/fitting/fittingApply/export?formPath=/a/fitting/fittingApply/ApplyallHeader&&maps="+$("#searchForm").serialize();
			 }

		});
	}else{
		 location.href="${ctx}/fitting/fittingApply/export?formPath=/a/fitting/fittingApply/ApplyallHeader&&maps="+$("#searchForm").serialize();
	}


}

function planStatus(rowData){
	if(rowData.fapStatus=='0'){
		return "待提交";
	}
	if(rowData.fapStatus=='1'){
        return '<a href="javascript:fittingInRoad(\''+rowData.id+'\');" class="c-0383dc" style="vertical-align: top">备件在途</a>';
		//return "已提交";
	}
	if(rowData.fapStatus=='2'){
		return "已入库";
	}
	return "";
}


</script>
	
</body>
</html>
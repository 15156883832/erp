<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
	<style>
		/*.col-7-1{ width:14%;}*/
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="ORDER_2017ORDER_ERPORDER_TAB" html='<a class="btn-tabBar "  href="${ctx }/order2017/header">ERP工单</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="ORDER_2017ORDER_400ORDER_TAB" html='<a class="btn-tabBar current"  href="${ctx }/order/ChangeSelfOrder/headerListforold400">400工单</a>'></sfTags:pagePermission><!--orderWholeList -->


			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
				<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="warningType"  value="">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
                            <th style="width: 76px;" class="text-r">标记类型：</th>
                            <td id="reloadSignSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select-box w-120"  id="signType" style="display:none" multiple  multiline="true" name="signType"  >
									<c:forEach items="${flags}" var="item">
                                        <option value="${item.id}">${item.name}</option>
                                    </c:forEach>
									</select>
								</span>
                            </td>
							<%--<th style="width: 76px;" class="text-r">工单状态：</th>
							<td id="reloadSpan">
								&lt;%&ndash;<input type="text" class="input-text" name = "status"/>&ndash;%&gt;
								<span class="dropdown-sin-2 w-140">
								<select class="select" name="status" id="status" multiple>
										<option value="">请选择</option>
										<option value="待派单">待派单</option>
										<option value="待接收">待接收</option>
										<option value="一级网点改派申请">一级网点改派申请</option>
										<option value="抢单中">抢单中</option>
										<option value="已接单">已接单</option>
										<option value="已预约">已预约</option>
										<option value="已派工">已派工</option>
										<option value="服务完成">服务完成</option>
										<option value="网点封单">网点封单</option>
										<option value="封单审核通过">封单审核通过</option>
										<option value="封单审核驳回">封单审核驳回</option>
										<option value="已结单">已结单</option>
										<option value="用户取消">用户取消</option>
										<option value="二级网点改派申请">二级网点改派申请</option>
										<option value="中心改派申请">中心改派申请</option>
										<option value="到货签收">到货签收</option>
										<option value="破损拒签">破损拒签</option>
										<option value="安得到货">安得到货</option>
										<option value="安得到货">用户签收</option>
										<option value="安得到货">用户拒签</option>
										<option value="安得到货">接收机器</option>
										<option value="安得到货">抢单锁定中</option>
									</select>
								</span>
							</td>--%>
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
								<input type="text" class="input-text" name = "applianceCategory"/>
							</td>
							<th style="width: 76px;" class="text-r">家电型号：</th>
							<td>
								<input type="text" class="input-text" name = "applianceModel"/>
							</td>
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
								<input type="text" class="input-text" id="serviceType" name = "serviceType"/>
							</td>

						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name = "customerMobile" onkeydown="enterEvent(event)"/>
								<input type="hidden" class="input-text" name = "orderStatus" id="orderStatus"/>
							</td>
							<th style="width: 76px;" class="text-r">用户地址：</th>
							<td>
								<input type="text" class="input-text" name = "customerAddress" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
								<input type="text" class="input-text" name = "employeName"/>
							</td>
							<th style="width: 76px;" class="text-r">转自接：</th>
							<td>
								<span class="select-box">
								<select class="select" name="isConvert" id="isConvert">
										<option value="">请选择</option>
										<option value="0">未转自接</option>
										<option value="1">已转自接</option>
									</select>
								</span>
							</td>


						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="" class="input-text Wdate w-140" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-140" style="width:140px" readonly>
							</td>
							<th style="width: 76px;" class="text-r">预约时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="promiseTimeMin" name="promiseTimeMin"  value="" class="input-text Wdate w-140" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'promiseTimeMin\')}'})" id="promiseTimeMax" name="promiseTimeMax" value="" class="input-text Wdate w-140" style="width:140px" readonly>
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">派工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'dispatchTimeMax\')||\'%y-%M-%d\'}'})" id="dispatchTimeMin" name="dispatchTimeMin" value="" class="input-text Wdate w-140" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'dispatchTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="dispatchTimeMax" name="dispatchTimeMax"  value="" class="input-text Wdate w-140" style="width:140px" readonly>
							</td>
							<th style="width: 76px;" class="text-r">完工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="endTimeMin" name="endTimeMin"  value="" class="input-text Wdate w-140" style="width:140px" readonly>
								至
								<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d 23:59:59'})" id="endTimeMax" name="endTimeMax" value="" class="input-text Wdate w-140" style="width:140px" readonly>
							</td>
						</tr>
					</table>
				</div>
			</form>
			<%--<div class="ordertjbox mt-10 cl">
				<div class="col-4-1 ordertj-item"  style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1 bb" onclick="warningOrder(1)">
							<p class="bg bg11"></p>
							<p class="txt">今日工单总数（<span class="f-18 c-0e8ee7 va-t" id="totalCounts">0</span>）</p>
						</div>
						<div class="ordertxt1" onclick="warningOrder(2)">
							<p class="bg bg12"></p>
							<p class="txt">待接收（<span class="f-18 c-0e8ee7 va-t" id="djsCount">0</span>）</p>
						</div>
					</div>
				</div>
				<div class="col-4-1 ordertj-item" style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1 bb" onclick="warningOrder(3)">
							<p class="bg bg31 "></p>
							<p class="txt">未完工（<span class="f-18 c-4baf4b va-t" id="wwgCount">0</span>）</p>
						</div>
						<div class="ordertxt1" onclick="warningOrder(6)">
							<p class="bg bg61"></p>
							<p class="txt">超45分钟未预约（<span class="f-18 c-f36a5a va-t" id="45mintCount">0</span>）</p>
						</div>
					</div>
				</div>
				<div class="col-4-1 ordertj-item"  style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1 bb" onclick="warningOrder(7)">
							<p class="bg bg62"></p>
							<p class="txt">预约倒计时2H（<span class="f-18 c-f36a5a va-t" id="2hCount">0</span>）</p>
						</div>
						<div class="ordertxt1" onclick="warningOrder(4)">
							<p class="bg bg41 "></p>
							<p class="txt">超20h预警工单（<span class="f-18 c-f36a5a va-t" id="20hCount">0</span>）</p>
						</div>
					</div>
				</div>
				<div class="col-4-1 ordertj-item"  style="cursor:pointer;">
					<div class="bk-gray">
						<div class="ordertxt1" onclick="warningOrder(5)">
							<p class="bg bg42"></p>
							<p class="txt">超24h预警工单（<span class="f-18 c-f36a5a va-t" id="24hCount">0</span>）</p>
						</div>
					</div>
				</div>
			</div>--%>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<%--<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HUNDRANDORDER_ZHUANZIJIE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="zzj();"><i class="sficon sficon-zzj"></i>转自接</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDERMGM_FOURORDER_HUNDRANDORDER_DELETEMORE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="delMore();"><i class="sficon sficon-rubbish"></i>批量删除</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<a href="javascript:showMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sign"></i>标记工单</a>'></sfTags:pagePermission>
					<a href="javascript:cancelMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-signCancel"></i>取消标记</a>--%>
						<a href="javascript:cancelMarkOrders();" class="sfbtn sfbtn-opt"><i class="sficon sficon-signCancel"></i>取消标记</a>
					<sfTags:pagePermission authFlag="ORDER_2017ORDER_400ORDER_PLPRINT_BTN" html='<a href="javascript:batchPrint();" id="repeatOrder"  class="sfbtn sfbtn-opt"><i class="sficon sficon-print"></i>批量打印</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="ORDER_2017ORDER_400ORDER_EXPORT_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="ORDER_2017ORDER_400ORDER_HEADER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
								
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
					
						<!-- <div class="f-l">
							<span class="c-f55025">注：</span>
							<span class="oState oState state-yzzj">已转自接</span>
						</div> -->
						<div class="f-l iconsBoxWrap">
								<a class="iconDec">图标注释？</a>
								<div class="iconsBox">
									<div class="iconsBoxBg">
										<div class="cl pl-10 pt-5">
											<span class="oState state-yzzj w-80 mb-5">已转自接</span>
											
										</div>
									</div>
									<span class="iconArrow"></span>
								</div>
								
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

<!-- 单个转自接 -->
<div class="popupBox zzjBox dange">
	<h2 class="popupHead">
		转自接
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="lh-22">当前服务工程师：<span class="c-0e8ee7 f-14 pl-5 pr-5" id="employes">张三</span></div>
			<div class="cl mt-15" id="stateBoxS">
				<span class="lh-26 f-l w-160 text-r">请选择转自接后的工单状态：</span>
				<a class="f-l ml-5 w-80 selectLabel selectedLabel">
					待派工<i class="icon-sel"></i>
				</a>
				<a class="f-l ml-5 w-80 selectLabel">
					服务中<i class="icon-sel"></i>
				</a>
				<a class="f-l ml-5 w-80 selectLabel">
					待回访<i class="icon-sel"></i>
				</a>
			</div>
			<div class="h-40 ">
				<div class="pt-15 cl hide" id="engineerNameS">
					<span class="f-l lh-26 w-160 text-r">请选择服务工程师：</span>
					<!-- 多选 -->
					<select class="select easyui-combobox ml-5 f-l w-140 " multiple="true"   id="selectEmployes">
						<!-- <option value="">请选择</option> -->
						<%-- <c:forEach items="${empList }" var="el">
							<option value="${el.columns.name }">${el.columns.name }</option>
						</c:forEach> --%>
					</select>
				</div>
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="settleFlag" name="settleFlag" value="${settleFlag }">
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
var isConvert = '${is_convert}'; //是否转自接

/* $(".resetSearchBtn").on("click",function(){
	$('#statusFlag').combobox('setValues',"");
	$('#employs').combobox('setValues',"");
}); */


$(function(){
	
	$('.iconDec').showIcons();
	selectStateS('stateBoxS','engineerNameS'); // 选择转自接状态
	
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
    couts();
	initSfGrid();
    $('.dropdown-sin-2').dropdown({input: '<input type="text" maxLength="20" placeholder="请输入搜索">',});
    $.setGridSize();
});

function isBlank(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}

function couts(){
    $.post("${ctx}/order/ChangeSelfOrder/getCounts",{orderType:"2"},function(result){
        $("#totalCounts").text(result.jrgdCunt);
        $("#djsCount").text(result.djsCount);
        $("#wwgCount").text(result.wwgCount);
        $("#20hCount").text(result.tyhCount);
        $("#24hCount").text(result.tfhCount);
        $("#45mintCount").text(result.fofmintCount);
        $("#2hCount").text(result.twhCount);
    });
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/ChangeSelfOrder/old400Order',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		rownumbers:true,
 		loadComplete: function() {
 			_order_comm.gridNum();
            if($("#table-waitdispatch").find("tr").length>1){
                $(".ui-jqgrid-hdiv").css("overflow","hidden");
            }else{
                $(".ui-jqgrid-hdiv").css("overflow","auto");
            }
		}  
	});
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
        return '已删除';
	}
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

function gdbh(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
}

function showDetail(id){
	$("#table-waitdispatch").jqGrid('resetSelection');
	 $("#table-waitdispatch").jqGrid('setSelection',id);
	layer.open({
		type : 2,
		content:'${ctx}/order/ChangeSelfOrder/oldOrder400Form?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1 
	});
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

function warningOrder(type){
	$("input[name='warningType']").val(type);
	search();
}

function search(){
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
	$("#applianceB").val($('#applianceBrand option:selected').val());
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

function reset(){
	//$("#statusFlag").combobox('clear');
	//$("#employs").val("");
	//$('#statusFlag').combobox('setValues',"");
	$("#searchForm").get(0).reset();
    $("#searchForm").find("input").val("");

    var html2 = '<span class="w-140 dropdown-sin-2">';
    html2 += '<select class="select-box w-120"  id="signType" style="display:none" multiple  multiline="true" name="signType" >';
    html2 += '<c:forEach items="${flags}" var="sign">';
    html2 += ' <option value="${sign.id }">${sign.name }</option>';
    html2 += '</c:forEach>';
    html2 += '</select>  </span>';
    $("#reloadSignSpan").html(html2);

    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
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
				 location.href="${ctx}/order/ChangeSelfOrder/exportForOld?formPath=/a/order/ChangeSelfOrder/headerListforold400&&maps="+$("#searchForm").serialize();
			 }
		});
	}else{
		 location.href="${ctx}/order/ChangeSelfOrder/exportForOld?formPath=/a/order/ChangeSelfOrder/headerListforold400&&maps="+$("#searchForm").serialize();
	}

}

function zzj(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	
	if(idArr.length<1){
		layer.msg("请先选择数据！");
		return ;
	}else if(idArr.length==1){//单个工单转自接
		var id=idArr[0];
		var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]);
		var numbers = "'"+rowData.number+"'";
		
		if(rowData.is_convert=="1"){
			layer.msg("您选择的工单已转自接，不可重复转！");
			return ;
		}else{
			$.ajax({
				type:"post",
				url:"${ctx}/order/ChangeSelfOrder/checkNumber",
				data:{numbers:numbers},
				success:function(result){
					if(result=="existNumber"){
						layer.msg("您选择转自接的工单编号在自接工单表中已经存在，无法转自接！");
					}else if(result=="ok"){
						layer.open({
							type : 2,
							content:'${ctx}/order/ChangeSelfOrder/oneZzj?id='+id,
							title:false,
							area: ['100%','100%'],
							closeBtn:0,
							shade:0,
							anim:-1 
						});
					}else{
						layer.msg("校验工单编号失败，请检查！");
					}
				}
			})
			
		}
	}else if(idArr.length>1){//批量转自接
		var ids="";
		var numbers = "";
		for(var i=0;i<idArr.length;i++){
			var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
			if(rowData.is_convert=="1"){
				layer.msg("您选择的工单中存在已转自接的工单，请重新选择！");
				return false ;
			}
			if(ids==""){
				ids="'"+idArr[i]+"'";
			}else{
				ids=ids+",'"+idArr[i]+"'";
			}
			if(numbers==""){
				numbers="'"+rowData.number+"'";
			}else{
				numbers=numbers+",'"+rowData.number+"'";
			}
		}
		$.ajax({
			type:"post",
			url:"${ctx}/order/ChangeSelfOrder/checkNumber",
			data:{numbers:numbers},
			success:function(result){
				if(result=="existNumber"){
					layer.msg("您选择转自接的工单编号在自接工单表中已经存在，无法转自接！");
				}else if(result=="ok"){
					layer.open({
						type : 2,
						content:'${ctx}/order/ChangeSelfOrder/moreZzj?ids='+ids,
						title:false,
						area: ['100%','100%'],
						closeBtn:0,
						shade:0,
						anim:-1 
					});
				} else{
					layer.msg("校验工单编号失败，请检查！");
				}
			}
		})
	}
}

function selectStateS(id1, id2){
	$('#'+id1+' .selectLabel').each(function(index){
		$(this).on('click', function(){
			$('#'+id1+' .selectLabel').removeClass('selectedLabel');
			$(this).addClass('selectedLabel');
			if(index == 0){
				$('#'+id2).hide();
			}else{
				$('#'+id2).show();
			}
		});
	})
}

function delMore(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){
		layer.msg("请先选择您要删除的工单！");
		return;
	}else{
		var delIds="";
		var leg = idArr.length;
		for(var i=0;i<idArr.length;i++){
			if(delIds==""){
				delIds="'"+idArr[i]+"'";
			}else{
				delIds=delIds+",'"+idArr[i]+"'";
			}
		}
		$('body').popup({
			level:'3',
			type:2,
			content:"您确定要删除这"+leg+"条工单吗？",
			fnConfirm:function(){
				$.ajax({
					type:"post",
					url:"${ctx}/order/ChangeSelfOrder/delMore",
					data:{delIds:delIds},
					success:function(result){
						if(result=="ok"){
							layer.msg("删除成功！");
							setTimeout(function(){
								//window.location.reload(true);
                                couts();
								search();
							},200);
						}else{
							layer.msg("删除失败，请检查！");
						}
						
					}
				})
			}
		})
		
	}
}

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		$("#applianceB").val($('#applianceBrand option:selected').val());
	    $("#table-waitdispatch").sfGridSearch({
	        postData: $("#searchForm").serializeJson()
	    });
	}
}
function showMarkOrders() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length <= 0) {
        layer.msg("请选择需要标记的工单");
        return;
    }

    layer.open({
        type : 2,
        content:'${ctx}/order/showMarkOrders?ids=' + idArr.join(",") + "&type=400",
        title:false,
        area: ['100%','100%'],
        closeBtn:0,
        shade:0,
        anim:-1
    });
}
function cancelMarkOrders() {
    var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length <= 0) {
        layer.msg("请选择需要取消标记的工单");
        return;
    }

    $('body').popup({
        level: '3',
        type: 2,
        title:"提示",
        content:"是否要取消已选择工单的标记？",
        fnConfirm :function(){
            $.ajax({
                url: '${ctx}/order/cancelOrdersMarkFor2017?type=400&ids=' + idArr.join(","),
                type: 'post',
                success: function() {
                    layer.msg("取消标记成功");
                    search();
                }
            });
        }
    });
}

function fmtOrderType(row){
    //2.美的厂家系统 3.惠而浦厂家系统 4.海信厂家系统 5.海尔厂家系统
    if(row.order_type=='2'){
		return "美的";
	}else if(row.order_type=='3'){
        return "惠而浦";
	}else if(row.order_type=='4'){
        return "海信";
	}else if(row.order_type=='5'){
        return "海尔";
	}else{
        return "";
	}
}

//批量打印
function batchPrint(){
	var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
    if (idArr.length <= 0) {
        layer.msg("请选择需要打印的工单！");
    } else {
    	//使用默认
    	window.open("${ctx}/print/order400For2017?orderId="+idArr.join(','));
    }
}
</script>
	
</body>
</html>
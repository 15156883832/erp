<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>库存管理</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
</head>
<body>
<div class="sfpagebg">
<div class="sfpage bk-gray table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_COMPANYSTOCK_TAB" html='<a class="btn-tabBar "  href="${ctx }/fitting/stock/index">公司库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_TAB" html='<a class="btn-tabBar"  href="${ctx }/fitting/stock/empFitting">工程师库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_WAITERETURN_TAB" html='<a class="btn-tabBar current"  href="${ctx }/fitting/stock/waitReturn">工程师返还<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:reset();" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
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
								<input type="text" class="input-text" name= "code"/>
							</td>
							<th style="width: 76px;" class="text-r">备件名称：</th>
							<td>
								<input type="text" class="input-text" name = "name"/>
							</td>
							<th style="width: 76px;" class="text-r">备件型号：</th>
							<td>
								<input type="text" class="input-text" name = "version"/>
							</td>
							
							<th style="width: 76px;" class="text-r">申请时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'usedTimeMax\')||\'%y-%M-%d\'}'})" id="usedTimeMin" name="usedTimeMin" value="" class="input-text Wdate w-140">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'usedTimeMin\')}',maxDate:'%y-%M-%d'})" id="usedTimeMax" name="usedTimeMax" value="" class="input-text Wdate w-140">
							</td>
								</tr>
						<tr>
							<th style="width: 76px;" class="text-r">申请人：</th>
							<td>
								<input type="text" class="input-text" name = "employeName"/>
							</td>
							<th style="width: 76px;" class="text-r">工程师：</th>
							<td>
								<span class="f-l">
									<select class="select select-box w-140"  id="employs"  multiline="true" name="empId"  style="height:26px">
										<option value="">请选择</option>
										<c:forEach var="emp" items="${list}">
											<option value="${emp.id}"  <c:if test="${empId==emp.id }">selected="selected"</c:if>>${emp.name }<c:if test="${emp.status=='3'}">（离职）</c:if></option>
										</c:forEach>
									</select>
								</span>
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				
					<div class="f-l">
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_BATCHSTORAGE_BTN" html='<a href="javascript:batchStorage();" class="sfbtn sfbtn-opt2" ><i class="sficon sficon-plrk"></i>批量入库</a>'></sfTags:pagePermission>
					</div>

				</div>
			<div class="mt-10">
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
		<div class="tabCon">
			暂不派工
		</div>
		<div class="tabCon">
			拒接工单
		</div>
		<div class="tabCon">
			今日预约
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


<script type="text/javascript">
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID

$(function(){
	$("select[name='empId']").select2();
	$(".selection").css("width","140px");
	//获取tab页面统计数字
	$.post("${ctx}/fitting/stock/getWaitReturnCount1",function(result){
		$("#tab_c1").text(result[0].count);
	});
	
 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	
	initSfGrid();
	
});
function resuleCount(){
	$.post("${ctx}/fitting/stock/getWaitReturnCount1",function(result){
		$("#tab_c1").text(result[0].count);
	});
}


function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/fitting/stock/ajaxWaitReturnList',
		sfHeader: defaultHeader,
		shrinkToFit:true,
		postData: $("#searchForm").serializeJson(),
        multiselect: true,
        rownumbers : true,
		gridComplete : function() {
			_order_comm.gridNum();
		}
	});
}
//判断数据是否为空
function isBlank(val) {
    if(val==null || val=='' || val == undefined) {
        return true;
    }
    return false;
}
//批量入库
function batchStorage(){
	   var idArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
		var length = idArr.length;
       if(length<1){
           layer.msg("请选择数据！");
       }
       else{
	var content = "确认批量将"+length+"条数据入库？";
	var ids;
	 for(var i=0 ;i<idArr.length;i++){
         if(isBlank(ids) ){
        	 ids=idArr[i];
         }else{
        	 ids=ids+","+idArr[i];
         }
     }
	$('body').popup({
		level:3,
		title:"备件批量入库",
		content:content,
		fnConfirm :function (){
            if(adpoting) {
                return;
            }
			adpoting = true;
			$.ajax({
				type:"POST",
				url:"${ctx}/fitting/stock/batchdoDFH",
				data:{
					"ids":ids
				},
				success:function(result){
					if(result==1){
						layer.msg('入库成功！！');
						window.location.reload(true);
					}else if(result==0){
						layer.msg('入库失败！！');
						window.location.reload(true);
					}
				},
                complete: function() {
                    adpoting = false;
                }
			});
		},
		fnCancel:function (){
			
		}
	});
       }
}

function fmtCode(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\');">'+rowData.fitting_code+'</a>';
}

function search(){
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
	var checkFlag = true;
	$("input.numberTest").each(function(){
		if($(this).val() != "" && !Number($(this).val())){
			layer.msg("请输入正确库存数量!");
			$(this).val("");
			checkFlag = false;
		}
	});
	if(!checkFlag){
		return;
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

function fmtFitType(rowDate){
	if(rowDate.type==1){
		return '配件';
	}else if(rowDate.type==2){
		return "耗材";
	}else{
		return "--";
	}
}
//确认入库按钮
function fmtOper(rowData){
	var html;
	if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_WAITERETURN_CONFIRMINSTOCK_BTN")}' === 'true'){
		html = '<a href="javascript:showDetail(\''+rowData.id+'\',\''+rowData.empName+'\',\''+rowData.used_num+'\',\''+rowData.name+'\');" class="oState state-qrrk c-0383dc">入库</a>';
	}
	if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_WAITERETURN_BOHUI_BTN")}' === 'true'){
		html += '<a href="javascript:RejectFitting(\''+rowData.id+'\',\''+rowData.name+'\',\''+rowData.version+'\',\''+rowData.used_num+'\');" class="ml-10 c-0383dc"><i class="sficon sficon-bohui"></i>驳回</a>';
	}
	return html;
}
//确认入库动作
var adpoting = false;
function showDetail(id,empName,usedNum,name){
    if(adpoting) {
        return;
    }
	adpoting = true;
	var content = "确认将"+name+"入库？";
	$('body').popup({
		level:3,
		title:"备件入库",
		content:content,
		fnConfirm :function (){
			$.ajax({
				type:"POST",
				url:"${ctx}/fitting/stock/doDFH",
				data:{
					"id":id,"usedNum":usedNum,"empName":empName
				},
				success:function(result){
					if(result==1){
						layer.msg('入库成功！！');
						window.location.reload(true);
						adpoting = false;
					}else if(result==0){
						layer.msg('入库失败！！');
						window.location.reload(true);
						adpoting = false;
					}
				},
                complete: function() {
                    
                }
			});
		},
		fnCancel:function (){
			
	 adpoting = false;
		}
	});
}

function reset() {
	$("select[name='empId']").select2('val','请选择');
}

//驳回
var outStocking = false;
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
                url: "${ctx}/fitting/fittingApply/RejectFittingUsedRecord",
                data: {
                    id: id
                },
                success: function (result) {
                    if (result.code == "200") {
                    	layer.msg("驳回成功！");
                        search();
                        resuleCount();
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
</script>
	
</body>
</html>
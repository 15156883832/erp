<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    <meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
	<script type="text/javascript" src="${ctxPlugin}/lib/imgShow.js"></script>
	  <style>
		  .tagImgBg{ background: #fff}
	  </style>
  </head>
  
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="EMP_SERVICE_EVAL_DETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/orderEvaluation/headList">用户评价</a>'></sfTags:pagePermission>
                <sfTags:pagePermission authFlag="QRCODE_USEDRECORD_TAB" html='<a class="btn-tabBar " href="${ctx }/QRCode/getQRCodeUsedList">电子名片服务记录</a>'></sfTags:pagePermission>
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
				<input type="hidden" name="siteId" id="siteId" value="${siteId }"> 
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">评价：</th>
							<td>
								<span class="select-box">
									<select class="select" name="serviceEval" id="serviceEval">
										<option value="">请选择</option>
										<option value="4">非常满意</option>
										<option value="3">满意</option>
										<option value="2">一般</option>
										<option value="1">不满意</option>
										<option value="0">很不满意</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">收款情况：</th>
							<td>
								<span class="select-box">
									<select class="select" name="chargeCondition" id="chargeCondition">
										<option value="">请选择</option>
										<option value="0">未收费</option>
										<option value="1">已收费</option>
									</select>
								</span>
							</td>
							
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
								<span class="">
									<select class="select select-box" name="employeId" id="employeName">
										<option value="">请选择</option>
										<c:forEach items="${empList}" var="el">
											<option value="${el.columns.id }">${el.columns.name }</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<td colspan="3">
								<label class="text-r lb">评价日期：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="${startTime }" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="<fmt:formatDate value="${date }" pattern="yyyy-MM-dd"/>" class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>
				</div>
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination" id="paginations"></div>
						</div>
					</div>
					<!-- pagination -->
			</div>
		</div>
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
 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
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
	$('#employeName').select2();
		//2.监听父层按钮的动作
		$('#pngfix-nav-btn', parent.document).click(function(){
			//3.给定一个时间点
			setTimeout(function(){
				//4.再次执行全屏
				layer.restore(full_idx);
			},200);
		});
		
	$(".selection").css("width","140px");

});

function serviceEval(rd) {
    //（4、非常满意;3、满意;2、一般;1、不满意0、非常不满满意）
    if (rd.service_eval === '4') {
        return "非常满意";
    } else if (rd.service_eval === '3') {
        return "满意";
    } else if (rd.service_eval === '2') {
        return "一般";
    } else if (rd.service_eval === '1') {
        return "不满意";
    } else if (rd.service_eval === '0') {
        return "非常不满意";
    }
    return "--"
}

function fmtChargeCondition(rd) {
    if (rd.charge_condition === '0') {
        return "未收费";
    } else if (rd.charge_condition === '1') {
        return "已收费";
    }
    return "--"
}

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/order/orderEvaluation/evaluationList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url,
        sfHeader: eval('${headerData.tableHeader}'),
        sfSortColumns:'${headerData.sortHeader}',
		postData:$("#searchForm").serializeJson(),
        shrinkToFit:true,
		multiselect: false,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		},
		loadComplete: function() {
            $('#table-waitdispatch .proofImg').each(function(){
				$(this).imgShow({hasIframe:true});
			});
		}
	});
}
$('.fftc .proofImg').imgShow();
function fmtPin(rowData) {
	var imgPath = '${commonStaticImgPath}' + rowData.sign;
	return '<span class="proofImg"><a class="c-0383dc">用户签字</a> <img src="'+imgPath+'" /> </span>';
}
function search(){
    var pageSize = $("#pageSize").val();
    if ($.trim(pageSize) == '' || pageSize == null) {
        $("#pageSize").val(20);
    }
    $("#table-waitdispatch").sfGridSearch({
        postData:$("#searchForm").serializeJson()
    });

}
</script>
  </body>
</html>
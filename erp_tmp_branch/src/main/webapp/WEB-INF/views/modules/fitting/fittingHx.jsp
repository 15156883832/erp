<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>  

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<style type="text/css">
.webuploader-pick{
	background:none;
	color:#22a0e6;	
	padding:0;
	
}
/* .spimg1{ border:none;} */
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
.spimg2{ border:none;}
.spimg2 .webuploader-pick{
	width:80px;
	height:80px;
}

.webuploader-pick img{
	width:100%;
	height:100%;
	position:absolute;
	left:0;
	top:0;
}
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
<title>备件申请管理-待核销</title>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_WAITEVERIFICAT_TAB" html='<a class="btn-tabBar current" href="${ctx}/fitting/preVerificationList">待核销<sup id="tab_c1">0</sup></a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_VERIFICATHISTORY_TAB" html='<a class="btn-tabBar" href="${ctx}/fitting/verificationHistoryList">核销历史记录</a>'></sfTags:pagePermission>
					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
						<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
						<a href="javascript:reset2();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
					</p>
				</div>
				<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">备件条码：</th>
							<td>
								<input type="text" name="code" class="input-text" />
								<input type="hidden" name="emps" id="emps" class="input-text" />
							</td>
							<th style="width: 76px;" class="text-r">备件名称：</th>
							<td>
								<input type="text" name="name" class="input-text" />
							</td>
							<th style="width: 80px;" class="text-r">服务工程师：</th>
							<td id="reloadSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select" id="employs" multiple  name="emps" >
									<c:forEach items="${fns:getEmloyeListForAll(siteId) }" var="emp">
										<c:if test="${emp.columns.status ne 3}">
											<option value="${emp.columns.name }">${emp.columns.name }</option>
										</c:if>
										<c:if test="${emp.columns.status eq 3}">
											<option value="${emp.columns.name }">${emp.columns.name }【离职】</option>
										</c:if>
									</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">使用类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="verificationUsedType">
										<option value="">请选择</option>
										<option value="1">工单使用</option>
										<option value="11">工单零售</option>
										<option value="3">工程师零售</option>
										<option value="4">网点零售</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">旧件状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="oldStatus">
										<option value="">请选择</option>
										<option value="0">已登记</option>
										<option value="1">已入库</option>
										<%--<option value="2">已删除</option>--%>
										<option value="3">已返厂</option>
										<option value="4">已报废</option>
									</select>
								</span>
							</td>

						</tr>
						<tr>
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
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" name="orderNo" class="input-text" />
							</td>
							<th style="width: 80px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" name="tel" class="input-text" />
							</td>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name= "customerName"/>
							</td>
							<th style="width: 76px;" class="text-r">详细地址：</th>
							<td>
								<input type="text" class="input-text" name= "customerAddress"/>
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">备件状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="fistatus">
										<option value="">请选择</option>
										<option value="1">待核销</option>
										<option value="3">已拒绝</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">备件品牌：</th>
							<td>
								<input type="text" name="fittingBrand" class="input-text" />
							</td>
							<th style="width: 76px;" class="text-r">使用时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemmin" name="datemmin" class="input-text Wdate">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemmin\')}',maxDate:'%y-%M-%d'})" id="datemax" name="datemax" class="input-text Wdate">
							</td>
						</tr>
					</table>
				</div>
				</form>
				<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_WAITEVERIFICAT_BATCHHX_BTN" html='<a href="javascript:modify();" class="sfbtn sfbtn-opt" id="xzhelp"><i class="sficon sficon-plcopy"></i>批量核销</a>'></sfTags:pagePermission>
				</div>
					<div class="f-r">
						<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_WAITEVERIFICAT_HX_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FITTINGMGM_PREVERFICAT_WAITEVERIFICAT_SETHEADER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
					</div>
				</div>
				<div class="mt-10">
					<table id="table-waitdispatch" class="table"></table>
					<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div></div>

<!-- 核销 -->
<div class="popupBox hxbox">
	<h2 class="popupHead">
		核销
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
        <form id="popupForm">
		<input type="hidden" id="vid" >
		<div class="popupMain">
			<div class="tabBarP mb-10">
				<a href="javascript:;" class="tabswitch fitInf current" onclick="javascript:fitInf();">备件信息</a>
				<a href="javascript:;" class="tabswitch orderInf" onclick="javascript:orderInf();">工单信息</a>
				<a href="javascript:;" class="tabswitch oldFitInf" onclick="javascript:oldFitInf();">旧件信息</a>
			</div>
			<div class="cl fittingInfo">
				<div class="f-r mb-10 mr-20">
					<label class="lb1 f-l">图片：</label>
					<div class="imgbox f-l spimg1" id="spimg1">
						<img  id="appearPhoto"/>
						<input type="hidden" name="img" value="" id="f_img">
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="lb1 f-l">备件条码：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_code"/>
					<label class="lb2 f-l">备件名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_name"/>
				</div>

				<div class="f-l mb-10">
					<label class="lb1 f-l">备件型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_version"/>
					<label class="lb2 f-l">使用类型：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_type"/>
				</div>
				<div class="f-l">
					<label class="lb1 f-l">备件数量：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_used_num"/>
					<label class="lb2 f-l">旧件返还：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_return_old"/>
				</div>
			</div>
			<div class="tabCon pt-10 gongdanInfo hide">
				<div class="cl mb-10">
					<label class="lb1 f-l">工单编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_order_no"/>
					<label class="f-l lb2">用户姓名：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_customer_name"/>
					<label class="f-l lb2">联系方式：</label>
					<input type="text" class="input-text w-120 f-l readonly" readonly="readonly" value="" id="f_tel"/>
				</div>
				<div class="cl mb-10">
					<label class="lb1 f-l">家电信息：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_appliance"/>
					<label class="f-l lb2">工单状态：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_order_status"/>
				</div>
			</div>
			<div class="tabCon oldFittingInfo hide">
				<div class="mb-5 text-r">
					<a href="javascript:stock();" class="sfbtn sfbtn-opt w-70"><i class="sficon sficon-rk"></i>入库</a>
				</div>
				<div class="cl bk-blue-dotted pt-10" id="old_fitting_info">
					<div class="f-r mb-10 mr-20">
						<label class="lb1 f-l spimg1" id="spimg2">图片：</label>
						<div class="imgbox f-l">
							<img id="oldImg" />
							<input type="hidden" name="img" value="" id="f_old_img">
						</div>
					</div>
					<div class="f-l mb-10">
						<label class="lb1 f-l">旧件状态：</label>
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_old_status2"/>
						<label class="lb2 f-l">旧件条码：</label>
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_old_code"/>
					</div>
					<div class="f-l mb-10">
						<label class="lb1 f-l">旧件名称：</label>
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_old_name"/>
						<label class="lb2 f-l">旧件型号：</label>
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_old_version"/>
					</div>
					<div class="f-l">
						<label class="lb1 f-l">旧件品牌：</label>
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_old_brand"/>
						<label class="lb2 f-l">是否原配：</label>
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="" id="f_old_origin"/>
					</div>
				</div>
			</div>
			<div id="hxInfoWrap">
				<div class="tabBarP mb-10">
					<a href="javascript:;" class="tabswitch current">收款信息</a>
				</div>
				<div class="tabCon">
					<div class=" bk-blue-dotted pb-10 pt-10">
						<div class="cl mb-10">
							<label class="lb1 f-l">核销类型：</label>
							<select class="select w-100 f-l" id="hxType">
								<option value="1">工单使用</option>
								<option value="2">工单零售</option>
								<option value="3">工程师零售</option>
								<option value="4">网点零售</option>
							</select>
							<label class="f-l lb2">收款金额：</label>
							<div class="f-l priceWrap w-100">
								<input type="text" class="input-text readonly" value="" name="collectMoney" id="f_collect_money" readonly/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="cl mb-10">
							<label class="lb1 f-l">确认收款：</label>
							<div class="f-l w-100">
								<label class="mt-3 radiobox radiobox-selected">
									<input type="radio" />是
								</label>
								<label class="mt-3 ml-20 radiobox">
									<input type="radio" />否
								</label>
							</div><label class="f-l lb2">确认金额：</label>
							<div class="f-l priceWrap w-100">
								<input type="text" class="input-text" value="" name="confirmedMoney" id="f_confirmed_money" maxlength="8"/>
								<span class="unit">元</span>
							</div>
						</div>
					</div>
					<div class="text-c mt-10">
						<a href="javascript:confirmVerification();" class="sfbtn sfbtn-opt3 w-70 mr-5">核销</a>
						<a href="javascript:refuseHx();" class="sfbtn sfbtn-opt w-70 mr-5">拒绝</a>
						<a href="javascript:saveSaleInfo();" class="sfbtn sfbtn-opt w-70 mr-5">保存</a>
						<a href="javascript:cancel();" class="sfbtn sfbtn-opt w-70">取消</a>
					</div>
				</div>
			</div>
		</div>
        </form>
	</div>
</div>

<!-- 批量核销 -->
<div class="popupBox batchhxbox" style="width:500px;">
	<h2 class="popupHead">
		批量核销
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="" style="width:500px;text-align: left;margin-left:100px;"> 
				<strong class="countksj"></strong>
			</div>
			<p class="c-666 lh-26" style="width:500px;text-align: left;margin-left:100px;">提示：</p>
			<p class="c-666 lh-26" style="width:500px;text-align: left;margin-left:100px;">1.核销类型：批量审核后默认核销类型为备件的使用类型。</p>
			<p class="c-666 lh-26" style="width:500px;text-align: left;margin-left:100px;">2.确认收款与确认金额：默认确认金额与备件收款金额一致。</p>
			
			<div class="text-c mt-10">
				<a href="javascript:batchVerification();" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
				<a href="javascript:batchcancel();" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>


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


<!-- 表头设置 -->
		<div class="">
			<div>
				<h2></h2>
			</div>
		</div>

<script type="text/javascript">
var sfGrid;
var id = '${headerData.id}';
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
		$.Huitab("#hxInfoWrap .tabBarP .tabswitch","#hxInfoWrap .tabCon","current","click","0");
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
//		$('.hxbox').popup();
		initGrid();
		$(".radiobox").click(function() {
			$(".radiobox").removeClass("radiobox-selected");
			$(this).addClass("radiobox-selected");
		});
		markCount();
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
	});
	
	
	function modify(){
		  var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
	        if(ids.length < 1){
	            layer.msg("请选择批量核销的数据!");
	        }else{
	        	$(".countksj").html("确定对"+ids.length+"条备件进行批量核销吗？");
	        	$('.batchhxbox').popup();
	        }
	    }
	
	        	var verifying = false;
	function batchVerification(){
		if (verifying) {
			return;
		}
		 var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
	        if(ids.length < 1){
	            layer.msg("请选择批量核销的数据!");
	        }else{
	        	var delIds="";
	    		for(var i=0;i<ids.length;i++){
	    			if(isBlank(delIds)){
	    				delIds = ids[i];
	    			}else{
	    				delIds = delIds + "," + ids[i] ;
	    			}
	    		}
	        	// 批量核销
	        verifying = true;
              $.ajax({
       			type: "POST",
       			url: "${ctx}/fitting/batchVerification",
       			data: {
       				ids: delIds 
       			},
       			success: function (data) {
       				if ("200" == data.code) {
       					search();
       					markCount();
       					layer.msg("核销成功");
       					batchcancel();
       				} else {
       					layer.msg("保存失败");
       				}
       			},
       			complete: function () {
       				verifying = false;
       			}
       		});
	        	}
	       
	}
	
	function fmtoper(rowData) {
		var html = '';
		if('${fns:checkBtnPermission("FITTINGMGM_PREVERFICAT_WAITEVERIFICAT_VERIFICAT_BTN")}' === 'true'){
			html = '<a href="javascript:verify(\''+rowData.id+'\');" class="oState state-hexiao c-0383dc hxhelp">核销</a>';
		}
		
		return html;
	}

function fitInf() {
    $(".fitInf").addClass("current");
    $(".orderInf").removeClass("current");
    $(".oldFitInf").removeClass("current");
    $(".fittingInfo").show();
    $(".gongdanInfo").hide();
    $(".oldFittingInfo").hide();
};
function orderInf() {
    $(".orderInf").addClass("current");
    $(".fitInf").removeClass("current");
    $(".oldFitInf").removeClass("current");

    $(".fittingInfo").hide();
    $(".gongdanInfo").show();
    $(".oldFittingInfo").hide();
};
function oldFitInf() {
    $(".oldFitInf").addClass("current");
    $(".orderInf").removeClass("current");
    $(".fitInf").removeClass("current");

    $(".fittingInfo").hide();
    $(".gongdanInfo").hide();
    $(".oldFittingInfo").show();
};

	function search(){
		//var y =$("#employs").combobox("getValues");
		//$("#emps").val(y);
		var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
		$("#table-waitdispatch").sfGridSearch({
			postData: $("#searchForm").serializeJson(),
			traditional:true
		});
	}

	function fmtOrderNo(rowData){
		var orderId = rowData.order_id || '';
		var orderNo = rowData.order_number || '';
		return '<a href="javascript:showDetail(\''+orderNo+'\');" class="c-0383dc">'+orderNo+'</a>';
	}

function fmtStatus(rowData){
    var status = rowData.status;
    return {"1":"待核销","2":"已核销","3":"已拒绝"}[status];
}

	function showDetail(orderNo){
		layer.open({
			type : 2,
			content:'${ctx}/order/orderDispatch/orderDetailForm?orderNo='+orderNo,
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			fadeIn:0,
			anim:-1
		});
	}

	function reset2() {
		$("#searchForm").get(0).reset();
        var html = '<span class="w-140 dropdown-sin-2">';
        html += '<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="emps"  >';
        html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
        html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
        html += '</c:forEach>';
        html += '</select>  </span>';
        $("#reloadSpan").html(html);
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">'
        });
	}

	function initGrid(){
		$("#table-waitdispatch").sfGrid({
			url : '${ctx}/fitting/preVerificationListData',
			sfHeader: defaultHeader,
			sfSortColumns: sortHeader,
            multiselect:true,
            autoWidth:false,
            rownumbers:true,
            gridComplete:function(){
            	_order_comm.gridNum();
            }
		});
	}

    function dofmtOldOrigin(s) {
        if ("1" == s) {
            return "是";
        } else if ("2" == s) {
            return "否";
        }
        return "";
    }

    function judgeTabV(result) {
        var firstV = -1;
        if (!result.oldFitting) {
            $(".tabswitch-tab").eq(0).hide();
        } else {
            firstV = 0;
        }
        if (firstV == -1) {
            firstV = 1;
        }
        if (!result.order&&!result.order400Rd) {
            $(".tabswitch-tab").eq(2).hide();
        }
        $(".tabswitch-tab").eq(firstV).show().trigger('click');
    }

    function cancel() {
		$('.hxbox').find(".closePopup").trigger('click');
	}
    function batchcancel() {
		$('.batchhxbox').find(".closePopup").trigger('click');
	}

	// 入库
	//通过申请
	var adpoting = false;
	function stock() {
		if(adpoting) {
		    return;
	    }
		adpoting = true;
		$.ajax({
			type: "POST",
			url: "${ctx}/fitting/stockOldFitting",
			data: {
				id: $("#vid").val() // 注意这里是核销id
			},
			success: function (data) {
				if ("200" == data.code) {
					layer.msg("旧件已入库");
				}
			},
            complete: function() {
                adpoting = false;
            }
		});
	}

	// 保存零售信息
	//通过申请
	var adpotin = false;
	function saveSaleInfo() {
		if(adpotin) {
		    return;
	    }
	    if(iaBlank($("#hxType").val())){
			layer.msg("请选择核销类型");
			return;
		}
		adpotin = true;
		var flag = ($(".radiobox").eq(0).hasClass("radiobox-selected")) ? "1" : "0";
		$.ajax({
			type: "POST",
			url: "${ctx}/fitting/saveCollection",
			data: {
				id: $("#vid").val(), // 注意这里是核销id
				money: $("#f_confirmed_money").val(),
				flag: flag,
                hxType:$("#hxType").val() //核销类型
			},
			success: function (data) {
				if ("200" == data.code) {
					layer.msg("保存成功");
				} else if ("802" == data.code) {
					layer.msg("确认金额不正确");
				} else if("801" == data.code) {
					layer.msg("保存失败");
				}
			},
            complete: function() {
                adpotin = false;
            }
		});
	}

	function iaBlank(val){
		if(val=='' || val==null || val==undefined){
			return true;
		}else{
		    return false;
		}
	}

	function verify(id) {
        $(".orderInf").removeClass("current");
        $(".fitInf").addClass("current");
        $(".oldFitInf").removeClass("current");
        $(".fittingInfo").show();
        $(".gongdanInfo").hide();
        $(".oldFittingInfo").hide();


        $("#popupForm").get(0).reset();
		var tabs = $(".tabswitch-tab");
		var imgs = $(".imgbox img");
        tabs.removeClass("current").show();
        tabs.eq(0).addClass("current");
		imgs.eq(0).attr("src", "${ctxPlugin}/static/h-ui.admin/images/img-default.png");
		imgs.eq(1).attr("src", "${ctxPlugin}/static/h-ui.admin/images/img-default.png");
		$(".radiobox").removeClass("radiobox-selected").eq(0).addClass("radiobox-selected");

        $.getJSON("${ctx}/fitting/verification?id=" + id, function (result) {
        	$("#f_collect_money").val(result.verification.collectionMoney);
        	$("#f_confirmed_money").val(result.verification.confirmedMoney);
			$("#vid").val(result.verification.id);
			var _hxType = "";
			if(isBlank(result.verification.confirmType)){
                if("1"==result.verification.type){
                    if("0"==result.verification.collectionFlag){//0未收款
                        $("#hxType").val("1");
                        _hxType = "1";
                    }else if("1"==result.verification.collectionFlag){//1已收款
                        $("#hxType").val("2");
                        _hxType = "2";
                    }else{
                        $("#hxType").val("1");
                        _hxType = "1";
                    }
                }else if("2"==result.verification.type){
                    $("#hxType").val("");
                } else if("3"==result.verification.type){
                    $("#hxType").val("3");
                    _hxType = "3";
                } else if("4"==result.verification.type){
                    $("#hxType").val("4");
                    _hxType = "4";
                }
            }else{
                $("#hxType").val(result.verification.confirmType);
                _hxType = result.verification.confirmType;
			}
			if(_hxType === "1") {
                $(".radiobox").eq(1).click();
			}
			if (result.verification.oldFittingFlag) {
				$("#f_return_old").val(result.verification.oldFittingFlag == '0' ? '不需要' : '需要');
			}
            if (result.fitting) {
                var fitting = result.fitting;
                $("#f_code").val(fitting.code);
                $("#f_name").val(fitting.name);
                $("#f_version").val(fitting.version);
                $("#f_used_num").val(result.verification.usedNum);
                $("#f_img").val(result.fitting.img);
                $("#f_type").val(fmtVerificationType({type: result.verification.type,collection_flag: result.verification.collectionFlag}));
                $("#appearPhoto").attr("src",'${commonStaticImgPath}'+result.fitting.img);
            }

            if (result.oldFitting) {
                $(".oldFitInf").show();
                var oldFitting = result.oldFitting;
				var oldStatus = fmtOldStatus({old_status: oldFitting.status});
//                $("#f_return_old").val(oldStatus);
                $("#f_old_status2").val(oldStatus);
                $("#f_old_code").val(oldFitting.code);
                $("#f_old_name").val(oldFitting.name);
                $("#f_old_version").val(oldFitting.version);
                $("#f_old_brand").val(oldFitting.brand);
                $("#f_old_img").val(oldFitting.img);
                $("#f_old_origin").val(dofmtOldOrigin(oldFitting.yrpz_flag));
                $("#oldImg").attr("src",'${commonStaticImgPath}'+oldFitting.img);
            }

			if(isBlank(result.oldFitting)){
                $(".oldFitInf").hide();
			}

            if(result.order) {
                $(".orderInf").show();
                var order = result.order;
                $("#f_order_no").val(order.columns.number);
                $("#f_customer_name").val(order.columns.customer_name);
                $("#f_tel").val(order.columns.customer_mobile);
                var c = order.columns.appliance_category ? order.columns.appliance_category : "";
                var b = order.columns.appliance_brand ? order.columns.appliance_brand : "";
                $("#f_appliance").val(b+c);
                $("#f_order_status").val(fmtOrderStatusTxt({status:order.columns.status}));
            } else if(result.order400Rd) {
                $(".orderInf").show();
				var order400 = result.order400Rd;
				$("#f_order_no").val(order400.number);
				$("#f_customer_name").val(order400.customer_name);
				$("#f_tel").val(order400.customer_mobile);
				c = order400.appliance_category ? order400.appliance_category : "";
				b = order400.appliance_brand ? order400.appliance_brand : "";
				$("#f_appliance").val(b+c);
				$("#f_order_status").val(order400.status);
			}

            if(isBlank(result.order)){
                $(".orderInf").hide();
            }

            judgeTabV(result);
			$('.hxbox').popup();
        });
    }

function isBlank(val) {
    if(val==null || val=='' || val == undefined) {
        return true;
    }
    return false;
}
    function joins(arr) {
        var arr2 = [];
        for(var i=0,j=0;i<arr.length;i++) {
            if(arr[i]) {
                arr2[j++] = arr[i];
            }
        }
        return arr2.join("/");
    }

    function markCount() {
		$.post("${ctx}/fitting/verificationMarkerCount",function(result){
			$("#tab_c1").text(result.t1);
			/*$("#tab_c2").text(result.t2);*/
		});
	}

	var verifying = false;
	// 核销
	function confirmVerification() {
		if (verifying) {
			return;
		}
        if(iaBlank($("#hxType").val())){
            layer.msg("请选择核销类型");
            return;
        }
		verifying = true;
        var flag = ($(".radiobox").eq(0).hasClass("radiobox-selected")) ? "1" : "0";
        $.ajax({
			type: "POST",
			url: "${ctx}/fitting/verify",
			data: {
				id: $("#vid").val(), // 注意这里是核销id
                money: $("#f_confirmed_money").val(),
                flag: flag,
                hxType:$("#hxType").val() //核销类型
			},
			success: function (data) {
				if ("200" == data.code) {
					search();
					markCount();
					layer.msg("核销成功");
					cancel();
				} else {
					layer.msg("保存失败");
				}
			},
			complete: function () {
				verifying = false;
			}
		});
	}
	
	$('#spimg1').imgShow();
	$('#spimg2').imgShow();
	
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

var onRefusing = false;

function refuseHx() {
    if (onRefusing) {
        return;
    }
    onRefusing = true;

    $('body').popup({
        level:3,
        title:"确认拒绝",
        content:"确认要拒绝本次核销吗？",
        fnConfirm :function(){
            $.ajax({
                type: "POST",
                url: "${ctx}/fitting/verifyRefused",
                data: {
                    id: $("#vid").val() // 注意这里是核销id
                },
                success: function (data) {
                    search();
                    layer.msg("核销通知已发送");
                    cancel();
                },
                complete: function () {
                    onRefusing = false;
                }
            });
        },
		fnCancel: function() {
            onRefusing = false;
		}
    });
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
                location.href="${ctx}/fitting/export?formPath=/a/fitting/preVerificationList&&maps="+$("#searchForm").serialize();
            }

        });
    }else{
        location.href="${ctx}/fitting/export?formPath=/a/fitting/preVerificationList&&maps="+$("#searchForm").serialize();
    }

}

</script>
</body>
</html>

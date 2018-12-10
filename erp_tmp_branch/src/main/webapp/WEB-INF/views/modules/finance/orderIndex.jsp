<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

	<meta name="decorator" content="base" />
	<!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
	<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css" />
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<style type="text/css">
		.has-switch {
			min-width: 70px;
		}

		.has-switch span, .has-switch label {
			padding-top: 0;
			padding-bottom: 0;
			line-height: 22px;
			height: 22px;
		}

	</style>
</head>

<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
		<div class="page-orderWait" style="padding-bottom: 0">
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx}/finance/revenue/order">工单收支明细</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_SEEDETAIL_TAB" html='<a class="btn-tabBar " href="${ctx}/finance/revenue/toEmployeDetail">工程师结算明细</a>'></sfTags:pagePermission>

				<p class="f-r btnWrap">
					<a href="javascript:search();" class="sfbtn sfbtn-opt">
						<i class="sficon sficon-search"></i>
						查询
					</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch">
						<i class="sficon sficon-moresearch"></i>
						更多查询
					</a>
					<a href="javascript:reset();" class="sfbtn sfbtn-opt resetSearchBtn" id="reset">
						<i class="sficon sficon-reset"></i>
						重置
					</a>
				</p>
			</div>
			<div class='mb-10'>
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAILS_TAB" html='<a class="mr-15 active__" href="${ctx}/finance/revenue/order">工单收支明细</a>'></sfTags:pagePermission>
				<span class='line_'></span>
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_GOODSREVENUEDETAIL_TAB" html='<a class="ml-15" href="${ctx}/finance/revenue/orderJSCount">工单结算统计</a>'></sfTags:pagePermission>

			</div>
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<input type="hidden" name="siteId" id="siteId" value="${siteId }">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name="number" />
							</td>
							<th style="width: 76px;" class="text-r">保修类型：</th>
							<td>
									<span class="select-box">

										<select class="select" name="warrantyType" value="${map.warrantyType }">
											<option value="">请选择</option>
											<option value="1" <c:if test="${map.warrantyType eq 1 }">selected="selected"</c:if>>保内</option>
											<option value="2" <c:if test="${map.warrantyType eq 2 }">selected="selected"</c:if>>保外</option>
											<%-- <option value="3" <c:if test="${map.warrantyType eq 3 }">selected="selected"</c:if>>保内转保外</option> --%>
										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">家电品牌：</th>
							<td>
								<input type="text" class="input-text" name="applianceBrand" value="${map.applianceBrand }" />
							</td>
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
								<input type="text" class="input-text" name="applianceCategory" value="${map.applianceCategory }" />
							</td>
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
									<span class="">
										<select class="select select-box" name="employeName" id="employeName" value="${map.employeName }">
											<option value="">请选择</option>
											<c:forEach items="${employeList }" var="emList">
												<option value="${emList.columns.id }" <c:if test="${map.id == emList.columns.name }">selected="selected"</c:if>>${emList.columns.name }<c:if
														test="${emList.columns.status=='3' }">（已离职）</c:if></option>
											</c:forEach>
										</select>
									</span>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">信息来源：</th>
							<td>
									<span class="select-box">
										<select class="select" name="origin">
											<option value="">请选择</option>
											<c:forEach items="${listorigin }" var="lro">
												<option value="${lro.columns.name }">${lro.columns.name }</option>
											</c:forEach>

										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">工单来源：</th>
							<td>
								<select class="select" name="orderType" style="width: 140px;">
									<option value="">请选择</option>
									<c:forEach items="${fns:getOrderTypeList() }" var="ot">
										<option value="${ot.columns.id }">${ot.columns.name }</option>
									</c:forEach>
								</select>
							</td>
							<th style="width: 76px;" class="text-r">交款信息：</th>
							<td>
								<span class="select-box">
									<select class="select" name="whetherCollection">
										<option value="">请选择</option>
										<option value="1">已交款</option>
										<option value="0">未交款</option>
										<option value="3">无交款</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">是否结算：</th>
							<td>
								<span class="select-box">
									<select class="select" name="settleJiesuan">
										<option value="">请选择</option>
										<option value="1">是</option>
										<option value="0">否</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName"/>
							</td>


						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name="customerMobile" />
							</td>
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
									<span class="select-box">
										<select class="select" name="serviceType">
											<option value="">请选择</option>
											<c:forEach items="${fns:getNewServiceType() }" var="stype">
												<option value="${stype.columns.name }">${stype.columns.name }</option>
											</c:forEach>
										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">结算审核：</th>
							<td>
									<span class="select-box">
										<select class="select" name="review">
											<option value="">请选择</option>
											<option value="0">未审核</option>
											<option value="1">审核通过</option>
											<option value="2">审核未通过</option>
										</select>
									</span>
							</td>
							<td colspan="4">
								<label class="text-r lb">完工时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="endTimeMin" name="endTimeMin" value="${map.endTimeMin }"
									   class="input-text Wdate w-120" style="width: 120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="endTimeMax" name="endTimeMax" value="${map.endTimeMax }"
									   class="input-text Wdate w-120" style="width: 120px">
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<td colspan="10">
								<label class="ml-15">报修时间：</label>
								<input type="text" onfocus="WdatePicker({onpicking: cDayFuncmin,maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"
									   value="${map.repairTimeMin }" class="input-text Wdate w-120" style="width: 120px" readonly>
								至
								<input type="text" onfocus="WdatePicker({onpicking: cDayFuncmax,minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="repairTimeMax" name="repairTimeMax"
									   value="${map.repairTimeMax }" class="input-text Wdate w-120" style="width: 120px" readonly>
								<label class="ml-15">结算归属时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')}'})" id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-120"
									   style="width: 120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}'})" id="createTimeMax" name="createTimeMax" value="" class="input-text Wdate w-120"
									   style="width: 120px">
								<label class="pl-10 ml-10">结算审核时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'reviewTimeMax\')}'})" id="reviewTimeMin" name="reviewTimeMin" value="" class="input-text Wdate w-120"
									   style="width: 120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'reviewTimeMin\')}'})" id="reviewTimeMax" name="reviewTimeMax" value="" class="input-text Wdate w-120"
									   style="width: 120px">

							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">交款时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'payTimeMax\')||\'%y-%M-%d\'}'})" id="payTimeMin" name="payTimeMin" class="input-text Wdate w-120"
									   style="width: 120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'payTimeMin\')}',maxDate:'%y-%M-%d'})" id="payTimeMax" name="payTimeMax" class="input-text Wdate w-120"
									   style="width: 120px">
							</td>
						</tr>

					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<%-- <sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_SEEDETAIL_BTN"
                        html='<a onclick="seeDetail()"class="sfbtn sfbtn-opt" target="_blank"><i class="sficon sficon-checkgcsmx"></i>查看工程师结算明细</a>'></sfTags:pagePermission> --%>

					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_JIESUANSH_BTN"
										   html='<a onclick="batchreview()"class="sfbtn sfbtn-opt" target="_blank"><i class="sficon sficon-jssh"></i>结算审核</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_EXPORT_BTN"
										   html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn">
						<i class="sficon sficon-setting"></i>
						表头设置
					</a>
					<%-- <a href="${ctx}/order/export?formPath=/a/order/Whole" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a> --%>
				</div>
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
				<div class="cl pt-5">
					<!-- <div class="f-l w-300">
                        <div class="f-l w-150"><stong class="" style="font-weight: 600">厂家结算：<span class="c-0383dc " id="factory_money_all">11</span>元</stong></div>
                    <div class="f-l w-150"><stong class="" style="font-weight: 600">结算支出：<span class="c-0383dc" id="sum_money_all">11</span>元</stong></div>
                    <div class="f-l w-150"><stong class="" style="font-weight: 600">当日支付：<span class="c-0383dc " id="payment_amount_all">11</span>元</stong></div>
                    <div class="f-l w-150"><stong class="" style="font-weight: 600">利润：<span class="c-0383dc " id="profits_all">11</span>元</stong></div>

                    </div> -->
					<div class="f-r">
						<div class="pagination"></div>
					</div>
				</div>
				<!-- pagination -->
			</div>

		</div>

	</div>
</div>

<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">提示</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要
				<span class="c-bb3906">开通VIP会员</span>
				后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
			</div>
		</div>
	</div>
</div>


<div class="popupBox  w-660 spromptBox">
	<h2 class="popupHead">
		结算审核
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15 f-14">
			<div class="pos-r pl-80">
				<label class="lb w-80 text-r">审核备注：</label>
				<textarea class="textarea" style="height: 160px;" id="reviewRemark1"></textarea>

			</div>
			<div class="text-c mt-30 mb-5">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-100 mr-5  passre" id="btn-confirm">审核通过</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-100 falidre">审核不通过</a>
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

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    slowlyLoading();

    $('#btn-add').click(function() {
        layer.open({
            type : 2,
            content : '	${ctx}/order/unit/form',
            title : false,
            area : [ '100%', '100%' ],
            closeBtn : 0,
            shade : 0,
            anim : -1
        })
    })
    var sfGrid;

    var id = '${headerData.id}'; //服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}'; //系统表格的ID
    $('#setHeadersBtn').click(function() {
        $('.addHeaders').tableHeaderSetting({
            id : id,
            defaultId : defaultId,
            sfHeader : defaultHeader,
            sfSortColumns : sortHeader,
            tableHeaderSaveUrl : '${ctx}/operate/site/saveTableHeader'
        }).popup();
    });

    $(function() {

        $.post("${ctx}/goods/sitePlatformGoods/distinct", function (result) {
            if (result == "showPopup") {

                $(".vipPromptBox").popup();
                $('#Hui-article-box', window.top.document).css({'z-index': '9'});
            }
        });

        $('#repairTimeMin').bind('blur', function() {
            dealRepairTime();
        })
        $('#repairTimeMax').bind('blur', function() {
            dealRepairTime();
        })
        $.tabfold("#moresearch", ".moreCondition", 1, "click");
        initSfGrid();
        //summoney();
        $('#employeName').select2();
        //2.监听父层按钮的动作
        $('#pngfix-nav-btn', parent.document).click(function() {
            //3.给定一个时间点
            setTimeout(function() {
                //4.再次执行全屏
                layer.restore(full_idx);
            }, 200);
        });

        $(".selection").css("width", "140px");
    });

    function isBlank(val) {
        if (val == null || $.trim(val) == '' || val == undefined) {
            return true;
        }
        return false;
    }

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid() {
        dealRepairTime();
        var url = "${ctx}/finance/revenue/orderList";
        sfGrid = $("#table-waitdispatch").sfGrid({
            url : url,
            sfHeader : defaultHeader,
            sfSortColumns : sortHeader,
            postData : $("#searchForm").serializeJson(),
            //shrinkToFit: true,
            multiselect : true,
            rownumbers : true,
            gridComplete : function() {
                _order_comm.gridNum();
            },
            loadComplete : function(data) {
                layer.closeAll();
                var header = sortHeader;
                if (isBlank(header)) {
                    header = dealHeader(defaultHeader);
                }
                returnObject(header);
            }
        });
    }

    function dealHeader(dt) {
        var name = "";
        for (var i = 0; i < dt.length; i++) {
            var val = dt[i].name;
            if (isBlank(name)) {
                name = val;
            } else {
                name += "," + val;
            }
        }
        return name;
    }

    function returnObject(sortHeader) {
        var objMny = {};
        $.ajax({
            type : "post",
            url : "${ctx}/finance/revenue/orderListCountMoney",
            //async : false,
            data : $("#searchForm").serializeJson(),
            success : function(data) {
                var dt = data.columns;
                var allCosts = (parseFloat(dt.serve_cost_count) + parseFloat(dt.auxiliary_cost_count) + parseFloat(dt.warranty_cost_count)).toFixed(2);
                objMny = {
                    serve_cost_count : !isBlank(dt.serve_cost_count) ? (dt.serve_cost_count).toFixed(2):0.00,
                    auxiliary_cost_count : !isBlank(dt.auxiliary_cost_count) ? (dt.auxiliary_cost_count).toFixed(2):0.00,
                    warranty_cost_count : !isBlank(dt.warranty_cost_count) ? (dt.warranty_cost_count).toFixed(2):0.00,
                    confirm_cost_count : dt.confirm_cost_count != "" ? (dt.confirm_cost_count).toFixed(2):0.00,
                    callback_cost_count : dt.callback_cost_count != "" ? (dt.callback_cost_count).toFixed(2):0.00,
                    costs_count : allCosts,
                    factory_money_count : dt.factory_money_count != "" ?(dt.factory_money_count).toFixed(2):0.00,
                    profits_count : dt.profits_count != "" ? (dt.profits_count).toFixed(2):0.00,
                    sum_money_count : dt.sum_money_count != "" ? (dt.sum_money_count).toFixed(2) :0.00,
                    payment_amount_count : dt.payment_amount_count != "" ? (dt.payment_amount_count).toFixed(2): 0.00,
                    fitting_costs_count : dt.fitting_costs_count != "" ? (dt.fitting_costs_count).toFixed(2) : 0.00
                };
                var arr = sortHeader.split(",");
                var obj = {};//"id":"合计"
                for (var i = 0; i < arr.length; i++) {
                    var name = arr[i];
                    var obj1 = {};
                    var val = "— —";
                    if (i == 0) {
                        val = "合计";
                    }
                    if (name == 'serve_cost') {
                        val = objMny.serve_cost_count;
                    }
                    if (name == 'auxiliary_cost') {
                        val = objMny.auxiliary_cost_count;
                    }
                    if (name == 'warranty_cost') {
                        val = objMny.warranty_cost_count;
                    }
                    if (name == 'confirm_cost') {
                        val = objMny.confirm_cost_count;
                    }
                    if (name == 'callback_cost') {
                        val = objMny.callback_cost_count;
                    }
                    if (name == 'costs') {
                        val = objMny.costs_count;
                    }
                    if (name == 'factory_money') {
                        val = objMny.factory_money_count;
                    }
                    if (name == 'profits') {
                        val = objMny.profits_count;
                    }
                    if (name == 'sum_money') {
                        val = objMny.sum_money_count;
                    }
                    if (name == 'payment_amount') {
                        val = objMny.payment_amount_count;
                    }
                    if (name == 'fitting_costs') {
                        val = objMny.fitting_costs_count;
                    }
                    obj1[name] = val;
                    obj = $.extend(obj, obj1);
                    ;
                }
                $("#table-waitdispatch").addRowData("1", obj, "last");
                $("#table-waitdispatch_frozen").find("#1").find("td").eq(0).addClass("hide");
                $("#table-waitdispatch_frozen").find("#1").find("td").eq(1).addClass("hide");
                $("#table-waitdispatch_frozen").find("#1").find("td").eq(2).attr("colspan", "5").css("background-color", "#ddd");
                $("#table-waitdispatch_frozen").find("#1").find("td").eq(3).addClass("hide");
                $("#table-waitdispatch_frozen").find("#1").find("td").eq(4).addClass("hide");
                //加底色
                $("#table-waitdispatch").find("#1").find("td").each(function(){
                    var val = $(this).attr("title");
                    if(val!='合计' && val!='— —'){
                        $(this).css("background-color", "#ffeedd");
                    }
                })
            }
        });
    }

    //保修类型
    function protectType(row) {
        if (row.id == "合计") {
            return "— —";
        }
        if (row.warranty_type == '1') {
            return "保内";
        } else if (row.warranty_type == '2') {
            return "保外";
        } else if (row.warranty_type == '3') {
            return "保外转保内";
        } else {
            return "---";
        }
    }

    function brandCategory(row) {
        if (row.id == '合计') {
            return "— —";
        }
        if (row.appliance_brand != null && row.appliance_category == null) {
            return row.appliance_brand;
        } else if (row.appliance_brand == null && row.appliance_category != null) {
            return row.appliance_category;
        } else if (row.appliance_brand != null && row.appliance_category != null) {
            return row.appliance_brand + row.appliance_category;
        } else {
            return "";
        }

    }
    //交款总额
    function handSomeMony(rowData) {
        var som = (parseFloat(rowData.serve_cost) + parseFloat(rowData.auxiliary_cost) + parseFloat(rowData.warranty_cost)).toFixed(2);
        return som;
    }

    //是否交款
    function sureHandMony(row) {
        if (row.id == '合计') {
            return "— —";
        }
        var som = row.serve_cost + row.auxiliary_cost + row.warranty_cost;

        if (row.whether_collection == '0' && som > 0) {
            return "未交款";
        } else if (row.whether_collection == '0' && som == 0) {
            return "无交款";
        } else if (row.whether_collection == '1') {
            return "已交款";
        } else {
            return "---";
        }
    }

    //是否结算
    function sureJiesuan(row) {
        if (row.id == '合计') {
            return "— —";
        }
        if ($.trim(row.settlement_time) != '' && row.settlement_time != null) {
            return "是";
        }
        return "否";
    }

    //结算审核
    function reviewOper(rowData) {
        if (rowData.review == '0' || rowData.review == null) {
            if (rowData.settl == 0) {
                return '<span class="c-0383dc oState state-waitSettlement w-80">未结算</span>';
            } else {
                return '<span class="c-0383dc oState state-waitVerify2 w-80">未审核</span>';
            }
        } else if (rowData.review == '1') {
            return '<span style="color:gray" class="oState state-finished w-80">审核通过</span>';
        } else {
            return '<span style="color:red" class="oState state-verify2nopass w-80">审核不通过</span>';
        }
    }

    //操作
    function fmtOper2(rowData) {
        if (rowData.id == "合计") {
            return "<span class='c-0383dc'>合 计</span>";
        }
        if ('${fns:checkBtnPermission("FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_SHENHE_BTN")}' === 'true') {
            return '<a onclick="openshenhe(\'' + rowData.id + '\',\'' + rowData.settl + '\',\'' + rowData.migration + '\');" class="oState state-verify c-0383dc">审核</a>';
        }
        return '';
    }

    //工单来源
    function orderTypeSource(row) {
        if (row.id == '合计') {
            return "— —";
        }
        if (row.order_type == '1') {
            return "ERP系统录入";
        } else if (row.order_type == '2') {
            return "美的厂家系统";
        } else if (row.order_type == '3') {
            return "惠而浦厂家系统";
        } else if (row.order_type == '4') {
            return "海信厂家系统 ";
        } else if (row.order_type == '5') {
            return "海尔厂家系统";
        } else {
            return "---";
        }
    }

    function typesLook(rowData) {
        if (rowData.type == 'i') {
            return "<span>整数</span>"
        } else {
            return "<span>实数</span>"
        }
    }

    function fmtOper(rowData) {
        return "<span><a href=javascript:updateMsg('" + rowData.id + "')>修改</a></span><span><a href=javascript:deleteMsg('" + rowData.id + "')>删除</a></span>";
    }

    function search() {
        if (!dealRepairTime()) {
            return;
        }
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData : $("#searchForm").serializeJson()
        });
        summoney();
    }
    function reset() {
        $("#repairTimeMin").val('${firstDate }');
        $("#repairTimeMax").val('${lastDate }');
        $("#endTimeMin").val('');
        $("#endTimeMax").val('');
        $("#employeName").select2('val', '请选择');
    }
    function exports() {
        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup({
                level : 3,
                title : "导出",
                content : content,
                fnConfirm : function() {
                    location.href = "${ctx}/finance/revenue/order/export?formPath=/a/finance/revenue/order&&maps=" + $("#searchForm").serialize();
                }

            });
        } else {
            location.href = "${ctx}/finance/revenue/order/export?formPath=/a/finance/revenue/order&&maps=" + $("#searchForm").serialize();
        }

    }

    function ordernumberOper(rowData) {
        var orderNo = rowData.number || '';
        return '<a href="javascript:showDetail(\'' + orderNo + '\',\'' + rowData.migration + '\');" class="c-0383dc">' + orderNo + '</a>';
    }

    function showDetail(orderNo, migration) {
        layer.open({
            type : 2,
            content : '${ctx}/order/orderDispatch/orderDetailForm?orderNo=' + orderNo + '&migration=' + migration,
            title : false,
            area : [ '100%', '100%' ],
            closeBtn : 0,
            shade : 0,
            fadeIn : 0,
            anim : -1
        });
    }

    function jumpToVIP() {
        layer.open({
            type : 2,
            content : '${ctx}/goods/sitePlatformGoods/jumpVIP',
            title : false,
            area : [ '100%', '100%' ],
            closeBtn : 0,
            shade : 0,
            anim : -1
        });
    }

    function seeDetail() {
        layer.open({
            type : 2,
            content : '${ctx}/finance/revenue/toEmployeDetail',
            title : false,
            area : [ '100%', '100%' ],
            closeBtn : 0,
            shade : 0,
            anim : -1
        });
    }
    //弹出审核弹出框
    function openshenhe(id, settl, migration) {
        if (settl == 0) {
            layer.msg("该工单尚未结算，请结算后再审核！", {
                time : 3000
            });
            return;
        }
        var url = "${ctx}/finance/revenue/showSettlementdetaile?id=" + id;
        layer.open({
            type : 2,
            content : url,
            title : false,
            area : [ '100%', '100%' ],
            closeBtn : 0,
            shade : 0,
            anim : -1
        });

    }

    function summoney() {
        dealRepairTime();
        $.ajax({
            type : "POST",
            url : "${ctx}/finance/revenue/getSummoney",
            traditional : true,
            data : $("#searchForm").serializeJson(),
            success : function(data) {
                if (data.columns.dataMark == '420') {
                    $("#profits_all").html("0.00");
                    $("#factory_money_all").html("0.00");
                    $("#sum_money_all").html("0.00");
                    $("#payment_amount_all").html("0.00");
                    return;
                }
                if (data.columns.profits == "" || data.columns.profits == null) {
                    $("#profits_all").html("0.00");
                } else {
                    $("#profits_all").html(data.columns.profits);
                }
                if (data.columns.factory_money == "" || data.columns.factory_money == null) {
                    $("#factory_money_all").html("0.00");
                } else {
                    $("#factory_money_all").html(data.columns.factory_money);
                }
                if (data.columns.sum_money == "" || data.columns.sum_money == null) {
                    $("#sum_money_all").html("0.00");
                } else {
                    $("#sum_money_all").html(data.columns.sum_money);
                }
                if (data.columns.payment_amount == "" || data.columns.payment_amount == null) {
                    $("#payment_amount_all").html("0.00");
                } else {
                    $("#payment_amount_all").html(data.columns.payment_amount);
                }

            }
        });

    }

    function batchreview() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        var i = 0;
        var j = 0;
        $.each(idArr, function(index, value) {
            var val = $('#table-waitdispatch').jqGrid("getRowData", value);
            var view = val.review;
            if (view == '审核通过' || view == '审核不通过') {
                i++;
            } else if (view == '未结算') {
                j++;
            }
        });
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {
            if (parseInt(j) > 0) {
                var content = "您选择的记录中有" + j + "条未结算，请结算后再审核！";
                $('body').popup({
                    level : '3',
                    type : 2,
                    title : "审核",
                    content : content,
                    fnConfirm : function() {

                    },
                });
            } else if (parseInt(i) > 0) {
                var content = "您选择的记录中有" + i + "条已审核，您确认要继续操作吗";
                $('body').popup({
                    level : '3',
                    type : 2,
                    title : "审核",
                    content : content,
                    fnConfirm : function() {
                        $('.spromptBox').popup();
                    },
                });
            } else {
                $('.spromptBox').popup();

            }

        }

    }

    $(".passre").click(function() {
        var reviewRemark = $("#reviewRemark1").val();
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        var rowData = $('#table-waitdispatch').jqGrid("getRowData", idArr[0]);
        var url = "${ctx}/finance/revenue/reviewPass";
        <%--if (rowData.migration == '2017') {--%>
        <%--url = "${ctx}/finance/revenue/reviewPass2017";--%>
        <%--}--%>
        $.ajax({
            type : "POST",
            url : url,
            traditional : true,
            data : {
                "id" : idArr,
                "reviewRemark" : reviewRemark
            },
            success : function(data) {
                if (data == "ok") {
                    layer.msg('操作成功!');
                    $.closeDiv($('.spromptBox'));
                    $("#table-waitdispatch").trigger("reloadGrid");
                    //window.location.reload(true);
                } else {
                    layer.msg('操作失败!');
                }
            },
            complete : function() {
                $("#reviewRemark1").val("");
                $("#reviewRemark2").val("");
            }
        });

    })

    $(".falidre").click(function() {
        var reviewRemark = $("#reviewRemark1").val();
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        var rowData = $('#table-waitdispatch').jqGrid("getRowData", idArr[0]);
        var url = "${ctx}/finance/revenue/reviewFailed";
        <%--if (rowData.migration == '2017') {--%>
        <%--url = "${ctx}/finance/revenue/reviewFailed2017";--%>
        <%--}--%>
        $.ajax({
            type : "POST",
            url : url,
            traditional : true,
            data : {
                "id" : idArr,
                "reviewRemark" : reviewRemark
            },
            success : function(data) {
                if (data == "ok") {
                    layer.msg('操作成功!');
                    $.closeDiv($('.spromptBox'));
                    $("#table-waitdispatch").trigger("reloadGrid");
                } else {
                    layer.msg('操作失败!');
                }
            },
            complete : function() {
                $("#reviewRemark1").val("");
                $("#reviewRemark2").val("");
            }
        });

    })

    $('.btn-retract').on('click', function() {
        var target = $(this).closest('.retractWrap').find('.retractBox');
        if (target.is(':visible')) {
            $(this).find('.Hui-iconfont').removeClass('Hui-iconfont-arrow2-bottom').addClass('Hui-iconfont-arrow2-top');
            target.hide();
        } else {
            $(this).find('.Hui-iconfont').removeClass('Hui-iconfont-arrow2-top').addClass('Hui-iconfont-arrow2-bottom');
            target.show();
        }
    });

    $('#btn-dayPay').on('click', function() {
        if ($('#daypayBox').is(':visible')) {
            $('#daypayTotal').hide();
            $('#daypayBox').hide();
            $(this).find('.label-cbox2').removeClass('label-cbox2-selected');
        } else {
            $('#daypayTotal').show();
            $('#daypayBox').show();
            $(this).find('.label-cbox2').addClass('label-cbox2-selected');
        }

    });

    function dealRepairTime() {
        var repairTimeMin = $("#repairTimeMin").val();
        var repairTimeMax = $("#repairTimeMax").val();
        if (isBlank(repairTimeMin)) {
            layer.msg("报修时间查询起始时间不能为空！");
            return false;
        }
        if (isBlank(repairTimeMax)) {
            layer.msg("报修时间查询结束时间不能为空！");
            return false;
        }
        if (repairTimeMin.substring(0, 4) != repairTimeMax.substring(0, 4)) {
            layer.msg("报修时间查询不能跨年！");
            return false;
        }
        return true;

    }

    function dealRepairTimeOne(dp, type) {
        if (type == 'min') {
            var repairTimeMax = $("#repairTimeMax").val();
            if (isBlank(dp)) {
                layer.msg("报修时间查询起始时间不能为空！");
                return false;
            }
            if (isBlank(repairTimeMax)) {
                layer.msg("报修时间查询结束时间不能为空！");
                return false;
            }
            if (dp.substring(0, 4) != repairTimeMax.substring(0, 4)) {
                layer.msg("报修时间查询不能跨年！");
                return false;
            }
            return true;
        } else {
            var repairTimeMin = $("#repairTimeMin").val();
            if (isBlank(repairTimeMin)) {
                layer.msg("报修时间查询起始时间不能为空！");
                return false;
            }
            if (isBlank(dp)) {
                layer.msg("报修时间查询结束时间不能为空！");
                return false;
            }
            if (dp.substring(0, 4) != repairTimeMin.substring(0, 4)) {
                layer.msg("报修时间查询不能跨年！");
                return false;
            }
            return true;
        }
    }

    function cDayFuncmin(dp) {
        var date = dp.cal.getNewDateStr();
        dealRepairTimeOne(date, "min");
    }

    function cDayFuncmax(dp) {
        var date = dp.cal.getNewDateStr();
        dealRepairTimeOne(date, "max");
    }

    $(function(){
        tableHeight();

    })

    window.onresize = function(){
        tableHeight();
    }

    function tableHeight(){
        var tHeight = $('.sfpagebg').height()-254;
        $('#gview_table-waitdispatch').css({
            'max-height':tHeight+'px',
            /*   'overflow-y':'hidden', */
        });
    }
</script>
</body>
</html>
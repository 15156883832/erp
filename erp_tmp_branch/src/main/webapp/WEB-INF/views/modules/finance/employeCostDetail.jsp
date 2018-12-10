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
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_TAB" html='<a class="btn-tabBar " href="${ctx}/finance/revenue/order">工单收支明细</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_SEEDETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx}/finance/revenue/toEmployeDetail">工程师结算明细</a>'></sfTags:pagePermission>

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
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_DETAILED_TAB" html='<a class="mr-15 active__" href="${ctx}/finance/revenue/toEmployeDetail">工程师结算明细</a>'></sfTags:pagePermission>
				<span class='line_'></span>
				<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_ORDERREVENUEDETAIL_STATISTICS_TAB" html='<a class="ml-15 " href="${ctx}/finance/revenue/toEmpJSCount">工程师结算统计</a>'></sfTags:pagePermission>

			</div>
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<input type="hidden" name="siteId" id="siteId" value="${siteId }">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
									<span class="">
										<select class="select select-box" name="employeName" id="employeName" value="${map1.employeName }">
											<option value="">请选择</option>
											<c:forEach items="${empList }" var="emList">
												<option value="${emList.columns.id }" <c:if test="${map1.employeName == emList.columns.id }">selected="selected"</c:if>>${emList.columns.name }<c:if
														test="${emList.columns.status=='3' }">（已离职）</c:if></option>
											</c:forEach>
										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">结算审核：</th>
							<td>
									<span class="select-box">
										<select class="select w-140" name="review">
											<option value="">请选择</option>
											<option value="0">未审核</option>
											<option value="1">审核通过</option>
											<option value="2">审核未通过</option>
										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
									<span class="">
										<select class="select select-box" name="applianceCategory" id="applianceCategory" value="${map.applianceCategory }">
											<option value="">请选择</option>
											<c:forEach items="${category }" var="ca">
												<option value="${ca.columns.name }">${ca.columns.name }</option>
											</c:forEach>
										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">家电品牌：</th>
							<td>
									<span class="">
										<select class="select select-box" name="applianceBrand" id="applianceBrand" value="${map.applianceBrand }">
											<option value="">请选择</option>
											<c:forEach items="${brand }" var="ba" varStatus="sta">
												<option value="${ba.key }">${ba.value }</option>
											</c:forEach>
										</select>
									</span>
							</td>
						</tr>
						<tr >
							<th style="width: 76px;" class="text-r">保修类型：</th>
							<td>
									<span class="select-box">

										<select class="select" name="warrantyType" value="${map.warrantyType }">
											<option value="">请选择</option>
											<option value="1" <c:if test="${map.warrantyType eq 1 }">selected="selected"</c:if>>保内</option>
											<option value="2" <c:if test="${map.warrantyType eq 2 }">selected="selected"</c:if>>保外</option>
										</select>
									</span>
							</td>
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
									<span class="select-box">
										<select class="select" name="serviceType" id="serviceType">
											<option value="">请选择</option>
											<c:forEach items="${fns:getNewServiceType() }" var="stype">
												<option value="${stype.columns.name }">${stype.columns.name }</option>
											</c:forEach>
										</select>
									</span>
							</td>
							<td colspan="4">
								<label class="text-r " style="margin-left: -12px">结算归属日期：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'settlementTimeMax\')||\'%y-%M-%d\'}'})" id="settlementTimeMin" name="settlementTimeMin" value="${settlementTimeMin }" class="input-text Wdate  w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'settlementTimeMin\')}',maxDate:'%y-%M-%d'})" id="settlementTimeMax" name="settlementTimeMax" value="${settlementTimeMax }" class="input-text Wdate  w-140" style="width:140px">
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({onpicking: cDayFuncmin,maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin" value="${map1.repairTimeMin }" class="input-text Wdate  w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({onpicking: cDayFuncmax,minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="repairTimeMax" name="repairTimeMax" value="${map1.repairTimeMax }" class="input-text Wdate  w-140" style="width:140px">

							</td>
							<th style="width: 76px;" class="text-r">完工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="endTimeMin" name="endTimeMin" value="${endTimeMin }" class="input-text Wdate  w-140" style="width:140px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="endTimeMax" name="endTimeMax" value="${endTimeMax }" class="input-text Wdate  w-140" style="width:140px">

							</td>
						</tr>

					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l tabBarP2">
					<a class="radiobox radiobox-selected mr-15" onclick="huizong1()"  >明细</a>
					<a class="radiobox"  onclick="huizong()" >汇总</a>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="FINANCEMGM_SITEREVENUEDETAIL_EMPDETAILED_EXPORT_BTN"
										   html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<div class="cl pt-5">
					<div class="f-r">
						<div class="pagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
    slowlyLoading();

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

    $(function() {
        $.tabfold("#moresearch",".moreCondition",1,"click");
        $('#repairTimeMin').bind('blur', function() {
            dealRepairTime();
        })
        $('#repairTimeMax').bind('blur', function() {
            dealRepairTime();
        })
        initSfGrid();
        $('.dropdown-sin-2').dropdown({
            input : '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });

        $('#employeName').select2();
        $("#applianceCategory").select2();
        $("#applianceBrand").select2();
        $(".selection").css("width", "140px");

    })

    function huizong() {
        window.location.href = "${ctx}/finance/revenue/toCostAll?map=" + $("#searchForm").serialize();
        $('#Hui-article-box', window.top.document).css({
            'z-index' : '9'
        });
    }

    function huizong1() {
        window.location.href = "${ctx}/finance/revenue/toEmployeDetail?map=" + $("#searchForm").serialize();
        $('#Hui-article-box', window.top.document).css({
            'z-index' : '9'
        });
    }

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid() {

        //var tableHeight_ = $(window).height() - 400;
        dealRepairTime();
        var url = "${ctx}/finance/revenue/toEmployeDetailGrid";
        sfGrid = $("#table-waitdispatch").sfGrid({
            url : url,
            sfHeader : defaultHeader,
            sfSortColumns : sortHeader,
            postData : $("#searchForm").serializeJson(),
            //shrinkToFit: true,
            multiselect : false,
            /* width : 950,
            height : tableHeight_, */
            rownumbers : true,
            gridComplete : function() {
                _order_comm.gridNum();
            },
            loadComplete: function(data){
                layer.closeAll();
                var header = sortHeader;
                if(isBlank(sortHeader)){
                    header = dealHeader(defaultHeader);
                }
                returnObject(header);
            }
        });
    }

    function dealHeader(dt){
        var name = "";
        for(var i=0;i<dt.length;i++){
            var val = dt[i].name;
            if(isBlank(name)){
                name = val;
            }else{
                name +=","+ val;
            }
        }
        return name;
    }

    function returnObject(sortHeader){
        var objMny = {};
        $.ajax({
            type:"post",
            url:"${ctx}/finance/revenue/orderEmployeListCountMoney",
            //async:false,
            data:$("#searchForm").serializeJson(),
            success:function(data){
                var dt = data.columns;
                var needMny = (parseFloat(dt.deSumMoney_emp)-parseFloat(dt.drzgMny_emp)).toFixed(2);
                objMny = {
                    deSumMoney_emp:dt.deSumMoney_emp != ""?(dt.deSumMoney_emp).toFixed(2):0.00,
                    drzgMny_emp:dt.drzgMny_emp != "" ? (dt.drzgMny_emp).toFixed(2):0.00,
                    needMny:needMny
                };
                var arr = sortHeader.split(",");
                var obj = {};//"id":"合计"
                for(var i=0;i<arr.length;i++){
                    var name = arr[i];
                    var obj1 = {};
                    var val="— —";
                    if(i==0){
                        val = "合计";
                    }
                    if(name=='deSumMoney'){
                        val = objMny.deSumMoney_emp;
                    }
                    if(name=='drzgMny'){
                        val = objMny.drzgMny_emp;
                    }
                    if(name=='needMny'){
                        val = objMny.needMny;
                    }
                    obj1[name] = val;
                    obj=$.extend(obj,obj1);;
                }
                $("#table-waitdispatch").addRowData("tt", obj, "last");
                $("#table-waitdispatch_frozen").find("#tt").find("td").eq(0).addClass("hide");//background-color: #ffeedd
                $("#table-waitdispatch_frozen").find("#tt").find("td").eq(1).attr("colspan","2").css("background-color","#ddd");
                $("#table-waitdispatch").find("#tt").find("td").eq(3).css("background","#ffeedd");
                $("#table-waitdispatch").find("#tt").find("td").eq(4).css("background","#ffeedd");
                $("#table-waitdispatch").find("#tt").find("td").eq(5).css("background","#ffeedd");
            }
        })

        //return obj;
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
    }

    //分页信息，点击查询
    function page(n, s) {
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        search();
    }

    //保修类型
    function protectType(row) {
        if(row.warranty_type=='— —'){
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

    function reset() {
        $("#endTimeMin").val('');
        $("#endTimeMax").val('');
        $("#settlementTimeMin").val('');
        $("#settlementTimeMax").val('');

        $('#employeName').val("");
        $(".select2-selection__rendered").attr("title","请选择");
        $(".select2-selection__rendered").html("请选择");
    }

    function toCostAll() {
        //$.closeDiv($(".gcsjsmxhzWrap"));
        layer.open({
            type : 2,
            content : '${ctx}/finance/revenue/toCostAll',
            title : false,
            area : [ '100%', '100%' ],
            closeBtn : 0,
            shade : 0,
            anim : -1
        });

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
                    location.href = "${ctx}/finance/revenue/employeDetailExport?formPath=/a/finance/revenue/toEmployeDetail&&maps=" + $("#searchForm").serialize();
                }
            });
        } else {
            location.href = "${ctx}/finance/revenue/employeDetailExport?formPath=/a/finance/revenue/toEmployeDetail&&maps=" + $("#searchForm").serialize();
        }

    }

    function isBlank(val) {
        if (val == null || $.trim(val) == '' || val == undefined) {
            return true;
        }
        return false;
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

    function fmtMny(row){
        return (parseFloat(row.deSumMoney)-parseFloat(row.drzgMny)).toFixed(2);
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
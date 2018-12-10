<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
    <title>备件返厂记录</title>
    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
    <script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
    <style type="text/css">
        .btn-import .webuploader-pick {
            background: #0e8ee7;
            padding: 0;
            width: 44px;
            height: 22px;
            color: #fff;
        }

        .webuploader-pick {
            background: none;
            color: #22a0e6;
            padding: 0;
            width: 100px;
            height: 24px;
        }

        .webuploader-pick img {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
        }

    </style>

</head>

<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                   <sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_RETURNFACTORY_TAB" html='<a class="btn-tabBar current"  href="${ctx}/factoryfitting/stocks/revokeApplyRecordTab">备件返厂记录<sup  id="tab_c3">0</sup></a>'></sfTags:pagePermission>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i
                                class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i
                                class="sficon sficon-reset"></i>重置</a>
                    </p>
                </div>

                <div class="tabCon">
                    <form id="searchForm">
                        <input type="hidden" name="page" id="pageNo" value="1">
                        <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                        <div class="bk-gray pt-10 pb-5">
                            <table class="table table-search">
                                <tr>
                                    <th style="width: 76px;" class="text-r">返厂单号：</th>
                                    <td>
                                        <input type="text" class="input-text" name="number"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">审核状态：</th>
                                    <td>
                                        <select class="select w-140" name="auditStatus">
                                            <option value="">请选择</option>
                                            <option value="0">待审核</option>
                                            <option value="1">已入库</option>
                                        </select>
                                    </td>
                                    <th style="width: 76px;" class="text-r">申请人：</th>
                                    <td>
                                        <input type="text" class="input-text" name="createName"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">返厂时间：</th>
                                    <td colspan="3">
                                        <input type="text"
                                               onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})"
                                               id="returnMin" name="returnMin" value="" class="input-text Wdate w-140"
                                               style="width:120px">
                                        至
                                        <input type="text"
                                               onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})"
                                               id="returnMax" name="returnMax" value="" class="input-text Wdate w-140"
                                               style="width:120px">
                                    </td>
                                </tr>
                                <tr>
                                    <th style="width: 76px;" class="text-r">备件类型：</th>
                                    <td>
								    <span class="w-140">
									<select class="select" name="fittingType" style="width:100%;height:25px"
                                            panelMaxHeight="300px">
                                        <option value="">请选择</option>
										<option value="0">旧件</option>
										<option value="1">新件</option>
									</select>
								    </span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>
                    <div class="pt-10 pb-5 cl">
                        <div class="f-l">
                            <%-- <sfTags:pagePermission authFlag="FACTORYFITTINGAPPLY_SITE_FFRECORD_ADDAPPLY_BTN"
                                                   html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="turnBackFactory();" id="btnAddnew"><i class="sficon sficon-add"></i>添加申请</a>'></sfTags:pagePermission> --%>
                            <%--<sfTags:pagePermission authFlag="FACTORYFITTINGAPPLY_SITE_FFRECORD_EDITAPPLY_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="updateApply();" id="btnAddnew"><i class="sficon sficon-edit"></i>修改申请</a>'></sfTags:pagePermission>--%>
                        </div>
                        <div class="f-r">
                        	<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
                            <sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_RETURNFACTORY_DELETE_BTN" html='<a onclick="deleteData()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-rubbish"></i>删除</a>'></sfTags:pagePermission>
                            <sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_RETURNFACTORY_EXPORT_BTN" html='<a onclick="return exports()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
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

<div class="popupBox bjsdrkbox" style="width: 968px;">
    <h2 class="popupHead">
        旧件返厂
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <div class="popupMain">
            <div class="pcontent">
                <div class="cl mb-10">
                    <label class="w-90 f-l">返厂单号：</label>
                    <input type="text" class="input-text w-190 readonly f-l" value="" readonly="readonly" id="number"
                           name="number"/>
                    <label class="w-120 f-l">返厂时间：</label>
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="bacFacDate"
                           name="bacFacDate" value="" class="input-text f-l Wdate w-190">
                    <label class="w-120 f-l">返厂操作人：</label>
                    <input type="text" class="input-text w-190 f-l readonly" readonly="readonly" maxlength="10" value=""
                           id="dacFacMan" name="dacFacMan"/>
                </div>
                <div class="cl mb-10">
                    <label class="w-90 f-l"><em class="mark">*</em>物流名称：</label>
                    <input type="text" value="" class="input-text  f-l w-190" id="logisticsName" name="logisticsName"/>
                    <label class="w-120 f-l "><em class="mark">*</em>物流单号：</label>
                    <input type="text" class="input-text w-190 f-l " value="" id="logisticsNo" name="logisticsNo"/>
                    <label class="w-120 f-l">备注：</label>
                    <input type="text" class="input-text w-190" id="remarks" value="" name="remarks"/>
                </div>

                <table class="table table-border table-bordered table-bg table-sdrk" style="width: 900px;">
                    <thead>
                    <tr>
                        <th class="w-160">备件条码</th>
                        <th class="w-160">备件名称</th>
                        <th class="w-160">备件型号</th>
                        <th class="w-80">适用品类</th>
                        <th class="w-120">返厂数量</th>
                        <th class="w-100">操作</th>
                    </tr>
                    </thead>
                    <tbody id="sdrk_tbd"></tbody>
                </table>
            </div>
        </div>
        <div class="text-c btnWrap">
            <a href="javascript:turnBackNow();" class="sfbtn sfbtn-opt3 w-70 mr-5">提交</a>
            <a href="javascript:closeAll_();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
        </div>
    </div>
</div>

<div class="popupBox bjxg" style="width: 968px;">
    <h2 class="popupHead">
        修改
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r pb-40">
        <div class="popupMain" style="height: 400px;  overflow: auto;">
            <div class="pcontent pd-15">
                <div class="cl mb-10">
                    <label class="w-90 f-l">返厂单号：</label>
                    <input type="text" class="input-text w-190 readonly f-l" value="" readonly="readonly"
                           name="number"/>
                    <label class="w-120 f-l">返厂时间：</label>
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="bacFacDate" value=""
                           disabled class="readonly input-text f-l Wdate w-190">
                    <label class="w-120 f-l">返厂操作人：</label>
                    <input type="text" class="input-text w-190 f-l readonly" readonly="readonly" maxlength="10" value=""
                           name="dacFacMan"/>
                </div>
                <div class="cl mb-10">
                    <label class="w-90 f-l"><em class="mark">*</em>物流名称：</label>
                    <input type="text" value="" class="input-text readonly f-l w-190" readonly name="logisticsName"/>
                    <label class="w-120 f-l "><em class="mark">*</em>物流单号：</label>
                    <input type="text" class="input-text w-190 f-l readonly" value="" readonly name="logisticsNo"/>
                    <label class="w-120 f-l">备注：</label>
                    <input type="text" class="input-text w-190 readonly" value="" readonly name="remarks"/>
                </div>

                <table class="table table-border table-bordered table-bg table-sdrk" style="width: 900px;">
                    <thead>
                    <tr>
                        <th class="w-160">备件条码</th>
                        <th class="w-160">备件名称</th>
                        <th class="w-160">备件型号</th>
                        <th class="w-80">适用品类</th>
                        <th class="w-120">返厂数量</th>
                        <th class="w-100">操作</th>
                    </tr>
                    </thead>
                    <tbody id="bjxg_tbd"></tbody>
                </table>
            </div>
        </div>
        <div class="text-c btnWrap">
            <a href="javascript:updateApplyRecord();" class="sfbtn sfbtn-opt3 w-70 mr-5">提交</a>
            <a href="javascript:closeAll_();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
        </div>
    </div>
</div>

<div class="popupBox bjxq" style="width: 968px;">
    <h2 class="popupHead">
        详情
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r pb-40">
        <div class="popupMain" style="height: 400px;  overflow: auto;">
            <div class="pcontent pd-15">
                <div class="cl mb-10">
                    <label class="w-90 f-l">返厂单号：</label>
                    <input type="text" class="input-text w-190 readonly f-l" value="" readonly="readonly"
                           name="number"/>
                    <label class="w-120 f-l">返厂时间：</label>
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="bacFacDate" value=""
                           disabled class="readonly input-text f-l Wdate w-190">
                    <label class="w-120 f-l">返厂操作人：</label>
                    <input type="text" class="input-text w-190 f-l readonly" readonly="readonly" maxlength="10" value=""
                           name="dacFacMan"/>
                </div>
                <div class="cl mb-10">
                    <label class="w-90 f-l"><em class="mark">*</em>物流名称：</label>
                    <input type="text" value="" class="input-text readonly f-l w-190" readonly name="logisticsName"/>
                    <label class="w-120 f-l "><em class="mark">*</em>物流单号：</label>
                    <input type="text" class="input-text w-190 f-l readonly" value="" readonly name="logisticsNo"/>
                    <label class="w-120 f-l">备注：</label>
                    <input type="text" class="input-text w-190 readonly" value="" readonly name="remarks"/>
                </div>

                <table class="table table-border table-bordered table-bg table-sdrk" style="width: 900px;">
                    <thead>
                    <tr>
                        <th class="w-60">序号</th>
                        <th class="w-160">备件条码</th>
                        <th class="w-160">备件名称</th>
                        <th class="w-160">备件型号</th>
                        <th class="w-80">适用品类</th>
                        <th class="w-120">返厂数量</th>
                    </tr>
                    </thead>
                    <tbody id="bjxq"></tbody>
                </table>
            </div>
        </div>
        <div class="text-c btnWrap">
            <a href="javascript:closeAll_();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
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
<script type="text/javascript">
    var sfGrid;
    var id = '${headerData.id}';
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';
    var uploaderPic;
    var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;//验证价钱的正则表达式
    function rabCount(){
    	 $.post("${ctx}/factoryfitting/stocks/getFittingTabCount", function (result) {
             $("#tab_c3").text(result);
         });
    }
    $(function () {
    	rabCount();
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

        $('#empNm').select2();
        $("#empNm").next(".select2").find(".selection").css("width", "160px");

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });

    });

    function closeAll_() {
        $.closeAllDiv();
    }

    function fmtSiteStatus(row) {
        if (row.audit_status == '0') {
            return "<span class='oState state-yrk'>待审核</span>";
        } else if (row.audit_status == '1') {
            return "<span class='oState state-yfc'>已入库</span>";
        }
    }

    function fmtSiteNumber(row) {
        return '<a href="javascript:showApplyDetail(\'' + row.id + '\');" class="c-0383dc">' + row.number + '</a>';//row.number;
    }

    function fmtlogisticsNo(rowData){
    	var logisticsNo = rowData.logistics_no;
    	if(!isBlank(logisticsNo)){
    	return '<a href="javascript:logsitDetail(\'' + rowData.id + '\');" class="c-0383dc">' + rowData.logistics_no + '</a>';
    	}
    	return "";
    }
    
  //物流信息
	function logsitDetail(id){
		layer.open({
			type : 2,
			content:'${ctx}/factoryfitting/Apply/logsitDetail?id='+id+"&type=2",
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		});
	}
    
    function showApplyDetail(id) {
        var rowData = $("#table-waitdispatch").jqGrid('getRowData', id);
        $.ajax({
            type: "post",
            data: {"id": id},
            url: '${ctx}/factoryfitting/stocks/getApplysById',
            dataType: "json",
            success: function (result) {
                $(".bjxq").find("input").val("");
                $("#bjxq").empty();

                $(".bjxq").find("input[name='number']").val(rowData.number);
                $(".bjxq").find("input[name='bacFacDate']").val(rowData.createTime);
                $(".bjxq").find("input[name='dacFacMan']").val(rowData.create_name);
                $(".bjxq").find("input[name='logisticsName']").val(rowData.logistics_name);
                $(".bjxq").find("input[name='logisticsNo']").val(rowData.logistics_no);
                $(".bjxq").find("input[name='remarks']").val(rowData.remark);

                nums = result.length;
                var html = '';
                if (result.length > 0) {
                    for (var i = 0; i < result.length; i++) {
                        html += '';
                        html += '<tr name="sdrk">';
                        html += '<td class="text-c"> ' + (i+1) + '</td>';
                        html += '<td class="text-c code" title="' + result[i].code + '"> ' + result[i].code + '</td>';
                        html += '<td class="text-c name text-overflow" title="' + result[i].name + '"> ' + result[i].name + '</td>';
                        html += '<td class="text-c version text-overflow" title="' + result[i].version + '"> ' + result[i].version + '</td>';
                        html += '<input type="hidden" class="id" name="id" value="' + result[i].detailId + '">';
                        html += '<td class="text-c category">' + result[i].suit_category + '</td>';
                        html += '<td class="text-c num">' + result[i].apply_num + '</td>';
                        html += '</tr>';
                    }
                    $("#bjxq").append(html);
                    $(".bjxq").popup();
                }
            }
        })
    }


    var norepeatSub = false;
    function deleteData() {
        if (norepeatSub) {
            return
        }
        var ids = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var idss = "";
        if (ids.length < 1) {
            layer.msg("请选择数据");
        } else {
            for (var i = 0; i < ids.length; i++) {
                var rowData = $("#table-waitdispatch").jqGrid('getRowData', ids[i]);
                if (rowData.audit_status != '待审核') {
                    layer.msg("只能删除待审核的记录");
                    return;
                }
                idss += ids[i] + ",";
            }
            $('body').popup({
                type: 2,
                level: 3,
                title: "提示",
                content: "确认要删除选中的记录吗?",
                fnConfirm: function () {
                    norepeatSub = true;
                    $.ajax({
                        type: "post",
                        data: {"ids": idss},
                        url: '${ctx}/factoryfitting/stocks/deleteData',
                        dataType: "json",
                        traditional: true,
                        success: function (result) {
                            if (result == "200") {
                                layer.msg("删除成功");
                                rabCount();
                                $("#table-waitdispatch").trigger("reloadGrid");//取消选中
                            }else if(result == "421"){
                            	layer.msg("存在不可删除的申请，请刷新后重新选择！");
                            } else  {
                                layer.msg("删除失败");
                            }
                        }
                        , complete: function () {
                            norepeatSub = false;
                        }
                    })
                },
                fnCancel: function () {
                }
            });
        }
    }


    var doc = 1;
    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid() {
        sfGrid = $("#table-waitdispatch").sfGrid({
            url: '${ctx}/factoryfitting/stocks/revokeApplyRecord',
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            multiselect: true,
            rownumbers: true,
            onSelectAll: function (rowid) { //点击全选时触发事件
                var rowIds = $('#table-waitdispatch').jqGrid('getDataIDs');//获取jqgrid中所有数据行的id
                if (doc == '1') {
                    for (var k = 0; k < rowIds.length; k++) {
                        var curRowData = $('#table-waitdispatch').jqGrid('getRowData', rowIds[k]);//获取指定id所在行的所有数据.
                        if ($.trim(curRowData.status) == "已返厂" || $.trim(curRowData.status) == "已报废") {
                            $('#table-waitdispatch').jqGrid("setSelection", rowIds[k], false);//设置改行不能被选中。
                        }
                        doc = 2;
                    }
                    return;
                }
                if (doc == '2') {
                    $("#table-waitdispatch").trigger("reloadGrid");//取消选中
                    //$("#cb_table-waitdispatch").parent("lable").removeAttr("style");

                    $(".ui-jqgrid-htable").find("label").css({'background-position': ' -150px -100px'});
                    doc = 1;
                }
            },
            onSelectRow: function (id) {//选择某行时触发事件
                var curRowData = $("#table-waitdispatch").jqGrid('getRowData', id);
                if ($.trim(curRowData.status) == "已返厂" || $.trim(curRowData.status) == "已报废") {
                    $("#table-waitdispatch").jqGrid("setSelection", id, false);
                }
            },
            gridComplete: function () {
                _order_comm.gridNum();
            }

        });
    }

    /*返厂*/
    var lon = 0;//计算行数
    var flge = false;
    function turnBackFactory() {
        $(".bjsdrkbox").find("input").val("");
        $("#sdrk_tbd").empty();
        if (flge) {
            return;
        }

        /*获取单号和时间*/
        $.ajax({
            type: "post", data: {}, url: '${ctx}/fitting/getDefaultInfo', dataType: "json",
            success: function (result) {
                $("#number").val(result.columns.faNumber);
                $("#dacFacMan").val(result.columns.facMan);
            }
        })

        $(".bjsdrkbox").popup();
        var ids = ""//$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var rowDatas = [];
        if (ids != null || ids.length != 0) {
            for (var i = 0; i < ids.length; i++) {
                var rowData = $("#table-waitdispatch").jqGrid('getRowData', ids[i]);
                rowDatas.push(rowData);
            }
        }
        var html = '';
        lon = ids.length + 1;
        flge = true;
        for (var i = 0; i < rowDatas.length; i++) {
            html += '';
            html += '<tr name="sdrk_tr">';
            html += '<td class="text-c code-' + i + '" title="' + rowDatas[i].code + '"> ' + rowDatas[i].code + '</td>';
            html += '<td class="text-c name-' + i + ' text-overflow" title="' + rowDatas[i].name + '"> ' + rowDatas[i].name + '</td>';
            html += '<td class="text-c version-' + i + ' text-overflow" title="' + rowDatas[i].version + '"> ' + rowDatas[i].version + '</td>';
            html += '	<input type="hidden" class="id-' + i + '" name="id" value="' + ids[i] + '">';
            html += '	<td class="text-c category-' + i + '">' + rowDatas[i].suit_category + '</td>';
            html += '	<td class="text-c num-' + i + '">' + rowDatas[i].num + '</td>';
            html += '<td class="text-c"><a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>';
            html += '</tr>';
        }

        html += '<tr name="sdrk_tr">';
        html += '	<td class="text-c">';
        html += '	<select class="select w-130 code code-' + ids.length + '"  name="fittingCode"  >    ';
        html += '  <option value=""></option>';
        html += '    </select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 name name-' + ids.length + '"  name="fittingName" id="fittingName" >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 version version-' + ids.length + '" name="fittingVersion" id="fittingVersion" >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<input type="hidden" class="id-' + ids.length + '" name="id" >';
        html += '	<td class="text-c  category-' + ids.length + '"></td>';
        html += '	<td class="text-c num-' + ids.length + '"></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';


        $("#sdrk_tbd").empty().html(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".code-" + ids.length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/getOldFittingsBySelect',
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
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
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
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".name-" + ids.length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/getOldFittingsNameBySelect',
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
                            var name = data.list[i].columns.name;
                            itemList.push({id: code, text: name});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
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
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".version-" + ids.length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/getOldFittingsVersionBySelect',
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
                            var version = data.list[i].columns.version;
                            itemList.push({id: code, text: version});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) {
                    return markup;
                }, // 自定义格式化防止xss注入
                minimumInputLength: 2,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo) {
                    return repo.text;
                }, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo) {
                    return repo.text;
                } // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        flge = false;
    }

    function deleteTR(z) {
        $(z).parent('td').parent('tr').remove();
    }

    function addNewTR(length) {
        var html = '';
        html += '<tr name="sdrk_tr">';
        html += '	<td class="text-c">';
        html += '	<select class="select w-130 code code-' + length + '"  name="fittingCode" datatype="*" nullmsg ="请选择工程师" >    ';
        html += '  <option value=""></option>';
        html += '    </select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 name name-' + length + '"  name="fittingName" id="fittingName" >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 version version-' + length + '" name="fittingVersion" id="fittingVersion">    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<input type="hidden" class="id-' + length + ' " name="id" >';
        /*html += '	<td class="text-c brand-' + length + '"></td>';*/
        html += '	<td class="text-c category-' + length + '"></td>';
        html += '	<td class="text-c num-' + length + '"></td>';
        /*html += '	<td class="text-c"><input type="text" class="input-text price-' + length + '" name="price" /></td>';*/
        html += '	<td class="text-c"></td>';
        html += '</tr>';

        $("#sdrk_tbd").append(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".code-" + length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/getOldFittingsBySelect',
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
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
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
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".name-" + length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/getOldFittingsNameBySelect',
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
                            var name = data.list[i].columns.name;
                            itemList.push({id: code, text: name});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
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
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".version-" + length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/getOldFittingsVersionBySelect',
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
                            var version = data.list[i].columns.version;
                            itemList.push({id: code, text: version});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) {
                    return markup;
                }, // 自定义格式化防止xss注入
                minimumInputLength: 2,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo) {
                    return repo.text;
                }, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo) {
                    return repo.text;
                } // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });

    }

    var fla = false;
    $(function () {
        $("#sdrk_tbd").change(function (e) {
            if (fla) {
                return;
            }
            var codeOrnameOrversion = $(e.target).attr('class');//选中的值的class
            var valu = $(e.target).val();//选中的值（code）
            if (codeOrnameOrversion.indexOf("code") > 0) {
                fla = true;
                var va = new Array();
                va = codeOrnameOrversion.split(" ");
                var val = new Array();
                val = va[3].split("-");
                var fitName = "name-" + val[1];//获取配件名称的class
                var fitversion = "version-" + val[1];//获取配件型号的class
                var warn = "num-" + val[1];//获取配件库存的class
                var id = "id-" + val[1];//获取配件id的class
                var category = "category-" + val[1];//获取备件品类class

                $.ajax({
                    type: "post", data: {"code": valu}, url: '${ctx}/fitting/getFittingsByCode', dataType: "json",
                    success: function (result) {
                        var zl = parseInt(val[1]) + 1;
                        if (zl == lon) {
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon += 1;
                        }


                        $("." + va[3]).parent("td").replaceWith('<td class="text-c text-overflow " title="' + valu + '">' + valu + '</td>');
                        $("." + fitName).parent("td").replaceWith('<td class="text-c  text-overflow"  title="' + result.columns.code + '">' + result.columns.name + '</td>');
                        $(".version-" + val[1]).parent("td").replaceWith('<td class="text-c  text-overflow" title="' + result.columns.code + '">' + result.columns.version + '</td>');

                        $("." + warn).text(result.columns.num);
                        $("." + id).val(result.columns.id);
                        $("." + category).text(result.columns.suit_category);
                    }
                })


                fla = false;
            } else if (codeOrnameOrversion.indexOf("name") > 0) {
                fla = true;
                var va = new Array();
                va = codeOrnameOrversion.split(" ");
                var val = new Array();
                val = va[3].split("-");
                var fitName = "code-" + val[1];//获取配件条码的class
                var fitversion = "version-" + val[1];//获取配件型号的class
                var warn = "num-" + val[1];//获取配件库存的class
                var id = "id-" + val[1];//获取配件id的class
                var category = "category-" + val[1];//获取备件品类class

                $.ajax({
                    type: "post", data: {"code": valu}, url: '${ctx}/fitting/getFittingsByCode', dataType: "json",
                    success: function (result) {

                        var zl = parseInt(val[1]) + 1;
                        if (zl == lon) {
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon += 1;
                        }

                        $("." + va[3]).parent("td").replaceWith('<td class="text-c text-overflow  " title="' + valu + '">' + result.columns.name + '</td>');
                        $("." + fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="' + result.columns.code + '">' + result.columns.code + '</td>');
                        $(".version-" + val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="' + result.columns.code + '">' + result.columns.version + '</td>');

                        $("." + warn).text(result.columns.num);
                        $("." + id).val(result.columns.id);
                        $("." + category).text(result.columns.suit_category);
                    }
                })
                fla = false;
            } else if (codeOrnameOrversion.indexOf("version") > 0) {
                fla = true;
                var va = new Array();
                va = codeOrnameOrversion.split(" ");
                var val = new Array();
                val = va[3].split("-");
                var fitName = "code-" + val[1];//获取配件条码的class
                var fitversion = "name-" + val[1];//获取配件名称的class
                var warn = "num-" + val[1];//获取配件库存的class
                var id = "id-" + val[1];//获取配件id的class
                var category = "category-" + val[1];//获取备件品类class

                $.ajax({
                    type: "post", data: {"code": valu}, url: '${ctx}/fitting/getFittingsByCode', dataType: "json",
                    success: function (result) {

                        var zl = parseInt(val[1]) + 1;
                        if (zl == lon) {
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon += 1;
                        }

                        $("." + va[3]).parent("td").replaceWith('<td class="text-c text-overflow" title="' + result.columns.code + '">' + result.columns.version + '</td>');
                        $("." + fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="' + result.columns.code + '">' + result.columns.code + '</td>');
                        $(".name-" + val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="' + result.columns.code + '">' + result.columns.name + '</td>');

                        //最新入库价格
                        $("." + warn).text(result.columns.num);
                        $("." + id).val(result.columns.id);
                        $("." + category).text(result.columns.suit_category);
                    }
                })
                fla = false;
            }
        })
    })

    //旧件返厂
    var manuallyStockPosted = false;
    function turnBackNow() {
        if (manuallyStockPosted) {
            return;
        }
        var number = $("#number").val();
        var bacFacDate = $("#bacFacDate").val();
        var dacFacMan = $("#dacFacMan").val();
        var logisticName = $("#logisticsName").val();
        var logisticNo = $("#logisticsNo").val();
        var remarks = $("#remarks").val();

        if (isBlank(logisticName)) {
            layer.msg("请填写物流名称");
            return;
        } else if (isBlank(logisticNo)) {
            layer.msg("请填写物流单号");
            return;
        }

        var ids = "";
        $("tr[name='sdrk_tr']").each(function (index) {
            var id = $(this).find("input[name='id']").val();//备件id
            if (!isBlank(id)) {
                ids += id + ",";
            }
        });
        if (isBlank(ids)) {
            layer.msg("请选择要返厂的备件");
        } else {
            manuallyStockPosted = true;
            $.ajax({
                type: "post",
                url: "${ctx}/fitting/oldFittingTurnBack",
                data: {
                    "ids": ids,
                    "number": number,
                    "bacFacDate": bacFacDate,
                    "dacFacMan": dacFacMan,
                    "logisticName": logisticName,
                    "logisticNo": logisticNo,
                    "remarks": remarks
                },
                dataType: "text",
                success: function (result) {
                    if (result === "200") {
                        window.top.layer.msg("提交成功!");
                        $.closeDiv($('.bjsdrkbox'));
                        $("#table-waitdispatch").trigger("reloadGrid");
                    } else {
                        layer.msg("提交失败!");
                    }
                }, complete: function () {
                    manuallyStockPosted = false;
                }
            });
        }
    }

    /*------------------------------------------------------*/


    /*修改申请*/
    var nums = 0;
    /*记录数*/
    var deleteIds = "";
    function updateApply() {
        $(".headWord").text("修改");

        var ids = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var rowData = $("#table-waitdispatch").jqGrid('getRowData', ids[0]);
        if (ids.length < 1) {
            layer.msg("请选择数据");
        } else if (ids.length > 1) {
            layer.msg("一次只能选择一条数据");
        } else if (rowData.audit_status != '待审核') {
            layer.msg("只能修该待审核的记录");
        } else {
            $.ajax({
                type: "post",
                data: {"id": ids[0]},
                url: '${ctx}/factoryfitting/stocks/getApplysById',
                dataType: "json",
                success: function (result) {
                    $(".bjxg").find("input").val("");
                    $("#bjxg_tbd").empty();

                    $(".bjxg").find("input[name='number']").val(rowData.number);
                    $(".bjxg").find("input[name='bacFacDate']").val(rowData.createTime);
                    $(".bjxg").find("input[name='dacFacMan']").val(rowData.create_name);
                    $(".bjxg").find("input[name='logisticsName']").val(rowData.logistics_name);
                    $(".bjxg").find("input[name='logisticsNo']").val(rowData.logistics_no);
                    $(".bjxg").find("input[name='remarks']").val(rowData.remark);

                    nums = result.length;
                    var html = '';
                    if (result.length > 0) {
                        for (var i = 0; i < result.length; i++) {
                            html += '';
                            html += '<tr name="sdrk">';
                            html += '<td class="text-c code" title="' + result[i].code + '"> ' + result[i].code + '</td>';
                            html += '<td class="text-c name text-overflow" title="' + result[i].name + '"> ' + result[i].name + '</td>';
                            html += '<td class="text-c version text-overflow" title="' + result[i].version + '"> ' + result[i].version + '</td>';
                            html += '	<input type="hidden" class="id" name="id" value="' + result[i].detailId + '">';
                            html += '	<td class="text-c category">' + result[i].suit_category + '</td>';
                            html += '	<td class="text-c num">' + result[i].apply_num + '</td>';
                            html += '<td class="text-c"><a class="c-0383dc" onclick="deleteTRTwo(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>';
                            html += '</tr>';
                        }
                        $("#bjxg_tbd").append(html);
                        $(".bjxg").popup();
                    }
                }
            })
        }

    }

    function deleteTRTwo(z) {
        if (nums > 1) {
            var id = $(z).parent('td').parent('tr').find("input[name='id']").val();
            deleteIds += id + ",";
            $(z).parent('td').parent('tr').remove();
            nums -= 1;
        } else {
            layer.msg("不可再删除了");
        }
    }

    var updateApplyRecordSub = false;
    function updateApplyRecord() {
        if (updateApplyRecordSub) {
            return;
        }
        updateApplyRecordSub = true;
        $.ajax({
            type: "post",
            data: {"ids": deleteIds},
            url: '${ctx}/factoryfitting/stocks/updateApplyRecord',
            dataType: "json",
            success: function (result) {
                if (result == "200") {
                    window.top.layer.msg("保存成功");
                    $.closeDiv($('.bjxg'));
                    $("#table-waitdispatch").trigger("reloadGrid");
                } else {
                    layer.msg("保存失败");
                }
            }, complete: function () {
                updateApplyRecordSub = false;
            }
        })
    }

    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }
    //(返厂/报废)
    var adpoting = false;
    function turnBack(type) {
        if (adpoting) {
            return;
        }

        var doing = "返厂";
        if (type == '4') {
            doing = '报废';
        }
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else {

            var id;
            var content = "确定要将" + idArr.length + "条旧件" + doing + "?"
            $('body').popup({
                level: 3,
                title: "批量入库",
                content: content,
                fnConfirm: function () {
                    adpoting = true;
                    for (var i = 0; i < idArr.length; i++) {
                        if (isBlank(id)) {
                            id = idArr[i];
                        } else {
                            id = id + "," + idArr[i];
                        }
                    }
                    $.ajax({
                        type: "POST",
                        url: "${ctx}/fitting/putOldFitting",
                        data: {"idArr": id, "type": type},
                        success: function (data) {
                            if (data) {
                                layer.msg(doing + '成功!');
                                $("#table-waitdispatch").trigger("reloadGrid");
                                //window.location.reload(true);
                            } else {
                                layer.msg(doing + '失败!');
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

    function fmtOper(rowData) {
        if (rowData.code) {
            return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">' + rowData.code + '</a>';
        } else {
            return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">--</a>';
        }
    }

    //是否原配转换为字符
    function fmtFitType(row) {
        if (row.yrpz_flag == 1) {
            return '是';
        } else if (row.yrpz_flag == 2) {
            return "否";
        } else {
            return "";
        }
    }


    function fmtBxStatus(row) {
        if (row.warranty_type == '1') {
            return '保内';
        } else if (row.warranty_type == '2') {
            return "保外";
        } else {
            return "";
        }
    }

    function showDetail(id) {
        layer.open({
            type: 2,
            content: '${ctx}/fitting/getById?id=' + id + "&whereFrom=" + 1,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }


    function search() {
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }
    function exports() {
        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup(
                {
                    level: 3,
                    title: "导出",
                    content: content,
                    fnConfirm: function () {
                        location.href = "${ctx}/factoryfitting/stocks/exportOld?formPath=/a/factoryfitting/stocks/revokeApplyRecordTab&&" + $("#searchForm").serialize();
                    }

                });
        } else {
            location.href = "${ctx}/factoryfitting/stocks/exportOld?formPath=/a/factoryfitting/stocks/revokeApplyRecordTab&&" + $("#searchForm").serialize();
        }

    }

    $(".resetSearchBtn")
        .on(
            "click",
            function () {
                var html = '<span class="w-140 dropdown-sin-2">';
                html += '<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employs"  >';
                html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
                html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
                html += '</c:forEach>';
                html += '</select>  </span>';
                $("#reloadSpan").html(html);
                $('.dropdown-sin-2')
                    .dropdown(
                        {
                            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
                        });
            });

    function close() {
        $.closeDiv($(".bjtzkkbox"));
    }

    function fmtFittingType(rowData){
        if(rowData.rovoke_type=='0'){
            return "旧件";
        }else if(rowData.rovoke_type=='1'){
            return "新件";
        }
    }

    function addNew() {
        $(".bjtzkkbox").find("input").val("");
        $(".bjtzkkbox").find("select").val("");
        $(".bjtzkkbox").find("#img-view").attr("src", "");
        $(".bjtzkkbox").popup();
    }

</script>
</body>
</html>

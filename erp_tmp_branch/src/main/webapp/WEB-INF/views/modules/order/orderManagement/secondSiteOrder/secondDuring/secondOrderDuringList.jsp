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
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
    <script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
    <style type="text/css">
        .SelectBG{
            background-color:#ffe6e2;
        }
        .dropdown-display{font-size: 12px}
        .dropdown-selected{margin-top: 4px}
    </style>
</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage  table-header-settable">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <a class="btn-tabBar current" href="${ctx }/secondOrder/secondDuring">处理中工单<sup id="tab_c1">0</sup></a>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
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
                                    <th style="width: 76px;" class="text-r">二级网点：</th>
                                    <td class="reloadType">
                                        <span class="w-140 dropdown-sin-2">
									    <select class="select"  style="width:100%;height:25px" multiple  name="secondSite" >
										    <c:forEach items="${sites }" var="site">
                                                <option value="${site.columns.id }">${site.columns.name }</option>
                                            </c:forEach>
									    </select>
								        </span>
                                    </td>
                                    <th style="width: 76px;" class="text-r">工单编号：</th>
                                    <td>
                                        <input type="text" class="input-text" name= "number"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">用户姓名：</th>
                                    <td>
                                        <input type="text" class="input-text" name = "customerName" onkeydown="enterEvent(event)"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">联系方式：</th>
                                    <td>
                                        <input type="text" class="input-text" name = "customerMobile" onkeydown="enterEvent(event)"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">用户地址：</th>
                                    <td>
                                        <input type="text" class="input-text" name = "customerAddress" onkeydown="enterEvent(event)"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="width: 76px;" class="text-r">家电品类：</th>
                                    <td>
								<span class="w-140">
									<select class="select easyui-combobox" id="catgyS"  multiline="false"  style="width:100%;height:25px" panelMaxHeight="300px">
										<option value=""></option>
										<c:forEach items="${category }" var="ca">
                                            <option value="${ca.columns.name }">${ca.columns.name }</option>
                                        </c:forEach>
									</select>
									<input type="hidden" name="applianceCategory"/>
								</span>
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
                                    <th style="width: 76px;" class="text-r">工单状态：</th>
                                    <td>
								<span class="w-140">
									<select class="select easyui-combobox" id="statusFlag" multiple="true"
                                            multiline="false" name="statuss" style="width:100%;height:25px"
                                            panelMaxHeight="130px">
										<option value="1">待网点派工</option>
										<option value="2">服务中</option>
										<option value="7">网点暂不派工</option>
									</select>
								</span>
                                    </td>
                                    <th style="width: 76px;" class="text-r">服务方式：</th>
                                    <td>
                                        <input type="text" class="input-text" id="serviceMode" name = "serviceMode"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">家电品牌：</th>
                                    <td>
                                        <input type="text" class="input-text" name="applianceBrand" />
                                    </td>
                                </tr>
                                <tr class="moreCondition" style="display: none;">
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
                                    <th style="width: 76px;" class="text-r">预约日期：</th>
                                    <td>
                                        <input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime" value="" class="input-text Wdate ">
                                    </td>
                                    <th style="width: 76px;" class="text-r">重要程度：</th>
                                    <td>
								<span class="select-box">
									<select class="select" name="level">
										<option value="">请选择</option>
										<option value="1">紧急</option>
										<option value="2">一般</option>
									</select>
								</span>
                                    </td>
                                    <th style="width: 76px;" class="text-r">家电条码：</th>
                                    <td>
                                        <input type="input-text"  name="elictrictyBarcode" value="" class="input-text">
                                    </td>
                                    <th style="width: 76px;" class="text-r">登记人：</th>
                                    <td>
                                        <input type="text" class="input-text" name="messengerName" />
                                    </td>
                                </tr>
                                <tr class="moreCondition" style="display: none;">
                                    <th style="width: 76px;" class="text-r">报修时间：</th>
                                    <td colspan="3">
                                        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-120" style="width:120px">
                                        至
                                        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
                                    </td>
                                    <th style="width: 76px;" class="text-r">派工时间：</th>
                                    <td colspan="3">
                                        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'dispatchTimesMax\')||\'%y-%M-%d\'}'})" id="dispatchTimesMin" name="dispatchTimesMin"  value="" class="input-text Wdate w-120" style="width:120px">
                                        至
                                        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'dispatchTimesMin\')}',maxDate:'%y-%M-%d'})" id="dispatchTimesMax" name="dispatchTimesMax"  value="" class="input-text Wdate w-120" style="width:120px">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>
                    <div class="pt-10 pb-5 cl">
                        <div class="f-r">
                            <a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
                            <sfTags:pagePermission authFlag="SECONDORDER_ISDEALINGORDER_EXPORTSECONDORDER_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
                            <sfTags:pagePermission authFlag="SECONDORDER_ISDEALINGORDER_TITLESETSECONDORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
                        </div>
                    </div>
                    <div>
                        <table id="table-waitdispatch" class="table"></table>
                        <div class="cl pt-10">
                            <div class="f-l iconsBoxWrap">
                                <a class="iconDec">图标注释？</a>
                                <div class="iconsBox">
                                    <div class="iconsBoxBg">
                                        <div class="cl pl-10 pt-5">
                                            <span class='oState state-waitTakeOrder'>待网点派工</span>
                                            <span class='oState state-serving'>服务中</span>
                                            <span class='oState state-noDispatch'>暂不派工</span>
                                        </div>
                                    </div>

                                    <span class="iconArrow"></span>
                                </div>

                            </div>
                            <div class="f-r">
                                <div class="pagination"></div>
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
    </div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    var a = true;
    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';			//系统表格的ID
    $(function(){
        numerCheck();
        $('.iconDec').showIcons();

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

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
            choice: function() {
            }
        });
        $(".secondSite").dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
            choice: function() {
            }
        });
    });

    function numerCheck(){
        $.post("${ctx}/secondOrder/getOrderTabCount",{},function(result){
            $("#tab_c1").text(result.c1);
        });
    }

    $(".resetSearchBtn").on("click",function(){
        $('#statusFlag').combobox('setValues',"");
        $("#catgyS").combobox('clear');

       /* var html = '<span class="w-140 dropdown-sin-2">';
        html += '<select class="select-box w-120"  id="employs" style="display:none" multiple placeholder="请选择" name="employeNames"  >';
        html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
        html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
        html += '</c:forEach>';
        html += '</select>  </span>';*/

        var htmlType = '<span class="w-140 dropdown-sin-2">';
        htmlType += '<select class="select"  style="display:none" multiple  name="secondSite" >';
        htmlType += '<c:forEach items="${sites }" var="site">';
        htmlType += ' <option value="${site.columns.id }">${site.columns.name }</option>';
        htmlType += '</c:forEach>';
        htmlType += '</select>  </span>';

        //$("#reloadSpan").html(html);
        $(".reloadType").html(htmlType);

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
    });

    window.onload=function(){
        $("#_easyui_combobox_i1_0").remove();
    }

    function fmtOrderStatus(rowData){
        var html1="";
        var html2="";
        var html3="";
        if(rowData.status=='1'){
            html2= "<span class='oState state-waitTakeOrder'>待网点派工 &nbsp&nbsp&nbsp</span>";
        }else if(rowData.status=='2'){
            html2= "<span class='oState state-serving'>服务中 &nbsp&nbsp&nbsp</span>";
        }else if(rowData.status=='7'){
            html2= "<span class='oState state-noDispatch'>暂不派工 &nbsp&nbsp&nbsp</span>";
        }
        return html1+html3+html2;
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/secondOrder/getWxzList',
            sfHeader: eval('${headerData.tableHeader}'),
            sfSortColumns:'${headerData.sortHeader}',
            rownumbers:true,
            gridComplete:function(){
                _order_comm.gridNum();
                var ids = $("#table-waitdispatch").getDataIDs();
                if($("#table-waitdispatch").find("tr").length>1){
                    $(".ui-jqgrid-hdiv").css("overflow","hidden");
                }else{
                    $(".ui-jqgrid-hdiv").css("overflow","auto");
                }
                for(var i=0;i<ids.length;i++){
                    var rowData = $("#table-waitdispatch").getRowData(ids[i]);
                    if(rowData.callback_result==2 && $.trim(rowData.status)=='服务中'){//则背景色置灰显示
                        $('#'+ids[i]).find("td").addClass("SelectBG");
                    }
                }
            }
        });
    }

    function fmtOrderNo(rowData){
        return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
    }

    function showDetail(id){
        layer.open({
            type : 2,
            content:'${ctx}/secondOrder/duringform?id='+id+'&map='+$("#searchForm").serialize(),
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }

    function statusFmt(rowId, cellval , colpos){
        if(cellval == 1){
            return "<span>dfdf</span>";
        }
        return "<span>"+colpos.appliance_category+colpos.appliance_brand+"</span>";
    }

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
    function search(){
        var valCategory = $('#catgyS').combobox('getValues');
        $("input[name='applianceCategory']").val(valCategory);
        var pageSize = $("#pageSize").val();
        if($.trim(pageSize)=='' || pageSize==null){
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function fmtWC(rowData){
        return rowData.confirm_cost;
    }

    function exports() {
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

        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records');
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup({
                level: 3,
                title: "导出",
                content: content,
                fnConfirm: function () {
                    location.href = "${ctx}/secondOrder/exportDuringOrCallBack?formPath=/a/secondOrder/secondDuring&&maps=" + $("#searchForm").serialize()+"&whoExport=deal";
                },
                fnCancel: function () {
                }

            });
        } else {
            location.href = "${ctx}/secondOrder/exportDuringOrCallBack?formPath=/a/secondOrder/secondDuring&&maps=" + $("#searchForm").serialize()+"&whoExport=deal";
        }
    }

    /*enter查询*/
    function enterEvent(event){
        var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
        if (keyCode ==13){
            $("#table-waitdispatch").sfGridSearch({
                postData: $("#searchForm").serializeJson()
            });
        }
    }
</script>

</body>
</html>
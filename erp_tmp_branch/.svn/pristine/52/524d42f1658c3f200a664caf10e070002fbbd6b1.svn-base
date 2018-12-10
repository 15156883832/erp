<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

    <meta name="decorator" content="base"/>
</head>
<body>
<div class="sfpagebg bk-gray ">
    <div class="sfpage ">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <sfTags:pagePermission authFlag="SITESETTLE_FAPIAOAPPLYSET_FAPIAOAPPLY_TAB" html='<a class="btn-tabBar " href="${ctx}/finance/invoiceMsg/invoiceManager">发票申请</a>'></sfTags:pagePermission>
                    <sfTags:pagePermission authFlag="SITESETTLE_FAPIAOAPPLYSET_FAPIAOAPPLYRECORD_TAB" html='<a class="btn-tabBar  current" href="${ctx}/finance/invoiceApplication/record">发票申请记录</a>'></sfTags:pagePermission>
                    <p class="f-r btnWrap">
                    </p>
                </div>
                <form id="searchForm">
                    <input type="hidden" name="page" id="pageNo" value="1">
                    <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">


                    <div class="pt-10 pb-5 cl">
                        <div class="f-l">
                            <%--<a href="javascript:deletes();" class="sfbtn sfbtn-opt"><i class="sficon sficon-rubbish"></i>删除</a>--%>
                        </div>
                        <div class="f-r">
                          <%--  <a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>--%>
                        </div>
                    </div>
                    <div>
                        <table id="table-waitdispatch" class="table"></table>
                        <!-- pagination -->
                        <div class="cl pt-10">
                            <div class="f-r">
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <!-- pagination -->
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="popupBox bjsdrkbox" style="width: 1110px;">
    <h2 class="popupHead">
        详情
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <div class="popupMain">
            <div class="pcontent">
                <table class="table table-border table-bordered table-bg table-sdrk">
                    <thead>
                    <tr>
                        <th class="w-50">序号</th>
                        <th class="w-120">订单编号</th>
                        <th class="w-120">商品名称</th>
                        <th class="w-80">购买数量</th>
                        <th class="w-80">购买价格</th>
                        <th class="w-120">收件人</th>
                        <th class="w-120">联系方式</th>
                        <th class="w-140">收货地址</th>
                        <th class="w-120">物流名称</th>
                        <th class="w-120">物流单号</th>
                    </tr>
                    </thead>
                    <tbody id="sdrk_tbd"></tbody>
                </table>
            </div>
        </div>
        <div class="text-c btnWrap">
            <a href="javascript:close('.bjsdrkbox');" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
        </div>
    </div>
</div>


<script type="text/javascript">

    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

    $(function(){

        initSfGrid();
        //$("#_easyui_textbox_input1").attr("readonly","readonly")
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        var url = "${ctx}/finance/invoiceApplication/getlist";
        sfGrid = $("#table-waitdispatch").sfGrid({
            url:url,
            sfHeader:defaultHeader,
            sfSortColumns:sortHeader,
            shrinkToFit: true,
            multiselect: false,
            postData:$("#searchForm").serializeJson(),
            rownumbers : true,
            gridComplete:function(){
                _order_comm.gridNum();
            },
        });
    }


    function orderDetail(row){
        return '<a href="javascript:lookOrdersDetail(\''+row.order_numbers+'\');" class="c-0383dc">查看详情</a>';
    }

    function lookOrdersDetail(orderNumbers){
        $.ajax({
            url:"${ctx}/finance/invoiceApplication/getOrdersDetail",
            type:'POST',
            data:{
                orderNumbers:orderNumbers
            },
            success:function(result){
                $("#sdrk_tbd").empty();
                if(result.length>0){
                   var html='';
                   for(var i=0;i<result.length;i++){
                        html+='<tr name="sdrk_tr">';
                        html += '	<td class="text-c">'+(i+1)+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.number+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.good_name+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.purchase_num+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.good_amount+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.customer_name+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.customer_contact+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.province+result[i].columns.city+result[i].columns.area+result[i].columns.customer_address+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.logistics_name+'</td>';
                        html += '	<td class="text-c">'+result[i].columns.logistics_no+'</td>';
                        html+='</tr>';
                   }
                   $("#sdrk_tbd").empty().html(html);
                }
                $(".bjsdrkbox").popup();
            }
        })
    }

    function close(selector){
        $.closeDiv($(selector));
    }

    function reviewStatus(rowDate) {
        if (rowDate.review_status =="0") {
            return "<span>待开票</span>";
        } else if(rowDate.review_status =="1"){
            return "<span>已开票</span>";
        }else if(rowDate.review_status =="2"){
            return "<span>审核未通过</span>";
        }else if(rowDate.review_status =="3"){
            return "<span>待审核</span>";
        }else if(rowDate.review_status =="4"){
            return "<span>已完成</span>";
        }else{
            return "<span></span>";
        }
    }


/*    function jsClearForm() {
        $("#searchForm :input[type='text']").each(function () {
            $(this).val("");
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
    }*/

/*    function exports() {
        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup({
                level: 3,
                title: "导出",
                content: content,
                fnConfirm: function () {
                    location.href = "${ctx}/finance/balanceManager/export?formPath=/a/finance/balanceManager/balance&&maps=" + $("#searchForm").serialize();
                }

            });
        } else {
            location.href = "${ctx}/finance/balanceManager/export?formPath=/a/finance/balanceManager/balance&&maps=" + $("#searchForm").serialize();

        }
    }*/
</script>
</body>
</html>
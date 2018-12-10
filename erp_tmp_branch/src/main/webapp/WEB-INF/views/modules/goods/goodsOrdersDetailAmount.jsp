<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
    <title>订单信息——公司商品订单——订单详情</title>
</head>
<body class="">
<div class="sfpagebg bk-gray pb-80 ">
    <div class="page-orderWait goodsPage">
        <div class="tabBar cl mb-10">
            <a class="btn-tabBar current" href="javascript:;">订单详情</a>
        </div>
        <div class="mb-5 lh-28">
				<span>
					订单编号：<span>${dataMap.siteOrder.columns.number}</span>
				</span>
            <span class="ml-100">
					订单状态：
                            <span>
                                <c:if test="${mark == 'zy' }">
                                     <!-- 公司订单 -->
                                     <c:if test="${dataMap.siteOrder.columns.status eq 0 }">已取消</c:if>
                                     <c:if test="${dataMap.siteOrder.columns.status == '1' || dataMap.siteOrder.columns.status == '4' }">待收款</c:if>
                                     <c:if test="${dataMap.siteOrder.columns.status == '2' || dataMap.siteOrder.columns.status == '3' }">已完成</c:if>
                                </c:if>
                                <c:if test="${mark == 'zg' }">
                                    <!-- 工程师自购订单 -->
                                    <c:if test="${dataMap.siteOrder.columns.status eq 0 }">已取消</c:if>
                                    <c:if test="${dataMap.siteOrder.columns.status == '3'  }">待确认</c:if>
                                    <c:if test="${dataMap.siteOrder.columns.status == '5' }">已确认</c:if>
                                </c:if>
                            </span>
				</span>
        </div>
        <div class="mb-10">
            <table class="table table-bg table-border table-bordered table-sdrk text-c">
                <thead>
                <tr>
                    <th width="20%">商品</th>
                    <th width="15%">入库价</th>
                    <th width="15%">工程师价</th>
                    <th width="15%">零售价</th>
                    <th width="15%">销售数量</th>
                    <th width="15%">成交价</th>
                    <th width="15%">提成</th>
                </tr>
                </thead>
                <c:forEach var="orderDetails" items="${dataMap.orderDetailList}">
                    <tr>
                        <td>
                            ${orderDetails.columns.good_name}
                        </td>
                        <td>${orderDetails.columns.site_price}</td>
                        <td>${orderDetails.columns.employe_price}</td>
                        <td>${orderDetails.columns.customer_price}</td>
                        <td>${orderDetails.columns.purchase_num}</td>
                        <td>${orderDetails.columns.real_amount}</td>
                        <td>${orderDetails.columns.sales_commissions}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="orderMsg_">
            <div class="mb-5 lh-28">
				<span>
					商品总数：${dataMap.siteOrder.columns.purchase_num}
				</span>
                <span class="ml-100" style="width: 250px;" title="${dataMap.siteOrder.columns.placing_name}">
					销售人员：${dataMap.siteOrder.columns.placing_name}
				</span>
            </div>
            <div class="mb-5 lh-28">
				<span>
					成交总额：${dataMap.siteOrder.columns.real_amount}元
				</span>
                <span class="ml-100">
					实收金额：${dataMap.siteOrder.columns.confirm_amount}元
				</span>
            </div>
            <div class="mb-5 lh-28">
				<span>
					提成总额：${dataMap.siteOrder.columns.sales_commissions}元
				</span>
                <span class="ml-100">
					当日支付金额： ${dataMap.siteOrder.columns.paid_commissions}元
				</span>
            </div>

        </div>
        <span class="mb-10">提成明细：</span>
        <div class="tichengMsg mt-20">
            <c:if test="${dataMap.deductListCount gt 0}">
            <table class="table-bg table-border table-bordered table-sdrk text-c tcTable">
                <tbody>
                <tr>
                    <td rowspan="2"></td>
                    <c:forEach var="datalist" items="${dataMap.dataList}" varStatus="deductSta">
                        <c:if test="${deductSta.count eq 1}">
                        <c:forEach var="deduct" items="${dataMap.deductList}">
                            <c:if test="${deduct.columns.deductId ne null and deduct.columns.deductId ne ''}">
                                <c:if test="${datalist.columns.id eq deduct.columns.id}">
                                    <td colspan="2">${deduct.columns.salesman}</td>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        </c:if>
                    </c:forEach>
                </tr>
                <tr>
                    <c:forEach var="datalist" items="${dataMap.dataList}" varStatus="deductSta">
                        <c:if test="${deductSta.count eq 1}">
                        <c:forEach var="deduct" items="${dataMap.deductList}">
                            <c:if test="${deduct.columns.deductId ne null and deduct.columns.deductId ne '' and datalist.columns.id eq deduct.columns.id}">
                                <td width="130">提成</td>
                                <td width="130">当日支付</td>
                            </c:if>
                        </c:forEach>
                        </c:if>
                    </c:forEach>
                </tr>
                <c:forEach var="datalist" items="${dataMap.dataList}">
                    <tr>
                        <c:forEach var="deduct" items="${dataMap.deductList}" varStatus="deductSta">
                            <c:if test="${deduct.columns.deductId ne null and deduct.columns.deductId ne ''}">
                                <c:if test="${deductSta.count eq 1}">
                                    <td>${datalist.columns.good_name}</td>
                                </c:if>
                                <c:if test="${datalist.columns.id eq deduct.columns.id}">
                                    <td>${empty deduct.columns.sales_commissions ?'0.00':deduct.columns.sales_commissions}元</td>
                                    <td>${empty deduct.columns.paid_commissions ?'0.00':deduct.columns.paid_commissions}元</td>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </c:if>
        </div>
        <div class="tichengMsg mt-20 cl tcMark">
            <div class="bei">
                <span>备注：</span>
                <c:if test="${dataMap.siteOrder.columns.status ne '1' && dataMap.siteOrder.columns.status ne '4'}">
                    <span style="width: 80%;">
                        ${dataMap.siteOrder.columns.pay_mark}
                    </span>
                </c:if>
                <c:if test="${dataMap.siteOrder.columns.status == '1' || dataMap.siteOrder.columns.status == '4'}">
                    <input type="text" id="marksEdit" class="input-text" value="${dataMap.siteOrder.columns.pay_mark}" style="width:70%">
                    <a href="javascript:saveMark('${dataMap.siteOrder.columns.id}');" style="margin-left: 10px; margin-bottom: 39px;" class="sfbtn sfbtn-opt3  w-70 mr-5">保存</a>
                </c:if>
            </div>
        </div>
        <div class="mb-10 lh-28 mt-10">
				<span>
					下单人：${dataMap.siteOrder.columns.creator}
				</span>
            <span class="ml-100">
					下单时间：<fmt:formatDate value="${dataMap.siteOrder.columns.placing_order_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</span>
        </div>
        <div class="tit_">
            <span>收货信息</span>
        </div>
        <div class="mb-10 lh-28 mt-10">
				<span>
					用户姓名：${dataMap.siteOrder.columns.customer_name}
				</span>
            <span class="ml-100">
					联系方式：${dataMap.siteOrder.columns.customer_contact}
				</span>
        </div>
        <div class="mb-10 lh-28 mt-10">
				<span>
					详细地址：${dataMap.siteOrder.columns.customer_address}
				</span>
        </div>
        <div class="tit_">
            <span>修改记录</span>
        </div>

        <div class="mb-10 lh-28 mt-10">
				<span>
					<c:forEach var="pros" items="${fns:getFittingProcess(dataMap.siteOrder.columns.edit_detail)}">
                        ${pros.time}：${pros.content}<br/>
                    </c:forEach>
				</span>
        </div>
    </div>

    <c:if test="${mark == 'zy' }">
        <!-- 公司订单 -->
        <c:if test="${dataMap.siteOrder.columns.status == '2' || dataMap.siteOrder.columns.status == '3' }">
            <div class="btnsWrapFixbBg bgOpacity"></div>
            <div class="btnsWrapFixb pt-15 text-c">
                <a class="btnBlue pt-10 pb-10 lh-26 f-16 w-180 c-white radius mr-20" onclick="goUpdateGoodsOrdersPage('${dataMap.siteOrder.columns.id}')">修改</a>
            </div>
        </c:if>
    </c:if>
</div>


<!--_footer 作为公共模版分离出去-->
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    $('.tcTable').css('width',400+$('.tcTable td[colspan="2"]').length*200+'px')
    $(function () {
        tableHeight();
    })

    window.onresize = function () {
        tableHeight();
    }

    function tableHeight() {
        var wHeight = $('.sfpagebg').height() - 250;
        var contHeight = $('#tableBody').height();

        $('#tableBody').css({
            'max-height': wHeight + 'px',
            'overflow': 'auto',
        });

        var tWidth = $('#tableBody').find('.table').eq(0).width();
        $('#tableHead').width(tWidth);
    }

    function goUpdateGoodsOrdersPage(orderId){
        layer.open({
            type : 2,
            content:"${ctx}/goods/siteselfOrder/receivablesOrder?rowId="+orderId+"&goWhere=detailPage&mark="+'${mark}',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }


    function saveMark(orderId){
        var marks = $("#marksEdit").val();
        $.ajax({
            type:"post",
            dataType:"json",
            url:"${ctx}/goods/siteselfOrder/saveMarks",
            data:{orderId:orderId,marks:marks},
            success:function(data){
                if(data=='200'){
                    layer.msg("保存成功！");
                }else{
                    layer.msg("保存失败，请稍后重试！");
                }
                return ;
            },
            error:function(){
                layer.msg("保存失败，请稍后重试！");
                return ;
            }
        })
    }

</script>
</body>
</html>
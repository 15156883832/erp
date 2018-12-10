<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base"/>

    <!--[if IE 6]>
    <script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>思傅帮App设置</title>
</head>
<body >
<div class="sfpagebg bk-gray"><div class="sfpage">
    <div class="page-orderWait">
        <div class="tabBar cl mb-20">
            <a class="btn-tabBar current" href="${ctx}/order/orderMarkSet/appSetting">思傅帮App设置</a>
        </div>
        <div class="bk-gray f-14 bg-e2eefc">
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">工单结算</div>
                <div class="pl-30 pt-15 h-50 bb bg-fff" id="orderSettleMent">
                    <span class="w-200 mr-20 radSelect <c:if test="${settle eq '3'}">radSelected</c:if>"><input type="radio" name="gdjs" value="3"/> 不显示</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${settle eq '2'}">radSelected</c:if>"><input type="radio" name="gdjs" value="2"/> 只显示汇总</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${settle eq '1' || empty settle}">radSelected</c:if>"><input type="radio" name="gdjs" value="1"/> 显示汇总和明细</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">工单结算显示方式</div>
                <div class="pl-30 pt-15 h-50 bb bg-fff" id="orderSettleMentType">
                    <span class="w-200 mr-20 radSelect <c:if test="${settleType eq '3' || empty settleType}">radSelected</c:if>"><input type="radio" name="gdjsxsfs" value="3"/> 按结算归属日期显示</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${settleType eq '2'}">radSelected</c:if>"><input type="radio" name="gdjsxsfs" value="2"/> 按工单完工时间显示 </span>
                    <span class="w-200 mr-20 radSelect <c:if test="${settleType eq '1'}">radSelected</c:if>"><input type="radio" name="gdjsxsfs" value="1"/> 按工单报修时间显示</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">商品提成</div>
                <div class="pl-30 pt-15 h-50 bb bg-fff" id="goodsPushMoney">
                    <span class="w-200 mr-20 radSelect <c:if test="${goodsPushMoney eq '3'}">radSelected</c:if>"><input type="radio" name="sptc" value="3"/> 不显示</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${goodsPushMoney eq '2'}">radSelected</c:if>"><input type="radio" name="sptc" value="2"/> 只显示汇总</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${goodsPushMoney eq '1' || empty goodsPushMoney}">radSelected</c:if>"><input type="radio" name="sptc" value="1"/> 显示汇总和明细</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">新建工单</div>
                <div class="pl-30 pt-15 h-50 bb bg-fff" id="buildNewOrder">
                    <span class="w-200 mr-20 radSelect <c:if test="${buildNewOrder eq '2'}">radSelected</c:if>"><input type="radio" name="xjgd" value="2"/> 不允许</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${buildNewOrder eq '1' || empty buildNewOrder}">radSelected</c:if>"><input type="radio" name="xjgd" value="1"/> 允许</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">拍照显示定位</div>
                <div class="pl-30 pt-15 bb h-50  bg-fff" id="showMarkByPhotograph">
                    <span class="w-200 mr-20 radSelect <c:if test="${showMarkByPh eq '2' || empty showMarkByPh}">radSelected</c:if>"><input type="radio" name="noShowMark" value="2"/> 不显示</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${showMarkByPh eq '1'}">radSelected</c:if>"><input type="radio" name="showMark" value="1"/> 显示</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">ERP完工工单显示</div>
                <div class="pl-30 pt-15 bb h-50 bg-fff" id="showHistoryOrder">
                    <span class="w-200 mr-20 radSelect <c:if test="${showHistoryOrder eq '3'}">radSelected</c:if>"><input type="radio" name="showMark" value="3"/> 不显示</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${showHistoryOrder eq '2'}">radSelected</c:if>"><input type="radio" name="showMark" value="2"/> 显示近三个月工单</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${showHistoryOrder eq '1' || empty showHistoryOrder}">radSelected</c:if>"><input type="radio" name="noShowMark" value="1"/> 全部显示</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 bb pos pl-50 w-220 ">400工单显示</div>
                <div class="pl-30 pt-15 bb h-50 bg-fff" id="fourHistoryOrder">
                    <span class="w-200 mr-20 radSelect <c:if test="${fourHistoryOrder eq '2'}">radSelected</c:if>"><input type="radio" name="showMark" value="2"/> 显示近三个月的</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${fourHistoryOrder eq '1' || empty fourHistoryOrder}">radSelected</c:if>"><input type="radio" name="noShowMark" value="1"/> 全部显示</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50  bb pos pl-50 w-220 ">显示周边用户信息</div>
                <div class="pl-30 pt-15 bb h-50  bg-fff" id="showAroundUsers">
                    <span class="w-200 mr-20 radSelect <c:if test="${showAroundUsers eq '2' || empty showAroundUsers}">radSelected</c:if>"><input type="radio" name="showMark" value="2"/> 不显示</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${showAroundUsers eq '1'}">radSelected</c:if>"><input type="radio" name="noShowMark" value="1"/> 显示</span>
                </div>
            </div>
            <div class="cl h-50 pos-r pl-220">
                <div class="h-50 lh-50 pos pl-50 w-220 ">商品库存标记</div>
                <div class="pl-30 pt-15  h-50 bg-fff" id="showEmpGoodsBtn">
                    <span class="w-200 mr-20 radSelect <c:if test="${showEmpGoodsBtn eq '1'}">radSelected</c:if>"><input type="radio" name="showMark" value="1"/> 领取库存</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${showEmpGoodsBtn eq '2'}">radSelected</c:if>"><input type="radio" name="showMark" value="2"/> 自购库存</span>
                    <span class="w-200 mr-20 radSelect <c:if test="${showEmpGoodsBtn eq '0' || empty showEmpGoodsBtn}">radSelected</c:if>"><input type="radio" name="noShowMark" value="0"/> 全部显示</span>
                </div>
            </div>
        </div>
        <div class="mt-35 pt-20 text-c">
            <a class="sfbtn sfbtn-opt3 w-70" id="btn_save">保存</a>
        </div>
    </div>
</div></div>
<!--请在下方写此页面业务相关的脚本-->
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(function(){
        $('.radSelect').on('click', function(){
            var hasClass = $(this).hasClass('radSelected');
            var oP = $(this).parent('div'),
                aSelect = oP.find('.radSelect'),
                aRadio = oP.find('input')
            if( !hasClass ){
                aSelect.removeClass('radSelected');
                aRadio.prop({'checked':'false'});
                $(this).addClass('radSelected');
                $(this).find('input').prop({'checked':'true'});
            }
        })
    })


    var saving = false;
    $("#btn_save").on("click", function () {
        if (saving) {
            return false;
        }

        var settle = $("#orderSettleMent").find(".radSelected").children().val();
        var settleType = $("#orderSettleMentType").find(".radSelected").children().val();
        var goodsPushMoney = $("#goodsPushMoney").find(".radSelected").children().val();
        var buildNewOrder = $("#buildNewOrder").find(".radSelected").children().val();
        var showMarkByPh = $("#showMarkByPhotograph").find(".radSelected").children().val();
        var showHistoryOrder = $("#showHistoryOrder").find(".radSelected").children().val();
        var fourHistoryOrder = $("#fourHistoryOrder").find(".radSelected").children().val();
        var showAroundUsers = $("#showAroundUsers").find(".radSelected").children().val();
        var showEmpGoodsBtn = $("#showEmpGoodsBtn").find(".radSelected").children().val();
        saving = true;
        $.ajax({
            url: "${ctx}/order/orderMarkSet/saveAppSetting",
            type: "POST",
            data: {
                settle: settle,
                settleType: settleType,
                goodsPushMoney: goodsPushMoney,
                buildNewOrder: buildNewOrder,
                showMarkByPh: showMarkByPh,
                showHistoryOrder:showHistoryOrder,
                fourHistoryOrder:fourHistoryOrder,
                showAroundUsers:showAroundUsers,
                showEmpGoodsBtn:showEmpGoodsBtn
            },
            success: function (data) {
                if (data) {
                    layer.msg('保存成功！');
                }
            },
            complete: function () {
                saving = false;
            }
        });
    })

</script>
</body>
</html>
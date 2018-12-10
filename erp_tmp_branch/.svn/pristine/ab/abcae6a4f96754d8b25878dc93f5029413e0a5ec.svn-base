<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<h3 class="modelHead mb-10 mt-10">收入</h3>

<!-- 1.0迁移过来的结算 -->
<c:if test="${sittlementSource eq 'order1' }">
<div class="cl mt-10 ">
	<label class="f-l w-80">结算费：</label>
	<div class="f-l w-140 priceWrap readonly">
		<input type="text" class="input-text readonly" disabled="disabled" value="${st.orderSettlement.columns.sum_money }"/>
		<span class="unit">元</span>
	</div>
	<label class="f-l w-100">明细：</label> 
	<input type="text" class="input-text w-480 f-l readonly" disabled="disabled" value="${st.orderSettlement.columns.cost_detail }" />
</div>
<div class="cl mt-10 order1.0">
	<label class="f-l w-80">结算日期：</label> 
	<input type="text" class="input-text w-140 f-l readonly" disabled="disabled" value="<fmt:formatDate value="${st.orderSettlement.columns.create_time}" pattern="yyyy-MM-dd"/>" />
	<label class="f-l w-100">利润：</label> 
	<input type="text" class="input-text w-140 f-l readonly" disabled="disabled" value="${st.orderSettlement.columns.profits}"/>
	<label class="f-l w-100">结算人：</label> 
	<input type="text" class="input-text w-140 f-l readonly" disabled="disabled" value="${st.orderSettlement.columns.create_name }"/>
</div>
<div class="mt-10 cl mb-10 order1.0">
	<label class="f-l w-80">备注内容：</label> 
	<input type="text" class="input-text f-l readonly" style="width: 620px;" disabled="disabled" value="${st.orderSettlement.columns.remarks}" />
</div>
</c:if>

<!-- 2.0的结算 -->
<c:if test="${sittlementSource eq 'order2' }">
<div class="cl mb-10 ">
    <label class="w-110 text-r f-l">厂家结算费：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text readonly" readonly="readonly" value="${st.orderSettlement.columns.factory_money}"/>
        <span class="unit">元</span>
    </div>
</div>
<div class="cl mb-10 ">
    <label class="w-110 text-r f-l hide"><span class="c-005aab va-t">工单收费</span>：</label>
    <div class="priceWrap w-100 f-l readonly hide">
        <input type="text" class="input-text" readonly="readonly" value="${st.orderMoney}" />
        <span class="unit">元</span>
    </div>
    <label class="w-110 text-r f-l">APP中的服务费：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" readonly="readonly" value="${st.order.columns.serve_cost}" />
        <span class="unit">元</span>
    </div>
    <label class="w-110 text-r f-l">APP中的材料费：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" readonly="readonly" value="${st.order.columns.auxiliary_cost}" />
        <span class="unit">元</span>
    </div>
    <label class="w-110 text-r f-l">APP中的延保费：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" readonly="readonly" value="${st.order.columns.warranty_cost}" />
        <span class="unit">元</span>
    </div>
</div>
<h3 class="modelHead mb-10 ">支出</h3>
<div class="f-l lh-26">
	<span class="f-l">工程师结算费：</span>
	<span class="f-l"><input id="empCost" readonly="readonly" style="border:none" class="input-text w-60" value="${st.orderSettlement.columns.sum_money}" />元</span>
	<span class="f-l ml-10 c-888">（当日支付：<input id="payed" readonly="readonly" style="border:none" class="input-text w-60 c-888" value="${st.orderSettlement.columns.payment_amount}" /> 元）</span>
</div>
<div class="cl mb-10">
	<label class="w-100 text-r f-l"><span class="c-005aab va-t">材料成本</span>：</label>
	<div class="priceWrap w-100 f-l fucaiCostWrap readonly">
		<input type="text" class="input-text"  value="${st.orderSettlement.columns.fitting_costs}" id="afee" onkeyup="calcOverall();" readonly="readonly"/>
		<span class="unit">元</span>
	</div>
</div>
<%-- <div class="cl mb-10 ">
    <label class="w-100 text-r f-l"><span class="c-005aab va-t">材料成本</span>：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" readonly="readonly" value="${st.orderSettlement.fittingCosts}" />
        <span class="unit">元</span>
    </div>
</div>
<div class="cl mb-10 ">
    <label class="w-100 text-r f-l"><span class="c-005aab va-t">工程师结算费</span>：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" id="empcost" readonly="readonly" value="${st.orderSettlement.sumMoney}" />
        <span class="unit">元</span>
    </div>
</div>
<div class="cl mb-10 ">
    <label class="w-100 text-r f-l"><span class="c-005aab va-t">当日支付</span>：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" id="payed" readonly="readonly" value="${st.orderSettlement.paymentAmount}" />
        <span class="unit">元</span>
    </div>
</div> --%>
<div class="retractWrap ">
    <div class="pos-r pl-160 ">
        <div class="lb w-160">
            <a href="javascript:;" class="jsbtn mr-5 btn-retract">收起<i class="Hui-iconfont Hui-iconfont-arrow2-bottom ml-5"></i></a>
            <span class="lh-26 textColon">派单工程师结算</span>
        </div>
        <div class="cl" style="min-height: 26px;">
            <c:forEach var="item" items="${st.dispEmpSettlementDetail}">
                <div class="f-l mb-10">
                    <label class="f-l w-80 text-r textColon">${item.columns.employe_name}</label>
                    <div class="priceWrap w-70 f-l readonly">
                        <input type="text" class="input-text" readonly="readonly" value="${item.columns.sum_money}" />
                        <span class="unit">元</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="bk-blue-dotted pt-10 cl mb-10 retractBox">
    	<div class="cl">
	        <c:forEach items="${st.jiesuanItems}" var="item">
	            <div class="f-l mb-10">
	                <label class="w-100 text-r f-l textColon" title="${item.key}">${item.key}</label>
	                <div class="priceWrap w-100 f-l readonly">
	                    <input type="text" class="input-text" readonly="readonly" value="${item.value}" />
	                    <span class="unit">元</span>
	                </div>
	            </div>
	        </c:forEach>
	     </div>
	    <div class="pos-r pl-90 ml-10 mb-10" style="padding-right:17px;">
		    <label class="w-90 text-r lb textColon">备注</label>
		    <input type="text" class="input-text readonly " style="width:100%;" readonly="readonly" value="${st.orderSettlement.columns.remarks}"/>
		</div>
    </div>
</div>
<div class="retractWrap ">
    <div class="pos-r pl-160">
        <div class="lb w-160">
            <a href="javascript:;" class="jsbtn mr-5 btn-retract">收起<i class="Hui-iconfont Hui-iconfont-arrow2-top ml-5"></i></a>
            <span class="lh-26">添加工程师结算：</span>
        </div>
        <div class="cl" style="min-height: 26px;">
            <c:forEach var="item" items="${st.addedJisuan}">
                <div class="f-l mb-10">
                    <label class="f-l">${item.empName}：</label>
                    <div class="priceWrap w-70 f-l readonly">
                        <input type="text" class="input-text" readonly="readonly" value="${item.cost}" />
                        <span class="unit">元</span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="bk-blue-dotted pt-10 mb-10 retractBox" >
        <c:forEach items="${st.addedEmpSettlementDetail}" var="item">
            <div class="mb-5">
                <span class="w-80 text-r">${item.columns.employe_name}：</span>
                <span class="w-150">${item.columns.service_measures} </span>
                <span class="w-150">${item.columns.sum_money}元</span>
                <span class="w-150">${item.columns.remarks}</span>
                <span class="w-150 c-888"><fmt:formatDate value="${item.columns.settlement_time}" pattern="yyyy-MM-dd"/></span>
            </div>
        </c:forEach>
    </div>
</div>
<!--
<div class="order2.0">
    <div class="cl mb-10">
        <a href="javascript:;" class="f-l h-26"> <span class="c-005aab va-t">当日支付</span>：</a>
        <div class="priceWrap w-100 f-l readonly">
            <input type="text" class="input-text" value="20" />
            <span class="unit">元</span>
        </div>
    </div>
    <div class="cl pl-30">
        <div class="f-l mb-10">
            <label class="w-70 f-l text-r">张笑笑笑：</label>
            <div class="priceWrap w-70 f-l readonly">
                <input type="text" class="input-text" readonly="readonly" />
                <span class="unit">元</span>
            </div>
        </div>
    </div>
</div>
-->
<div class="cl mb-10 ">
    <label class="w-100 text-r f-l "><span class="c-005aab va-t">结算归属日期</span>：</label>
    <input type="text" value="<fmt:formatDate value="${st.orderSettlement.columns.settlement_time}" pattern="yyyy-MM-dd"/>" class="input-text w-140 f-l readonly" readonly="readonly">
</div>
<%-- <div class="pos-r pl-90 ml-10 ">
    <label class="w-90 text-r lb">备注：</label>
    <input type="text" class="input-text readonly" readonly="readonly" value="${st.orderSettlement.remarks}"/>
</div> --%>

<%--<h3 class="modelHead mb-10 ">利润</h3>--%>
<h3 class="modelHead mb-10">利润
    <span class="tiShi pr-80">（计算公式：利润=厂家结算费+工单收费-辅材成本-工程师结算费）</span>
    当日支付<span class="tiShi">（表示：当日支出的记账信息）</span>
</h3>
<div class="cl mb-10 order2.0">
    <label class="w-100 text-r f-l lh-26"> <span class="c-005aab va-t">利润</span>：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" value="${st.orderSettlement.columns.profits}" readonly="readonly"/>
        <span class="unit">元</span>
    </div>
    <label class="w-100 text-r f-l lh-26" style="margin-left: 320px"> <span class="c-005aab va-t">当日支付</span>：</label>
    <div class="priceWrap w-100 f-l readonly">
        <input type="text" class="input-text" value="${st.orderSettlement.columns.payment_amount}" id="payed-mirror" readonly="readonly"/>
        <span class="unit">元</span>
    </div>
</div>
</c:if>
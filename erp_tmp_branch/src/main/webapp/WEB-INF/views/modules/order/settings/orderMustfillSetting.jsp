<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base"/>
    <title>工单必填项设置</title>
</head>
<body >
<div class="sfpagebg bk-gray">
    <div class="page-orderWait">
        <div class="tabBar cl mb-20">
          	<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICECATE_TAB" html='<a class="btn-tabBar " href="${ctx}/order/category/headerList">服务品类</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICEBRAND_TAB" html='<a class="btn-tabBar" href="${ctx}/order/category/siteBrandRelList">服务品牌</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGORIGIN_TAB" html='<a class="btn-tabBar" href="${ctx}/order/orderOrigin">信息来源</a> '></sfTags:pagePermission>
	<%-- 	<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_TAB" html='<a class="btn-tabBar" href="${ctx}/order/malfunction">故障类型</a>'></sfTags:pagePermission>  --%>
			<a class="btn-tabBar" href="${ctx}/order/printdesign">工单打印模板</a>
			<a class="btn-tabBar current" href="${ctx}/order/orderMustFill/getMustFillInfo">工单必填项</a>
			<a class="btn-tabBar " href="${ctx}/order/township">乡镇设置</a>
			<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGMALL_TAB" html='<a class="btn-tabBar " href="${ctx}/order/orderMall">购机商场</a>'></sfTags:pagePermission>
			 <%-- <a class="btn-tabBar " href="${ctx}/order/siteSuperviseSetting">监督内容</a> --%>
			<a class="btn-tabBar " href="${ctx}/order/serviceType">服务类型</a>
			<a class="btn-tabBar " href="${ctx}/order/serviceMode">服务方式</a>
			<a class="btn-tabBar " href="${ctx}/order/customerType">用户类型</a>
        </div>
        <div class="cl mb-25 border3_ orderMustWrap orderMustSet">
            <h4 class="mustTop_">工单必填项设置</h4>
            <div class="pl-25">
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">工单编号 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">服务类型 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">服务方式 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">用户姓名 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">手机号码 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">详细地址 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">家电品牌 <i class="oItemChk"></i></span>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">家电品类 <i class="oItemChk"></i></span>
                <c:if test="${hasData eq true}">
                    <c:forEach var="re" items="${reList}">
                        <c:if test="${re.columns.name eq 'customerFeedback'}">
                            <span class="f-l mr-20  mb-40_ customerFeedback  orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">服务描述 <i class="oItemChk"></i></span>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${hasData ne true}">
                    <span class="f-l mr-20  mb-40_ customerFeedback orderMustItem orderMustChk">服务描述 <i class="oItemChk"></i></span>
                </c:if>
                <span class="f-l mr-20  mb-40_ orderMustItem orderMustDis">报修时间 <i class="oItemChk"></i></span>
                <c:if test="${hasData eq true}">
                    <c:forEach var="re" items="${reList}">
                        <c:if test="${re.columns.name eq 'origin'}">
                            <span class="f-l mr-20  mb-40_ origin orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">信息来源 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'promiseTime'}">
                            <span class="f-l mr-20  mb-40_ promiseTime orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">预约时间 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'promiseLimit'}">
                            <span class="f-l mr-20  mb-40_ promiseLimit orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">时间要求 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'remarks'}">
                            <span class="f-l mr-20  mb-40_ remarks orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">&#12288;&#12288;备注 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'applianceModel'}">
                            <span class="f-l mr-20  mb-40_ applianceModel orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">产品型号 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'applianceNum'}">
                            <span class="f-l mr-20  mb-40_ applianceNum orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">产品数量 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'applianceBarcode'}">
                            <span class="f-l mr-20  mb-40_ applianceBarcode orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">内机条码 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'applianceMachineCode'}">
                            <span class="f-l mr-20  mb-40_ applianceMachineCode orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">外机条码 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'applianceBuyTime'}">
                            <span class="f-l mr-20  mb-40_ applianceBuyTime orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">购买日期 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'pleaseReferMall'}">
                            <span class="f-l mr-20  mb-40_ pleaseReferMall orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">购买商城 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'warrantyType'}">
                            <span class="f-l mr-20  mb-40_ warrantyType orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">保修类型 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'level'}">
                            <span class="f-l mr-20  mb-40_ level orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">重要程度 <i class="oItemChk"></i></span>
                        </c:if>
                        <c:if test="${re.columns.name eq 'customerType'}">
                            <span class="f-l mr-20  mb-40_ customerType orderMustItem ${re.columns.status eq '0'?'orderMustChk':''}">用户类型 <i class="oItemChk"></i></span>
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${hasData ne true}">
                    <span class="f-l mr-20  mb-40_ origin orderMustItem">信息来源 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ promiseTime orderMustItem">预约时间 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ promiseLimit orderMustItem">时间要求 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ remarks orderMustItem">&#12288;&#12288;备注 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ applianceModel orderMustItem">产品型号 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ applianceNum orderMustItem">产品数量 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ applianceBarcode orderMustItem">内机条码 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ applianceMachineCode orderMustItem">外机条码 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ applianceBuyTime orderMustItem">购买日期 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ pleaseReferMall orderMustItem">购机商场 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ warrantyType orderMustItem">保修类型 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ level orderMustItem">重要程度 <i class="oItemChk"></i></span>
                    <span class="f-l mr-20  mb-40_ customerType orderMustItem">用户类型 <i class="oItemChk"></i></span>
                </c:if>
            </div>
        </div>
        <div class="cl mb-25 border3_ orderMustWrap orderFedMustSet">
            <h4 class="mustTop_">思傅帮APP服务反馈必填项</h4>
            <div class="pl-25">
                <span class="f-l mr-20 mb-40_ orderMustItem  orderMustDis">家电品牌 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  orderMustDis">家电品类 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  orderMustDis">反馈内容 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  orderMustDis">保修类型 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  orderMustDis">内机条码 <i class="oItemChk"></i></span>
            <c:if test="${hasDataFed ne true}">
                <span class="f-l mr-20 mb-40_ orderMustItem  applianceModel">产品型号 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  applianceBuyTime">购买日期 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  pleaseReferMall">购机商场 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  applianceMachineCode">外机条码 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  malfunctionType">故障现象 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  processImage">过程照片 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  serveCost">服务费 <i class="oItemChk"></i></span>
                <span class="f-l mr-20 mb-40_ orderMustItem  warrantyCost">延保费 <i class="oItemChk"></i></span>
            </c:if>
            <c:if test="${hasDataFed eq true}">
                <c:forEach var="re" items="${reListFed}">
                    <c:if test="${re.columns.name eq 'applianceModel'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} applianceModel">产品型号 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'applianceBuyTime'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} applianceBuyTime">购买日期 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'pleaseReferMall'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} pleaseReferMall">购机商场 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'applianceMachineCode'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} applianceMachineCode">外机条码 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'malfunctionType'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} malfunctionType">故障现象 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'processImage'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} processImage">过程照片 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'serveCost'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} serveCost">服务费 <i class="oItemChk"></i></span>
                    </c:if>
                    <c:if test="${re.columns.name eq 'warrantyCost'}">
                        <span class="f-l mr-20 mb-40_ orderMustItem ${re.columns.status eq '0'?'orderMustChk':''} warrantyCost">延保费 <i class="oItemChk"></i></span>
                    </c:if>
                </c:forEach>
            </c:if>
            </div>
        </div>
        <div class="text-c pt-30">
            <a class="sfbtn sfbtn-opt3 w-70 mr-10" onclick="saveData()">保存</a>
            <%--<a class="sfbtn sfbtn-opt w-70">取消</a>--%>
        </div>
    </div>
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
    $(function(){
        $('.orderMustWrap ').on('click','.orderMustItem' ,function(){
            if(!$(this).hasClass('orderMustDis') ){
                if($(this).hasClass('orderMustChk')){
                    $(this).removeClass('orderMustChk');
                }else{
                    $(this).addClass('orderMustChk');
                }
            }
        })
    })

    var submitRepeat=false;
    function saveData(){
        if(submitRepeat){
            return;
        }
        submitRepeat=true;
        var customer_feedback = $(".orderMustSet").find(".customerFeedback").hasClass("orderMustChk");
        var origin = $(".orderMustSet").find(".origin").hasClass("orderMustChk");
        var promise_time = $(".orderMustSet").find(".promiseTime").hasClass("orderMustChk");
        var promise_limit = $(".orderMustSet").find(".promiseLimit").hasClass("orderMustChk");
        var remarks = $(".orderMustSet").find(".remarks").hasClass("orderMustChk");
        var appliance_model = $(".orderMustSet").find(".applianceModel").hasClass("orderMustChk");
        var appliance_num = $(".orderMustSet").find(".applianceNum").hasClass("orderMustChk");
        var appliance_barcode = $(".orderMustSet").find(".applianceBarcode").hasClass("orderMustChk");
        var appliance_machine_code = $(".orderMustSet").find(".applianceMachineCode").hasClass("orderMustChk");
        var appliance_buy_time = $(".orderMustSet").find(".applianceBuyTime").hasClass("orderMustChk");
        var please_refer_mall = $(".orderMustSet").find(".pleaseReferMall").hasClass("orderMustChk");
        var warranty_type = $(".orderMustSet").find(".warrantyType").hasClass("orderMustChk");
        var level = $(".orderMustSet").find(".level").hasClass("orderMustChk");
        var customerType = $(".orderMustSet").find(".customerType").hasClass("orderMustChk");


        var applianceModel = $(".orderFedMustSet").find(".applianceModel").hasClass("orderMustChk");
        var applianceBuyTime = $(".orderFedMustSet").find(".applianceBuyTime").hasClass("orderMustChk");
        var pleaseReferMall = $(".orderFedMustSet").find(".pleaseReferMall").hasClass("orderMustChk");
        var applianceMachineCode = $(".orderFedMustSet").find(".applianceMachineCode").hasClass("orderMustChk");
        var malfunctionType = $(".orderFedMustSet").find(".malfunctionType").hasClass("orderMustChk");
        var processImage = $(".orderFedMustSet").find(".processImage").hasClass("orderMustChk");
        var serveCost = $(".orderFedMustSet").find(".serveCost").hasClass("orderMustChk");
        var warrantyCost = $(".orderFedMustSet").find(".warrantyCost").hasClass("orderMustChk");


        $.ajax({
            url:"${ctx}/order/orderMustFill/saveMustFill",
            type:"post",
            data:{
                customerFeedback:customer_feedback,
                origin:origin,
                promiseTime:promise_time,
                promiseLimit:promise_limit,
                remarks:remarks,
                applianceModel:appliance_model,
                applianceNum:appliance_num,
                applianceBarcode:appliance_barcode,
                applianceMachineCode:appliance_machine_code,
                applianceBuyTime:appliance_buy_time,
                pleaseReferMall:please_refer_mall,
                warrantyType:warranty_type,
                level:level,
                customerType:customerType,
                applianceModelF:applianceModel,
                applianceBuyTimeF:applianceBuyTime,
                pleaseReferMallF:pleaseReferMall,
                applianceMachineCodeF:applianceMachineCode,
                malfunctionTypeF:malfunctionType,
                processImageF:processImage,
                serveCostF:serveCost,
                warrantyCostF:warrantyCost
            },success:function(result){
                layer.msg("保存成功！");
            },complete:function(){
                submitRepeat=false;
            }
        })
    }


</script>
</body>
</html>

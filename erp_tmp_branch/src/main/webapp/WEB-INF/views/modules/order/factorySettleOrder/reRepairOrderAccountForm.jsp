<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>维修单录入(重新提交)</title>
    <meta name="decorator" content="base"/>

    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
    <style type="text/css">

        .spimg1 .webuploader-pick{
            width:134px;
            height:134px;
        }
    </style>
</head>

<body>
<div class="popupBox odWrap orderdetailVb">
    <h2 class="popupHead">
        重新提交
        <a href="javascript:;" class="sficon closePopup" id="closDivPoup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <div class="popupMain pos-r pb-50" >
            <div class="pcontent" style="padding-right: 20px">
                <div id="detialWd" class=" pr-15">
                    <div class="tabBarP mb-15" style="overflow: visible;">
                        <a href="javascript:;" class="tabswitch current">基本信息</a>
                    </div>
                    <div class="cl mb-10">
                        <div class="f-l">
                            <label class="f-l w-80">工单编号：</label>
                            <input type="text" id="orderNumber" class="input-text w-160 readonly f-l" readonly="readonly" value="${order.number }"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">服务类型：</label>
                            <input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.serviceType}"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">服务方式：</label>
                            <input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.serviceMode }"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">信息来源：</label>
                            <input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.origin }"/>
                        </div>
                    </div>
                    <div class="cl mb-15">
                        <div class="f-l">
                            <label class="f-l w-80">重要程度：</label>
                            <c:if test="${order.level eq '1' }">
                                <input type="text" class="input-text w-160 readonly f-l" readonly="readonly" value="紧急"/>
                            </c:if>
                            <c:if test="${order.level eq '2' }">
                                <input type="text" class="input-text w-160 readonly f-l" readonly="readonly" value="一般"/>
                            </c:if>
                            <c:if test="${order.level ne '1' && order.level ne '2' }">
                                <input type="text" class="input-text w-160 readonly f-l" readonly="readonly" value=""/>
                            </c:if>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">报修时间：</label>
                            <input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">登记人：</label>
                            <input type="text" class="input-text w-140 readonly f-l" readonly="readonly" value="${order.xm}"/>
                        </div>
                    </div>
                    <div class="line mb-15"></div>
                    <div class="cl mb-10">
                        <div class="f-l ">
                            <label class="f-l w-80"><em class="mark hide ">*</em>用户姓名：</label>
                            <input id="customerName" type="text" class="input-text w-160 readonly f-l remarkUpdate " readonly="readonly"  value="${order.customerName }"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100 reLX1" >联系方式1：</label>
                            <input id="customerMobile" type="text" class="input-text w-140 readonly f-l remarkUpdate " readonly="readonly"  value="${order.customerMobile }"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">联系方式2：</label>
                            <input id="customerTelephone" type="text" class="input-text w-140 readonly f-l remarkUpdate" readonly="readonly"  value="${order.customerTelephone }"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">联系方式3：</label>
                            <input id="customerTelephone2" type="text" class="input-text w-140 readonly f-l remarkUpdate" readonly="readonly" value="${order.customerTelephone2 }"/>
                        </div>
                    </div>
                    <div class="cl mb-15">
                        <div class="f-l" id="pcd">
                            <label class="f-l w-80">详细地址：</label>
                            <%--<input type="text" class="input-text w-100 mr-15 readonly f-l" readonly value="${order.customerProvince }"/>--%>
                        <%--    <input type="text" class="input-text w-100 mr-15 readonly f-l" readonly value="${order.customerCity }"/>
                            <input type="text" class="input-text w-100 mr-10 readonly f-l" readonly value="${order.customerArea }"/>--%>
                            <input type="text" class="input-text readonly f-l w-400 " value="${order.customerAddress }"/>
                        </div>
                    </div>
                    <div class="line mb-15"></div>
                    <div class="cl mb-10">
                        <div class="f-l">
                            <label class="f-l w-80">家电品牌：</label>
                            <input type="text" class="input-text w-160 f-l readonly" readonly="readonly" value="${order.applianceBrand}"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">家电品类：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${order.applianceCategory }"/>
                        </div>

                        <div class="f-l">
                            <label class="f-l w-100">产品型号：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${order.applianceModel}"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">产品数量：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="applianceNum" value="${order.applianceNum }"/>
                        </div>
                    </div>

                    <div class="cl mb-10">
                        <div class="f-l">
                            <label class="f-l w-80">内机条码：</label>
                            <input type="text" class="input-text w-160 f-l readonly" readonly="readonly" value="${order.applianceBarcode}" title="${order.applianceBarcode}"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">外机条码：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="${order.applianceMachineCode}" title="${order.applianceMachineCode}"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">购买日期：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">购机商场：</label>
                            <input type="text" name="pleaseReferMall" class="input-text w-140 f-l readonly" readonly="readonly" value="${order.pleaseReferMall}">
                        </div>
                    </div>
                    <div class="cl mb-10">
                        <div class="f-l">
                            <label class="f-l w-80">保修类型：</label>
                            <c:if test="${order.warrantyType eq 1 }">
                                <input type="text" class="input-text w-160 f-l readonly" readonly="readonly"  value="保内"/>
                            </c:if>
                            <c:if test="${order.warrantyType eq 2 }">
                                <input type="text" class="input-text w-160 f-l readonly" readonly="readonly"  value="保外"/>
                            </c:if>
                            <c:if test="${order.warrantyType ne 1 && order.warrantyType ne 2}">
                                <input type="text" class="input-text w-160 f-l readonly" readonly="readonly"  value=""/>
                            </c:if>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">预约日期：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
                        </div>
                        <div class="f-l">
                            <label class="f-l w-100">时间要求：</label>
                            <input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${order.promiseLimit }"/>
                        </div>
                    </div>
                    <div class="cl mb-10 pos-r pl-80 h-50">
                        <label class="w-80 pos">服务描述：</label>
                        <textarea type="text" class="input-text h-50 readonly" style="width: 880px;" readonly="readonly">${order.customerFeedback}</textarea>
                    </div>
                    <div class="cl mb-10 pos-r pl-80 h-50">
                        <label class="w-80 pos">备注：</label>
                        <textarea type="text" class="input-text h-50 readonly" style="width: 880px;" readonly="readonly" >${order.remarks}</textarea>
                    </div>

                </div>
                <div id="serveFb" class="mb-15 pr-15">
                    <div class="tabBarP">
                        <a href="javascript:;" class="tabswitch current">服务反馈</a>
                        <a href="javascript:showSYMsg();" class="tabswitch" style="width: 100px">保内使用备件</a>
                    </div>
                    <div class="tabCon">
                        <div class="cl mt-10">
                            <div class="f-l ">
                                <label class="f-l w-80">服务状态：</label>
                                <input type="text" class="input-text w-160 f-l readonly" readonly="readonly"  value="${dispStatus}"/>
                            </div>
                            <div class="f-l">
                                <label class="f-l w-100">服务工程师：</label>
                                <input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="${order.employeName}" title="手机号：${msg2Mobiles}" />
                            </div>
                            <div class="f-l">
                                <label class="f-l w-100">故障现象：</label>
                                <input type="text" class="input-text w-380 f-l readonly" readonly="readonly"  value="${order.malfunctionType}"/>
                            </div>
                        </div>
                        <div class="cl mt-10">
                            <div class="pos-r pl-80">
                                <label class="pos w-80">服务反馈：</label>
                                <div class="readonly processWrap2" style="width: 880px">
                                    <c:forEach var="fbItems" items="${feedbackInfo.feedbackResults}">
                                        <p class="processItem">
                                            <span class="time">${fbItems.feedbackTime} </span>
                                            <span>${fbItems.feedbackName }：${fbItems.feedbackResults }</span>
                                        </p>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tabCon">
                        <div style="overflow: auto;">
                            <table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
                                <caption>工单关联配件使用</caption>
                                <thead>
                                <tr>
                                    <th class="w-180">备件条码</th>
                                    <th class="w-260">备件名称</th>
                                    <th class="w-120">备件型号</th>
                                    <th class="w-90">最新入库价格</th>
                                    <th class="w-80">工程师价格</th>
                                    <th class="w-70">零售价格</th>
                                    <th class="w-50">数量</th>
                                    <th class="w-70">收费金额</th>
                                    <th class="w-70">状态</th>
                                </tr>
                                </thead>
                            </table>
                        </div>

                    </div>
                </div>

                <div class="pr-15">
                    <h3 class="modelHead mb-10">结算项</h3>
                    <div style="overflow: auto;" class="mb-10">
                        <table id="" class="table table-border table-bordered table-bg table-relatedorder">
                            <thead>
                            <tr>
                                <c:forEach items="${settlementTempList}" var="settlTemp">
                                    <th style="width:160px">${settlTemp.columns.name}</th>
                                </c:forEach>
                                <th class="w-90">操作</th>
                            </tr>
                            </thead>
                            <tbody id="settlements">
                            <tr>
                                <c:forEach items="${settTempListMap}" var ="list">
                                    <td>
                                        <c:forEach items="${list}" var="list1" begin="0" end="0">
                                            <c:if test="${list1.columns.attrib=='1' || empty list1.columns.attrib}">
                                                <select class="select mainId readonly w-140" multiline="true" disabled >
                                                    <option value=""></option>
                                                    <c:forEach items="${list}" var="list2">
                                                        <option value="${list2.columns.main_id}">${list2.columns.value}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                            <c:if test="${list1.columns.attrib!='1' && not empty list1.columns.attrib}">
                                                <select class="select mainId w-140" multiline="true" >
                                                    <option value="">请选择</option>
                                                    <c:forEach items="${list}" var="list2">
                                                        <option value="${list2.columns.main_id}">${list2.columns.value}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </c:forEach>
                                <td class="w-40">
                                    <a class="delete hide" href="javascript:;" onclick="delSettleItem(this)"><i class="sficon sficon-del "></i></a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

            <div class="pt-10 text-c btnWrap">
                <a class="sfbtn sfbtn-opt3 w-70 mr-10" href="javascript:submitRepairOrder();">提交</a>
                <a class="sfbtn sfbtn-opt w-70 mr-10" href="javascript:cancel();">取消</a>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    $("#closDivPoup").on("click",function(){
        parent.search();
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
    });
    $('#imgshow').imgShow();
    $(function(){
        $('#wxImgList').imgShow();
        $("#orderNumber").prop("disabled",false);
        $("#orderNumber").prop("readonly",true);

        $('#minusWrap').removeClass('minusWrap');
        $('#minusWrap').find('.prefix').hide();

        //2.监听父层按钮的动作
        $('#pngfix-nav-btn', parent.document).click(function(){
            //3.给定一个时间点
            setTimeout(function(){
                //4.再次执行全屏
                layer.restore(full_idx);
            },200);
        });
        $.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
        $.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");

        $('.orderdetailVb').popup({fixedHeight:false});

        $("#settlements").find("select").select2();
        $(".selection").css("width","140px");

        valuChange();
    });

    //获取工单关联备件使用信息
    function showSYMsg(){
        var orderNumber = "${order.number}";
        var str="";
        var imgstr="";
        var img = [];
        $.ajax({
            url:"${ctx}/factoryorder/orderCheck/showSYMsg",
            data:{orderNumber:orderNumber,remark:'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
            dataType:'json',
            async:false,
            success:function(result){
                $("#pjsy").html("<caption>工单关联配件使用</caption>"+
                    "<thead>" +
                    "<tr>" +
                    "<th class='w-180'>备件条码</th>" +
                    "<th class='w-260'>备件名称</th>" +
                    "<th class='w-120'>备件型号</th>" +
                    "<th class='w-90'>最新入库价格</th>" +
                    "<th class='w-80'>工程师价格</th>" +
                    "<th class='w-70'>零售价格</th>" +
                    "<th class='w-50'>数量</th>" +
                    "<th class='w-70'>收费金额</th>" +
                    "<th class='w-100'>使用类型</th>" +
                    "<th class='w-70'>状态</th>" +
                    "</tr>" +
                    "</thead>");
                /* $(".showimg").html("<label class='lb lb1'>备件图片：</label>"); */

                if(result.list.length>0){
                    $.each(result.list, function (index, val) {
                        str += "<tr>" +
                            "<td class='w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='w-90'>" + val.columns.site_price + "</td>" +
                            "<td class='w-80'>" + val.columns.employe_price + "</td>" +
                            "<td class='w-70'>" + val.columns.customer_price + "</td>" +
                            "<td class='w-50'>×" + val.columns.used_num + "</td>" +
                            "<td class='w-70'>" + val.columns.collection_money + "</td>";
                        if(val.columns.warranty_type=="1"){
                            str+="<td class='text-c  w-100'>保内使用</td>";
                        }else if(val.columns.warranty_type=="2"){
                            str+="<td class='text-c  w-100'>保外零售</td>";
                        }else{
                            str+="<td class='text-c  w-100'></td>";
                        }
                        if (val.columns.status == "1") {
                            str += "<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
                        } else if (val.columns.status == "2") {
                            str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
                        }
                    });
                }else{
                    $(".showimg").html("");
                }

                $("#pjsy").append(str);
                return;
            }

        });
    }

    function valuChange(){
        var noInfluence=false;
        $("#settlements").find(".mainId").off("change.s");
        $("#settlements").find(".mainId").on("change.s",function(e){
            if(noInfluence){
                return;
            }
            var mainId=$(this).val();
            noInfluence=true;
            $(this).parent("td").parent("tr").find(".mainId").val(mainId).trigger("change");
            $(this).parent("td").parent("tr").find(".mainId").attr("disabled","disabled");
            addSettleItem();
            noInfluence=false;
        });
    }


    function addSettleItem(){
        var orderId='${order.id}';
        $.ajax({
            url:"${ctx}/order/orderSettlement/getAllSettleDetail",
            data:{"orderId":orderId},
            dataType:'json',
            success:function(result){
                var html='<tr>';
                for(var m=0;m<result.length;m++){
                    html+='<td>';
                    var list=result[m];
                    for(var j=0;j<1;j++){
                        if(list[j].columns.attrib=='1' || isBlank(list[j].columns.attrib)){
                            html+=' <select class="select mainId w-140 readonly" disabled> <option value=""></option>';
                            for(var i=0;i<list.length;i++){
                                html+='<option value="'+list[i].columns.main_id+'">'+list[i].columns.value+'</option>';
                            }
                            html+='<select>';
                        }else{
                            html+=' <select class="select mainId w-140"> <option value="">请选择</option>';
                            for(var i=0;i<list.length;i++){
                                html+='<option value="'+list[i].columns.main_id+'">'+list[i].columns.value+'</option>';
                            }
                            html+='<select>';
                        }
                    }
                    html+='</td>';
                }
                html+='<td><a class="delete hide" href="javascript:;" onclick="delSettleItem(this)"><i class="sficon sficon-del "></i></a> </td></tr>';
                $("#settlements").find(".delete").removeClass("hide");
                $("#settlements").append(html);

                $("#settlements").find(".mainId").select2();
                $(".selection").css("width","140px");
                valuChange();
            }
        })
    }

    function delSettleItem(del){
        $(del).parent("td").parent("tr").remove();
    }

    var norepeatSub=false;
    function submitRepairOrder(){
        if(norepeatSub){
            return;
        }
        var orderId= "${order.id}";
        var selecter=$("#settlements").find("tr");
        var mainIds="";
        $(selecter).each(function(index,element){
            var html=$(element).find("select").get(0);
            if(!isBlank($(html).val())){
                mainIds+=$.trim($(html).val())+",";
            }
        })

        if(isBlank(mainIds)){
            layer.msg("请选择结算项");
        }else{
            norepeatSub=true;
            $.ajax({
                url:"${ctx}/order/orderSettlement/reWriteRepairOrder",
                data:{
                    mainIds:mainIds,
                    orderId:orderId
                },
                dataType:'json',
                success:function(result){
                    if(result.code=="200"){
                        window.top.layer.msg("提交成功");
                        window.parent.reloadGride();
                        $.closeDiv($(".orderdetailVb"));
                    }else if(result.code=="201"){
                        layer.msg("提交失败");
                    }else{
                        layer.msg("出现未知异常");
                    }
                },complete:function(){
                    norepeatSub=false;
                }
            })
        }
    }

    function cancel(){
        $.closeDiv($(".orderdetailVb"));
    }

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }


</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>
<body>
<!-- 维护发票寄送地址 -->
<div class="popupBox w-600 receiptAddress">
    <h2 class="popupHead">
        维护发票寄送地址
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <form id="invoiceaddressform">
        <div class="popupContainer pb-50">
            <div class="popupMain pt-25 pb-30">
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>收件人姓名：</label>
                    <input type="text" class="input-text f-l w-320" name="receiverName" id="receiverName" value="${invoiceAddress.columns.receiver_name}" datatype="*" nullmsg="请填写收件人姓名"  />
                </div>

                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>收件人地址：</label>
                    <select class="select f-l w-100" id="province" name="receiverProvince">
                        <c:forEach items="${provincelist }" var="pro">
                            <option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==invoiceAddress.columns.receiver_province }">selected="selected"</c:if><c:if test="${pro.columns.ProvinceName==site.columns.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
                        </c:forEach>
                    </select>
                    <select class="select f-l w-100 ml-10" id="city" name="recevierCity">
                        <c:forEach items="${cities }" var="cs">
                            <option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==invoiceAddress.columns.recevier_city }">selected="selected"</c:if><c:if test="${pro.columns.ProvinceName==site.columns.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
                        </c:forEach>
                    </select>
                    <select class="select f-l w-100 ml-10" id="area" name="receiverArea">
                        <c:forEach items="${districts }" var="ds">
                            <option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==invoiceAddress.columns.receiver_area }">selected="selected"</c:if><c:if test="${pro.columns.ProvinceName==site.columns.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
                        </c:forEach>
                    </select>
                    <input type="text" class="input-text f-l w-320 mt-10" style="margin-left: 180px;" placeholder="请输入详细地址" name="recevierAddress" id="recevierAddress" value="" datatype="*" nullmsg="请填写详细地址" ignore="ignore"  />
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>邮政编码：</label>
                    <input type="text" class="input-text f-l w-320" value="${invoiceAddress.columns.postcode}" name="postcode" id="postcode"  datatype="*" nullmsg="请填写邮政编码"/>
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>手机号：</label>
                    <input type="text" class="input-text f-l w-320" value="${invoiceAddress.columns.recevier_mobile}" name="recevierMobile" id="recevier_mobile" datatype="mobiles" nullmsg="请填写手机号" errormsg="请填写真实的手机号" />
                </div>
            </div>
            <div class="text-c btbWrap">
                <a href="javascript:;" id="subBtn" class="sfbtn sfbtn-opt3">保存</a>
                <a href="javascript:;" class="sfbtn sfbtn-opt" onclick="quxiaomsg()">取消</a>
            </div>
        </div>
    </form>

</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script>
    $(function () {
        if('${invoiceAddress.columns.recevier_address}'!=null&&'${invoiceAddress.columns.recevier_address}'!=""){
            $("#recevierAddress").val('${invoiceAddress.columns.recevier_address}');
        }else{
            if('${site.columns.address}'!=null&&'${site.columns.address}'!=""){
               $("#recevierAddress").val('${site.columns.address}');
            }
        }
        $('.receiptAddress').popup();
        $('#invoiceaddressform').Validform({
            btnSubmit: "#subBtn",
            ignoreHidden:true,
            tiptype: function (msg, o, cssctl) {
                if (msg) {
                    layer.msg(msg);
                }
            },
            beforeSubmit:function(curform){

            },
            postonce: true,
            datatype: {
               "mobiles":/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/
            },
            callback: function (form) {
                $.ajax({
                    url: "${ctx}/finance/invoiceMsg/saveinvoiceAddress",
                    type: "POST",
                    data: $("#invoiceaddressform").serialize(),
                    success: function (data) {
                        if (data == "saveok") {
                            parent.layer.msg("保存成功");
                            parent.window.location.reload(true);
                            $.closeDiv($('.maintainReceipt'));
                        } else if(data == "updateok"){
                            parent.layer.msg("修改成功");
                            parent.window.location.reload(true);
                            $.closeDiv($('.maintainReceipt'));
                        }else{
                            layer.msg(data);
                        }
                    }
                });
                return false;
            }
        });
    });

    function quxiaomsg(){
        $.closeDiv($(".receiptAddress"));
    }

    $(function () {
        $("#province").change(function () {
            var province = $("#province").val();
            $.ajax({
                type: "post",
                url: "${ctx}/order/getCity",
                async: false,
                data: {
                    province: province
                },
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    var length = obj.length;
                    if (length < 1) {
                        layer.msg("无数据");
                    } else {
                        $("#city").empty();
                        $("#area").empty();
                        var HTML = " ";
                        for (var i = 0; i < length; i++) {
                            if (i == 0) {
                                HTML += '<option value="' + obj[i].columns.CityName + '" selected="selected">'
                                    + obj[i].columns.CityName
                                    + '</option>';
                            } else {
                                HTML += '<option value="' + obj[i].columns.CityName + '">'
                                    + obj[i].columns.CityName
                                    + '</option>';
                            }
                        }
                        $("#city").append(HTML);
                    }
                },
                error: function () {
                    return;
                },
                complete: function () {
                    var cls = $("#city").find(
                        "option:selected").prop(
                        "value");
                    $.ajax({
                        type: "post",
                        url: "${ctx}/order/getArea",
                        async: true,
                        data: {
                            city: cls
                        },
                        dataType: "json",
                        success: function (data) {
                            var obj = eval(data);
                            var length = obj.length;
                            if (length < 1) {
                                layer.msg("无数据");
                            } else {
                                $("#area").empty();
                                var HTML = " ";
                                for (var i = 0; i < length; i++) {
                                    if (i == 0) {
                                        HTML += '<option value="' + obj[i].columns.DistrictName + '" selected="selected">'
                                            + obj[i].columns.DistrictName
                                            + '</option>';
                                    } else {
                                        HTML += '<option value="' + obj[i].columns.DistrictName + '" >'
                                            + obj[i].columns.DistrictName
                                            + '</option>';
                                    }
                                }
                                $("#area").append(HTML);
                            }
                        }
                    });
                    return;
                }
            });
        });
    });
    // 选择市获取区县
    $("#city").change(
        function () {
            var city = $("#city").val();
            $.ajax({
                type: "post",
                url: "${ctx}/order/getArea",
                async: false,
                data: {
                    city: city
                },
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    var length = obj.length;
                    if (length < 1) {
                        layer.msg("无数据");
                    } else {
                        $("#area").empty();
                        var HTML = " ";
                        for (var i = 0; i < length; i++) {
                            if (i == 0) {
                                HTML += '<option value="' + obj[i].columns.DistrictName + '" selected="selected">'
                                    + obj[i].columns.DistrictName
                                    + '</option>';
                            } else {
                                HTML += '<option value="' + obj[i].columns.DistrictName + '" >'
                                    + obj[i].columns.DistrictName
                                    + '</option>';
                            }
                        }
                        $("#area").append(HTML);
                    }
                }
            });
        });

</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>我的商品-购买美洁力底座</title>
    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
    <style>

    </style>

</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="pd-20 ndlbPage ">
        <div class="">
            <form id="orderForm" >
                <div class="mb-25">
                    <table class="table buyDetailTable text-c">
                        <thead>
                        <tr>
                            <th class="w-340">商品信息</th>
                            <th class="w-120">商品单价</th>
                            <th class="w-150">VIP会员价</th>
                            <th class="w-150">建议零售价</th>
                            <th class="w-190">购买数量</th>
                            <th class="w-120">小计</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr id="10ANan" class="radius ">
                            <td>
                                <div class="wrap1 text-l ">
                                    <div class="imgWrap imgWrap">
                                        <img id="10AImage" src="${commonStaticImgPath}${images}" class="img pos"/>
                                        <div class="pl-25">
                                            <h3 class="lh-30 f-14 goodName1">${platform.columns.name}</h3>
                                            <p class="c-888 f-12 lh-20">${platform_columns.description}</p>
                                        </div>
                                    </div>
                                    <p class="pos-r pl-20 c-666 f-12 mt-5">
                                        <%-- <i class="sficon1 sficon-note2 pos"></i>10A适用家用普通插座，例如冰箱、洗衣机等--%>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="wrap1">￥<span id="10ANoVIPPrice">${platform.columns.no_vip_price}</span>
                                </div>
                            </td>
                            <td>
                                <div class="wrap1"><span class="c-0383dc">￥<span id="10AVIPPrice">${platform.columns.site_price}</span></span></div>
                            </td>
                            <td>
                                <div class="wrap1">￥${platform.columns.advice_price}</div>
                            </td>
                            <td>
                                <div class="wrap1 w-140" style="margin: 0 auto;">
                                    <div class="countWrap w-140 mb-5">
                                        <a class="btn-minus" href="javascript:subNum(10);"></a>
                                        <input type="text" id="adj_num" readonly name="quantity" class="input-text text-c readonly" value="15"/>
                                        <a class="btn-plus" href="javascript:addNum(10);"></a>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="wrap1"><strong class="c-fd6e32 f-20">￥<span id="orderZong" class="va-t"></span></strong>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="cl mb-10 hide">
                        <div class="f-l">
                            <span id="diqu"></span>
                        </div>
                        <input type="hidden" name="price" value="${platform.columns.site_price }"/>
                        <input type="hidden" name="pid" value="${platform.columns.id }"/>
                        <input type="hidden" name="payType" value="alipay"/>
                        <input type="hidden" name="orderNumber" value=""/>
                        <input type="hidden" id="img-input"  name="icon" value="">
                        <input type="hidden" id="siteprovince" name="province" value="${site.province}">
                        <input type="hidden" id="sitecity" name="city" value="${site.city}">
                        <input type="hidden" id="sitearea" name="area" value="${site.area}">
                        <input type="hidden" name="zong" value="">
                    </div>
                </div>
                <div class="bg-e2eefc pt-10 pb-10 mb-15">
                    <div class="cl mb-10">
                        <label class="f-l w-100"><em class="mark">*</em> 收件人：</label>
                        <input name="customerName" class="input-text w-370 f-l bg-fff" nullmsg="请输入收件人" datatype="*" maxlength="20" />
                        <label class="f-l w-130"><em class="mark">*</em> 联系方式：</label>
                        <input name="customerMobile" class="input-text w-370 f-l bg-fff" nullmsg="请检查联系方式" errormsg="联系方式格式不正确" datatype="m" maxlength="20"/>
                    </div>
                    <div class="cl " id="pcd">
                        <label class="f-l w-100"><em class="mark">*</em> 详细地址：</label>
                        <select class="select f-l w-160 bg-fff mr-10 prov" id="province">
                            <option value="">请选择省份</option>
                        </select>
                        <select class="select f-l w-160 bg-fff mr-10 city" id="city">
                            <option value="">请选择市</option>
                        </select>
                        <select class="select f-l w-160 bg-fff mr-10 dist" id="area">
                            <option value="">请选择区/县</option>
                        </select>
                        <input class="input-text w-360 f-l bg-fff" name="customerAddress" placeholder="请输入详细地址" nullmsg="请输入详细地址" datatype="*" maxlength="100" />
                    </div>
                </div>

                <div class="cl mb-5">
                    <label class="f-l w-100">支付方式：</label>
                    <div class="f-l" id="payWayBox">
                        <div class="payWay payWay_zfb payWayCur f-l mr-20 pay-by-zfb">
                            <i class="payWay_icon"></i>
                        </div>
                        <div class="payWay payWay_wx f-l mr-20 pay-by-wx">
                            <i class="payWay_icon"></i>
                        </div>
                    </div>
                </div>
                <p class="ml-100 sficon1 sficon-note2 c-888 mb-10">建议使用支付宝</p>
                <div class="line-solid mb-10"></div>
                <div class="cl f-14">
                    <div class="f-r">
                        <span class="mr-10">应付金额：<strong class="c-fd6e32 f-26">￥</strong><strong class="c-fd6e32 f-26" id="zong" name="zong"></strong></span>
                    </div>
                </div>
                <div class="cl">
                    <div class="f-r">
                        <span class="mr-10 hide" id="openVIP"><a class="c-fd6e32 underline va-t sficon1 sficon-crown1 mr-5 f-14" onclick="jumpToVIP()">开通会员</a><span class="f-13">立减<span class="yohuiPrice va-t">0</span></span></span>
                        <span class="mr-10" id="hadYouHui">已优惠：<span class="">￥<span class="yohuiPrice" >0</span></span></span>
                        <a class="btn_buy ml-10 goumai"  id="immPay">购买</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<div id="sty" class="popupBox spPayWrap wxPay">
    <h2 class="popupHead">
        <!--支付宝支付-->
        <span id="payHead">微信支付</span>
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain">
            <h3 class="payTitle">
                思方收银台
            </h3>
            <div class="payOrder cl">
                <div class="f-l c-666 w-340">
                    <p>收货人：<span id="shouHR"></span></p>
                    <p>&#12288;电话：<span id="tel"></span></p>
                    <p>&#12288;地址：<span id="address"></span></p>
                </div>
                <div class="f-r f-13">
                    <p >订单编号：${number }</p>
                    <p>订单类型：平台产品</p>
                    <p>应付金额：<span class="f-20 money" id="money"></span></p>
                </div>
            </div>

            <!-- 支付二维码部分-->
            <div class="payment hide1">
                <div class="payWrap">
                    <div class="payWrapTitle">
                        支付<span class="c-fd7e2a pl-5 pr-5 moy"></span>元
                    </div>
                    <div class="cl pt-15">
                        <div class="f-l w-320 pr-25">
                            <div class="f-r w-140">
                                <img id="payTy" src="${ctxPlugin }/static/h-ui.admin/images/weipay.png" class="w-140" />
                                <p class="payNote2"></p>
                            </div>
                            <div class="f-r icon_paystep">1</div>

                        </div>
                        <div class="f-l w-320 pr-25 ">
                            <a class="f-r c-fd6e32 f-13 btn_checkcase"><i class="sficon sficon-checkcase"></i> 示例</a>
                            <div class="f-r w-140">
                                <div class="f-r paycaseWrap spimg1" id="spimg2" >
                                    <!-- <a href="javascript:;" class="btn-uploadimg oneImg" ></a> -->
                                    <img id="img-view" src="${ctxPlugin }/static/h-ui.admin/images/img-default2.png" />
                                </div>
                                <a class="c-0383dc w-140 lh-30 f-l text-c f-13" id="img-picker">上传支付凭证</a>
                            </div>
                            <div class="f-r icon_paystep">2</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-c mt-10 mb-10">
            <a href="javascript:surePay();" class="sfbtn sfbtn-opt3 w-70 mr-5">确定支付</a>
            <a href="javascript:cancelPay();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
        </div>
    </div>
</div>

<div id="ty" class="popupBox spPayWrap wxPay">
    <h2 class="popupHead">
        <span id="lie">微信-支付凭证示例</span>
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20 text-c">
            <img id="lieImg" src="${ctxPlugin}/static/h-ui.admin/images/paySeq_wx.png" />
        </div>
        <div class="text-c mt-10 mb-15">
            <a href="javascript:closeTY();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>

<script type="text/javascript">
    var payType = "alipay";
    var goodsName='${platform.columns.name}';
    var goodSign='${platform.columns.good_sign}';
    var sitePrice='${platform.columns.site_price}';
    var numb='${number}';
    var isVIP=true;
    var uploaderCreated =false;
    var notVIPPrice='${platform.columns.no_vip_price}';
    function uploadPayConfirm() {
        if(uploaderCreated) {
            return;
        }
        uploaderCreated = true;
        var uploader = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: true,
            swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
            server: '${ctx}/common/uploadFile',
            duplicate: true,
            fileSingleSizeLimit: 1024 * 1024 * 5,
            pick: '#img-picker',
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
            },
            method: 'POST'
        });
        uploader.on("error", function (type) {
            if (type == "Q_TYPE_DENIED") {
                layer.msg("请上传JPG、PNG格式文件");
            } else if (type == "F_EXCEED_SIZE") {
                layer.msg("文件大小不能超过5M");
            }
        });
        uploader.on('beforeFileQueued', function (file) {
            uploader.reset();
        });
        uploader.on('uploadSuccess', function (file, response) {
            $("#img-view").attr("src", '${commonStaticImgPath}' + response.path);
            $("#img-input").val(response.path);
        });
    }

    $(function(){
        var province='${site.province}';
        if($.trim(province)=="香港" || $.trim(province)=="澳门" || $.trim(province)=="台湾"|| $.trim(province)=="国外"){
            layer.msg("暂不支持该地区的物流订单");
            $("#diqu").empty().append('<input type="hidden"  type="text" class="input-text w-190 bg-fff f-l mr-40" nullmsg="暂不支持该地区的物流订单" datatype="*" maxlength="20">')
        }else{
            $("#diqu").empty();
        }

        var startNum=10;
        if($.trim(goodSign)=="DZ20180110" || $.trim(goodSign)=="DZ20180113"){
            $("#adj_num").val("30");
            startNum="30";
        }else if($.trim(goodSign)=="DZ20180111"){
            $("#adj_num").val("100");
            startNum="100";
        }else{
            $("#adj_num").val("15");
            startNum="15";
        }

        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){
                $("#openVIP").removeClass("hide");
                $("#hadYouHui").addClass("hide");

                var z=notVIPPrice*startNum;
                $("#zong").text(z.toFixed(2));
                $("input[name='zong']").val(z.toFixed(2));
                $("input[name='price']").val(notVIPPrice);
                $(".yohuiPrice").text(parseFloat(notVIPPrice*startNum)-parseFloat(sitePrice*startNum));
                isVIP=false;
            }else{
                $("#openVIP").addClass("hide");
                $("#hadYouHui").removeClass("hide");

                var z=sitePrice*startNum;
                $("#zong").text(z.toFixed(2));
                $("input[name='zong']").val(z.toFixed(2));
                $("input[name='price']").val(sitePrice);
                $(".yohuiPrice").text(parseFloat(notVIPPrice*startNum)-parseFloat(sitePrice*startNum));
            }
            $("#orderZong").text(parseFloat(notVIPPrice*startNum).toFixed(2));
        });

        $("#pcd").citySelect({
            url:'${ctxPlugin}/lib/city.min.js',
            address: '${site.province}${site.city}${site.area}'
        });

        $('#orderForm').Validform({
            btnSubmit:"#immPay",
            tiptype: function(msg, o, cssctl) {
                if (msg != "") {
                    layer.msg(msg);
                }
            },
            callback: function (form) {
                var name=$("input[name='customerName']").val();
                var tel=$("input[name='customerMobile']").val();
                var povince=$("#province").val();
                var city=$("#city").val();
                var area=$("#area").val();
                var address=$("input[name='customerAddress']").val();
                var zong=$("#zong").text();

                $("#shouHR").text(name);//收货人
                $("#tel").text(tel);//电话
                $("#address").text(povince+city+area+address);//地址
                $("#money").text("￥"+zong);//支付金额
                $(".moy").text(zong);//支付金额
                $("#siteprovince").val(povince);
             	 $("#sitecity").val(city);
          		$("#sitearea").val(area);
                if($.trim(payType)=="alipay"){
                    $("#sty").removeClass("wxPay");
                    $("#sty").addClass("zfbPay");
                    $("#payHead").text("支付宝支付");
                    $("#payTy").attr("src","${ctxPlugin }/static/h-ui.admin/images/funderAlipay.png")
                }else{
                    $("#sty").addClass("wxPay");
                    $("#sty").removeClass("zfbPay");
                    $("#payHead").text("微信支付");
                    $("#payTy").attr("src","${ctxPlugin }/static/h-ui.admin/images/funderWeChat.png")
                }
                $("input[name='orderNumber']").val(numb);

                uploadPayConfirm();
                $("#sty").popup({closeSelfOnly:true});
                return false;
            }
        });

        $('#payWayBox').on('click','.payWay' ,function(){
            $('#payWayBox .payWay').removeClass('payWayCur');
            $(this).addClass('payWayCur');
        });

        $("a.paywapWrap").bind('click', function () {
            $("a.paywapWrap").removeClass("payCurrent");
            $(this).addClass("payCurrent");
        });
        $(".pay-by-zfb").bind('click', function () {
            payType = "alipay";
            $("input[name='payType']").val("alipay");
        });
        $(".pay-by-wx").bind('click', function () {
            payType = "wx";
            $("input[name='payType']").val("wx");
        });

    });

    $(".btn_checkcase").click(function(){
        if($.trim(payType)=="alipay"){
            $("#ty").removeClass("wxPay");
            $("#ty").addClass("zfbPay");
            $("#lie").text("支付宝-支付凭证示例");
            $("#lieImg").attr("src","${ctxPlugin}/static/h-ui.admin/images/paySeq_zfb.png")
        }
        $("#ty").popup({closeSelfOnly:true});
    })

    function closeTY(){
        $.closeDiv($("#ty"), true);
    }

    function jumpToVIP(){
        layer.open({
            type: 2,
            content: '${ctx}/goods/sitePlatformGoods/jumpVIP',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0
        });
    }

    function closeDiv(){
        $.closeDiv($(".protoDetailWrap"));
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});

    }

    function subNum() {
        var price = $("input[name='price']").val();
        var counter = $("#adj_num");
        var num = parseInt(counter.val());
        if($.trim(goodSign)=="DZ20180110" || $.trim(goodSign)=="DZ20180113"){
            if (num > 30) {
                num -= 10;
            }
        }else if($.trim(goodSign)=="DZ20180111" ){
            if (num > 100) {
                num -= 10;
            }
        }else{
            if (num > 15) {
                num -= 5;
            }
        }

        counter.val(num);
        if(!isVIP){
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("input[name='zong']").val((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((notVIPPrice*num).toFixed(2));
            $(".yohuiPrice").text(parseFloat(notVIPPrice*num)-parseFloat(sitePrice*num));
        }else{
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("input[name='zong']").val((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((notVIPPrice*num).toFixed(2));
            $(".yohuiPrice").text(parseFloat(notVIPPrice*num)-parseFloat(sitePrice*num));
        }
        var province=$("#province").val();

    }
    function addNum() {
        var price = $("input[name='price']").val();
        var counter = $("#adj_num");
        var num = parseInt(counter.val());

        if($.trim(goodSign)=="DZ20180110" || $.trim(goodSign)=="DZ20180111"
            || $.trim(goodSign)=="DZ20180113"){
            if(num>=10){
                num+=10;
            }
        }else{
            if(num>=5){
                num+=5;
            }
        }

        counter.val(num);
        if(!isVIP){
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("input[name='zong']").val((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((notVIPPrice*num).toFixed(2));
            $(".yohuiPrice").text(parseFloat(notVIPPrice*num)-parseFloat(sitePrice*num));
        }else{
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("input[name='zong']").val((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((notVIPPrice*num).toFixed(2));
            $(".yohuiPrice").text(parseFloat(notVIPPrice*num)-parseFloat(sitePrice*num));
        }

        var province=$("#province").val();

    }

    var formPo =false;
    function surePay(){
        if(formPo){
            return;
        }
        $("input[name='province']").val($("#province").val());
        $("input[name='city']").val($("#city").val());
        $("input[name='area']").val($("#area").val());
        var icon=$("input[name='icon']").val();
        if(isBlank(icon)){
            layer.msg("请上传支付凭证！");
        }else{
            formPo=true;
            $.ajax({
                url: "${ctx}/goods/sitePlatformGoods/createMeiJLiOrder",
                type: "POST",
                data: $("#orderForm").serialize(),
                success: function(data) {
                    if(data=="numberExit"){
                        window.top.layer.msg("该订单编号已存在！");
                    }else{
                        window.top.layer.msg("订单提交成功！");
                        cancelPay();
                        removeIframe();
                    }
                },
                error: function() {
                    layer.msg("订单提交失败");
                },
                complete: function () {
                    formPo = false;
                    cancelPay();
                    removeIframe();
                }
            });
        }
    }

    $('#spimg2').imgShow();

    function cancelPay() {
        $.closeDiv($(".spPayWrap"),true);

    }
    function closePay() {
        cancelPay();
    }
    function cancelShowDesk() {
        $.closeDiv($(".protoDetailWrap"));
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
    }

    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }


    $("#province").change(function(){
        var province=$(this).val();
        //var num=$("#adj_num").val();//购买数量
        //getLogisticsPrice(num,province);
        if($.trim(province)=="香港" || $.trim(province)=="澳门" || $.trim(province)=="台湾" || $.trim(province)=="国外"){
            layer.msg("暂不支持该地区的物流订单");
            $("#diqu").empty().append('<input type="hidden"  type="text" class="input-text w-190 bg-fff f-l mr-40" nullmsg="暂不支持该地区的物流订单" datatype="*" maxlength="20">')
        }else{
            $("#diqu").empty();
        }
    });

</script>
</body>
</html>
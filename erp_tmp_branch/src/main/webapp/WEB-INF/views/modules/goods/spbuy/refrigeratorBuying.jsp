<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>我的商品-购买南岛升级版</title>
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
                                    <%--<th class="w-150">VIP会员价</th>--%>
                                    <th class="w-150">建议零售价</th>
                                    <th class="w-190">购买数量</th>
                                    <th class="w-120">小计</th>
                                    <th class="w-110">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr id="10ANan"
                                    class="radius  <c:if test="${platform.columns.good_sign ne 'MD20180716'}">hide</c:if>">
                                    <td>
                                        <div class="wrap1 text-l ">
                                            <div class="imgWrap imgWrap">
                                                <img id="10AImage" src="${commonStaticImgPath}${images}" class="img pos"/>
                                                <div class="pl-25">
                                                    <h3 class="lh-30 f-14 goodName1">${platform.columns.name}</h3>
                                                    <p class="c-888 f-12 lh-20">${platform.columns.description}</p>
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
                                    <td class="hide">
                                        <div class="wrap1"><span class="c-0383dc">￥<span id="10AVIPPrice">${platform.columns.site_price}</span></span></div>
                                    </td>
                                    <td>
                                        <div class="wrap1">￥<span id="10AdvicePrice">${platform.columns.advice_price}</span></div>
                                    </td>
                                    <td>
                                        <div class="wrap1 w-140" style="margin: 0 auto;">
                                            <div class="countWrap w-140 mb-5">
                                                <a class="btn-minus" href="javascript:subNum(10);"></a>
                                                <div class="priceWrap readonly">
                                                    <input type="text" id="adj_num10" readonly name="quantity10" class="input-text text-c readonly" value="1"/>
                                                    <span class="unit unit10A">个</span>
                                                </div>
                                                <a class="btn-plus" href="javascript:addNum(10);"></a>
                                            </div>
                                            <input type="hidden" name="unit10A" value="个"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1"><strong class="c-fd6e32 f-20">￥<span id="orderZong10" class="va-t"></span></strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1 ${platform.columns.good_sign eq 'MD20180716' ? '':'hide'}"><a class="btn_add  " onclick="addGoods()">添加商品</a></div>
                                        <div class="wrap1 hide"><a class="btn_del" onclick="deleteGood('10ANan')">删除商品</a></div>
                                    </td>
                                </tr>
                                <tr id="16ANan" class="radius <c:if test="${platform.columns.good_sign ne 'MD20180717'}">hide</c:if>">
                                    <td>
                                        <div class="wrap1 text-l ">
                                            <div class="imgWrap imgWrap">
                                                <img id="16AImage" src="${commonStaticImgPath}${images}" class="img pos"/>
                                                <div class="pl-25">
                                                    <h3 class="lh-30 f-14 goodName2">${platform.columns.name}</h3>
                                                    <p class="c-888 f-12 lh-20">${platform.columns.description}</p>
                                                </div>
                                            </div>
                                            <input type="hidden" name="unit10A" value="个"/>
                                            <p class="pos-r pl-20 c-666 f-12 mt-5">
                                                <%-- <i class="sficon1 sficon-note2 pos"></i>10A适用家用普通插座，例如冰箱、洗衣机等--%>
                                            </p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1">￥<span id="16ANoVIPPrice">${platform.columns.no_vip_price}</span>
                                        </div>
                                    </td>
                                    <td class="hide">
                                        <div class="wrap1"><span class="c-0383dc">￥<span id="16AVIPPrice">${platform.columns.site_price}</span></span></div>
                                    </td>
                                    <td>
                                        <div class="wrap1">￥<span id="16AdvicePrice">${platform.columns.advice_price}</span></div>
                                    </td>
                                    <td>
                                        <div class="wrap1 w-140" style="margin: 0 auto;">
                                            <div class="countWrap w-140 mb-5">
                                                <a class="btn-minus" href="javascript:subNum(16);"></a>
                                                <div class="priceWrap readonly">
                                                    <input type="text" id="adj_num16" readonly name="quantity16" class="input-text text-c readonly" value="1"/>
                                                    <span class="unit unit16A">个</span>
                                                </div>
                                                <a class="btn-plus" href="javascript:addNum(16);"></a>
                                            </div>
                                            <input type="hidden" name="unit16A" value="个"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1"><strong class="c-fd6e32 f-20">￥<span id="orderZong16" class="va-t">307.5</span></strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1 ${platform.columns.good_sign eq 'MD20180717' ? '':'hide' }">
                                            <a class="btn_add " onclick="addGoods()">添加商品</a>
                                        </div>
                                        <div class="wrap1 hide">
                                            <a class="btn_del " onclick="deleteGood('16ANan')">删除商品</a>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <div class="cl mb-10 hide">
                                <div class="f-l">
                                    <span id="diqu"></span>
                                    <span id="yunfeiiii"></span>
                                </div>
                                <input type="hidden" name="price10A" value="${platform.columns.site_price }"/>
                                <input type="hidden" name="price16A" value="${platform.columns.site_price }"/>
                                <input type="hidden" name="pid10A" value="${platform.columns.good_sign eq 'MD20180716' ? platform.columns.id:'' }"/>
                                <input type="hidden" name="pid16A" value="${platform.columns.good_sign eq 'MD20180717' ? platform.columns.id:'' }"/>
                                <input type="hidden" name="payType" value="alipay"/>
                                <input type="hidden" name="orderNumber" value="${number}"/>
                                <input type="hidden" id="img-input" name="icon" value="">
                                <input type="hidden" id="logisticsPrice" name="logisticsPrice" value=""><%--运费--%>
                               <input type="hidden" id="siteprovince" name="province" value="${site.province}">
		                        <input type="hidden" id="sitecity" name="city" value="${site.city}">
		                        <input type="hidden" id="sitearea" name="area" value="${site.area}">
                                <input type="hidden" name="zong10A" value="">
                                <input type="hidden" name="zong16A" value="">
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
                    <div class="f-l">
                        <span class="c-fd6e32">免运费</span>
                    </div>
                    <div class="f-r">
                        <span class="mr-10">应付金额：<strong class="c-fd6e32 f-26">￥</strong><strong class="c-fd6e32 f-26" id="zong" name="zong"></strong></span>
                    </div>
                </div>
                <div class="cl">
                    <div class="f-r">
                        <span class="mr-10 hide" id="openVIP"><a class="c-fd6e32 underline va-t sficon1 sficon-crown1 mr-5 f-14" onclick="jumpToVIP()">开通会员</a><span class="f-13">立减<span class="yohuiPrice va-t"></span></span></span>
                        <%--<span class="mr-10" id="hadYouHui">已优惠：<span class="">￥<span class="yohuiPrice" ></span></span></span>--%>
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
        <a href="javascript:;" class="sficon closePopup closeThis"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain">
            <h3 class="payTitle">
                思方收银台
            </h3>
            <div class="payOrder cl">
                <div class="f-l c-666">
                    <p class="f-l mr-20">收货人：<span id="shouHR" class="va-t"></span></p>
                    <p class="f-l mr-20">电话：<span id="tel" class="va-t"></span></p>
                    <p class="f-l">地址：<span id="address" class="va-t"></span></p>
                </div>
            </div>

            <!-- 支付二维码部分-->
            <div class="payment hide1 paymentPart">
                <div class="payWrap">
                    <div class="payWrapTitle">
                        支付<span class="c-fd7e2a pl-5 pr-5 moy"></span>元
                    </div>
                    <div class="cl pt-10">
                        <div class="payCode">
                        </div>
                        <div class="payNote"></div>
                    </div>
                </div>
            </div>

            <!-- 支付结果（成功） -->
            <div class="pd-25 text-c payResultS hide">
                <i class="prnote mr-10"></i>
                <span class="text-l pt-10">
					<strong class="f-18">您已成功付款</strong>
				</span>
            </div>

            <!-- 支付结果（失败） -->
            <div class="pd-25 text-c payResultF hide" >
                <i class="prnote mr-10"></i>
                <span class="text-l pt-10">
					<strong class="f-18">支付失败</strong>
				</span>
            </div>


        </div>
        <div class="text-c mb-10">
            <a id="oneGuanbi" href="javascript:cancelPay();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
            <a id="twoGuanbi" href="javascript:cancelPayTwo();" class="sfbtn sfbtn-opt w-70 mr-5 hide">关闭</a>
        </div>
    </div>
</div>


<div class="popupBox w-710 addProto">
    <h2 class="popupHead">
        添加商品
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pd-15 ">
        <div class="popupMain">
            <table class="table table-bg table-border table-bordered table-sdrk text-c">
                <thead>
                <tr>
                    <th class="w-80">选择</th>
                    <th class="w-130">商品名称</th>
                    <th class="w-100">图片</th>
                    <th class="w-100">商品品牌</th>
                    <th class="w-100">商品型号</th>
                    <th class="w-100">商品类别</th>
                </tr>
                </thead>
                <tbody id="goodslist">
                <tr>
                    <td><span class="label-cbox "></span></td>
                    <td>漏电保护插头 10A </td>
                    <td><img src="" style="width: 90px;height: 80px"/></td>
                    <td>南岛</td>
                    <td>NB-ZL3M-10 </td>
                    <td>插座</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="text-c mt-20">
            <a href="javascript:addGoodsNow();" class="btnOrange w-110 mr-5">添加</a>
            <a href="javascript:cancelAdd();" class="btnOrange_b w-110 w-70 ">取消</a>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    var goodIds='${platform.columns.id}';
    var goodId10A="";
    var goodId16A="";
    var payType = "alipay";
    var goodsName='${platform.columns.name}';
    var goodsSign='${platform.columns.good_sign}';
    var sitePrice10A=0;//会员价（10A）
    var sitePrice16A=0;//会员价（16A）
    var numb='${number}';
    var isVIP=${isVIP};
    var notVIPPrice10A=100;//非会员价(10A)
    var notVIPPrice16A=100;//非会员价(16A)
    $(function(){
        $('#payWayBox').on('click','.payWay' ,function(){
            $('#payWayBox .payWay').removeClass('payWayCur');
            $(this).addClass('payWayCur');
        });

        if(isVIP){
            $("#openVIP").addClass("hide");
            $("#hadYouHui").removeClass("hide");
        }else{
            $("#openVIP").removeClass("hide");
            $("#hadYouHui").addClass("hide");
        }

        if(goodsSign=='MD20180716'){
            sitePrice10A='${platform.columns.site_price}';
            notVIPPrice10A='${platform.columns.no_vip_price}';
            goodId10A='${platform.columns.id}';
            if(!isVIP){
                $("input[name='price10A']").val('${platform.columns.no_vip_price}');
            }
        }else if(goodsSign=='MD20180717'){
            sitePrice16A='${platform.columns.site_price}';
            notVIPPrice16A='${platform.columns.no_vip_price}';
            goodId16A='${platform.columns.id}';
            if(!isVIP){
                $("input[name='price16A']").val('${platform.columns.no_vip_price}');
            }
        }

        $("#pcd").citySelect({
            url:'${ctxPlugin}/lib/city.min.js',
            address: '${site.province}${site.city}${site.area}'
        });

        countAnythingPrice();

        $('#orderForm').Validform({
            btnSubmit:"#immPay",
            tiptype: function(msg, o, cssctl) {
                if (msg != "") {
                    layer.msg(msg);
                }
            },
            callback: function (form) {
                var name = $("input[name='customerName']").val();
                var tel = $("input[name='customerMobile']").val();
                var povince = $("#province").val();
                var city = $("#city").val();
                var area = $("#area").val();
                var address = $("input[name='customerAddress']").val();
                var zong = $("#zong").text();

                $("#shouHR").text(name);//收货人
                $("#tel").text(tel);//电话
                $("#address").text(povince + city + area + address);//地址
                //$("#money").text("￥" + zong);//支付金额
                $(".moy").text(zong);//支付金额
                $("#siteprovince").val(povince);
           	 $("#sitecity").val(city);
        		$("#sitearea").val(area);
                if ($.trim(payType) == "alipay") {
                    $("#sty").removeClass("wxPay");
                    $("#sty").addClass("zfbPay");
                    $("#payHead").text("支付宝支付");
                    $("#payTy").attr("src", "${ctxPlugin }/static/h-ui.admin/images/alipay.png")
                } else {
                    $("#sty").addClass("wxPay");
                    $("#sty").removeClass("zfbPay");
                    $("#payHead").text("微信支付");
                    $("#payTy").attr("src", "${ctxPlugin }/static/h-ui.admin/images/weipay.png")
                }
                $("input[name='orderNumber']").val(numb);
                checkPrice();
                return false;
            }
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

    $('.addProto ').on('click','tr',function () {
        var chk = $(this).find('.label-cbox');
        if(chk.hasClass('label-cbox-selected')){
            chk.removeClass('label-cbox-selected');
        }else{
            chk.addClass('label-cbox-selected');
        }
    })

    function cancelAdd(){
        $.closeDiv($(".addProto"),true);
    }

    function jumpToVIP(){
        layer.open({
            type: 2,
            content: '${ctx}/goods/sitePlatformGoods/jumpVIP',
            //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0
        });
    }

    function cancelPayTwo(){
        removeIframe();
    }

    var formPosted = false;
    function checkout() {
        if(formPosted) {
            return false;
        }
        formPosted = true;

        var index = layer.load(0, {shade: false});
        $(".protoDetailWrap").hide();
        $.ajax({
            url: "${ctx}/goods/sitePlatformGoods/createRefrigertorOrder",
            type: "POST",
            data: $("#orderForm").serialize(),
            success: function(data) {
                if (data.code == "200") {
                    var qrCodeUrl = data.data[0];
                    $('.payCode').empty().qrcode({width: 150, height: 150, text: qrCodeUrl});
                    var price = $("input[name='price']").val();
                    var num = $("#adj_num").val();
                    var totalAmount = (num * parseFloat(price)).toFixed(2);
                    $("#payAmount1").text(totalAmount);
                    $("#payAmount2").text(totalAmount);
                    $("#orderNo").text(data.data[2]);

                    var desk = $('.spPayWrap');
                    if (payType == "wx") {
                        desk.removeClass("zfbPay wxPay").addClass("wxPay");
                    } else if (payType == "alipay") {
                        desk.removeClass("zfbPay wxPay").addClass("zfbPay");
                    } else {
                        return;
                    }
                    desk.show({level:2});
                    unipay.config({
                        cancelPath: "${ctx}/pay/cancel",
                        queryOrderStatusPath: "${ctx}/pay/status"
                    });
                    monitor = new unipay.Monitor(payType, data.data[1], {
                        onPaySuccess: function() {
                            $(".paymentPart").hide();
                            $(".payResultS").show();
                            $("#oneGuanbi").addClass("hide");
                            $("#twoGuanbi").removeClass("hide");
                        },
                        onPayTimeout: function () {
                            layer.msg("支付超时");
                            closePay();
                        }
                    });
                    monitor.start();
                } else if (data.code == "422") {
                    layer.msg("订单提交失败");
                }
            },
            error: function() {
                layer.msg("订单提交失败");
            },
            complete: function () {
                formPosted = false;
                layer.close(index);
            }
        });
    }

    function checkPrice(){
        $.post("${ctx}/goods/nanDao/checkPriceForRefrigertor",$("#orderForm").serialize(),function(result){
            if(result=='fal'){
                layer.msg("价格计算可能有误，请截图后联系管理员！！！");
            }else{
                checkout();
                $("#sty").popup({closeSelfOnly: true,level:2});
            }
        });
    }

    var newGood="";
    var newGoodSign="";
    var newSitePrice="";
    var newId="";
    var advicePrice="";
    function addGoods(){
        $.post("${ctx}/goods/nanDao/getAllReFrigerator",{id:goodIds},function(result){
            if(result!=null){
                var html='';
                for(var i=0;i<result.length;i++){
                    html+='<tr><td><span class="label-cbox "><input type="hidden" name="goodsId" value="'+result[i].columns.id+'" /></span></td>';
                    html+='<td>'+result[i].columns.name+'</td>';
                    html+='<td><img src="${commonStaticImgPath}'+result[i].columns.icon+'" style="width: 90px;height: 80px"/></td>';
                    html+='<td>'+result[i].columns.brand+'</td>';
                    html+='<td>'+result[i].columns.model+'</td>';
                    html+='<td>'+result[i].columns.category+'</td></tr>';
                    newGood=result[i].columns.name;
                    newGoodSign=result[i].columns.good_sign;
                    if(newGoodSign=='MD20180716'){
                        $(".goodName1").text(result[i].columns.name);
                        $("#adj_num10").val("1");//初始化数量
                        notVIPPrice10A=result[i].columns.no_vip_price;
                        goodId10A=result[i].columns.id;
                        $("#10AImage").attr({"src":'${commonStaticImgPath}'+result[i].columns.icon});
                    }else if(newGoodSign=='MD20180717'){
                        $(".goodName2").text(result[i].columns.name);
                        $("#adj_num16").val("1");//初始化数量
                        notVIPPrice16A=result[i].columns.no_vip_price;
                        goodId16A=result[i].columns.id;
                        $("#16AImage").attr({"src":'${commonStaticImgPath}'+result[i].columns.icon});
                    }

                    $("#10ANan").addClass("trbb");
                    advicePrice = result[i].columns.advice_price;
                    newSitePrice = result[i].columns.site_price;
                    newId = result[i].columns.id;
                }
                $("#goodslist").empty().append(html);
                $(".addProto").popup({level:2},true);
            }
        });
    }

    function addGoodsNow(){
        var vas = $(".label-cbox-selected").children().val();
        if(isBlank(vas)){
            layer.msg("请选择商品！");
            return;
        }
        $(".radius").removeClass("hide");
        if(newGoodSign=='MD20180716'){
            $("#10ANoVIPPrice").text(notVIPPrice10A.toFixed(2));
            $("#10AVIPPrice").text(newSitePrice.toFixed(2));
            sitePrice10A=newSitePrice;
            $("input[name='pid10A']").val(goodId10A);
            $("input[name='price10A']").val(notVIPPrice10A.toFixed(2));
            $("#10AdvicePrice").text(advicePrice.toFixed(2));
        }else if(newGoodSign=='MD20180717'){
            $("#16ANoVIPPrice").text(notVIPPrice16A.toFixed(2));
            $("#16AVIPPrice").text(newSitePrice.toFixed(2));
            sitePrice16A=newSitePrice;
            $("input[name='pid16A']").val(goodId16A);
            $("input[name='price16A']").val(notVIPPrice16A.toFixed(2));
            $("#16AdvicePrice").text(advicePrice.toFixed(2));
        }
        $(".btn_add").parent("div").addClass("hide");
        $(".btn_del").parent("div").removeClass("hide");

        goodIds=goodId10A+","+goodId16A;
        $.closeDiv($(".addProto"),true);
        countAnythingPrice();
    }

    function deleteGood(idVal){
        $("#10ANan").removeClass("trbb");
        $(".btn_add").parent("div").removeClass("hide");
        $(".btn_del").parent("div").addClass("hide");
        $("#"+idVal).addClass("hide");
        if($.trim(idVal)=="10ANan"){
            goodIds=goodId16A;
            sitePrice10A="0";
            $("input[name='pid10A']").val("");
        }else{
            goodIds=goodId10A;
            sitePrice16A="0";
            $("input[name='pid16A']").val("");
        }
        countAnythingPrice();
    }

    function subNum(va) {
        var counter = $("#adj_num"+va);
        var num = parseInt(counter.val());
        if (num > 1) {
            num -= 1;
        }
        counter.val(num);
        countAnythingPrice();
    }
    function addNum(va) {
        var counter = $("#adj_num"+va);
        var num = parseInt(counter.val());
        num+=1;
        counter.val(num);
        countAnythingPrice();
    }
    $("#province").change(function(){
        countAnythingPrice();
    });
    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }

    function cancelPay(){
        $.closeDiv($("#sty"),true);
    }
    //计算各种乱七八糟的价格
    function countAnythingPrice(){
        //每次都要重新计算运费
        var province=$("#province").val();
        var pro='${site.province}';
        if(isBlank($("#province").val())){
            if(pro.indexOf('省')>0){
                province=pro.split("省")[0];
            }else if(pro.indexOf('市')>0){
                province=pro.split("市")[0];
            }else{
                province=pro;
            }
        }
        //如果sitePrice10A的价格为0则不存在10A的商品
        if(sitePrice10A != '0' && sitePrice16A == '0'){//只有10A的
            var num10A = $("#adj_num10").val();//10A的数量
            var unit=$(".unit10A").text();
            if($.trim(unit)=='箱'){
                num10A=parseInt(num10A)*144;
            }
            var goodsZong = parseFloat(notVIPPrice10A)*parseFloat(num10A);//商品总额
            var payZong = 0;//应付总额
            var youhui = (parseFloat(notVIPPrice10A) - parseFloat(sitePrice10A))*num10A;//优惠价格
            if(isVIP){
                if(num10A>=144){
                    payZong=goodsZong-youhui;
                }else{
                    payZong=goodsZong-youhui;
                }
            }else{
                if(num10A>=144){
                    payZong=parseFloat(goodsZong);
                }else{
                    payZong=parseFloat(goodsZong);
                }
            }
            $("#orderZong10").text(goodsZong.toFixed(2));
            $(".yohuiPrice").text(youhui.toFixed(2));
            $("#zong").text(payZong.toFixed(2));

            $("input[name='zong10A']").val(payZong.toFixed(2));
        }else if(sitePrice10A == '0' && sitePrice16A != '0'){//只有16A的
            var num16A=$("#adj_num16").val();//16A的数量
            var unit=$(".unit16A").text();
            if($.trim(unit)=='箱'){
                num16A=parseInt(num16A)*144;
            }
            var goodsZong = parseFloat(notVIPPrice16A)*parseFloat(num16A);//商品总额
            var payZong = 0;//应付总额
            var youhui = (parseFloat(notVIPPrice16A) - parseFloat(sitePrice16A))*num16A;//优惠价格
            if(isVIP){
                if(num16A>=144){
                    payZong=goodsZong-youhui;
                }else{
                    payZong=goodsZong-youhui;
                }
            }else{
                if(num16A>=144){
                    payZong=parseFloat(goodsZong);
                }else{
                    payZong=parseFloat(goodsZong);
                }
            }
            $("#orderZong16").text(goodsZong.toFixed(2));
            $(".yohuiPrice").text(youhui.toFixed(2));
            $("#zong").text(payZong.toFixed(2));

            $("input[name='zong16A']").val(payZong.toFixed(2));
        }else{//两个商品都有
            var num10A=$("#adj_num10").val();//10A的数量
            var num16A=$("#adj_num16").val();//16A的数量
            var unit10A=$(".unit10A").text();
            var unit16A=$(".unit16A").text();
            if($.trim(unit10A)=='箱'){
                num10A=parseInt(num10A)*144;
            }
            if($.trim(unit16A)=='箱'){
                num16A=parseInt(num16A)*144;
            }
            var numz=parseInt(num10A)+parseInt(num16A);

            $("#allNum").text(numz);//总数
            var goodsZong10A = parseFloat(notVIPPrice10A)*parseFloat(num10A);//商品总额
            var goodsZong16A = parseFloat(notVIPPrice16A)*parseFloat(num16A);//商品总额
            $("#orderZong10").text(goodsZong10A.toFixed(2));
            $("#orderZong16").text(goodsZong16A.toFixed(2));
            var heji=goodsZong10A+goodsZong16A;
            $("#allPri").text(heji.toFixed(2));//合计

            var payZong = 0;//应付总额
            youhui10A = (parseFloat(notVIPPrice10A) - parseFloat(sitePrice10A))*num10A;//优惠价格
            youhui16A = (parseFloat(notVIPPrice16A) - parseFloat(sitePrice16A))*num16A;//优惠价格
            var youhui=youhui10A+youhui16A;
            if(isVIP){
                if(numz>=144){
                    payZong=heji-youhui;
                    $("input[name='zong10A']").val(parseFloat(sitePrice10A)*parseFloat(num10A));
                    $("input[name='zong16A']").val(parseFloat(sitePrice16A)*parseFloat(num16A));
                }else{
                    payZong=heji-youhui;
                    $("input[name='zong10A']").val(parseFloat(sitePrice10A)*parseFloat(num10A));
                    $("input[name='zong16A']").val(parseFloat(sitePrice16A)*parseFloat(num16A));
                }
            }else{
                if(numz>=144){
                    payZong=parseFloat(heji);
                    $("input[name='zong10A']").val(parseFloat(notVIPPrice10A)*parseFloat(num10A));
                    $("input[name='zong16A']").val(parseFloat(notVIPPrice16A)*parseFloat(num16A));
                }else{
                    payZong=parseFloat(heji);
                    $("input[name='zong10A']").val(parseFloat(notVIPPrice10A)*parseFloat(num10A));
                    $("input[name='zong16A']").val(parseFloat(notVIPPrice16A)*parseFloat(num16A));
                }
            }
            $(".yohuiPrice").text(youhui.toFixed(2));
            $("#zong").text(payZong.toFixed(2));
        }
    }


    //新疆/西藏/甘肃/内蒙/黑龙江/云南/海南/青海
    $("#province").change(function(){
        var province=$(this).val();
        if($.trim(province)=="新疆" || $.trim(province)=="西藏" || $.trim(province)=="甘肃" || $.trim(province)=="内蒙" || $.trim(province)=="黑龙江" || $.trim(province)=="云南" || $.trim(province)=="青海"
            || $.trim(province)=="香港" || $.trim(province)=="澳门" || $.trim(province)=="台湾"|| $.trim(province)=="国外"){
            layer.msg("暂不支持该地区的物流订单");
            $("#diqu").empty().append('<input type="hidden"  type="text" class="input-text w-190 bg-fff f-l mr-40" nullmsg="暂不支持该地区的物流订单" datatype="*" maxlength="20">')
        }else{
            $("#diqu").empty();
        }
    });

</script>
</body>
</html>
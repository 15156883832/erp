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
    <div class="sfpage ">
        <div class="pd-20 ndlbPage">
            <form id="orderForm" >
                <div class="cl pb-20 ">
                    <div class="f-l ">
                        <div id="10ANan" class="f-l radius w-280 mr-30 <c:if test="${platform.columns.good_sign ne 'BS20180107'}">hide</c:if>">
                            <div class="mb-5 w-280 pos-r bk-gray radius ndlbWrap ">
                                <a class="btn_remove hide" onclick="deleteGood('10ANan')">X</a>
                                <div class="ndlbName text-c">
                                    <img id="10AImage" style="max-height: 200px" src="${commonStaticImgPath}${images}" />
                                </div>
                                <div class="pl-10 pr-10 pt-10">
                                    <div class="cl f-14 mb-5">
                                        <span class="mr-10">单价：￥<span id="10ANoVIPPrice">${platform.columns.no_vip_price}</span></span>
                                        <span class="">会员价：<span class="c-fd6e32">￥<span id="10AVIPPrice">${platform.columns.site_price}</span></span></span>
                                    </div>
                                    <div class="mb-10 cl">
                                        <span class="sficon1 sficon-rad1 sficon-rad1_selected f-l cPointer" data-unit="个" data-num="15">按个</span>
                                        <span class="sficon1 sficon-rad1 f-r cPointer" data-unit="箱" data-num="1">按箱（144个/箱）</span>
                                    </div>
                                    <div class="ndlbNumWrap cl">
                                        <div class="countWrap w-140 f-l" >
                                            <a href="javascript:subNum(10);" class="btn-minus"></a>
                                            <div class="priceWrap readonly">
                                                <input type="text" id="adj_num10"  name="quantity10" class="input-text bg-fff readonly va-t" readonly="readonly" value="15" />
                                                <span class="unit unit10A">个</span>
                                            </div>
                                            <a href="javascript:addNum(10);" class="btn-plus"></a>
                                        </div>
                                        <input type="hidden" name="unit10A" value="个"/>
                                        <div class="f-r f-20 c-fd6e32 lh-26">
                                            ￥<span id="orderZong10" class="va-t">307.5</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <p class="w-280 pos-r pl-25 c-666"><i class="sficon1 sficon-note2 pos"></i> 10A适用家用普通插座，例如冰箱、洗衣机等</p>
                        </div>
                        <div id="16ANan"  class="f-l w-280 mr-30 radius <c:if test="${platform.columns.good_sign ne 'BS20180108'}">hide</c:if>">
                            <div class="w-280 mb-5 pos-r bk-gray radius ndlbWrap" >
                                <a class="btn_remove hide" onclick="deleteGood('16ANan')">X</a>
                                <div class="ndlbName text-c">
                                    <img id="16AImage" style="max-height: 200px"  src="${commonStaticImgPath}${images}" />
                                </div>
                                <div class="pl-10 pr-10 pt-10">
                                    <div class="cl f-14 mb-10">
                                        <span class="mr-10">单价：￥<span id="16ANoVIPPrice">${platform.columns.no_vip_price}</span></span>
                                        <span class="">会员价：<span class="c-fd6e32">￥<span id="16AVIPPrice">${platform.columns.site_price}</span></span></span>
                                    </div>
                                    <div class="mb-10 cl">
                                        <span class="sficon1 sficon-rad1 sficon-rad1_selected f-l cPointer" data-unit="个" data-num="15">按个</span>
                                        <span class="sficon1 sficon-rad1 f-r cPointer" data-unit="箱" data-num="1">按箱（144个/箱）</span>
                                    </div>
                                    <div class="ndlbNumWrap cl">
                                        <div class="countWrap w-140 f-l " >
                                            <a href="javascript:subNum(16);" class="btn-minus"></a>
                                            <div class="priceWrap readonly">
                                                <input type="text" id="adj_num16"  name="quantity16" class="input-text bg-fff readonly va-t" readonly="readonly" value="15" />
                                                <span class="unit unit16A">个</span>
                                            </div>
                                            <a href="javascript:addNum(16);" class="btn-plus"></a>
                                        </div>
                                        <input type="hidden" name="unit16A" value="个"/>
                                        <div class="f-r f-20 c-fd6e32 lh-26">
                                            ￥<span  id="orderZong16" class="va-t">307.5</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <p class="pos-r w-280 c-666 pl-25"><i class="sficon1 sficon-note2 pos"></i>16A适用大型家电，需专用插座，例如柜式空调、电热水器等</p>
                        </div>
                        <a class="f-l  mr-30 text-c btn_addLb" onclick="addGoods()">添加商品</a>
                        <div class="cl mb-10 hide">
                            <div class="f-l">
                                <span id="diqu"></span>
                                <span id="yunfeiiii"></span>
                            </div>
                            <input type="hidden" name="price10A" value="${platform.columns.site_price }"/>
                            <input type="hidden" name="price16A" value="${platform.columns.site_price }"/>
                            <input type="hidden" name="pid10A" value="${platform.columns.good_sign eq 'BS20180107' ? platform.columns.id:'' }"/>
                            <input type="hidden" name="pid16A" value="${platform.columns.good_sign eq 'BS20180108' ? platform.columns.id:'' }"/>
                            <input type="hidden" name="payType" value="alipay"/>
                            <input type="hidden" name="orderNumber" value="${number}"/>
                            <input type="hidden" id="img-input"  name="icon" value="">
                            <input type="hidden" id="logisticsPrice"  name="logisticsPrice" value=""><%--运费--%>
                             <input type="hidden" id="siteprovince" name="province" value="${site.province}">
	                        <input type="hidden" id="sitecity" name="city" value="${site.city}">
	                        <input type="hidden" id="sitearea" name="area" value="${site.area}">
                            <input type="hidden" name="zong10A" value="">
                            <input type="hidden" name="zong16A" value="">
                        </div>
                    </div>

                    <div class="f-l pt-30 ml-30 w-430">
                        <h3 class="f-30 mb-15 ndlbTitle">全新升级版漏电保护插头</h3>
                        <ul class="benefit_Nd">
                            <li>
                                <span class="nd_star"></span>可免费申请增值税发票
                            </li>
                            <li>
                                <span class="nd_star"></span>产品升级、包装升级、服务升级
                            </li>
                            <li>
                                <span class="nd_star"></span>五年超长质保期（通过使用“<a class="c-fd6e32 ">思方无现金收款</a>” 享受五年质保期）
                            </li>
                        </ul>
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
                        运费：<span class="c-fd6e32">￥<span id="yunfei" class="va-t">10.00</span></span>（满144个免运费）
                    </div>
                    <div class="f-r">
                        <span class="mr-10">应付金额：<strong class="c-fd6e32 f-26">￥</strong><strong class="c-fd6e32 f-26" id="zong" name="zong"></strong></span>
                    </div>
                </div>
                <div class="cl">
                    <div class="f-r">
                        <span class="mr-10 hide" id="openVIP"><a class="c-fd6e32 underline va-t sficon1 sficon-crown1 mr-5 f-14" onclick="jumpToVIP()">开通会员</a><span class="f-13">立减<span class="yohuiPrice va-t"></span></span></span>
                        <span class="mr-10" id="hadYouHui">已优惠：<span class="">￥<span class="yohuiPrice" ></span></span></span>
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

        if(goodsSign=='BS20180107'){
            sitePrice10A='${platform.columns.site_price}';
            notVIPPrice10A='${platform.columns.no_vip_price}';
            goodId10A='${platform.columns.id}';
            if(!isVIP){
                $("input[name='price10A']").val('${platform.columns.no_vip_price}');
            }
        }else if(goodsSign=='BS20180108'){
            sitePrice16A='${platform.columns.site_price}';
            notVIPPrice16A='${platform.columns.no_vip_price}';
            goodId16A='${platform.columns.id}';
            if(!isVIP){
                $("input[name='price16A']").val('${platform.columns.no_vip_price}');
            }
        }

        var province='${site.province}';
        if(province.indexOf('省')>0){
            var pro=province.split("省")[0];
            getLogisticsPrice(15,pro);
        }else if(province.indexOf('市')>0){
            var pro=province.split("市")[0];
            getLogisticsPrice(15,pro);
        }else{
            getLogisticsPrice(15,province);
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

    $('.ndlbWrap').on('click','.sficon-rad1', function () {
        var oP = $(this).closest('.ndlbWrap');
        oP.find('.sficon-rad1').removeClass('sficon-rad1_selected');
        $(this).addClass('sficon-rad1_selected');
        oP.find('.priceWrap .input-text').val($(this).attr('data-num'));
        oP.find('.priceWrap .unit').text($(this).attr('data-unit'));

        var unit10A=$(".unit10A").text();
        var unit16A=$(".unit16A").text();
        if($.trim(unit10A)== '箱'){
            $("input[name='unit10A']").val("箱");
        }else{
            $("input[name='unit10A']").val("个");
        }
        if($.trim(unit16A)== '箱'){
            $("input[name='unit16A']").val("箱");
        }else{
            $("input[name='unit16A']").val("个");
        }

        countAnythingPrice();
    })

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

    function cancelPayTwo(){
        removeIframe();
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

    var formPosted = false;
    function checkout() {
        if(formPosted) {
            return false;
        }
        formPosted = true;
        
        var index = layer.load(0, {shade: false});
        $(".protoDetailWrap").hide();
        $.ajax({
            url: "${ctx}/goods/sitePlatformGoods/createNanDaoUpgradeOrder",
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

    function updateOrCreate(name,href){
        var bStop = false;
        var bStopIndex = 1;
        var show_navLi = $('#min_title_list li',window.top.document);
        show_navLi.each(function () {
            $(this).removeClass('active');
            if ($(this).find('span').text() == name) {
                bStopIndex = show_navLi.index($(this));
                bStop = true;
            }
        });
        if (!bStop) {
            creatIframe(href,name);
        } else {
            show_navLi.eq(bStopIndex).addClass('active');
            $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).show().find('iframe').attr({'src':href,});

        }
    }

    function checkPrice(){
        $.post("${ctx}/goods/nanDao/checkPrice",$("#orderForm").serialize(),function(result){
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
    function addGoods(){
        $.post("${ctx}/goods/nanDao/getAllSouthIslandsUpgrade",{id:goodIds},function(result){
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
                    if(newGoodSign=='BS20180107'){
                        $("#adj_num10").val("15");//初始化数量
                        notVIPPrice10A=result[i].columns.no_vip_price;
                        goodId10A=result[i].columns.id;
                        $("#10AImage").attr({"src":'${commonStaticImgPath}'+result[i].columns.icon});
                    }else if(newGoodSign=='BS20180108'){
                        $("#adj_num16").val("15");//初始化数量
                        notVIPPrice16A=result[i].columns.no_vip_price;
                        goodId16A=result[i].columns.id;
                        $("#16AImage").attr({"src":'${commonStaticImgPath}'+result[i].columns.icon});
                    }
                    newSitePrice=result[i].columns.site_price;
                    newId=result[i].columns.id;
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
        $(".btn_addLb").addClass("hide");
        if(newGoodSign=='BS20180107'){
            $("#10ANoVIPPrice").text(notVIPPrice10A.toFixed(2));
            $("#10AVIPPrice").text(newSitePrice.toFixed(2));
            sitePrice10A=newSitePrice;
            $("input[name='pid10A']").val(goodId10A);
            if(isVIP){
                $("input[name='price10A']").val(newSitePrice.toFixed(2));
            }else{
                $("input[name='price10A']").val(notVIPPrice10A.toFixed(2));
            }
        }else if(newGoodSign=='BS20180108'){
            $("#16ANoVIPPrice").text(notVIPPrice16A.toFixed(2));
            $("#16AVIPPrice").text(newSitePrice.toFixed(2));
            sitePrice16A=newSitePrice;
            $("input[name='pid16A']").val(goodId16A);
            if(isVIP){
                $("input[name='price16A']").val(newSitePrice.toFixed(2));
            }else{
                $("input[name='price16A']").val(notVIPPrice16A.toFixed(2));
            }
        }
        $(".btn_remove").removeClass("hide");
        goodIds=goodId10A+","+goodId16A;
        $.closeDiv($(".addProto"),true);
        countAnythingPrice();
    }

    function deleteGood(idVal){
        $(".btn_remove").addClass("hide");
        $("#"+idVal).addClass("hide");
        $(".btn_addLb").removeClass("hide");
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
        var unit=$(".unit"+va+"A").text();
        if(unit=='箱'){
            if(num>1){
                num-=1;
            }
        }else{
            if (num > 15) {
                num -= 10;
            }
        }

        counter.val(num);
        countAnythingPrice();
    }
    function addNum(va) {
        var counter = $("#adj_num"+va);
        var num = parseInt(counter.val());
        var unit=$(".unit"+va+"A").text();
        if(unit=='箱'){
            num+=1;
        }else{
            num += 10;
        }
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
            getLogisticsPrice(num10A,province);//计算运费
            var yunfei = $("#yunfei").text();
            $("input[name='logisticsPrice']").val(yunfei);

            var goodsZong = parseFloat(notVIPPrice10A)*parseFloat(num10A);//商品总额
            var payZong = 0;//应付总额
            var youhui = (parseFloat(notVIPPrice10A) - parseFloat(sitePrice10A))*num10A;//优惠价格
            if(isVIP){
                if(num10A>=144){
                    payZong=goodsZong-youhui;
                }else{
                    payZong=goodsZong-youhui+parseFloat(yunfei);
                }
            }else{
                if(num10A>=144){
                    payZong=parseFloat(goodsZong);
                }else{
                    payZong=parseFloat(goodsZong) + parseFloat(yunfei);
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
            getLogisticsPrice(num16A,province);//计算运费
            var yunfei = $("#yunfei").text();
            $("input[name='logisticsPrice']").val(yunfei);
            var goodsZong = parseFloat(notVIPPrice16A)*parseFloat(num16A);//商品总额
            var payZong = 0;//应付总额
            var youhui = (parseFloat(notVIPPrice16A) - parseFloat(sitePrice16A))*num16A;//优惠价格
            if(isVIP){
                if(num16A>=144){
                    payZong=goodsZong-youhui;
                }else{
                    payZong=goodsZong-youhui+parseFloat(yunfei);
                }
            }else{
                if(num16A>=144){
                    payZong=parseFloat(goodsZong);
                }else{
                    payZong=parseFloat(goodsZong) + parseFloat(yunfei);
                }
            }
            $("#orderZong16").text(goodsZong.toFixed(2));
            $(".yohuiPrice").text(youhui.toFixed(2));
            $("#zong").text(payZong.toFixed(2));

            $("input[name='zong16A']").val(payZong);
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
            getLogisticsPrice(numz,province);//计算运费
            var yunfei = $("#yunfei").text();
            $("input[name='logisticsPrice']").val(yunfei);

            $("#allNum").text(numz);//总数
            var goodsZong10A = parseFloat(notVIPPrice10A)*parseFloat(num10A);//商品总额
            var goodsZong16A = parseFloat(notVIPPrice16A)*parseFloat(num16A);//商品总额
            $("#orderZong10").text(goodsZong10A.toFixed(2));
            $("#orderZong16").text(goodsZong16A.toFixed(2));
            var heji=goodsZong10A+goodsZong16A;
            $("#allPri").text(heji.toFixed(2));//合计

            var payZong = 0;//应付总额
            var youhui=0;
            youhui10A = (parseFloat(notVIPPrice10A) - parseFloat(sitePrice10A))*num10A;//优惠价格
            youhui16A = (parseFloat(notVIPPrice16A) - parseFloat(sitePrice16A))*num16A;//优惠价格
            var youhui=youhui10A+youhui16A;
            if(isVIP){
                if(numz>=144){
                    payZong=heji-youhui;
                    $("input[name='zong10A']").val((parseFloat(sitePrice10A)*parseFloat(num10A)).toFixed(2));
                    $("input[name='zong16A']").val((parseFloat(sitePrice16A)*parseFloat(num16A)).toFixed(2));
                }else{
                    payZong=heji-youhui+parseFloat(yunfei);
                    $("input[name='zong10A']").val((parseFloat(sitePrice10A)*parseFloat(num10A)+parseFloat(yunfei)).toFixed(2));
                    $("input[name='zong16A']").val(parseFloat(sitePrice16A)*parseFloat(num16A));
                }
            }else{
                if(numz>=144){
                    payZong=parseFloat(heji);
                    $("input[name='zong10A']").val((parseFloat(notVIPPrice10A)*parseFloat(num10A)).toFixed(2));
                    $("input[name='zong16A']").val((parseFloat(notVIPPrice16A)*parseFloat(num16A)).toFixed(2));
                }else{
                    payZong=parseFloat(heji) + parseFloat(yunfei);
                    $("input[name='zong10A']").val((parseFloat(notVIPPrice10A)*parseFloat(num10A)+parseFloat(yunfei)).toFixed(2));
                    $("input[name='zong16A']").val((parseFloat(notVIPPrice16A)*parseFloat(num16A)).toFixed(2));
                }
            }
            $(".yohuiPrice").text(youhui.toFixed(2));
            $("#zong").text(payZong.toFixed(2));
        }
    }

    //根据省获取运费价格
    function getLogisticsPrice(num,province){
        var zhongPrice=0.00;
        if($.trim(province)=="安徽" || $.trim(province)=="江苏" || $.trim(province)=="浙江"|| $.trim(province)=="上海"){//首重15价格为8元（没增加一个加1元）
            zhongPrice=(num-15)/10*1.2+10;
            if(parseInt(num)>=144){
                $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
            }else{
                $("#yunfei").text(zhongPrice.toFixed(2));
            }
            $("#diqu").empty()
        }else　if($.trim(province)=="湖北" || $.trim(province)=="山东" || $.trim(province)=="江西"|| $.trim(province)=="河南" ||
            $.trim(province)=="河北" || $.trim(province)=="北京" || $.trim(province)=="福建"|| $.trim(province)=="广东" ||
            $.trim(province)=="湖南" || $.trim(province)=="天津"){
            zhongPrice = (num-15)/10*6+15;
            if(parseInt(num)>=144){
                $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
            }else{
                $("#yunfei").text(zhongPrice.toFixed(2));
            }
            $("#diqu").empty()
        }else if($.trim(province)=="重庆" || $.trim(province)=="四川" || $.trim(province)=="山西"|| $.trim(province)=="辽宁" ||
            $.trim(province)=="广西" || $.trim(province)=="广西壮族自治区" || $.trim(province)=="陕西" || $.trim(province)=="吉林"|| $.trim(province)=="贵州" ||$.trim(province)=="黑龙江" ||
            $.trim(province)=="云南" || $.trim(province)=="海南" || $.trim(province)=="内蒙古"|| $.trim(province)=="宁夏" ||$.trim(province)=="甘肃" ||
            $.trim(province)=="青海" ){
            if($.trim(province)=="重庆" || $.trim(province)=="四川" || $.trim(province)=="山西"|| $.trim(province)=="辽宁" || $.trim(province)=="广西壮族自治区" || $.trim(province)=="广西" ||
                $.trim(province)=="陕西" || $.trim(province)=="吉林"|| $.trim(province)=="贵州" ||$.trim(province)=="黑龙江" || $.trim(province)=="云南"){
                zhongPrice=(num-15)/10*8+16;
                if(parseInt(num)>=144){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }else{
                zhongPrice=(num-15)/10*10+20;
                if(parseInt(num)>=144){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }
            $("#diqu").empty()
        }else if($.trim(province)=="新疆" || $.trim(province)=="西藏"){
            if($.trim(province)=="新疆"){
                zhongPrice=(num-15)/10*20+30;
                if(parseInt(num)>=144){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }else if($.trim(province)=="西藏"){
                zhongPrice=(num-15)/10*20+30;
                if(parseInt(num)>=144){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }
            $("#diqu").empty();
        }else{
            layer.msg("暂不支持该地区的物流订单");
            $("#diqu").empty().append('<input type="hidden"  type="text" class="input-text w-1135 bg-fff f-l mr-40" nullmsg="暂不支持该地区的物流订单" datatype="*" maxlength="20">')
        }
        if($.trim(province) != "香港" && $.trim(province) != "澳门" && $.trim(province) != "台湾"){
            $.ajax({
                url: "${ctx}/goods/sitePlatformGoods/checkLogistics",
                type: "POST",
                data: {
                    province:province,
                    num:num,
                    logisticss:zhongPrice.toFixed(2)
                },
                success: function(data) {
                    if(data == "200"){
                        $("#yunfeiiii").empty();
                    } else if (data == "201") {
                        layer.msg("运费计算可能有误，请截图后联系管理员！");
                        $("#yunfeiiii").empty().append('<input type="hidden"  type="text" class="input-text w-1135 bg-fff f-l mr-40" nullmsg="运费计算可能有误，请截图后联系管理员!" datatype="*" maxlength="20">')
                    }else if(data == "401") {
                        layer.msg("暂不支持该省的物流订单！");
                        $("#yunfeiiii").empty().append('<input type="hidden"  type="text" class="input-text w-1135 bg-fff f-l mr-40" nullmsg="暂不支持该省的物流订单！" datatype="*" maxlength="20">')
                    }
                },
                error: function() {
                    layer.msg("运费计算失败");
                }
            });
        }
    }
</script>
</body>
</html>
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
        .webuploader-pick{
            width: 120px;
            height: 30px;
            padding:0;
        }
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
                                    <th class="w-110">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr id="10ANan"
                                    class="radius  <c:if test="${platform.columns.good_sign ne 'LB20180105'}">hide</c:if>">
                                    <td>
                                        <div class="wrap1 text-l ">
                                            <div class="imgWrap imgWrap">
                                                <img id="10AImage" src="${commonStaticImgPath}${images}" class="img pos"/>
                                                <div class="pl-25">
                                                    <h3 class="lh-30 f-14 goodName1">${platform.columns.name}</h3>
                                                    <p class="c-888 f-12 lh-20 line-clamp2" title="${platform.columns.description}" style="overflow: hidden; height: 40px;cursor:pointer;">${platform.columns.description}</p>
                                                </div>
                                            </div>
                                            <p class="pos-r pl-20 c-666 f-12 mt-5">
                                                <i class="sficon1 sficon-note2 pos"></i>10A适用家用普通插座，例如冰箱、洗衣机等
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
                                                <div class="priceWrap readonly">
                                                    <input type="text" id="adj_num10" readonly name="quantity10" class="input-text text-c readonly" value="15"/>
                                                    <span class="unit unit10A">个</span>
                                                </div>
                                                <a class="btn-plus" href="javascript:addNum(10);"></a>
                                            </div>
                                            <input type="hidden" name="unit10A" value="个"/>
                                            <p class=" text-l">
                                                <label class="mt-10 sficon1 sficon-rad1 sficon-rad1_selected cPointer" data-unit="个" data-num="15">按个</label>
                                                <label class="mt-10 sficon1 sficon-rad1 cPointer" data-unit="箱" data-num="1">按箱（144个/箱）</label>
                                            </p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1"><strong class="c-fd6e32 f-20">￥<span id="orderZong10" class="va-t"></span></strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1 ${platform.columns.good_sign eq 'LB20180105' ? '':'hide'}"><a class="btn_add  " onclick="addGoods('1','${platform.columns.id}')">添加商品</a></div>
                                        <div class="wrap1 hide"><a class="btn_del" onclick="deleteGood('10ANan')">删除商品</a></div>
                                    </td>
                                </tr>
                                <tr id="16ANan"
                                    class="radius <c:if test="${platform.columns.good_sign ne 'LB20180106'}">hide</c:if>">
                                    <td>
                                        <div class="wrap1 text-l ">
                                            <div class="imgWrap imgWrap">
                                                <img id="16AImage" src="${commonStaticImgPath}${images}" class="img pos"/>
                                                <div class="pl-25">
                                                    <h3 class="lh-30 f-14 goodName2">${platform.columns.name}</h3>
                                                    <p class="c-888 f-12 lh-20" title="${platform.columns.description}" style="overflow: hidden; height: 40px;cursor:pointer;">${platform.columns.description}</p>
                                                </div>
                                            </div>
                                            <input type="hidden" name="unit10A" value="个"/>
                                            <p class="pos-r pl-20 c-666 f-12 mt-5">
                                                <i class="sficon1 sficon-note2 pos"></i>16A适用大型家电，例如柜式空调、电热水器等
                                            </p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1">￥<span id="16ANoVIPPrice">${platform.columns.no_vip_price}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1"><span class="c-0383dc">￥<span id="16AVIPPrice">${platform.columns.site_price}</span></span></div>
                                    </td>
                                    <td>
                                        <div class="wrap1">￥${platform.columns.advice_price}</div>
                                    </td>
                                    <td>
                                        <div class="wrap1 w-140" style="margin: 0 auto;">
                                            <div class="countWrap w-140 mb-5">
                                                <a class="btn-minus" href="javascript:subNum(16);"></a>
                                                <div class="priceWrap readonly">
                                                    <input type="text" id="adj_num16" readonly name="quantity16" class="input-text text-c readonly" value="15"/>
                                                    <span class="unit unit16A">个</span>
                                                </div>
                                                <a class="btn-plus" href="javascript:addNum(16);"></a>
                                            </div>
                                            <input type="hidden" name="unit16A" value="个"/>
                                            <p class=" text-l">
                                                <label class="mt-10 sficon1 sficon-rad1 sficon-rad1_selected" data-unit="个" data-num="15">按个</label>
                                                <label class="mt-10 sficon1 sficon-rad1 " data-unit="箱" data-num="1">按箱（144个/箱）</label>
                                            </p>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1"><strong class="c-fd6e32 f-20">￥<span id="orderZong16" class="va-t">307.5</span></strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="wrap1 ${platform.columns.good_sign eq 'LB20180106' ? '':'hide' }">
                                            <a class="btn_add " onclick="addGoods('1','${platform.columns.id}')">添加商品</a>
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
                                <input type="hidden" name="pid10A" value="${platform.columns.good_sign eq 'LB20180105' ? platform.columns.id:'' }"/>
                                <input type="hidden" name="pid16A" value="${platform.columns.good_sign eq 'LB20180106' ? platform.columns.id:'' }"/>
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
        <%--	<a href="javascript:;" class="sficon closePopup"></a>--%>
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
                <%--<div class="f-r f-13">
                    <p >订单编号：${number }</p>
                    <p>订单类型：平台产品</p>
                    <p>应付金额：<span class="f-20 money" id="money"></span></p>
                </div>--%>
            </div>

            <!-- 支付二维码部分-->
            <div class="payment hide1">
                <div class="payWrap">
                    <div class="payWrapTitle">
                        支付<span class="c-fd7e2a pl-5 pr-5 moy"></span>元
                    </div>
                    <%--	<img src="${ctxPlugin }/static/h-ui.admin/images/img_payTishi.png" class="mt-10" />--%>
                    <p class=" pl-30 c-cc0000 pos-r f-14 mt-10">
                        <span class="pos iconDec"></span>
                        付款完成后，请务必上传支付凭证，并提交订单，以便工作人员处理订单，及时发货！<br />详情请咨询客服，QQ：387808217、2997231847。
                    </p>
                    <div class="cl pt-10">
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
                                    <img id="img-view" src="${ctxPlugin }/static/h-ui.admin/images/img-default2.png" />
                                </div>
                                <a class="c-0383dc w-140 lh-30 f-l text-c f-13" id="img-picker">上传支付凭证</a>
                            </div>
                            <div class="f-r icon_paystep">2</div>
                        </div>
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
            <a href="javascript:surePay();" class="sfbtn sfbtn-opt3 w-70 mr-5">确定支付</a>
            <a href="javascript:cancelPay();" class="sfbtn sfbtn-opt w-70 mr-5">取消订单</a>
        </div>
    </div>
</div>

<div id="ty" class="popupBox spPayWrap wxPay">
    <h2 class="popupHead">
        <!---->
        <span id="lie">微信-支付凭证示例</span>
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20 text-c">
            <!--<img src="static/h-ui.admin/images/paySeq_wx.png" />-->
            <img id="lieImg" src="${ctxPlugin}/static/h-ui.admin/images/paySeq_wx.png" />
        </div>
        <div class="text-c mt-10 mb-15">
            <a href="javascript:closeTY();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
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
    var uploaderCreated =false;
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

        if(goodsSign=='LB20180105'){
            sitePrice10A='${platform.columns.site_price}';
            notVIPPrice10A='${platform.columns.no_vip_price}';
            goodId10A='${platform.columns.id}';
            if(!isVIP){
                $("input[name='price10A']").val('${platform.columns.no_vip_price}');
            }
        }else if(goodsSign=='LB20180106'){
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
                uploadPayConfirm();
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

    $(".btn_checkcase").click(function(){
        if($.trim(payType)=="alipay"){
            $("#ty").removeClass("wxPay");
            $("#ty").addClass("zfbPay");
            $("#lie").text("支付宝-支付凭证示例");
            $("#lieImg").attr("src","${ctxPlugin}/static/h-ui.admin/images/paySeq_zfb.png")
        }
        $("#ty").popup({closeSelfOnly:true,level:4});
    })

    function closeTY(){
        $.closeDiv($("#ty"), true);
    }

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

    $('.radius').on('click','.sficon-rad1', function () {
        var oP = $(this).closest('.radius');
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

    function checkPrice(){
        $.post("${ctx}/goods/nanDao/checkPrice",$("#orderForm").serialize(),function(result){
            if(result=='fal'){
                layer.msg("价格计算可能有误，请截图后联系管理员！！！");
            }else{
                $("#sty").popup({closeSelfOnly: true,level:2});
            }
        });
    }

    var newGood="";
    var newGoodSign="";
    var newSitePrice="";
    var newId="";
    function addGoods(de,id){
        $.post("${ctx}/goods/nanDao/getAllSouthIslands",{de:de,id:goodIds},function(result){
            if(result!=null){
                var html='';
                for(var i=0;i<result.length;i++){
                    html+='<tr><td><span class="label-cbox "><input type="hidden" name="goodsId" value="'+result[i].columns.id+'" /></span></td>';
                    html+='<td>'+result[i].columns.name+'</td>';
                    html+='<td><img src="${commonStaticImgPath}'+result[i].columns.picture+'" style="width: 90px;height: 80px"/></td>';
                    html+='<td>'+result[i].columns.brand+'</td>';
                    html+='<td>'+result[i].columns.model+'</td>';
                    html+='<td>'+result[i].columns.category+'</td></tr>';
                    newGood=result[i].columns.name;
                    newGoodSign=result[i].columns.good_sign;
                    if(newGoodSign=='LB20180105'){
                        $(".goodName1").text(result[i].columns.name);
                        $("#adj_num10").val("15");//初始化数量
                        notVIPPrice10A=result[i].columns.no_vip_price;
                        goodId10A=result[i].columns.id;
                        $("#10AImage").attr({"src":'${commonStaticImgPath}'+result[i].columns.picture});
                    }else if(newGoodSign=='LB20180106'){
                        $(".goodName2").text(result[i].columns.name);
                        $("#adj_num16").val("15");//初始化数量
                        notVIPPrice16A=result[i].columns.no_vip_price;
                        goodId16A=result[i].columns.id;
                        $("#16AImage").attr({"src":'${commonStaticImgPath}'+result[i].columns.picture});
                    }

                    $("#10ANan").addClass("trbb");

                    newSitePrice=result[i].columns.site_price;
                    newId=result[i].columns.id;
                }
                $("#goodslist").empty().append(html);
                $(".addProto").popup({level:2},true);
            }
        });
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
                url: "${ctx}/goods/sitePlatformGoods/createNanDaoOrder",
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
                    window.top.layer.msg("订单提交失败");
                    cancelPay()
                },
                complete: function () {
                    formPo = false;
                    cancelPay();
                    removeIframe();
                }
            });
        }
    }

    function addGoodsNow(){
        var vas = $(".label-cbox-selected").children().val();
        if(isBlank(vas)){
            layer.msg("请选择商品！");
            return;
        }
        $(".radius").removeClass("hide");
        if(newGoodSign=='LB20180105'){
            $("#10ANoVIPPrice").text(notVIPPrice10A.toFixed(2));
            $("#10AVIPPrice").text(newSitePrice.toFixed(2));
            sitePrice10A=newSitePrice;
            $("input[name='pid10A']").val(goodId10A);
            if(isVIP){
                $("input[name='price10A']").val(newSitePrice.toFixed(2));
            }else{
                $("input[name='price10A']").val(notVIPPrice10A.toFixed(2));
            }
        }else if(newGoodSign=='LB20180106'){
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
                    $("input[name='zong10A']").val(parseFloat(sitePrice10A)*parseFloat(num10A));
                    $("input[name='zong16A']").val(parseFloat(sitePrice16A)*parseFloat(num16A));
                }else{
                    payZong=heji-youhui+parseFloat(yunfei);
                    $("input[name='zong10A']").val(parseFloat(sitePrice10A)*parseFloat(num10A)+parseFloat(yunfei));
                    $("input[name='zong16A']").val(parseFloat(sitePrice16A)*parseFloat(num16A));
                }
            }else{
                if(numz>=144){
                    payZong=parseFloat(heji);
                    $("input[name='zong10A']").val(parseFloat(notVIPPrice10A)*parseFloat(num10A));
                    $("input[name='zong16A']").val(parseFloat(notVIPPrice16A)*parseFloat(num16A));
                }else{
                    payZong=parseFloat(heji) + parseFloat(yunfei);
                    $("input[name='zong10A']").val(parseFloat(notVIPPrice10A)*parseFloat(num10A)+parseFloat(yunfei));
                    $("input[name='zong16A']").val(parseFloat(notVIPPrice16A)*parseFloat(num16A));
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
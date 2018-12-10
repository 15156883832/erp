<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>我的商品-购买平台合作商品</title>
	<meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
	<style type="text/css">
		/* WebKit browsers */
		input::-webkit-input-placeholder {
			color: #777;
		}
		/* Mozilla Firefox 4 to 18 */
		input:-moz-placeholder {
			color: #777;
			opacity: 1;
		}
		/* Mozilla Firefox 19+ */
		input::-moz-placeholder {
			color: #777;
			opacity: 1;
		}
		/* Internet Explorer 10+ */
		input:-ms-input-placeholder {
			color: #777;
		}
	</style>
</head>
<body>
<div class="popupBox protoDetailWrap">
	<h2 class="popupHead">
		购买
		<a href="javascript:;" class="sficon closePopup" id="goumai"></a>
	</h2>
	<div class="popupContainer" style="padding-bottom: 0;">
		<div class="popupMain pt-10 pl-15 pr-15 pb-15">
			<form id="orderForm">
				<div class="mb-10 cl f-13">
					<div class="f-l">
						<label class="w-100 f-l">购买产品：</label>
						<p class="f-l lh-24"><strong class="f-16"> ${platform.columns.name} </strong></p>
					</div>
					<div class="f-l ml-30 pt-5">
						<span class="f-l">商品单价：￥91.4</span>
						<span class="f-l f-14 c-fd6e32 ml-10">VIP会员价：￥${platform.columns.site_price}</span>
					</div>
				</div>

				<div class="bg-e2eefc pt-10 pb-15 mb-15">
					<div class="cl mb-10">
						<div class="f-l">
							<span id="diqu"></span>
							<label class="f-l w-90 text-r"><em class="mark">*</em>收件人：</label>
							<input name="customerName" type="text" class="input-text w-190 bg-fff f-l mr-40" nullmsg="请输入收件人" datatype="*" maxlength="20">
						</div>
						<div class="f-r pr-25">
							<label class="f-l w-90 text-r"><em class="mark">*</em>联系方式：</label>
							<input name="customerMobile" type="text" class="input-text w-200 bg-fff f-l" nullmsg="请检查联系方式" errormsg="联系方式格式不正确" datatype="m" maxlength="20">
						</div>
						<input type="hidden" name="price" value="${platform.columns.site_price }"/>
						<input type="hidden" name="pid" value="${platform.columns.id }"/>
						<input type="hidden" name="payType" value="alipay"/>
						<input type="hidden" name="orderNumber" value=""/>
						<input type="hidden" id="img-input"  name="icon" value="">
						<input type="hidden" id="logisticsPrice"  name="logisticsPrice" value=""><%--运费--%>
					  <input type="hidden" id="siteprovince" name="province" value="${site.province}">
                        <input type="hidden" id="sitecity" name="city" value="${site.city}">
                        <input type="hidden" id="sitearea" name="area" value="${site.area}">
						<input type="hidden" name="zong" value="">
					</div>

					<div class="cl mb-10" id="pcd">
						<label class="f-l w-90 text-r"><em class="mark">*</em>收件地址：</label>
						<select class="select f-l w-100 bg-fff prov" id="province">
							<option value="" >请选择省份</option>
						</select>
						<select class="city select f-l w-100 bg-fff ml-15" id="city">
							<option value="">请选择市</option>
						</select>
						<select class="dist select f-l w-100 bg-fff ml-15" id="area">
							<option value="">请选择区/县</option>
						</select>
						<input name="customerAddress" placeholder="请输入详细地址" type="text" class="ml-15 input-text f-l bg-fff w-280 " nullmsg="请输入详细地址" datatype="*" maxlength="100">

					</div>
				</div>

				<%--<div class="cl mb-10">
					&lt;%&ndash;<div class="f-l w-330">
						<label class="f-l w-90 text-r">商品单价：</label>
						<span class="f-l f-16">￥91.4</span>
					</div>&ndash;%&gt;
					<div class="f-l">
						<label class="f-l w-90 text-r">运费：</label>
						<span class="f-l f-16" >￥<span id="yunfei">10.00</span></span>
						<span class="f-l c-666 lh-26" id="ninety">（满90个包邮）</span>
						<span class="f-l lh-26 c-fd6e32 " id="upninety">（免运费）</span>
					</div>
				</div>--%>
				<div class="cl mb-15">
					<div class="f-l ">
						<label class="f-l w-90 text-r">购买数量：</label>
						<div class="countWrap w-140 f-l">
							<a href="javascript:subNum();" class="btn-minus"></a>
							<input type="text" id="adj_num"  name="quantity" class="input-text bg-fff readonly" readonly="readonly" value="15" />
							<a href="javascript:addNum();" class="btn-plus"></a>
						</div>

					</div>
					<span class="f-l c-666 lh-26 ml-10" id="ninety">（满90个包邮）</span>
					<span class="f-l lh-26 c-fd6e32 ml-10 " id="upninety">（免运费）</span>
					<%--<div class="f-l">
						<label class="f-l w-90 text-r">商品总价：</label>
						<span class="f-l f-16 c-fd6e32" id="orderZong"></span>
					</div>--%>
				</div>
				<div class="cl mb-15">
					<div class="f-l">
						<label class="f-l w-90 text-r">商品总额：</label>
						<span class=" f-l f-16 c-fd6e32">￥<span class=" f-16 c-fd6e32" id="orderZong"></span></span>
					</div>
					<div class="f-l ml-30">
						<label class="f-l">运费：</label>
						<span class="f-l lh-26 c-fd6e32" >￥<span id="yunfei" class="va-t">10.00</span></span>
					</div>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90 text-r">支付方式：</label>
					<div class="f-l">
						<a class="paywapWrap f-l payCurrent pay-by-zfb">
							<i class="icon-pay icon-zfb mr-5"></i>
							支付宝
							<i class="icon_choice"></i>
						</a>
						<a class="paywapWrap f-l pay-by-wx">
							<i class="icon-pay icon-wx mr-5"></i>
							微信
							<i class="icon_choice"></i>
						</a>
					</div>
				</div>
				<div class="line-solid mb-15"></div>
				<div class="cl pl-20">
					<%--<div class="f-l">
						<a class="paywapWrap f-l payCurrent pay-by-zfb">
							<i class="icon-pay icon-zfb mr-5"></i>
							支付宝
							<i class="icon_choice"></i>
						</a>
						<a class="paywapWrap f-l pay-by-wx">
							<i class="icon-pay icon-wx mr-5"></i>
							微信
							<i class="icon_choice"></i>
						</a>
					</div>--%>
					<div class="f-r">
						<span class="lh-30">
							（已优惠：<span class="c-fd6e32">￥</span><span class="c-fd6e32" id="yohuiPrice"></span>）
							应付金额：<span class="c-fd6e32 f-20 va-t">￥</span><strong class="c-fd6e32 f-20 va-t"  id="zong" name="zong">${platform.columns.site_price}</strong>
						</span>
						<a href="javascript:;" id="immPay" class="btn_buyPrototype ml-10" style="width: 120px;">购买</a>
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
		<div class="text-c mt-10 mb-10">
			<!-- <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" style="display: none;" >重新支付</a> -->
			<a href="javascript:surePay();" class="sfbtn sfbtn-opt3 w-70 mr-5">确定支付</a>
			<a href="javascript:cancelPay();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
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

<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>

<script type="text/javascript">
    var payType = "alipay";
    var formPosted = false;
    var monitor;
    var goodsName='${platform.columns.name}';
    var sitePrice='${platform.columns.site_price}';
    var numb='${number}';
    var isVIP=true;
    var uploaderCreated =false;

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
            //$(".oneImg").remove();

        });
	}
    $(function(){
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

        $("#upninety").hide();

        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            var yun=$("#yunfei").text();
            if(result=="showPopup"){
                var z=91.4*15+parseFloat(yun);
                $("#zong").text(z);
                $("input[name='zong']").val(z);
                $("input[name='price']").val("91.4");
                $("input[name='logisticsPrice']").val(yun);
                $("#yohuiPrice").text(0);
                isVIP=false;
            }else{
                var z=sitePrice*15+parseFloat(yun);
                $("#zong").text(z);
                $("input[name='zong']").val(z);
                $("input[name='logisticsPrice']").val(yun);
                $("input[name='price']").val(sitePrice);
                $("#yohuiPrice").text((parseFloat(91.4*15)-parseFloat(sitePrice*15)).toFixed(2));
            }
            $("#orderZong").text(parseFloat(91.4*15).toFixed(2));
        });

        $("#pcd").citySelect({
            url:'${ctxPlugin}/lib/city.min.js',
            address: '${site.province}${site.city}${site.area}'
        });

        $('.protoDetailWrap').popup();
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
                $("#money").text("￥" + zong);//支付金额
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

                //createUploader("#filePicker-add", "#Imgprocess2", "file_fake_addimg", "file_fake_add", "delimgs");
                var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档
                var thumbnailHeight = 130;

                //$("#sty").popup({closeSelfOnly: true});
                uploadPayConfirm();
                $("#sty").popup({level:2,closeSelfOnly:true});
                return false;
            }
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
		/* $(".closePopup").bind('click', function () {
		 //			cancelPay();
		 $.closeAllDiv();
		 }); */

        var price='${platform.columns.site_price}';
        if($.trim(goodsName)=='漏电保护插头'){
            var num=$("#adj_num").val();
            if(parseInt(num)<=15){
                $("#adj_num").val("15");
                //$('.btn-minus').removeAttr('href');//去掉a标签中的href属性
                $("#zong").text(price*15);
            }
        }

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

	/* $("#goumai").on("click",function(){
	 $('#Hui-article-box',window.top.document).css({'z-index':'9'});
	 }) */

    function closeDiv(){
        $.closeDiv($(".protoDetailWrap"));
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});

    }

    function subNum() {
        var price = $("input[name='price']").val();
        var counter = $("#adj_num");
        var num = parseInt(counter.val());
        if($.trim(goodsName)=='漏电保护插头'){
            if(num>15){
                num-=10;
            }
        }else{
            if (num > 1) {
                num-=10;
            }
        }

        counter.val(num);
        if(!isVIP){
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((91.4*num).toFixed(2));
        }else{
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((91.4*num).toFixed(2));
            $("#yohuiPrice").text((parseFloat(91.4*num)-parseFloat(sitePrice*num)).toFixed(2));
        }
        var province=$("#province").val();
        getLogisticsPrice(num,province);

        if(parseInt(num)<90){
            $("#upninety").hide();
            $("#ninety").show();
            var yun=$("#yunfei").text();//运费
            var z=parseFloat(yun)+(num * parseFloat(price));
            $("#zong").text(z.toFixed(2));
        }
    }
    function addNum() {
        var price = $("input[name='price']").val();
        var counter = $("#adj_num");
        var num = parseInt(counter.val());
        if(num>=15){
            num+=10;
        }
        counter.val(num);
        if(!isVIP){
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((91.4*num).toFixed(2));
        }else{
            $("#zong").text((num * parseFloat(price)).toFixed(2));
            $("#orderZong").text((91.4*num).toFixed(2));
            $("#yohuiPrice").text((parseFloat(91.4*num)-parseFloat(sitePrice*num)).toFixed(2));
        }

        var province=$("#province").val();
        getLogisticsPrice(num,province);
        if(parseInt(num)>=90){
            $("#upninety").show();
            $("#ninety").hide();
        }else{
            var yun=$("#yunfei").text();//运费
            var z=parseFloat(yun)+(num * parseFloat(price));
            $("#zong").text(z.toFixed(2));
        }
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
            layer.msg("请上传支付凭证！")
        }else{
            formPo=true;
            $.ajax({
                url: "${ctx}/goods/sitePlatformGoods/createNanDaoOrder",
                type: "POST",
                data: $("#orderForm").serialize(),
                success: function(data) {
                    layer.msg("支付成功！");
                    //$.closeDiv($(".protoDetailWrap"));
                    window.location.href='${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist';
                    $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                    //window.parent.location.reload();
                },
                error: function() {
                    layer.msg("订单提交失败");
                },
                complete: function () {
                    formPo = false;
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
        var num=$("#adj_num").val();//购买数量
        getLogisticsPrice(num,province);
    });

    //根据省获取运费价格
    function getLogisticsPrice(num,province){
        var zhongPrice=0.00;
        if($.trim(province)=="安徽" || $.trim(province)=="江苏" || $.trim(province)=="浙江"|| $.trim(province)=="上海"){//首重15价格为8元（没增加一个加1元）
            zhongPrice=(num-15)/10*1+8;
            if(parseInt(num)>=90){
                $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
            }else{
                $("#yunfei").text(zhongPrice.toFixed(2));
            }
            $("#diqu").empty()
        }else　if($.trim(province)=="湖北" || $.trim(province)=="山东" || $.trim(province)=="江西"|| $.trim(province)=="河南" ||
            $.trim(province)=="河北" || $.trim(province)=="北京" || $.trim(province)=="福建"|| $.trim(province)=="广东" ||
            $.trim(province)=="湖南" || $.trim(province)=="天津"){
            zhongPrice = (num-15)/10*5+12;
            if(parseInt(num)>=90){
                $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
            }else{
                $("#yunfei").text(zhongPrice.toFixed(2));
            }
            $("#diqu").empty()
        }else if($.trim(province)=="重庆" || $.trim(province)=="四川" || $.trim(province)=="山西"|| $.trim(province)=="辽宁" ||
            $.trim(province)=="广西" || $.trim(province)=="陕西" || $.trim(province)=="吉林"|| $.trim(province)=="贵州" ||$.trim(province)=="黑龙江" ||
            $.trim(province)=="云南" || $.trim(province)=="海南" || $.trim(province)=="内蒙古"|| $.trim(province)=="宁夏" ||$.trim(province)=="甘肃" ||
            $.trim(province)=="青海" ){
            if($.trim(province)=="重庆" || $.trim(province)=="四川" || $.trim(province)=="山西"|| $.trim(province)=="辽宁" || $.trim(province)=="广西" ||
                $.trim(province)=="陕西" || $.trim(province)=="吉林"|| $.trim(province)=="贵州" ||$.trim(province)=="黑龙江" || $.trim(province)=="云南"){
                zhongPrice=(num-15)/10*6+15;
                if(parseInt(num)>=90){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }else{
                zhongPrice=(num-15)/10*8+15;
                if(parseInt(num)>=90){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }
            $("#diqu").empty()
        }else if($.trim(province)=="新疆" || $.trim(province)=="西藏"){
            if($.trim(province)=="新疆"){
                zhongPrice=(num-15)/10*15+30;
                if(parseInt(num)>=90){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }else if($.trim(province)=="西藏"){
                zhongPrice=(num-15)/10*20+30;
                if(parseInt(num)>=90){
                    $("#yunfei").empty().append('<del>'+zhongPrice.toFixed(2)+'</del>');
                }else{
                    $("#yunfei").text(zhongPrice.toFixed(2));
                }
            }
            $("#diqu").empty();
        }else{
            layer.msg("暂不支持该地区的物流订单");
            $("#diqu").empty().append('<input type="hidden"  type="text" class="input-text w-190 bg-fff f-l mr-40" nullmsg="暂不支持该地区的物流订单" datatype="*" maxlength="20">')
        }

        if(!isVIP){//非会员
            var zong=parseFloat(num)*91.4;
            if(parseInt(num)>=90){
                $("#zong").text(zong.toFixed(2));
                $("input[name='zong']").val(zong.toFixed(2));
            }else{
                var zhong=zong+zhongPrice;
                $("#zong").text(zhong.toFixed(2));
                $("input[name='zong']").val(zhong.toFixed(2));
            }
        }else{
            var zong=parseFloat(num)*sitePrice;
            if(parseInt(num)>=90){
                $("#zong").text(zong.toFixed(2));
                $("input[name='zong']").val(zong.toFixed(2));
            }else{
                var zhong=zong+zhongPrice;
                $("#zong").text(zhong.toFixed(2));
                $("input[name='zong']").val(zhong.toFixed(2));

            }
        }

        $("input[name='province']").val($("#province").val());
        $("input[name='city']").val($("#city").val());
        $("input[name='area']").val($("#area").val());
        $("#logisticsPrice").val(zhongPrice.toFixed(2));

    }

</script>
</body>
</html>
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
		.addProto tr{ cursor: pointer; }

		.webuploader-pick{
			width: 120px;
			height: 30px;
			padding:0;
		}

	</style>
</head>
<body>
<div class="popupBox protoDetailWrap" style="width: 860px">
	<h2 class="popupHead">
		购买
		<a href="javascript:;" class="sficon closePopup" id="goumai"></a>
	</h2>
	<div class="popupContainer" style="padding-bottom: 0;">
		<div class="popupMain pt-15 pl-15 pr-15 pb-15">
			<form id="orderForm" >
				<h3 class="modelHead mb-10">
					购买产品
					<a id="addgoodsTy" class="sfbtn sfbtn-opt3 f-r pos-r" href="javascript:addGoods('1','${platform.columns.id}');" style="bottom: 6px;font-weight: 400;">添加商品</a>
					<a id="addgoodsTyca" class="sfbtn sfbtn-opt3 f-r pos-r sfbtn-disabled hide"  style="bottom: 6px;font-weight: 400;">添加商品</a>
					<img class="f-r mr-5" src="${ctxPlugin}/static/h-ui.admin/images/hand1.gif">
				</h3>
				<c:if test="${platform.columns.good_sign eq 'LB20180106'}">
					<div id="addInthere">

					</div>
				</c:if>

				<div>
					<div class="cl lh-24 pl-15">
						<c:if test="${platform.columns.good_sign eq 'LB20180106'}">
							<strong class="f-l f-16 w-240 godnan16A">${platform.columns.name}</strong>
						</c:if>

						<c:if test="${platform.columns.good_sign eq 'LB20180105'}">
							<strong class="f-l f-16 w-240 godnan10A">${platform.columns.name}</strong>
						</c:if>

						<div class="f-l w-140 ">商品单价：￥${platform.columns.no_vip_price}</div>
						<div class="f-l w-140">VIP会员价：<span class="f-16 va-t">￥${platform.columns.site_price}</span></div>
						<a class="f-r c-fd6e32 f-16 goodsN hide" href="javascript:deleteGoods('${platform.columns.id}','${platform.columns.name}','${platform.columns.good_sign}');">【删除】</a>
					</div>
					<c:if test="${platform.columns.good_sign eq 'LB20180106'}">
						<p class="ml-15 c-888 mb-10 sficon1 sficon-note2 tishi16A">16A适用大型家电，例如柜式空调、电热水器等 </p>
					</c:if>

					<c:if test="${platform.columns.good_sign eq 'LB20180105'}">
						<p class="ml-15 c-888 mb-10 sficon1 sficon-note2 tishi10A">10A适用家用普通插座，例如冰箱、洗衣机等 </p>
					</c:if>
				</div>

				<c:if test="${platform.columns.good_sign eq 'LB20180105'}">
					<div id="addInthere">

					</div>
				</c:if>
				<h3 class="modelHead mb-10">
					购买数量
				</h3>

				<div class="cl mb-5 lh-26 pl-15 pr-15 buyCountBox <c:if test="${platform.columns.good_sign eq 'LB20180106'}">hide</c:if> ">
					<strong class="f-l f-16 w-180" id="godna10">${platform.columns.name}</strong>
					<div class="f-l w-260 mt-3">
						<span class="f-l cPointer sficon1 sficon-rad1 sficon-rad1_selected" data-unit="个" data-num="15">按个</span>
						<span class="f-l cPointer ml-30 sficon1 sficon-rad1" data-unit="箱" data-num="1">按箱（144个/箱）</span>
					</div>
					<div class="countWrap w-140 f-l">
						<a href="javascript:subNum(10);" class="btn-minus"></a>
						<div class="priceWrap readonly">
							<input type="text" id="adj_num10"  name="quantity10" class="input-text bg-fff readonly va-t" readonly="readonly" value="15" />
							<span class="unit unit10A" >个</span>
						</div>
						<input type="hidden" name="unit10A" value="个"/>
						<a href="javascript:addNum(10);" class="btn-plus"></a>
					</div>
					<div class="f-r ">商品总额：<span class="f-16 va-t" >￥<span id="orderZong10">370</span></span></div>
				</div>

				<div class="cl mb-5 lh-26 pl-15 pr-15 buyCountBox <c:if test="${platform.columns.good_sign eq 'LB20180105'}">hide</c:if> ">
					<strong class="f-l f-16 w-180" id="godna16">${platform.columns.name}</strong>
					<div class="f-l w-260 mt-3">
						<span class="f-l cPointer sficon1 sficon-rad1 sficon-rad1_selected" data-unit="个" data-num="15">按个</span>
						<span class="f-l cPointer ml-30 sficon1 sficon-rad1" data-unit="箱" data-num="1">按箱（144个/箱）</span>
					</div>
					<div class="f-l w-140 text-c">
						<div class="countWrap w-140 f-l">
							<a href="javascript:subNum(16);" class="btn-minus"></a>
							<div class="priceWrap readonly">
								<input type="text" id="adj_num16"  name="quantity16" class="input-text bg-fff readonly va-t" readonly="readonly" value="15" />
								<span class="unit unit16A" >个</span>
							</div>
							<input type="hidden" name="unit16A" value="个"/>
							<a href="javascript:addNum(16);" class="btn-plus"></a>
						</div>
					</div>
					<div class="f-r ">商品总额：<span class="f-16 va-t" >￥<span id="orderZong16">370</span></span></div>
				</div>

				<div class="cl mb-10 lh-26 pl-15 pr-15 goodsN hide">
					<div class="f-l c-fd6e32 f-16"style="margin-left: 440px;" >总数：<span id="allNum">0</span>个</div>
					<div class="f-r c-fd6e32 f-16" >合计：￥<span id="allPri">714</span></div>
				</div>

				<div class="mb-10 cl f-13 hide">
					<div class="f-l">
						<label class="w-100 f-l">购买产品：</label>
						<p class="f-l lh-24"><strong class="f-16"> ${platform.columns.name} </strong></p>
					</div>
					<div class="f-l ml-30 pt-5">
						<c:if test="${platform.columns.good_sign eq 'LB20180105'}">
							<span class="f-l">商品单价：￥20.50</span>
						</c:if>
						<c:if test="${platform.columns.good_sign eq 'LB20180106'}">
							<span class="f-l">商品单价：￥22.50</span>
						</c:if>
						<span class="f-l f-14 c-fd6e32 ml-10">VIP会员价：￥${platform.columns.site_price}</span>
					</div>
				</div>

				<div class="bg-e2eefc pt-10 pb-15 mb-15">
					<div class="cl mb-10">
						<div class="f-l">
							<span id="diqu"></span>
							<span id="yunfeiiii"></span>
							<label class="f-l w-90 text-r"><em class="mark">*</em>收件人：</label>
							<input name="customerName" type="text" class="input-text w-190 bg-fff f-l mr-40" nullmsg="请输入收件人" datatype="*" maxlength="20">
						</div>
						<div class="f-l pr-25">
							<label class="f-l w-190 text-r"><em class="mark">*</em>联系方式：</label>
							<input name="customerMobile" type="text" class="input-text w-200 bg-fff f-l" nullmsg="请检查联系方式" errormsg="联系方式格式不正确" datatype="m" maxlength="20">
						</div>
							<input type="hidden" name="price10A" value="${platform.columns.site_price }"/>
							<input type="hidden" name="price16A" value="${platform.columns.site_price }"/>
							<input type="hidden" name="pid10A" value="${platform.columns.good_sign eq 'LB20180105' ? platform.columns.id:'' }"/>
							<input type="hidden" name="pid16A" value="${platform.columns.good_sign eq 'LB20180106' ? platform.columns.id:'' }"/>
							<input type="hidden" name="payType" value="alipay"/>
							<input type="hidden" name="orderNumber" value="${number}"/>
							<input type="hidden" id="img-input"  name="icon" value="">
							<input type="hidden" id="logisticsPrice"  name="logisticsPrice" value=""><%--运费--%>
							<input type="hidden" name="province" value="${site.province}">
							<input type="hidden" name="city" value="${site.city}">
							<input type="hidden" name="area" value="${site.area}">
							<input type="hidden" name="zong10A" value="">
							<input type="hidden" name="zong16A" value="">
					</div>

					<div class="cl" id="pcd">
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
				<div class="cl mb-5">
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
				<p class="mb-10 ml-90 c-888 sficon1 sficon-note2">建议您使用支付宝支付</p>
				<div class="line-solid mb-15"></div>
				<div class="cl pl-20">
					<div class="f-l lh-26">
						<label class="f-l">运费：</label>
						<span class="f-l f-14 c-fd6e32 va-m">￥<span id="yunfei" class="va-t">10.00</span></span>
						<span class="f-l ">（满144个免运费）</span>
					</div>
					<div class="f-r">
						<span class="lh-30">
							应付金额：<span class="c-fd6e32 f-20 va-t">￥</span><strong class="c-fd6e32 f-20 va-t"  id="zong" name="zong"></strong>
						</span>
					</div>
				</div>
				<div class="cl">
					<div class="f-r">
					<span class="mr-10 hide" id="openVIP">（<a class="c-fd6e32 underline va-t sficon1 sficon-crown1 mr-10" onclick="jumpToVIP()">开通会员</a>立减<span class="c-fd6e32 yohuiPrice"></span>）</span>
					<span class="mr-10" id="hadYouHui">已优惠：<span class="c-fd6e32 va-t">￥<span class="c-fd6e32 yohuiPrice va-t" ></span></span></span>
					<a href="javascript:;" id="immPay" class="btn_buyPrototype goumai" style="width: 120px;">购买</a>
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
					<th class="w-100">商品品牌</th>
					<th class="w-100">商品型号</th>
					<th class="w-100">商品类别</th>
				</tr>
				</thead>
				<tbody id="goodslist">
				<tr>
					<td><span class="label-cbox "></span></td>
					<td>漏电保护插头 10A </td>
					<td>
						<img src="" class="w-80" />
					</td>
					<td>南岛</td>
					<td>NB-ZL3M-10 </td>
					<td>插座</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="text-c mt-20">
			<a href="javascript:addGoodsNow();" class="sfbtn sfbtn-opt3 w-70 mr-5">添加</a>
			<a href="javascript:cancelAdd();" class="sfbtn sfbtn-opt w-70 ">取消</a>
		</div>
	</div>
</div>


<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>

<script type="text/javascript">
	var payType = "alipay";
	var goodsName='${platform.columns.name}';
	var goodsSign='${platform.columns.good_sign}';
	var sitePrice10A=0;//会员价（10A）
	var sitePrice16A=0;//会员价（16A）
	var numb='${number}';
	var isVIP=${isVIP};
    var uploaderCreated =false;
	var notVIPPrice10A='${platform.columns.no_vip_price}';//非会员价(10A)
	var notVIPPrice16A='${platform.columns.no_vip_price}';//非会员价(16A)

    $(function(){
        $("#upninety").hide();

        if(isVIP){
            $("#openVIP").addClass("hide");
            $("#hadYouHui").removeClass("hide");
        }else{
            $("#openVIP").removeClass("hide");
            $("#hadYouHui").addClass("hide");
        }

        if(goodsSign=='LB20180105'){
            sitePrice10A='${platform.columns.site_price}';
            if(!isVIP){
                $("input[name='price10A']").val(notVIPPrice10A);
			}
        }else if(goodsSign=='LB20180106'){
            sitePrice16A='${platform.columns.site_price}';
            if(!isVIP){
                $("input[name='price16A']").val(notVIPPrice16A);
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

    $('.protoDetailWrap').on('click','.sficon-rad1', function () {
		var oP = $(this).closest('.buyCountBox');
		oP.find('.sficon-rad1').removeClass('sficon-rad1_selected');
		oP.find('.priceWrap .unit').html($(this).attr('data-unit'));
        oP.find('.priceWrap .input-text').val($(this).attr('data-num'));
		$(this).addClass('sficon-rad1_selected');
        changeAllNum();
        countAnythingPrice();
    })


    /**
	 * 计算总个数
     */
	function changeAllNum(){
        var unit10A=$(".unit10A").text();
        var num10A=$("#adj_num10").val();
        var unit16A=$(".unit16A").text();
        var num16A=$("#adj_num16").val();

        if($.trim(unit10A)== '箱'){
            num10A=parseInt(num10A)*144;
            $("input[name='unit10A']").val("箱");
        }else{
            $("input[name='unit10A']").val("个");
		}
        if($.trim(unit16A)== '箱'){
            num16A=parseInt(num16A)*144;
            $("input[name='unit16A']").val("箱");
        }else{
            $("input[name='unit16A']").val("个");
		}
        $("#allNum").text((parseInt(num10A)+parseInt(num16A)));
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

    function addGoods(de,id){
        $.post("${ctx}/goods/nanDao/getAllSouthIslands",{de:de,id:id},function(result){
			if(result!=null){
			 	var html='';
				for(var i=0;i<result.length;i++){
				    html+='<tr><td><span class="label-cbox "><input type="hidden" name="goodsId" value="'+result[i].columns.id+'" /></span></td>';
				    html+='<td>'+result[i].columns.name+'</td>';
				    html+='<td>'+result[i].columns.brand+'</td>';
				    html+='<td>'+result[i].columns.model+'</td>';
				    html+='<td>'+result[i].columns.category+'</td></tr>';
				}
				$("#goodslist").empty().append(html);
                $(".addProto").popup({level:2},true);
			}
        });
    }

    var preventRepeat=false;
    function addGoodsNow(){
        if(preventRepeat){
            return;
		}
        var vas = $(".label-cbox-selected").children().val();
        if(isBlank(vas)){
            layer.msg("请选择商品！");
            return;
        }
        var id=$("#goodslist").find(".label-cbox-selected").find("input[name='goodsId']").val();
        preventRepeat=true;
        $.post("${ctx}/goods/nanDao/getSouthIslandById",{id:id},function(result){
            if(result!=null){
                var html='';
                html+='<div class="cl mb-5 lh-26 pl-15">';

                if(result.columns.good_sign=='LB20180105'){
                    html+='<strong class="f-l f-16 w-240 godnan10A">'+result.columns.name+'</strong>';
                    html+='<div class="f-l w-140 ">商品单价：￥'+result.columns.no_vip_price+'</div>';
                }else if(result.columns.good_sign=='LB20180106'){
                    html+='<strong class="f-l f-16 w-240 godnan16A">'+result.columns.name+'</strong>';
                    html+='<div class="f-l w-140 ">商品单价：￥'+result.columns.no_vip_price+'</div>';
                }
                html+='<div class="f-l w-140 ">VIP会员价：<span class="f-16 va-t" id="anotherGoodsVIPPrice">￥'+result.columns.site_price+'</span></div>';
                html+='<a class="f-r c-fd6e32 f-16 goodsN" href="javascript:deleteGoods(\''+result.columns.id+'\',\''+result.columns.name+'\',\''+result.columns.good_sign+'\');">【删除】</a></div>';

                if(result.columns.good_sign=='LB20180105'){
                    html+='<p class="ml-15 c-888 mb-10 sficon1 sficon-note2 tishi10A">10A适用家用普通插座，例如冰箱、洗衣机等 </p>';
                    $("#addInthere").prepend(html);
                    $("#godna10").text(result.columns.name);
                }else{
                    html+='<p class="ml-15 c-888 mb-10 sficon1 sficon-note2 tishi16A">16A适用大型家电，例如柜式空调、电热水器等 </p>'
                    $("#addInthere").append(html);
                    $("#godna16").text(result.columns.name);
				}
                $(".goodsN").removeClass("hide");
                var go10=$("#godna10").text();
                var go16=$("#godna16").text();
                if(result.columns.name==go10){
                    $("#godna10").parent("div").removeClass("hide");
                }else if(result.columns.name==go16){
                    $("#godna16").parent("div").removeClass("hide");
                }

                if(result.columns.good_sign=='LB20180105'){
                    sitePrice10A=result.columns.site_price;
                    notVIPPrice10A=result.columns.no_vip_price;
                    if(isVIP){
                        $("input[name='price10A']").val(result.columns.site_price);
                    }else{
                        $("input[name='price10A']").val(result.columns.no_vip_price);
					}
                    $("input[name='pid10A']").val(result.columns.id);
                }else if(result.columns.good_sign=='LB20180106'){
                    sitePrice16A=result.columns.site_price;
                    notVIPPrice16A=result.columns.no_vip_price;
                    if(isVIP){
                        $("input[name='price16A']").val(result.columns.site_price);
					}else{
                        $("input[name='price16A']").val(result.columns.no_vip_price);
					}
                    $("input[name='pid16A']").val(result.columns.id);
                }

                countAnythingPrice();
				$("#addgoodsTy").addClass("hide");
				$("#addgoodsTyca").removeClass("hide");
                preventRepeat=false;
                $.closeDiv($(".addProto"),true);
                changeAllNum();
            }
        });
    }

    function deleteGoods(id,godname,va){
        var go1=$(".godnan10A").text();
        var gon=$(".godnan16A").text();
        if(va=="LB20180105"){
            $("#godna10").parent("div").addClass("hide");
        }else if(va=="LB20180106"){
            $("#godna16").parent("div").addClass("hide");
        }
        if(godname==go1){
            $(".godnan10A").parent("div").remove();
            $(".tishi10A").remove();
        }else if(godname==gon){
            $(".godnan16A").parent("div").remove();
            $(".tishi16A").remove();
        }

        //方便计算各种价格
        if(va=="LB20180105"){
			sitePrice10A=0;
            $("input[name='price10A']").val("");
            $("input[name='pid10A']").val("");
		}else if(va=="LB20180106"){
            sitePrice16A=0;
            $("input[name='price16A']").val("");
            $("input[name='pid16A']").val("");
		}
        countAnythingPrice();
        $(".goodsN").addClass("hide");
        $("#addgoodsTy").removeClass("hide");
        $("#addgoodsTyca").addClass("hide");
        $("#addgoodsTy").attr("href","javascript:addGoods('2','"+id+"');");
    }



	$('.addProto ').on('click','tr',function () {
	    var chk = $(this).find('.label-cbox');
		if(chk.hasClass('label-cbox-selected')){
            chk.removeClass('label-cbox-selected');
		}else{
            chk.addClass('label-cbox-selected');
		}
    })
	
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

	function cancelAdd(){
        $.closeDiv($(".addProto"),true);
	}

	function closeDiv(){
		$.closeDiv($(".protoDetailWrap"));
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		
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
        changeAllNum();
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
        changeAllNum();
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
			    window.top.layer.msg("支付成功！");
				window.parent.location.reload();
                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
			},
			error: function() {
                window.top.layer.msg("订单提交失败");
                window.parent.location.reload();
                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
			},
			complete: function () {
				$.closeDiv($(".protoDetailWrap"));
                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                formPo = false;
			}
		});
	}
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
        countAnythingPrice();
    });

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
        var youhui=youhui = (parseFloat(notVIPPrice10A) - parseFloat(sitePrice10A))*num10A;//优惠价格
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
        $("#allNum").text(num10A);//总数
		$("#orderZong10").text(goodsZong.toFixed(2));
		$(".yohuiPrice").text(youhui.toFixed(2));
		$("#zong").text(payZong.toFixed(2));

		$("input[name='zong10A']").val(payZong);
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
        $("#allNum").text(num16A);//总数
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
        var youhui10A = (parseFloat(notVIPPrice10A) - parseFloat(sitePrice10A))*num10A;//优惠价格
        var youhui16A = (parseFloat(notVIPPrice16A) - parseFloat(sitePrice16A))*num16A;//优惠价格
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
	if($.trim(province)=="安徽" || $.trim(province)=="江苏" || $.trim(province)=="浙江"|| $.trim(province)=="上海"){
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
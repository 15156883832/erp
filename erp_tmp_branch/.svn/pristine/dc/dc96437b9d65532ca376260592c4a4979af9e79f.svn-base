<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>我的商品-购买南岛升级版</title>
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<style>
.webuploader-pick {
	width: 120px;
	height: 30px;
	padding: 0;
}
</style>

</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="pd-20 ndlbPage ">
			<div class="">
				<form id="orderForm">
					<div class="mb-25">
						<table class="table buyDetailTable text-c">
							<thead>
								<tr>
									<th class="w-300">商品信息</th>
									<th class="w-120">商品单价</th>
									<th class="w-130">VIP会员价</th>
									<th class="w-130">建议零售价</th>
									<th class="w-190">购买数量</th>
									<th class="w-120">小计</th>
									<th class="w-200">操作</th>
								</tr>
							</thead>
							<tbody id="goodsListCollection">
								<tr class="radius">
									<td>
										<div class="wrap1 text-l ">
											<div class="imgWrap imgWrap">
												<img src="${commonStaticImgPath}${images}" class="img pos imageOne" />
												<div class="pl-25">
													<h3 class="lh-30 f-14 goodName1">${platform.columns.name}</h3>
													<p class="c-888 f-12 lh-20 line-clamp2" title="${platform.columns.description}" style="overflow: hidden; height: 40px; cursor: pointer;">${platform.columns.description}</p>
												</div>
											</div>
											<p class="pos-r pl-20 c-666 f-12 mt-5">
												<i class="sficon1 sficon-note2 pos"></i>
												<c:if test="${platform.columns.good_sign=='LB18102201' || platform.columns.good_sign=='BS20180107' }">
													10A适用家用普通插座，例如冰箱、洗衣机等
												</c:if>
												<c:if test="${platform.columns.good_sign=='LB18102202' }">
													16A适用大型家电，例如柜式空调、电热水器等
												</c:if>

											</p>
										</div>
									</td>
									<td>
										<div class="wrap1">
											￥
											<span class="NoVIPPrice">${platform.columns.no_vip_price}</span>
										</div>
									</td>
									<td>
										<div class="wrap1">
											<span class="c-0383dc">
												￥
												<span class="VIPPrice">${platform.columns.site_price}</span>
											</span>
										</div>
									</td>
									<td>
										<div class="wrap1">￥${platform.columns.advice_price}</div>
									</td>
									<td>
										<div class="wrap1 w-140" style="margin: 0 auto;">
											<div class="countWrap w-140 mb-5">
												<a class="btn-minus" onclick="subNum(this)"></a>
												<div class="priceWrap readonly">
													<input type="text" readonly name="quantity" class="input-text text-c readonly add_nums" value="15" />
													<span class="unit unitShow">个</span>
												</div>
												<a class="btn-plus" onclick="addNum(this)"></a>
											</div>
											<input type="hidden" name="unit10A" value="个" />
											<input class="showType" hidden="hidden" name="showType" value="0" />
											<input class="goodId" hidden="hidden" name="goodId" value="${platform.columns.id}" />
											<input class="realPrice" hidden="hidden" name="realPrice" value="0" />
											<p class=" text-l">
												<label class="mt-10 sficon1 sficon-rad1 sficon-rad1_selected cPointer" data-unit="个" data-num="15">按个</label>
												<label class="mt-10 sficon1 sficon-rad1 cPointer" data-unit="箱" data-num="1">按箱（144个/箱）</label>
											</p>
										</div>
									</td>
									<td>
										<div class="wrap1">
											<strong class="c-fd6e32 f-20">
												￥
												<span class="va-t orderZong"></span>
											</strong>
										</div>
									</td>
									<td>
										<div class="wrap1">
		                                    <a class="sfbtn sfbtn-opt shanchuone hide" onclick="deleteGood(this)">
		                                        <i class="sficon sficon-rubbish"></i>删除
		                                    </a>
		                                    <a class="sfbtn sfbtn-opt ml-15" onclick="addGoods('1','')">
		                                        <i class="sficon sficon-add"></i>添加商品
		                                    </a>
		                                </div>
										<%-- <div class="wrap1">
											<a class="btn_add  " onclick="addGoods('1','${platform.columns.id}')">添加商品</a>
										</div>
										<div class="wrap1 hide">
											<a class="btn_del" onclick="deleteGood(this)">删除商品</a>
										</div> --%>
									</td>
								</tr>
							</tbody>
						</table>

						<div class="cl mb-10 hide">
							<div class="f-l">
								<span id="diqu"></span>
								<span id="yunfeiiii"></span>
							</div>
							<input type="hidden" name="price10A" value="${platform.columns.site_price }" />
							<input type="hidden" name="price16A" value="${platform.columns.site_price }" />
							<input type="hidden" name="pid10A" value="${platform.columns.good_sign eq 'LB20180105' ? platform.columns.id:'' }" />
							<input type="hidden" name="pid16A" value="${platform.columns.good_sign eq 'LB20180106' ? platform.columns.id:'' }" />
							<input type="hidden" name="payType" value="alipay" />
							<input type="hidden" name="orderNumber" value="${number}" />
							<input type="hidden" id="img-input" name="icon" value="">
							<input type="hidden" id="logisticsPrice" name="logisticsPrice" value="">
							<%--运费--%>
							<input type="hidden" id="siteprovince" name="province" value="${site.province}">
							<input type="hidden" id="sitecity" name="city" value="${site.city}">
							<input type="hidden" id="sitearea" name="area" value="${site.area}">
							<input type="hidden" name="zong10A" value="">
							<input type="hidden" name="zong16A" value="">
						</div>
					</div>
					<div class="bg-e2eefc pt-10 pb-10 mb-15">
						<div class="cl mb-10">
							<label class="f-l w-100">
								<em class="mark">*</em>
								收件人：
							</label>
							<input name="customerName" class="input-text w-370 f-l bg-fff" nullmsg="请输入收件人" datatype="*" maxlength="20" />
							<label class="f-l w-130">
								<em class="mark">*</em>
								联系方式：
							</label>
							<input name="customerMobile" class="input-text w-370 f-l bg-fff" nullmsg="请检查联系方式" errormsg="联系方式格式不正确" datatype="m" maxlength="20" />
						</div>
						<div class="cl " id="pcd">
							<label class="f-l w-100">
								<em class="mark">*</em>
								详细地址：
							</label>
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
							运费：
							<span class="c-fd6e32">
								￥
								<span id="yunfei" class="va-t">10.00</span>
							</span>
							（满144个免运费）
						</div>
						<div class="f-r">
							<span class="mr-10">
								应付金额：
								<strong class="c-fd6e32 f-26">￥</strong>
								<strong class="c-fd6e32 f-26" id="zong" name="zong"></strong>
							</span>
						</div>
					</div>
					<div class="cl">
						<div class="f-r">
							<span class="mr-10 hide" id="openVIP">
								<a class="c-fd6e32 underline va-t sficon1 sficon-crown1 mr-5 f-14" onclick="jumpToVIP()">开通会员</a>
								<span class="f-13">
									立减
									<span class="yohuiPrice va-t"></span>
								</span>
							</span>
							<span class="mr-10" id="hadYouHui">
								已优惠：
								<span class="">
									￥
									<span class="yohuiPrice"></span>
								</span>
							</span>
							<a class="btn_buy ml-10 goumai" id="immPay">购买</a>
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
			<a href="javascript:guanbiCoperate();" class="sficon closePopup closeThis"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain">
				<h3 class="payTitle">思方收银台</h3>
				<div class="payOrder cl">
					<div class="f-l c-666">
						<p class="f-l mr-20">
							收货人：
							<span id="shouHR" class="va-t"></span>
						</p>
						<p class="f-l mr-20">
							电话：
							<span id="tel" class="va-t"></span>
						</p>
						<p class="f-l">
							地址：
							<span id="address" class="va-t"></span>
						</p>
					</div>
				</div>

				<!-- 支付二维码部分-->
				<div class="payment hide1 paymentPart">
					<div class="payWrap">
						<div class="payWrapTitle">
							支付
							<span class="c-fd7e2a pl-5 pr-5 moy"></span>
							元
						</div>
						<div class="cl pt-10">
							<div class="payCode"></div>
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
				<div class="pd-25 text-c payResultF hide">
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

	<%-- <div id="sty" class="popupBox spPayWrap wxPay">
		<h2 class="popupHead">
			<span id="payHead">微信支付</span>
		</h2>
		<div class="popupContainer">
			<div class="popupMain">
				<h3 class="payTitle">思方收银台</h3>
				<div class="payOrder cl">
					<div class="f-l c-666">
						<p class="f-l mr-20">
							收货人：
							<span id="shouHR" class="va-t"></span>
						</p>
						<p class="f-l mr-20">
							电话：
							<span id="tel" class="va-t"></span>
						</p>
						<p class="f-l">
							地址：
							<span id="address" class="va-t"></span>
						</p>
					</div>
				</div>

				<div class="payment hide1">
					<div class="payWrap">
						<div class="payWrapTitle">
							支付
							<span class="c-fd7e2a pl-5 pr-5 moy"></span>
							元
						</div>
						<p class=" pl-30 c-cc0000 pos-r f-14 mt-10">
							<span class="pos iconDec"></span>
							付款完成后，请务必上传支付凭证，并提交订单，以便工作人员处理订单，及时发货！
							<br />
							详情请咨询客服，QQ：387808217、2997231847。
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
								<a class="f-r c-fd6e32 f-13 btn_checkcase">
									<i class="sficon sficon-checkcase"></i>
									示例
								</a>
								<div class="f-r w-140">
									<div class="f-r paycaseWrap spimg1" id="spimg2">
										<img id="img-view" src="${ctxPlugin }/static/h-ui.admin/images/img-default2.png" />
									</div>
									<a class="c-0383dc w-140 lh-30 f-l text-c f-13" id="img-picker">上传支付凭证</a>
								</div>
								<div class="f-r icon_paystep">2</div>
							</div>
						</div>
					</div>
				</div>

				<div class="pd-25 text-c payResultS hide">
					<i class="prnote mr-10"></i>
					<span class="text-l pt-10">
						<strong class="f-18">您已成功付款</strong>
					</span>
				</div>

				<div class="pd-25 text-c payResultF hide">
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
	</div>--%>


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
							<td>
								<span class="label-cbox "></span>
							</td>
							<td>漏电保护插头 10A</td>
							<td>
								<img src="" style="width: 90px; height: 80px" />
							</td>
							<td>南岛</td>
							<td>NB-ZL3M-10</td>
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
	var isVIP=${isVIP};
	var yunfeiMark = 1;
	var successMark = "1";
    var goodIds='${platform.columns.id}';
    var payType = "alipay";
    var goodsName='${platform.columns.name}';
    var goodsSign='${platform.columns.good_sign}';
    var numb='${number}';
    
    var uploaderCreated =false;
    $(function(){
    	$('#payWayBox').on('click','.payWay' ,function(){
            $('#payWayBox .payWay').removeClass('payWayCur');
            $(this).addClass('payWayCur');
        });
    	if(isVIP){
            $("#openVIP").addClass("hide");
            $("#hadYouHui").removeClass("hide");
            $(".orderZong").text((parseFloat(15)*parseFloat($(".NoVIPPrice").text())).toFixed(2));
            $(".realPrice").val((parseFloat(15)*parseFloat($(".VIPPrice").text())).toFixed(2));
        }else{
            $("#openVIP").removeClass("hide");
            $("#hadYouHui").addClass("hide");
            $(".orderZong").text((parseFloat(15)*parseFloat($(".NoVIPPrice").text())).toFixed(2));
            $(".realPrice").val((parseFloat(15)*parseFloat($(".NoVIPPrice").text())).toFixed(2));
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
        countSumMoney();
        everyOrderClick();
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

    $('.addProto ').on('click','tr',function () {
        var chk = $(this).find('.label-cbox');
        if(chk.hasClass('label-cbox-selected')){
            chk.removeClass('label-cbox-selected');
        }else{
            chk.addClass('label-cbox-selected');
        }
    })

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
        $.post("${ctx}/goods/nanDao/checkPriceNews",$("#orderForm").serialize(),function(result){
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
    function addGoods(de,id){
    	var ids = "";
    	$(".goodId").each(function(){
    		if(isBlank(ids)){
    			ids = $(this).val();
    		}else{
    			ids +=","+ $(this).val();
    		}
    	});
        $.post("${ctx}/goods/nanDao/getAllSouthIslandsNew",{de:de,id:ids},function(result){
            if(result!=null){
                var html='';
                for(var i=0;i<result.length;i++){
                    html+='<tr><td><span class="label-cbox "><input type="hidden" name="goodsId" value="'+result[i].columns.id+'" /></span></td>';
                    html+='<td>'+result[i].columns.name+'</td>';
                    html+='<td><img src="${commonStaticImgPath}'+result[i].columns.picture+'" style="width: 90px;height: 80px"/></td>';
                    html+='<td>'+result[i].columns.brand+'</td>';
                    html+='<td>'+result[i].columns.model+'</td>';
                    html+='<td>'+result[i].columns.category+'</td></tr>';
                }
                $("#goodslist").empty().append(html);
                
                $(".addProto").popup({level:2},true);
            }
        });
    }

    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }

    

    /*********************************************************************************************************************/
    
    
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
    
    function everyOrderClick(){
    	$('.sficon-rad1').on('off');
    	$('.sficon-rad1').on('click', function () {
            var oP = $(this).closest('.radius');
            oP.find('.sficon-rad1').removeClass('sficon-rad1_selected');
            $(this).addClass('sficon-rad1_selected');
            oP.find('.priceWrap .input-text').val($(this).attr('data-num'));
            oP.find('.priceWrap .unit').text($(this).attr('data-unit'));
            var obj = $(this).parent("p").parent("div");
			if($(this).attr("data-unit")=='个'){
				obj.find(".showType").val("0");
			};
			if($(this).attr("data-unit")=='箱'){
				obj.find(".showType").val("1");
			};
			countOrderMoney();
        });
    };
    
    function countOrderMoney(){
    	$("#goodsListCollection tr").each(function(){
    		var type = $(this).find("input[name=showType]").val();//0个 1箱
    		var num = $(this).find("input[name=quantity]").val();//数量
    		var price = $(this).find(".VIPPrice").text();//最终的成交单价
    		var noVipPrice = $(this).find(".NoVIPPrice").text();
    		if(!isVIP){
    			price = noVipPrice;
    		}
    		if(type=='1'){
    			num = parseInt(num) * parseInt(144);
    		}
    		var money = (parseFloat(num) * parseFloat(price)).toFixed(2);//最终这一条订单的总价
    		var moneyNoVip = (parseFloat(num) * parseFloat(noVipPrice)).toFixed(2);//非VIP总价
    		$(this).find(".orderZong").text(moneyNoVip);
    		$(this).find(".realPrice").val(money);
    	});
    	countLogisPrice();//计算邮费
    	countSumMoney();//计算应付总金额和已优惠金额
    };
    
  	//计算邮费
    function countLogisPrice(){
    	var numCounts = 0;
    	var province = $("#province").val();
    	$("#goodsListCollection tr").each(function(){
    		var type = $(this).find("input[name=showType]").val();//0个 1箱
    		var num = $(this).find("input[name=quantity]").val();//数量
    		if(type=='1'){
    			num = parseInt(num) * parseInt(144);
    		}
    		numCounts = parseInt(num) + parseInt(numCounts);
    	});
    	getLogisticsPrice(numCounts,province);
    }
    
  //计算应付总金额和已优惠金额
    function countSumMoney(){
	    var countPriceOne = 0;
	    var countPriceTwo = 0;
	    var numCount = 0;
   	    $("#goodsListCollection tr").each(function(){
   		    var orderPriceOne = $(this).find(".orderZong").text();
   		    var orderPriceTwo = $(this).find(".realPrice").val();
   		    var type = $(this).find("input[name=showType]").val();//0个 1箱
 			var num = $(this).find("input[name=quantity]").val();//数量
 			if(type=='1'){
 				num = parseInt(num) * parseInt(144);
 			}
 			numCount = parseInt(numCount) + parseInt(num);
   		 	countPriceOne = parseFloat(orderPriceOne) + parseFloat(countPriceOne);
   		 	countPriceTwo = parseFloat(orderPriceTwo) + parseFloat(countPriceTwo);
   	    });
   	    $(".yohuiPrice").text((parseFloat(countPriceOne) - parseFloat(countPriceTwo)).toFixed(2));
   	    var allPrice = (parseFloat(countPriceTwo)+parseFloat($("#yunfei").text())).toFixed(2);
   	    if(parseInt(numCount) >= parseInt(144)){
   	    	allPrice = countPriceTwo.toFixed(2);
   	    }
		$("#zong").text(allPrice);
    }
  
    function addNum(obj) {
    	var type = $(obj).parent("div").parent("div").find(".showType").val();
        var num = parseInt($(obj).parents("tr").find("input[name=quantity]").val());
        if(type=='0'){
        	num += 10;
        }else{
        	num+=1;
        }
        $(obj).parents("tr").find("input[name=quantity]").val(num);
        countOrderMoney(); 
    }
    
    function subNum(obj) {
    	var type = $(obj).parent("div").parent("div").find(".showType").val();
        var num = parseInt($(obj).parents("tr").find("input[name=quantity]").val());
        if(type=='1'){
            if(num>1){
                num-=1;
            }
        }else{
            if (num > 15) {
                num -= 10;
            }
        }
        $(obj).parents("tr").find("input[name=quantity]").val(num);
        countOrderMoney();
    }
    $("#province").change(function(){
    	var province = $("#province").val();
    	if($.trim(province) == "香港" || $.trim(province) == "澳门" || $.trim(province) == "台湾"){
    		layer.msg("暂不支持"+province+"的物流订单！");
    		return;
    	}
    	countOrderMoney();
    });
    /*取消添加商品*/
    function cancelAdd(){
        $.closeDiv($(".addProto"),true);
    }
    
    /*点击添加商品*/
    function addGoodsNow(){
    	var ids = "";
    	$(".label-cbox-selected").each(function(){
    		var goodId = $(this).find("input[name=goodsId]").val();
    		if(isBlank(ids)){
    			ids = goodId;
    		}else{
    			ids +="," + goodId;
    		}
    	});
       if(isBlank(ids)){
    	   layer.msg("请选择您要添加的商品！");
    	   return;
       }
       $.ajax({
    	   type:"post",
    	   url:"${ctx}/goods/sitePlatformGoods/getPlatGoodsMsgByIds",
    	   data:{ids:ids},
    	   success:function(data){
    		   var html = "";
    		   var trLength = $("#goodsListCollection").find("tr").length;
    		   if(data.length > 0){
    			   for(var i=0;i<data.length;i++){
    				   var dt = data[i].columns;
    				   var images = (dt.icon!=null ? dt.icon : "").split(",")[0];
    				   var goodSign = dt.good_sign;
    				   var signHtml = "16A适用大型家电，例如柜式空调、电热水器等";
    				   if(goodSign=='LB18102201' || goodSign=='BS20180107'){
    					   signHtml = '10A适用家用普通插座，例如冰箱、洗衣机等';
    				   };
					   addOrDelHtml ='<div class="wrap1">'+
                               '<a class="sfbtn sfbtn-opt shanchuone" onclick="deleteGood(this)">'+
			                   '        <i class="sficon sficon-rubbish"></i>删除'+
			                   '   </a>'+
			                   '    <a class="sfbtn sfbtn-opt ml-15" onclick="addGoods(1,)">'+
			                   '        <i class="sficon sficon-add"></i>添加商品'+
			                   '    </a>'+
			                   '</div>';
    				   html +=
	    					'<tr class="radius">'+
							'<td>'+
							'	<div class="wrap1 text-l ">'+
							'		<div class="imgWrap imgWrap">'+
							'			<img src="${commonStaticImgPath}'+images+'" class="img pos imageOne" />'+
							'			<div class="pl-25">'+
							'				<h3 class="lh-30 f-14 goodName1">'+dt.name+'</h3>'+
							'				<p class="c-888 f-12 lh-20 line-clamp2" title="'+dt.description+'" style="overflow: hidden; height: 40px; cursor: pointer;">'+dt.description+'</p>'+
							'			</div>'+
							'		</div>'+
							'		<p class="pos-r pl-20 c-666 f-12 mt-5">'+
							'			<i class="sficon1 sficon-note2 pos"></i>'+
							signHtml+
							'		</p>'+
							' 	</div>'+
							'</td>'+
							'<td>'+
							'	<div class="wrap1">'+
							'		￥'+
							'		<span class="NoVIPPrice">'+dt.no_vip_price+'</span>'+
							'	</div>'+
							'</td>'+
							'<td>'+
							'	<div class="wrap1">'+
							'		<span class="c-0383dc">'+
							'			￥'+
							'			<span class="VIPPrice">'+dt.site_price+'</span>'+
							'		</span>'+
							'	</div>'+
							'</td>'+
							'<td>'+
							'	<div class="wrap1">￥'+dt.advice_price+'</div>'+
							'</td>'+
							'<td>'+
							'	<div class="wrap1 w-140" style="margin: 0 auto;">'+
							'		<div class="countWrap w-140 mb-5">'+
							'			<a class="btn-minus" onclick="subNum(this)"></a>'+
							'			<div class="priceWrap readonly">'+
							'				<input type="text" readonly name="quantity" class="input-text text-c readonly add_nums" value="15" />'+
							'				<span class="unit unitShow">个</span>'+
							'			</div>'+
							'			<a class="btn-plus" onclick="addNum(this)" ></a>'+
							'		</div>'+
							'		<input type="hidden" name="unit10A" value="个" />'+
							'		<input class="showType" hidden="hidden" name="showType" value="0" />'+
							'		<input class="goodId" hidden="hidden" name="goodId" value="'+dt.id+'" />'+
							'		<input class="realPrice" hidden="hidden" name="realPrice" />'+
							'		<p class=" text-l">'+
							'			<label class="mt-10 sficon1 sficon-rad1 sficon-rad1_selected cPointer" data-unit="个" data-num="15">按个</label>'+
							'			<label class="mt-10 sficon1 sficon-rad1 cPointer" data-unit="箱" data-num="1">按箱（144个/箱）</label>'+
							'		</p>'+
							'	</div>'+
							'</td>'+
							'<td>'+
							'	<div class="wrap1">'+
							'		<strong class="c-fd6e32 f-20">'+
							'			￥'+
							'			<span class="va-t orderZong"></span>'+
							'		</strong>'+
							'	</div>'+
							'</td>'+
							'<td>'+
							addOrDelHtml+
							'</td>'+
						'</tr>';
    			   }
    		   }
    		   $("#goodsListCollection").append(html);
    		   var lgh = $("#goodsListCollection").find("tr").length;;
	           if(lgh>1){
	           		$("#goodsListCollection").find("tr").each(function(){
	           			$(this).find(".shanchuone").show();
	           		});
	           };
    		   everyOrderClick();
    		   countOrderMoney();
    		   $.closeDiv($(".addProto"),true);
    	       
    	   }
       });
    }
    
    function deleteGood(obj){
    	$(obj).parents("tr").remove();
    	var lgh = $("#goodsListCollection").find("tr").length;;
    	if(lgh==1){
    		$("#goodsListCollection").find("tr").find(".shanchuone").hide();
    	}
    	countOrderMoney();
    }
    
    function collectionOrderData(){
    	var ids = "";
    	var showTypes = "";//0个 1箱
    	var numbers = "";
    	var orderAmounts = "";
    	var orderAmountsShow = "";
    	var numsAll = 0;
    	var isVip = isVIP ? "1" : "2";//vip：1    非vip：2
    	$("#goodsListCollection").find("tr").each(function(){//
    		var nowTy = $(this).find(".showType").val();//0个 1箱
    		var nowNum = $(this).find("input[name=quantity]").val();
    		if(nowTy=='1'){
    			nowNum = parseInt(nowNum) * parseInt(144);
    		}
    		numsAll = parseInt(numsAll)+parseInt(nowNum);
    		if(isBlank(ids)){
    			ids = $(this).find("input[name=goodId]").val();
    			showTypes = nowTy;
    			numbers = nowNum;
    			orderAmounts = $(this).find("input[name=realPrice]").val();
    			orderAmountsShow = $(this).find(".orderZong").text();
    		}else{
    			ids +=","+ $(this).find("input[name=goodId]").val();
    			showTypes +=","+  nowTy;
    			numbers +=","+ nowNum;
    			orderAmounts +=","+  $(this).find("input[name=realPrice]").val();//订单实际金额
    			orderAmountsShow +=","+  $(this).find(".orderZong").text();//订单非VIP金额
    		}
    	});
    	var customerName = $("input[name=customerName]").val();
    	var customerMobile = $("input[name=customerMobile]").val();
    	var customerAddress = $("input[name=customerAddress]").val();
    	var province = $("#province").val();
    	var city = $("#city").val();
    	var area = $("#area").val();
    	var payType = "1";
    	if($(".payWayCur").hasClass("pay-by-wx")){
    		payType = "0";
    	};
    	var logisPrice = $("#yunfei").text();//运费
    	var logisMark = "1";//有运费标识
    	if(parseInt(numsAll) >= parseInt(144)){
    		logisMark = "0";//无运费标识
    	};
    	var allAmount = $("#zong").text();//应付总金额
    	var youhuiAmount = $(".yohuiPrice").text();//优惠总金额
    	var data = {
    			ids:ids,
    			showTypes:showTypes,
    			numbers:numbers,
    			orderAmounts:orderAmounts,
    			orderAmountsShow:orderAmountsShow,
    			numsAll:numsAll,
    			isVip:isVip,
    			customerName:customerName,
    			customerMobile:customerMobile,
    			customerAddress:customerAddress,
    			province:province,
    			city:city,
    			area:area,
    			payType:payType,
    			logisPrice:logisPrice,
    			logisMark:logisMark,
    			allAmount:allAmount,
    			youhuiAmount:youhuiAmount
    	};
    	return data;
    };
    
    
    
    var formPosted = false;
    function checkout() {
        if(formPosted) {
            return false;
        }
        formPosted = true;
        var datas = collectionOrderData();

        var index = layer.load(0, {shade: false});
        $(".protoDetailWrap").hide();
        $.ajax({
            url: "${ctx}/goods/sitePlatformGoods/createNanDaoUpgradeOrderLatest",
            type: "POST",
            data: datas,
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
                        	successMark = "2";
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
                }else if(data.code=='410'){
                	layer.msg("提交的信息有误！");
                }
                return;
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
    
    function cancelPay() {
    	$.closeDiv($('.spPayWrap'));
    	$('#Hui-article-box',window.top.document).css({'z-index':'9'});
    	if(monitor) {
    		monitor.stop();
    	}
    }
    
    /* function cancelPay(){
        $.closeDiv($("#sty"),true);
    } */
    
    function cancelPayTwo(){
        removeIframe();
    }
    
    function guanbiCoperate(){
    	if(successMark=='2'){
    		removeIframe();
    	}
    }
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="decorator" content="base"/>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<!--[if lt IE 9]>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />

	<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<!--[if IE 6]>
	<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->
	<title>商品详情</title>
</head>
<body class="">
<div class="sfpagebg bk-gray">
	<div class="pt-25 pb-25 pl-20 pr-20 goodsPage">
		<div class="goodsDetail">
			<div class="cl mb-20">
				<div class="f-l w-480">
					<div class="f-l mr-15 commodityImgWrap" id="commodityImgWrap">
						<%--<c:forEach var="imgs" items="${img }" begin="0" end="0">
							<img src="${prototypeStaticImgPath}${imgs}" style="height: 360px;width: 360px;"/>
						</c:forEach>--%>
						<%--<img src="static/h-ui.admin/images/sp_img1.png" id="commodityImg" />--%>
					</div>
					<div class="commodityImgListWrap f-l" id="commodityImgListWrap">
						<a class="btn_com btn_comPrev" id="btn_comPrev"> </a>
						<a class="btn_com btn_comNext" id="btn_comNext"></a>
						<div class="commodityImgList">
							<ul id="adlist">
								<c:forEach var="imgs" items="${img }">
									<li class=""><img src="${prototypeStaticImgPath}${imgs}" /></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
				<div class="f-l">
					<h3 class="goodsName">
						<c:if test="${rds.columns.appearance_grade eq 'S级'}">
							<span class="goodslevel goodslevel_3 va-t" title="无瑕疵">s级</span>
						</c:if>
						<c:if test="${rds.columns.appearance_grade eq 'A级'}">
							<span class="goodslevel goodslevel_3 va-t" title="机器两侧瑕疵累计三处以内,且正面面板瑕疵不超过一处。">A级</span>
						</c:if>
						<c:if test="${rds.columns.appearance_grade eq 'B级'}">
							<span class="goodslevel goodslevel_3 va-t" title="机器两侧瑕疵累计五处以内，且正面面板瑕疵不超过三处。">B级</span>
						</c:if>
						<c:if test="${rds.columns.appearance_grade eq 'C级'}">
							<span class="goodslevel goodslevel_3 va-t" title="机器两侧瑕疵累计五处以上，正面面板瑕疵三处以上。">C级</span>
						</c:if>
						${rds.columns.brand}  ${rds.columns.name}${rds.columns.model}  ${rds.columns.category}
					</h3>
					<div class="goodsPrice mb-15 cl f-13">
						<div class="f-l col-3-1">
							<span class="">特惠价：</span><strong class="c-fd6e32 f-24">￥${rds.columns.sale_price }</strong>
						</div>
						<div class="f-l col-3-1">
							<span class="">挂牌价：</span><del class="c-black f-16 mr-5">￥${rds.columns.hangtag_price }</del>
							<span class="radius bg-ff6600 c-white lh-22 pl-5 pr-5 f-12">立省${rds.columns.hangtag_price -rds.columns.sale_price }元</span>
						</div>

					</div>
					<p class="lh-20 f-14 mb-15 w-710 c-888">
						${rds.columns.down_cabinet_remarks }
					</p>
					<a class="btn_buyGoods radius w-180 f-18">立即购买</a>
				</div>
			</div>

			<div class="producttitle mb-25">
					<span class="producttitle_1">
						<span class="f-16">商品介绍 </span>
						<span class="f-16 c-888">/</span>
						<span class="c-888">Product Introduction</span>
					</span>
			</div>
			<div class="" style="width: 1000px; margin: 0 auto 25px;" >
				<table class="table table-border table-bordered productParameters">
					<tr>
						<th>家电品牌</th>
						<td id="brand">${rds.columns.brand }</td>
						<th>家电品类</th>
						<td id="category" >${rds.columns.category }</td>
					</tr>
					<tr>
						<th>商品规格</th>
						<td id="">${rds.columns.specification }</td>
						<th>门板类型</th>
						<td id="" >${rds.columns.door_panel }</td>
					</tr>
					<tr>
						<th>家电型号</th>
						<td id="model">${rds.columns.model }</td>
						<th>上样时间</th>
						<td id="loadSampleTime">${rds.columns.load_sample_time }</td>
					</tr>
					<tr>
						<th>上样卖场</th>
						<td id="mallName">${rds.columns.mall_name }</td>
						<th>详细地址</th>
						<td id="address" >${rds.columns.address }</td>
					</tr>
				</table>
			</div>
			<div class="text-c goodsImgsMain">
				<c:forEach var="imgs" items="${img }">
					<img src="${prototypeStaticImgPath}${imgs}" /><br>
				</c:forEach>
			</div>

		</div>
	</div>
</div>

<div class="popupBox protoDetailWrap prototypeDetailWrap">
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
						<p class="f-l lh-24"><strong class="f-16" id="poName">${rds.columns.name }  </strong></p>
					</div>
					<div class="f-l">
						<label class="f-l w-90 text-r">商品总额：</label>
						<span class="f-l f-16 c-fd6e32" id="orderZong">${rds.columns.sale_price }</span>
					</div>
				</div>

				<div class="bg-e2eefc pt-10 pb-15 mb-15">
					<div class="cl mb-10">
						<input type="hidden" name="id" id="idRecord" value="${rds.columns.id }"/>
						<input type="hidden" name="payType" value="alipay"/>
						<input type="hidden" name="outTradeNo" value="${rds.columns.number }"/>
						<input type="hidden" id="img-input"  name="icon" value="">
						<input type="hidden" name="totalFee" value="${rds.columns.sale_price }">
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

					<div class="f-r">
						<span class="lh-30">
							应付金额：<strong class="c-fd6e32 f-20 va-t"  id="zong" name="zong">${rds.columns.sale_price }</strong>
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
				奥莱收银台
			</h3>
			<div class="payOrder cl">
				<div class="f-l c-666 w-340">
					<p id="poNumber">订单编号：${rds.columns.number }</p>
					<p>应付金额：<span class="f-20 money" id="money">￥${rds.columns.sale_price }</span></p>
				</div>
				<div class="f-r f-13">
					<p>订单类型：奥莱家电产品</p>
				</div>
			</div>

			<!-- 支付二维码部分-->
			<div class="payment hide1">
				<div class="payWrap">
					<div class="payWrapTitle">
						支付<span class="c-fd7e2a pl-5 pr-5 moy">${rds.columns.sale_price }</span>元
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
								<div class="f-r paycaseWrap spimg1" id="spimg2" style="line-height: 30px;">
									<a href="javascript:;" class="btn-uploadimg oneImg" ></a>
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
			<a href="javascript:closBoxId('sty');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
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
			<a href="javascript:closBoxId('ty');" class="sfbtn sfbtn-opt3 w-70">关闭</a>
		</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/carousel.js"></script>
<script type="text/javascript">
    var payType = "alipay";
    var monitor;
    var formPosted = false;
    $('.btn_buyGoods').on('click', function(){
        $('.prototypeDetailWrap').popup();
    })
    $(function(){
        $('#commodityImgListWrap').carousel();

        $("a.paywapWrap").bind('click', function () {
            $("a.paywapWrap").removeClass("payCurrent");
            $(this).addClass("payCurrent");
        });

        //店家查看支付凭证实例
        $(".btn_checkcase").click(function(){
            if($.trim(payType)=="alipay"){
                $("#ty").removeClass("wxPay");
                $("#ty").addClass("zfbPay");
                $("#lie").text("支付宝-支付凭证示例");
                $("#lieImg").attr("src","${ctxPlugin}/static/h-ui.admin/images/paySeq_zfb.png")
            }
            $("#ty").popup({closeSelfOnly:true});
        })

        //选择支付方式
        $(".pay-by-zfb").bind('click', function () {
            payType = "alipay";
            $("input[name='payType']").val("alipay");
        });
        $(".pay-by-wx").bind('click', function () {
            payType = "wx";
            $("input[name='payType']").val("wx");
        });


        $('#orderForm').Validform({
            btnSubmit:"#immPay",
            tiptype: function(msg, o, cssctl) {
                if (msg != "") {
                    layer.msg(msg);
                }
            },
            callback: function (form) {

                if($.trim(payType)=="alipay"){
                    $("#sty").removeClass("wxPay");
                    $("#sty").addClass("zfbPay");
                    $("#payHead").text("支付宝支付");
                    $("#payTy").attr("src","${ctxPlugin }/static/h-ui.admin/images/prototype_zfb.png")
                }else{
                    $("#sty").addClass("wxPay");
                    $("#sty").removeClass("zfbPay");
                    $("#payHead").text("微信支付");
                    $("#payTy").attr("src","${ctxPlugin }/static/h-ui.admin/images/prototype_wx.png")
                }

                //	createUploader("#filePicker-add","#Imgprocess2","file_fake_addimg","file_fake_add","delimgs");
                var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档
                var thumbnailHeight = 130;
                uploader = WebUploader.create({
                    // 选完文件后，是否自动上传。
                    auto: true,
                    swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
                    //server: '${ctx}/common/uploadFile',
                    server: '${prototypeUploadPath}/a/common/uploadFile',
                    duplicate:true,
                    fileSingleSizeLimit:1024*1024*5,
                    pick: '#img-picker',
                    accept: {
                        title: 'Images',
                        extensions: 'gif,jpg,jpeg,bmp,png',
                        mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
                    },
                    method:'POST'
                });
                uploader.on("error",function (type){
                    if (type=="Q_TYPE_DENIED"){
                        layer.msg("请上传JPG、PNG格式文件");
                    }else if(type=="F_EXCEED_SIZE"){
                        layer.msg("文件大小不能超过5M");
                    }
                });
                uploader.on('beforeFileQueued', function(file){
                    uploader.reset();
                });
                uploader.on( 'uploadSuccess', function( file, response ) {
                    $("#img-view").attr("src",'${prototypeStaticImgPath}'+response.path);
                    $("#img-input").val(response.path);
                    //$(".oneImg").remove();

                });


                $("#sty").popup({closeSelfOnly:true});
                closBox("prototypeDetailWrap");

                return false;
            }
        });
    })
    $('#btn_goTop').on('click', function(){
        $(".sfpagebg").animate({ scrollTop: 0 }, 520);
    })

    $('.prototypeWrap').hover(function(){
        $(this).addClass('protoWrapCur');
    }, function(){
        $(this).removeClass('protoWrapCur');
    });

    //确认支付
    var formPo =false;
    function surePay(){
        if(formPo){
            return;
        }

        var icon=$("input[name='icon']").val();
        if(isBlank(icon)){
            layer.msg("请上传支付凭证！")
        }else{
            formPo=true;
            $.ajax({
                url: "${ctx}/goods/sitePlatformGoods/prototypeOrder",
                type: "POST",
                data: $("#orderForm").serialize(),
                success: function(data) {
                    if(!isBlank(data.id)){
                        layer.msg("支付成功！");
                        $.closeAllDiv();
                        window.location.href='${ctx}/goods/siteself/getPrototypeList';
                        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                    }
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

    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }


    function closBoxId(name){
        $.closeDiv($("#"+name));
    }


    function closBox(name){
        $.closeDiv($("."+name));
    }

</script>
</body>
</html>
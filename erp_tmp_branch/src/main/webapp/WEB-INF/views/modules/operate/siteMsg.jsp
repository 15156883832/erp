<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style type="text/css">
/* .webuploader-pick{
	color: #0383dc;
	background: none;
} */
.imgbox3 img{ width:118px; height:118px;} 
.webuploader-pick{
	background:none;
	color:#22a0e6;	
	padding:0;
	
}
/* .spimg1{ border:none;} */
.webuploader-pick{
	width:118px;
	height:118px;
	overflow:visible;
}
.img_yyzz .webuploader-pick{
	height:24px;
	width:134px;
	line-height:24px;
}
.webuploader-pick img{
	width:100%;
	height:100%;
	position:absolute;
	left:0;
	top:0;
}
</style>

<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>运营管理-公司资料</title>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<h2 class="f-20 pt-15 pb-15 lh-20">${site.columns.name }</h2>
			<div class="cl">
				<div class="f-l w-480 infoWrap" id="infoWrap">
					<c:if test="${not empty parentSiteName}">
						<div class="cl mb-10">
							<label class="f-l w-70 text-r">一级网点：</label>
							<p class="f-l w-300 lh-26">${parentSiteName}</p>
						</div>
					</c:if>
					<div class="cl mb-10">
						<label class="f-l w-70 text-r">法人代表：</label>
						<p class="f-l w-300 lh-26">${site.columns.corporator }</p>
					</div>
					<div class="cl mb-10">
						<label class="f-l w-70 text-r">联系人：</label>
						<input type="text" class="input-text f-l w-300" onkeyup="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5]/g,'')" disabled="disabled" value="${site.columns.contacts }" id="contacts"/>
					</div>
					<div class="cl mb-10">
						<label class="f-l w-70 text-r">联系电话：</label>
						<input type="text" class="input-text f-l w-300" disabled="disabled" value="${site.columns.telephone }" id="telephone"/>
					</div>
					<div class="cl mb-10" >
						<label class="f-l w-70 text-r">企业地址：</label>
						<p class="f-l w-300 pt-5 adress" id="adress"> ${adress }</p>
						<%-- <input type="text" class="input-text f-l w-300 adress" disabled="disabled"  value="${adress }"   /> --%>
						<span class="select-box w-90 f-l mb-10" id="showProvince" style="display:none">
							<select class="select" id="province" disabled="disabled">
							<%-- <option value="${site.columns.province }" selected="selected">${site.columns.province }</option> --%>
								<c:forEach items="${provincelist }" var="pro">
									<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==site.columns.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
								</c:forEach>
							</select>
						</span>
						<span class="select-box w-90 f-l ml-15 mb-10" id="showCity"  style="display:none">
							<select class="select" id="city"  disabled="disabled">
								<c:forEach items="${cities }" var="cs">
									<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==site.columns.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
								</c:forEach>
							</select>
						</span>
						<span class="select-box w-90 f-l ml-15 mb-10" id="showArea" style="display:none">
							<select class="select"  id="area" value=""  disabled="disabled">
							<c:forEach items="${districts }" var="ds">
									<option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==site.columns.city }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
							</c:forEach>
							</select>
						</span><br>
						<input id="spanadress" type="text"  style="display: none; margin-left:70px" class="input-text f-l w-300 " value="${site.columns.address }"/>
					</div>
				</div>
				<div class="f-l ml-40">
					<div class="">
						<label class="f-l w-80 text-r ">营业执照：</label>
						<div class="imgbox2 f-l pos-r spimg1"  id="ImgprocessPJ1">
							<img alt="" src="${commonStaticImgPath}${site.columns.license_img }" id="imgpic">
						</div>
						<input type="hidden" name="licenseImg" value="${site.columns.license_img }" id="img-input">
					</div>
					<div style="margin-left: 80px; margin-top: 40%;visibility: hidden; "  class="up img_yyzz" >
						<a href="javascript:;" class="upload" >重新上传图片</a>	
					</div>
				</div>
				<div class="f-r text-c" style="padding-top: 108px;">
					<sfTags:pagePermission authFlag="OPERATEMGM_SITEMSG_SITEMSG_EDITE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70" id="btn-edit">修改</a>'></sfTags:pagePermission>
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 btn2 hide " id="btn-save">保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 btn2 hide quxiao"  id="btn-cancel" onclick="cancel()">取消</a>
				</div>
		
			</div>
			
			
						<div class="mt-25 line-solid"></div>
			<strong class="f-14 sysInfo-lb">收款二维码</strong>
			<div class="cl">
				<div class="f-l w-200">
					<label class="w-70 text-r f-l">支付宝：</label>
					<div class="imgbox3 f-l pos-r zfb" id="erweima">
						
						<c:if test="${empty site.columns.ali_code }">
							<div class=""  id="ImgprocessPJ2" >
								<img  id="imgpic1"  > 
								<a href="javascript:;" class="btn-uploadimg erweima " style="color:#22a0e6" >点击上传</a>
							</div>
						</c:if>
						<c:if test="${not empty site.columns.ali_code }">
							<div class=""  id="ImgprocessPJ2" >
								<img alt="" src="${commonStaticImgPath}${site.columns.ali_code }" id="imgpic1"  > 
							</div>
							<a href="javascript:;" class="sficon btn-delimg delzfb" style="color:#22a0e6"  onclick="delzfb()"></a>
						</c:if>
						<input type="hidden" name="licenseImg1" value="${site.columns.ali_code }" id="img-input1">
					</div>
					
				</div>
				<div class="f-l ml-10 w-230">
					<label class="w-110 text-r f-l">微信：</label>
					<div class="imgbox3 f-l pos-r wx" id="weixin">
						
						<c:if test="${empty site.columns.wx_code }">
							<div class="spimg1"  id="ImgprocessPJ3">
								<img   id="imgpic2"  >
								<a href="javascript:;" class="btn-uploadimg weixin " style="color:#22a0e6" >点击上传</a>
							</div>
						</c:if>
						<c:if test="${not empty site.columns.wx_code }">
							<div class=""  id="ImgprocessPJ3">
								<img alt="" src="${commonStaticImgPath}${site.columns.wx_code }" id="imgpic2"  > 
							</div>
							<a href="javascript:;" class="sficon btn-delimg  delwx" onclick="delwx()"></a>
						</c:if>
						<input type="hidden" name="licenseImg2" value="${site.columns.wx_code }" id="img-input2">
					</div>
					
				</div>
			</div>
			
			
	
			<div class="mt-25 line-solid"></div>
			<strong class="f-14 sysInfo-lb">系统信息</strong>
			<div class="">
				<div class="cl">
					<label class="w-70 text-r f-l">当前版本：</label>
					<c:if test="${dict eq 1 }">
						<p class="f-l lh-26"><span class="f-l mr-5">思方ERP</span> <span class="c-bb3906 f-14 f-l ">VIP版</span></p>
					</c:if>
					<c:if test="${dict eq 0 }">
						<p class="f-l lh-26">ERP2.0</p>
					</c:if>
				</div>
				<div class="cl">
					<label class="w-70 text-r f-l">有效期：</label>
					<p class="f-l lh-26">${createTime } 至 ${dueTime }</p>
				</div>
				<div class="cl">
					<label class="w-70 text-r f-l">会员等级：</label>
					<p class="f-l lh-26"><i class="sficon sficon-role${level.count} mr-5"></i>${level.name}</p>
				</div>
				<div class="cl">
					<c:if test="${hasShareCode}">
						<label class="w-70 text-r f-l">激活码：</label>
						<p class="f-l lh-26"><span style="color:blue;">${share_code}</span></p>
					</c:if>
				</div>
					<c:if test="${dict eq 1 }">
						<div class="f-r mt-40 pt-10" id="xfOrKt">
							<c:if test="${empty site.columns.due_time }">
								<a href="javascript:;" class="sfbtn sfbtn-opt3 w-100 f-13" onclick="jumpToVIP('1')">购买VIP会员</a>
							</c:if>
							<c:if test="${not empty site.columns.due_time }">
								<a href="javascript:;" class="sfbtn sfbtn-opt3 w-100 f-13" onclick="jumpToVIP('2')">续费VIP会员</a>
							</c:if>
							<a href="javascript:;" class="sfbtn sfbtn-opt w-100 f-13" onclick="openHistoryRrecord()">历史订单查询</a>
						</div>
					</c:if>
				
				
		
			</div> 
		</div>
	</div></div>
	
	


<!-- 历史订单 -->
<div class="popupBox vipHistoryOrder">
	<h2 class="popupHead">
		历史订单查询
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain">
			<div class="pcontent">
				<div class="text-c w-660">
					<div class="f-l">
					<a href="javascript:;" onclick="applications()" class="sfbtn sfbtn-opt "><i class="sficon sficon-fpsq"></i>发票申请</a><span class="c-888">（发票申请前需先维护发票信息和发票寄送地址。）</span>
					</div>
					<table class="table table-bg table-border table-bordered table-sdrk goodsTable">
						<thead>

							<tr>
								<th class="w-40"><span class=""></span> </th>
								<th class="w-180">订单编号</th>
								<th class="w-120">下单日期</th>
								<th class="w-300">商品名称</th>
								<th class="w-110">订单金额（元）</th>
								<th class="w-110">支付状态</th>
							</tr>
						</thead>
						<tbody id="historyOrder">
						
						</tbody>
					</table>
				</div>
			</div>
			<div class="text-c btnWrap">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70" onclick="closeHistoryRecord()">关闭</a>
			</div>
		</div>
	</div>
</div>


	<!-- 提示 -->
	<div class="popupBox w-480 receiptWarn">
		<h2 class="popupHead">
			提示
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pb-50">
			<div class="popupMain pt-30 pb-60">
				<div class="mb-10 text-c f-14 pt-30">
					<span class="iconType iconType1"></span>
					申请开票前需您先维护发票信息和发票寄送地址。
				</div>
				<div class="text-c">
					<a class="btn_recep insertinvoice"><i class="sficon sficon-edit"></i> 维护发票信息</a>
					<a class="btn_recep ml-15 insertaddress"><i class="sficon sficon-edit"></i> 发票寄送地址</a>
				</div>

			</div>
			<div class="text-c btbWrap">
				<a href="javascript:closereceiptWarn();" class="sfbtn sfbtn-opt3" >关闭</a>
			</div>
		</div>
	</div>

	<div class="popupBox w-600 receiptInfoWrap">
		<h2 class="popupHead">
			申请发票
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pb-50">
			<div class="popupMain pt-25 pl-30 pr-30">
				<div class="f-14 lh-24 pb-10">
					您共选择了<span class="va-t pl-5 pr-5 c-fe0101 f-18" id="applbranches">3</span>条订单， 开票金额：<span class="va-t pl-5 pr-5 c-0e8ee7 f-18" id="applamount">12,000</span>元。
				</div>
				<div class="infoWrap">
					<p class="infoWrapTitle">发票信息</p>
					<div class="cl lh-26 f-13">
						<span class="f-l w-90 text-r" >发票性质：</span>
						<p class="f-l c-888" id="invoiceNature">纸质发票</p>
					</div>
					<div class="cl lh-26 f-13">
						<span class="f-l w-90 text-r">发票抬头：</span>
						<p class="f-l c-888 w-420" id="invoiceTitle">捷成家用电器服务部</p>
					</div>
					<div class="cl lh-26 f-13">
						<span class="f-l w-90 text-r">发票类型：</span>
						<p class="f-l c-888" id="invoiceType">增值税普通发票</p>
					</div>
				</div>
				<div class="infoWrap">
					<p class="infoWrapTitle">发票寄送地址</p>
					<div class="cl lh-26 f-13">
						<span class="f-l w-90 text-r">收件人姓名：</span>
						<p class="f-l c-888" id="receiverName">胖纸</p>
						<span class="f-l w-90 text-r">手机号：</span>
						<p class="f-l c-888" id="receiverMobile">13805510551</p>
					</div>
					<div class="cl lh-26 f-13">
						<span class="f-l w-90 text-r">收件地址：</span>
						<p class="f-l c-888 w-420" id="receiverAddress">湖南张家界永定区湖南张家界永定区北门幼儿园后面</p>
					</div>
					<div class="cl lh-26 f-13">
						<span class="f-l w-90 text-r">邮政编码：</span>
						<p class="f-l c-888 " id="invoicepost">230011</p>
					</div>
				</div>
			</div>
			<div class="text-c btbWrap">
				<a href="javascript:;" class="sfbtn sfbtn-opt3" onclick="tijiaosq()">提交</a>
				<a href="javascript:closereceiptInfoWrap();" class="sfbtn sfbtn-opt">关闭</a>
			</div>
		</div>
	</div>

<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript">

    function closereceiptWarn() {
        $.closeDiv($('.receiptWarn'));
    }
    function closereceiptInfoWrap() {
        $.closeDiv($('.receiptInfoWrap'));
    }
    function applications() {
        var ids = $('.table-sdrk tr[data-selected ="true"]');
       // var statusArr = new Array();
        var reviewstatusArr = new Array();
        var numberArr = new Array();
        var placeingtimeArr = new Array();

        var amount = 0;
        $.each(ids, function (index, obj) {
           // statusArr.push($(obj).find(".statusC").text());
            reviewstatusArr.push($(obj).find(".review_status").val());
            numberArr.push($(obj).find(".number").text());
            placeingtimeArr.push($(obj).find(".placing_order_time").text());
            var good_amount=$(obj).find(".good_amount").text();
            var discount_amount=isBlank($(obj).find(".discount_amount").val()) ? 0:$(obj).find(".discount_amount").val();
            if (good_amount != null && good_amount != "") {
                amount = parseFloat(amount) + parseFloat(good_amount)-parseFloat(discount_amount);
            }
            amount = parseFloat(amount).toFixed(2);

        });
        //var nameArr=$('#table-waitdispatch').getCol("good_category",false);
        //var statusArr=$('#table-waitdispatch').getCol("status",false);
        //var reviewstatusArr=$('#table-waitdispatch').getCol("review_status",false);
        //var amount=$('#table-waitdispatch').getCol("good_amount",false,'sum');
        if ('${invoiceMsg.columns.id}' == null || '${invoiceMsg.columns.id}' == "" || '${invoiceAddress.columns.id}' == null || '${invoiceAddress.columns.id}' == "") {
            $('.receiptWarn').popup();
        } else {
            if (ids == null || ids.length == 0) {
                layer.msg("请选择订单!");
                return;
            }

       /*    var flag2 = true;
            $.each(statusArr, function (index, obj) {
                if (obj != "已发货" && obj!="已入库") {//已发货.已入库
                    layer.msg("订单必须为已发货或已入库的订单 '" + numberArr[index] + "' 订单为 "+obj);
                    flag2 = false;
                    return false;
                }
            })
            if (!flag2) {
                return;
            }*/
            var flag4 = true;
            $.each(placeingtimeArr, function (index, obj) {
                if (new Date(Date.parse(obj))<=new Date(Date.parse("2018-01-23 00:00:00"))) {
                    layer.msg("订单 '" + numberArr[index] + "' 已过时");
                    flag4 = false;
                    return false;
                }
            });
            if (!flag4) {
                return;
            }
            var flag3 = true;
            $.each(reviewstatusArr, function (index, obj) {
                if (obj == "0"||obj=="1"||obj=="3"||obj=="4") {
                    layer.msg("订单 '" + numberArr[index] + "' 已申请过发票");
                    flag3 = false;
                    return false;
                }
            });
            if (!flag3) {
                return;
            }
            $('#applbranches').html(ids.length);
            $('#applamount').html(amount);
            $('#invoiceNature').html("纸质发票");
            $('#invoiceTitle').html('${invoiceMsg.columns.invoice_title}');
            if ('${invoiceMsg.columns.invoice_type}' == "0") {
                $('#invoiceType').html("增值税普通发票");
            } else {
                $('#invoiceType').html("增值税专用发票");
            }
            $('#receiverMobile').html('${invoiceAddress.columns.recevier_mobile}');
            $('#receiverName').html('${invoiceAddress.columns.receiver_name}');
            $('#receiverAddress').html('${invoiceAddress.columns.receiver_province}' + '${invoiceAddress.columns.recevier_city}' + '${invoiceAddress.columns.receiver_area}' + '${invoiceAddress.columns.recevier_address}');
            $('#invoicepost').html('${invoiceAddress.columns.postcode}');
            $('.receiptInfoWrap').popup();
        }
    }

    $(".insertinvoice").on('click', function () {
        layer.open({
            type: 2,
            content: '${ctx}/finance/invoiceMsg/toform',
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            anim: -1
        });
    })

    $(".insertaddress").on('click', function () {
        layer.open({
            type: 2,
            content: '${ctx}/finance/invoiceMsg/tofromAddress',
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            anim: -1
        });
    })

    var marksq = false;
    function tijiaosq() {
        if (marksq) {
            return;
        }
        var invoicemsgid = '${invoiceMsg.columns.id}';
        var invoiceaddressid = '${invoiceAddress.columns.id}';
        var ids2 = $('.table-sdrk tr[data-selected ="true"]');
        //var ids2 = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var amount2 = 0;
        var orderids = new Array();
        var orderGoodsCate = new Array();
        var ordernumbers = new Array();
        $.each(ids2, function (index, obj) {
            var good_amount=$(obj).find(".good_amount").text();
            var discount_amount=isBlank($(obj).find(".discount_amount").val()) ? 0:$(obj).find(".discount_amount").val();
            if (good_amount != null && good_amount != "") {
                amount2 = amount2 + parseFloat(good_amount)-parseFloat(discount_amount);
            }

			/*  var row2 = $("#table-waitdispatch").jqGrid("getRowData", obj);
			 if (row2.good_amount != null && row2.good_amount != "") {
			 amount2 = amount2 + parseFloat(row2.good_amount);
			 }*/
            orderGoodsCate.push($(obj).find(".goodNameP").text());
            ordernumbers.push($(obj).find(".number").text());
            var orderid=$(obj).find("input[name='id']").val();
            if (orderid != null && orderid != "") {
                orderids.push(orderid);
            }
        });
        //orderids = ids2;
        var invoicevalue = amount2;
        var invoiceNature = "0";
        var invoiceTitle = $("#invoiceTitle").text();
        var invoiceType = "0";
        if ($("#invoiceType").text() == "增值税普通发票") {
            invoiceType = "0";
        } else {
            invoiceType = "1";
        }
        var receiverName = $("#receiverName").text();
        var receiverMobile = $("#receiverMobile").text();
        var receiverAddress = $("#receiverAddress").text();
        var postcode = $("#invoicepost").text();
        var types = "1";
        marksq = true;
        $.ajax({
            type: "POST",
            url: "${ctx}/finance/invoiceApplication/saveapplication",
            traditional: true,
            data: {
                invoicemsgid: invoicemsgid,
                invoiceaddressid: invoiceaddressid,
                invoicevalue: invoicevalue,
                orderids: orderids,
                orderGoodsCate: orderGoodsCate,
                invoiceNature: invoiceNature,
                invoiceTitle: invoiceTitle,
                invoiceType: invoiceType,
                receiverName: receiverName,
                receiverMobile: receiverMobile,
                receiverAddress: receiverAddress,
                postcode: postcode,
                types: types,
				kptype:'0',
                ordernumbers:ordernumbers
            },
            success: function (data) {
                if (data == "ok") {
                    layer.msg('申请发票成功等待审核!');
                    //search();
                    $.closeDiv($('.receiptInfoWrap'));
                    //window.location.reload(true);
                } else {
                    layer.msg('申请失败!');
                    //window.location.reload(true);
                    return;
                }
                marksq = false;
            }
        });
    }

$('.imgbox3').hover(function(){
	$(this).find('.btn-delimg').show();
	/* var fdfd = '${site.columns.zhifubao_img }';
	if(isBlank(fdfd)){
		$(this).find('.btn-delimg').hide();
	} */
}, function(){
	$(this).find('.btn-delimg').hide();
})

function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}


	function delimg() {
		if ($("#img-input1").val()=== "") {
		} else {

			$(".delzfb").css('display', 'block');
		}
	}
	function nodelimg() {
		$(".delzfb").css('display', 'none');
	}

	function delimg2() {
		if ($("#img-input2").val() === "") {
		} else {
         
			$(".delwx").css('display', 'block');
		}
	}
	function nodelimg2() {
		$(".delwx").css('display', 'none');
	}

	function TextValidate() {
		var code;
		var character;
		if (document.all) {
			code = window.event.keyCode;
		} else {
			code = arguments.callee.caller.arguments[0].which;
		}
		var character = String.fromCharCode(code);
		var txt = new RegExp(
				"[ ,\\`,\\~,\\!,\\@,\#,\\$,\\%,\\^,\\+,\\*,\\&,\\\\,\\/,\\?,\\|,\\:,\\.,\\<,\\>,\\{,\\},\\(,\\),\\',\\;,\\=,\"]");
		if (txt.test(character)) {
			alert("User Name can not contain SPACES or any of these special characters:\n , ` ~ ! @ # $ % ^ + & * \\ / ? | : . < > {} () [] \" ");
			if (document.all) {
				window.event.returnValue = false;
			} else {
				arguments.callee.caller.arguments[0].preventDefault();
			}
		}
	}

	$(function() {

		createUploader('.upload', '#ImgprocessPJ1', '', '', '');
		erweima('#erweima', '#ImgprocessPJ2', '', '', '');
		weixin('#weixin', '#ImgprocessPJ3', '', '', '')

	});
/*    $('.goodsTable .label-cbox').on('click', function () {
        var flag = $(this).hasClass('label-cbox2-selected');
        if(flag){
            $(this).removeClass('label-cbox2-selected');
            $(this).closest('tr').attr({'data-selected':'false'});
        }else {
            $(this).addClass('label-cbox2-selected');
            $(this).closest('tr').attr({'data-selected':'true'});
        }
    })*/
  function checkselect(obj) {
      var flag = $(obj).hasClass('label-cbox2-selected');
      if(flag){
          $(obj).removeClass('label-cbox2-selected');
          $(obj).closest('tr').attr({'data-selected':'false'});
      }else {
          $(obj).addClass('label-cbox2-selected');
          $(obj).closest('tr').attr({'data-selected':'true'});
      }
  }
    $('#historyOrder .label-cbox').on('click', function () {
        var flag = $(this).hasClass('label-cbox2-selected');
        if(flag){
            $(this).removeClass('label-cbox2-selected');
            $(this).closest('tr').attr({'data-selected':'false'});
        }else {
            $(this).addClass('label-cbox2-selected');
            $(this).closest('tr').attr({'data-selected':'true'});
        }
    })


	//点击保存修改
	$("#btn-save")
			.bind(
					'click',
					function() {
						//获取页面元素信息
						var province = $("#province").val();
						var city = $("#city").val();
						var area = $("#area").val();
						var addressl = $("#spanadress").val();
						var contacts = $("#contacts").val();
						var telephone = $("#telephone").val();
						var img = $("#img-input").val();

						//var adress=document.getElementById("spanadress").value;
						var moliereg = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
						if (contacts == null || contacts == "") {
							layer.msg("服务商联系人为必填项");
							return;
						}

						if (telephone.length > 0) {
							if (!moliereg.test(telephone)) {
								layer.msg("请输入正确的联系方式");
								return;
							}
						} else {
							layer.msg("请输入联系方式");
							return;
						}
						if (province == null || province == "") {
							layer.msg("请选择省份");
							return;
						}
						if (city == null || city == "") {
							layer.msg("请选择相应的市");
							return;
						}
						if (area == null || area == "") {
							layer.msg("请选择相应的区");
							return;
						}

						$.ajax({
							type : 'POST',
							url : "${ctx}/operate/getSiteMsg/editeSite",//修改
							traditional : true,
							data : {
								"contacts" : contacts,
								"telephone" : telephone,
								"license_img" : img,
								"adress" : adress,
								"province" : province,
								"city" : city,
								"area" : area,
								"address" : addressl
							},
							success : function(data) {
								//隐藏相关元素
								$("#showProvince").css("display", "none");
								$("#showCity").css("display", "none");
								$("#showArea").css("display", "none");
								$("#spanadress").css("display", "none");
								window.location.reload(true);
							}

						});
					})
	//点击修改按钮
	$('#btn-edit').bind('click', function() {
		$("#contacts").val('${site.columns.contacts }');
		$("#telephone").val('${site.columns.telephone }');
		$("#province").val('${site.columns.province }');
		$("#city").val('${site.columns.city }');
		$("#area").val('${site.columns.area }');
		$("#spanadress").val('${site.columns.address }');
		$('#infoWrap').find('input').removeAttr('disabled').css({
			'border' : '1px solid #ccc'
		});
		//显示和隐藏相关元素
		$(this).hide();
		$('.adress').hide();
		$('.btn2').show();
		$("#showProvince").css("display", "");
		$("#showCity").css("display", "");
		$("#showArea").css("display", "");
		$("#spanadress").css("display", "");
		$("select").prop("disabled", false);

		$(".up").css("visibility", "");
	})

	function createUploader(picker, site, el, id, delimg) {
		var thumbnailWidth = 150; //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 150;
		uploader = WebUploader.create({
			// 选完文件后，是否自动上传。 
			auto : true,
			swf : '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
			server : '${ctx}/common/uploadFile',
			duplicate : true,
			fileSingleSizeLimit : 1024 * 1024 * 5,
			pick : picker,
			accept : {
				title : 'Images',
				extensions : 'gif,jpg,jpeg,bmp,png',
				mimeTypes : 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			},
			method : 'POST'
		});
		uploader.on("error", function(type) {
			if (type == "Q_TYPE_DENIED") {
				layer.alert("请上传JPG、PNG格式文件");
			} else if (type == "F_EXCEED_SIZE") {
				layer.alert("文件大小不能超过5M");
			}
		});

		uploader.on('beforeFileQueued', function(file) {
			uploader.reset();
		});
		uploader.on('uploadSuccess', function(file, response) {
			$("#imgpic").attr("src", "${commonStaticImgPath}" + response.path);
			$("#img-input").val(response.path);
		});
		uploader.on('uploadError', function(file, reason) {

		});

		uploader.on('fileQueued', function(file) {
			uploader.makeThumb(file, function(error, src) {
				if (error) {
					alert('不能预览');
				} else {
					img(id, src, file, site);
					dele(file);
				}
			}, thumbnailWidth, thumbnailHeight);
			//   uploader.upload();  
		});

	}
	//删除图片
	function dele(file) {
		$(".btn-delimg").on("click", function() {
			$(this).parent('.imgWrap1').remove();
			uploader.removeFile(file, true);
			$("#pickerImg" + file.id).remove();
			return;
		})
	}

	function img(id, src, file, site) {
		var html = ' <div class="" id="file'+file.id+'">';
		html += '<img src="'+src+'" id=""></img></div>';
		$(site).html(html);
	}
	//点击取消按钮出发事件
	function cancel() {
		$('#infoWrap').find('input').attr({
			'disabled' : 'disabled'
		}).css({
			'border' : '1px solid #fff'
		});
		$('.btn2').hide();
		$("#showProvince").css("display", "none");
		$("#showCity").css("display", "none");
		$("#showArea").css("display", "none");
		$("#spanadress").css("display", "none");

		$('#btn-edit').show();
		$('.adress').show();
		$('.up').css("visibility", "hidden");
		window.location.reload(true);
	}
	//联级下拉框的js
	$(function() {
		$("#province")
				.change(
						function() {
							var province = $("#province").val();
							$
									.ajax({
										type : "post",
										url : "${ctx}/order/getCity",
										async : false,
										data : {
											province : province
										},
										dataType : "json",
										success : function(data) {
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
														HTML += '<option value="'+obj[i].columns.CityName+'" selected="selected">'
																+ obj[i].columns.CityName
																+ '</option>';
													} else {
														HTML += '<option value="'+obj[i].columns.CityName+'">'
																+ obj[i].columns.CityName
																+ '</option>';
													}
												}

												$("#city").append(HTML);
											}

										},
										error : function() {
											return;
										},
										complete : function() {
											var cls = $("#city").find(
													"option:selected").prop(
													"value");
											$.ajax({
														type : "post",
														url : "${ctx}/order/getArea",
														async : true,
														data : {
															city : cls
														},
														dataType : "json",
														success : function(data) {
															var obj = eval(data);
															var length = obj.length;
															if (length < 1) {
																layer
																		.msg("无数据");
															} else {

																$("#area")
																		.empty();
																var HTML = " ";
																for (var i = 0; i < length; i++) {
																	if (i == 0) {
																		HTML += '<option value="'+obj[i].columns.DistrictName+'" selected="selected">'
																				+ obj[i].columns.DistrictName
																				+ '</option>';
																	} else {
																		HTML += '<option value="'+obj[i].columns.DistrictName+'" >'
																				+ obj[i].columns.DistrictName
																				+ '</option>';
																	}
																}
																$("#area")
																		.append(
																				HTML);
															}
														}
													});

											return;
										}
									});
						});

	});
	// 选择市获取区县
	$("#city")
			.change(
					function() {
						var city = $("#city").val();
						$.ajax({
									type : "post",
									url : "${ctx}/order/getArea",
									async : false,
									data : {
										city : city
									},
									dataType : "json",
									success : function(data) {
										var obj = eval(data);
										var length = obj.length;
										if (length < 1) {
											layer.msg("无数据");
										} else {

											$("#area").empty();
											var HTML = " ";
											for (var i = 0; i < length; i++) {
												if (i == 0) {
													HTML += '<option value="'+obj[i].columns.DistrictName+'" selected="selected">'
															+ obj[i].columns.DistrictName
															+ '</option>';
												} else {
													HTML += '<option value="'+obj[i].columns.DistrictName+'" >'
															+ obj[i].columns.DistrictName
															+ '</option>';
												}
											}
											$("#area").append(HTML);
										}
									}
								});
					});

	function erweima(picker, site, el, id, delimg) {
		var thumbnailWidth = 150; //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 150;
		uploader1 = WebUploader.create({
			// 选完文件后，是否自动上传。 
			auto : true,
			swf : '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
			server : '${ctx}/common/uploadFile',
			duplicate : true,
			fileSingleSizeLimit : 1024 * 1024 * 5,
			pick : {
				id : picker,
               
			},
			accept : {
				title : 'Images',
				extensions : 'gif,jpg,jpeg,bmp,png',
				mimeTypes : 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			},
			method : 'POST'
		});
		uploader1.on("error", function(type) {
			if (type == "Q_TYPE_DENIED") {
				layer.alert("请上传JPG、PNG格式文件");
			} else if (type == "F_EXCEED_SIZE") {
				layer.alert("文件大小不能超过5M");
			}
		});

		uploader1.on('beforeFileQueued', function(file) {
			uploader.reset();
		});
		uploader1.on('uploadSuccess',
				function(file, response) {
					$("#imgpic1").attr("src",
							"${commonStaticImgPath}" + response.path);
					$("#img-input1").val(response.path);
					$(".erweima").remove();
					var imgzfb = $("#img-input1").val();
					$.ajax({
						type : 'POST',
						url : "${ctx}/operate/getSiteMsg/updatezfb",//修改
						traditional : true,
						data : {
							"imgzfb" : imgzfb,

						},
						success : function(data) {
							window.location.reload(true);
							//隐藏相关元素
							
							//$(".erweima").text("重新上传");
						}
					});

					uploader1.on('uploadError', function(file, reason) {

					});

					uploader1.on('fileQueued', function(file) {
						$(".erweima").remove();
						uploader1.makeThumb(file, function(error, src) {
							if (error) {
								alert('不能预览');
							} else {
								img(id, src, file, site);
								dele(file);
							}
						}, thumbnailWidth, thumbnailHeight);
						//   uploader.upload();  
					});

				});

	}

	function weixin(picker, site, el, id, delimg) {
		var thumbnailWidth = 150; //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 150;
		uploader2 = WebUploader.create({
			// 选完文件后，是否自动上传。 
			auto : true,
			swf : '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
			server : '${ctx}/common/uploadFile',
			duplicate : true,
			fileSingleSizeLimit : 1024 * 1024 * 5,
			pick : picker,
			accept : {
				title : 'Images',
				extensions : 'gif,jpg,jpeg,bmp,png',
				mimeTypes : 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
			},
			method : 'POST'
		});
		uploader2.on("error", function(type) {
			if (type == "Q_TYPE_DENIED") {
				layer.alert("请上传JPG、PNG格式文件");
			} else if (type == "F_EXCEED_SIZE") {
				layer.alert("文件大小不能超过5M");
			}
		});

		uploader2.on('beforeFileQueued', function(file) {
			uploader.reset();
		});
		uploader2.on('uploadSuccess',
				function(file, response) {
					$("#imgpic2").attr("src","${commonStaticImgPath}" + response.path);
					$("#img-input2").val(response.path);
					var imgwx = $("#img-input2").val();
					$.ajax({
						type : 'POST',
						url : "${ctx}/operate/getSiteMsg/updatewx",//修改
						traditional : true,
						data : {
							"imgwx" : imgwx,

						},
						success : function(data) {
							//隐藏相关元素
							window.location.reload(true);

						},
					});
			
		uploader2.on('uploadError', function(file, reason) {

		});

		uploader2.on('fileQueued', function(file) {
			$(".weixin").remove();
			uploader2.makeThumb(file, function(error, src) {
				if (error) {
					alert('不能预览');
				} else {
					img(id, src, file, site);
					dele(file);
				}
			}, thumbnailWidth, thumbnailHeight);
			//   uploader.upload();  
		});
	});
	}

	function delzfb() {
		$("#imgpic1")[0].src = "";
		$.ajax({
			type : 'POST',
			url : "${ctx}/operate/getSiteMsg/updatezfb",//修改
			traditional : true,
			data : {
				"imgzfb" : "",

			},
			success : function(data) {
				//隐藏相关元素
				//$(".erweima").text("重新上传")
					window.location.reload(true);
			}
		});

	}
	function delwx() {
		$("#imgpic2")[0].src = "";
		$.ajax({
			type : 'POST',
			url : "${ctx}/operate/getSiteMsg/updatewx",//修改
			traditional : true,
			data : {
				"imgwx" : "",

			},
			success : function(data) {
				window.location.reload(true);

			},

		});
	}
	
	$('#ImgprocessPJ1').imgShow({hasIframe:true});
	
	
	
	//历史购买记录
	function openHistoryRrecord(){
		$("#historyOrder").empty();
		$.ajax({
			type:"POST",
			url:"${ctx}/goods/sitePlatformGoods/historyOrder",
			data:{},
			success:function(result){
				for(var i=0;i<result.length;i++){
					$("#historyOrder").append('<tr >'+
													'<td><span class="label-cbox" onclick="checkselect(this)"></span> </td>'+
                                                 '<td class="text-l number">'+result[i].columns.number+'</td>'+
												 '<td class="placing_order_time">'+formatDate(result[i].columns.placing_order_time)+'</td>'+
												 '<td class="text-l">'+result[i].columns.good_name+'</td>'+
												 '<td class="good_amount">'+result[i].columns.good_amount+'</td>'+
												 '<td>已支付</td> '+
							                     '<input type= "hidden"  value="'+result[i].columns.review_status+'" class="review_status"/>'+
                                                 '<input type= "hidden"  value="'+result[i].columns.discount_amount+'" class="discount_amount"/>'+
                                                /* '<input type= "hidden"  value="'+result[i].columns.number+'" class="number"/>'+*/
                                                 '<input type= "hidden"  value="'+result[i].columns.id+'" name="id"/>'+
											 '</tr>');
				}
				$('.vipHistoryOrder').popup({fixedHeight:false});
			}
		})
	}
	
	function closeHistoryRecord(){
		$.closeDiv($(".vipHistoryOrder"));
	}
	

	
	function qquxiaozhifu(){
		$(".spPayWrap").removeClass("wxPay").addClass("zfbPay");
		$('.payshadeBg').hide();
		$('.spPayWrap').hide();
	}
	
	function formatDate(time){ 
		var now=new Date(time); 
        var year=now.getFullYear();     
        var month=now.getMonth()+1;     
        var date=now.getDate();     
        return   year+"."+month+"."+date;     
        }  
	
	function jumpToVIP(){
		layer.open({
			type : 2,
			content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		});
	}
    
	
</script> 
</body>
</html>
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
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
	<!--[if IE 6]>
	<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->
	<title>商品购买订单</title>
</head>
<body class="">
<div class="sfpagebg bk-gray">
	<div class="page-orderWait goodsPage">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_PLATEFORMJOINGOODS_TAB" html='<a  href="${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist" class="btn-tabBar " href="javascript:;">平台商品</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_SYSSERVE_TAB" html='<a href="${ctx}/goods/sitePlatformGoods/getPlatfromGoodsRecord" class="btn-tabBar current" href="javascript:;">购买记录</a>'></sfTags:pagePermission>
		</div>
		<div class="cl mb-5">
			<div class="f-l GoodsTabBar">
				<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_SYSSERVE_TAB" html='<a  href="${ctx}/goods/sitePlatformGoods/getPlatfromGoodsRecord" class="tabswi">商品购买订单</a>'></sfTags:pagePermission>
				<span class="pipe">|</span>
				<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_LBRECORD_TAB" html='<a  href="${ctx}/goods/nanDao/getPlatfromGoodsRecord" class="tabswi current">漏保订单</a>'></sfTags:pagePermission>
				<span class="pipe">|</span>
				<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_MJLORDERECORD_TAB" html='<a href="${ctx}/goods/mjl/getPlatfromGoodsRecord" class="tabswi">美洁力订单</a>'></sfTags:pagePermission>
			</div>
			<p class="f-r ">
				<a href="javascript:search();" class="sfbtn sfbtn-opt "><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<form action="${ctx}/goods/nanDao/getPlatfromGoodsRecord" id="searchForm" method="post">
			<input type="hidden" name="page" id="pageNo" value="${page.pageNo}">
			<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
			<div class="bk-gray pt-10 pb-5 ">
				<table class="table table-search">
					<tr>
						<th style="width: 76px;" class="text-r">订单编号：</th>
						<td>
							<input type="text" class="input-text" name="number" value="${searchValues.number}"/>
						</td>
						<th style="width: 76px;" class="text-r">订单状态：</th>
						<td>
							<select class="select" name="status" style="width: 140px;">
								<option value="">请选择</option>
								<option value="0" ${searchValues.status eq '0'?'selected':''}>待支付</option>
								<option value="1" ${searchValues.status eq '1'?'selected':''}>出库中</option>
								<option value="3" ${searchValues.status eq '3'?'selected':''}>已发货</option>
								<option value="4" ${searchValues.status eq '4'?'selected':''}>已完成</option>
							</select>
						</td>
						<th style="width: 76px;" class="text-r">下单人：</th>
						<td>
							<select class="select w-140" name="placeOrderMan">
								<option value="">请选择</option>
								<c:forEach items="${placeOrderMan}" var="orderMan">
									<option value="${orderMan.columns.id}" ${searchValues.placeOrderMan eq orderMan.columns.id?'selected':''}>${orderMan.columns.name}</option>
								</c:forEach>
							</select>
						</td>
						<th style="width: 76px;" class="text-r">商品名称：</th>
						<td>
							<input type="text" class="input-text" name = "good_name" value="${searchValues.good_name}"/>
						</td>
						<th style="width: 76px;" class="text-r">商品类别：</th>
						<td>
							<input type="text" class="input-text" name = "good_category" value="${searchValues.good_category}"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div class="pt-10 pb-5 cl btnsWrap">
			<div class="f-l">
				<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_SYSSERVE_FAPIAOAPPLY_BTN" html='<a href="javascript:;" onclick="applications()" class="sfbtn sfbtn-opt "><i class="sficon sficon-fpsq"></i>发票申请</a><span class="c-888">（发票申请前需先维护发票信息和发票寄送地址。）</span>'></sfTags:pagePermission>
			</div>

			<div class="f-r">
				<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
				<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_LBRECORD_EXPORT_BTN" html='<a href="javascript:exports();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
			</div>
		</div>
		<div class="mb-10" id="tableHead">
			<table class="table table-bg goodsTable" style="table-layout: auto">
				<thead>
				<tr>
					<th class="w-40"></th>
					<th class="w-400 text-c">订单详情</th>
					<th class="w-80 text-c">购买数量</th>
					<th class="w-120 text-c">购买金额</th>
					<th class="w-200 text-c">下单人信息</th>
					<th class="w-140 text-c">下单时间</th>
					<th class="w-110 text-c">订单状态</th>
					<th class="w-120 text-c">操作</th>
				</tr>
				</thead>
			</table>
		</div>
		<div id="tableBodyWrap">
			<ul class="" id="tableBody">
			<c:forEach items="${page.list}" var="orders">
				<li class="mb-10">
					<table class="table table-border table-bordered text-c goodsTable" style="table-layout: auto;">
						<tr>
							<td colspan="8" class="c-666 bg-fafafa text-l"><span class="pl-5">订单编号：</span> <span class="c-222 number">${orders.columns.number}</span></td>
						</tr>
						<tr>
							<td class="w-40">
								<span class="sficon label-cbox2"></span>
							</td>
							<td class="w-400 " style="border-left: 0;">
								<div class="imgTD">
									<img src="${commonStaticImgPath}${orders.columns.good_icon}" class="goosImg" />
									<div class=" f-l lh-22 ">
										<p class="f-13 c-005aab goodNameP">${orders.columns.good_name}</p>
										<div class="cl">
											<p class="f-l c-6	66">商品类别：${orders.columns.good_category}</p>
										</div>
									</div>
								</div>
							</td>
							<td class="w-80" style="border-left: 0;">x${orders.columns.purchase_num}</td>
							<td class="w-120"><span>￥</span><span class="good_amount">${orders.columns.good_amount}</span></td>
							<td class="w-200">
								<p class="f-13">${orders.columns.placeOrderName}</p>
								<p class="f-13">${orders.columns.mobile} </p>
							</td>
							<td class="w-140 placing_order_time"><fmt:formatDate value="${orders.columns.placing_order_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td class="w-110">
									<c:if test="${orders.columns.status eq '0'}">
										<span class="oState state-waitVerify2 w-90 text-l statusC">待审核</span>
									</c:if>
									<c:if test="${orders.columns.status eq '1'}">
										<span class="oState state-waitCk w-90 text-l statusC">出库中</span>
									</c:if>
									<c:if test="${orders.columns.status eq '2'}">
										<c:if test="${orders.columns.if_instocks eq '0' || empty orders.columns.if_instocks}">
											<span class="oState state-yfhuo w-90 text-l statusC">已发货</span>
										</c:if>
										<c:if test="${orders.columns.if_instocks eq '1'}">
											<span class="oState state-yrk w-90 text-l statusC">已入库</span>
										</c:if>
									</c:if>
									<c:if test="${orders.columns.status eq '3'}">
										<span class="oState state-pass2 w-90 text-l statusC">审核不通过</span>
									</c:if>
									<c:if test="${orders.columns.status eq '4'}">
										<span class="oState state-canceled w-90 text-l statusC">用户取消</span>
									</c:if>
							</td>
							<td class="w-120">
									<c:if test="${orders.columns.status eq '0' || orders.columns.status eq '1' || orders.columns.status eq '4'}">
										<a class="oState  c-0e8ee7 ">---</a>
									</c:if>
									<c:if test="${orders.columns.status eq '2'}">
										<p>
											<a href="javascript:orderDetailPlat('${orders.columns.id}');" class="c-0e8ee7 w-90 text-l "><i class="sficon  sficon-view"></i>查看详情</a>
										</p>
										<p>
											<a href="javascript:logsitDetailPlat('${orders.columns.id}');" class="c-0e8ee7 oState state-ckwl w-90 text-l">物流信息</a>
										</p>
										<c:if test="${orders.columns.if_instocks ne '1'}">
											<p>
												<sfTags:pagePermission authFlag="GOODSMGM_PLATEFORMGOODS_LBRECORD_INSTOCKS_BTN" html='<a href="javascript:ifInstocks(\'${orders.columns.id}\',\'${orders.columns.good_number}\',\'${orders.columns.good_name}\',\'${orders.columns.purchase_num}\');" class="oState  c-0e8ee7 state-qrrk  w-90 text-l">入库</a>'></sfTags:pagePermission>
											</p>
										</c:if>
									</c:if>
									<c:if test="${orders.columns.status eq '3'}">
										<p>
											<a href="javascript:toPay('${orders.columns.good_id}');" class="c-0e8ee7 oState state-cxtj w-90 text-l">重新提交</a>
										</p>
										<p>
											<a href="javascript:cancelOrder('${orders.columns.id}','${orders.columns.siteself_order_id}','${orders.columns.good_id}','${orders.columns.purchase_num}','${orders.columns.unit}');" class="c-0e8ee7 oState state-pass2 w-90 text-l">取消订单</a>
										</p>
									</c:if>
							</td>
							<input type="hidden" class="goodSign" value="${orders.columns.good_sign}"/>
							<input type= "hidden" name="review_status" value="${orders.columns.review_status}" class="review_status"/>
							<input type= "hidden" name="id" value="${orders.columns.id}"/>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>
		</div>
	</div>
	<div class="pagination pr-10">${page}</div>
</div>

</div>
</div>


<div class="popupBox spOprocess">
	<h2 class="popupHead">
		物流信息
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60" >
		<div class="popupMain pt-15" >
			<div class="pcontent">
				<!-- <div class="cl text-hc pd-20 " id="detailProgress">
				</div> -->
				<div class="llbox bk-gray" >
					<h3 class="lltitle">物流信息
						<span class="f-r mr-10" id="logisticsNo">单号：</span>
						<span class="f-r mr-20" id="logisticsName">名称：</span>

					</h3>
					<div class="nologistics hide">商品尚未发货</div>
					<ul class="logisticslist pt-5 pb-5" style="min-height: 200px;max-height: 400px;overflow: auto">


					</ul>
				</div>
			</div>
		</div>

		<div class="text-c btbWrap">
			<a href="javascript:close();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
		</div>
	</div>
</div>


<!-- 入库 -->
<div class="popupBox sprkbox" style="width:380px">
	<h2 class="popupHead">
		入库 <a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-15 pb-15" >
			<div class="cl">
				<label class="f-l w-100">商品名称：</label>
				<input type="text" class="input-text w-160 f-l readonly "  name="instocksName" readonly="readonly"/>

				<input type="text" class="input-text w-140 f-l readonly hide" type="hidden"  name="instocksNumber" readonly="readonly"/>
				<input type="text" class="input-text w-140 f-l readonly hide" type="hidden"  name="instocksOrderId" readonly="readonly"/>
			</div>
			<div hidden="hidden" id="rkTips" class="pl-100 mt-5 c-888">未转自营的商品，入库时默认转自营。</div>
			<div class="cl mt-10">
				<label class="f-l w-100"><em class="mark">*</em>入库数量：</label>
				<div class="priceWrap f-l w-160">
					<input type="text" class="input-text w-140 f-l " name="instocksNum"/>
					<span class="unit" id="ruUnit">个</span>
				</div>

			</div>
			<div class="text-c mt-20">
				<input type="hidden" name="rgoodId"/>
				<a href="javascript:doInstocks();" class="sfbtn sfbtn-opt3 w-70 mr-5">入库</a> <a
					href="javascript:closeDiv();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
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

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">

    $(function(){
        tableHeight();
        var pageSize=${page.pageSize};
        $('.pagination .select').val(pageSize);
    })
    $('.goodsTable .label-cbox2').on('click', function () {
        var flag = $(this).hasClass('label-cbox2-selected');
        if(flag){
            $(this).removeClass('label-cbox2-selected');
            $(this).closest('tr').attr({'data-selected':'false'});
        }else {
            $(this).addClass('label-cbox2-selected');
            $(this).closest('tr').attr({'data-selected':'true'});
        }
    })
    window.onresize = function(){
        tableHeight();
    }
    function tableHeight() {
        var wHeight = $('.sfpagebg').height() - 270;
        var contHeight = $('#tableBody').height();

        $('#tableBodyWrap').css({
            'height': wHeight + 'px',
            'overflow': 'auto',
        });
        if (contHeight > wHeight) {
            $('#tableHead').css({'padding-right': '17px'});
        } else {
            $('#tableHead').css({'padding-right': '0px'});
        }
    }
	function zfpz(rowData){//支付凭证
   		 return html='<span class="proofImg"><a class="c-0383dc">凭证</a> <img src="${commonStaticImgPath}'+rowData.pay_confirm+'" /> </span>';
	}


function reviewStatus(rowDate) {
    if (rowDate.review_status == "3") {
        return "<span>待审核</span>";
    } else if (rowDate.review_status == "0" || rowDate.review_status == "1" || rowDate.review_status == "4") {
        return "<span>已审核</span>";
    } else {
        if ((rowDate.good_sign != "BS20180107") && (rowDate.good_sign != "BS20180108")) {
            return "<span>————</span>";
        } else {
            if (rowDate.status != "2") {
                return "<span>————</span>";
            } else {
                if (new Date(Date.parse(rowDate.placing_order_time)) <= new Date(Date.parse("2018-01-23 00:00:00"))) {
                    return "<span>————</span>";
                } else {
                    return "<span>待申请</span>";
                }
            }
        }

    }
}
    function search(){
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#searchForm").submit();
    }

    function reset(){
        $("input[name='number']").val('');
        $("select[name='status']").val('');
        $("select[name='placeOrderMan']").val('');
        $("input[name='good_name']").val('');
        $("input[name='good_category']").val('');
    }
    //订单过程(南岛)
    function orderDetailPlat(id){
        pardetaile=layer.open({
            type : 2,
            content:'${ctx}/goods/nanDao/continuePay?id='+id+"&type="+2,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    //取消订单(南岛)
    function cancelOrder(id,soId,gId,pNum){
        var content = "确认要取消？";
        $('body').popup({
            level:3,
            title:"取消订单",
            content:content,
            fnConfirm :function(){
                $.ajax({
                    type : "POST",
                    url : "${ctx}/goods/nanDao/cancelOrder",
                    data : {
                        "id" : id,
                        soId:soId,
                        gId:gId,
                        pNum:pNum
                    },
                    success : function(data) {
                        if (data == "ok") {
                            layer.msg('取消成功!');
                            //window.location.reload(true);
                            search();
                        } else {
                            layer.msg('取消失败!');
                            //window.location.reload(true);
                            search();
                        }
                    }
                });
            },
        });
    }

    //重新提交
    function toPay(id){
        pardetaile=layer.open({
            type : 2,
            content:'${ctx}/goods/sitePlatformGoods/showBuyCOP?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    //弹出入库框（南岛）
    function ifInstocks(id,goodNumber,goodName,num,unit){
        $("input[name='instocksNumber']").val(goodNumber);
        $("input[name='instocksNum']").val(num);
        $("input[name='instocksOrderId']").val(id);
        $.ajax({
            type:"post",
            url:"${ctx}/goods/nanDao/selfGoodByNumber",
            data:{goodNumber:goodNumber},
            success:function(data){
                if(data==null || data==""){
                    $("#rkTips").show();
                    $("input[name='instocksName']").val(goodName);
                }else{
                    $("input[name='instocksName']").val(data.columns.name);
                    if($.trim(data.columns.unit)!="" && data.columns.unit !=null){
                        $("#ruUnit").text(data.columns.unit);
                    }
                }
                $(".sprkbox").popup();
            }
        })

    }


    var instocksMark=false;
    function doInstocks(){
        if(instocksMark){
            return;
        }
        var goodName = $("input[name='instocksName']").val();
        var goodNumber = $("input[name='instocksNumber']").val();
        var num = $.trim($("input[name='instocksNum']").val());
        var orderId = $("input[name='instocksOrderId']").val();
        var parnt = /^[0-9]\d*(\.\d+)?$/;
        if($.trim(num)=="" || num==null){
            layer.msg("请填写入库数量！");
            $("input[name='instocksNum']").focus();
            return;
        }
        if(!parnt.test(num)){
            layer.msg("入库数量要求为大于0的数！");
            $("input[name='instocksNum']").focus();
            return;
        }
        if(parseFloat(num) <= parseFloat(0)){
            layer.msg("入库数量要求为大于0的数！");
            $("input[name='instocksNum']").focus();
            return;
        }
        instocksMark=true;
        $.ajax({
            type:"post",
            url:"${ctx}/goods/nanDao/doInstocks",
            data:{goodName:goodName,goodNumber:goodNumber,num:num,orderId:orderId},
            success:function(data){
                if(data.code=="421"){
                    layer.msg("已入库！");
                }else if(data.code=="422"){
                    layer.msg("该平台商品信息有误，无法转自营！");
                }else if(data.code=="200"){
                    layer.msg("入库成功！");
                    search();
                    closeDiv();
                }else{
                    layer.msg("入库失败，出现未知错误，请联系管理员！");
                }
                instocksMark=false;
                return;
            }
        })
    }

    function closeDiv(){
        $.closeDiv($(".sprkbox"));
    }
    //查看詳情
    function orderDetail(id){
        pardetaile=layer.open({
            type : 2,
            content:'${ctx}/goods/sitePlatformGoods/continuePayId?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    //物流信息(南岛)
    function logsitDetailPlat(id){
        pardetaile=layer.open({
            type : 2,
            content:'${ctx}/goods/nanDao/logsitDetail?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function applications() {
        var ids = $('#tableBody tr[data-selected ="true"]');
        var nameArr = new Array();
        var statusArr = new Array();
        var reviewstatusArr = new Array();
        var numberArr = new Array();
        var placeingtimeArr = new Array();
        var amount = 0;
        $.each(ids, function (index, obj) {
            nameArr.push($(obj).find(".goodSign").val());
            statusArr.push($(obj).find(".statusC").text());
            reviewstatusArr.push($(obj).find(".review_status").val());
            numberArr.push($(obj).prev().find(".number").text());
            placeingtimeArr.push($(obj).find(".placing_order_time").text());
            var good_amount=$(obj).find(".good_amount").text();
            if (good_amount != null && good_amount != "") {
                amount = parseFloat(amount) + parseFloat(good_amount);
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
            var flag1 = true;
            $.each(nameArr, function (index, obj) {
                if ((obj != "BS20180108") && (obj != "BS20180107") && (obj != "LB18102201") && (obj != "LB18102202")) {
                    layer.msg("只能选择升级版的漏电保护插头的订单");
                    flag1 = false;
                    return false;
                }
            })
            if (!flag1) {
                return;
            }

            var flag2 = true;
            $.each(statusArr, function (index, obj) {
                if (obj != "已发货" && obj!="已入库") {//已发货.已入库
                    layer.msg("订单必须为已发货或已入库的订单 '" + numberArr[index] + "' 订单为 "+obj);
                    flag2 = false;
                    return false;
                }
            })
            if (!flag2) {
                return;
            }
            var flag4 = true;
            $.each(placeingtimeArr, function (index, obj) {
                var myDate = new Date();
                var year=myDate.getFullYear();
                var month=myDate.getMonth()+1;
                var nowdate=year+"-"+"0"+month;
				if(month > 9 ){
					nowdate=year+"-"+ month;
				}
                if (obj.indexOf(nowdate) < 0) {
                    layer.msg("订单必须为当月的订单");
                    flag4 = false;
                    return false;
                }

               /* if (new Date(Date.parse(obj))<=new Date(Date.parse("2018-01-23 00:00:00"))) {
                    layer.msg("订单 '" + numberArr[index] + "' 已过时");
                    flag4 = false;
                    return false;
                }*/
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
            $('#receiverMobile').html('${invoiceAddress.columns.recevier_mobile}')
            $('#receiverName').html('${invoiceAddress.columns.receiver_name}');
            $('#receiverAddress').html('${invoiceAddress.columns.receiver_province}' + '${invoiceAddress.columns.recevier_city}' + '${invoiceAddress.columns.receiver_area}' + '${invoiceAddress.columns.recevier_address}');
            $('#invoicepost').html('${invoiceAddress.columns.postcode}');
            $('.receiptInfoWrap').popup();
        }
	}
function closeDiv(){
	$.closeDiv($(".sprkbox"));
}

var instocksMark=false;
function doInstocks(){
	if(instocksMark){
		return;
	}
	var goodName = $("input[name='instocksName']").val();
	var goodNumber = $("input[name='instocksNumber']").val();
	var num = $.trim($("input[name='instocksNum']").val());
	var orderId = $("input[name='instocksOrderId']").val();
	var parnt = /^[0-9]\d*(\.\d+)?$/;
	if($.trim(num)=="" || num==null){
		layer.msg("请填写入库数量！");
		$("input[name='instocksNum']").focus();
		return;
	}
	if(!parnt.test(num)){
		layer.msg("入库数量要求为大于0的数！");
		$("input[name='instocksNum']").focus();
		return;
	}
	if(parseFloat(num) <= parseFloat(0)){
		layer.msg("入库数量要求为大于0的数！");
		$("input[name='instocksNum']").focus();
		return;
	}
	instocksMark=true;
	$.ajax({
		type:"post",
		url:"${ctx}/goods/nanDao/doInstocks",
		data:{goodName:goodName,goodNumber:goodNumber,num:num,orderId:orderId},
		success:function(data){
			if(data.code=="421"){
				layer.msg("已入库！");
				return;
			}else if(data.code=="422"){
				layer.msg("该平台商品信息有误，无法转自营！");
				return;
			}else if(data.code=="200"){
				layer.msg("入库成功！");
				search();
				closeDiv();
				return;
			}else{
				layer.msg("入库失败，出现未知错误，请联系管理员！");
				return;
			}
			instocksMark=false;
		}
	})
}
    var marksq = false;
    function tijiaosq() {
        if (marksq) {
            return;
        }
        var invoicemsgid = '${invoiceMsg.columns.id}';
        var invoiceaddressid = '${invoiceAddress.columns.id}';
        var ids2 = $('#tableBody tr[data-selected ="true"]');
        //var ids2 = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var amount2 = 0;
        var orderids = new Array();
        var orderGoodsCate = new Array();
        var ordernumbers = new Array();
        $.each(ids2, function (index, obj) {
            var good_amount=$(obj).find(".good_amount").text();
            if (good_amount != null && good_amount != "") {
                amount2 = amount2 + parseFloat(good_amount);
            }
          /*  var row2 = $("#table-waitdispatch").jqGrid("getRowData", obj);
            if (row2.good_amount != null && row2.good_amount != "") {
                amount2 = amount2 + parseFloat(row2.good_amount);
            }*/
            orderGoodsCate.push($(obj).find(".goodNameP").text());
            ordernumbers.push($(obj).prev().find(".number").text());

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
        var types = "2";
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
				kptype:'1',
				ordernumbers:ordernumbers
            },
            success: function (data) {
                if (data == "ok") {
                    layer.msg('申请发票成功等待审核!');
                    search();
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
    function closereceiptWarn() {
        $.closeDiv($('.receiptWarn'));
    }
    function closereceiptInfoWrap() {
        $.closeDiv($('.receiptInfoWrap'));
    }


    function exports(){
        var idArr=${page.list.size()}
        var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
        if(idArr>10000){
            $('body').popup({
                level:3,
                title:"导出",
                content:content,
                fnConfirm :function(){
                    location.href="${ctx}/goods/nanDao/exports?formPath=/a/goods/nanDao/list&&maps="+$("#searchForm").serialize();
                }

            });
        }else{
            location.href="${ctx}/goods/nanDao/exports?formPath=/a/goods/nanDao/list&&maps="+$("#searchForm").serialize();
        }

    }

</script>
</body>
</html>
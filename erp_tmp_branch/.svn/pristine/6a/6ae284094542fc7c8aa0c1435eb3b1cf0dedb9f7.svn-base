<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
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
	<title>订单信息——公司商品订单</title>
</head>
<body class="">
<div class="sfpagebg bk-gray">
	<div class="page-orderWait goodsPage">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_YANGJIGOODS_TAB" html='<a class="btn-tabBar " href="${ctx}/goods/siteself/getPrototypeList">奥莱家电</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_YANGJIORDERSELF_TAB" html='<a class="btn-tabBar current" href="${ctx }/goods/siteself/getMyorder">我的订单</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt "><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<form action="${ctx}/goods/siteself/getMyorder" id="searchForm" method="post">
			<input type="hidden" name="page" id="pageNo" value="${page.pageNo}">
			<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
		<div class="bk-gray pt-10 pb-5 ">
			<table class="table table-search">
				<tr>
					<th style="width: 76px;" class="text-r">商品编号：</th>
					<td><input type="text" class="input-text" name="number" value="${maps.number}"/></td>
					<th style="width: 76px;" class="text-r">商品名称：</th>
					<td><input type="text" class="input-text" name="name" value="${maps.name}"/></td>
					<th style="width: 76px;" class="text-r">商品类别：</th>
					<td>
						<%--<span class="select-box">
							<select class="select" name="category">
								<option value="">请选择</option>
								<c:forEach var="cg" items="${categoryList}">
								<option value="${cg.columns.name }"
									<c:if test="${maps.category == cg.columns.name}">selected="selected"</c:if>>${cg.columns.name }</option>
								</c:forEach>
							</select>
						</span>--%>
						<input type="text" class="input-text" name="category" value="${maps.category}"/>
					</td>
					<th style="width: 76px;" class="text-r">商品型号：</th>
					<td>
						<input type="text" class="input-text" name="model" value="${maps.model}"/>
					</td>
					<th style="width: 76px;" class="text-r">状态：</th>
					<td><select class="select" name="orderStatus" style="width: 140px;">
						<option value="">请选择</option>
						<option value="1"
								<c:if test="${maps.orderStatus == 1}">selected="selected"</c:if> >待审核
						</option>
						<option value="2"
								<c:if test="${maps.orderStatus == 2}">selected="selected"</c:if> >待领取
						</option>
						<option value="4"
								<c:if test="${maps.orderStatus == 4}">selected="selected"</c:if> >审核未通过
						</option>
					</select>
					</td>
				</tr>
			</table>
		</div>
		</form>
		<div class="pt-10 pb-5 cl btnsWrap">
			<%--<div class="f-r">
				<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>
			</div>--%>
		</div>
		<div class="mb-10" id="tableHead">
			<table class="table table-bg goodsTable">
				<thead>
				<tr>
					<th class="w-420 text-c">商品信息</th>
					<th class="w-80 text-c">购买数量</th>
					<th class="w-100 text-c">购买金额</th>
					<th class="w-100 text-c">下单时间</th>
					<th class="w-110 text-c">订单状态</th>
					<th class="w-190 text-c">备注（不通过原因）</th>
					<th class="w-110 text-c">凭证</th>
					<th class="w-120 text-c">操作</th>
				</tr>
				</thead>
			</table>
		</div>
		<ul class="" id="tableBody">
			<li class="mb-10">
				<table class="table table-border table-bordered text-c goodsTable" style="table-layout: auto;">
					<c:forEach var="item" items="${page.list}">
					<tr>
						<td colspan="8" class="c-666 bg-fafafa text-l"><span class="pl-5">订单编号：</span> <span class="c-222"><a class="c-0e8ee7" href="javascript:getDetailMsg('${item.columns.id}');">${item.columns.number}</a></span></td>
					</tr>
					<tr>
						<td class="w-420 cPointer" onclick="getDetailMsg('${item.columns.id}')">
							<div class="imgTD">
								<img src="${prototypeStaticImgPath}${item.columns.imgs}" class="goosImg" />
								<div class=" ">
									<p class="f-13 c-005aab">${item.columns.name }</p>
									<div class="cl lh-26">
										<p class="c-666 f-l pr-30">商品类别：${item.columns.category}</p>
										<p class="c-666 f-l ">商品型号：${item.columns.model}</p>
									</div>
									<div class="text-overflow w-320 c-666">${item.columns.bremarks}</div>
								</div>
							</div>
						</td>
						<td class="w-80" style="border-left: 0;">x1</td>
						<td class="w-100">￥${item.columns.purchase_amount }</td>
						<td class="w-100">${item.columns.create_time}</td>
						<td class="w-100">
								<c:choose>
									<c:when test="${item.columns.bstatus eq '4'}">
										<span class="oState state-yth">已提货</span>
									</c:when>
									<c:when test="${item.columns.bstatus eq '3'}">
										<c:if test="${item.columns.status eq '1'}">
											<span class="oState state-waitVerify2">待审核</span>
										</c:if>
										<c:if test="${item.columns.status eq '4'}">
											<span class="oState state-pass2">未通过</span>
										</c:if>
										<c:if test="${item.columns.status eq '2'}">
											<span class="oState state-finished">审核通过</span>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${item.columns.status eq '4'}">
											<span class="oState state-pass2">未通过</span>
										</c:if>
										<c:if test="${item.columns.status ne '4'}">---</c:if>
									</c:otherwise>
								</c:choose>
						</td>
						<td class="w-190">${item.columns.remarks}</td>
						<td class="w-110 prototypeImg">
							<img src="${prototypeStaticImgPath}${item.columns.icon}" class="goosImg" />
						</td>
						<td class="w-120">
							<c:choose>
								<c:when test="${item.columns.status eq '4'}">
									<p><a class="c-0e8ee7 oState state-cxtj"  href="javascript:toPay('${item.columns.id}','${item.columns.prototype_id}');">重新提交</a></p>
									<p><a class="c-0e8ee7 oState state-pass2" href="javascript:cancel('${item.columns.id}','${item.columns.prototype_id}');">取消订单</a></p>
								</c:when>
								<c:otherwise>---</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:forEach>
				</table>
			</li>

		</ul>
	</div>
	<div>
		<div class="pagination">${page}</div>
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">

    $(function(){
        tableHeight();
    })

    $(".prototypeImg").each(function(){
        $(this).imgShow({hasIframe:true});
    })

    //重新提交
    function toPay(id,pId){
        pardetaile=layer.open({
            type : 2,
            content:'${ctx}/goods/siteself/prototypePay?id='+id+"&type="+1,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
    //取消订单
    function cancel(id,protoId){
        var content = "确认要取消？";
        $('body').popup({
            level:3,
            type:2,
            title:"取消订单",
            content:content,
            fnConfirm :function(){
                $.ajax({
                    type : "POST",
                    url : "${ctx}/goods/siteself/cancellationofOrder",
                    data : {
                        "id" : id,
                        protoId:protoId
                    },
                    success : function(data) {
                        if (data == "ok") {
                            layer.msg('取消成功!');
                            search();
                        } else {
                            layer.msg('取消失败!');
                            search();
                        }
                    }
                });
            },
            fnCancel:function (){

            }
        });
    }

    window.onresize = function(){
        tableHeight();
    }
    function tableHeight(){
        var wHeight = $('.sfpagebg').height() - 250;
        var contHeight = $('#tableBody').height();

        $('#tableBody').css({
            'max-height':wHeight+'px',
            'overflow':'auto',
        });

        var tWidth = $('#tableBody').find('.table').eq(0).width();
        $('#tableHead').width(tWidth);
    }


    function search(){
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#searchForm").submit();
    }

    function jsClearForm() {
        $("#searchForm :input[type='text']").each(function () {
            $(this).val("");
        });

        $("select").val("");

    }

    function getDetailMsg(id){
        layer.open({
            type : 2,
            content:'${ctx}/goods/siteself/getOrderId?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }
</script>
</body>
</html>
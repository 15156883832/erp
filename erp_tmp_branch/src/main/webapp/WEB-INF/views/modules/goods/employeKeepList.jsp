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
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
	<!--[if IE 6]>
	<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->
	<title>工程师明细</title>
</head>
<body class="">
<div class="sfpagebg bk-gray" style="overflow: hidden">
	<div class="page-orderWait goodsPage">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKS_TAB" html='	<a class="btn-tabBar  " href="${ctx}/goods/siteself/WholeEmployeSite">工程师领取库存</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKSRECORD_TAB" html='<a class="btn-tabBar current" href="${ctx}/goods/siteGoodsKeep/empList">领取库存明细</a> '></sfTags:pagePermission>

			<p class="f-r ">
				<a href="javascript:search();" class="sfbtn sfbtn-opt "><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<form action="${ctx}/goods/siteGoodsKeep/empList" id="searchForm" method="post">
			<input type="hidden" name="page" id="pageNo" value="${page.pageNo}">
			<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
		<div class="bk-gray pt-10 pb-5">
			<table class="table table-search">
				<tr>
					<th style="width: 76px;" class="text-r">服务工程师：</th>
					<td>
						<span class="f-l w-140  readonly" >
							<select class="select  w-140" id="employs" name="employeName">
								<option value="">请选择</option>
								<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">
									<option value="${emp.columns.id }" <c:if test="${emp.columns.id==map.employeName }">selected="selected"</c:if>>${emp.columns.name }</option>
								</c:forEach>
							</select>
						</span>
					</td>
					<th style="width: 76px;" class="text-r">商品编号：</th>
					<td>
						<input type="text" class="input-text" name= "good_number" value="${map.good_number}"/>
					</td>
					<th style="width: 76px;" class="text-r">商品名称：</th>
					<td>
						<input type="text" class="input-text" name = "good_name" value="${map.good_name}"/>
					</td>
					<th style="width: 76px;" class="text-r">商品类别：</th>
					<td>
						<select class="select" name="good_category" style="width: 140px;">
							<option value="">请选择</option>
							<c:forEach items="${fns:getSiteGoodsCategoryList(siteId)}" var="ot">
								<option value="${ot.columns.name }" ${map.good_category eq ot.columns.name ?'selected':''}>${ot.columns.name }</option>
							</c:forEach>
						</select>
					</td>
					<th style="width: 76px;" class="text-r">类型：</th>
					<td>
						<select class="select" name="mxtype" style="width: 140px;">
							<option value="">请选择</option>
							<option value="1" ${map.mxtype eq '1'?'selected':''}>领用</option>
							<option value="2" ${map.mxtype eq '2'?'selected':''}>零售</option>
							<option value="3" ${map.mxtype eq '3'?'selected':''}>返还</option>
						</select>
					</td>
				</tr>
				<tr>
					<th style="width: 76px;" class="text-r">时间：</th>
					<td colspan="3">
						<input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'createTimeMax\')}'})"  id="createTimeMin" name="createTimeMin" value="${map.createTimeMin }" class="input-text Wdate w-140" >
						至
						<input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'createTimeMin\')}'})" id="createTimeMax" name="createTimeMax"  value="${map.createTimeMax }" class="input-text Wdate w-140" >
					</td>
				</tr>

			</table>
		</div>
		</form>
		<div class="pt-10 pb-5 cl btnsWrap">
			<div class="f-r">
				<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
				<sfTags:pagePermission authFlag="GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKSRECORD_EXPORTS_BTN" html='<a href="javascript:exports();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
			</div>
		</div>
		<div id="goodsTableHead">
			<table class="table table-bg ">
				<thead>
					<tr>
						<th class="w-280 text-c">商品信息</th>
						<th class="w-80 text-c">服务工程师</th>
						<th class="w-70 text-c">明细数量</th>
						<th class="w-80 text-c">入库价（元）</th>
						<!-- <th class="w-80 text-c">工程师价格</th>
						<th class="w-70 text-c">交款金额</th>
						<th class="w-100 text-c">申请人</th> -->
						<th class="w-100 text-c">操作人</th>
						<!-- <th class="w-120 text-c">订单编号</th>
						<th class="w-140 text-c">用户信息</th> -->
						<th class="w-120 text-c">订单编号</th>
						<th class="w-100 text-c">时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="mb-10" id="goodsTableWrap">
			<table class="table table-bg text-c goodsTable" style="table-layout: auto">
				<c:forEach items="${page.list}" var="orderDetails">
				<tr class="bb">
					<td class="text-l w-280">
						<div class="imgTD">
							<img src="${commonStaticImgPath}${orderDetails.columns.icon}" class="goosImg" />
							<div class=" f-l lh-22 ">
								<p class="f-13 c-005aab">${orderDetails.columns.goodName}</p>

									<p class="c-666 ">商品类别：${orderDetails.columns.goodCategory}</p>
									<p class="c-666">商品编号：${orderDetails.columns.goodNumber}</p>

								<div class="c-666">商品型号：${orderDetails.columns.goodModel}</div>
							</div>
						</div>
					</td>
					<td class="w-80">${orderDetails.columns.empName}</td>
					<td class="w-70">
						<p class="f-16">
							<strong>
								<c:if test="${orderDetails.columns.type eq '1'}"><span class="c-38a014">+${orderDetails.columns.amount}</span></c:if>
								<c:if test="${orderDetails.columns.type eq '2'}"><span class="c-fe0101">-${orderDetails.columns.amount}</span></c:if>
								<c:if test="${orderDetails.columns.type eq '3'}"><span class="c-fe0101">-${orderDetails.columns.amount}</span></c:if>
								<c:if test="${orderDetails.columns.type eq '4'}"><span class="c-38a014">+${orderDetails.columns.amount}</span></c:if>
							</strong>
						</p>
						<p>
							<c:if test="${orderDetails.columns.type eq '1'}">领用</c:if>
							<c:if test="${orderDetails.columns.type eq '2'}">零售</c:if>
							<c:if test="${orderDetails.columns.type eq '3'}">返还</c:if>
							<c:if test="${orderDetails.columns.type eq '4'}">自购</c:if>
						</p>
					</td>
					<td class="w-80" >${orderDetails.columns.site_price} </td>
					<%-- <td class="w-80" >${orderDetails.columns.employe_price} </td>
					<td class="w-70" >${orderDetails.columns.pay_money} </td>
					<td class="w-100" >${orderDetails.columns.empName}</td> --%>
					<td class="w-100" >
						<c:if test="${not empty orderDetails.columns.cnsName}">${orderDetails.columns.cnsName}</c:if>
						<c:if test="${not empty orderDetails.columns.employeName}">${orderDetails.columns.employeName}</c:if>
						<c:if test="${empty orderDetails.columns.employeName  &&  empty orderDetails.columns.cnsName}">${orderDetails.columns.siteName}</c:if>
					</td>
					<%-- <td class="w-120" >${orderDetails.columns.orderNumber} </td>
					<td class="text-l w-140">
						<p>${orderDetails.columns.customer_name}  ${orderDetails.columns.customer_contact}</p>
						<p>${orderDetails.columns.customer_address}</p>
					</td> --%>
					<td class="w-120" >
						${orderDetails.columns.orderNumber }
					</td> 
					<td class="w-100">
						<p><fmt:formatDate value="${orderDetails.columns.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
						<%-- <p><fmt:formatDate value="${orderDetails.columns.create_time}" pattern="HH:mm:ss"/></p> --%>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div class="h-30 pagination pr-10" >
			<!-- 分页 -->${page}
		</div>
	</div>
</div>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript">
    $(function(){//返还：GOODSMGM_MYGOODSMGM_EMPLOYEGIVESTOCKSRECORD_RETURNTOSITE_BTN
        $('.goodsTable').on('click','.label-cbox', function(){
            var isSelected = $(this).hasClass('label-cbox-selected');
            if(!isSelected){
                $(this).closest('.goodsTable').find('.label-cbox').removeClass('label-cbox-selected');
                $(this).closest('.goodsTable').find('input[type="radio"]').prop({'checked':'false'});
                $(this).addClass('label-cbox-selected');
                $(this).find('input[type="radio"]').prop({'checked':'true'});
            }
        })
        $("select[name='employeName']").select2();
		$(".selection").css("width","140px");

        tableHeight();
        var pageSize=${page.pageSize};
        $('.pagination .select').val(pageSize);
//		$('.lingshou').popup({fixedHeight:false});
//		$('.lydji').popup();
//		$('.ruku').popup();

    })

    window.onresize = function(){
        tableHeight();
    }

    function tableHeight(){
        var tHeight = $('.sfpagebg').height()-280;
        var tableHeight = $('#goodsTableWrap .goodsTable').height();
        $('#goodsTableWrap').css({
            'max-height':tHeight+'px',
            'overflow':'auto',
        });
        if(tableHeight > tHeight){
            $('#goodsTableHead').css({'padding-right':'17px'});
        }else{
            $('#goodsTableHead').css({'padding-right':'0px'});
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
        $("input[name='good_number']").val('');
        $("input[name='good_name']").val('');
        $("select[name='good_category']").val('');
        $("select[name='mxtype']").val('');
        $("input[name='order_number']").val('');
        $("#employs").select2('val', '请选择');
        $("#searchForm").find("input").val("");
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
                    location.href="${ctx}/goods/siteGoodsKeep/exportEmp?formPath=/a/goods/siteGoodsKeep/empList&&maps="+$("#searchForm").serialize();
                }
            });
        }else{
            location.href="${ctx}/goods/siteGoodsKeep/exportEmp?formPath=/a/goods/siteGoodsKeep/empList&&maps="+$("#searchForm").serialize();
        }

    }
    
</script>
</body>
</html>
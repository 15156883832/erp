<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
<%-- <script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script> --%>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
<style type="text/css">

		.ceshistyle_label{
			padding-right:10px;
			position:relative;
		}
		.ceshistyle_label:before{
			content:'：';
			position:absolute;
			right:0;
			top:0;
			width:10px;
			text-align:center;
			line-height:26px;
		}
		.dropdown-clear-all{
			line-height: 22px
		}
		.dropdown-option[disabled] {
		    color: #000000;
		    background-color: #fff;
		    cursor: default;
		    text-decoration: none;
		    font-weight:bold;
		    background-color:#ddd
		}
		.select2-container--default .select2-results__option[aria-disabled=true]{
			 color: #000000;
		    background-color: #fff;
		    cursor: default;
		    text-decoration: none;
		    font-weight:bold;
		    background-color:#BEBEBE
		}
		.table-bordered th, .table-bordered td {
	        border-left: none; 
		}
	</style>

<title>订单信息——公司商品订单</title>
</head>
<body class="">
	<div class="sfpagebg bk-gray" style="overflow: hidden">
		<div class="page-orderWait goodsPage">
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_SELFGOODS_TAB" html='<a class="btn-tabBar current"  href="${ctx }/goods/siteselfOrder/headerList">公司订单</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_EMPLOYEBUYORDERS_TAB" html='<a class="btn-tabBar "  href="${ctx }/goods/siteselfOrder/employeBuyBySelfOrder">工程师自购订单</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_PLATFORMGOODS_TAB" html='<a class="btn-tabBar"  href="${ctx }/goods/platFormOrder/headerList">浩泽净水订单</a> '></sfTags:pagePermission>
				<%-- <sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_MEIJIELIORDER_TAB" html='<a class="btn-tabBar"  href="${ctx }/goods/platFormOrder/headerListMjl">美洁力订单</a> '></sfTags:pagePermission> --%>
				<p class="f-r btnWrap">
					<a href="javascript:search();" class="sfbtn sfbtn-opt "><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<div class="bk-gray pt-10 pb-5 ">
				<form id="searchForm">
					<input type="hidden" name="pageNo1" id="pageNo1" value="1"> 
					<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }"> 
					<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">订单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number" value="${map.number }"/>
							</td>
							<th style="width: 76px;" class="text-r">订单状态：</th>
							<td>
								<select class="select w-140" name="status">
									<option value="">请选择</option>
									<option value="1z" <c:if test="${map.status=='1z' }">selected="selected"</c:if>>待收款</option>
									<option value="2z" <c:if test="${map.status=='2z' }">selected="selected"</c:if>>已完成</option>
									<option value="0z" <c:if test="${map.status=='0z' }">selected="selected"</c:if>>已取消</option>
								</select>
							</td>
							<th style="width: 76px;" class="text-r">销售人员：</th>
							<td id="reloadSignSpan">
								<select class="select w-140"  id="xiaoNames"   name="xiaoNames"  >
									<option value="">请选择</option>
									<option disabled class="check">网点人员</option>
							 	    <c:if test="${rd1 ne null }">
										<c:forEach items="${rd1 }" var="rd1">
											<option value="${rd1.columns.name }" <c:if test="${rd1.columns.name==map.xiaoNames }">selected="selected"</c:if>>${rd1.columns.name }</option>
										</c:forEach>
									</c:if>
								    <option disabled class="check">服务工程师</option>
								    <c:if test="${rd2 ne null }">
										<c:forEach items="${rd2 }" var="rd2">
											<option value="${rd2.columns.name }" <c:if test="${rd2.columns.name==map.xiaoNames }">selected="selected"</c:if>>${rd2.columns.name }</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName" value="${map.customerName }" />
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name = "customerMobile" value="${map.customerMobile }" />
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">商品名称：</th>
							<td>
								<input type="text" class="input-text" name = "goodName" value="${map.goodName }" />
							</td>
							<th style="width: 76px;" class="text-r">商品类别：</th>
							<td>
								<%--<input type="text" class="input-text" name = "goodCategory" value="${map.goodCategory }" />--%>
								<select class="select w-140" name="goodCategory" id="goodCategory">
									<option value="">请选择</option>
									<c:forEach var="cg" items="${categoryType}">
										<option value="${cg.columns.name }" <c:if test="${cg.columns.name==map.goodCategory }">selected="selected"</c:if>>${cg.columns.name }</option>
									</c:forEach>
								</select>
							</td>

							<th style="width: 76px;" class="text-r">下单时间：</th>
							<td colspan="3">
                                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'placingOrderTimeMax\')}'})"  id="placingOrderTimeMin" name="placingOrderTimeMin" value="${map.placingOrderTimeMin }" class="input-text Wdate w-140" >
                                至
                                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'placingOrderTimeMin\')}'})" id="placingOrderTimeMax" name="placingOrderTimeMax"  value="${map.placingOrderTimeMax }" class="input-text Wdate w-140" >
							</td>
						</tr>
						<tr class="moresearch">
							<th style="width: 76px;" class="text-r">收款时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd ',maxDate:'#F{$dp.$D(\'confirmTimeMax\')}'})"  id="confirmTimeMin" name="confirmTimeMin" value="${map.confirmTimeMin }" class="input-text Wdate w-140" >
								至
								<input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd ',minDate:'#F{$dp.$D(\'confirmTimeMin\')}'})" id="confirmTimeMax" name="confirmTimeMax"  value="${map.confirmTimeMax }" class="input-text Wdate w-140" >
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="pt-10 pb-5 cl btnsWrap">
				<div class="f-l">
					<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_SELFGOODS_CANCELORDER_BTN" html='<a onclick="return cancelOrder()" class="sfbtn sfbtn-opt" ><i class="sficon sficon-cancel"></i>取消订单</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_SELFGOODS_DETETEGOODSORDER_BTN" html='<a  onclick="return deleteOrders()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-del"></i>批量删除</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_SELFGOODS_PLPRINTORDER_BTN" html='<a href="javascript:batchPrint();" id="repeatOrder"  class="sfbtn sfbtn-opt2"><i class="sficon sficon-print"></i>批量打印</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_SELFGOODS_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</div>
			</div>
			<div class="mb-10" id="tableHead">
				<table class="table-bg goodsTable" style="table-layout:auto;">
					<thead>
						<tr class='text-c'>
							<!-- <th class="w-40"></th> -->
							<th width="300" class="text-c">商品信息</th>
							<th width="100" class="text-c">成交价</th>
							<th width="100" class="text-c">销售人员</th>
							<th width="100" class="text-c">工单编号</th>
							<th width="100" class="text-c">用户信息</th>
							<th width="100" class="text-c">下单人</th>
							<th width="100" class="text-c">下单时间</th>
							<th width="100" class="text-c">成交总额</th>
							<th width="100" class="text-c">实收金额</th>
							<th width="100" class="text-c">收款人</th>
							<th width="100" class="text-c">收款时间</th>
						</tr>
					</thead>
				</table>
			</div>
			
			
			<ul class="" id="tableBody">
				<c:forEach items="${page.list }" var="lt1">
					<li class="mb-10">
					<table class="table-border table-bordered text-c goodsTable" style="table-layout: auto;">
						<tr>
							<td colspan="13" class="c-666 bg-fafafa text-l">
								<span class="label-cbox selectOne">
									<input type="radio" name="ddId" value="${lt1.columns.id}"  />
									<input type="radio" name="ddStatus" value="${lt1.columns.status}"  />
								</span>
								<span class="pl-5">订单编号：</span> <span class="c-222 c-0e8ee7" style="cursor: pointer;" onclick="detailMsg('${lt1.columns.id}')">${lt1.columns.number }</span>
								<c:if test="${lt1.columns.status == '0' }"><span class="mr-15 f-r oState state-canceled">已取消</span></c:if>
								<c:if test="${lt1.columns.status == '1' || lt1.columns.status == '4'}"><span class="mr-15 f-r oState state-waitPay">待收款</span></c:if>
								<c:if test="${lt1.columns.status == '3' || lt1.columns.status == '2' }"><span class="mr-15 f-r oState state-finished">已完成</span></c:if>
							</td>
						</tr>
						<tr>
							<!-- 商品信息 -->
							<td width="300" style="border-left: 0;cursor: pointer;" >
								<c:forEach items="${lt1.columns.detailList }" var="dtl">
									<div class="imgTD" style="display: inline-block; width: 85%;"  onclick="showDetail('${dtl.columns.good_id}','${dtl.columns.good_name}')" >
										<img src="${commonStaticImgPath}${dtl.columns.firstIcon }" class="goosImg" />
										<div class=" f-l lh-22 ">
											<p class="f-13 c-005aab">${dtl.columns.good_name }</p>
											<div class="cl">
												<p class="f-l c-666">商品类别：${dtl.columns.good_category }</p>
											</div>
										</div>
										
									</div>
									<div class=" center lh-22" style="display: inline-block; width: 12%; vertical-align: top;">
										x${dtl.columns.purchase_num }
									</div>
								</c:forEach>
							</td>
							<!-- 成交价 -->
							<td width="100" class="" style="border-left: 0;">
								<c:forEach items="${lt1.columns.detailList }" var = "dtlt">
									<div class="imgTD" style="padding-left:0;text-align:center">
										${dtlt.columns.real_amount}
									</div>
								</c:forEach>
							</td>
							<!-- 销售人员 -->
							<td width="100" class="">
								${lt1.columns.placing_name }
							</td>
							<!-- 工单编号 -->
							<td width="100" class="" style="word-break:normal;">
								<a class="c-0e8ee7" style="cursor: pointer;" onclick="orderDetailForm('${lt1.columns.order_number }')">${lt1.columns.order_number }</a>
							</td>
							<!-- 用户信息 -->
							<td width="100" class="">
								<p>	${lt1.columns.customer_name }&nbsp;${lt1.columns.customer_contact }</p>
								<p>${lt1.columns.customer_address }</p>
							</td>
							<!-- 下单人 -->
							<td width="100" class="">
								${lt1.columns.creator}
							</td>
							<!-- 下单时间 -->
							<td width="100" class="">
								<p><fmt:formatDate value="${lt1.columns.placing_order_time}" pattern="yyyy-MM-dd"/></p>
							    <p><fmt:formatDate value="${lt1.columns.placing_order_time}" pattern="HH:mm:ss"/></p> 
							</td>
							<!-- 成交总额 -->
							<td width="100" class="">
								<c:choose> 
								    <c:when  test="${lt1.columns.real_amount==null || lt1.columns.real_amount=='' }">    
										<c:if test="${lt1.columns.ocId != null && lt1.columns.ocId != '' }">
											<span class="proofImg"><a class="c-0383dc" style="text-decoration: underline;">查看凭证</a> <img src="${commonStaticImgPath}${lt1.columns.ocImgs}" /> </span>
										</c:if>
								 	</c:when>      
								    <c:otherwise>    
										<p>${lt1.columns.real_amount}</p>
										<c:if test="${lt1.columns.ocId != null && lt1.columns.ocId != '' }">
											<span class="proofImg"><a class="c-0383dc" style="text-decoration: underline;">查看凭证</a> <img src="${commonStaticImgPath}${lt1.columns.ocImgs}" /> </span>
										</c:if>
								  	</c:otherwise> 
								</c:choose>
							</td>
							<!-- 实收金额 -->
							<td width="100" class="">
								${lt1.columns.confirm_amount}
							</td>
							<!-- 收款人 -->
							<td width="100" class="">
								${lt1.columns.confirmor}
							</td>
							<!-- 收款时间 -->
							<td width="100" class="">
								<c:choose> 
								    <c:when  test="${lt1.columns.status eq 1 || lt1.columns.status eq 4 }">    
										<p><sfTags:pagePermission authFlag="GOODSMGM_GOODSORDERMSG_SELFGOODS_GETMANEY_BTN" html='<a class="c-0e8ee7" onclick="gatheringthen(\'${lt1.columns.id}\',\'${lt1.columns.status}\')"><i class="sficon sficon-sk"></i>收款</a>'></sfTags:pagePermission></p>
								 	</c:when>      
								
								     <c:otherwise>    
										<p><fmt:formatDate value="${lt1.columns.confirm_time}" pattern="yyyy-MM-dd"/></p>
							   			<p><fmt:formatDate value="${lt1.columns.confirm_time}" pattern="HH:mm:ss"/></p>
								  	</c:otherwise> 
								</c:choose>
							</td>
						</tr>
					</table>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div class="cl pr-10">
			<div class="pagination">${page}</div>
		</div>
	</div>

<div class="popupBox qrsfBox">
	<h2 class="popupHead">
		确认收费
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pt-25 pb-20 pl-30 pr-30" >
			<p class="f-14 mb-10" id="sfNumber">订单编号：PO01714354321546546</p>
			<div class=" mb-20">
				<table class="table table-bg table-border table-bordered table-sdrk text-c" style="table-layout: auto;">
					<thead>
						<tr>
							<th class="w-420">商品图片</th>
							<th class="w-120">商品名称</th>
							<th class="w-120">商品数量</th>
						</tr>
					</thead>
					<tr>
						<td class="" id="sfImg">
							
						</td>
						<td id="sfName">漏电保护插座</td>
						<td id="sfNum">2025个</td>
					</tr>
				</table>
			</div>
			<p class="f-14 c-fe0101 mb-10" id="lrTips">温馨提示：该商品的结算方式为：按固定金额结算。</p>
			<div class="cl mb-10">
				<label class="w-100 f-l"><em class="mark">*</em> 入库价格：</label>
				<div class="f-l w-140 priceWrap readonly">
					<input type="text" class="input-text readonly" readonly="readonly" id="sfSitePrice" />
					<span class="unit">元</span>
				</div>
				<label class="w-120 f-l"><em class="mark">*</em> 工程师价格：</label>
				<div class="f-l w-140 priceWrap readonly">
					<input type="text" class="input-text readonly" readonly="readonly" id="sfEmployePrice"/>
					<span class="unit">元</span>
				</div>
				<input type="text" hidden="hidden" class="input-text w-140 f-l paixu" id="status2" name="status2"  />
				<input type="text" hidden="hidden" class="input-text w-140 f-l paixu" id="numberPlat" name="numberPlat"  />
				<input type="text" hidden="hidden" class="input-text w-140 f-l paixu" id="pNum" name="pNum"  />
				<input type="text" hidden="hidden" class="input-text w-140 f-l paixu" id="gId" name="gId"  />
				<label class="w-100 f-l"> 交款金额：</label>
				<div class="f-l w-140 priceWrap readonly">
					<input type="text" class="input-text readonly" readonly="readonly" id="realAmount" />
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="w-100 f-l"><em class="mark">*</em> 实收金额：</label>
				<div class="f-l w-140 priceWrap mustfill">
					<input type="text" class="input-text " id="confirmAmount" name="confirmAmount" />
					<input type="text" class="input-text " hidden="hidden" id="commissionsRemarks" name="commissionsRemarks" />
					<input type="text" class="input-text " hidden="hidden" id="oldCommissionsRemarks" name="oldCommissionsRemarks" />
					<span class="unit">元</span>
				</div>
				<div id="ifHasWxjsh" class="f-l">
					
				</div>
			</div>
			<div class="cl mb-10">
				<label class="w-100 f-l"> 工程师提成金额：</label>
				<div class="f-l w-140 priceWrap ">
					<input type="text" class="input-text " id="salesCommissions" />
					<span class="unit">元</span>
				</div>
				<label class="w-120 f-l"><em class="mark">*</em> 销售人员：</label>
				<span id="intHtml" class="f-l " >
					<span class="f-l w-380 dropdown-sin-2 readonly" >
						 <select class="select-box w-120 readonly"  id="xiaoName"  multiple="multiple" name="xiaoName"  style="width:140px">
						 	<option  disabled class="check">网点人员</option>
						 	<c:if test="${rd1 ne null }">
								<c:forEach items="${rd1 }" var="rd1">
									<option value="${rd1.columns.uId }">${rd1.columns.name }</option>
								</c:forEach>
							</c:if> 
							<option disabled class="check">服务工程师</option>
							<c:if test="${rd2 ne null }">
								<c:forEach items="${rd2 }" var="rd2">
									<option value="${rd2.columns.uId }">${rd2.columns.name }</option>
								</c:forEach>
							</c:if> 
						 </select>
					</span> 
				</span>
			</div>
			<div class="mb-10 cl">
				<label class="w-100 f-l">备注：</label>
				<textarea id="marks" name="marks" class="textarea f-l h-40" style="width:630px;font-size:12px;"></textarea>
			</div>
			<div class="bg-e8f2fa pt-15 pb-5 cl mb-15 xsEmployesss ">
				<label class="w-80 f-l">提成明细：</label>
				<div class="f-l w-600" id="xsEmployes">
				</div>
			</div>
			
			<div class="text-c pt-10">
				<a href="javascript:confirmGatheringthen();" class="sfbtn sfbtn-opt3 w-70 mr-5">确认收费</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 " id="btn-confirm-cancel">取消</a>
			</div>
		</div>
	</div>
</div>

<!-- 取消订单 -->
<div class="popupBox notDispatch showwxgddiv">
	<h2 class="popupHead">
		取消订单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1"><em class="mark">*</em>取消订单理由：</label>
				<textarea id="reasonofwxgd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="saveQxdd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="canQxdd()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${ctxPlugin}/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
<script type="text/javascript">
var tclrWays=""; //商品利润计算方式
var dd;//dropdown
var rId;
var ifFk;
	$(function(){
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
		tableHeight();
        var pageSize=${page.pageSize};
        $('.pagination .select').val(pageSize);
		$('.vipPrice').on('click', function(){
			$(this).closest('.vipPriceW').find('.vipPrice').removeClass('vipCur');
			$(this).addClass('vipCur');
		})
		$("select[name='goodCategory']").select2();
		$("select[name='placingOrderBy']").select2();
		$("select[name='xiaoNames']").select2();
		$(".selection").css("width","140px");
		$('.proofImg').imgShow();
		
		/* $('.dropdown-sin-2').dropdown({
	        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
	        choice: function() {
	        }
	    }); */
		//$(".qrsfBox").popup();
	})
	
	$('#tableBody .label-cbox').on('click', function(){
		var flag = $(this).hasClass('label-cbox-selected');
		if(flag){
			$(this).removeClass('label-cbox-selected');
		}else{
			$(this).addClass('label-cbox-selected');
		}
	})
	
	window.onresize = function(){
		tableHeight();
	}
	function tableHeight(){
		var wHeight = $('.sfpagebg').height() - 310;
		var contHeight = $('#tableBody').height();

		$('#tableBody').css({
			'max-height':wHeight+'px',
			'overflow':'auto',
		});
		
		var tWidth = $('#tableBody').find('.table').eq(0).width();
		$('#tableHead').width(tWidth);
	}
	
	
	//条件查询w
	function search() {
		$('#pageNo').val('1');
		window.location.href="${ctx}/goods/siteselfOrder/headerList?map="+$("#searchForm").serialize();
		return;
	}
	
	//分页信息，点击查询
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		window.location.href="${ctx}/goods/siteselfOrder/headerList?map="+$("#searchForm").serialize();
		return;
	}
	
	//重置
	function reset(){
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
		$("input[name='goodName']").val('');
		$("input[name='number']").val('');
		$("input[name='placingOrderBy']").val('');
		$("input[name='customerName']").val('');
		$("input[name='customerMobile']").val('');
		$("select[name='status']").val('');
		$("#searchCategory").select2('val', '请选择');
		$("#searchPlacingOrderBy").select2('val', '请选择');
		$("#xiaoNames").select2('val', '请选择');
        $("#goodCategory").select2('val', '请选择');
		$("#searchForm").find("input").val("");
		/*$("#placingOrderTimeMin").val("");
		$("#placingOrderTimeMax").val("");
		$("#confirmTimeMin").val("");
		$("#confirmTimeMax").val("");*/
        //$("#xsEmployes").empty();

    }

	var idsArr = '';
	function gatheringthen(rowId,stat){ //列表中点击收款操作
		layer.open({
			type : 2,
			content:"${ctx}/goods/siteselfOrder/receivablesOrder?rowId="+rowId ,
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			fadeIn:0,
			anim:-1
		});
	return 
		
		/* $.closeDiv($(".sporderdetail"));
		$('#confirmGatheringbox').empty(); */
		$.ajax({
			type:"POST",
			url:"${ctx}/goods/siteselfOrder/queryByIdMoney",
			data:{rowId:rowId},
			//dataType:'json',
			success:function(data){
				var result = data.gsd;
				var salesSet = data.salesSet;
				var emIds = result.columns.placing_order_by;//工程师ids
				var emNames = result.columns.placing_name;//工程师names
				idsArr = emIds;
				var num = result.columns.purchase_num;//购买数量
				var allTch = result.columns.sales_commissions;//总的销售提成
				var tcfs = result.columns.deduct_type;//提成方式
				var reAmount = result.columns.real_amount;//实收金额
				var rkPrice = result.columns.site_price;//入库价格
				var empPrice = result.columns.employe_price;//工程师价格
				if($.trim(empPrice)=='' || empPrice==null){
					empPrice=0;
				}
				$("#commissionsRemarks").val(result.columns.commissions_remarks);
				$("#oldCommissionsRemarks").val(result.columns.commissions_remarks);
				var tcbl = result.columns.ratio_deduct_val;//提成比列
				var ids = [];
				var names = [];
				var empHtml = '';
				
				if(emIds != "" && emNames != ""){
					ids = emIds.split(",");
					names = emNames.split(",");
					var moneyTch = '0';
					moneyTch = (allTch/ids.length).toFixed(2);//每个工程师的提成金额
					for(var i=0;i<ids.length;i++){
					 	empHtml+='<div class="f-l mb-10 mr-15 ceshistyle">'+
					    	'<label class="nameTag w-90 f-l ceshistyle_label" title="'+names[i]+'">'+names[i]+'</label>'+
					    	'<div class="priceWrap f-l bg-fff w-80">'+
								'<input type="text" class="input-text " name="oneTch" value="'+moneyTch+'" />'+
								'<input type="text" class="input-text " hidden="hidden" name="oneTchIds" value="'+ids[i]+'" />'+
								'<span class="unit">元</span>'+
				    		'</div>'+
			    		'</div>'
					} 
				}
				$("#xsEmployes").empty();
				$("#xsEmployes").append(empHtml);
				$("#intHtml").empty();
				$("#intHtml").append('<span class="f-l w-370 dropdown-sin-2 readonly" >'+
								' <select class="select-box w-120 readonly"  id="xiaoName"  multiple="multiple" name="xiaoName"  style="width:140px">'+
								'<option disabled>网点人员</option>'+
								 '<c:if test="${rd1 ne null }">'+
									'<c:forEach items="${rd1 }" var="rd1">'+
										'<option value="${rd1.columns.uId }">${rd1.columns.name }</option>'+
									'</c:forEach>'+
								 '</c:if>'+
								 '<option disabled>服务工程师</option>'+
								 '<c:if test="${rd2 ne null }">'+
									'<c:forEach items="${rd2 }" var="rd2">'+
										'<option value="${rd2.columns.uId }">${rd2.columns.name }</option>'+
									'</c:forEach>'+
								 '</c:if>'+
								'</select>'+
							'</span> ');
				//qrsfBox
				if(!isBlank(result.columns.good_icon)){
					var imgHtml = "";
					for(var i=0;i<result.columns.good_icon.split(',').length;i++){
						imgHtml+='<img src="${commonStaticImgPath}'+result.columns.good_icon.split(',')[i]+'"  class="goosImg" />';
					}
					$("#sfImg").empty();
					$("#sfImg").append(imgHtml);
				}
				$("#sfName").text(result.columns.good_name);
				$("#sfNumber").text("订单编号："+result.columns.number);
				$("#sfNum").text(result.columns.purchase_num+result.columns.unit);//
				$("#sfSitePrice").val(rkPrice*num);
				$("#sfEmployePrice").val(empPrice*num);
				$("#confirmAmount").val(result.columns.real_amount);
				$("#realAmount").val(result.columns.real_amount);
				$("#salesCommissions").val(result.columns.sales_commissions);
				var zfId = result.columns.zfId;
				var zxHtml = '';
				if(!isBlank(zfId)){
					var zfType = result.columns.zfType;
					zxHtml = '<label class="w-120 f-l"> 无现金收款：</label><span class="c-fe0101 lh-26">'+
								(zfType=='0' ? '支付宝' : '微信')+'</span><span class="lh-26 pr-5">'+result.columns.zfMoney+
								'</span><a class="c-0383dc proofImg"><i class="sficon sficon-view"></i>查看凭证 <img src="${commonStaticImgPath}'+result.columns.zfImg+'" /> </a>';
				}
				$("#ifHasWxjsh").empty();
				$("#ifHasWxjsh").append(zxHtml);
				$('.proofImg').imgShow({hasIframe:true});
				$("#status2").val(result.columns.status);
				$("#numberPlat").val(result.columns.number);
				$("#pNum").val(result.columns.purchase_num);
				$("#gId").val(result.columns.good_id);
				$("#marks").val(result.columns.pay_mark);
				
				var tcwenzi = '按固定金额结算';
				if(result.columns.deduct_type == "2"){
					tcwenzi = '按利润比列提成（利润 = 实收金额 - 入库价格）';
					if(salesSet!=null && $.trim(salesSet)!= ""){
						tclrWays = salesSet.columns.set_value;
						if(salesSet.columns.set_value=='2'){
							tcwenzi = '按利润比列提成（利润 = 实收金额 - 工程师价格）';
						}
						if(salesSet.columns.set_value=='3'){
							tcwenzi = '按利润比列提成（利润 = 实收金额）';
						}
					}
				}
				$("#lrTips").text("温馨提示：该商品的结算方式为："+tcwenzi);
				
				dd = $('.dropdown-sin-2').dropdown({
			        // data: json2.data,
			        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
			        choice: function() {
			        }
			    }).data("dropdown");
				$('.dropdown-sin-2').bind('click', function(){ 
					chagesSty();
				})
				if($.trim(emIds)!="" && emIds!=null){
					dd.choose(emIds.split(","), true);
				}
				rId=rowId;
				$('.qrsfBox').popup();
				$("#confirmAmount").blur(function(){
					var confirmAt = $("#confirmAmount").val();
					var moneyTch = '0';
					if(tcfs=="2"){
						moneyTch = ((confirmAt-rkPrice*num)*tcbl*0.01).toFixed(2);
						var sassionMarks ="比例提成（(实收金额-入库价格)*比列系数*0.01），本次提成："+"("+confirmAt+"-"+rkPrice+"*"+num+")*"+tcbl+"*0.01="+moneyTch+"元";
						if(tclrWays=='2'){
							moneyTch = ((confirmAt-empPrice*num)*tcbl*0.01).toFixed(2);
							sassionMarks = "比例提成（(实收金额-工程师价格)*比列系数*0.01），本次提成："+"("+confirmAt+"-"+empPrice+"*"+num+")*"+tcbl+"*0.01="+moneyTch+"元";
						}
						if(tclrWays=='3'){
							moneyTch = ((confirmAt)*tcbl*0.01).toFixed(2);
							sassionMarks = "比例提成（实收金额*比列系数*0.01），本次提成："+confirmAt+"*"+tcbl+"*0.01="+moneyTch+"元";
						}
						commissionsRemarks = sassionMarks;
						$("#salesCommissions").val(moneyTch);
						if( $(".xsEmployesss input[name='oneTch']").length>0){
							$(".xsEmployesss input[name='oneTch']").each(function(index,el){
								$(this).attr('value',(moneyTch/ $(".xsEmployesss input[name='oneTch']").length).toFixed(2));
							});
						}
					}
				})
				
				$("#salesCommissions").blur(function(){
					var tcAll = $("#salesCommissions").val();
					if( $(".xsEmployesss input[name='oneTch']").length>0){
						$(".xsEmployesss input[name='oneTch']").each(function(index,el){
							$(this).attr('value',(tcAll/$(".xsEmployesss input[name='oneTch']").length).toFixed(2));
						});
					}
				})
				 
				$(".xsEmployesss input[name='oneTch']").blur(function(){
					var allOneTch = 0;
					var oneTch = '';
					var everyMark = "0";
					$(".xsEmployesss input[name='oneTch']").each(function(index,el){
						var elValue = $(el).val();
						if($.trim(elValue)=="" || elValue==undefined ){
							elValue=0;
						}
						if(!checkMoney(elValue)){
							everyMark = "1";
							return;
						}
						allOneTch=parseFloat(allOneTch)+parseFloat(elValue);
						if(oneTch==''){
							oneTch=elValue;
						}else{
							oneTch=oneTch+","+elValue;
						}
					})
					if(everyMark=="1"){
						layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
						return;
					}
					$("#salesCommissions").val(allOneTch.toFixed(2));
				})
				$("#confirmAmount").change(function(){
					var confirmAt = $("#confirmAmount").val();
					var moneyTch = '0';
					if(tcfs=="2"){
						moneyTch = ((confirmAt-rkPrice*num)*tcbl*0.01).toFixed(2);
						var sassionMarks ="比例提成（(实收金额-入库价格)*比列系数*0.01），本次提成："+"("+confirmAt+"-"+rkPrice+"*"+num+")*"+tcbl+"*0.01="+moneyTch+"元";
						if(tclrWays=='2'){
							moneyTch = ((confirmAt-empPrice*num)*tcbl*0.01).toFixed(2);
							sassionMarks = "比例提成（(实收金额-工程师价格)*比列系数*0.01），本次提成："+"("+confirmAt+"-"+empPrice+"*"+num+")*"+tcbl+"*0.01="+moneyTch+"元";
						}
						if(tclrWays=='3'){
							moneyTch = ((confirmAt)*tcbl*0.01).toFixed(2);
							sassionMarks = "比例提成（实收金额*比列系数*0.01），本次提成："+confirmAt+"*"+tcbl+"*0.01="+moneyTch+"元";
						}
						$("#commissionsRemarks").val(sassionMarks);
						//alert($("#commissionsRemarks").val());
					}
				}) ;
		$("#salesCommissions").change(function(){
			var tcAll = $("#salesCommissions").val();
			$("#commissionsRemarks").val("手动调整提成金额， 本次提成："+tcAll+"元");
			//alert($("#commissionsRemarks").val());
		});
		$(".xsEmployesss input[name='oneTch']").change(function(){
			var allOneTch = 0;
			var oneTch = '';
			var everyMark = "0";
			$(".xsEmployesss input[name='oneTch']").each(function(index,el){
				var elValue = $(el).val();
				if($.trim(elValue)=="" || elValue==undefined ){
					elValue=0;
				}
				if(!checkMoney(elValue)){
					everyMark = "1";
					return;
				}
				allOneTch=parseFloat(allOneTch)+parseFloat(elValue);
				if(oneTch==''){
					oneTch=elValue;
				}else{
					oneTch=oneTch+","+elValue;
				}
			})
			if(everyMark=="1"){
				//layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
				return;
			}
			$("#commissionsRemarks").val("手动调整提成金额， 本次提成："+allOneTch.toFixed(2)+"元");
			//alert($("#commissionsRemarks").val());
		})
			}
		});
	}

	$('#btn-confirm-cancel').on('click', function() { //点击取消 关闭付款弹出框
		$.closeDiv($('.qrsfBox'));
	});

	$('#guanbi').on('click', function() { //点击关闭 关闭确认出库弹出框
		$.closeDiv($('.spqrck'));
	});
	
	function quxiao(){ //点击取消 关闭订单详情弹出框
		$.closeDiv($('.sporderdetail'));
	}

	function quxiao1(){ //点击取消 关闭订单详情弹出框
		$.closeDiv($('.sporderdetail'));
	}

	function check(number) {
		var re = /^\d+(?=\.{0,1}\d+$|$)/
		if (!re.test(number)) {
			return false;
		}
		return true;
	}
	
	function checkMoney(mny){
		var reg = /^[1-9]{1}\d*(.\d{1,2})?$|^0.\d{1,2}$/;
		if(parseFloat(mny) == parseFloat(0)){
			return true;
		}else{
			if(reg.test(mny)){
				return true;
			}
		}
		return false;
	}

	var adpoting = false;
	function confirmGatheringthen(){ //点击确认收款按钮执行收费过程
		if(adpoting) {
			return;
		}
		var status = $("#status2").val();
		var marks = $("#marks").val();
		var confirmAmount = $("#confirmAmount").val();
		var salesCommissions = $("#salesCommissions").val();
		var newMsg = $("#commissionsRemarks").val();
		var oldMsg = $("#oldCommissionsRemarks").val();
		var finalMsg = newMsg;
		if(!isBlank(newMsg) || !isBlank(oldMsg)){
			if(newMsg!=oldMsg){
				finalMsg = "现在的提成方式为："+newMsg+"；原提成方式为："+oldMsg;
			}
		}
		var allOneTch = 0;
		var oneTch = '';
		var everyMark = "0";
		$("input[name='oneTch']").each(function(index,el){
			var elValue = $(el).val();
			if($.trim(elValue)=="" || elValue==undefined ){
				elValue=0;
			}
			if(!checkMoney(elValue)){
				everyMark = "1";
				return;
			}
			allOneTch=parseFloat(allOneTch)+parseFloat(elValue);
			if(oneTch==''){
				oneTch=elValue;
			}else{
				oneTch=oneTch+","+elValue;
			}
		})
		if(everyMark=="1"){
			layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
			return;
		}
		var idAs = $("#xiaoName").val();
		var idArrs="";
		for(var i=0;i<idAs.length;i++){
			if(idArrs==""){
				idArrs=idAs[i];
			}else{
				idArrs=idArrs+","+idAs[i];
			}
		}
		var nameArrs = $(".dropdown-display").attr("title");
	    var pNum = $("#pNum").val();
		var gId = $("#gId").val();
		if($.trim(salesCommissions)!=""  && salesCommissions!=null ){
			if(check(salesCommissions)==false){
				layer.msg("工程师提成金额输入格式不正确！");
				$("#salesCommissions").focus();
				return;
			} 
		}
		if(isBlank(confirmAmount)){
			layer.msg("实收金额不能为空！");
			$("#confirmAmount").focus();
		}else if(check(confirmAmount)==false){
			layer.msg("实收金额输入格式不正确！");
			$("#confirmAmount").focus();
		} else{
			adpoting = true;
			$.ajax({
				type: "POST",
				url: "${ctx}/goods/siteselfOrder/confirmAmount",
				data: {
					rowId: rId,
					confirmAmount: confirmAmount,
					status: status,
					pNum: pNum,
					gId: gId,
					salesCommissions:salesCommissions,
					oneTch:oneTch,
					idsArr:idArrs,
					nameArrs:nameArrs,
					marks:marks, 
					commissionsRemarks:finalMsg
				},
				dataType: 'json',
				success: function (result) {
					if (result == '200') {
						layer.msg("确认收款成功！");
						//window.location.reload(true);
						search();
						$.closeDiv($(".qrsfBox"));
					} else if(result == '420'){
						layer.msg("订单信息有误，确认收款失败！");
					}else {
						$('body').popup({
							level: '3',
							type: 1,
							content: "确认收款失败，请检查！"
						})
					}
				},
				complete: function() {
					adpoting = false;
				}
			});
		} 
	}

	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}

	function detailMsg(rowId){ //订单详情
		var href="${ctx}/goods/siteselfOrder/toGoodsOrderDetailPage?id="+rowId+"&mark=zy";
		updateOrCreate("订单详情",href);
	}

	function outStockDetail(rowId,stats){ //点击出库，查出出库弹出框的展示信息
		$.ajax({
			type:"POST",
			url:"${ctx}/goods/siteselfOrder/detailMsg",
			data:{rowId:rowId},
			dataType:'json',
			success:function(result){
				$("#ckNumber").text(result.columns.number);
				$("#ckCategory").text("商品类别："+result.columns.good_category);
				$("#ckGoodNumber").text("商品编号："+result.columns.good_number);
				$("#ckGoodName").text(result.columns.good_name);
				$("#ckPlacingName").text(result.columns.creator);
				$("#ckCustomerName").text("用户姓名："+result.columns.customer_name);
				$("#ckCustomerMobile").text("联系方式："+result.columns.customer_contact);
				$("#ckCustomerAddress").text("详细地址："+result.columns.customer_address);
				$("#id1").val(result.columns.id);
				$("#goodId1").val(result.columns.good_id);
				$("#purchaseNum1").val(result.columns.purchase_num);
				$("#stocks1").val(result.columns.stocks);
				$("#ckPurchaseNum").text(result.columns.purchase_num+result.columns.unit);
				$("#ckRealAmount").text(result.columns.real_amount);
				var status = result.columns.status;
				var ckStatuss = '<span class="oState state-dskdck">待收款待出库</span>';
				if(status=='0'){
					ckStatuss = '<span class="oState state-canceled">已取消</span>';
				}
				if(status=='2'){
					ckStatuss = '<span class="oState state-waitCk">已收款待出库</span>';
				}
				if(status=='3'){
					ckStatuss = '<span class="oState state-finished">已完成</span>';
				}
				if(status=='4'){
					ckStatuss = '<span class="oState state-waitPay">待收款已出库</span>';
				}
				$("#ckStatus").empty();
				$("#ckStatus").append(ckStatuss);
				if(!isBlank(result.columns.good_icon)){
					$("#ckImg").attr("src",'${commonStaticImgPath}'+result.columns.good_icon.split(',')[0]);
				}
				
				$('.qrckBox').popup();
			}
		})
	}
	var adpotin = false;
	function outStockConfirm(){ //点击确认出库按钮执行出库操作
		if(adpotin) {
			return;
		}
		var id1=$("#id1").val();
		var goodId1=$("#goodId1").val();
		var purchaseNum1=$("#purchaseNum1").val();
		var stocks = $("#stocks1").val();
		if(parseFloat(purchaseNum1)>parseFloat(stocks)){
			layer.msg("公司库存不足！");
		}else{
			adpotin = true;
			$.ajax({
				type:"POST",
				url:"${ctx}/goods/siteselfOrder/outStock",
				data:{rowId:id1,
					goodId:goodId1,
					purchaseNum:purchaseNum1},
				success:function(result){
					if(result=="ok"){
						layer.msg("出库成功！");
						//window.location.reload(true);
						search();
						$.closeDiv($(".spqrck"));
					}else if(result=="yck"){
						layer.msg("该商品已出库！");
						return;
					}else if(result=="yxj"){
						layer.msg("商品信息有误！");
						return;
					}else{
						layer.msg("出库失败，请检查！");
						return;
					}
				},
				complete: function() {
					adpotin = false;
				}
			})
		}
	}

	function exports(){
		var idArr='${page.count}';
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				fnConfirm :function(){
					location.href="${ctx}/goods/siteselfOrder/export?formPath=/a/goods/siteselfOrder/headerList&&maps="+$("#searchForm").serialize();
				}

			});
		}else{
			location.href="${ctx}/goods/siteselfOrder/export?formPath=/a/goods/siteselfOrder/headerList&&maps="+$("#searchForm").serialize();
		}

	}
	
	function chagesSty(){
		var xName = $('#xiaoName').val();
		if($.trim(xName) != "" && xName != null && xName != undefined ){
		    var nameArr = $("#intHtml").find(".dropdown-display").attr("title").split(',');
		    var html = '';
		    var tije = $("#salesCommissions").val();//总的提成金额
		    if(tije==null || $.trim(tije) == "") {
		    		tije=0;
		    }
		    if(!checkMoney(tije)){
		    	layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
		    	$("#salesCommissions").focus();
		    	return;
		    }
		    var dgtije = (tije/xName.length).toFixed(2);//单个工程师提成金额
		    for(var i=0;i<xName.length;i++){
		    	html+='<div class="f-l mb-10 mr-15 ceshistyle">'+
				    	'<label class="nameTag w-90 f-l ceshistyle_label" title="'+ nameArr[i] +'">'+nameArr[i]+'</label>'+
				    	'<div class="priceWrap f-l bg-fff w-80">'+
						'<input type="text" class="input-text " name="oneTch" value="'+dgtije+'" />'+
						'<input type="text" class="input-text " hidden="hidden" name="oneTchIds" value="'+xName[i]+'" />'+
						'<span class="unit">元</span>'+
			    		'</div>'+
	    		'</div>'
		    }
	    }
		$("#xsEmployes").empty();
	    $("#xsEmployes").append(html);
	    $(".xsEmployesss input[name='oneTch']").blur(function(){
			var allOneTch = 0;
			var oneTch = '';
			var everyMark = "0";
			$(".xsEmployesss input[name='oneTch']").each(function(index,el){
				var elValue = $(el).val();
				if($.trim(elValue)=="" || elValue==undefined ){
					elValue=0;
				}
				if(!checkMoney(elValue)){
					everyMark = "1";
					return;
				}
				allOneTch=parseFloat(allOneTch)+parseFloat(elValue);
				if(oneTch==''){
					oneTch=elValue;
				}else{
					oneTch=oneTch+","+elValue;
				}
			})
			if(everyMark=="1"){
				layer.msg("工程师提成金额要求大于等于0且最多只能够有两位小数");
				return;
			}
			$("#salesCommissions").val(allOneTch.toFixed(2));
		})
	}
	
	//取消订单
	function cancelOrder(){
		var ifselt = $(".label-cbox-selected");
		if(!$(".selectOne").hasClass("label-cbox-selected")){
			layer.msg("请选择数据！");
			return;
		};
		var idSelect = $(".label-cbox-selected");
		
		var idsSelt='';
		var statusSelt = '';
		idSelect.each(function(ind,el){
			if(idsSelt==''){
				idsSelt=$(el).find("input[name='ddId']").val();
			}else{
				idsSelt=idsSelt+","+$(el).find("input[name='ddId']").val();
			}
			if(statusSelt==''){
				statusSelt=$(el).find("input[name='ddStatus']").val();
			}else{
				statusSelt=statusSelt+","+$(el).find("input[name='ddStatus']").val();
			}
			
		})
		var idArr=idsSelt.split(',');
		var statusArr=statusSelt.split(',');
		var yxIds='';
		for(var i=0;i<statusArr.length;i++){
			if(statusArr[i]!='0'){
				if(yxIds==''){
					yxIds="'"+idArr[i]+"'";
				}else{
					yxIds=yxIds+",'"+idArr[i]+"'";
				}
			}
		}
		if(yxIds==''){
			layer.msg("您选择的商品订单已取消！");
			return;
		}
		var msg = '您选择的'+idArr.length+'条订单中有' + yxIds.split(",").length  + '条未取消，您确定要取消吗？';
		if(yxIds.split(",").length == idArr.length){
			msg='您确定要取消这'+yxIds.split(",").length+'条商品订单吗？';
		}
		$('body').popup({
			level: '3',
			type:2,  // 提示是否进行某种操作
			closeSelfOnly: true,
			content: msg,
			fnConfirm: function () {
				$('.showwxgddiv').popup();
				
			}
		}) 
	}
	
	var markQx = false;
	function saveQxdd(){
		if(markQx){
			return;
		}
		var reason = $("#reasonofwxgd").val();
		if($.trim(reason)=='' || reason==null || reason==undefined){
			layer.msg("请填写取消原因！");
			$("#reasonofwxgd").focus();
			return;
		}
		var ifselt = $(".label-cbox-selected");
		if(!$(".selectOne").hasClass("label-cbox-selected")){
			layer.msg("请选择数据！");
			return;
		};
		var idSelect = $(".label-cbox-selected");
		var idsSelt='';
		var statusSelt = '';
		idSelect.each(function(ind,el){
			if(idsSelt==''){
				idsSelt=$(el).find("input[name='ddId']").val();
			}else{
				idsSelt=idsSelt+","+$(el).find("input[name='ddId']").val();
			}
			if(statusSelt==''){
				statusSelt=$(el).find("input[name='ddStatus']").val();
			}else{
				statusSelt=statusSelt+","+$(el).find("input[name='ddStatus']").val();
			}
		})
		var idArr=idsSelt.split(',');
		var statusArr=statusSelt.split(',');
		var yxIds='';
		for(var i=0;i<statusArr.length;i++){
			if(statusArr[i]!='0'){
				if(yxIds==''){
					yxIds="'"+idArr[i]+"'";
				}else{
					yxIds=yxIds+",'"+idArr[i]+"'";
				}
			}
		}
		if(yxIds==''){
			layer.msg("您选择的商品订单已取消！");
			return;
		}
		markQx = true;
		$.ajax({
			type:"post",
			url:"${ctx}/goods/siteselfOrder/cancelGoodsOrder",
			data:{yxIds:yxIds,
				reason:reason},
			success:function(data){
				if(data.code=="200"){
					layer.msg("取消成功！");
					$("#reasonofwxgd").val('');
					$.closeDiv($('.showwxgddiv'));
					search();
					markQx=false;
				}else{
					layer.msg("取消失败，请联系管理员！");
					markQx=false;
					return;
				}
			}
		})
	}
	
	function canQxdd(){
		$.closeDiv($('.showwxgddiv'));
	}
	function getDate(tm) {
		if($.trim(tm)=="" || tm==null){
			return "";
		}
		return new Date(parseInt(tm) ).toLocaleString().replace(/:\d{1,2}$/,' '); 
	}
	
	//商品详情
	 function showDetail(id,name){
		$.ajax({
			type:"post",
			data:{},
			url:"${ctx}/goods/siteself/checkGoodsIfExist?id="+id,
			success:function(data){
				if(data=='420'){
					layer.msg("该商品已被删除，无法查看详情！");
				}else if(data=='200'){
					var href="${ctx}/goods/siteself/showDetail?id="+id+"&jp=o1";
					updateOrCreate(name,href);
				}else{
					layer.msg("未知错误，请稍后重试！");
				}
				return;
			}
		})
	 }
	
	 function updateOrCreate(name,href){
	     var bStop = false;
	     var bStopIndex = 1;
	     var show_navLi = $('#min_title_list li',window.top.document);
	     show_navLi.each(function () {
	         $(this).removeClass('active');
	         if ($(this).find('span').text() ==$.trim(name)) {
	             bStopIndex = show_navLi.index($(this));
	             bStop = true;
	         }
	     });
	     if (!bStop) {
	         creatIframe(href, name);
	     } else {
	         show_navLi.eq(bStopIndex).addClass('active');
	         $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).show().find('iframe').attr({'src': href,});
	     }
	 }
	 
	 function deleteOrders(){
		var ifselt = $(".label-cbox-selected");
		if(!$(".selectOne").hasClass("label-cbox-selected")){
			layer.msg("请选择数据！");
			return;
		};
		var idSelect = $(".label-cbox-selected");
		
		var idsSelt='';
		var idsSeltAll='';
		idSelect.each(function(ind,el){
			var seleteId = $(el).find("input[name='ddId']").val();
			var selectStatus = $(el).find("input[name='ddStatus']").val();
			if(selectStatus=='0'){
				if(idsSelt==''){
					idsSelt=$(el).find("input[name='ddId']").val();
				}else{
					idsSelt=idsSelt+","+$(el).find("input[name='ddId']").val();
				}
			}
			if(idsSeltAll==''){
				idsSeltAll=$(el).find("input[name='ddId']").val();
			}else{
				idsSeltAll=idsSeltAll+","+$(el).find("input[name='ddId']").val();
			}
		})
		if(isBlank(idsSelt)){
			layer.msg("您选择的订单中没有可删除的订单，请重新选择！");
			return ;
		}
		var idsSeltArr = idsSelt.split(",");
		var idsSeltAllArr = idsSeltAll.split(",");
		$('body').popup({
			level: '3',
			type:2,  // 提示是否进行某种操作
			closeSelfOnly: true,
			content: "您选择的"+idsSeltAllArr.length+"订单中有"+idsSeltArr.length+"条可以删除，您确定要删除吗？",
			fnConfirm: function () {
				$.ajax({
					type:"post",
					url:"${ctx}/goods/siteselfOrder/deleteGoodsOrders",
					data:{ids:idsSelt},
					success:function(result){
						if(result=='200'){
							layer.msg("删除成功");
							search();
							return ;
						}else{
							layer.msg("删除失败，请检查！");
							return;
						}
					}
				})
			}
		}) 
			
	 }
	 
	 //批量打印商品订单
	 function batchPrint(){
		var ifselt = $(".label-cbox-selected");
		if(!$(".selectOne").hasClass("label-cbox-selected")){
			layer.msg("请选择您要打印的订单！");
			return;
		};
		var idSelect = $(".label-cbox-selected");
		var idsArr = [];
		idSelect.each(function(ind,el){
			idsArr.push($(el).find("input[name='ddId']").val());
		})
		var ids = idsArr.join(",");
		window.open("${ctx}/goods/siteselfOrder/printGoodsOrder?ids="+ids);
	 }
	 
	 function orderDetailForm(orderNumber){
		layer.open({
			type : 2,
			content:"${ctx}/order/orderDispatch/orderDetailForm?orderNo="+orderNumber+"&migration=",
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
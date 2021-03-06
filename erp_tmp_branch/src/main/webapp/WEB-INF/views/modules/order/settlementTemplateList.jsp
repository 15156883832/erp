﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<title>结算模板设置</title>

<script type="text/javascript"
	src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<style type="text/css">
.Validform_error, input.error, select.error {
	background-color: #fbe2e2;
	border-color: #c66161;
	color: #c00;
}
</style>

</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<form id="searchForm"
					action="${ctx}/order/settlementTemplate/list" method="post">
					<input type="hidden" id="pageNo" name="page"
						value="${page.pageNo }"> <input type="hidden"
						id="pageSize" name="rows" value="${page.pageSize }"> <input
						type="hidden" name="category" value="${cateId}" id="categroyId">
					<div class="tabBar cl mb-10">
						<sfTags:pagePermission authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_TAB" html='<a class="btn-tabBar  current" href="javascript:;">结算方案设置</a>'></sfTags:pagePermission>
							<%--<a class="btn-tabBar " href="${ctx}/order/commonsetting/settingvalue">结算显示设置</a>--%>
							<sfTags:pagePermission authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_CONDITIONS_TAB" html='<a class="btn-tabBar " href="${ctx}/order/commonsetting/conditionsSet">结算条件设置</a>'></sfTags:pagePermission>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a> <a href="javascript:;"
								class="sfbtn sfbtn-opt" onclick="reset()"><i class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="bk-gray pt-10 pb-10 pl-5 pr-10">
						<label class="w-70">结算措施：</label> <input type="text"
							class="input-text w-140" id="servicemeasures" value="${sms }" />
					</div>
				</form>
				<div class="tabBarP mt-15 pos-r h-30 pr-80" id="tabBarP">
					<ul class="tabswitch_list" id="tabswitch_list" style="left:${pos};">
						<c:forEach items="${catelist }" var="cates">
							<c:if test="${cates.id eq cateId}">
								<li onclick="toNav('${ctx }/order/settlementTemplate/getlist?categroy=${cates.id }')"><a class="tabswitch current" id="tabswitchCurrent"
																														 href="#">${cates.name }</a></li>
							</c:if>
							<c:if test="${cates.id != cateId}">
								<li onclick="toNav('${ctx }/order/settlementTemplate/getlist?categroy=${cates.id }')"><a class="tabswitch"
																														 href="#">${cates.name }</a></li>
							</c:if>
						</c:forEach>
					</ul>

					<div class="tabswitch_more hide" id="tabswitch_more">
						<a id="tabswitch-prev" class="btn_tabswitchmore c-888"
							href="javascript:;"><i class="Hui-iconfont f-18">&#xe6d4;</i></a>
						<a id="tabswitch-next" class="btn_tabswitchmore c-888"
							href="javascript:;"><i class="Hui-iconfont f-18">&#xe6d7;</i></a>
					</div>
				</div>
				<div class="mt-10">
					<sfTags:pagePermission
						authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_ADD_BTN"
						html='<a href="javascript:;" class="sfbtn sfbtn-opt" id="btn-add"><i class="sficon sficon-add"></i>新增</a>'></sfTags:pagePermission>

					<sfTags:pagePermission
						authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_EDITE_BTN"
						html='<a href="javascript:;" class="sfbtn sfbtn-opt" id="btn-upda"><i class="sficon sficon-edit2"></i>修改</a>'></sfTags:pagePermission>

					<sfTags:pagePermission
						authFlag="SYSSETTLE_SETTLEMENTTEMP_SETTLEMENT_DELETE_BTN"
						html='<a href="javascript:;" class="sfbtn sfbtn-opt" id="btn-dele"><i class="sficon sficon-rubbish"></i>删除</a>'></sfTags:pagePermission>
				</div>
				<div class="tableWrap mt-10 text-c">
					<table
						class="table table-bg table-border table-bordered table-sdrk"
						style="table-layout: fixed;">
						<thead>
							<tr class="text-c">
								<th width="10%">选择</th>
								<th width="30%">结算措施</th>
								<th width="20%">结算项</th>
								<th width="20%">结算依据</th>
								<th width="20%">结算方式</th>
							</tr>
						</thead>
						<c:forEach items="${page.list }" var="item" varStatus="sta">
							<tr>
								<td class="text-c"><label class="radiobox"
									for="gzlbs${sta.count }"> <c:forEach items="${item}"
											var="item1">
											<input type="radio" id="gzlb${sta.count }" name="chk_trb"
												value="${item1.key}">
										</c:forEach>
								</label></td>

								<td><c:forEach items="${item}" var="item1">
						${item1.key}
						</c:forEach></td>

								<td class="no-pd"><c:forEach items="${item}" var="item2">
										<c:forEach items="${item2.value}" var="mal">
											<div class="bb h-30 pd-5" title="${mal.chargeName}">
												${mal.chargeName }</div>
											<input type="hidden" value="${mal.id}">
										</c:forEach>
									</c:forEach></td>
								<td class="no-pd"><c:forEach items="${item}" var="item2">
										<c:forEach items="${item2.value}" var="mal">
											<div class="bb h-30 pd-5" title="${mal.basisType}">
												<c:if test="${mal.basisType eq '0'}">${mal.basisAmount }</c:if>
												<c:if test="${mal.basisType eq '1'}">服务费</c:if>
												<c:if test="${mal.basisType eq '2'}">辅材费</c:if>
												<c:if test="${mal.basisType eq '3'}">延保费</c:if>
												<c:if test="${mal.basisType eq '4'}">辅材费-入库价格</c:if>
												<c:if test="${mal.basisType eq '6'}">辅材费-工程师价格</c:if>
												<c:if test="${mal.basisType eq '5'}">厂家结算费</c:if>
											</div>
										</c:forEach>
									</c:forEach></td>
								<td class="no-pd"><c:forEach items="${item}" var="item2">
										<c:forEach items="${item2.value}" var="mal">
											<div class="bb h-30 pd-5" title="${mal.basisType}">

												<c:choose>
													<c:when test="${empty mal.chargeProportion }">${mal.chargeAmount}</c:when>
													<c:otherwise>${mal.chargeProportion}%</c:otherwise>
												</c:choose>
											</div>
										</c:forEach>
									</c:forEach></td>
							</tr>
						</c:forEach>

					</table>
				</div>
				<div class="cl mt-10">
					<div class="pagination">${page}</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 新增结算方案 -->
	<div class="popupBox settlement2 addSettlement">
		<h2 class="popupHead">
			新增结算方案 <a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<form action="#" class="form-add-fitti" method="post">
				<div class="popupMain">
					<div class="pcontent" style="max-height:560px;">
						<div class="mb-10 cl">
							<label class="f-l">服务品类：</label> <input type="text"
								class="f-l w-140 input-text" id="category" readonly="readonly"
								value="${cateId}" name="category" datatype="*">
							<!-- 	<label class="f-l ml-50">保修类型：</label>
					<select class="f-l w-140 select" name="warrantyType" id="warranty_type" datatype="*" nullmsg ="请选择保修类型">
						<option value="">请选择</option>
						<option value="0">保内</option>
						<option value="1">保外</option>
					</select> -->
							<label class="f-l ml-50"><em class="mark">*</em>结算方案：</label> <input type="text"
								class="f-l w-140 input-text" name="serviceMeasures"
								id="serviceMeasures" datatype="*" nullmsg="请输入结算方案" />

						</div>

						<div class="text-c">
							<table
								class="table table-bg table-border table-bordered table-sdrk">
								<thead>
									<tr>
										<th class="w-210">结算项</th>
										<th class="w-210">结算依据</th>
										<th colspan="2" class="w-210">结算方式</th>
										<th class="w-130">操作</th>
									</tr>
								</thead>
								<tbody id="tbody">

									<tr>
										<td><input type="text" class="input-text"
											name="chargeName" datatype="*" nullmsg="请输入结算项" /></td>
										<td>
											<div class="jsyjbox">
												<div class="priceWrap sbasebox"
													onclick="showSbasebox(event ,this)">
													<input type="text" class="input-text " readonly="readonly"
														UNSELECTABLE="on" name="settle-base" value="服务费" /> <span
														class="unit"><a href="javascript:;"
														class="select-arrowdown showList"
														onclick="showList(event,this)"></a></span>
												</div>
												<ul class="baseList" onmouseover="showBaseList(this)">
													<li class="selected" data-text="服务费" selected="selected">服务费</li>
													<li data-text="辅材费">辅材费</li>
													<li data-text="延保">延保费</li>
													<li data-text="自定义金额">自定义金额</li>
													<li data-text="辅材费-入库价格">辅材费-入库价格</li>
													<li data-text="辅材费-工程师价格">辅材费-工程师价格</li>
													<li data-text="厂家结算费">厂家结算费</li>
												</ul>
											</div>
										</td>
										<td class="w-150"><select class="select"
											name="settle-way" onchange="changeUnit(this)">
												<option value="1">按金额</option>
												<option value="2">按比例</option>
										</select></td>
										<td>
											<div class="priceWrap w-60 jsfs jsfs1">
												<input type="text" class="input-text" name="settle-value" />
												<span class="unit">元</span>
											</div>
											<div class="priceWrap w-60 jsfs jsfs2 " style="display: none">
												<input type="text" class="input-text" name="settle-value" />
												<span class="unit">%</span>
											</div>
										</td>
										<td class="text-l" style="padding-left: 40px;"><a
											href="javascript:;" class="sficon sficon-reduce2 mr-5"
											style="display: none;" onclick="hideSettle('tbody',this)"></a>
											<a href="javascript:;" class="sficon sficon-add2 mr-5"
											onclick="addSettle('tbody',this)"></a></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="text-c btnWrap">
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"
						id="btnAddSetelement">保存</a> <a
						href="javascript:cancel('addSettlement');"
						class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</form>
		</div>
	</div>


	<!-- 修改结算方案 -->
	<div class="popupBox settlement2 editSettlement">
		<h2 class="popupHead">
			修改结算方案 <a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<form action="#" class="form-update-fitti" method="post">
			<div class="popupContainer pos-r">
				<div class="popupMain">
					<div class="pcontent">
						<div class="mb-10 cl">
							<label class="f-l">服务品类：</label> <input type="text"
								class="f-l w-140 input-text readonly" readonly="readonly"
								id="categoryup" readonly="readonly" value="${cateId}"
								name="categoryup" datatype="*">
							<!-- 	<label class="f-l ml-50">保修类型：</label>
					<select class="f-l w-140 select" name="warrantyTypeup" id="warranty_typeup" datatype="*" nullmsg ="请选择保修类型">
						<option value="">请选择</option>
						<option value="1">保内</option>
						<option value="2">保外</option>
					</select> -->

							<label class="f-l ml-50">结算措施：</label> <input type="hidden"
								id="upserviceMeasures" /> <input type="text"
								class="f-l w-140 input-text" name="upserviceMeasures"
								id="xintype" datatype="*" nullmsg="请输入结算措施" />
						</div>
						<div class="text-c">
							<table
								class="table table-bg table-border table-bordered table-sdrk">
								<thead>
									<tr>
										<th class="w-210">结算项</th>
										<th class="w-210">结算依据</th>
										<th colspan="2" class="w-210">结算方式</th>
										<th class="w-130">操作</th>
									</tr>
								</thead>
								<tbody id="editBody">
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="text-c btnWrap">
					<a href="javascript:;" id="btnUpdateSetelement"
						class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a> <a
						href="javascript:cancel('editSettlement');"
						class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		$(function() {
			$('.page-orderWait .table').find('td').each(function() {
				$(this).find('div').last().css({
					'border' : '0'
				});
			});
            $('.page-orderWait .table').find('tr').each(function () {
                $(this).bind('click', function () {
                    if ($(this).hasClass('ui-state-highlight')) {
                        $("input[type='radio']").removeAttr("checked");
                        $(this).removeClass('ui-state-highlight');
                    } else {
                        $("input[type='radio']").removeAttr("checked");
                        $('.page-orderWait .table tr').removeClass('ui-state-highlight');
                        $(this).addClass('ui-state-highlight');
                        $(this).children().find("input[type='radio']").attr("checked", 'checked');
                    }
                });
            });

			$.tabBarList();
			initTableH();
			$('body').click( function() {  
                 $(".baseList").each(function(ids,el){
                	 $(this).hide();
                 })
		    });  
		});

		$('input[name="chk_trb"]').on(
				'click',
				function(ev) {
					ev.stopPropagation();
					var pTr = $(this).parents('tr');

					if (pTr.hasClass('ui-state-highlight')) {
						pTr.removeClass('ui-state-highlight');
					} else {
						$('.page-orderWait .table tr').removeClass(
								'ui-state-highlight');
						pTr.addClass('ui-state-highlight');
					}
				});

		$('#btn-add').bind('click', function() {
			$('.addSettlement').popup({
				/* fixedHeight : false */
			});
			$("#category").val($("#tabswitchCurrent").text());
			var _name = $("input[name='chk_trb']:checked").val();
			$("#serviceMeasures").val(_name);
		});

		$('#btn-upda').bind('click', function() {
			var _name = $("input[name='chk_trb']:checked").val();
			if (isBlank(_name)) {
				layer.msg("请选择一条数据！");
			} else {
				//$('.editSettlement').popup({fixedHeight:false});
				$("#categoryup").val($("#tabswitchCurrent").text());
				$("#upserviceMeasures").val(_name);
				$("#xintype").val(_name);
				xiugai();
			}

		});
		$('#btn-dele')
				.bind(
						'click',
						function() {
							var _name = $("input[name='chk_trb']:checked")
									.val();
							if (isBlank(_name)) {
								layer.msg("请选择一条数据！");
							} else {
								var content = "确认要删除结算措施？";
								//$("#decategory").val($("#tabswitchCurrent").text());
								//$("#deserviceMeasures").val(_name);
								$('body')
										.popup(
												{
													level : 3,
													title : "删除",
													content : content,
													fnConfirm : function() {
														//deleSet();
														var cate = $(
																"#tabswitchCurrent")
																.text()
														var cateId = $(
																"#categroyId")
																.val();
														var serviceMeasures = _name;//结算措施
														$
																.ajax({
																	type : "POST",
																	url : "${ctx}/order/settlementTemplate/delectSettel",
																	data : {
																		serviceMeasures : serviceMeasures,
																		cate : cate
																	},
																	success : function(
																			data) {
																		layer
																				.msg("删除成功");
																		window.location.href = "${ctx}/order/settlementTemplate/getlist?categroy="
																				+ cateId;

																	}
																});
													}
												});
								//$('.delSettlement').popup({fixedHeight:false});

							}

						});

		function xiugai() {
			var $curTr = $('.sfpage .table').find('tr.ui-state-highlight');
			var oBody = $('#editBody');
			oBody.empty();
			var length = $curTr.children('td').eq(2).children('div').size(), html = '';
			for (var i = 0; i < length; i++) {
				html += '<tr>'
						+ '<td>'
						+ '<input type="text" class="input-text input2" name="chargeNameup"  datatype="*" nullmsg="请输入结算项" value="'
						+ $.trim($curTr.children('td').eq(2).children('div')
								.eq(i).text())
						+ '" />'
						+ '</td>'
						+ '<td>'
						+ '<div class="jsyjbox">'
						+ '<div class="priceWrap sbasebox"  onclick="showSbaseboxup(event ,this)">'
						+ '<input type="text" class="input-text " readonly="readonly" UNSELECTABLE="on" name="settle-baseup" value="'
						+ $.trim($curTr.children('td').eq(3).children('div')
								.eq(i).text())
						+ '"/>'
						+ '<span class="unit"><a href="javascript:;" class="select-arrowdown showList" onclick="showList(event,this)"></a></span>'
						+ '</div>'
						+ '<ul class="baseList" onmouseover="showBaseListedite(this)">'
						+ '<li class="selected" data-text="服务费" selected="selected">服务费</li>'
						+ '<li data-text="辅材费">辅材费</li>'
						+ '<li data-text="延保费">延保费</li>'
						+ '<li data-text="自定义金额">自定义金额</li>'
						+ '<li data-text="辅材费-入库价格">辅材费-入库价格</li>'
						+ '<li data-text="辅材费-工程师价格">辅材费-工程师价格</li>'
                    	+ '<li data-text="厂家结算费">厂家结算费</li>'
						+ '</ul>'
						+ '</div>' + '</td>';
				var jsWay = $.trim($curTr.children('td').eq(4).children('div')
						.eq(i).text());
				var lastChar = $.trim(jsWay.substr(jsWay.length - 1, 1));
				if (lastChar != '%') {
					html += '<td class=" w-150">'
							+ '<select class="select" name="settle-wayup"  onchange="changeUnit(this)" >'
							+ '<option value="1" selected="selected">按金额</option>'
							+ '<option value="2">按比例</option>'
							+ '</select>'
							+ '</td>'
							+ '<td class=" w-150">'
							+ '<div class="priceWrap jsfs jsfs1">'
							+ '<input type="text" class="input-text" name="settle-valueup" value="'
							+ $.trim(jsWay.substr(0, jsWay.length))
							+ '" />'
							+ '<span class="unit">元</span>'
							+ '</div>'
							+ '<div class="priceWrap jsfs jsfs2 " style="display: none">'
							+ '<input type="text" class="input-text" name="settle-valueup" />'
							+ '<span class="unit">%</span>'
							+ '</div>'
							+ '</td>'
							+ '<td class="text-l" style="padding-left:40px;">'
							+ '<a href="javascript:;" class="sficon sficon-reduce2 mr-5"  onclick="hideSettle(\'editBody\',this)"></a>'
							+ '<a href="javascript:;" class="sficon sficon-add2 mr-5"style="display: none;" onclick="addSettleedite(\'editBody\',this)"></a>'
							+ '</td>' + '</tr>';
				} else {
					html += '<td class=" w-150">'
							+ '<select class="select" name="settle-wayup" onchange="changeUnit(this)" >'
							+ '<option value="1">按金额</option>'
							+ '<option value="2" selected="selected">按比例</option>'
							+ '</select>'
							+ '</td>'
							+ '<td class=" w-150">'
							+ '<div class="priceWrap jsfs jsfs1 " style="display: none">'
							+ '<input type="text" class="input-text" name="settle-valueup" />'
							+ '<span class="unit">元</span>'
							+ '</div>'
							+ '<div class="priceWrap jsfs jsfs2">'
							+ '<input type="text" class="input-text" name="settle-valueup" value="'
							+ $.trim(jsWay.substr(0, jsWay.length - 1))
							+ '" />'
							+ '<span class="unit">%</span>'
							+ '</div>'
							+ '</td>'
							+ '<td class="text-l" style="padding-left:40px;">'
							+ '<a href="javascript:;" class="sficon sficon-reduce2 mr-5"  onclick="hideSettle(\'editBody\',this)"></a>'
							+ '<a href="javascript:;" class="sficon sficon-add2 mr-5"style="display: none;" onclick="addSettleedite(\'editBody\',this)"></a>'
							+ '</td>' + '</tr>';
				}

			}
			oBody.append(html);
			oBody.find('tr').last().find('.sficon-add2').show().find(
					'.sficon-reduce2').hide();
			$('.editSettlement').popup({
				fixedHeight : false
			});
		}

		// 弹出框里的操作
		function showBaseList(obj) {
			$(obj)
					.find('li')
					.each(
							function(index) {
								$(this)
										.on(
												{
													mouseover : function() {
														$(this)
																.parent(
																		'.baseList')
																.children('li')
																.removeClass(
																		'selected');
														$(this).addClass(
																'selected');
													},
													click : function() {
														var textInput = $(this)
																.closest(
																		'.jsyjbox')
																.find(
																		'input[name="settle-base"]');
														if (index != 3) {
															textInput
																	.val($(this)
																			.attr(
																					'data-text'));
															textInput
																	.attr({
																		'readonly' : 'readonly',
																		'UNSELECTABLE' : 'on'
																	});
														} else {
															textInput.val('');
															textInput
																	.removeAttr(
																			'readonly')
																	.removeAttr(
																			'UNSELECTABLE');
															textInput
																	.attr({
																		'placeholder' : '请输入自定义金额'
																	});
														}
														$(obj).hide();
													}
												})
							})
		}
		function showBaseListedite(obj) {
			$(obj)
					.find('li')
					.each(
							function(index) {
								$(this)
										.on(
												{
													mouseover : function() {
														$(this)
																.parent(
																		'.baseList')
																.children('li')
																.removeClass(
																		'selected');
														$(this).addClass(
																'selected');
													},
													click : function() {
														var textInput = $(this)
																.closest(
																		'.jsyjbox')
																.find(
																		'input[name="settle-baseup"]');
														if (index != 3) {
															textInput
																	.val($(this)
																			.attr(
																					'data-text'));
															textInput
																	.attr({
																		'readonly' : 'readonly',
																		'UNSELECTABLE' : 'on'
																	});
														} else {
															textInput.val('');
															textInput
																	.removeAttr(
																			'readonly')
																	.removeAttr(
																			'UNSELECTABLE');
															textInput
																	.attr({
																		'placeholder' : '请输入自定义金额'
																	});
														}
														$(obj).hide();
													}
												})
							})
		}
		//添加操作的下拉框事件
		function showSbasebox(ev, obj) {
			var ev = ev || event;
			ev.cancelBubble = true;
			var flag = $(obj).find('input[name="settle-base"]')
					.attr('readonly');
			if (flag) {
				var $blist = $(obj).parent('.jsyjbox').find('.baseList');
				$('.baseList').not($blist).hide();
				$blist.show();
			}

		}
		////修改操作的下拉框事件
		function showSbaseboxup(ev, obj) {
			var ev = ev || event;
			ev.cancelBubble = true;
			var flag = $(obj).find('input[name="settle-baseup"]').attr(
					'readonly');
			if (flag) {
				var $blist = $(obj).parent('.jsyjbox').find('.baseList');
				$('.baseList').not($blist).hide();
				$blist.show();
			}
		}

		function showList(ev, obj) {
			var ev = ev || event;
			ev.cancelBubble = true;
			var $jsyjbox = $(obj).closest('.jsyjbox').find('.baseList');
			$('.baseList').not($jsyjbox).hide();
			if ($jsyjbox.is(':visible')) {
				$jsyjbox.hide();
			} else {
				$jsyjbox.show();
			}
		}

		$('.addSettlement').bind('click', function() {
			$('.baseList').hide();
		});
		//添加操作的添加选项按钮
		function addSettle(bodyId, obj) {
			var tbody = $('#' + bodyId);
			var html = '<tr>'
					+ '<td>'
					+ '<input type="text" class="input-text" name="chargeName" datatype="*" nullmsg="请输入结算项" />'
					+ '</td>'
					+ '<td>'
					+ '<div class="jsyjbox">'
					+ '<div class="priceWrap sbasebox" onclick="showSbasebox(event,this)">'
					+ '<input type="text" class="input-text " readonly="readonly" UNSELECTABLE="on" name="settle-base" value="服务费" />'
					+ '<span class="unit"><a href="javascript:;" class="select-arrowdown showList" onclick="showList(event,this)"></a></span>'
					+ '</div>'
					+ '<ul class="baseList" onmouseover="showBaseList(this)">'
					+ '<li class="selected" data-text="服务费" selected="selected">服务费</li>'
					+ '<li data-text="辅材费">辅材费</li>'
					+ '<li data-text="延保费">延保费</li>'
					+ '<li data-text="自定义金额">自定义金额</li>'
					+ '<li data-text="辅材费-入库价格">辅材费-入库价格</li>'
					+ '<li data-text="辅材费-工程师价格">辅材费-工程师价格</li>'
                	+ '<li data-text="厂家结算费">厂家结算费</li>'
					+ '</ul>'
					+ '</div>'
					+ '</td>'
					+ '<td class="w-150">'
					+ '<select class="select" name="settle-way" onchange="changeUnit(this)" >'
					+ '<option value="1">按金额</option>'
					+ '<option value="2">按比例</option>'
					+ '</select>'
					+ '</td>'
					+ '<td>'
					+ '<div class="priceWrap w-60 jsfs jsfs1">'
					+ '<input type="text" class="input-text" name="settle-value" />'
					+ '<span class="unit">元</span>'
					+ '</div>'
					+ '<div class="priceWrap w-60 jsfs jsfs2 " style="display: none">'
					+ '<input type="text" class="input-text" name="settle-value" />'
					+ '<span class="unit">%</span>'
					+ '</div>'
					+ '</td>'
					+ '<td class="text-l" style="padding-left:40px;">'
					+ '<a href="javascript:;" class="sficon sficon-reduce2 mr-5" onclick="hideSettle(\''
					+ bodyId
					+ ' \',this)"></a>'
					+ '<a href="javascript:;" class="sficon sficon-add2 mr-5" onclick="addSettle(\''
					+ bodyId + ' \',this)"></a>' + '</td>' + '</tr>';

			tbody.append(html);
			$(obj).prev('.sficon-reduce2').show();
			$(obj).hide();
			$.setPos($(obj).closest('.popupBox'));

		}

		//修改操作的添加选项按钮
		function addSettleedite(bodyId, obj) {
			var tbody = $('#' + bodyId);
			var html = '<tr>'
					+ '<td>'
					+ '<input type="text" class="input-text" name="chargeNameup" datatype="*" nullmsg="请输入结算项" />'
					+ '</td>'
					+ '<td>'
					+ '<div class="jsyjbox">'
					+ '<div class="priceWrap sbasebox" onclick="showSbaseboxup(event,this)">'
					+ '<input type="text" class="input-text " readonly="readonly" UNSELECTABLE="on" name="settle-baseup" value="服务费" />'
					+ '<span class="unit"><a href="javascript:;" class="select-arrowdown showList" onclick="showList(event,this)"></a></span>'
					+ '</div>'
					+ '<ul class="baseList" onmouseover="showBaseListedite(this)">'
					+ '<li class="selected" data-text="服务费" selected="selected">服务费</li>'
					+ '<li data-text="辅材费">辅材费</li>'
					+ '<li data-text="延保费">延保费</li>'
					+ '<li data-text="自定义金额">自定义金额</li>'
					+ '<li data-text="辅材费-入库价格">辅材费-入库价格</li>'
					+ '<li data-text="辅材费-工程师价格">辅材费-工程师价格</li>'
                	+ '<li data-text="厂家结算费">厂家结算费</li>'
					+ '</ul>'
					+ '</div>'
					+ '</td>'
					+ '<td class="w-150">'
					+ '<select class="select" name="settle-wayup" onchange="changeUnit(this)" >'
					+ '<option value="1">按金额</option>'
					+ '<option value="2">按比例</option>'
					+ '</select>'
					+ '</td>'
					+ '<td>'
					+ '<div class="priceWrap w-60 jsfs jsfs1">'
					+ '<input type="text" class="input-text" name="settle-valueup" />'
					+ '<span class="unit">元</span>'
					+ '</div>'
					+ '<div class="priceWrap w-60 jsfs jsfs2 " style="display: none">'
					+ '<input type="text" class="input-text" name="settle-valueup" />'
					+ '<span class="unit">%</span>'
					+ '</div>'
					+ '</td>'
					+ '<td class="text-l" style="padding-left:40px;">'
					+ '<a href="javascript:;" class="sficon sficon-reduce2 mr-5" onclick="hideSettle(\''
					+ bodyId
					+ ' \',this)"></a>'
					+ '<a href="javascript:;" class="sficon sficon-add2 mr-5" onclick="addSettleedite(\''
					+ bodyId + ' \',this)"></a>' + '</td>' + '</tr>';

			tbody.append(html);
			$(obj).prev('.sficon-reduce2').show();
			$(obj).hide();
			$.setPos($(obj).closest('.popupBox'));

		}

		function hideSettle(bodyId, obj) {
			var tbody = $('#' + bodyId);
			$(obj).parents('tr').remove();
			var childLength = tbody.children().size(), lastTr = tbody
					.children().eq(childLength - 1);

			lastTr.find('.sficon-add2').show();
			if (childLength == 1) {
				lastTr.find('.sficon-reduce2').hide();
			}
		}

		function changeUnit(obj) {
			var oIndex = $(obj).find('option:selected').val();
			$(obj).closest('tr').find('.jsfs').css('display', 'none');
			$(obj).closest('tr').find('.jsfs' + oIndex).css('display', 'block')
		}

		function initTableH() {
			var tHeight = $('.sfpagebg').height() - 280;
			$('.tableWrap').css({
				'max-height' : tHeight,
				'overflow' : 'auto'
			})
		}
		
		var reMk=false;
		$('.form-add-fitti')
				.Validform(
						{
							btnSubmit : "#btnAddSetelement",
							tiptype : function(msg) {
								if (msg != "") {
									layer.msg(msg);
								}
							},
							callback : function(form) {
								if(reMk==true){
									return;	
								}
								var result = [];//结算费用名称
								var solution = [];//结算依据
								var settype = [];//结算方式
								var set_amount = [];//结算金额
								var cate = $("#category").val();
								var cateId = $("#categroyId").val();
								var serviceMeasures = $("#serviceMeasures")
										.val();//结算措施
								//var warrantyType = $("#warranty_type").val();//保修类型
								$('input[name="chargeName"]').each(function() {
									if (isBlank($(this).val())) {
									} else {
										result.push($(this).val());
									}
								});
								$('input[name="settle-base"]').each(function() {
									if (isBlank($(this).val())) {
										solution.push("");
									} else {
										solution.push($(this).val());
									}
								});
								$('select[name="settle-way"]').each(function() {
									if (isBlank($(this).val())) {
									} else {
										settype.push($(this).val());
									}
								});

								$('input[name="settle-value"]')
										.each(
												function() {
													if ($(this).parent().is(
															':visible')) {
														if (isBlank($(this)
																.val())) {
															set_amount.push("");
														} else {
															set_amount
																	.push($(
																			this)
																			.val());
														}
													}

												});
										reMk=true;
								
								$
										.ajax({
											type : "POST",
											url : "${ctx}/order/settlementTemplate/saveset",
											data : {
												serviceMeasures : serviceMeasures,
												cate : cate,
												//warrantyType:warrantyType,
												result : JSON.stringify(result),
												settype : JSON
														.stringify(settype),
												setamount : JSON
														.stringify(set_amount),
												solution : JSON
														.stringify(solution)
											},
											success : function(data) {
												if ('true' == data.ok) {
													window.location.href = "${ctx}/order/settlementTemplate/getlist?categroy="
															+ cateId;
													$
															.closeDiv($(".addSettlement"))
													$("#type").val("");
													$(
															'input[name="chargeAmount"]')
															.val("");
													$(
															'input[name="chargeName"]')
															.val("");
													$('.curMaskbox-tjgzlb')
															.hide();
												}
											},
											complete:function(){
												reMk==false;
											}
										});

								return false;
							}
						});

		$('.form-update-fitti')
				.Validform(
						{
							btnSubmit : "#btnUpdateSetelement",
							tiptype : function(msg) {
								if (msg != "") {
									layer.msg(msg);
								}
							},
							callback : function(form) {
								var result = [];//结算费用名称
								var solution = [];//结算依据
								var settype = [];//结算方式
								var set_amount = [];//结算金额
								var cate = $("#categoryup").val();
								var cateId = $("#categroyId").val();
								var serviceMeasures = $("#upserviceMeasures")
										.val();//结算措施
								var xintype = $("#xintype").val();//结算措施
								//var warrantyType = $("#warranty_type").val();//保修类型
								$('input[name="chargeNameup"]').each(
										function() {
											if (isBlank($(this).val())) {
											} else {
												result.push($(this).val());
											}
										});
								$('input[name="settle-baseup"]').each(
										function() {
											if (isBlank($(this).val())) {
												solution.push("");
											} else {
												solution.push($(this).val());
											}
										});
								$('select[name="settle-wayup"]').each(
										function() {
											if (isBlank($(this).val())) {
											} else {
												settype.push($(this).val());
											}
										});
								$('input[name="settle-valueup"]')
										.each(
												function() {
													if ($(this).parent().is(
															':visible')) {
														if (isBlank($(this)
																.val())) {
															set_amount.push("");
														} else {
															set_amount
																	.push($(
																			this)
																			.val());
														}
													}

												});

								$
										.ajax({
											type : "POST",
											url : "${ctx}/order/settlementTemplate/getupSettel",
											data : {
												serviceMeasures : serviceMeasures,
												cate : cate,
												//warrantyType:warrantyType,
												result : JSON.stringify(result),
												settype : JSON
														.stringify(settype),
												setamount : JSON
														.stringify(set_amount),
												solution : JSON
														.stringify(solution),
												xintype : xintype
											},
											success : function(data) {
												if ('true' == data.ok) {
													window.location.href = "${ctx}/order/settlementTemplate/getlist?categroy="
															+ cateId;
													$
															.closeDiv($(".editSettlement"))
												}
											}
										});

								return false;
							}
						});
		function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}

		function deleSet() {
			var $curTr = $('.sfpage .table').find('tr.ui-state-highlight');
			var oBody = $('#delBody');
			oBody.empty();
			var length = $curTr.children('td').eq(2).children('div').size(), html = '';
			for (var i = 0; i < length; i++) {
				html += '<tr>'
						+ '<td>'
						+ '<input type="text" class="input-text input2 readonly" readonly="readonly" unselectable="on" value="'
						+ $.trim($curTr.children('td').eq(2).children('div')
								.eq(i).text())
						+ '" />'
						+ '</td>'
						+ '<td>'
						+ '<input type="text" class="input-text input2 readonly " readonly="readonly" UNSELECTABLE="on" value="'
						+ $.trim($curTr.children('td').eq(3).children('div')
								.eq(i).text()) + '"/>' + '</td>';
				var jsWay = $.trim($curTr.children('td').eq(4).children('div')
						.eq(i).text());
				var id = $.trim($curTr.children('td').eq(2).children('input')
						.val());
				var lastChar = jsWay.substr(jsWay.length - 1, 1);
				if (lastChar != '%') {
					html += '<td class="w-150">'
							+ '<input type="text" class="input-text readonly input2 " readonly="readonly" UNSELECTABLE="on" value="按金额"/>'
							+ '</td>'
							+ '<td>'
							+ '<div class="priceWrap w-60 readonly">'
							+ '<input type="text" class="input-text" readonly="readonly" UNSELECTABLE="on" value="'
							+ $.trim(jsWay.substr(0, jsWay.length))
							+ '"/>'
							+ '<span class="unit">元</span>'
							+ '</div>'
							+ '</td>'
							+ '<td>'
							+ '<label class="label-cbox2"><input type="checkbox" name="radio_jsfs" value="'+id+'"/></label>	'
							+ '</td>' + '</tr>';
				} else {
					html += '<td class="w-150">'
							+ '<input type="text" class="input-text input2 readonly" readonly="readonly" UNSELECTABLE="on" value="按比例"/>'
							+ '</td>'
							+ '<td>'
							+ '<div class="priceWrap w-60 readonly">'
							+ '<input type="text" class="input-text " readonly="readonly" UNSELECTABLE="on" value="'
							+ $.trim(jsWay.substr(0, jsWay.length - 1))
							+ '"/>'
							+ '<span class="unit">%</span>'
							+ '</div>'
							+ '</td>'
							+ '<td>'
							+ '<label class="label-cbox2"><input type="checkbox" name="radio_jsfs" value="'+id+'"/></label>	'
							+ '</td>' + '</tr>';
				}
			}
			oBody.append(html);
			$.selectCheck('radio_jsfs');
			$('.delSettlement').popup({
				fixedHeight : false
			});

		}

		//删除结算项
		function delectSettelChargeCame() {
			var set_amount = [];//结算项
			var cateId = $("#categroyId").val();
			$("input[name='radio_jsfs']:checked").each(function() {
				if (isBlank($(this).val())) {
				} else {
					set_amount.push($(this).val());
				}
			});
			if (set_amount.length == 0) {
				layer.msg("请选择删除项！");
			} else {
				$
						.ajax({
							type : "POST",
							url : "${ctx}/order/settlementTemplate/delectSettelChargeCame",
							data : {
								set_amount : JSON.stringify(set_amount)
							},
							success : function(data) {
								layer.msg("删除成功");
								window.location.href = "${ctx}/order/settlementTemplate/getlist?categroy="
										+ cateId;

							}
						});
			}
		}
		//删除结算服务措施
		/* function delectSettel(){
		
		 } */

		function cancel(id) {
			$.closeDiv($('.' + id));
		}
		function search() {
			var cateId = $("#categroyId").val();
			var servicemeasures = $("#servicemeasures").val();
			window.location.href = "${ctx}/order/settlementTemplate?servicemeasures="
					+  encodeURI(encodeURI(servicemeasures)) + "&category=" + cateId;
		}
		
		function reset(){
			$("#servicemeasures").val('');
		}

        function toNav(url) {
            url += "&pos=" + $('.tabswitch_list').css('left');
            window.location = url;
        }
		
		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return;
		}
	</script>
</body>
</html>
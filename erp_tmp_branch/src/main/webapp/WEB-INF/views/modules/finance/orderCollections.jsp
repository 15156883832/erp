<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/imgShow.js"></script>
</head>

<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<sfTags:pagePermission authFlag="ORDER_ORDERCOLLECTIONS_DETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/orderCollections/headList">二维码收款明细</a>'></sfTags:pagePermission>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt">
								<i class="sficon sficon-search"></i>
								查询
							</a>
							<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn">
								<i class="sficon sficon-reset"></i>
								重置
							</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1">
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<input type="hidden" name="siteId" id="siteId" value="${siteId }">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">工单编号：</th>
										<td>
											<input type="text" class="input-text" name="number" id="number" />
										</td>
										<th style="width: 76px;" class="text-r">收款方式：</th>
										<td>
											<span class="select-box">
												<select class="select" name="paymentType" id="paymentType">
													<option value="">请选择</option>
													<option value="0">支付宝</option>
													<option value="1">微信</option>
												</select>
											</span>
										</td>

										<th style="width: 76px;" class="text-r">服务工程师：</th>
										<td>
											<span class="">
												<select class="select select-box" name="employeName" id="employeName">
													<option value="">请选择</option>
													<c:forEach items="${emList }" var="el">
														<option value="${el.columns.name }">${el.columns.name }</option>
													</c:forEach>
												</select>
											</span>
										</td>
										<td colspan="3">
											<label class="text-r lb">收款日期：</label>
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="${startTime }"
												class="input-text Wdate w-120" style="width: 120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax"
												value="<fmt:formatDate value="${date }" pattern="yyyy-MM-dd"/>" class="input-text Wdate w-120" style="width: 120px">
										</td>
									</tr>
									<tr>
										<th style="width: 76px;" class="text-r">提成状态：</th>
										<td>
											<span class="select-box">
												<select class="select" name="commissionStatus" id="commissionStatus">
													<option value="">请选择</option>
													<option value="0">未提成</option>
													<option value="1">已提成</option>
												</select>
											</span>
										</td>
									</tr>
								</table>
							</div>
						</form>
						<div class="pt-10 pb-5 cl">
							<div class="f-r">
								<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn">
									<i class="sficon sficon-setting"></i>
									表头设置
								</a>
								<sfTags:pagePermission authFlag="ORDER_ORDERCOLLECTIONS_DETAIL_EXPORT_BTN"
									html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
							</div>
						</div>
						<div>
							<table id="table-waitdispatch" class="table"></table>
							<!-- pagination -->
							<div class="cl pt-10">
								<div class="f-l">
									<stong class="f-14" style="font-weight: 600">收款合计：<span class="c-0383dc f-14" id="amoutsum"></span>元,</stong>
								</div>
								<div class="f-l">
									<stong class="f-14" style="font-weight: 600">发放提成：<span class="c-0383dc f-14" id="commissionsum"></span>元</stong>
								</div>
								<div class="f-r">
									<div class="pagination" id="paginations"></div>
								</div>
							</div>
							<!-- pagination -->
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- 表头设置 -->
	<div class="">
		<div>
			<h2></h2>
		</div>
	</div>

	<div class="popupBox w-320 vipPromptBox">
		<h2 class="popupHead">提示</h2>
		<div class="popupContainer">
			<div class="popupMain text-c pt-30 pb-20">
				<div class="">
					<i class="iconType iconType2"></i>
					<strong class="f-16">VIP会员功能</strong>
				</div>
				<p class="c-666 lh-26">
					抱歉，此功能需要
					<span class="c-bb3906">开通VIP会员</span>
					后才能使用！
				</p>
				<div class="text-c mt-30">
					<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
					<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
				</div>
			</div>
		</div>
	</div>


	<!-- 发放提成 -->
	<div class="popupBox fftc">
		<h2 class="popupHead">
			<span id="fftchead">发放提成</span>
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-20">
				<div class="cl mb-10">
					<div class="f-l w-310">
						<input type="hidden" id="commissionid" />
						<input type="hidden" id="temployeId" />
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">服务工程师：</span>
							<p class=" c-888" id="temployeName">小A</p>
						</div>
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">收款类型：</span>
							<p class="f-12 c-888" id="tsource">小A</p>
						</div>
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">收款时间：</span>
							<p class="f-12 c-888" id="tcreateTime">2018-01-01 12:00</p>
						</div>
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">收款方式：</span>
							<p class="f-12 c-888" id="tpaymentType">小A</p>
						</div>
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">收款原因：</span>
							<p class="f-12 c-888" id="tdescription">美的空调安装、用户家电使用咨询服务用户家电使用咨询服务</p>
						</div>

					</div>
					<div class="f-l w-310">
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">用户姓名：</span>
							<p class=" c-888" id="tcustomerName">小A</p>
						</div>
						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">用户电话：</span>
							<p class="f-12 c-888" id="tcustomerMobile">13855556656</p>
						</div>

						<div class="f-l w-310 pl-100 pos-r f-13 lh-20 mb-5">
							<span class="w-100 text-r pos">详细地址：</span>
							<p class="f-12 c-888" id="tcustomerAddress">安徽省合肥市蜀山区蔚蓝商务港安徽省合肥市蜀山区蔚蓝商务港</p>
						</div>
					</div>
				</div>

				<div class="line-dashed mb-10"></div>
				<div class="pt-10 cl mb-10">
					<div class="f-l w-310 pl-100 pos-r f-13 lh-26 ">
						<span class="w-100 text-r pos">收款金额：</span>
						<p class="f-12 c-888 f-l" id="tpaymentAmount">100元</p>
						<span class="proofImg">
							<a class="f-l c-0e8ee7 underline ml-15 ">
								<i class="sficon sficon-view"></i>
								查看凭证
								<img src="" id="timg" />
							</a>
						</span>
					</div>
					<div class="f-l w-310 pl-100 pos-r f-13 " id="tcjediv">
						<label class="w-100 text-r pos">提成金额：</label>
						<%--<p class="f-12 c-888">10元</p>--%>
						<div class="f-l priceWrap  w-100" id="tcjedivs">
							<input type="text" class="input-text" id="tcommissionMoney" />
							<span class="unit">元</span>
						</div>
						<input type="button" class="mr-10 ml-10 sfbtn sfbtn-opt3 hide" value="重新发放提成" id="cxff" onclick="cxff()" />
					</div>
				</div>
				<div class="pt-10 cl mb-10 detailmarks">
					<div class="f-l w-310 pl-100 pos-r f-13 lh-26 ">
						<span class="w-100 text-r pos">备注：</span>
						<textarea id="marksAdd" name="marksAdd" class="textarea f-l h-40" style="width: 510px;"></textarea>
					</div>
				</div>
				<div class="pl-30" id="scszls">
					<a class="c-888 ml-5" id="created">
						<i class="sficon label-cbox4 label-cbox4-selected"></i>
						生成提成收支流水
					</a>
					（
					<span class="c-fe0101">可以在“财务管理”→ “收支流水管理”页面查看</span>
					）
				</div>
				<!-- <div class="text-c pl-20 mt-30 pt-15" id="qrqx">
					<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" id="qrff" onclick="qrff()" />
					<input type="button" class="mr-10 sfbtn sfbtn-opt3 hide" value="重新发放提成" id="cxff" onclick="cxff()" />
					<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="ffqx()" />  
				</div> -->
				<div class="text-c pl-20 mt-30 pt-15" id="detailssave">
					<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="保存" id="bcbz" onclick="saveMarks()" />
					<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt3 hide" value="确认" id="qrff" onclick="qrff()" />
					<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="关闭" id="gbbc" onclick="ffqx()" />
				</div>
			</div>
		</div>
	</div>

	<div class="popupBox w-380 confirmAccountpop">
		<h2 class="popupHead">
			修改金额
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-15">
				<div class="cl mb-10 mt-30">
					<label class="f-l w-120">收款金额：</label>
					<div class="f-l priceWrap  w-150" id="tcjedivs">
						<input type="text" class="input-text" id="newMoney" />
						<span class="unit">元</span>
					</div>
				</div>
				<div class="text-c pt-15 mt-30">
					<input type="hidden" name="cooId" id="cooId" />
					<input onclick="qurenAccount()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
					<input type="button" onclick="quxiaoAccount()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var id = '${headerData.id}'; //服务商表格的ID
		var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
		var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		var defaultId = '${headerData.defaultId}'; //系统表格的ID
		$(function() {

			$.post("${ctx}/goods/sitePlatformGoods/distinct", function(result) {
				if (result == "showPopup") {

					$(".vipPromptBox").popup();
					$('#Hui-article-box', window.top.document).css({
						'z-index' : '9'
					});
				}
			});

			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			initSfGrid();
			$('#setHeadersBtn').click(function() {
				$('.addHeaders').tableHeaderSetting({
					id : id,
					defaultId : defaultId,
					sfHeader : defaultHeader,
					sfSortColumns : sortHeader,
					tableHeaderSaveUrl : '${ctx}/operate/site/saveTableHeader'
				}).popup();
			});
			$('#employeName').select2();
			//2.监听父层按钮的动作
			$('#pngfix-nav-btn', parent.document).click(function() {
				//3.给定一个时间点
				setTimeout(function() {
					//4.再次执行全屏
					layer.restore(full_idx);
				}, 200);
			});

			$(".selection").css("width", "140px");

		});

		var hasConfirmPerm = false;
		var hasFaTiChengPerm = false;
		var hasEditMoney = false;
		<sf:hasPermission perm="ORDER_ORDERCOLLECTIONS_DETAIL_QRDZ_BTN">
		hasConfirmPerm = true;
		</sf:hasPermission>
		<sf:hasPermission perm="ORDER_ORDERCOLLECTIONS_DETAIL_FFTC_BTN">
		hasFaTiChengPerm = true;
		</sf:hasPermission>
		<sf:hasPermission perm="ORDER_ORDERCOLLECTIONS_DETAIL_EDITMONEY_BTN">
		hasEditMoney = true;
		</sf:hasPermission>

		//初始化jqGrid表格，传递的参数按照说明
		function initSfGrid() {
			var url = "${ctx}/order/orderCollections/orderCollectionsList";
			sfGrid = $("#table-waitdispatch").sfGrid({
				url : url,
				sfHeader : eval('${headerData.tableHeader}'),
				sfSortColumns : '${headerData.sortHeader}',
				postData : $("#searchForm").serializeJson(),
				//shrinkToFit: true,
				multiselect : false,
				rownumbers : true,
				gridComplete : function() {
					_order_comm.gridNum();
				},
				loadComplete : function() {
					$.ajax({
						type : "post",
						url : "${ctx}/order/orderCollections/sumAmount",
						data : $("#searchForm").serializeJson(),
						success : function(result) {
							if (result != null && result != "") {
								var sum1 = result.sumamount;
								var sum2 = result.sumcommission;
								if (sum1 != null && sum1 != "") {
									$("#amoutsum").html(parseFloat(sum1).toFixed(2));
								} else if (sum1 == null || sum1 == "") {
									$("#amoutsum").html(parseFloat(0).toFixed(2));
								} else {
									$("#amoutsum").html(parseFloat(0).toFixed(2));
								}
								if (sum2 != null && sum2 != "") {
									$("#commissionsum").html(parseFloat(sum2).toFixed(2));
								} else if (sum2 == null || sum2 == "") {
									$("#commissionsum").html(parseFloat(0).toFixed(2));
								} else {
									$("#commissionsum").html(parseFloat(0).toFixed(2));
								}
							} else {
								$("#amoutsum").html(parseFloat(0).toFixed(2));
								$("#commissionsum").html(parseFloat(0).toFixed(2));
							}
						}
					});
					$('#table-waitdispatch .proofImg').each(function() {
						$(this).imgShow({
							hasIframe : true
						});
					});
				}
			});
		}
		$('.fftc .proofImg').imgShow();
		function fmtPin(rowData) {
			var imgPath = '${commonStaticImgPath}' + rowData.imgs;
			return '<span class="proofImg"><a class="c-0383dc">凭证</a> <img src="'+imgPath+'" /> </span>';
		}

		function optionOper(rowData) {
			var ret = "";
			if (rowData.confirm === '0' && hasConfirmPerm) {
				ret += "<span class='w-50' ><a onclick='confirmdz(\"" + rowData.id + "\",\"" + rowData.payment_type + "\",\"" + rowData.payment_amount
						+ "\")' class='c-0383dc ' ><i class='sficon1 sficon-qrdz'></i>确认到账</a>";
			}
			if (ret.length > 0) {
				ret += "&nbsp;&nbsp;"
			}
			ret += "<span class='w-50' ><a onclick='getDetails(\"" + rowData.id + "\")' class='c-0383dc ' ><i class='sficon sficon-view'></i>详情</a>";
			if (rowData.commission_status === '0' && hasFaTiChengPerm) {
				if (ret.length > 0) {
					ret += "&nbsp;&nbsp;"
				}
				ret += "<a onclick='commission(\"" + rowData.id + "\")' class='c-0383dc' ><i class='sficon sficon-fftc'></i>发放提成</a></span>";
			}
			return ret;
		}

		function confirmOper(rowData) {
			if (rowData.confirm == '1') {
				return "<span>已到账</span>"
			} else {
				return "<span>未确认</span>"
			}
		}

		var cfflags = false;
		function confirmdz(id, type, amount) {
			if (cfflags) {
				return;
			}
			var content = "";
			if (type == '0') {
				content = "确认支付宝到账" + amount + "元";
			} else {
				content = "确认微信到账" + amount + "元";
			}
			$('body').popup({
				level : '3',
				type : 2,
				content : content,
				fnConfirm : function() {
					cfflags = true;
					$.ajax({
						type : "post",
						url : "${ctx}/order/orderCollections/confirmdz",
						data : {
							id : id
						},
						success : function(result) {
							if (result == "ok") {
								layer.msg("确认到账成功");
								search();
							} else {
								layer.msg("确认到账失败");
								return;
							}
							cfflags = false;
						}
					});
				}
			});

		}
		function getDetails(id) {
			$.ajax({
				type : "post",
				url : "${ctx}/order/orderCollections/getDetailbyid",
				data : {
					id : id
				},
				success : function(result) {
					$("#fftchead").text("详情");
					$("#timg").attr("src", '${commonStaticImgPath}' + result.columns.imgs);
					$("#tcommissionMoney").val("");
					if (result != null) {
						$("#commissionid").val(result.columns.id);
						$("#marksAdd").val(result.columns.marks);
						$("#temployeName").html(result.columns.employe_name);
						$("#temployeId").val(result.columns.employe_id);
						if (result.columns.employe_name == '0') {
							$("#tsource").html(" 工单收款");
						} else if (result.columns.employe_name == '1') {
							$("#tsource").html("商品订单收款");
						} else if (result.columns.employe_name == '2') {
							$("#tsource").html("其他项收款");
						} else if (result.columns.employe_name == '3') {
							$("#tsource").html("备件零售");
						} else {
							$("#tsource").html("");
						}
						if (result.columns.create_time != null) {
							$("#tcreateTime").html(timeStamp2String(result.columns.create_time));
						} else {
							$("#tcreateTime").html("");
						}
						if (result.columns.payment_type == '0') {
							$("#tpaymentType").html("支付宝");
						} else {
							$("#tpaymentType").html("微信");
						}
						$("#tdescription").html(result.columns.description);
						$("#tcustomerName").html(result.columns.customer_name);
						$("#tcustomerMobile").html(result.columns.customer_mobile);
						$("#tcustomerAddress").html(result.columns.customer_address);
						$("#tpaymentAmount").html(result.columns.payment_amount);
						if (result.columns.commission_status == '1') {
							$("#tcommissionMoney").val(result.columns.commission_money);
							//$("#tcommissionMoney").addClass("readonly");
							$("#tcjedivs").addClass("readonly");
							$("#tcommissionMoney").attr("readonly", true);
							$("#tcjediv").removeClass("hide");
							$("#qrff").addClass("hide");
							$("#cxff").removeClass("hide");
							$("#qrqx").removeClass("hide");
							$("#bcbz").show();
							$("#qrff").hide();
							$("#cxff").show();
						} else {
							$("#tcjediv").addClass("hide");
							$("#qrqx").addClass("hide");
							$("#cxff").hide();
							$("#qrff").hide();
							$("#bcbz").show();
						}
						$("#scszls").addClass("hide");
						$(".detailmarks").show();
						$("#detailssave").show();
						$('.fftc').popup();
					} else {
						layer.msg("查看失败");
						return;
					}
				},
				error : function(XMLHttpRequest, textStatus) {
				}
			});
		}

		var tempDis = false;
		function commission(id) {
			if (tempDis) {
				return;
			}
			tempDis = true;
			$.ajax({
				type : "post",
				url : "${ctx}/order/orderCollections/getDetailbyid",
				data : {
					id : id
				},
				success : function(result) {
					$("#fftchead").text("发放提成");
					$("#timg").attr("src", '${commonStaticImgPath}' + result.columns.imgs);
					$("#tcommissionMoney").val("");
					if (result != null) {
						$("#commissionid").val(result.columns.id);
						$("#temployeName").html(result.columns.employe_name);
						$("#temployeId").val(result.columns.employe_id);
						if (result.columns.employe_name == '0') {
							$("#tsource").html(" 工单收款");
						} else if (result.columns.employe_name == '1') {
							$("#tsource").html("商品订单收款");
						} else if (result.columns.employe_name == '2') {
							$("#tsource").html("其他项收款");
						} else if (result.columns.employe_name == '3') {
							$("#tsource").html("备件零售");
						} else {
							$("#tsource").html("");
						}
						if (result.columns.create_time != null) {
							$("#tcreateTime").html(timeStamp2String(result.columns.create_time));
						} else {
							$("#tcreateTime").html("");
						}
						if (result.columns.payment_type == '0') {
							$("#tpaymentType").html("支付宝");
						} else {
							$("#tpaymentType").html("微信");
						}
						$("#tdescription").html(result.columns.description);
						$("#tcustomerName").html(result.columns.customer_name);
						$("#tcustomerMobile").html(result.columns.customer_mobile);
						$("#tcustomerAddress").html(result.columns.customer_address);
						$("#tpaymentAmount").html(result.columns.payment_amount);
						$("#tcjediv").removeClass("hide");
						$("#tcommissionMoney").removeClass("readonly");
						$("#tcommissionMoney").removeAttr("readonly");
						$("#tcommissionMoney").parent("div").removeClass("readonly");
						$("#scszls").removeClass("hide");
						$("#qrqx").removeClass("hide");
						$("#cxff").addClass("hide");
						$("#qrff").show();
						$("#qrff").removeClass("hide");
						$("#scszls").find('.label-cbox4').addClass('label-cbox4-selected');
						$(".detailmarks").hide();
						$("#detailssave").show();
						$("#gbbc").show();
						$("#bcbz").hide();
						$('.fftc').popup();
						tempDis = false;
					} else {
						layer.msg("查看失败");
						return;
					}
				},
				error : function(XMLHttpRequest, textStatus) {
				}
			});
		}

		$('#created').on('click', function() {
			var flag = $(this).find('.label-cbox4').hasClass('label-cbox4-selected');
			if (flag) {
				$(this).find('.label-cbox4').removeClass('label-cbox4-selected');
			} else {
				$(this).find('.label-cbox4').addClass('label-cbox4-selected');
			}
		})
		var ffflag = false;
		function qrff() {
			if (ffflag) {
				return;
			}
			var marks = $("#marksAdd").val();
			var cid = $("#commissionid").val();
			var commissionvalue = $("#tcommissionMoney").val();
			var detailContent = $("#tdescription").html();
			var costProducerName = $("#temployeName").html();
			var costProducer = $("#temployeId").val();
			if (!commissionvalue.match(/^\d+(\.\d{1,2})?$/)) {
				layer.msg("发放金额格式不正确")
				$("#tcommissionMoney").focus();
				return;
			}
			var createType = '0';
			if ($("#created ").find('.label-cbox4').hasClass('label-cbox4-selected')) {
				createType = '1';
			}
			var ffflag = true;
			$.ajax({
				type : "post",
				url : "${ctx}/order/orderCollections/saveCommission",
				data : {
					id : cid,
					commissionMoney : commissionvalue,
					createType : createType,
					detailContent : detailContent,
					costProducerName : costProducerName,
					costProducer : costProducer,
					marks : marks

				},
				success : function(result) {
					if (result == "ok") {
						layer.msg("发放成功");
						search();
						$.closeDiv($(".fftc"));
					} else if (result == "ok2") {
						layer.msg("发放成功生成收支流水失败请重新发放");
						search();
						$.closeDiv($(".fftc"));
					} else {
						layer.msg("发放失败");
						return;
					}
					ffflag = false;
				}
			});

		}
		function cxff() {
			$("#fftchead").text("重新发放提成");
			$("#cxff").addClass("hide");
			$("#qrff").removeClass("hide");
			$("#tcommissionMoney").removeClass("readonly");
			$("#tcommissionMoney").removeAttr("readonly");
			$("#tcjedivs").removeClass("readonly");
			$("#scszls").find('.label-cbox4').addClass('label-cbox4-selected');
			$("#scszls").removeClass("hide");
			$("#bcbz").hide();
			$("#qrff").show();
		}

		function ffqx() {
			$("#tcommissionMoney").removeClass("readonly");
			$("#tcommissionMoney").removeAttr("readonly");
			$("#tcjedivs").removeClass("readonly");
			$.closeDiv($(".fftc"));
		}

		//0.工单收款  1.商品订单收款,2.其他项收款,3.备件零售
		function sourceOper(rowData) {
			if (rowData.source == '0') {
				return "<span>工单收款</span>";
			} else if (rowData.source == '1') {
				return "<span>商品订单收款</span>";
			} else if (rowData.source == '2') {
				return "<span>其他项收款</span>";
			} else if (rowData.source == '3') {
				return "<span>备件零售</span>";
			} else {
				return "";
			}
		}

		function cstatusOper(rowData) {
			if (rowData.commission_status == '1') {
				return "<span class='oState state-finished'>已提成</span>";
			} else {
				return "<span class='oState state-wtc'>未提成</span>";
			}
		}
		function search() {
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
			$("#table-waitdispatch").sfGridSearch({
				postData : $("#searchForm").serializeJson()
			});

		}

		function fmtOper(rowData) {
			if (rowData.payment_type == 0) {
				return "<span>支付宝</span>";
			} else if (rowData.payment_type == 1) {
				return "<span>微信</span>";
			} else {
				return "<span style='color:red'>异常！</span>";
			}

		}

		function exports() {
			var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
			var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
			if (idArr > 10000) {
				$('body').popup({
					level : 3,
					title : "导出",
					content : content,
					fnConfirm : function() {
						location.href = "${ctx}/order/orderCollections/export?formPath=/a/order/orderCollections/headList&&maps=" + $("#searchForm").serialize();
					}

				});
			} else {
				location.href = "${ctx}/order/orderCollections/export?formPath=/a/order/orderCollections/headList&&maps=" + $("#searchForm").serialize();
			}

		}

		$(".resetSearchBtn").on("click", function() {
			$("#employeName").select2('val', '请选择');
		});

		function jumpToVIP() {
			layer.open({
				type : 2,
				content : '${ctx}/goods/sitePlatformGoods/jumpVIP',
				title : false,
				area : [ '100%', '100%' ],
				closeBtn : 0,
				shade : 0,
				anim : -1
			});
		}

		//格式化时间
		function timeStamp2String(time) {
			var datetime = new Date();
			datetime.setTime(time);
			var year = datetime.getFullYear();
			var month = datetime.getMonth() + 1;
			var date = datetime.getDate();
			var hour = datetime.getHours();
			if (hour <= 9) {
				hour = "0" + hour;
			}
			var minute = datetime.getMinutes();
			if (minute <= 9) {
				minute = "0" + minute;
			}
			return year + "-" + month + "-" + date + " " + hour + ":" + minute;//+"."+mseconds;
		}

		function saveMarks() {
			var id = $("#commissionid").val();
			var marks = $("#marksAdd").val();
			$.ajax({
				type : "post",
				data : {
					id : id,
					marks : marks
				},
				url : "${ctx}/order/orderCollections/saveMarks",
				dataType : "json",
				success : function(data) {
					if (data == '200') {
						layer.msg('保存成功！');
						ffqx();
						search();
					} else {
						layer.msg('保存失败，请检查！');
					}
					return;
				},
				error : function() {
					layer.msg('保存失败，请检查！');
					return;
				}
			})
		}

		function shoukuanFormat(rowData) {
			var sts = rowData.confirm;
			if (sts === '0') {
				if (hasEditMoney) {
					return "<a onclick='shoukuanConfirm(\"" + rowData.id + "\",\"" + rowData.payment_amount + "\")'>" + rowData.payment_amount
							+ "<i class='sficon sficon-edit'></i></a>";
				} else {
					return "<a>" + rowData.payment_amount + "</a>";
				}
			} else {
				return "<a>" + rowData.payment_amount + "</a>";
			}
		}

		function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}

		function shoukuanConfirm(id, money) {
			$.ajax({
				type : "post",
				url : "${ctx}/order/orderCollections/getDetailbyid",
				data : {
					id : id
				},
				success : function(data) {
					$("#cooId").val(data.columns.id);
					$("#newMoney").val(data.columns.payment_amount);
					$('.confirmAccountpop').popup();
				}
			})
		}

		var reg = /^[1-9]{1}\d*(.\d{1,2})?$|^0.\d{1,2}$/;
		var newMark = false;
		function qurenAccount() {
			if (newMark) {
				return;
			}
			var id = $("#cooId").val();
			var money = $("#newMoney").val();
			if (isBlank(money)) {
				layer.msg("请填写收款金额！");
				$("#newMoney").focus();
				return;
			}
			if (!reg.test(money)) {
				layer.msg("收款金额格式有误！");
				$("#newMoney").focus();
				return;
			}
			newMark = true;
			$.ajax({
				type : "post",
				url : "${ctx}/order/orderCollections/confirmEditMoney",
				data : {
					id : id,
					money : money
				},
				success : function(data) {
					newMark = false;
					if (data == '450') {
						layer.msg("收款记录有误，请刷新后重试！");
					} else if (data == '451') {
						layer.msg("已确认到账，不可修改，请刷新后重试！");
					} else if (data == '460') {
						layer.msg("收款金额不得大于关联工单的收款总额！");
					} else if (data == '461') {
						layer.msg("收款金额不得大于关联商品订单的成交总额！");
					} else if (data == '462') {
						layer.msg("收款金额不得大于关联工单的收款总额！");
					} else if (data == '200') {
						quxiaoAccount();
						search();
						layer.msg("修改成功！");
					} else {
						layer.msg("修改失败，请稍后重试！");
					}
					return;
				},
				error : function() {
					newMark = false;
					layer.msg("修改失败，请稍后重试！");
					return;
				}
			})

		}

		function quxiaoAccount() {
			$.closeDiv($('.confirmAccountpop'));
		}
	</script>
</body>
</html>
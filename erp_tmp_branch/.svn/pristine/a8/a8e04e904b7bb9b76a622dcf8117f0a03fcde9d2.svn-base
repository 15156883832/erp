<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base" />
<meta charset="utf-8">

<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />

<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/css/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="${ctxPlugin}/static/h-ui.admin/css/style.css" />

<style>
div#Validform_msg {
	z-index: 10000 !important;
}

.select-box {
	padding: 0;
}
</style>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage table-header-settable serverbrand">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICECATE_TAB" html='<a class="btn-tabBar " href="${ctx}/order/category/headerList">服务品类</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_SERVICEBRAND_TAB" html='<a class="btn-tabBar" href="${ctx}/order/category/siteBrandRelList">服务品牌</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MSGORIGIN_TAB" html='<a class="btn-tabBar" href="${ctx}/order/orderOrigin">信息来源</a> '></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/malfunction">故障类型</a>'></sfTags:pagePermission>
						<%-- <a class="btn-tabBar" href="${ctx}/order/commonsetting/settingtable">语音提醒</a> --%>
					</div>
					<form id="searchForm" action="${ctx}/order/malfunction/getlist"
						method="post">
						<input type="hidden" id="pageNo" name="page"
							value="${page.pageNo }"> <input type="hidden"
							id="pageSize" name="rows" value="${page.pageSize }"> <input
							type="hidden" name="categroy" value="${caId}">
						<div class="mb-10 cl">
							<label class="">故障类别：</label> <input type="text" name="type"
								class="input-text w-160" value="${type}"> <a
								href="javascript:search();" class="sfbtn sfbtn-opt ml-30"><i
								class="sficon sficon-search"></i>查询</a>
						</div>
					</form>

					<div class="tabBarP mt-15 pos-r h-30 pr-80" id="tabBarP">
					<ul class="tabswitch_list" id="tabswitch_list">
						<c:forEach items="${cate }" var="cates">
						
							<c:if test="${cates.columns.id eq caId}">
								<li><a class="tabswitch current" id="tabswitchCurrent"
									href="${ctx }/order/malfunction/getlist?categroy=${cates.columns.id }">${cates.columns.name }</a></li>
							</c:if>
							<c:if test="${cates.columns.id != caId}">
								<li><a class="tabswitch"
									href="${ctx}/order/malfunction/getlist?categroy=${cates.columns.id}">${cates.columns.name }</a></li>
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

					<div class=" mt-10">
					<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_ADD_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" id="btn-add"><i class="sficon sficon-add"></i>新增</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_UPDATE_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" id="btn-edit"><i class="sficon sficon-edit"></i>修改</a> '></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="SYSSETTLE_ORDERMSGSET_MALTIONTYPE_DELETE_BTN" html=' <a href="javascript:;" class="sfbtn sfbtn-opt" id="btn-delete"><i class="sficon sficon-rubbish"></i>删除</a>'></sfTags:pagePermission>
						
						 
						
					</div>

					<div class="mt-10 table-malfunction">
						<table class="table table-bg table-border table-bordered"
							style="table-layout: fixed;">
							<thead>
								<tr class="text-c">
									<th width="20px"></th>
									<th width="100px">故障类别</th>
									<th width="200px">故障原因</th>
									<th width="140px">解决方案</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${page.list }" var="item" varStatus="sta">
									<tr>
										<td class="text-c"><label for="gzlb${sta.count }"
											class="radiobox"> <c:forEach items="${item}"
													var="item1">
													<input type="radio" id="gzlb${sta.count }" name="chk_trb"
														value="${item1.key}">
												</c:forEach>
										</label></td>
										<td class="text-c"><c:forEach items="${item}"
												var="item1">
							${item1.key}
							</c:forEach></td>
										<td class="no-pd"><c:forEach items="${item}" var="item2">
												<c:forEach items="${item2.value}" var="mal">
													<div class="trobletxt" style="text-align: center"
														id="${mal.userType }" title="${mal.description}">
														${mal.description }</div>
												</c:forEach>
											</c:forEach></td>
										<td class="no-pd"><c:forEach items="${item}" var="item2">
												<c:forEach items="${item2.value}" var="mal">
													<a href="javascript:;" class="btn-block c-0e8ee7 trobletxt"
														title="${mal.solution}" id="mal_${mal.id}">
														${mal.solution } </a>
												</c:forEach>
											</c:forEach></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="cl">
					<div class="f-l mt-10" >
							<c:if test="${not isSystem}">
							<span class="c-f55025">（注：<i class="icon-bg"></i>平台添加）
							</span>
						</c:if>
					</div>
					<div class="pagination">${page}</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 添加故障类别 -->
	<div class="popupBox faulttype addFaulttype" id="addGuzhang">
		<h2 class="popupHead">
			新增 <a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<form action="#" class="form-add-fitti" method="post">
			<div class="popupContainer pos-r">
				<div class="popupMain pt-10">
					<div class="pcontent maskbox-gzlb">
						<p class="txtwrap1 c-f55025 lh-26 mb-5">
							<label class="lb w-90">注：</label> 添加故障类别，点击如下<i
								class="sficon sficon-add2 ml-5 mr-5"></i>可以添加多条故障原因和解决方案
						</p>
						<input type="hidden" id="category" value="${caId}">
						<div class="txtwrap1 faulttype-input mb-10">
							<label class="lb c-0383dc w-90">故障类别：</label> <input type="text"
								class="input-text w-450" id="type" />
						</div>
						<div id="faultbox">
							<div class="faulttype-main txtwrap1 mb-10">
								<div class="faulttypebox w-450">
									<div class="txtabox">
										<label class="lh-26 lb">故障原因：</label> <input type="text"
											class="input-text" id="addDesc" name="description" />
									</div>
									<div class="txtabox mt-10">
										<label class="lh-26 lb">解决方案：</label>
										<textarea class="textarea h-50" id="addSolution"
											name="solution"></textarea>
									</div>
								</div>
								<div class="btnbox">
									<a class="sficon sficon-reduce2 mb-5"
										onclick="delFaulttype(this)" style="display: none;"></a> <a
										class="sficon sficon-add2" onclick="addFaulttype(this)"></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="text-c btnWrap">
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5 singleSubmit"
						id="btnAddFitting">保存</a> <a href="javascript:;"
						class="sfbtn sfbtn-opt w-70 mr-5" id="btn-add-cancel">取消</a>
				</div>
			</div>
		</form>
	</div>

	<!-- 修改故障类别 -->
	<div class="popupBox faulttype editFaulttype">
		<h2 class="popupHead">
			修改 <a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<form action="#" class="form-add-malfunction" method="post">
			<div class="popupContainer pos-r">
				<div class="popupMain pt-10">
					<div class="pcontent maskbox-gzlb">
						<!-- //maskbox-gzlb -->
						<div class="txtwrap1 faulttype-input mb-10">
							<label class="lb c-0383dc w-90">故障类别：</label> <input type="text"
								class="input-text w-450" id="xg-gzlbinput" datatype="*" /> <input
								type="hidden" id="xiugaiguzhang" />
						</div>
						<div id=gzyymain-xgbox></div>
					</div>
				</div>
				<div class="text-c btnWrap">
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"
						id="btn-yes-xg">保存</a> <a href="javascript:;"
						class="sfbtn sfbtn-opt w-70 mr-5" id="btn-edit-cancel">取消</a>
				</div>
			</div>
		</form>
	</div>

	<div class="popupBox faulttype delFaulttype">
		<h2 class="popupHead">
			删除故障类别 <a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<div class="popupMain pt-10">
				<div class="pcontent">
					<p class="c-f55025 lh-26 mb-5 pl-25">
						注：选中<i class="label-cbox3 label-cbox3-selected ml-5 "></i>
						删除对应的故障类别和解决方案，当故障原因和解决方案全部删除时，该故障类别也同时删除
					</p>
					<div class="txtwrap1 mb-10">
						<label class="lb w-90">故障类别：</label> <input type="text"
							class="input-text w-450 readonly" id="sc-gzlbinput"
							readonly="readonly" />
					</div>
					<div id="gzyymain-scbox"></div>
				</div>
			</div>
			<div class="text-c btnWrap">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"
					id="btn-del-yes">删除</a> <a href="javascript:;"
					class="sfbtn sfbtn-opt w-70 mr-5" id="btn-del-cancel">取消</a>
			</div>
		</div>
	</div>


	<div class="bottommask"></div>


	<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUp.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript"
		src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
	<!--<script src="static/h-ui.admin/js/easyui-revised.js" type="text/javascript" charset="utf-8"></script>-->

	<script type="text/javascript"
		src="${ctxPlugin}/lib/jquery-ui/jquery-ui-custom.min.js"></script>
	<script src="${ctxPlugin}/lib/drag2.js"></script>

	<script type="text/javascript">
		var editable = true;
		var isSystem = '${isSystem}' == 'true';
		var addMalF;
		var modMalF;
		var isSelectedAdding;/*标识是否是选中添加*/

		$(function() {

			//$(document).tooltip();//jQuery提示框
			$('.tabNav a').each(
					function(index) {
						$(this).click(
								function() {
									$('.tabNav a').removeClass('active').eq(
											index).addClass('active');
								});
					});
			
			$('#btn-del-cancel').on('click', function() {
				$.closeDiv($('.delFaulttype'));
			});

			$('#btn-edit-cancel').on('click', function() {
				$.closeDiv($('.editFaulttype'));
			});

			$('#btn-add-cancel').on('click', function() {
				$.closeDiv($('.addFaulttype'));
			});

			$('#btn-del-yes').on('click', function() {
				var ids = $('.label-cbox3-selected').map(function() {
					return $(this).prop('id').substr(4);
				}).get();
				if (!ids.length) {
					layer.msg("请选择要删除的故障!");
					return;
				}
				
				var loadingIndex = layer.load();
				 $.closeDiv($('.delFaulttype'));
				$.ajax({
					type : "POST",
					url : "${ctx}/order/malfunction/delSelectedMalfunction",
					data : {
						ids : ids
					},
					success : function() {
						$('.delFaulttype').hide();
						window.location.reload(true);
					},
					complete : function() {
						layer.close(loadingIndex);
						
					}
				});
			});

			// 打开“添加弹出框”
			$('#btn-add').click(function() {
						var thisTr = $('.table-bg').find('tr.active');//定义选中的那一行
						var index = $(thisTr).children('td').eq(2).children(
								'div').size();//定义选中故障原因的长度，即故障原因数据有多少条
						if (index > 0) {
							var type = $('input:radio[name="chk_trb"]:checked')
									.val();//如果添加之前有选中的话，即index大于0，将故障类别type赋值给新定义的type
							$("#type").val(type);//给添加类别弹出框中的字段故障类型type赋值，即选中添加的话故障类型已经固定且不可编辑
							$("#type").attr("disabled", "disabled");
							isSelectedAdding = true;
						} else {//没有选中添加的话字段故障类型type置空，且可编辑
							isSelectedAdding = false;
							$("#type").val('');
						}
						 $('.addFaulttype').popup({
							fixedHeight : false
						}); 
						$('.addFaulttype').css("display", "block");
						$(".bottommask").show();
					});

			$('.btn-xzgz').bind('click', function() {
				var _this = $(this);
				if (_this.hasClass("btn-xzyes")) {
					_this.removeClass("btn-xzyes");
				} else {
					_this.addClass("btn-xzyes");
				}
			});

			$(document).on(
					"click",
					".btn-xzgz",
					function() {
						var _this = $(this);
						if (_this.hasClass("btn-xzyes")) {
							_this.removeClass("btn-xzyes");
							_this.parent('.gzyymain').children('.gzyybox')
									.removeClass("del-active");
						} else {
							_this.addClass("btn-xzyes");
							_this.parent('.gzyymain').children('.gzyybox')
									.addClass("del-active");
						}
					});
			// 打开“修改”弹出框

			$('#btn-edit').click(function() {
				var type = $('input:radio[name="chk_trb"]:checked').val();
				if (isBlank(type)) {
					layer.msg("请选择一条数据");
				} else {
					$('#xg-gzlbinput').val(type);
					$('#xiugaiguzhang').val(type);
					editTrob();
				}
			});

			$('#btn-delete').click(
					function() {
						var thisTr = $('.table-bg').find('tr.active');
						var index = $(thisTr).children('td').eq(2).children(
								'div').size();
						if (index > 0) {
							var type = $('input:radio[name="chk_trb"]:checked')
									.val();
							delTrob();
							/* $('.delFaulttype').css({
								'left':'50%',
								'margin-left':-parseInt($('.delFaulttype').outerWidth()/2),
								"top":"50px"
							}); */
							$('.delFaulttype').popup({
								fixedHeight : false
							});
							$(".bottommask").show();
						} else {
							layer.msg("请选择一条数据");
						}
					});

			// 按钮栏高度设置
			$('.btns-menu').height(
					$('.table-bg').height() < 180 ? 180 : $('.table-bg')
							.height());

			// 点击表格，选中某一行
			$('input[name="chk_trb"]').each(
					function() {
						$(this).click(
								function() {
									if (!isSiteAdded($(this).closest("tr"))
											&& !isSystem) {
										layer.msg("平台添加不可修改");
										$(this).removeAttr('checked');
										return;
									}
									var fal = $(this).closest('label')
											.hasClass('checked');
									$("label").removeClass('checked');
									if (fal) {
										$(this).closest('label').attr("class",
												"bjdhx-lb");
										$(this).attr("checked", false);
									} else {
										$(this).closest('label').attr("class",
												"bjdhx-lb checked");
									}

									var flag = $(this).closest('tr').hasClass(
											'active');
									if (flag) {
										$(this).closest('tr').removeClass(
												'active');
									} else {
										$(this).closest('tbody').children('tr')
												.removeClass('active');
										$(this).closest('tr')
												.addClass('active');
									}
								});
					});
			
			setTablebb();
			$.tabBarList();
			initTableH();
			
		});

		function search() {
			$('#pageNo').val('1');
			$('#searchForm').submit();
		}

		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return;
		}

		window.onresize = function() {
			initTableH();
			
		}

		function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}

		function initTableH() {
			var tHeight = $('.sfpagebg').height() - 280;
			$('.table-malfunction').css({
				'max-height' : tHeight,
				'overflow' : 'auto',
			})
			
		}

		// 设置表格里面“故障原因” “解决方案”里的最后一个div和a没有底边
		function setTablebb() {
			$('.table-bg table').find('td.no-pd').children(
					'div:last-child,a:last-child').css({
				'border' : 'none'
			});
			
		}

		// 控制弹出框的高度
		function setGzlbH(obj, maxsize) {
			if (maxsize > 3) {
				$(obj).height(430);
				$(obj).css({
					'overflow' : 'auto',
					'padding-right' : '0'
				});
			} else {
				$(obj).css({
					'height' : 'auto',
					'padding-right' : '15px'
				});
			}
		}

		function editTrob() {
			var thisTr = $('.table-bg').find('tr.active');
			var index = $(thisTr).children('td').eq(2).children('div').size();
			if (index > 0) {
				$('#gzyymain-xgbox').empty();
				for (var i = 0; i < index; i++) {
					$('#gzyymain-xgbox')
							.append(
									'<div class="faulttype-main txtwrap1 mb-10">'
											+ '<div class="faulttypebox w-450">'
											+ '<div class="txtabox">'
											+ '<label class="lh-26 lb">故障原因：</label>'
											+ '<input type="text" class="input-text " name="xiugaiguzhang" value="'
											+ $.trim($(thisTr).children('td')
													.eq(2).children('div')
													.eq(i).html())
											+ '" datatype="*" />'
											+ '</div>'
											+ '<div class="txtabox mt-10">'
											+ '<label class="lh-26 lb">解决方案：</label>'
											+ '<textarea class="textarea  h-50" name="xiugaifangan" datatype="*" >'
											+ $.trim($(thisTr).children('td')
													.eq(3).children('a').eq(i)
													.text()) + '</textarea>'
											+ '</div>' + '</div>' + '</div>');
				}

				$(".bottommask").show();
				$('.editFaulttype').popup({
					fixedHeight : false
				});
			} else {
				layer.msg("请选择一条数据");
			}
			var maxsize = $('#gzyymain-xgbox .faulttype-main').size();//faulttypebox
			setGzlbH($('#gzyymain-xgbox').closest('.maskbox-gzlb'), maxsize);
		}

		function disableActions() {
			$('#btn-add').removeClass('btn-commom').addClass("btn-disabled");
			$('#btn-edit').removeClass('btn-commom').addClass("btn-disabled");
			$('#btn-delete').removeClass('btn-commom').addClass("btn-disabled");
		}

		function enableActions() {
			$('#btn-add').removeClass('btn-disabled').addClass("btn-commom");
			$('#btn-edit').removeClass('btn-disabled').addClass("btn-commom");
			$('#btn-delete').removeClass('btn-disabled').addClass("btn-commom");
		}

		function isSiteAdded(thisTr) {
			var tmp = thisTr.children('td').eq(2).children('div');
			var index = tmp.size();
			if (index > 0) {
				return $.trim(tmp.eq(0).attr("id")) != '1';
			}
			return false;
		}

		function delTrob() {
			var thisTr = $('.table-bg').find('tr.active');
			$('#sc-gzlbinput').val(
					$.trim($(thisTr).children('td').eq(1).text()));
			var index = $(thisTr).children('td').eq(2).children('div').size();
			$('#gzyymain-scbox').empty();
			for (var i = 0; i < index; i++) {
				$('#gzyymain-scbox')
						.append(
								'<div class="faulttype-main txtwrap1 mb-10">'
										+ '<div class="faulttypebox w-450">'
										+ '<div class="txtabox">'
										+ '<label class="lh-26 lb">故障原因：</label>'
										+ '<p class="faulttxt">'
										+ $(thisTr).children('td').eq(2)
												.children('div').eq(i).text()
										+ '</p>'
										+ '</div>'
										+ '<div class="txtabox ">'
										+ '<label class="lh-26 lb">解决方案：</label>'
										+ '<p class="faulttxt">'
										+ $(thisTr).children('td').eq(3)
												.children('a').eq(i).text()
										+ '</p>'
										+ '</div>'
										+ '</div>'
										+ '<a class="label-cbox3 fSelect " id="'
										+ $(thisTr).children('td').eq(3)
												.children('a').eq(i).attr('id')
										+ '"></a>' + '</div>');
			}
			var maxsize = $('#gzyymain-scbox .faulttype-main').size();
			setGzlbH($('#gzyymain-scbox').closest('.maskbox-gzlb'), maxsize);
		}

		$(document).on("click", ".label-cbox3", function() {
			var _this = $(this);
			if (_this.hasClass("label-cbox3-selected")) {
				_this.removeClass("label-cbox3-selected");
			} else {
				_this.addClass("label-cbox3-selected");
			}
		});

		/**
		 * 更新故障类别
		 */
		 $.closeDiv($('.editFaulttype'));
		modMalF = $('.form-add-malfunction')
		
				.Validform(
						{
							btnSubmit : "#btn-yes-xg",
							tiptype : function(msg) {
								if (msg != "") {
									layer.msg(msg);
								}
							},
							callback : function(form) {
								var xintype = $("#xg-gzlbinput").val();
								var result = "";
								var solution = "";
								var cate = $("#category").val();
								var type = $("#xiugaiguzhang").val();
								$('input[name="xiugaiguzhang"]').each(
										function() {
											if (result == "") {
												result = $(this).val();
											} else if ($(this).val() == "") {
												//					result = result;
											} else {
												result = result + "/"
														+ $(this).val();
											}
										});

								$('textarea[name="xiugaifangan"]').each(
										function() {
											if (solution == "") {
												solution = $(this).val();
											} else if ($(this).val() == "") {
												//					solution = solution;
											} else {
												solution = solution + "@"
														+ $(this).val();
											}
										});

								$
										.ajax({
											type : "POST",
											url : "${ctx}/order/malfunction/getupmal",
											//				data: "type=" + type + "&solution=" + solution + "&cate=" + cate + "&result=" + result + "&xintype=" + xintype,
											data : {
												type : type,
												solution : solution,
												cate : cate,
												result : result,
												xintype : xintype
											},
											//dataType: 'json',
											success : function(data) {
												if ("true" == data.ok) {
													//$('.curMaskbox-xggzlb').hide();
													layer.msg("修改成功");
													window.location.href = "${ctx}/order/malfunction/getlist?categroy="
															+ cate;
												} else if ("duplicate" == data.ok) {
													layer
															.msg("平台中已存在该故障类别，请勿重复添加！");
												} else {
													layer
															.msg("平台中已存在该故障类别，请勿重复添加！");
												}
											}
										});
								return false;
							}
						});

		// 添加故障类别 里面的：点击“-”删除刚添加的模块	
		function btnMingzClick(obj) {
			$(obj).closest('.gzyymain').remove();
			var maxsize = $('#gzyymain-box .gzyymain').size();
			$('#gzyymain-box .gzyymain').eq(maxsize - 1).find('.btn-addgz')
					.show();
			if (maxsize == 1) {
				$('#gzyymain-box .gzyymain').eq(0).find('.btn-mingz').hide();
			}
			setGzlbH($('#gzyymain-box').closest('.maskbox-gzlb'), maxsize);
			
		}

		// 添加故障类别 里面的：点击“-”删除刚添加的模块
		function delFaulttype(obj) {
			var oParent = $('#faultbox');
			$(obj).parents('.faulttype-main').remove();

			var childLenth = oParent.children().size();
			oParent.children().eq(childLenth - 1).find('a.sficon-add2').show();
			if (childLenth == 1) {
				oParent.children().eq(0).find('a.sficon-reduce2').hide();
			}
			$.setPos($('.faulttype'));
		}

		// 添加故障类别 里面的：店家“+”显示新的添加模块	
		function btnAddgzClick(obj) {
			addDivTroub();
			$(obj).hide();
			
		}

		// 添加故障类别 里面的：店家“+”显示新的添加模块
		function addFaulttype(obj) {
			var oParent = $('#faultbox');

			//对输入框中的值进行判断

			var html = '<div class="faulttype-main txtwrap1 mb-10">'
					+ '<div class="faulttypebox w-450">'
					+ '<div class="txtabox">'
					+ '<label class="lh-26 lb">故障原因：</label>'
					+ '<input type="text" class="input-text" name="description" datatype="*" />'
					+ '</div>'
					+ '<div class="txtabox mt-10">'
					+ '<label class="lh-26 lb">解决方案：</label>'
					+ '<textarea class="textarea h-50" name="solution"  datatype="*"></textarea>'
					+ '</div>'
					+ '</div>'
					+ '<div class="btnbox">'
					+ '<a class="sficon sficon-reduce2 mb-5" onclick="delFaulttype(this)"></a>'
					+ '<a class="sficon sficon-add2" onclick="addFaulttype(this)"></a>'
					+ '</div>' + '</div>';
			oParent.append(html);
			$(obj).hide();
			$(obj).prev('a.sficon-reduce2').show();
			$.setPos($('.faulttype'));
		}

		$(function() {
			
			//.dragging();
			$(".editFaulttype").dragging();
			$(".delFaulttype").dragging();
			$(".trobletxt[id='1']").closest('tr').css("background-color",
					"#fcf8e3");

			$("#type").blur(function() {
				if (isSelectedAdding) {
					return;
				}

				var type = $('#type').val();
				var cate = $('#category').val();

				$.ajax({
					type : "POST",
					url : "${ctx}/order/malfunction/checktypeduplication",
					data : {
						type : type,
						cate : cate
					},
					//dataType: 'json',
					success : function(data) {
						if (data.exist) {
							layer.msg("故障类别已存在");
						}
					}
				});
			});
			
		});

		//添加故障类别中的保存
		$.closeDiv($('.addFaulttype'));
		addMalF = $('.form-add-fitti')
		
				.Validform(
						{
							btnSubmit : "#btnAddFitting",
							tiptype : function(msg) {
								if (msg != "") {
									layer.msg(msg);
								}
							},
							callback : function(form) {
								var result = "";
								var solution = "";
								var cate = $("#category").val();
								var type = $("#type").val();
								$('input[name="description"]').each(function() {
									if (result == "") {
										result = $(this).val();
									} else if ($(this).val() == "") {
										//					result = result;
									} else {
										result = result + "/" + $(this).val();
									}
								});

								$('textarea[name="solution"]').each(
										function() {
											if (solution == "") {
												solution = $(this).val();
											} else if ($(this).val() == "") {
												//					solution = solution;
											} else {
												solution = solution + "^"
														+ $(this).val();
											}
										});
								
										$.ajax({
											type : "POST",
											url : "${ctx}/order/malfunction/savemal",
											//				data : "type=" + type + "&cate=" + cate + "&result=" + result + "&solution=" + solution,
											data : {
												type : type,
												cate : cate,
												result : result,
												solution : solution,
												sel : isSelectedAdding
											},
											//dataType: 'json',
											success : function(data) {
												if ('true' == data.ok) {
													window.location.href = "${ctx}/order/malfunction/getlist?categroy="
															+ cate;
													$("#type").val("");
													$(
															'textarea[name="solution"]')
															.val("");
													$(
															'input[name="description"]')
															.val("");
													$('.addFaulttype').hide();
												} else if ("duplicate" == data.ok) {
													layer
															.msg("平台中已存在该故障类别，请勿重复添加！");
												} else {
													layer
															.msg("无法添加平台中已存在的故障类别");
												}
											}
										});

								return false;
							}
						});

		//  关闭弹出框，叉号
		$('.btn-closemask')
				.click(
						function() {
							var cate = $("#category").val();
							window.location.href = "${ctx}/order/malfunction/getlist?categroy="
									+ cate;
							$("#type").val("");
							$('textarea[name="solution"]').val("");
							$('input[name="description"]').val("");
							$(this).closest('.curMaskbox').hide();
							$(".bottommask").hide();
							$("#type").attr("disabled", false);
						});
	</script>
</body>
</html>
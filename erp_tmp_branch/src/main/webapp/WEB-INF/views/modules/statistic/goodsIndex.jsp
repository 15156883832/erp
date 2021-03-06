<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>商品库存</title>
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/highcharts.js"></script>
<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/exporting.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin }/static/h-ui.admin/css/easyui.css" />
<script src="${ctxPlugin }/static/h-ui.admin/js/jquery.easyui.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="STATISTIC_STOCKSTAT_STOCKSTORE_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/stockStat">备件库存</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="STATISTIC_STOCKSTAT_GOODSTORE_TAB" html='<a class="btn-tabBar current" href="${ctx}/statistic/goodsStat">商品库存</a>'></sfTags:pagePermission>
				</div>
				<form action="" id="cx" method="post">
					<div class="cl mt-10">
						<label class="">商品销售时间：</label>
						<input type="text" class="input-text easyui-combobox" style="width: 200px;" value="${saleTime }" id="saleTime" name="saleTime" />

						<label class=" w-90 text-r">商品类别：</label>
						<select class="select w-140" id="goodCategory" name="goodCategory">
							<option value="">--请选择--</option>
							<c:forEach var="cg" items="${categoryList}">
								<option value="${cg.columns.name }" <c:if test="${goodCatetgory == cg.columns.name }">selected="selected"</c:if>>${cg.columns.name }</option>
							</c:forEach>
						</select>
						<p class="f-r">
							<a href="javascript:search();" class="sfbtn sfbtn-opt" id="btn-search">
								<i class="sficon sficon-search"></i>
								查询
							</a>
							<sfTags:pagePermission authFlag="STATISTIC_STOCKSTAT_GOODSTORE_EXPORT_BTN"
								html='<a  onclick="return exports()"class="sfbtn sfbtn-opt"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
						</p>
					</div>
				</form>
				<div class="cl mt-10">
					<div class="col-6 bk-gray f-l spStockBox spStockBox2 pos-r" style="padding: 0;">
						<div class="pt-15 pb-15 bg-e7eff5">
							<div class="stockbox stockbox2">
								<p class="money">
									<strong>${goodsMap.stockInfo.columns.totalStock }</strong>
								</p>
								<p class="money-lb">库存总数</p>
							</div>
						</div>
						<div class="cl pt-10 pb-10">
							<div class="col-6 f-l text-c lh-30">
								<span class="f-13 c-666">公司：</span>
								<span class="f-16 c-0e8ee7">${goodsMap.stockInfo.columns.siteStocks }</span>
							</div>
							<div class="col-6 f-l text-c lh-30 bl">
								<span class="f-13 c-666">工程师：</span>
								<span class="f-16 c-0e8ee7">${goodsMap.stockInfo.columns.empStocks }</span>
							</div>
						</div>
					</div>
					<div class="col-6 f-l pl-1" style="padding-right: 0;">
						<div class="bk-gray spStockBox spStockBox3 pos-r">
							<div class="pt-15 pb-15 bg-e7eff5">
								<div class="stockbox stockbox3">
									<p class="money">
										<strong>￥${goodsMap.stockInfo.columns.totalMoney }</strong>
									</p>
									<p class="money-lb">库存成本</p>
								</div>
							</div>
							<div class="cl pt-10 pb-10">
								<div class="col-6 f-l text-c lh-30">
									<span class="f-13 c-666">公司：</span>
									<strong class="f-13 c-666">￥</strong>
									<span class="f-16 c-0e8ee7">${goodsMap.stockInfo.columns.siteMoney }</span>
								</div>
								<div class="col-6 f-l text-c lh-30 bl">
									<span class="f-13 c-666">工程师：</span>
									<strong class="f-13 c-666">￥</strong>
									<span class="f-16 c-0e8ee7">${goodsMap.stockInfo.columns.empMoney }</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="mt-10 text-c tableWrap" style="overflow: hidden; max-height: 700px;">
					<div class="tableLabel">
						<table class="table table-bg table-bordered table-sdrk" style="border-bottom: 0;">
							<thead>
								<tr>
									<th style="width: 10%;">序号</th>
									<th style="width: 15%;">商品名称</th>
									<th style="width: 15%;">商品类别</th>
									<th style="width: 15%;">商品编号</th>
									<th style="width: 15%;">库存总量</th>
									<th style="width: 15%;">销售数量</th>
									<th style="width: 15%;">销售金额（元）</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="tableBody">
						<table class="table table-border table-bordered" id="bjStock_table">
							<tbody class="">
								<c:forEach var="item" items="${goodsMap.list }" varStatus="idx">
									<tr>
										<td style="width: 10%;">${idx.index + 1 }</td>
										<td style="width: 15%;">${item.columns.good_name }</td>
										<td style="width: 15%;">${item.columns.good_category }</td>
										<td style="width: 15%;">${item.columns.good_number }</td>
										<td style="width: 15%;">${item.columns.stocks!=null ? item.columns.stocks : '0.00' }</td>
										<td style="width: 15%;">${item.columns.purchaseNum }</td>
										<td style="width: 15%;">${item.columns.saleMoney }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="tableLabel tableFoot">
						<table class="table table-border table-bordered">
							<tfoot class="bg-eee">
								<tr>
									<td style="width: 55%;">合计</td>
									<td style="width: 15%;">${goodsMap.stockInfo.columns.siteStocks }</td>
									<td style="width: 15%;">${goodsMap.stockInfo.columns.numTotal }</td>
									<td style="width: 15%;">${goodsMap.stockInfo.columns.moneyTotal }</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			initTableHeight();
		});

		window.onresize = function() {
			initTableHeight();
		}

		function initTableHeight() {
			var maxHeight = $('.sfpagebg').height() - 335;
			$('#bjStock_table tr').last().children('td').css({
				'border-bottom' : '0'
			});
			var tableHeight = $('#bjStock_table').height();
			if (tableHeight > maxHeight) {
				$('.tableBody').css({
					'height' : maxHeight,
					'overflow-y' : 'auto',
					'overflow-x' : 'hidden',
					'padding-left' : '17px',
					'position' : 'relative',
					'left' : '-17px',
					'width' : $('.tableBody').width() + 17,
				});
				$('#bjStock_table').width($('.tableLabel').width() - 1);
			}
		}

		function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}

		// $('#saleTime').combobox("getValues")
		//获取做选中的  valueField所对应的值
		$('#saleTime').combobox({
			valueField : 'id',
			textField : 'value',
			multiple : 'true',
			/* onChange: function (newVal,oldVal) {
				if(isBlank(newVal)){
					$('#saleTime').combobox('clear');
					$('#saleTime').combobox('setValue', {});
					return;
				}
				if(!isBlank(newVal)){
					var valArr = newVal.split(",");
					if(isBlank(valArr[valArr.length-1])){
						alert(1)
					}
				}
			},  */
			data : [/* {
									id: '',
									value: '请选择'
								}, */{
				id : '2017-1',
				value : '2017-1'
			}, {
				id : '2017-2',
				value : '2017-2'
			}, {
				id : '2017-3',
				value : '2017-3'
			}, {
				id : '2017-4',
				value : '2017-4'
			}, {
				id : '2017-5',
				value : '2017-5'
			}, {
				id : '2017-6',
				value : '2017-6'
			}, {
				id : '2017-7',
				value : '2017-7'
			}, {
				id : '2017-8',
				value : '2017-8'
			}, {
				id : '2017-9',
				value : '2017-9'
			}, {
				id : '2017-10',
				value : '2017-10'
			}, {
				id : '2017-11',
				value : '2017-11'
			}, {
				id : '2017-12',
				value : '2017-12'
			}, {
				id : '2018-1',
				value : '2018-1'
			}, {
				id : '2018-2',
				value : '2018-2'
			}, {
				id : '2017-3',
				value : '2017-3'
			}, {
				id : '2018-4',
				value : '2018-4'
			}, {
				id : '2018-5',
				value : '2018-5'
			}, {
				id : '2018-6',
				value : '2018-6'
			}, {
				id : '2018-7',
				value : '2018-7'
			}, {
				id : '2018-8',
				value : '2018-8'
			}, {
				id : '2018-9',
				value : '2018-9'
			}, {
				id : '2018-10',
				value : '2018-10'
			}, {
				id : '2018-11',
				value : '2018-11'
			}, {
				id : '2018-12',
				value : '2018-12'
			} ],
		});

		function exports() {
			var idArr = document.getElementById("bjStock_table").rows.length;
			var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
			if (idArr > 10000) {
				$('body').popup({
					level : 3,
					title : "导出",
					content : content,
					fnConfirm : function() {
						location.href = "${ctx}/statistic/exportsGoods?" + $("#cx").serialize();
					}

				});
			} else {
				location.href = "${ctx}/statistic/exportsGoods?" + $("#cx").serialize();
			}

		}

		function search() {
			var saleTime = $("#saleTime").val();
			var goodCategory = $('#goodCategory option:selected').val();
			window.location.href = "${ctx}/statistic/goodsStat?saleTime=" + saleTime + "&goodCategory=" + encodeURI(goodCategory);
		}

		function reset() {
			$("#saleTime").val('');
		}
	</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
<title>My JSP 'proLimitList.jsp' starting page</title>
<meta name="decorator" content="base" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css" />
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<style>
.dropdown-display {
	font-size: 12px
}

.dropdown-selected {
	margin-top: 4px
}
</style>
</head>

<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<a class="btn-tabBar  current"  href="${ctx}/fitting/fittingSecondStock/secondStockHeader">备件库存</a>
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
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">直营网点：</th>
										<td>
											<span class="w-140  readonly">
												<select class="select w-140" name="siteName" id="siteName">
													<!-- <option value="">请选择</option> -->
													<c:forEach var="cg" items="${secondSiteList}" varStatus="idx">
														<option <c:if test='${idx.index==0 }'>selected="selected"</c:if> value="${cg.columns.id }">${cg.columns.name }</option>
													</c:forEach>
												</select>
											</span>
										</td>
										<th style="width: 76px;" class="text-r">备件名称：</th>
										<td>
											<input type="text" class="input-text" name="fittingName" />
										</td>
										<th style="width: 76px;" class="text-r">备件条码：</th>
										<td>
											<input type="text" class="input-text" name="fittingCode" />
										</td>
										<th style="width: 76px;" class="text-r">备件型号：</th>
										<td>
											<input type="text" class="input-text" name="fittingModel" />
										</td>
										<td>
											<input type="checkbox" id="ifHasStocks" name="ifHasStocks" value="0" />
											&nbsp;有库存备件
										</td>
									</tr>
								</table>
							</div>
						</form>
						<div class="pt-10 pb-5 cl">
							<div class="f-l">
								<label>备件库存总数：</label>
								<span id="allStocks" class="c-0383dc">0</span>
							</div>
							<div class="f-r">
								<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
								<sfTags:pagePermission authFlag="SECONDFITTINF_ALLFITTINGSTOCKS_EXPORT_BTN"
									html='<a href="javascript:exports();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
							</div>
						</div>
						<div>
							<table id="table-waitdispatch" class="table"></table>
							<div class="cl pt-10">
								<div class="f-r">
									<div class="pagination"></div>
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
					<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 备件详情 -->
<div class="popupBox bjdetailbox" style="width:760px">
	<h2 class="popupHead">
		备件详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pd-20">
			<div class="cl mb-10">
                <input id="fttId" hidden="hidden" />
				<label class="f-l w-100"> 备件条码：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="code" readonly="readonly" unselectable="on" value="" id="barcode2"/>
				<label class="f-l w-100"> 备件名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="fname" readonly="readonly" unselectable="on" value="" />

				<label class="f-l w-100">备件品牌：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="brand" readonly="readonly" unselectable="on" value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100"> 备件型号：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="version" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 适用品类：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="category" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 备件类型：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="type" readonly="readonly"  unselectable="on"value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">计量单位：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="unit" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 入库数量：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="warning" readonly="readonly" unselectable="on" value="2" />
				<label class="f-l w-100"> 入库价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" name="sitePrice" readonly="readonly" unselectable="on" />
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">

				<label class="f-l w-100">工程师价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" name="employePrice" readonly="readonly" unselectable="on" />
					<span class="unit">元</span>
				</div>
				<label class="f-l w-100">零售价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" name="customerPrice" readonly="readonly" unselectable="on" />
					<span class="unit">元</span>
				</div>
				<label class="f-l w-100">库位：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="location" readonly="readonly" unselectable="on" value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">返还旧件：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="refundOldFlag" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 备件来源：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="supplier" readonly="readonly" unselectable="on" value="" />
			</div>

			<div class="cl mb-10">
				<label class="f-l w-100">二维码：</label>
				<div class="f-l w-140">
					<div class="imgbox " id="qrcode" style="border:0;"></div>
				</div>

				<label class="f-l w-100">图片：</label>
				<p id="imagesHtml">
				</p>
			</div>
			<div class="text-c pt-25">
			<!-- 	<a class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="lastFitting()">上一个</a>
				<a class="sfbtn sfbtn-opt w-70 mr-5" onclick="nextFitting()">下一个</a> -->
				<a href="javascript:showTiao();" class="sfbtn sfbtn-opt3 w-80 mr-5">打印二维码</a>
				<a href="javascript:closeDetail();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
			</div>
		</div>
	</div>
</div>


<!-- 备件形码 -->
<div class="popupBox jjcodebox">
	<h2 class="popupHead">
		配件二维码
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl pd-10 bk-gray w-460">
				<!-- 条码 -->
				<div class="f-l ml-10">
					<div style="width:110px; height:110px;" id="barcode"></div>
					<p id="tiaoCode" class="text-c">${fitting.code}</p>
				</div>
				<div class="f-l ml-10" >
					<p class=" mb-10 w-300 pos-r pl-50"><span class="pos w-50 text-r lh-22">名称：</span><span id="tiaoName" class="lh-20"></span> </p>
					<p class=" mb-10 w-300 pos-r pl-50 "><span class="pos w-50 text-r lh-22">型号：</span><span id="tiaoVersion" class="lh-20"></span> </p>
					<p class=" mb-10 w-300 pos-r pl-50 "><span class="pos w-50 text-r lh-22">品牌：</span><span id="tiaoBrand" class="lh-20"></span>&nbsp;库位：<span id="kuweiV" class="lh-20"></span></p>
					<p class="mb-10 w-300 pos-r pl-50 "><span class="pos w-50 text-r lh-22">适用：</span><span id="tiaoV" class="lh-20"></span></p>
				</div>
			</div>
			<div class="cl mt-10">
				<label class="f-l">打印份数：</label>
				<div class="priceWrap f-l w-100">
					<input class="input-text" value="1" id="number" onchange="checkField(this.value)"/>
					<span class="unit">份</span>
				</div>
			</div>
			<div class="text-c mt-15">
				<a  id="printStock" target="_blank" onclick="closeDivTiao()" class="sfbtn sfbtn-opt3 w-70 mr-5">打印</a>
				<a href="javascript:closeDivTiao();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
		</div>
	</div>
</div>
	<form action="${ctx}/printFitting/printStockList" id="printForm" target="_blank" method="post"></form>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript">
		var sfGrid;
		var id = '${headerData.id}';
		var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
		var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		var defaultId = '${headerData.defaultId}';

		$(function() {
			$.post("${ctx}/goods/sitePlatformGoods/distinct", function(result) {
				if (result == "showPopup") {

					$(".vipPromptBox").popup();
					$('#Hui-article-box', window.top.document).css({
						'z-index' : '9'
					});
				}
			});
			
			$("select[name='siteName']").select2();
			$(".selection").css("width", "140px");
			$(".resetSearchBtn").on("click", function() {
				$("#siteName").select2('val', '请选择');
				$("#ifHasStocks").checked=false;
				$("#ifHasStocks").val("0");
				clickIfHasStocks();
			});

			clickIfHasStocks();

			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			$('#setHeadersBtn').click(function() {
				$('.addHeaders').tableHeaderSetting({
					id : id,
					defaultId : defaultId,
					sfHeader : defaultHeader,
					sfSortColumns : sortHeader,
					tableHeaderSaveUrl : '${ctx}/operate/site/saveTableHeader'
				}).popup();
			});
			initSfGrid();
			checkNum();
		});
		
		function clickIfHasStocks(){
			$("#ifHasStocks").off('click');
			$("#ifHasStocks").on('click', function() {
				var val = $(this).val();
				if (val == '0') {
					$(this).val("1");
				}
				if (val == '1') {
					$(this).val("0");
				}
				search();
			});
		}

		function checkNum() {
			$.post("${ctx}/fitting/fittingSecondStock/getFittingAllStocks?" + $("#searchForm").serialize(), function(result) {
				$("#allStocks").text(result.allStocks);
			});
		}

		//初始化jqGrid表格，传递的参数按照说明

		function initSfGrid() {
			sfGrid = $("#table-waitdispatch").sfGrid({
				url : '${ctx}/fitting/fittingSecondStock/getSecondStockList',
				sfHeader : defaultHeader,
				sfSortColumns : sortHeader,
				postData:$("#searchForm").serializeJson(),
				multiselect: false,
				rownumbers : true,
				gridComplete : function() {
					_order_comm.gridNum();
				}
			});
		}

		function isBlank(val) {
			if (val == null || val == '' || val == undefined) {
				return true;
			}
			return false;
		}
		

		function fmtOper(rowData) {
			if (rowData.code) {
				return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">' + rowData.code + '</a>';
			} else {
				return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">--</a>';
			}
		}

		//是否原配转换为字符
		function fmtFitType(row) {
			if (row.type == 1) {
				return '配件';
			} else if (row.type == 2) {
				return "耗材";
			} else {
				return "";
			}
		}

		//是否原配转换为字符
		function fmtBxStatus(row) {
			if (row.warranty_type == '1') {
				return '保内';
			} else if (row.warranty_type == '2') {
				return "保外";
			} else {
				return "";
			}
		}

		function showDetail(id) {
			layer.open({
				type : 2,
				content : '${ctx}/fitting/getById?id=' + id,
				title : false,
				area : [ '100%', '100%' ],
				closeBtn : 0,
				shade : 0,
				fadeIn : 0,
				anim : -1
			});
		}

		function search() {
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
			$("#table-waitdispatch").sfGridSearch({
				postData : $("#searchForm").serializeJson(),
				gridComplete : function() {
					checkNum();
				}
			});
		}

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
		
		function exports(){
	        var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	        var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	        if(idArr>10000){
	            $('body').popup({
	                level:3,
	                title:"导出",
	                content:content,
	                fnConfirm :function(){
	                    location.href="${ctx}/fitting/fittingSecondStock/export?formPath=/a/fitting/fittingSecondStock/secondStockHeader&&maps="+$("#searchForm").serialize();
	                }

	            });
	        }else{
	            location.href="${ctx}/fitting/fittingSecondStock/export?formPath=/a/fitting/fittingSecondStock/secondStockHeader&&maps="+$("#searchForm").serialize();
	        }

	    }

		function fmtCode(rowData){
	        return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.code+'</a>';
	    }
		
		 function showDetail(id){
		        var a = document.getElementById("printStock");
		        a.removeAttribute("href");
		        $("#printStock").prop("href","${ctx}/printFitting/printStock?id="+id+"&number=1");
		        hrefs = "${ctx}/printFitting/printStock?id="+id;
		        $.ajax({
		            url:'${ctx}/fitting/stock/ajaxFittingById',
		            data:{id: id},
		            success:function(result){
		                var code=result.code;
		                var imgstr='';
		                if(!isBlank(result.img)){
		                    var images=result.img.split(",");
		                    for(var i=0;i<images.length;i++){
		                        if(!isBlank(images[i])){
		                            imgstr+="<div class='imgWrap f-l spimg1 mr-10' >";
		                            imgstr+="<img src='${commonStaticImgPath}"+images[i]+"'/>";
		                            imgstr+=" </div>";
		                        }
		                    }
		                }
		                $("#imagesHtml").empty().append(imgstr);
		                $("#imagesHtml .imgWrap").imgShow();

		                $(".bjdetailbox").find("#qrcode").empty();
		                $('.bjdetailbox').find("#qrcode").qrcode({width: 100, height: 100, text: code});
		                $(".bjdetailbox").find("input[name='code']").val(result.code);
		                $(".bjdetailbox").find("input[name='fname']").val(result.name);
		                $(".bjdetailbox").find("input[name='brand']").val(result.brand);
		                $(".bjdetailbox").find("input[name='version']").val(result.version);
		                $(".bjdetailbox").find("input[name='category']").val(result.suitCategory);
		                $("#fttId").val(result.id);
		                if(result.type==1){
		                    $(".bjdetailbox").find("input[name='type']").val("配件");
		                }else if(result.type==2){
		                    $(".bjdetailbox").find("input[name='type']").val("耗材");
		                }
		                $(".bjdetailbox").find("input[name='unit']").val(result.unit);
		                $(".bjdetailbox").find("input[name='warning']").val(result.warning);
		                $(".bjdetailbox").find("input[name='sitePrice']").val(result.sitePrice);
		                $(".bjdetailbox").find("input[name='employePrice']").val(result.employePrice);
		                $(".bjdetailbox").find("input[name='customerPrice']").val(result.customerPrice);
		                $(".bjdetailbox").find("input[name='location']").val(result.location);
		                if(result.refundOldFlag==0){
		                    $(".bjdetailbox").find("input[name='refundOldFlag']").val("不需要返还 ");
		                }else if(result.refundOldFlag==1){
		                    $(".bjdetailbox").find("input[name='refundOldFlag']").val("需要返还 ");
		                }
		                $(".bjdetailbox").find("input[name='supplier']").val(result.supplier);

		                $("#tiaoCode").html(result.code);
		                $("#tiaoName").html(result.name);
		                $("#tiaoVersion").html(result.version);
		                $("#tiaoBrand").html(result.brand);
		                $("#tiaoV").html(result.suitCategory);
		                if(isBlank(result.location)){
		                	$("#kuweiV").html('');
		                }else{
		                	$("#kuweiV").html(result.location);
		                }
		                var code=result.code;
		                $('#barcode').empty().qrcode({width: 110, height: 110, text:code});
		                $(".bjdetailbox").popup();
		            }
		        });
		    }
		 
		function closeDetail(){
	        $.closeDiv($('.bjdetailbox'));
	    }
		
		function showTiao(){
	        $(".jjcodebox").popup({level:2});
	    }
		
		function closeDivTiao(){
	        $.closeDiv($(".jjcodebox"));
	    }
		
		var che = /^[0-9]*[1-9][0-9]*$/;
	    function checkField(val){	
	    if(isBlank(val)){
	    	val=1;
	    }else if(!che.test(val)){
	    	layer.msg("请输入正确的格式！");
	    }
	    $("#printStock").prop("href",hrefs+"&number="+val);
	    
	    }
	</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>我的商品-公司库存</title>
<meta name="decorator" content="base" />
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css" />
<style type="text/css">
.webuploader-pick {
	background: none;
	color: #22a0e6;
	width: 90px;
	padding: 0;
	height: 20px;
}

.webuploader-pick img {
	width: 90px;
	height: 20px;
	position: absolute;
	left: 0;
	top: 0;
}

.SelectBG {
	background-color: #ffe6e2;
}

.dropdown-clear-all {
	line-height: 22px
}

.ceshistyle_label {
	padding-right: 10px;
	position: relative;
}

.ceshistyle_label:before {
	content: '：';
	position: absolute;
	right: 0;
	top: 0;
	width: 10px;
	text-align: center;
	line-height: 26px;
}

.dropdown-option[disabled] {
	color: #000000;
	background-color: #fff;
	cursor: default;
	text-decoration: none;
	font-weight: bold;
	background-color: #ddd
}

@media screen and (max-width:1600px){
    .pcontent{
height: 450px;overflow-y: auto;
    }
}
</style>
<title>公司库存</title>
</head>
<body class="">
	<!-- 零售 -->
	<div class="popupBox lingshou " style="display: block;overflow-y:auto;">
		<h2 class="popupHead">
			零售
			<a href="javascript:closeLsDiv();" class="sficon closePopup lsCloses"></a>
		</h2>
		<div class="popupContainer">
			<div class="pcontent">
				<div class="popupMain pl-15 pt-15 pb-10">
					<div class="sale_ mb-10">
						<div>
							<span>
								<em class="mark">*</em>
								销售人员：
							</span>
							<span class="f-l w-380 dropdown-sin-2 readonly" style="width: 330px;">
								<select class="select-box w-120 readonly" id="xiaoName" multiple="multiple" name="xiaoName" style="width: 140px">
									<option disabled class="check">网点人员</option>
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
						</div>
						<div class="f-r">
							<span>
								<em class="mark">*</em>
								下单时间：
							</span>
							<input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm ',maxDate:'%y-%M-%d %H:%m'})" style="width: 330px;"
								value="<fmt:formatDate value='${nowDate }' pattern='yyyy-MM-dd HH:mm'/>" id="placingOrderTime" name="placingOrderTime" class="input-text Wdate w-140">
						</div>
					</div>
					<div class="bg-e8f2fa pt-25 pr-15 pb-10 mb-20 laceBorder">
						<div class="cl mb-10">
							<label class="f-l w-90">
								<em class="mark">*</em>
								用户姓名：
							</label>
							<input type="text" class="input-text w-140 f-l bg-fff" maxlength="10" name="userName" id="lsCustomerName" />
							<label class="f-l w-100">
								<em class="mark">*</em>
								联系方式：
							</label>
							<input type="text" class="input-text w-140 f-l bg-fff" maxlength="20" name="mobile" id="lsCustomerMobile" />
							<label class="f-l w-90">详细地址：</label>
							<input type="text" class="input-text w-330 f-l bg-fff" name="address" id="lsCustomerAddress" />
						</div>
					</div>
					<div class="mb-15 price_jiao" style="overflow:auto;max-height:114px;">
						<table class="table table-bg table-border table-bordered table-sdrk text-c" style="table-layout: auto;">
							<thead>
								<tr>
									<th class="w-300">商品</th>
									<th class="w-100">库存</th>
									<th class="w-130">零售价</th>
									<th class="w-100">销售数量</th>
									<th class="w-110">成交价</th>
									<th class="w-100">操作</th>
								</tr>
							</thead>
							<tbody id="dataList">
								<c:forEach items="${defaultList }" var="dt" varStatus="idx">
									<tr>
										<td>
											<span>${dt.columns.name }</span>
											<input class="selectedId" value="${dt.columns.id }" hidden="hidden" />
										</td>
										<td>
											<span class="stocksmark">${dt.columns.stocks }</span>${empty dt.columns.unit ? '个' : dt.columns.unit  }
											<!-- 备用数据 -->
											<input class="deductType" value="${dt.columns.deduct_type}" hidden="hidden" />
											<input class="normalDeductAmount" value="${dt.columns.normal_deduct_amount}" hidden="hidden" />
											<input class="ratioDeductVal" value="${dt.columns.ratio_deduct_val}" hidden="hidden" />
											<input class="sitePrice" value="${dt.columns.site_price}" hidden="hidden" />
											<input class="employePrice" value="${dt.columns.employe_price}" hidden="hidden" />
											<input class="oneSalesCommissions" value="" hidden="hidden" />
											<input class="oneGoodsUnit" value="${dt.columns.unit}" hidden="hidden" />
										</td>
										<td>
											<c:choose>
												<c:when test="${dt.columns.rebate_flag==1 }">
													<!--如果 有折扣价-->
													<select class="select selecthas">
														<option value="${dt.columns.customer_price }">${dt.columns.customer_price }</option>
														<option value="${dt.columns.rebate_price }">${dt.columns.rebate_price }</option>
													</select>
												</c:when>
												<c:otherwise>
													<!--否则 -->  
										      	${dt.columns.customer_price }
										    </c:otherwise>
											</c:choose>
										</td>
										<td class="gModel">
											<span class="reduce">-</span>
											<span class="saleNum_">1</span>
											<span class="plus_">+</span>
										</td>
										<td class="gCategory">
											<div class="priceWrap f-l">
												<input type="text" class="input-text oneFinalPrice" value="${dt.columns.customer_price }" />
												<span class="unit">元</span>
											</div>
										</td>
										<td class="gUnit">
											<c:choose>
												<c:when test="${dt.columns.brand=='浩泽' }">
													— —
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${idx.last && idx.index==0 }">
															<!--如果 -->
															<img src="${ctxPlugin}/static/h-ui.admin/images/addItem.png" class="addmark" alt="" width="25">
														</c:when>
														<c:otherwise>
															<!--否则 -->
															<img src="${ctxPlugin}/static/h-ui.admin/images/delete_.png" class="reducemark" alt="" width="25" class="mr-20">
															<c:if test="${idx.last }">
																<img src="${ctxPlugin}/static/h-ui.admin/images/addItem.png" class="addmark" alt="" width="25">
															</c:if>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="cl mb-10 fourPrice">
						<label class="f-l w-80">成交总额：</label>
						<div class="priceWrap f-l w-140 readonly">
							<input type="text" class="input-text readonly" id="orderRealAmount" readonly="readonly" />
							<span class="unit" id="lsdanwei">元</span>
						</div>
						<label class="f-l w-100">
							<em class="mark">*</em>
							实收金额：
						</label>
						<div class="priceWrap f-l w-140">
							<input type="text" class="input-text" id="orderConfirmAmount" />
							<span class="unit">元</span>
						</div>
						<label class="f-l w-100">
							<em class="mark">*</em>
							提成金额：
						</label>
						<div class="priceWrap f-l w-140 readonly">
							<input type="text" class="input-text   readonly" id="orderSalesCommissions" readonly="readonly" />
							<span class="unit">元</span>
						</div>
						<label class="f-l w-80">当日支付：</label>
						<div class="priceWrap f-l w-140 readonly">
							<input type="text" class="input-text readonly" id="orderPaidCommissions" value="0.00" readonly="readonly" />
							<span class="unit">元</span>
						</div>
					</div>
					<div class="pt-10 cl mb-15 tichengTable" style="display: none;">
						<label class="f-l" style="width: 7%">提成明细：</label>
						<div class="f-l" style="min-width:855px; max-width: 855px;max-height:146px; overflow: auto;">
							<table class="bg-e8f2fa table-bg table-border table-bordered table-sdrk text-c mingxi" style='min-width:100%!important;'>
								<tbody id="tichengDetail">

								</tbody>
							</table>
						</div>
					</div>
					<div class="text-c " style="margin-top:20px;">
						<a href="javascript:saveSales();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
						<a href="javascript:closeLSpup();" id="quxiaoLsCancel" class="sfbtn sfbtn-opt w-70">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 零售 -->
	<div class="popupBox addgoodspopup ">
		<h2 class="popupHead">
			选择商品
			<a href="javascript:closeLsDiv();" class="sficon closePopup goodsListCloseup"></a>
		</h2>
		<div class="popupContainer">
			<div class="pcontent">
				<div class="popupMain pl-15 pt-15 pb-15">
					<form id="goodsListForm">
						<div class="mb-20 warnMsgContain">
							<div class="f-l mr-20">
								<span>商品名称：</span>
								<input type="text" id="goodsName" name="goodsName" class="priceWrap">
							</div>
							<!-- <div class="f-l mr-20"><span>商品类别：</span><input type="text" name="goodsCategory" class="priceWrap">
	                    </div>
	                    <div class="f-l mr-20"><span>商品编号：</span><input type="text" name="goodsNumber" class="priceWrap">
	                    </div> -->
							<input id="alreadySelectedIds" name="alreadySelectedIds" hidden="hidden" />
							<button type="button" class="sfbtn sfbtn-opt3 w-70 mr-5 f-r" onclick="getSiteGoodsList()">查询</button>
						</div>
					</form>
					<div class="mb-15 price_jiao" style="max-height: 250px; overflow: auto;">
						<table class="table table-bg table-border table-bordered table-sdrk text-c" style="table-layout: auto;">
							<thead>
								<tr>
									<th class="w-50"></th>
									<th class="w-300">商品名称</th>
									<th class="w-230">商品型号</th>
									<th class="w-100">库存</th>
								</tr>
							</thead>
							<tbody id="goodsList">

							</tbody>
						</table>
					</div>
					<!-- <p class="mark mb-30">
						备注：
						<br>
						商品库存为0时，点击选中商品时提示：您选中的商品无库存，请重新选择。
					</p> -->
					<div class="text-c ">
						<a href="javascript:addGoodsToSale();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
						<a href="javascript:closeLS();" id="quxiaoLsCancel" class="sfbtn sfbtn-opt w-70">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript">
    var tichengWays = '${saleSet}';//服务商提成计算方式
	$(function(){
		$(".lingshou").popup();
		dd = $('.dropdown-sin-2').dropdown({
	        // data: json2.data,
	        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
	        choice: function() {
	        }
	    }).data("dropdown");
		$('.dropdown-sin-2').bind('click', function(){ 
			/*工程师改变*/
			employeChanges();
		})
	    customerPriceChange(); 
	})
	
	/*工程师选择*/
	function employeChanges(){
    	var idAs = $("#xiaoName").val();
    	employes = idAs;
    	if(isBlank(idAs)){
    		$(".tichengTable").hide();
    		return ;
    	}
    	if($.trim(idAs) != "" && idAs != null && idAs != undefined ){
		    var nameArr = $(".dropdown-display").attr("title").split(',');
		    var html = "";
		    var ht1 = '<td rowspan="2"></td>';
		    var ht2 = '';
		    
		    for(var j=0;j<nameArr.length;j++){
		    	ht1 += '<td colspan="2" empIdOne = "'+idAs[j]+'">'+nameArr[j]+'</td>';
		    	ht2 += '<td>提成</td>'+
                      '<td>当日支付</td>';
		    }
		    html +='<tr>'+ht1+'</tr>'+'<tr>'+ht2+'</tr>';
		    
		    var data = getDateListDetail();
		    for(var i=0;i<data.length;i++){
		    	var oneSalesCommision = (parseFloat(data[i].oneSalesCommissions)/nameArr.length).toFixed(2);
		    	html +='<tr><td class="w-100" tdIds="'+data[i].id+'">'+data[i].name+'</td>';
    			for(var h=0;h<nameArr.length;h++){
    				html +=   '<td class="w-100">'+
				                '<div class="priceWrap">'+
				                    '<input type="text" value="'+oneSalesCommision+'" class="input-text everyTicheng"/>'+
				                    '<input class="adjustGoodsId" value="'+data[i].id+'" hidden="hidden" />'+
				                    '<span class="unit">元</span>'+
				                '</div>'+
				            '</td>'+
				            '<td class="w-100">'+
				                '<input type="checkbox" class="drzfmark">'+
				                '<div class="priceWrap dangri hide" style="display:none;">'+
                                    '<input type="text" class="input-text dangrizhifu"/>'+
                                    '<span class="unit">元</span>'+
                                '</div>'
				            '</td>';
    			}
    			html += '</tr>';
		    }
		    $("#tichengDetail").empty().append(html);
    	}
    	/*处理提成明细列表中的价格问题*/
    	dealTechengListPrice();
    	//if($('.mingxi td[colspan="2"]').length>2){
   		$('.mingxi').css('width',400+$('.mingxi td[colspan="2"]').length*300+'px');
    	//}
    	$(".tichengTable").show();
	}
    
	/*处理提成明细列表中的价格问题*/
	function dealTechengListPrice(){
		$(".drzfmark").off("click");
		$(".drzfmark").on("click",function(){
			if($(this).is(':checked')){
				$(this).parent("td").find("div").eq(0).show();
			}else{
				$(this).parent("td").find("div").eq(0).hide();
			}
			$(this).parent("td").find(".dangrizhifu").val($(this).parent("td").prev("td").find(".everyTicheng").val());
			dealRemoveCheckedBox();
		});
		
		/*提成明细手动修改提成*/
		$(".everyTicheng").off("change");
		$(".everyTicheng").on("change",function(){
			if(isBlank($(this).val())){
				return layer.msg("提成金额不能为空！");
			}
			if(!checkMoney($(this).val())){
    			layer.msg("提成金额格式填写有误！");
    			$(this).focus();
    			return;
    		}
			if(parseFloat($(this).parent("div").parent("td").next("td").find(".dangrizhifu").val()) > parseFloat($(this).val())){
				if($(this).parent("div").parent("td").next("td").find(".drzfmark").is(':checked')){
					$(this).parent("div").parent("td").next("td").find(".dangrizhifu").focus();
					layer.msg("此工程师对应该商品的当日支付金额不能大于提成金额！");
					return false; 
				}
				
			}
			var allTicheng = 0;
			var goodsId = "";
			$(this).parent("div").parent("td").parent("tr").find("td").each(function(){
				if($(this).find(".priceWrap").find("input").eq(0).hasClass("everyTicheng")){
					var thisVal = $(this).find(".priceWrap").find("input").eq(0).val();
					allTicheng = parseFloat(parseFloat(allTicheng) + parseFloat(thisVal)).toFixed(2);
					goodsId = $(this).find(".priceWrap").find(".adjustGoodsId").val(); 
				};
			})
			$("#dataList").find("tr").each(function(){
				var listGoodsId = $(this).find("td").eq(0).find(".selectedId").val();
				if(goodsId==listGoodsId){
					$(this).find("td").eq(1).find(".oneSalesCommissions").val(allTicheng);
				}
				return;
			})
			var countTicheng = 0;
			$(".everyTicheng").each(function(){
				if(!isBlank($(this).val()) && checkMoney($(this).val())){
					countTicheng = (parseFloat(countTicheng)+parseFloat($(this).val())).toFixed(2);
				}
			})
			$("#orderSalesCommissions").val(countTicheng);
		});
		
		/*提成明细手动修改当日支付*/
		$(".dangrizhifu").off("change");
		$(".dangrizhifu").on("change",function(){
			if(!$(this).parent("div").parent("td").find("input").eq(0).is(':checked')){
				//dealRemoveCheckedBox();
				return;
			}
			if(!checkMoney($(this).val())){
    			layer.msg("当日支付金额格式填写有误！");
    			$(this).focus();
    			return;
    		}
			if(parseFloat($(this).parent("div").parent("td").prev("td").find(".everyTicheng").val()) < parseFloat($(this).val())){
				layer.msg("此工程师对应该商品的当日支付金额不能大于提成金额！");
				$(this).focus();
				return;
			};
			if(isBlank($(this).val())){
				layer.msg("当日支付金额不能为空！");
			}
			var drzfAll = 0;//当日支付总金额
			$(".dangrizhifu").each(function(){
				if($(this).parent("div").parent("td").find("input").eq(0).is(':checked')){
					if(!isBlank($(this).val()) && checkMoney($(this).val())){
						drzfAll = parseFloat(parseFloat(drzfAll) + parseFloat(isBlank($(this).val()) ? 0 : $(this).val() )).toFixed(2);
					}
				}
			})
			$("#orderPaidCommissions").val(drzfAll);
		});
	}
	
	function dealRemoveCheckedBox(){
		var drzfAll = 0;//当日支付总金额
		$(".dangrizhifu").each(function(){
			if($(this).parent("div").parent("td").find("input").eq(0).is(':checked')){
				if(!isBlank($(this).val()) && checkMoney($(this).val())){
					drzfAll = parseFloat(parseFloat(drzfAll) + parseFloat(isBlank($(this).val()) ? 0 : $(this).val() )).toFixed(2);
				}
			}
		})
		$("#orderPaidCommissions").val(drzfAll);
	}
    
    /*获取已经选择的商品的数据*/
    function getDateListDetail(){
    	var data = [];
    	var i=0;
    	$("#dataList").find("tr").each(function(){
    		var detail = {};
    		detail.name = $(this).find("td").eq(0).find("span").eq(0).text();
    		detail.id = $(this).find("td").eq(0).find("input").eq(0).val();
    		detail.oneSalesCommissions = $(this).find("td").eq(1).find(".oneSalesCommissions").val();
    		data[i] = detail;
    		i++;
    	})
    	return data;
    }
	
	function customerPriceChange(){
		/*减*/
		$(".reduce").off('click');
		$('.reduce').on('click', function () {
	        var num = $(this).next().text();
	        if (num > 1) {
	            num--;
	            $(this).next().text(num);
	            var customerPrice = 0;
		        if($(this).parent("td").parent("tr").find("td").eq(2).find("select").hasClass("select")){//有折扣价的时候
		        	customerPrice = $.trim($(this).parent("td").parent("tr").find("td").eq(2).find("select").val());
		        }else{
		        	customerPrice = $.trim($(this).parent("td").parent("tr").find("td").eq(2).text());
		        }
		        $(this).parent("td").parent("tr").find("td").eq(4).find("div").find("input").val(parseFloat(parseFloat(num) * parseFloat(customerPrice)).toFixed(2));
	        }else{
	        	//layer.msg("数量要求大于0！");
	        	
	        }
	        evaluatePrice();
	        /*改变数量，影响提成*/
	        var goodsId = $(this).parent("td").parent("tr").find("td").eq(0).find("input").eq(0).val(); //改变数量的商品的Id
	        var goodsSaleCommision = $(this).parent("td").parent("tr").find("td").eq(1).find(".oneSalesCommissions").val(); //提成
	        dealChangeNumsConnectTicheng(goodsId,goodsSaleCommision);
	        return;
	    });
		
		/*加*/
		$(".plus_").off('click');
	    $('.plus_').on("click",function (event) {
	        var num = $(this).prev().text();
	        var stocks = $(this).parent("td").parent("tr").find("td").eq(1).find("span").eq(0).text();
	        if(parseFloat(stocks) <= parseFloat(num)){
	        	layer.msg("销售数量不得大于库存数！");
	        	return;
	        }
	        num++;
	        $(this).prev().text(num);
	        var customerPrice = 0;
	        if($(this).parent("td").parent("tr").find("td").eq(2).find("select").hasClass("select")){//有折扣价的时候
	        	customerPrice = $.trim($(this).parent("td").parent("tr").find("td").eq(2).find("select").val());
	        }else{
	        	customerPrice = $.trim($(this).parent("td").parent("tr").find("td").eq(2).text());
	        }
	        $(this).parent("td").parent("tr").find("td").eq(4).find("div").find("input").val(parseFloat(parseFloat(num) * parseFloat(customerPrice)).toFixed(2));
	        evaluatePrice();
	        /*改变数量，影响提成*/
	        var goodsId = $(this).parent("td").parent("tr").find("td").eq(0).find("input").eq(0).val(); //改变数量的商品的Id
	        var goodsSaleCommision = $(this).parent("td").parent("tr").find("td").eq(1).find(".oneSalesCommissions").val(); //提成
	        dealChangeNumsConnectTicheng(goodsId,goodsSaleCommision);
	        return;
	    }); 
	    
	    /*价格改变*/
		$(".selecthas").change(function(){
			var num = $.trim($(this).parent("td").parent("tr").find("td").eq(3).find(".saleNum_").text());
			$(this).parent("td").parent("tr").find("td").eq(4).find("div").find("input").val(parseFloat(parseFloat(num) * parseFloat($(this).val())).toFixed(2));
			evaluatePrice();
			/*改变数量，影响提成*/
	        var goodsId = $(this).parent("td").parent("tr").find("td").eq(0).find("input").eq(0).val(); //改变数量的商品的Id
	        var goodsSaleCommision = $(this).parent("td").parent("tr").find("td").eq(1).find(".oneSalesCommissions").val(); //提成
	        dealChangeNumsConnectTicheng(goodsId,goodsSaleCommision);
		});
	    
	    /*删除一条商品*/
	    $(".reducemark").off('click');
	    $(".reducemark").on("click",function(){
	    	addReducemarkPosition(this);
	    	$(this).parent("td").parent("tr").remove();
	    	employeChanges();
	    	customerPriceChange();
	    });
	    
	    /*添加商品时*/
	    $(".addmark").off('click');
	    $(".addmark").bind("click",function(){
	    	getSiteGoodsList();
	    	$(".addgoodspopup").popup({level:2});
	    });
	    
	    /*列表成交价改变*/
	    $(".oneFinalPrice").change(function(){
	    	if(!isBlank($(this).val()) && checkMoney($(this).val())){
	    		evaluatePrice();
	    		employeChanges();
	    	}else{
	    		if(isBlank($(this).val())){
	    			layer.msg("请填写成交价！");
	    		}
	    		if(!checkMoney($(this).val())){
	    			layer.msg("成交价金额格式填写有误！");
	    			$(this).focus();
	    		}
	    		return;
	    	}
	    });
	    
	    /*初始化计算价格*/
	    evaluatePrice();
	}
	
	/*初始化计算价格*/
	function evaluatePrice(){
		var orderRealAmount = 0;//成交总额
		var orderConfirmAmount = 0;//实收金额
		var orderSalesCommissions = 0;//提成金额
		var orderPaidCommissions = 0;//当日支付 
		$("#dataList").find("tr").each(function(){
			var oneRealAmount = $(this).find("td").eq(4).find("div").find("input").eq(0).val();//列表成交价-单个商品的实收金额
			var oneDeductType = $(this).find("td").eq(1).find(".deductType").val();//这个商品的工程师提成方式
			var oneNormalDeductAmount = $(this).find("td").eq(1).find(".normalDeductAmount").val();//常规提成金额
			var oneRatioDeductVal = $(this).find("td").eq(1).find(".ratioDeductVal").val();//提成比例系数
			var oneSitePrice = $(this).find("td").eq(1).find(".sitePrice").val();//入库价格
			var oneEmployePrice = $(this).find("td").eq(1).find(".employePrice").val();//工程师价格
			var num = $(this).find("td").eq(3).find(".saleNum_").text(); //单个商品的数量
			var oneCustomerPrice = 0;
			if($(this).parent("td").parent("tr").find("td").eq(2).find("select").hasClass("select")){//有折扣价的时候
	        	oneCustomerPrice = $.trim($(this).parent("td").parent("tr").find("td").eq(2).find("select").val());
	        }else{
	        	oneCustomerPrice = $.trim($(this).parent("td").parent("tr").find("td").eq(2).text());
	        }
			orderRealAmount =( parseFloat(oneRealAmount) + parseFloat(orderRealAmount) ).toFixed(2);
			var oneSalesCommissions = 0;
			
			if(oneDeductType=='1'){ //提成方式为常规提成
				 oneSalesCommissions =( parseFloat(oneSalesCommissions) + parseFloat(oneNormalDeductAmount) * parseFloat(num) ).toFixed(2)
			}else{//比例提成
				oneSalesCommissions = ((parseFloat(oneRealAmount)-parseFloat(oneSitePrice)*parseFloat(num)) * parseFloat(oneRatioDeductVal) *0.01).toFixed(2);
				if(!isBlank(tichengWays)){//未设置商品利润计算方式
					if(tichengWays=='2'){
						oneSalesCommissions = ((parseFloat(oneRealAmount)-parseFloat(oneEmployePrice)*parseFloat(num)) * parseFloat(oneRatioDeductVal) *0.01).toFixed(2);
					}
					if(tichengWays=='3'){
						oneSalesCommissions = (parseFloat(oneRealAmount) * parseFloat(oneRatioDeductVal) *0.01).toFixed(2);
					}
				}
			}
			$(this).find("td").eq(1).find(".oneSalesCommissions").val(oneSalesCommissions);//单个工程师的提成
			console.log(oneSalesCommissions+","+orderSalesCommissions);
			orderSalesCommissions = (parseFloat(oneSalesCommissions) + parseFloat(orderSalesCommissions)).toFixed(2);
		})
		$("#orderRealAmount").val(orderRealAmount);//成交总额
		$("#orderConfirmAmount").val(orderRealAmount);//实收金额
		$("#orderSalesCommissions").val(orderSalesCommissions);
	}
	
	function getSiteGoodsList(){
		var ids = "";
		$("#dataList").find("tr").each(function(){
			if(isBlank(ids)){
				ids = $(this).find("td").eq(0).find("input").val();
			}else{
				ids += ","+ $(this).find("td").eq(0).find("input").val();
			}
		})
		$("#alreadySelectedIds").val(ids);
		$.ajax({
    		type:"post",
    		url:"${ctx}/goods/siteselfOrder/getSiteGoodsList",
    		dataType:"json",
    		data:$("#goodsListForm").serialize(),
    		success:function(data){
    			var html = "";
    			if(data.length > 0){
    				for(var i=0;i<data.length;i++){
    					var dt = data[i].columns;
    					var html1 = '<td><input style="width:18px;height:18px;"  type="checkbox"  value="'+dt.id+'" slStocks="'+dt.stocks+'"></td>';
    					if(parseFloat(dt.stocks) <= parseFloat(0)){
    						html1 = '<td><input type="checkbox" style="width:18px;height:18px;" class="disabledclass" value="'+dt.id+'" slStocks="'+dt.stocks+'"></td>';
    					}
    					html += '<tr>'+html1+
			                        '<td> '+dt.name+'</td>'+
			                        '<td>'+(isBlank(dt.model) ? '无' : dt.model)+'</td>'+
			                        '<td>'+dt.stocks+(isBlank(dt.unit) ? '个' : dt.unit)+'</td>'+
			                    '</tr>';
        			}
    			}
    			$("#goodsList").empty().append(html);
    			$(".disabledclass").bind("click",function(){
    				layer.msg("您选中的商品无库存,请重新选择！");
    				return;
    			})
    		}
    	})
	}
	
	function isBlank(val){
		if(val==null || $.trim(val)=='' || val==undefined){
			return true;
		}
		return false;
	}
	
	function addReducemarkPosition(obj){
		var mark = "1";
		$(obj).parent("td").parent("tr").find("td").eq(5).find("img").each(function(){
			if($(this).hasClass("addmark")){
				mark = "2";
			}
		})
		if(mark=='2'){//自身有添加的标识
			$(obj).parent("td").parent("tr").prev("tr").find("td").eq(5).append('<img src="${ctxPlugin}/static/h-ui.admin/images/addItem.png" class="addmark" alt="" width="25">');
			if($("#dataList").find("tr").length==2){
				$(obj).parent("td").parent("tr").prev("tr").find("td").eq(5).find(".reducemark").remove();
			};
		}else{//自身无添加的标识
			if($("#dataList").find("tr").length==2){
				$(obj).parent("td").parent("tr").next("tr").find("td").eq(5).find(".reducemark").remove();
			};
		}
		customerPriceChange();
	}
	
	function closeLS(){
		$(".goodsListCloseup").trigger("click");
	}
	
	function closeLsDiv(){
		$("#goodsName").val('');
	}
	
	function getSelectedGoodsList(){
		var ids = "";
		var mark = "1";
		$("#goodsList").find("tr").each(function(){
			var id = $(this).find("td").eq(0).find("input").val();
			if($(this).find("td").eq(0).find("input").is(':checked')){
				var stocks = $(this).find("td").eq(0).find("input").attr("slStocks");
				if(parseFloat(stocks) <= parseFloat(0)){
					mark = "2";
				}
				if(isBlank(ids)){
					ids = id;
				}else{
					ids += ","+ id;
				}
			}
		});
		if(mark=='2'){
			layer.msg("您选中的商品无库存,请重新选择！");
			return "no";
		}
		return ids;
	}
	
	var addGoodsToSaleMark = false;
	function addGoodsToSale(){
		if(addGoodsToSaleMark){
			return;
		}
		var ids = getSelectedGoodsList();
		if(isBlank(ids)){
			layer.msg("请先选择您要添加的商品！");
			return;
		}
		addGoodsToSaleMark = true;
		$.ajax({
			type:"post",
    		url:"${ctx}/goods/siteselfOrder/getSelectedAddGoods",
    		dataType:"json",
    		data:{ids:ids},
    		success:function(data){
				var html = "";				
				if(data.length > 0){
					for(var i=0;i<data.length;i++){
						var dt = data[i].columns;
						var html1 = dt.customer_price;
						var html2 = "";
						if(i==data.length-1){
							html2 = '<img src="${ctxPlugin}/static/h-ui.admin/images/addItem.png" alt="" class="addmark"  width="25">';
						}
						if(dt.rebate_flag=='1'){
							html1 = '<select class="select selecthas">'+
							    		'<option value="'+dt.customer_price+'">'+dt.customer_price+'</option>'+
							    		'<option value="'+dt.rebate_price+'">'+dt.rebate_price+'</option>'+
							    	'</select>';
						}
						html += '<tr>'+
			                        '<td> <span>'+dt.name+'</span><input class="selectedId" value="'+dt.id+'" hidden="hidden" /></td>'+
			                        '<td><span class="stocksmark"> '+dt.stocks +'</span>'+ (isBlank(dt.unit) ? '个' : dt.unit)+
			                        	'<input class="deductType" value="'+dt.deduct_type+'" hidden="hidden"/>'+
		                            	'<input class="normalDeductAmount" value="'+dt.normal_deduct_amount+'" hidden="hidden"/>'+
		                            	'<input class="ratioDeductVal" value="'+dt.ratio_deduct_val+'" hidden="hidden"/>'+
		                            	'<input class="sitePrice" value="'+dt.site_price+'" hidden="hidden"/>'+
			                            '<input class="employePrice" value="'+dt.employe_price+'" hidden="hidden"/>'+
			                            '<input class="oneSalesCommissions" value="" hidden="hidden"/>'+
			                            '<input class="oneGoodsUnit" value="'+dt.unit+'" hidden="hidden" />'+
			                        '</td>'+
			                        '<td>'+html1+'</td>'+
			                        '<td class="gModel">'+
			                            '<span class="reduce">-</span><span class="saleNum_">1</span><span class="plus_">+</span>'+
			                        '</td>'+
			                        '<td class="gCategory">'+
			                            '<div class="priceWrap f-l">'+
			                                '<input type="text" value="'+dt.customer_price+'" class="input-text oneFinalPrice"/>'+
			                                '<span class="unit">元</span>'+
			                            '</div>'+
			                        '</td>'+
			                        '<td class="gUnit">'+
			                            '<img src="${ctxPlugin}/static/h-ui.admin/images/delete_.png" class="reducemark" alt="" width="25" class="mr-20">'+
			                            html2 + 
			                        '</td>'+
			                    '</tr>';
					}
				}
				$("#dataList").find(".addmark").remove();
				if($("#dataList").find("tr").length==1){
					$("#dataList").find("tr").find("td").eq(5).append('<img src="${ctxPlugin}/static/h-ui.admin/images/delete_.png" class="reducemark" alt="" width="25" class="mr-20">');
				}
				$("#dataList").append(html);
				customerPriceChange();
				employeChanges();
				addGoodsToSaleMark = false;
				$(".goodsListCloseup").trigger("click");
			},
			error:function(){
				alert("error");
			}
		})
	}
	
	/*改变商品数量，影响提成列表*/
	function dealChangeNumsConnectTicheng(goodsId,goodsSaleCommision){
		$("#tichengDetail").find("tr").each(function(){
			var gId = $(this).find("td").eq(0).attr("tdIds");
			if(gId == goodsId){
				var idAs = $("#xiaoName").val();
				if(!isBlank(idAs)){
					var oneSales = parseFloat(parseFloat(goodsSaleCommision)/idAs.length).toFixed(2);
					$(this).find(".everyTicheng").each(function(){
						$(this).val(oneSales);
					});
				}
			}
		})
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
	
	/*零售保存*/
	var saveSalesMark = false;
	function saveSales(){
		if(saveSalesMark){
			return;
		}
		var empIds = $("#xiaoName").val();
		var placingOrderTime = $("#placingOrderTime").val();
		var customerName = $("#lsCustomerName").val();
		var customerMobile = $("#lsCustomerMobile").val();
		var customerAddress = $("#lsCustomerAddress").val();
		var orderConfirmAmount = $("#orderConfirmAmount").val();//实收金额
		var orderRealAmount = $("#orderRealAmount").val();//成交总额
		var orderSalesCommissions = $("#orderSalesCommissions").val();//提成金额
		var orderSalesCommissions = $("#orderSalesCommissions").val();//提成金额
		var orderPaidCommissions = $("#orderPaidCommissions").val();//当日支付
		if(isBlank(empIds)){
			layer.msg("请选择销售人员！");
			return;
		}
		var nameArr = $(".dropdown-display").attr("title").split(',');
		if(isBlank(placingOrderTime)){
			layer.msg("请填写下单时间！");
			return;
		}
		if(isBlank(customerName)){
			layer.msg("请填用户姓名！");
			$("#lsCustomerName").focus();
			return;
		}
		if(isBlank(customerMobile)){
			layer.msg("请填写联系方式！");
			$("#lsCustomerMobile").focus();
			return;
		}
		if(isBlank(orderConfirmAmount)){
			layer.msg("请填写实收金额！");
			$("#orderConfirmAmount").focus();
			return;
		}
		if(!checkMoney(orderConfirmAmount)){
			layer.msg("实收金额格式有误！");
			$("#orderConfirmAmount").focus();
			return;
		}
		
		var oneTichengMark = "1";
		var allTicheng = 0;
		$(".everyTicheng").each(function(){
			var val = $(this).val();
			allTicheng = (parseFloat(allTicheng)+parseFloat(val)).toFixed(2);
			if(isBlank(val)){
				$(this).focus();
				oneTichengMark = "2";
				return false; 
			}
			if(!checkMoney($(this).val())){
				$(this).focus();
				oneTichengMark = "3";
				return false; 
			}
		})
		if(oneTichengMark=="2"){
			layer.msg("工程师提成金额不能为空！");
			return;
		}
		if(oneTichengMark=="3"){
			layer.msg("工程师提成金额格式有误！");
			return;
		}
		var dangrizhifuMark = "1";
		$(".dangrizhifu").each(function(){
			var obj = this;
			if(parseFloat($(this).parent("div").parent("td").prev("td").find(".everyTicheng").val()) < parseFloat($(this).val())){
				$(obj).focus();
				dangrizhifuMark = "4";
				return false; 
			}
			if($(this).parent("div").parent("td").find("input").eq(0).is(':checked')){
				if(isBlank($(obj).val())){
					$(obj).focus();
					dangrizhifuMark = "2";
					return false; 
				}
				if(!checkMoney($(obj).val())){
					$(obj).focus();
					dangrizhifuMark = "3";
					return false; 
				}
			}
		})
		if(dangrizhifuMark=="2"){
			layer.msg("工程师当日支付金额不能为空！");
			return;
		}
		if(dangrizhifuMark=="3"){
			layer.msg("工程师当日支付金额格式有误！");
			return;
		}
		if(dangrizhifuMark=="4"){
			layer.msg("此工程师对应该商品的当日支付金额不能大于提成金额！");
			return;
		}
		var data = {
				empIds:empIds,
				empNames:nameArr,
				empIdsStr:empIds.join(","),
				empNamesStr:nameArr.join(","),
				placingOrderTime:placingOrderTime,
				customerName:customerName,
				customerMobile:customerMobile,
				customerAddress:customerAddress,
				realAmount:orderRealAmount,
				confirmAmount:orderConfirmAmount,
				salesCommissions:allTicheng,
				paidCommissions:orderPaidCommissions
				
		};
		for(var i=0;i<8;i++){
			var obj = [];
			var m=0;
			$("#dataList").find("tr").each(function(){
				var needVal = $(this).find("td").eq(0).find(".selectedId").val();
				if(i==1){
					if($(this).find("td").eq(2).find("select").hasClass("select")){//有折扣价的时候
						needVal = $.trim($(this).find("td").eq(2).find("select").val());
			        }else{
			        	needVal = $.trim($(this).find("td").eq(2).text());
			        }
				}
				if(i==2){
					needVal = $(this).find("td").eq(3).find(".saleNum_").text();
				}
				if(i==3){
					needVal = $(this).find("td").eq(4).find(".oneFinalPrice").val();
				}
				if(i==4){
					needVal = $(this).find("td").eq(1).find(".oneSalesCommissions").val();
				}
				if(i==5){
					needVal = $(this).find("td").eq(0).find("span").eq(0).text();
				}
				if(i==6){
					needVal = isBlank($(this).find("td").eq(1).find(".sitePrice").val()) ? "0.00" : $(this).find("td").eq(1).find(".sitePrice").val();
				}
				if(i==7){
					needVal = isBlank($(this).find("td").eq(1).find(".oneGoodsUnit").val()) ? "no" : $(this).find("td").eq(1).find(".oneGoodsUnit").val();
				}
				obj[m]=needVal;
				m++;
			});
			if(i==0){
				data.goods1Id = obj;
			}
			if(i==1){
				data.goods2CustomerPrice = obj;
			}
			if(i==2){
				data.goods3Num = obj;
			}
			if(i==3){
				data.goods4RealNum = obj;
			}
			if(i==4){
				data.goods5SalesComm = obj;
			}
			if(i==5){
				data.goods5Name = obj;
			}
			if(i==6){
				data.goods5SitePrice = obj;
			}
			if(i==7){
				data.goods5Unit = obj;
			}
		}
		
		for(var i=0;i<4;i++){
			var obj = [];
			if(i==0){
				var n=0;
				$("#tichengDetail").find("tr").each(function(){
					var goodsId = $(this).find("td").attr("tdIds");
					if(!isBlank(goodsId)){
						obj[n] = goodsId;
						n++
					}
				})
				data.gNames=obj;
			}
			if(i==1){
				var n=0;
				var obj1=[]
				$("#tichengDetail").find("tr").eq(0).find("td").each(function(){
					var empId = $(this).attr("empIdOne");
					if(!isBlank(empId)){
						obj[n] = empId;
						obj1[n] = $(this).text();
						n++;
					}
				})
				data.eIds=obj;
				data.eNames = obj1;
			}
			if(i==2){
				var n=0;
				$("#tichengDetail").find("tr").each(function(){
					if($(this).find("td").eq(1).find("div").find("input").eq(0).hasClass("everyTicheng")){//找到有提成的tr
						$(this).find("td").each(function(){//遍历其中的td
							if($(this).find("div").find("input").eq(0).hasClass("everyTicheng")){//找到存在提成的td
								obj[n] = $(this).find("div").find("input").eq(0).val();
								n++;
							}
						})
					}
				})
				data.gOneTch=obj;
			}
			if(i==3){
				var n=0;
				$("#tichengDetail").find("tr").each(function(){
					if($(this).find("td").eq(1).find("div").find("input").eq(0).hasClass("everyTicheng")){//找到有提成的tr,因为有提成得到也一定会有当日支付
						$(this).find("td").each(function(){//遍历其中的td
							if($(this).find("input").eq(0).hasClass("drzfmark")){//找到存在当日支付的td
								if($(this).find("input").eq(0).is(':checked')){//选中了当日支付
									obj[n] = $(this).find(".dangrizhifu").val();
								}else{//未选中当日支付
									obj[n] = "0.00";
								}
								n++;
							}
						})
					}
				})
				data.gOneDrzf=obj;
			}
		}
		saveSalesMark = true;
		$.ajax({
			post:"post",
			url:"${ctx}/goods/siteselfOrder/saveSales",
			data:data,
			dataType:"json",
			traditional:true,
			success:function(result){
				saveSalesMark = false;
				var code = result.code;
				if(code=='420'){
					layer.msg("商品信息有误！");
				}else if(code=='421'){//库存不足
					layer.msg(result.errMsg);
				}else if(code=='200'){
					parent.parent.layer.msg("保存成功！");
					parent.search();
					$(".lsCloses").trigger("click");
					
				}else{
					layer.msg("保存失败，请联系管理员！");
				}
				return;
			},
			error:function(){
				layer.msg("请稍后重试,error!");
				saveSalesMark = false;
				return;
			}
		})
	}
	
	function closeLSpup(){
		$(".lsCloses").trigger("click");
	}
	
	
</script>
</body>
</html>
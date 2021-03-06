<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8" />
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />


<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>

<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<title>编辑商品</title>
</head>
<body >
	<div class="sfpagebg bk-gray pt-25 pl-25 pr-25 pb-80">
	<form id="tf">
		<div class="">
			<input type="hidden" name="yuanNumber" value="${siteSelf.columns.number }">
			<input type="hidden" name="id" value="${siteSelf.columns.id }"/>
			<input type="text" class="input-text w-140 f-l" hidden="hidden" value="${siteSelf.columns.number }"  id="oldNumber" name="oldNumber"/>
			<input type="hidden" name="source" value="${siteSelf.columns.source }"/>
			<input  hidden="hidden" name="oldStocks" id="oldStocks" value="${siteSelf.columns.stocks }"/>
			<input  hidden="hidden" name="createTime" id="createTime" value="${siteSelf.columns.create_time }"/>
			<div class="cl mb-15">
				<label class="lb w-100 text-r f-l">商品名称：</label>
				<input type="text " class="input-text f-l w-460 mustfill readonly" value="${siteSelf.columns.name }" <c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">readonly="readonly"</c:if>  id="name" name="name" />
			</div>
			<div class="cl mb-15 ">
				<label class="lb w-100 text-r f-l">商品图片：</label>
				<div class="f-l">
					<c:forEach items="${icons }" var="icn" varStatus="da">
						<div class="imgWrap1 f-l  mr-15" id="img${da.index}">
							<div class="imgWrap ">
								<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
									<a class="sficon btn-delimg"  onclick="deleteImg('img${da.index}')"></a>
								</c:if>
								<img  class="img" src="${commonStaticImgPath}${icn}" id="${commonStaticImgPath}${icn}" />
								<input type="hidden" value="${icn}" name="pickerImg" >
							</div>
						</div> 
					</c:forEach>
					<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
						<div class="imgWrap1 f-l  mr-15" id="Imgprocess">
							<div class="imgWrap " id="imgsAdd">
								<a class="btn-upload bk_dashed"></a>
							</div>
						</div>
					</c:if>
					
				</div>
				<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
					<span class="c-888 f-12 ml-10 mt-50 pt-10">建议主图上传图片大小：800*800px，最多5张</span>
				</c:if>
			</div>
		
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">基本信息：</strong></div>
			<div class="cl mb-10">
				<label class="w-180 f-l"> 商品编号：</label>
				<input type="text" class="f-l input-text w-300 mustfill" <c:if test="${siteSelf.columns.source==2 }">readonly="readonly"</c:if> <c:if test="${editNumber == 'ok' }">readonly="readonly"</c:if> placeholder="自动生成支持手动输入" value="${siteSelf.columns.number }" maxlength="20" id="number" name="number" />
				<label class="w-120 f-l">商品品牌：</label>
				<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
					<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.brand }"  maxlength="10" name="brand" />
				</c:if>
				<c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">
					<div class="priceWrap f-l w-300 readonly">
						<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.brand }" readonly="readonly" maxlength="10" name="brand" />
					</div>
				</c:if>
				
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">商品类别：</label>
				<select class="select f-l w-300" id="category" <c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">readonly="readonly"</c:if> name="category">
					<option value="">--请选择--</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }" <c:if test="${siteSelf.columns.category==cg.columns.name }">selected="selected"</c:if>>${cg.columns.name }</option>
					</c:forEach>
				</select>
				<label class="w-120 f-l">商品型号：</label>
				<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
					<input type="text" class="f-l input-text w-300" name="model" value="${siteSelf.columns.model }" maxlength="100" />
				</c:if>
				<c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">
					<div class="priceWrap f-l w-300 readonly">
						<input type="text" class="f-l input-text w-300" name="model" value="${siteSelf.columns.model }" readonly="readonly" maxlength="100" />
					</div>
				</c:if>
			</div>
			<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
				<div class="cl mb-10">
					<label class="w-180 f-l"> 库存数量：</label>
					<input type="text" class="f-l input-text w-300 mustfill " value="${siteSelf.columns.stocks }" id="gstocks" name="gstocks"  />
					<label class="w-120 f-l">商品单位：</label>
					<select id="punit" class="select f-l w-300" name="unit" onfocus="showTip();">
						<option value="">请选择</option>
						<c:forEach items="${units}" var="item">
							<option value="${item.name}" <c:if test="${siteSelf.columns.unit==item.name }">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="cl mb-10">
					<label class="w-180 f-l">库位：</label>
					<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.location }" maxlength="50" name="location" />
					<label class="w-120 f-l">是否上架：</label>
					<select class="select f-l w-300" name="sellFlag">
						<option value="1" <c:if test="${siteSelf.columns.sell_flag eq 1 }">selected="selected"</c:if> >确认上架</option>
						<option value="2"<c:if test="${siteSelf.columns.sell_flag eq 2 }">selected="selected"</c:if> >暂不上架</option>
					</select>
				</div>
				<div class="cl mb-10">
					<label class="w-180 f-l">序号：</label>
					<input type="text" class="f-l input-text w-300" name="sortNum" value ="${siteSelf.columns.sort_num }"  />
					<c:if test="${siteSelf.columns.allowEdit=='ok' }">
						<label class="w-120 f-l ">保修期限：</label>
						<input type="text" class="f-l input-text w-300 readonly" maxlength="10" readonly="readonly" value="${siteSelf.columns.repair_term }" id="repairTerm" name="repairTerm" />
					</c:if>
					<c:if test="${siteSelf.columns.allowEdit!='ok' }">
						<label class="w-120 f-l ">保修期限：</label>
						<input type="text" class="f-l input-text w-300" maxlength="10" value="${siteSelf.columns.repair_term }" id="repairTerm" name="repairTerm" />
					</c:if>
				</div>
			</c:if>
			<c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">
				<div class="cl mb-10">
					<label class="w-180 f-l">商品单位：</label>
					<div class="priceWrap f-l w-300 readonly">
						<input type="text" class="f-l input-text w-300  " readonly="readonly" value="${siteSelf.columns.unit }" name="unit" />
					</div>
					<label class="w-120 f-l">是否上架：</label>
					<select class="select f-l w-300" name="sellFlag">
						<option value="1" <c:if test="${siteSelf.columns.sell_flag eq 1 }">selected="selected"</c:if> >确认上架</option>
						<option value="2"<c:if test="${siteSelf.columns.sell_flag eq 2 }">selected="selected"</c:if> >暂不上架</option>
					</select>
				</div>
				<div class="cl mb-10 ">
					<label class="w-180 f-l ">保修期限：</label>
					<input type="text" class="f-l input-text w-300" maxlength="10" value="${siteSelf.columns.repair_term }" id="repairTerm" name="repairTerm" />
				</div>
			</c:if>
			
			
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">价格信息：</strong></div>
			<div class="cl mb-10">
				<c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">
					<label class="w-180 f-l">官方指导价：</label>
					<div class="priceWrap f-l w-300 readonly">
						<input type="text" class="input-text" readonly="readonly"  id="gcustomerPrice" name="gcustomerPrice" value="${siteSelf.columns.customer_price }"/>
						<span class="unit">元</span>
					</div>
					<label class="w-120 f-l">建议零售价：</label>
					<div class="priceWrap f-l w-300 readonly">
						<input type="text" class="input-text" readonly="readonly"  id="grebatePrice" name="grebatePrice" value="${siteSelf.columns.rebate_price }"/>
						<span class="unit">元</span>
					</div>
					<input type='hidden' name="gsitePriceYing"  value="${siteSelf.columns.site_price }"/><!-- 入库价格 -->
				</c:if>
				<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
					<label class="w-180 f-l">入库价格：</label>
					<div class="priceWrap f-l w-300 mustfill">
						<input type="text" class="input-text" value="${siteSelf.columns.site_price }"  id="gsitePrice" name="gsitePrice" datatype="*" errormsg="格式错误" nullmsg="入库价格" />
						<span class="unit">元</span>
					</div>
					<label class="w-120 f-l">工程师价格：</label>
					<div class="priceWrap f-l w-300 mustfill">
						<input type="text" class="input-text" name="gemployePrice" value="${siteSelf.columns.employe_price }" />
						<span class="unit">元</span>
					</div>
				</c:if>
			</div>
			<div class="cl mb-10">
				<c:if test="${siteSelf.columns.name=='浩泽家用反渗透直饮机' }">
					<label class="w-180 f-l">促销奖励：</label>
					<div class="priceWrap f-l w-300 readonly ">
						<input type="text" class="input-text" readonly="readonly" value="${siteSelf.columns.rebate_price - siteSelf.columns.site_price }"  name="orderPrice"/>
						<span class="unit">元</span>
					</div>
				</c:if>
				<c:if test="${siteSelf.columns.name!='浩泽家用反渗透直饮机' }">
					<label class="w-180 f-l">零售价格：</label>
					<div class="priceWrap f-l w-300 mustfill">
						<input type="text" class="input-text"  id="gcustomerPrice" name="gcustomerPrice" value="${siteSelf.columns.customer_price }"/>
						<span class="unit">元</span>
					</div>
					<c:if test="${siteSelf.columns.rebate_flag eq 0 }">
						<label class="w-120 f-l">
							<a class="label-cbox4 " id="btn_discount"><input type="hidden" name="rebateFlag" value="0"/>折扣价格：</a>
						</label>
						<div class="priceWrap f-l w-300 readonly" id="discountWrap">
							<input type="text" class="input-text readonly" readonly="readonly" value="" name="grebatePrice" />
							<span class="unit">元</span>
						</div>
					</c:if>
					<c:if test="${siteSelf.columns.rebate_flag eq 1 }">
						<label class="w-120 f-l">
							<a class="label-cbox4 label-cbox4-selected" id="btn_discount"><input type="hidden" name="rebateFlag" value="1"/>折扣价格：</a>
						</label>
						<div class="priceWrap f-l w-300 " id="discountWrap">
							<input type="text" class="input-text " value="${siteSelf.columns.rebate_price }"  name="grebatePrice" />
							<span class="unit">元</span>
						</div>
					</c:if>
				</c:if>
			</div>
			
			<div class="cl mb-10" id="tcWrap">
				<label class="w-180 f-l">工程师提成：</label>
				<div class="mt-3 f-l w-300">
					<span class="radiobox <c:if test='${siteSelf.columns.deduct_type eq 1 }'>radiobox-selected</c:if> mr-10"><input type="radio" name="deductType" id="normal_tc" value="1" <c:if test='${siteSelf.columns.deduct_type eq 1 }'>checked="checked"</c:if> />固定金额 </span>
					<span class="radiobox <c:if test='${siteSelf.columns.deduct_type eq 2 }'>radiobox-selected</c:if>"><input type="radio" name="deductType" id="ratio_tc" value="2" <c:if test='${siteSelf.columns.deduct_type eq 2 }'>checked="checked"</c:if> />利润比例 </span>
				</div>
				<c:if test="${siteSelf.columns.deduct_type eq 1 }">
					<div class="f-l w-480 tcbox">
						<label class="w-120 f-l">提成金额：</label>
						<div class="priceWrap f-l w-300">
							<input type="text" class="input-text"  name="gnormalDeductAmount" value="${siteSelf.columns.normal_deduct_amount }" />
							<span class="unit">元</span>
						</div>
					</div>
					<div class="f-l hide tcbox " id="ratio_box">
						<label class="f-l w-120">利润提成比例：</label>
						<div class="priceWrap f-l w-160">
							<span><input type="text" class="input-text" name="ratioDeductVal" value="${siteSelf.columns.ratio_deduct_val }"/></span>
							<span class="unit">%</span>
						</div>
						<span class="c-f55025 f-l lh-26" id="salesSetMark">（利润 = 成交价  - 入库价格）</span>
					</div>
				</c:if>
				<c:if test="${siteSelf.columns.deduct_type eq 2 }">
					<div class="f-l hide w-480 tcbox">
						<label class="w-120 f-l">提成金额：</label>
						<div class="priceWrap f-l w-300">
							<input type="text" class="input-text"  name="gnormalDeductAmount" value="${siteSelf.columns.normal_deduct_amount }" />
							<span class="unit">元</span>
						</div>
					</div>
					<div class="f-l  tcbox " id="ratio_box">
						<label class="f-l w-120">利润提成比例：</label>
						<div class="priceWrap f-l w-160">
							<span><input type="text" class="input-text" name="ratioDeductVal" value="${siteSelf.columns.ratio_deduct_val }"/></span>
							<span class="unit">%</span>
						</div>
						<span class="c-f55025" id="salesSetMark">
							<c:if test="${salesSet.columns.set_value == '1' || salesSet == null }">（利润 = 成交价    - 入库价格）</c:if>
							<c:if test="${salesSet.columns.set_value == '2'}">（利润 = 成交价    - 工程师价格）</c:if>
							<c:if test="${salesSet.columns.set_value == '3'}">（利润 = 成交价  ）</c:if>
						</span>
					</div>
				</c:if>
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">京东比较链接：</label>
				<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.jd_seller_link }" name="jdSellerLink" />
				<label class="w-120 f-l">淘宝比较链接：</label>
				<input type="text" class="f-l input-text w-300" value="${siteSelf.columns.tmall_seller_link }" name="tmallSellerLink" />
			</div>
			
			
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">商品介绍：<strong></div>
			<div class="" style="margin: 0 auto; width: 1000px;">
				<div class="">
					<!-- 编辑器 -->
					<script id="container" name="content" type="text/plain">
       				 
   					</script>
					<textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
				</div>
			</div>
		</div>
	</form>
	<div class="btnsWrapFixbBg bgOpacity"></div>
	<div class="btnsWrapFixb pt-15 text-c">
		<a class="btnBlue pt-10 pb-10 lh-26 f-16 w-180 c-white radius mr-10"  id="saveClick" >保存</a>
		<a class="bg-eee pt-10 pb-10 lh-26 f-16 w-180 radius" onclick="quxiao()" >取消</a>
	</div>
</div>	

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
	var feedImgsCount = '${count}';
	$(function(){
		
		if(feedImgsCount>=5){
			$("#imgsAdd").hide();
		}
		//防止图片过宽
	  	fixImgWidth();
	  	ue = UE.getEditor('container',{ serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
			toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
	                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
	                      'simpleupload', 'insertimage', 'preview','fullscreen']],
	                      autoHeightEnabled: true,
	                      autoFloatEnabled: false,
	                      elementPathEnabled : false,
	                      initialFrameHeight: 150});
		ue.ready(function(){
			ue.setContent('${siteSelf.columns.html }');
			 // 阻止工具栏的点击向上冒泡
		    $(this.container).click(function(e){
		        e.stopPropagation();
		    });
		    // 解决悬浮问题
		    if (UE.browser.ie && UE.browser.version <= 7) {
	    		FixIe7Bug();
	    	}
		});
			
		createUploader("#imgsAdd","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");
		
		$('#btn_discount').on('click', function(){
			var isOn = $(this).hasClass('label-cbox4-selected');
			if( !isOn ){
				$(this).addClass('label-cbox4-selected');
				$(this).find('input').val('1');
				$("input[name='grebatePrice']").val('${siteSelf.columns.rebate_price }');
				$('#discountWrap').removeClass('readonly');
				$('#discountWrap').find('input').removeClass('readonly').removeAttr('readonly');
			}else{
				$(this).removeClass('label-cbox4-selected');
				$(this).find('input').val('0');
				$("input[name='grebatePrice']").val('');
				$('#discountWrap').addClass('readonly');
				$('#discountWrap').find('input').addClass('readonly').attr({'readonly':'readonly'});
			}
		})
		
		$('.radiobox').on('click', function(){
			var isOn = $(this).hasClass('radiobox-selected');
			var nowThis = $(this).find("input").val();
			if( !isOn ){
				$(this).closest('div').find('.radiobox').removeClass('radiobox-selected');
				$(this).closest('div').find('input[type="radio"]').prop({'checked':'false'});
				$('#tcWrap').find('.tcbox').hide();
				$(this).addClass('radiobox-selected');
				$(this).find('input[type="radio"]').prop({'checked':'true'});
				if(nowThis=='2'){
					$.ajax({
						type:"post",
						url:"${ctx}/goods/siteself/ajaxGetSalesSet",
						success:function(data){
							var msg="（利润 = 成交价   - 入库价格）";
							if(data!=null && data !=''){
								if(data.columns.set_value=="2"){
									msg="（利润 = 成交价   - 工程师价格）";
								}
								if(data.columns.set_value=="3"){
									msg="（利润 = 成交价   ）";
								}
							}
							$("#salesSetMark").text(msg);
						}
					});
				}
				$('#tcWrap').find('.tcbox').eq($(this).index()).show();
			}
		})
		
	})
	
	var adpoting = false;
	$(function(){
		$("#saveClick").bind("click",function(){
			if (adpoting) {
				return;
			}
			$("#html").val(ue.getContent());
			var tmallSellerLink = $("input[name='tmallSellerLink']").val();
			var jdSellerLink = $("input[name='jdSellerLink']").val();
			var name = $("input[name='name']").val();
			var category = $("select[name='category']").val();
			var gstocks = $("input[name='gstocks']").val();
			var gsitePrice = $("input[name='gsitePrice']").val();
			var gcustomerPrice = $("input[name='gcustomerPrice']").val();
			var icon = $("input[name='pickerImg']").val();
			var number = $("input[name='number']").val();
			//var rebateFlag = $("input[name='rebateFlag']").val();
			var grebatePrice = $("input[name='grebatePrice']").val();//折扣价格
			var gnormalDeductAmount = $("input[name='gnormalDeductAmount']").val();//提成金额
			var gemployePrice = $("input[name='gemployePrice']").val();//工程师价格
			var sortNum = $("input[name='sortNum']").val();//序号
			var repairTerm = $("input[name='repairTerm']").val();
			//var goodName='${siteSelf.columns.name }';
			if ($.trim(name) == '浩泽家用反渗透直饮机') {

				if (isBlank(category)) {
					layer.msg("请选择商品类别！");
					return;
				}
				adpoting = true;
				$.ajax({
					type : "post",
					traditional : true,
					url : "${ctx}/goods/siteself/doBJ",
					data : $("#tf").serializeJson(),
					success : function(result) {
						if (result == "ok") {
							layer.msg("修改成功！");
							//window.location.href="${ctx}/goods/siteself/WholeCompanySite";
							var liMark = $('#min_title_list li',window.top.document);
							liMark.each(function(idx,el){
								if($(el).hasClass("active")){
                                    var aCloseIndex = $(this).index();
                                    $(el).remove();
                                    //$('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();
                                    setTimeout(function(){
                                        $('#iframe_box',window.top.document).find('.show_iframe').eq(aCloseIndex).remove();
                                    }, 20);
								}
							});
							var name = "";
							var href = "";
							var hh = '${jp}';
							if(hh=='o1'){
								href="${ctx}/goods/siteselfOrder/headerList";
								name="订单信息";
							}
							if(hh=='o2'){
								href="${ctx}/goods/platFormOrder/headerList";
								name="订单信息";
							}
							if(hh=='s1'){
								href="${ctx}/goods/siteself/WholeCompanySite";
								name="公司库存";
							} 
							if(hh=='s22'){
								href="${ctx}/goods/siteself/BuyEmployeSite";
								name="工程师自购库存";
							} 
							if(hh=='o11'){
								href="${ctx}/goods/siteselfOrder/employeBuyBySelfOrder";
								name="订单信息";
							} 
							/* if(hh=='o1'){
								href="${ctx}/goods/siteself/WholeCompanySite";
								name="";
							} */
							updateOrCreate(name,href);
							return;
						} else if (result == "existNumber") {
							layer.msg("该商品编号已存在！！");
							$("input[name='number']").focus();
							return;
						} else if (result == "existPlatNumber") {
							layer.msg("该商品编号与平台合作商品的商品编号重复！");
							$("input[name='number']").focus();
							return;
						} else {
							layer.msg("修改失败，请检查！");
							return;
						}
					},
					complete : function() {
						adpoting = false;
					}
				})
			} else {
				if (isBlank(number)) {
					layer.msg('商品编号不能为空！！！');
					document.getElementById("number").focus();
					return false;
				}
				if (isBlank(name)) {
					layer.msg('商品名称不能为空！！！');
					document.getElementById("name").focus();
					return false;
				}
				if (isBlank(category)) {
					layer.msg('商品类别不能为空！！！');
					document.getElementById("category").focus();
					return false;
				}
				if (isBlank(gstocks)) {
					layer.msg('请输入新增数量！！！');
					document.getElementById("gstocks").focus();
					return false;
				}
				if (isBlank(gsitePrice)) { //入库价格
					layer.msg('请输入入库价格！！！');
					document.getElementById("gsitePrice").focus();
					return false;
				} else if (check(gsitePrice) == false) {
					layer.msg('输入的入库价格格式有误！！！');
					return false;
				}
				if (isBlank(gcustomerPrice)) { //零售价格
					layer.msg('请输入零售价格！！！');
					return false;
				} else if (check(gcustomerPrice) == false) {
					layer.msg('输入的零售价格格式有误！！！');
					return false;
				}
				if (isBlank(icon)) {
					layer.msg('请上传商品图片！！！');
					return false;
				}
				/* if (check(grebatePrice) == false) {
					layer.msg('输入的折扣价格格式有误！！！');
					return false;
				} */
				if(gnormalDeductAmount!=null && $.trim(gnormalDeductAmount)!=""){
					if (check(gnormalDeductAmount) == false) {
						layer.msg('输入的提成金额格式有误！！！');
						return false;
					}
				}
				if (check(gemployePrice) == false) {
					layer.msg('输入的工程师价格格式有误！！！');
					return false;
				}
				if (upZero(sortNum) == false) {
					layer.msg('输入的序号格式有误！！！');
					return false;
				}
				/* if (!checkURL(jdSellerLink)) {
					layer.msg("京东比价链接格式不正确，请重新输入！");
					$("input[name='jdSellerLink']").focus();
					return;
				}
				if (!checkURL(tmallSellerLink)) {
					layer.msg("淘宝比价链接格式不正确，请重新输入！");
					$("input[name='tmallSellerLink']").focus();
					return;
				} */
				adpoting = true;
				$.ajax({
					type : "post",
					traditional : true,
					url : "${ctx}/goods/siteself/doBJ",
					data : $("#tf").serializeJson(),
					success : function(result) {
						if (result == "ok") {
							layer.msg("修改成功！");
							//window.location.href="${ctx}/goods/siteself/WholeCompanySite";
							var liMark = $('#min_title_list li',window.top.document);
							liMark.each(function(idx,el){
								if($(el).hasClass("active")){
                                    var aCloseIndex = $(this).index();
                                    $(el).remove();
                                    setTimeout(function(){
                                        $('#iframe_box',window.top.document).find('.show_iframe').eq(aCloseIndex).remove();
									}, 20);
								}
							});
							var name = "";
							var href = "";
							var hh = '${jp}';
							if(hh=='o1'){
								href="${ctx}/goods/siteselfOrder/headerList";
								name="订单信息";
							}
							if(hh=='o2'){
								href="${ctx}/goods/platFormOrder/headerList";
								name="订单信息";
							}
							if(hh=='o3'){
								href="${ctx}/goods/platFormOrder/headerListMjl";
								name="订单信息";
							}
							if(hh=='s1'){
								href="${ctx}/goods/siteself/WholeCompanySite";
								name="公司库存";
							} 
							if(hh=='s2'){
								href="${ctx}/goods/siteself/WholeEmployeSite";
								name="公司库存";
							} 
							if(hh=='s3'){
								href="${ctx}/goods/usedRecord/waitReturn";
								name="公司库存";
							} 
							if(hh=='s22'){
								href="${ctx}/goods/siteself/BuyEmployeSite";
								name="工程师自购库存";
							} 
							if(hh=='o11'){
								href="${ctx}/goods/siteselfOrder/employeBuyBySelfOrder";
								name="订单信息";
							}
							updateOrCreate(name,href);
							return;
						} else if (result == "existNumber") {
							layer.msg("该商品编号已存在！！");
							$("input[name='number']").focus();
                            adpoting = false;
							return;
						} else if (result == "existPlatNumber") {
							layer.msg("该商品编号与平台合作商品的商品编号重复！");
							$("input[name='number']").focus();
                            adpoting = false;
							return;
						} else if(result=='444'){
							layer.msg("商品库存已经发生变化，请刷新后重试!");
                            adpoting = false;
							return;
						}else {
							layer.msg("修改失败，请检查！");
                            adpoting = false;
							return;
						}
					},
					complete : function() {
						//adpoting = false;
					}
				})
			}
		})
	})
	
	function check(number) { 
	    var re = /^\d+(?=\.{0,1}\d+$|$)/ 
        if (!re.test(number)) { 
           return false;
        } 
	    return true;
	} 
	
	function upZero(num){
		var reg = /^\+?[1-9]\d*$/;
		if(!reg.test(num)){
			return false;
		}
		return true;
	}
	
	function checkURL(URL){
		var str=URL;
		var Expression=/^http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?$/; 
		var objExp=new RegExp(Expression);
		if($.trim(URL)=='' || URL==null){
			return true;
		}
		if(objExp.test(str)==true){
		   return true;
		}else{
		   return false;
		}
	}
	
	function showTip() {
		if (!showUnitTip && unitOps == 0) {
			showUnitTip = true;
			$('body').popup({
				level: '3',
				type: 1,  // 提示操作成功
//			type:2,  // 提示是否进行某种操作
				content: '请在 “系统设置-计量单位” 中维护计量单位',
				fnConfirm: function () {
					showUnitTip = false;
					// 点击"确定"/“关闭”按钮进行的操纵
				},
				fnCancel: function () {
					// 点击"取消"按钮进行的操纵
					showUnitTip = false;
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
	
	//判断编号是否存在
	$("input[name='number']").blur(function() {
		var number = $("input[name='number']").val();
		var oldNumber = $("input[name='oldNumber']").val();
		var yuanNumber = $("input[name='yuanNumber']").val();
		if (number != yuanNumber) {
			$.ajax({
				type : "POST",
				url : "${ctx}/goods/siteself/isNullEdit",
				data : {
					number : number,
					oldNumber : oldNumber
				},
				success : function(data) {
					if (data == "fal") {
						layer.msg('该编号已存在！！');
						$.closeDiv($(".splydjbox"));
						window.location.reload(true);
					}
				}
			});
		}
	})
	
	function createUploader(picker,site, el,id,delimg) {
		var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 130; 
		uploader = WebUploader.create({
		       // 选完文件后，是否自动上传。 
		       auto: true,  
		       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
		       server: '${ctx}/common/uploadFile',
		       duplicate:true,
		       fileSingleSizeLimit:1024*1024*5,
		       pick: picker,  
		       accept: {  
		    	    title: 'Images',
		    	    extensions: 'gif,jpg,jpeg,bmp,png',
		    	    mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
		       },  
		       method:'POST'
		   }); 
		   uploader.on("error",function (type){
		   if (type=="Q_TYPE_DENIED"){ 
			   layer.msg("请上传JPG、PNG格式文件");
			   }else if(type=="F_EXCEED_SIZE"){
				   layer.msg("文件大小不能超过5M"); }
		   });
		   
		   uploader.on('beforeFileQueued', function(file){
		   });
		   uploader.on( 'uploadSuccess', function( file, response ) {
			   $("input[name='markAble']").each(function(index,items){
					if(items.value==file.id){
						$(site).append('<input type="hidden"  name="pickerImg" id="pickerImg'+file.id+'" value="'+response.path+'">');
					}
				})  
		   });
		   uploader.on( 'uploadError', function( file, reason ) {
				
		   }); 
		   uploader.on( 'uploadFinished', function() {
				if(uploader){
					uploader.reset();
				}
		   });
		  
		   uploader.on( 'fileQueued', function( file ) {
			  if(feedImgsCount==4){
				  $("#imgsAdd").hide();
			   }
			   if(parseInt(feedImgsCount) > 4 ){
				   layer.msg("最多可上传5张图片！");
				   return false;
			   } 
		   uploader.makeThumb( file, function( error, src ) {
			   if (error) {
				    layer.msg('不能预览');
			   } else {
				   img(id,src,file,site);
			   }
		}, thumbnailWidth, thumbnailHeight );
		});   
		   
	}
	
	function delx(obj,fileId) {
		$("#file"+fileId+"").remove();
		$(obj).parent('.imgWrap1').remove();
		$("#pickerImg"+fileId).remove();
		feedImgsCount = parseInt(feedImgsCount)-1;
		if(feedImgsCount<=4){
			$("#imgsAdd").show();
		} 
    	return ;
	} 

	
	function img(id,src,file,site){
		if(feedImgsCount > 4){
			$("#imgsAdd").hide();
			layer.msg("最多可上传5张图片！");
			return false;
		}
		feedImgsCount=parseInt(feedImgsCount)+1;  
		var html =' <div class="f-l imgWrap1 mr-15" id="file'+file.id+'"><div class="imgWrap"> ';
		html +='<img src="'+src+'" id="" class="img"></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
				'<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
		$(site).append(html);
		if(feedImgsCount>=5){
			$("#imgsAdd").hide();
		}
	}
	
	function deleteImg(ff) {
		$("#" + ff).remove();
		feedImgsCount = feedImgsCount - 1;
		if (feedImgsCount == 4) {
			$("#imgsAdd").show();
		} 
		if (uploader) {
			uploader = null;
		}
		createUploader("#imgsAdd", "#Imgprocess", "file_fake_addimg","file_fake_add", "delimgs");
	}
	
	//防止图片过宽
	   function fixImgWidth(){
	   	$('#activeEditor img').each(function(item,index){
	   			$(this).bind('load', function() {//针对谷歌浏览器解决图片不能缩小的bug
	   				if($(this).width()>600){
	   					$(this).width(600);
	   				}
	   				$(this).parent().width($(this).width());
	   			});
	   			if($(this).width()>600){
	   					$(this).width(600);
	   				}
	   				$(this).parent().width($(this).width());
	   		});
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
	   function quxiao(){
		   var liMark = $('#min_title_list li',window.top.document);
			liMark.each(function(idx,el){
				if($(el).hasClass("active")){
                    var aCloseIndex = $(this).index();
                    $(el).remove();
                    //$('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();
                    setTimeout(function(){
                        $('#iframe_box',window.top.document).find('.show_iframe').eq(aCloseIndex).remove();
                    }, 20);
				}
			});
		   var name = "";
			var href = "";
			var hh = '${jp}';
			if(hh=='o1'){
				href="${ctx}/goods/siteselfOrder/headerList";
				name="订单信息";
			}
			if(hh=='o2'){
				href="${ctx}/goods/platFormOrder/headerList";
				name="订单信息";
			}
			if(hh=='o3'){
				href="${ctx}/goods/platFormOrder/headerListMjl";
				name="订单信息";
			}
			if(hh=='s1'){
				href="${ctx}/goods/siteself/WholeCompanySite";
				name="公司库存";
			} 
			if(hh=='s2'){
				href="${ctx}/goods/siteself/WholeEmployeSite";
				name="公司库存";
			} 
			if(hh=='s3'){
				href="${ctx}/goods/usedRecord/waitReturn";
				name="公司库存";
			} 
			updateOrCreate(name,href);
	   }
</script> 
</body>
</html>
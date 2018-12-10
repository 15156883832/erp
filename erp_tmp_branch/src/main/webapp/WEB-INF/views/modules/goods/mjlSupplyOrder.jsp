<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
<style type="text/css">
	#imageShow{
		width:456px;
		height:456px;
		text-align:center;
	}
	#imageShow img{ max-width:100%;}
</style>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<a class="btn-tabBar "  href="${ctx }/goods/platFormOrder/orderManageHeaderList">订单管理</a>
						<a class="btn-tabBar current"  href="${ctx }/goods/mjl/supplyMjlOrder">美洁力订单</a>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a> 
							<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1"> <input
								type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">商品名称：</th>
										<td>
											<input type="text" class="input-text" name = "goodName"/>
											<label class="ml-15">下单时间：</label>
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})"  id=createTimeMin name="createTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
										
											<label class="ml-15">出库时间：</label>
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'outTimeMax\')||\'%y-%M-%d\'}'})"  id=outTimeMin name="outTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'outTimeMin\')}',maxDate:'%y-%M-%d'})" id="outTimeMax" name="outTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
										</td>
										
									</tr>
								</table>
							</div>

						</form>
						<div class="pt-10 pb-5 cl">
							<div class="f-r">
								<a  class="sfbtn sfbtn-opt" onclick="return expotrs()" target="_blank"><i class="sficon sficon-export"></i>导出</a>
							</div>
											
						</div>
						<div class="mt-10">
							<table id="table-waitdispatch" class="table"></table>
							<!-- pagination -->
							<div class="cl pt-10">
								<div class="f-l">
								
								</div>
								<div class="f-r">
									<div class="pagination"></div>
								</div>
							</div>
							<!-- pagination -->
						</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	<!-- 不通过 -->
<div class="popupBox shfkbox shfkboxjj shfkboxjjbtg">
	<h2 class="popupHead">
		不通过原因
		<a href="javascript:closeDivApp1();" class="sficon closePopup" ></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20">
			<textarea class="textarea" placeholder="请填写不通过原因" id="reason"></textarea>
			<div class="text-c mt-25">
				<a href="javascript:noPassSubmit();" class="sfbtn sfbtn-opt3 w-70 mr-5">发送</a>
				<a href="javascript:closeDivApp1();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
			
		</div>
	</div>
</div>

<!-- 确认出库 -->
<div class="popupBox spqrck" style="width:520px;">
	<h2 class="popupHead">
		确认出库
		<a href="javascript:guanbi();" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<h3 class="modelHead mb-10">订单信息</h3>
			<div class="cl mb-10">
				<label class="f-l w-80">订单编号：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="number1" readonly="readonly" value="" />
				<label class="f-l w-80 text-r">商品名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="goodName1" readonly="readonly" value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">购买数量：</label>
				<div class="priceWrap w-140 readonly f-l readonly">
					<input type="text" class="input-text readonly" id="purchaseNum1" readonly="readonly"  value="" />
					<span class="unit" id="unit1"></span>
				</div>
				<label class="f-l w-80 text-r">用户姓名：</label>
				<input type="text" class="input-text w-140 f-l readonly text-overflow" id="customerName1" readonly="readonly"  />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">联系方式：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="customerContact1" readonly="readonly"  value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">详细地址：</label>
				<input type="text" class="input-text w-380 f-l readonly" id="customerAddress1" readonly="readonly" value="" />
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<label class="f-l w-80 text-r">物流名称：</label>
				  <span class="w-140 f-l">
									<select class="select easyui-combobox"  id="logisticsName1"  name="logisticsName1" style="width:100%;height:25px" panelMaxHeight="130px">
									  <option value="中通快递" selected="selected">中通快递</option>
									  <option value="顺丰速运" >顺丰速运</option>
									  <option value="EMS" >EMS</option>
									  <option value="申通快递" >申通快递</option>
									  <option value="圆通快递" >圆通快递</option>
									  <option value="韵达快递" >韵达快递</option>
									  <option value="百世汇通快递" >百世汇通快递</option>
									  <option value="天天快递" >天天快递</option>
									  <option value="德邦物流" >德邦物流</option>
									  <option value="全一快递" >全一快递</option>
									  <option value="全峰快递" >全峰快递</option>
									  <option value="盛辉物流" >盛辉物流</option>
									  <option value="中铁快运" >中铁快运</option>
									</select>
								</span>
				<label class="f-l w-100 text-r"><em class="mark">*</em>物流单号：</label>
				<input type="text" class="input-text w-140 f-l mustfill" id="logisticsNo1"   value="" />
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick = "outStockConfirm()">确认出库</a>
				<input type="text" hidden="hidden" class="input-text w-370 f-l readonly" id="id1" readonly="readonly" value="" />
				<input type="text" hidden="hidden" class="input-text w-370 f-l readonly" id="goodId1" readonly="readonly" value="" />
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="guanbi()">关闭</a>
			</div>
		</div>
	</div>
</div>


<!-- 支付凭证预览 -->
<div class="popupBox shfkbox shfkboxjj shfkboxjjzfpz">
	<h2 class="popupHead">
		 支付凭证
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20">
			<div id="imageShow" >
				<img alt="" id="zhifupingzheng" />
			</div>
		</div>
	</div>
</div>


<div class="popupBox w-580 orderxq">
	<h2 class="popupHead">
		订单详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-15 pb-15">
			<div class="cl mb-10">
				<label class="f-l w-90">购买产品：</label>
				<strong class="f-l f-14 w-190 lh-26" id="goodsName"></strong>
				<label class="f-l w-90">购买单价：</label>
				<span class="f-l w-190 lh-26 " id="goodsprice"></span>
			</div>
			<div class="bg-e2eefc pt-10 pb-10 mb-10">
				<div class="cl mb-10">
					<label class="f-l w-90">收件人：</label>
					<span class="f-l w-190 lh-26 " id="customerName"></span>
					<label class="f-l w-90">联系方式：</label>
					<span class="f-l w-190 lh-26 " id="customerContact"></span>
				</div>
				<div class="cl ">
					<label class="f-l w-90">详细地址：</label>
					<span class="f-l lh-26 " id="customerAddress"></span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-90">购买数量：</label>
				<span class="f-l w-120 lh-26 "  id="purchaseNum"></span>
				<label class="f-l w-50">运费：</label>
				<span class="f-l w-120 lh-26 " id="logisticsPrice"></span>
				<label class="f-l w-60">实付金额：</label>
				<span class="f-l w-120 lh-26 "  id="goodAmount"></span>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-90">支付方式：</label>
				<span class="f-l w-120 lh-26 " id="paymentType"></span>
				<label class="f-l w-50">购买人：</label>
				<span class="f-l w-300 lh-26 " id="site"></span>
			</div>
			<div class="cl ">
				<label class="f-l w-90">支付时间：</label>
				<span class="f-l w-120 lh-26 " id="payment_time"></span>
			</div>
		</div>
	</div>
</div>

	
	<script type="text/javascript">
	var noPassId;
	var outStockId;
	var sfGrid;
	var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
	var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		$(function() {
			
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			initSfGrid();
		});
	
		//初始化jqGrid表格，传递的参数按照说明
		   function initSfGrid() {
				sfGrid = $("#table-waitdispatch").sfGrid({
					url : '${ctx}/goods/mjl/supplyMjlGrid',
					sfHeader : defaultHeader,
					sfSortColumns : sortHeader,
					multiselect:false,
					rownumbers : true,
					gridComplete:function(){
						_order_comm.gridNum();
						if($("#table-waitdispatch").find("tr").length>1){
							$(".ui-jqgrid-hdiv").css("overflow","hidden");
						}else{
							$(".ui-jqgrid-hdiv").css("overflow","auto");
						}
					},
					loadComplete:function(){
						$('.frozen-bdiv .proofImg').each(function(){
							$(this).imgShow({hasIframe:true});
						})
					}
				});
			}
		
		function search(){
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
		    $("#table-waitdispatch").sfGridSearch({
		        postData: $("#searchForm").serializeJson()
		    });
		}
		
		function noPass(id){
			noPassId=id;
			$("#reason").val('');
			$(".shfkboxjjbtg").popup();
		}
		
		var mark1 = false;
		function noPassSubmit(){
			if(mark1==true){
				return ;
			}
			var reason = $("#reason").val();
			if($.trim(reason)=="" || reason==null ){
				layer.msg("请输入不通过原因！");
				$("#reason").focus();
				return false;
			}
			mark1=true;
			$.ajax({
				type:"post",
				url:"${ctx}/goods/mjl/noPass",
				data:{noPassId:noPassId,reason:reason},
				success:function(result){
					if(result=="ok"){
						layer.msg("提交成功！");
						closeDivApp1();
						search();
					}else{
						layer.msg("提交失败，请检查！");
						return false;
					}
				},
				complete:function(){
					mark1=false;
				}
			})
		}
		
		function closeDivApp1(){
			$.closeDiv($(".shfkboxjjbtg"));
			window.location.reload(true);
		}
		
		function outStock(id){
			outStockId=id;
			$.ajax({
				type:"post",
				url:"${ctx}/goods/mjl/detail",
				data:{id:id},
				success:function(data){
					if(data!=null && data !=""){
						$("#number1").val(data.columns.number);
						$("#placingOrderBy1").val(data.columns.siteName);
						$("#goodName1").val(data.columns.good_name);
						$("#purchaseNum1").val(data.columns.purchase_num);
						$("#customerName1").val(data.columns.customer_name);
						$("#customerContact1").val(data.columns.customer_contact);
						$("#customerAddress1").val(data.columns.customer_address);
						$("#id1").val(data.columns.id);
						$("#goodId1").val(data.columns.good_id);
						$("#unit1").text(data.columns.unit);
					}
					$("#logisticsName1").val('');
					$("#logisticsNo1").val('');
					$(".spqrck").popup();
				}
			})
			
		}
		
		function guanbi(){
			$("#number1").val('');
			$("#placingOrderBy1").val('');
			$("#goodName1").val('');
			$("#purchaseNum1").val('');
			$("#customerName1").val('');
			$("#customerContact1").val('');
			$("#customerAddress1").val('');
			$("#id1").val('');
			$("#goodId1").val('');
			$("#unit1").text('');
			$("#logisticsName1").val('');
			$("#logisticsNo1").val('');
			$.closeDiv($(".spqrck"));
			search();
		}
		
		var mark2 = false;
		function outStockConfirm(){
			if(mark2==true){
				return ;
			}
			var id = $("#id1").val();
			var goodId = $("#goodId1").val();
			var logisticsName = $("#logisticsName1").val();
			var logisticsNo = $("#logisticsNo1").val();
			if($.trim(logisticsName)=="" || logisticsName==null){
				layer.msg("请填写物流名称！");
				$("#logisticsName1").focus();
				return;
			}
			if($.trim(logisticsNo)=="" || logisticsNo==null){
				layer.msg("请填写物流单号！");
				$("#logisticsNo1").focus();
				return;
			}
			mark2=true;
			$.ajax({
				type:"post",
				url:"${ctx}/goods/mjl/outStockConfirm",
				data:{id:id,logisticsName:logisticsName,logisticsNo:logisticsNo,goodId:goodId},
				success:function(result){
					if(result=='ok'){
						layer.msg("出库成功！");
						guanbi();
						search();
					}else{
						layer.msg("出库失败，请检查！");
						return ;
					}
					
				},
				complete:function(){
					mark2=false;
				}
			})
		}
		function pass(id){
			$('body').popup({
				level:'3',
				type:2,
				content:"您确定要通过该订单吗？",
				fnConfirm:function(){
					$.ajax({
						type:"post",
						url:"${ctx}/goods/mjl/pass",
						data:{id:id},
						success:function(result){
							if(result=='ok'){
								layer.msg("审核通过！");
								search();
							}else{
								layer.msg("审核失败，请检查！");
								return ;
							}
						}
					})
				}
			})
			
		}
		
		function fmtOper(rowData){//操作
			var html="---";
			if(rowData.status=='0'){
				html="<span  ><a onclick='pass(\""+rowData.id+"\")' class='c-0383dc' >通过</a></span>&nbsp;&nbsp;<span  ><a onclick='noPass(\""+rowData.id+"\")' class='c-0383dc' >未通过</a></span>";
			}
			if(rowData.status=='1'){
				html="<span  ><a onclick='outStock(\""+rowData.id+"\")' class='c-0383dc' ><i class='sficon sficon-ck '></i>出库</a></span>";
			}
			if(rowData.status=='2'){
				html="<span  class='c-0383dc'>---</span>";
			}
			if(rowData.status=='3'){
				html="<span  ><a onclick='pass(\""+rowData.id+"\")' class='c-0383dc' >通过</a></span>";
			}
			if(rowData.status=='4'){
				html="<span  class='c-0383dc'>---</span>";
			}
			return html; 
		}
		
		function zfpz(rowData){//支付凭证
			//return html="<span  ><a onclick='yulan(\""+rowData.pay_confirm+"\")' class='c-0383dc'>凭证</a></span>"; 
			return html='<span class="proofImg"><a class="c-0383dc">凭证</a> <img src="${commonStaticImgPath}'+rowData.pay_confirm+'" /> </span>'; 
		}
		
		function detail(rowData){//订单编号
			return html="<span  class='c-0383dc'><a class='c-0383dc' onclick='showDetail(\""+rowData.id+"\")'>"+rowData.number+"</a> </span>"; 
		}
		
		function showDetail(orderId){
			$.ajax({
				type:"post",
				url:"${ctx}/goods/mjl/showOrderdetail",
				data:{"id":orderId},
				success:function(data){
					if(data!=null && data !=""){
						$("#goodsName").text(data.columns.good_name);
						$("#goodsprice").text(data.columns.site_price+"元");
						$("#customerName").text(data.columns.customer_name);
						$("#customerContact").text(data.columns.customer_contact);
						$("#customerAddress").text(data.columns.province+data.columns.city+data.columns.area+data.columns.customer_address);
						$("#purchaseNum").text(data.columns.purchase_num+"个");
						$("#logisticsPrice").text(data.columns.logistics_price+"元");
						$("#goodAmount").text(data.columns.good_amount+"元");
						if(data.columns.payment_type=="0"){
							$("#paymentType").text("微信");
						}else{
							$("#paymentType").text("支付宝");
						}
						$("#site").text(data.columns.site_name);
						if(data.columns.payment_time!=null && $.trim(data.columns.payment_time)!="" && data.columns.payment_time!=undefined){
							var date=new Date(parseInt(data.columns.payment_time,10));
							$("#payment_time").text(getDateTime(date));
						}
					}
					$(".orderxq").popup();

				}
				
				
			})
		}
		
		function statusOne(rowData){//订单状态
			var html="---";
			if(rowData.status=='0'){
				html = "待审核";
			}
			if(rowData.status=='1'){
				html = "待出库";
			}
			if(rowData.status=='2'){
				html = "已完成";
			}
			if(rowData.status=='3'){
				html = "审核未通过";
			}
			if(rowData.status=='4'){
				html = "已取消";
			}
			return html; 
		}
		
		function timeFormat(rowData){
			if(rowData.status==2){
				return rowData.sendgood_time;
			}else if(rowData.status==3){
				if(rowData.no_pass_time!=null && rowData.no_pass_time!="null" ){
					return rowData.no_pass_time;
				}
			}else if(rowData.status==4){
				if(rowData.no_pass_time!=null && rowData.no_pass_time!="null" ){
					return rowData.no_pass_time;
				}
			}else{
				return "";
			} 
			return "";
		}
		
		function codeColor(rowData){
			return html="<span  class='c-0383dc'>"+rowData.good_number+"</span>"; 
		}
		
		function yulan(img){
			$("#zhifupingzheng").attr("src",'${commonStaticImgPath}'+img);
			$(".shfkboxjjzfpz").popup();
		}
		$("#imageShow").imgShow();
		
		function expotrs(){
			var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
			var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
			if(idArr>10000){
				$('body').popup({
					level:3,
					title:"导出",
					content:content,
					 fnConfirm :function(){
						 location.href="${ctx}/goods/mjl/exportSupply?formPath=/a/goods/mjl/supplyMjlOrder&&maps="+$("#searchForm").serialize(); 
					 }
				});
			}else{
				 location.href="${ctx}/goods/mjl/exportSupply?formPath=/a/goods/mjl/supplyMjlOrder&&maps="+$("#searchForm").serialize();
			}
		}
		
		 function getDateTime(date) {
			    var year = date.getFullYear();
			    var month = date.getMonth() + 1;
			    var day = date.getDate();
			    var hh = date.getHours();
			    var mm = date.getMinutes();
			    var ss = date.getSeconds();
			    return year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss; 
		} 
		 
		 function zffs(rowData){
				if(rowData.payment_type=="0"){
					return "微信";
				}else if(rowData.payment_type=="1"){
					return "支付宝";
				}
				return "---";
		}
		
	</script>
	
</body>
</html>
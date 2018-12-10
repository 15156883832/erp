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
						<a class="btn-tabBar current" href="${ctx }/goods/nanDao/sysMjlOrder">美洁力订单</a>
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
										<th style="width: 76px;" class="text-r">订单编号：</th>
										<td>
											<input type="text" class="input-text" value="" name="number" id="number" />
										</td>
										<th style="width: 76px;" class="text-r">订单状态：</th>
										<td>
											<span class="select-box">
												<select class="select" name="status">
													<option value="">请选择</option>
													<option value="0">待审核</option>
													<option value="1">待出库</option>
													<option value="2">已完成</option>
													<option value="3">审核未通过</option>
													<option value="4">已取消</option>
												</select>
											</span>
										</td>
										<th style="width: 76px;" class="text-r">商品名称：</th>
										<td>
											<input type="text" class="input-text" name = "goodName"/>
										</td>
										<th style="width: 76px;" class="text-r">下单人：</th>
										<td>
											<input type="text" class="input-text" value="" name="placeOrderBy" id="placeOrderBy" />
										</td>
										<!-- <th style="width: 76px;" class="text-r">商品编号：</th>
										<td>
											<input type="text" class="input-text" name = "goodNumber"/>
										</td>
										 -->
									</tr>
									<tr>
										<th style="width: 76px;" class="text-r">下单时间：</th>
										<td colspan="3">
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})"  id=createTimeMin name="createTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
										</td>
										<th style="width: 76px;" class="text-r">出库时间：</th>
										<td colspan="3">
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
					url : '${ctx}/goods/mjl/sysMjlGrid',
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
						$('.proofImg').each(function(){
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
		
		function paType(rowData){
			if(rowData.payment_type=="0"){
				return "微信";
			}else if(rowData.payment_type=="1"){
				return "支付宝";
			}
			return "---";
		}
		function paSt(rowData){
			if(rowData.pay_status=="0"){
				return "未支付";
			}else if(rowData.pay_status=="1"){
				return "已支付";
			}
			return "---";
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
		
		function logsit(rowData){//订单编号
			return html="<span  class='c-0383dc'><a class='c-0383dc' onclick='logsitDetail(\""+rowData.id+"\")'>物流信息</a> </span>"; 
		}
		
		//物流信息
		function logsitDetail(id){
			pardetaile=layer.open({
				type : 2,
				content:'${ctx}/goods/mjl/logsitDetail?id='+id,
				title:false,
				area: ['100%','100%'],
				closeBtn:0,
				shade:0,
				anim:-1 
			});
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
						var date=new Date(parseInt(data.columns.payment_time,10));
						$("#payment_time").text(getDateTime(date));
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
						 location.href="${ctx}/goods/mjl/exportSys?formPath=/a/goods/mjl/sysMjlOrder&&maps="+$("#searchForm").serialize(); 
					 }
				});
			}else{
				 location.href="${ctx}/goods/mjl/exportsSys?formPath=/a/goods/mjl/sysMjlOrder&&maps="+$("#searchForm").serialize();
			}
		}
		
		function fpGoods(rowData){
			var html=rowData.distributionType;
			if(rowData.distributionType=='1'){
				html = "自动分配";
			}
			if(rowData.distributionType=='2'){
				html = "手动分配";
			}
			return html;
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
		 
		 function orderStatuss(row){
			 if(row.status=="0"){
				 return "待审核";
			 }
			 if(row.status=="1"){
				 return "待出库";
			 }
			 if(row.status=="2"){
				 return "已完成";
			 }
			 if(row.status=="3"){
				 return "审核不通过";
			 }
			 if(row.status=="4"){
				 return "已取消";
			 }
			 return "";
		 }
	</script>
	
</body>
</html>
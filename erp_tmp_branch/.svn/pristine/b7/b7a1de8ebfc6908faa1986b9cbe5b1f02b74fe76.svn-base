<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar current"  href="${ctx }/goods/platFormOrder/orderManageHeaderList">订单管理</a>
			<c:if test="${showTab == 'ok' }">
				<a class="btn-tabBar "  href="${ctx }/goods/mjl/supplyMjlOrder">美洁力订单</a>
			</c:if>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
						<th style="width: 76px;" class="text-r">商品名称：</th>
							<td>
								<input type="text" class="input-text" name = "goodName"/>
							</td>
							<th style="width: 76px;" class="text-r">订单状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="status">
										<option value="">请选择</option>
										<option value="2">待发货</option>
										<option value="3">已发货</option>
										<option value="4">已完成</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">下单人：</th>
							<td>
								<input type="text" class="input-text" name = "placingOrderBy"/>
							</td>
							<th style="width: 76px;" class="text-r">订单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">下单时间：</th>
							<td colspan="3">
								<input type="text" class="input-text Wdate w-140" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})" name = "placingOrderTime"/>&nbsp;至&nbsp;<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="input-text Wdate w-140" name = "placingOrderTime1"/>
							</td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="pt-10 pb-5 cl">
				<div class="f-r">
					<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>
				</div>
								
			</div>
			
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
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

<div class="popupBox spxdbox">
	<h2 class="popupHead">
		发货
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl mb-10">
				<label class="f-l w-70">用户姓名：</label>
				<input type="text" class="input-text w-140 f-l readonly text-overflow" id="customerName" readonly="readonly" title="" value="" />
				<label class="f-l w-90">联系方式：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="customerContact" readonly="readonly"  value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-70">详细地址：</label>
				<input type="text" class="input-text w-370 f-l readonly" id="customerAddress" readonly="readonly" value="" />
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<div class="f-r mr-40" id="fahuoPhoto">
					<label class="w-90 f-l">商品图片：</label>
					<div class="imgbox f-l mr-10">
						<img id="managerIcon"  />
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodName" readonly="readonly"  value="" />
					<label class="f-l w-90">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodBrand" readonly="readonly" value="" />
					
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品类别：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodCategory" readonly="readonly"  value="" />
					<label class="f-l w-90">商品型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodModel" readonly="readonly" value="" />
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">购买数量：</label>
					<div class="priceWrap w-140 readonly f-l readonly">
						<input type="text" class="input-text readonly" id="purchaseNum" readonly="readonly"  value="" />
						<span class="unit" id="unit">件</span>
					</div>
					<label class="f-l w-90">商品金额：</label>
					<div class="priceWrap w-140 readonly f-l readonly">
						<input type="text" class="input-text readonly" id="goodAmount" readonly="readonly"  value="" />
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l">
					<label class="f-l w-70">订单编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="number" readonly="readonly" value="12938100000128" />
					<label class="f-l w-90">下单人：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="placingOrderBy" readonly="readonly" value="" />
				</div>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mt-10">
				<label class="f-l w-70">物流名称：</label>
				<select class="select w-140 f-l" id="logisticsName" >
						<option value="">请选择</option>
						<option value="1">顺丰快递</option>
						<option value="2">韵达快递</option>
						<option value="3">中通快递</option>
						<option value="4">申通快递</option>
						<option value="5">圆通快递</option>
						<option value="6">百世快递</option>
						<option value="7">德邦物流</option>
						<option value="8">中国邮政</option>
						<option value="9">京东物流</option>
				</select> 
				<label class="f-l w-90">物流编号：</label>
				<input type="text" class="input-text w-140 f-l " id="logisticsNo"  value="" />
				<label class="f-l w-90">发货时间：</label>
				<input type="text" class="Wdate w-140 f-l " id="sendgoodDate" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
			</div>
			
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="confirmSendGoods()">确认发货</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="guanbi">关闭</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
	
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
var rId;
var ifFk;
var ifSuccess;

$(function(){
 	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid(); 
});

function search(){ //条件查询
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

function initSfGrid(){ //加载grid表格
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/goods/platFormOrder/orderManageGrid',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		shrinkToFit: true,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
} 

function fmtOper(rowData){ //列表操作
	if(rowData.status=='0'){
		return "<span>--</span>"
	}else if(rowData.status=='1'){
		return "<span>--</span>"
	}else if(rowData.status=='2'){ 
		return "<span ><i class='sficon sficon-confirmDelivery '/><a onclick='fahuo(\""+rowData.id+"\",\""+rowData.good_id+"\")' class='c-0383dc'>确定发货</a></span>";
	 } else if(rowData.status=='3'){
		/* return "<span >--</span>"; */
		 return "<span><i class='sficon sficon-confirmFinshed '/><a onclick='confirmEnd(\""+rowData.id+"\",\""+rowData.customer_name+"\",\""+rowData.customer_address+"\")' class='c-0383dc'>确定完成</a></span>"; 
	} else if(rowData.status=='4'){
		return "<span >--</span>";
	}else if(rowData.status=='5'){
		return "<span >--</span>";
	} else{
		return "<span style='color:red'>异常！</span>";
	}
}
 
function statusOne(rowData){ //订单状态
	if(rowData.status=='0'){
		return "<span>未支付</span>"
	}else if(rowData.status=='1'){
		return "<span>待分配确认</span>"
	}else if(rowData.status=='2'){ 
		return "<span >待发货</span>";
	 } else if(rowData.status=='3'){
		return "<span >已发货</span>";
		/* <a onclick='confirmEnd(\""+rowData.id+"\",\""+rowData.customer_name+"\",\""+rowData.customer_address+"\")' class='c-0383dc'><i class='sficon sficon-confirmFinshed '></li>确定完成</a> */
	} else if(rowData.status=='4'){
		return "<span >已完成</span>";
	}else if(rowData.status=='5'){
		return "<span>已取消</span>";
	} else{
		return "<span style='color:red'>异常！</span>";
	}
}

function detail(rowData){ //订单编号
	return "<span ><a  class='c-0383dc'>"+rowData.number+"</a></span>";
}

function fahuo(rowId){ //点击确认发货，进入发货弹出框
	$.ajax({
		type:"POST",
		url:"${ctx}/goods/platFormOrder/detailSysMsg1",
		data:{rowId:rowId}, 
		dataType:'json',
		success:function(result){
			$("#customerName").val(result.columns.customer_name);
			$("#customerContact").val(result.columns.customer_contact);
			$("#customerAddress").val(result.columns.customer_address);
			$("#goodName").val(result.columns.good_name);
			$("#goodBrand").val(result.columns.good_brand);
			$("#number").val(result.columns.number);
			$("#goodModel").val(result.columns.good_model);
			$("#purchaseNum").val(result.columns.purchase_num);
			$("#placingOrderBy").val(result.columns.sName);
			$("#goodAmount").val(result.columns.good_amount);
			$("#unit").html(result.columns.unit);
			$("#goodCategory").val(result.columns.good_category); 
			$("#logisticsName").val(result.columns.logistics_name); 
			$("#logisticsNo").val(result.columns.logistics_no); 
			$("#managerIcon").attr("src","${commonStaticImgPath}"+result.columns.good_icon+"");
			var date = new Date();
			$("#sendgoodDate").val(CurentTime); 
			$('.spxdbox').popup();
			rId=rowId;
		}
	})
}
var adpoting = false;
function confirmSendGoods(){  //确认发货，执行发货操作
	if(adpoting) {
	    return;
    }

	var logisticsName = "";
	var logisticsName1 = $("#logisticsName").val(); 
	if(logisticsName1=='1'){
		logisticsName = "顺丰快递"
	}else if(logisticsName1=='2'){
		logisticsName = "韵达快递"
	}else if(logisticsName1=='3'){
		logisticsName = "中通快递"
	}else if(logisticsName1=='4'){
		logisticsName = "申通快递"
	}else if(logisticsName1=='5'){
		logisticsName = "圆通快递"
	}else if(logisticsName1=='6'){
		logisticsName = "百世快递"
	}else if(logisticsName1=='7'){
		logisticsName = "德邦 物流"
	}else if(logisticsName1=='8'){
		logisticsName = "中国邮政"
	}else if(logisticsName1=='9'){
		logisticsName = "京东物流"
	}
	var logisticsNo = $("#logisticsNo").val(); 
	var sendgoodDate = $("#sendgoodDate").val();
	if($.trim(logisticsName)=="" || $.trim(logisticsName)==null ){
		$('body').popup({
			level:'3',
			type:1,
			content:"请填写物流名称！"
		})
	}else if($.trim(logisticsNo)=="" || $.trim(logisticsNo)==null){
		$('body').popup({
			level:'3',
			type:1,
			content:"请填写物流单号！"
		})
	}else{
		adpoting = true;
		$.ajax({
			type:"POST",
			url:"${ctx}/goods/platFormOrder/confirmSendGoods",
			data:{rowId:rId,
				logisticsName:logisticsName,
				logisticsNo:logisticsNo,
				sendgoodDate:sendgoodDate}, 
			dataType:'json',
			success:function(result){
				if(result==true){
					layer.msg("发货成功！");
					window.location.reload(true);
					$.closeDiv($(".spxdbox"));
				}else{
					$('body').popup({
						level:'3',
						type:1,
						content:"发货失败，请检查！"
					})
				}
			},
            complete: function() {
                adpoting = false;
            }
		})
	}
}
var adpotin = false;
function confirmEnd(rowId,name,address){ //点击确定完成按钮
	$('body').popup({
		level:'3',
		type:2,
		content:""+name+"("+address+")</br>确定已完成?",
		fnConfirm:function(){
			if(adpotin) {
			    return;
		    }
			adpotin = true;
			$.ajax({
				type:"POST",
				url:"${ctx}/goods/platFormOrder/confirmEnd",
				data:{rowId:rowId}, 
				dataType:'json',
				success:function(result){
					if(result==true){
						layer.msg("确定完成！");
						window.location.reload(true);
					}else{
						$('body').popup({
							level:'3',
							type:1,
							content:"确定完成失败，请检查！"
						})
					}
					
				},
	            complete: function() {
	                adpotin = false;
	            }
			})
		}
	})
}

$('#guanbi').on('click', function() {
	$.closeDiv($('.spxdbox'));
});
function CurentTime() {   
    var now = new Date();        
    var year = now.getFullYear();       //年  
    var month = now.getMonth() + 1;     //月  
    var day = now.getDate();            //日        
    var hh = now.getHours();            //时  
    var mm = now.getMinutes();          //分  
    var ss = now.getSeconds();           //秒        
    var clock = year + "-";        
    if(month < 10)  
        clock += "0";      
    clock += month + "-";      
    if(day < 10)  
        clock += "0";        
    clock += day + " ";   
    if(hh < 10)  
        clock += "0";     
    clock += hh + ":";  
    if (mm < 10) clock += '0';   
    clock += mm + ":";   
       
    if (ss < 10) clock += '0';   
    clock += ss;
    
    return clock; 
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
				 location.href="${ctx}/goods/platFormOrder/export2?formPath=/a/goods/platFormOrder/orderManageHeaderList&&maps="+$("#searchForm").serialize();
			 }
	
		});
	}else{
		 location.href="${ctx}/goods/platFormOrder/export2?formPath=/a/goods/platFormOrder/orderManageHeaderList&&maps="+$("#searchForm").serialize();
		
	}

}
$("#fahuoPhoto").imgShow();
</script>
	
</body>
</html>
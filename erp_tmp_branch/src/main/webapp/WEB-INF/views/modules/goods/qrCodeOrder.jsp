<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
<div class="sfpage table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar current" href="${ctx}/goods/platFormOrder/sysCodeOrder">二维码订单</a>
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
							<th style="width: 76px;" class="text-r">服务商名称：</th>
							<td>
								<input type="text" class="input-text"  name = "siteName"/>
							</td>
							<th style="width: 76px;" class="text-r">订单状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="status">
										<option value="">请选择</option>
										<option value="3">已发货</option>
										<option value="2">未发货</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">付款时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'paymentTime1\')||\'%y-%M-%d\'}'})"  id=paymentTime name="paymentTime"  class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'paymentTime\')}',maxDate:'%y-%M-%d'})" id="paymentTime1" name="paymentTime1"   class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="pt-10 pb-5 cl">
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="exports()" target="_blank"><i class="sficon sficon-export"></i>导出</a>
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

<div class="popupBox spqrfhbox ">
	<h2 class="popupHead">
		确认发货
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain">
			<div class="pcontent pt-15 pl-15">
				<div class="cl mb-10">
					<label class="f-l w-90">服务商名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="siteName1"  readonly="readonly"  />
					<label class="f-l w-90">联系方式：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="customerContact1" readonly="readonly" title="" value="" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90">详细地址：</label>
					<input type="text" class="input-text w-370 f-l readonly text-overflow" id="customerAddress1" readonly="readonly" value="" />
				</div>
				<div class="line-dashed mb-10 w-480"></div>
				<div class="cl mb-10">
					<label class="f-l w-90">物流名称：</label>
					<input type="text" class="input-text w-140 f-l " id="logisticsName1"  value="" />
					<label class="f-l w-90">物流单号：</label>
					<input type="text" class="input-text w-140 f-l " id="logisticsNo1"  value="" />
					<input type="text" hidden="hidden" class="input-text w-140 f-l readonly" id="siteId1" readonly="readonly" value="" />
				</div>
				<div class="line-dashed mb-10 w-480"></div>
				<div class="pl-90 pos-r">
					<label class="lb w-90">设备序列号：</label>
					<div id="sequenceBox">
						<div class="mb-10 shebeixuliehao">
							<input type="text" class="input-text w-140"  name="serio"/> 
							<a href="javascript:;" class="sficon sficon-reduce2 mr-5 mt-5" style="display: none;" onclick="delSettle(this)"></a>
							<a href="javascript:;" class="sficon sficon-add2 mr-5 mt-5" onclick="showSettle(this)"></a>
						</div>
					</div>
				</div>
			</div>
			<div class="text-c btnWrap">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="confirmSendGood()">确认发货</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="guanbi">关闭</a>
			</div>
		</div>
	</div>
</div>

<div class="popupBox spOprocess">
	<h2 class="popupHead">
		订单过程
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain pt-15">
			<div class="pcontent">
			
				<div class="llbox bk-gray">
					<h3 class="lltitle">物流信息
					<span class="f-r mr-10" id="logisticsNo">单号：</span>
					<span class="f-r mr-20" id="logisticsName">名称：</span>
					</h3>
					<div class="nologistics hide">商品尚未发货</div>
					<ul class="logisticslist pt-5 pb-5" style="min-height: 200px;max-height: 400px;overflow: auto">
						
						
					</ul>
				</div>
			</div>
		</div>
		
		<div class="text-c btbWrap">
			<a href="javascript:close();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
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

function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });
}

function initSfGrid(){
	$("#table-waitdispatch").sfGrid({
		url : '${ctx}/goods/platFormOrder/sysCodeOrderList',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		shrinkToFit: true,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
} 

function operation(rowData){
	if(rowData.status=='2'){
		return "<span ><a onclick='sendGood(\""+rowData.id+"\")' class='c-0383dc'>确认发货</a></span>";
	}else if(rowData.status=='3'){
		return "<span ><a onclick='logsitDetail(\""+rowData.id+"\")' class='c-0383dc'>物流信息</a></span>";
	}else if(rowData.status=='4'){
		return "<span ><a onclick='logsitDetail(\""+rowData.id+"\")' class='c-0383dc'>物流信息</a></span>";
	}else{
		return "<span ><a class='c-0383dc'>---</a></span>";
	}
}

$('#guanbi').on('click', function() {
	$.closeDiv($('.spqrfhbox'));
});

function check(number){
	if($.trim(number) != "" && number != null && number != undefined){
		return true;
	}
	return false;
}
function timeChange(timestamp ){
	var d = new Date(timestamp);    //根据时间戳生成的时间对象
	var date = (d.getFullYear()) + "-" + 
	           (d.getMonth() + 1) + "-" +
	           (d.getDate()) + " " + 
	           (d.getHours()) + ":" + 
	           (d.getMinutes()) + ":" + 
	           (d.getSeconds());
    return date;
	
}
function close(){
	$.closeDiv($(".spOprocess"));
}
//物流信息
function logsitDetail(id){
		$.ajax({
			type:"post",
			url:"${ctx}/goods/sitePlatformGoods/orderProgress",
			data:{id:id},
			success:function(result){
				$('.logisticslist').empty();
				var logNo = result.columns.logistics_no;
				var logName = result.columns.logistics_name;
				var list = result.columns.listmap;
				
				var htmllog = "";
				for(var i =0;i<list.length;i++){
					var time = list[i].key ;
					if(i == 0){
						htmllog +='<li>'
							+'<div class="lltime">'+time+'</div>'
							+'<div class="lladdress lastAddr currentSeq"><i class="icon_seq"></i>'+list[i].value+'</div>'
						    +'</li>';
					}else{
					htmllog +='<li>'
					+'<div class="lltime">'+time+'</div>'
					+'<div class="lladdress lastAddr "><i class="icon_seq"></i>'+list[i].value+'</div>'
				    +'</li>';
					}
				}
				$('.logisticslist').append(htmllog);
				$('#logisticsNo').html("单号："+logNo);
				$('#logisticsName').html("名称："+logName);
				$('.spOprocess').popup();
			}
		})
	}
/* 订单状态 */
function statusOne(rowData){
	if(rowData.status=='2'){
		return "<span class='oState state-waitSend' >待发货</span>";
	}else if(rowData.status=='3'){
		return "<span class='oState state-sended'>已发货</span>";
	}else if(rowData.status=='4'){
		return "<span class='oState state-finished'>已完成</span>";
	}
}

function detail(rowData){
	return "<span ><a  class='c-0383dc'>"+rowData.number+"</a></span>";
}

function sendGood(rowId){//点击确定发货打开弹出框
	$.ajax({
		type:"POST",
		url:"${ctx}/goods/platFormOrder/detailBombScreen",
		data:{rowId:rowId}, 
		dataType:'json',
		success:function(result){
			$("#siteName1").val(result.record.columns.site_name);
			$("#customerContact1").val(result.record.columns.customer_contact);
			$("#customerAddress1").val(result.record.columns.customer_address);
			$("#logisticsName1").val(result.record.columns.logistics_name);
			$("#logisticsNo1").val(result.record.columns.logistics_no);
			$("#siteId1").val(result.record.columns.site_id);
			
		rId = result.record.columns.id;	
		$('.spqrfhbox').popup();
		
		}
	})
}
var adpoting = false;
function confirmSendGood(){//点击确定发货执行发货操作
	if(adpoting) {
	    return;
    }
	var logisticsName = $("#logisticsName1").val();
	var logisticsNo = $("#logisticsNo1").val();
	var siteId = $("#siteId1").val();
	var serialNos = $(".shebeixuliehao input[name='serio']");
	var serialNoVals = [];
	serialNos.each(function(index,el){
		serialNoVals[index] = $(el).val();
	})
	for(var i=0;i<serialNoVals.length;i++){
		if($.trim(serialNoVals[i])=="" || $.trim(serialNoVals[i])==null){
			return $('body').popup({
				level:'3',
				type:1,
				content:"设备序列号不能为空！"
			})
		}
	}
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
			traditional:true,
			url:"${ctx}/goods/platFormOrder/confirmSendGood",
			data:{rowId:rId,
				logisticsName:logisticsName,
				logisticsNo:logisticsNo,
				serialNoVals:serialNoVals,
				siteId:siteId}, 
			dataType:'json',
			success:function(result){
				if(result==true){
					layer.msg("发货成功！");
					window.location.reload(true);
					$.closeDiv($(".spqrfhbox"));
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

function showSettle(obj){
	var box = $('#sequenceBox');
	var boxChild = $('#sequenceBox').children('div');
	var html = '<div class="mb-10 shebeixuliehao">'+
					'<input type="text" class="input-text w-140" name="serio" /> '+
					'<a href="javascript:;" class="sficon sficon-reduce2 mr-5 mt-5" onclick="delSettle(this)"></a>'+
					'<a href="javascript:;" class="sficon sficon-add2 mr-5 mt-5" style="display: none;" onclick="showSettle(this)"></a>'+
				'</div>';
	$(box).prepend(html);
	$(obj).prev().show();
}

function delSettle(obj){
	$(obj).parent('div').remove();
	var box = $('#sequenceBox');
	var boxChild = $('#sequenceBox').children('div');
	var childLength = boxChild.size()
	$(boxChild).eq(childLength-1).find('.sficon-add2').show();
	if( childLength == 1){
		$(boxChild).eq(childLength-1).find('.sficon-reduce2').hide();
	}
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
				 location.href="${ctx}/goods/platFormOrder/export5?formPath=/a/goods/platFormOrder/sysCodeOrder&&maps="+$("#searchForm").serialize();
			 }
		});
	}else{
		 location.href="${ctx}/goods/platFormOrder/export5?formPath=/a/goods/platFormOrder/sysCodeOrder&&maps="+$("#searchForm").serialize();
	}

}

</script>
	
</body>
</html>
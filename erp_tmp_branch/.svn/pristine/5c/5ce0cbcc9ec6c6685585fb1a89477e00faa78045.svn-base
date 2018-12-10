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
			<a class="btn-tabBar" href="${ctx}/goods/platform/WholePlatHeader">平台产品</a>
			<a class="btn-tabBar current"  href="${ctx }/goods/platFormOrder/platOrderHeaderList">产品订单</a>
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
							<th style="width: 76px;" class="text-r">订单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
							<th style="width: 76px;" class="text-r">订单状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="status">
										<option value="">请选择</option>
										<option value="0">待支付</option>
										<option value="1">待确认</option>
										<option value="2">待发货</option>
										<option value="3">已发货</option>
										<option value="4">已完成</option>
										<option value="5">已取消</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">下单人：</th>
							<td>
								<input type="text" class="input-text" name = "placingOrderBy"/>
							</td>
							<th style="width: 76px;" class="text-r">商品编号：</th>
							<td>
								<input type="text" class="input-text" name = "goodNumber"/>
							</td>
							<th style="width: 76px;" class="text-r">商品名称：</th>
							<td>
								<input type="text" class="input-text" name = "goodName"/>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">商品类别：</th>
							<td>
								<span class="select-box">
									<select class="select" name="goodCategory">
										<option value="">请选择</option>
										<c:forEach items="${categoryType}" var="ctype">
										    <option value="${ctype.columns.name}">${ctype.columns.name}</option>
										 </c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">商品分配：</th>
							<td>
								<span class="select-box">
									<select class="select" name="supplierId">
										<option value="">请选择</option>
										<option value="1">自动分配</option>
										<option value="2">手动分配</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">下单时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'placingOrderTime1\')||\'%y-%M-%d\'}'})"  id=placingOrderTime name="placingOrderTime"  class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'placingOrderTime\')}',maxDate:'%y-%M-%d'})" id="placingOrderTime1" name="placingOrderTime1"   class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			
			<div class="pt-10 pb-5 cl">
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="expotrs()" target="_blank"><i class="sficon sficon-export"></i>导出</a>
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

<div class="popupBox sporderdetail">
	<h2 class="popupHead">
		订单详情
		<a href="javascript:;" class="sficon closePopup" ></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain" id="detailBox">
			<div class="cl mb-10">
				<div class="f-r mb-10 mr-40" id="detailPhoto">
					<label class="w-90 f-l">商品图片：</label>
					<div class="imgbox f-l mr-10">
						<img id="iconDetail"/>
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodNumber" readonly="readonly" value="" />
					<label class="f-l w-90">商品名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodName" readonly="readonly"  value="" />
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodBrand" readonly="readonly" value="" />
					<label class="f-l w-90">商品型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodModel" readonly="readonly"  value="" />
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品类别：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodCategory" readonly="readonly" value="" />
					<label class="f-l w-90">商品来源：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="source" readonly="readonly"  value="" />
				</div>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<label class="f-l w-70">用户姓名：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="customerName" readonly="readonly" value="" />
				<label class="f-l w-90">联系方式：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="customerContact" readonly="readonly"  value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-70">详细地址：</label>
				<input type="text" class="input-text w-370 f-l readonly" id="customerAddress" readonly="readonly" value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-70">订单编号：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="number" readonly="readonly" value="" />
				<label class="f-l w-90">购买数量：</label>
				<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" id="purchaseNum"  readonly="readonly" value="" />
						<span class="unit" id="unit"></span>
				</div>
				<label class="f-l w-90">商品总额：</label>
				<div class="priceWrap w-140 readonly f-l readonly">
					<input type="text" class="input-text readonly" id="goodAmount" readonly="readonly"  value="" />
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-70">下单人：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="placingOrderBy" readonly="readonly" value="" />
				<label class="f-l w-90">订单状态：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="status" readonly="readonly"  value="" />
			</div>
			<input type="text" hidden="hidden" class="input-text" id="sitePrice"   value="" />
			<div class="text-c mt-20" id="selectOne">
			</div>
		</div>
	</div>
</div>

<!-- 分配 -->
<div class="popupBox spxdbox">
	<h2 class="popupHead">
		分配
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl mb-10">
				<label class="f-l w-70">用户姓名：</label>
				<input type="text" class="input-text w-140 f-l readonly text-overflow" id="customerName1" readonly="readonly" title="安徽省合肥市政务区荷叶地街道蔚蓝商务港A" value="安徽省合肥市政务区荷叶地街道蔚蓝商务港A" />
				<label class="f-l w-90">联系方式：</label>
				<input type="text" class="input-text w-140 f-l readonly" id="customerContact1" readonly="readonly"  value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-70">详细地址：</label>
				<input type="text" class="input-text w-370 f-l readonly" id="customerAddress1" readonly="readonly" value="" />
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<div class="f-r mr-40" id="fenpeiPhoto">
					<label class="w-90 f-l">商品图片：</label>
					<div class="imgbox f-l mr-10">
						<img id="iconfp" />
					</div>
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">订单编号：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="number1" readonly="readonly" value="12938100000128" />
					<label class="f-l w-90">商品名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodName1" readonly="readonly"  value="售后通用电控盒组件" />
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodBrand1" readonly="readonly" value="" />
					<label class="f-l w-90">商品类别：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodCategory1" readonly="readonly"  value="" />
				</div>
				<div class="f-l mb-10">
					<label class="f-l w-70">商品型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="goodModel1" readonly="readonly" value="" />
					<label class="f-l w-90">购买数量：</label>
					<div class="priceWrap w-140 readonly f-l readonly">
						<input type="text" class="input-text readonly" id="purchaseNum1" readonly="readonly"  value="" />
						<span class="unit" id="unit1"></span>
					</div>
				</div>
				<div class="f-l">
					<label class="f-l w-70">商品金额：</label>
					<div class="priceWrap w-140 readonly f-l readonly">
						<input type="text" class="input-text readonly" id="goodAmount1" readonly="readonly"  value="" />
						<span class="unit">元</span>
					</div>
					<label class="f-l w-90">下单人：</label>
					<input type="text" class="input-text w-140 f-l readonly" id="placingOrderBy1" readonly="readonly" value="" />
				</div>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mt-10" id="gysList">
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="confirmFenpei()">确认分配</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="guanbi()" >关闭</a>
			</div>
		</div>
	</div>
</div>

<div class="popupBox spOprocess">
	<h2 class="popupHead">
		物流信息
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r pb-60">
		<div class="popupMain pt-15">
			<div class="pcontent">
				<!-- <div class="cl text-c pd-20 " id="detailProgress">
				</div> -->
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
		url : '${ctx}/goods/platFormOrder/platOrderGrid',
		sfHeader: defaultHeader,
		//sfSortColumns: sortHeader,
		//shrinkToFit: true
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
			if($("#table-waitdispatch").find("tr").length>1){
				$(".ui-jqgrid-hdiv").css("overflow","hidden");
			}else{
				$(".ui-jqgrid-hdiv").css("overflow","auto");
			}
		}
	});
} 

function codeColor(rowData){
	return "<span ><a class='c-0383dc'>"+rowData.good_number+"</a></span>";
}

function fmtOper(rowData){ //列表操作
	 if(rowData.status=='0'){
			return "<span ><a class='c-0383dc'>---</a></span>";
	}else if(rowData.status=='1'){
		return "<span ><a onclick='fenpei(\""+rowData.id+"\",\""+rowData.good_id+"\")' class='c-0383dc'><i class='sficon sficon-assign '></i>分配</a></span>";
	}else if(rowData.status=='2'){
		return "<span ><a class='c-0383dc'>---</a></span>";
	}else if(rowData.status=='3'){
		return "<span ><a class='c-0383dc'><a href='javascript:logsitDetail(\"" + rowData.id+"\");' class='c-0383dc'>物流信息</a></a></span>";
	}else if(rowData.status=='4'){
		return "<span ><a class='c-0383dc'><a href='javascript:logsitDetail(\"" + rowData.id+"\");' class='c-0383dc'>物流信息</a></a></span>";
	}else if(rowData.status=='5'){
		return "<span ><a class='c-0383dc'>---</a></span>";
	}
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

function close(){
	$.closeDiv($(".spOprocess"));
}

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

function statusOne(rowData){ //订单状态
	if(rowData.pay_status==0){
		return "<span class='oState state-yxd'>待支付</span>";
	}else{
		if(rowData.status=='0'){
			return "<span class='oState state-yxd'>待支付</span>";
		}else if(rowData.status=='1'){
			return "<span class='oState state-waitCheck'>待确认</span>";
		}else if(rowData.status=='2'){
			return "<span class='oState state-waitSend'>待发货</span>";
		}else if(rowData.status=='3'){
			return "<span class='oState state-sended'>已发货</span>";
		}else if(rowData.status=='4'){
			return "<span class='oState state-finished'>已完成</span>";
		}else if(rowData.status=='5'){
			return "<span class='oState state-canceled'>已取消</span>";
		}
	}
}

function detail(rowData){ //点击进入订单详情
	return "<span ><a onclick='detailSysMsg(\""+rowData.id+"\")' class='c-0383dc'>"+rowData.number+"</a></span>";
}

function detailSysMsg(rowId){ //订单详情弹出框以及展示的信息
	$('#selectOne').empty();
	$.ajax({
		type:"POST",
		url:"${ctx}/goods/platFormOrder/detailSysMsg1",
		data:{rowId:rowId}, 
		dataType:'json',
		success:function(result){
			var parent = $('#detailBox');
			$("#number").val(result.columns.number);
			$("#goodNumber").val(result.columns.good_number);
			$("#goodBrand").val(result.columns.good_brand);
			$("#goodModel").val(result.columns.good_model);
			$("#customerName").val(result.columns.customer_name);
			$("#customerContact").val(result.columns.customer_contact);
			$("#customerAddress").val(result.columns.customer_address);
			$("#purchaseNum").val(result.columns.purchase_num);
			$("#placingOrderBy").val(result.columns.sName);
			$("#goodAmount").val(result.columns.good_amount);
			$("#goodName").val(result.columns.good_name);
			$("#goodBrand").val(result.columns.good_brand);
			$("#unit").html(result.columns.unit);
			$("#goodCategory").val(result.columns.good_category); 
			$("#iconDetail").attr("src","${commonStaticImgPath}"+result.columns.good_icon+"");
			$("#source").val('平台');
			if(result.columns.status=='0'){
				$("#status").val('待支付');
				$("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
			}else if(result.columns.status=='1'){
				$("#status").val('待确认');
				$("#selectOne").append('<a href="javascript:;" id="" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="fenpei(\''+result.columns.id+'\',\''+result.columns.good_id+'\')">分配</a>'+
				'<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()" >取消</a>')
			}else if(result.columns.status=='2'){
				$("#status").val('待发货');
				$("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
			}else if(result.columns.status=='3'){
				$("#status").val('已发货');
				$("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
			}else if(result.columns.status=='4'){
				$("#status").val('已完成');
				$("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
			} else if(result.columns.status=='5'){
				$("#status").val('已取消');
				$("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
			} 
			$('.sporderdetail').popup();
		}
	})
	
}

function fenpei(rowId,goodId){
	$("#gysList").empty();
	$.ajax({
		type:"POST",
		url:"${ctx}/goods/platFormOrder/detailSysMsg",
		data:{rowId:rowId,
			goodId:goodId}, 
		dataType:'json',
		success:function(result){
			$.closeDiv($('.sporderdetail'));
			$("#customerName1").val(result.record.columns.customer_name);
			$("#customerContact1").val(result.record.columns.customer_contact);
			$("#customerAddress1").val(result.record.columns.customer_address);
			$("#goodName1").val(result.record.columns.good_name);
			$("#number1").val(result.record.columns.number);
			$("#goodBrand1").val(result.record.columns.good_brand);
			$("#goodModel1").val(result.record.columns.good_model);
			$("#purchaseNum1").val(result.record.columns.purchase_num);
			$("#placingOrderBy1").val(result.record.columns.sName);
			$("#goodCategory1").val(result.record.columns.good_category); 
			$("#goodAmount1").val(result.record.columns.good_amount);
			$("#unit1").html(result.record.columns.unit);
			$("#iconfp").attr("src","${commonStaticImgPath}"+result.record.columns.good_icon+"");
			rId=rowId;
			var two="";
			for(var i=0;i<result.list.length;i++){
				two+='<option value="'+result.list[i].columns.supplier_id+'">'+result.list[i].columns.spname+'</option>'
			}
			var one = '<label class="f-l w-70">供应商：</label>'+
					'<select class="select w-140 f-l" id="gysId">'+
					'<option value="">请选择</option>'+two+'</select>';
			
			$("#gysList").append(one); 
			$('.spxdbox').popup();
		}
	})
}

function quxiao(){
	$.closeDiv($('.sporderdetail'));
}

function guanbi(){
	$.closeDiv($('.spxdbox'));
}

var adpotin = false;
function confirmFenpei(){
	if(adpotin) {
	    return;
    }
	var supplierId = $("#gysId").val();
	if($.trim(supplierId)=="" || $.trim(supplierId)==null){
		$('body').popup({
			level:'3',
			type:1,
			content:"请选择供应商！"
		})
	}else{
		adpotin = true;
		$.ajax({
			type:"POST",
			url:"${ctx}/goods/platFormOrder/confirmFenpei",
			data:{rowId:rId,
				supplierId:supplierId}, 
			dataType:'json',
			success:function(result){
				if(result==true){
					layer.msg("分配成功！");
					window.location.reload(true);
					$.closeDiv($(".spxdbox"));
				}else{
					$('body').popup({
						level:'3',
						type:1,
						content:"分配失败，请检查！"
					})
				}
				
			},
	        complete: function() {
	            adpotin = false;
	        }
		})
	}
}
$('#detailPhoto').imgShow();
$('#fenpeiPhoto').imgShow();

function expotrs(){
	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/goods/platFormOrder/export4?formPath=/a/goods/platFormOrder/platOrderHeaderList&&maps="+$("#searchForm").serialize(); 
			 }
		});
	}else{
		 location.href="${ctx}/goods/platFormOrder/export4?formPath=/a/goods/platFormOrder/platOrderHeaderList&&maps="+$("#searchForm").serialize();
	}
}
</script>
	
</body>
</html>
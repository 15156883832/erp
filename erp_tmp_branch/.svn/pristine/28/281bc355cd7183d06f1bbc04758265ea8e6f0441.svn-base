<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>区域南岛订单</title>
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>

</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<a class="btn-tabBar current" href="${ctx }/goods/nanDao/areacommodityOrder">南岛订单</a>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
							<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1"> <input
								type="hidden" name="rows" id="pageSize" value="20">
							<div class="bk-gray pt-10 pb-5 moreCondition mb-10">
								<table class="table table-search">
									<tr class="moreCondition" style="">
									
										<th style="width: 76px;" class="text-r">服务商：</th>
										<td>
											<input name="areaName" id="areaName" value="${areaId }" type="hidden">
											<input type="text" class="input-text" name = "siteName"/>
										</td>
										<th style="width: 76px;" class="text-r">商品名称：</th>
										<td>
											<input type="text" class="input-text" name = "goodName"/>
										</td>

										<th style="width: 76px;" class="text-r">下单时间：</th>
										<td colspan="3">
											<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})"  id=createTimeMin name="createTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
											至
											<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
										</td>
									</tr>
								</table>
							</div>

						</form>
						<div class="pb-5 cl">
							<div class="f-r">
								<a  class="sfbtn sfbtn-opt2" onclick="return expotrs()" target="_blank"><i class="sficon sficon-export"></i>导出</a>
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

	<script type="text/javascript">
	var noPassId;
	var outStockId;
	var orderStatus;
	var sfGrid;
	var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
	var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		$(function() {
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			initSfGrid();
            $('#aIdentity').imgShow();
		});
		//初始化jqGrid表格，传递的参数按照说明
		   function initSfGrid() {
				sfGrid = $("#table-waitdispatch").sfGrid({
					url : '${ctx}/goods/nanDao/areaNadaoGrid',
					sfHeader : defaultHeader,
					sfSortColumns : sortHeader,
					postData:{'areaName':'${areaId}'},
					multiselect:false,
                    rownumbers: true,
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
                        });
                    }
				});
			}

		function closeNoPass(){
		       $.closeDiv($(".butongguoyuanyin"));
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
            confirmOrder(id)
		}


    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

    function noPassSubmit(){
        $(".butongguoyuanyin").popup({level:2});
	}


		function closeUpdate(){
            $.closeDiv($(".updateOrder"));
		}

		function closeDivApp1(){
			$.closeDiv($(".shfkboxjjbtg"));
			//search();
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
			//window.location.reload(true);
           // initSfGrid();
            search();
		}


		function closeDivApp2(){
			$.closeDiv($(".orderxq"));
		}

		function continueConfirm(){
			$.closeDiv($(".promptBox1"));
		}

		//物流信息
		function logsitDetail(id){
			pardetaile=layer.open({
				type : 2,
				content:'${ctx}/goods/nanDao/logsitDetail?id='+id,
				title:false,
				area: ['100%','100%'],
				closeBtn:0,
				shade:0,
				anim:-1 
			});
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
		
		function expotrs(){
			var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
			var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
			if(idArr>10000){
				$('body').popup({
					level:3,
					title:"导出",
					content:content,
					 fnConfirm :function(){
						 location.href="${ctx}/goods/nanDao/areaexports?formPath=/a/goods/nanDao/areacommodityOrder&&type=1&&maps="+$("#searchForm").serialize(); 
					 }
				});
			}else{
				 location.href="${ctx}/goods/nanDao/areaexports?formPath=/a/goods/nanDao/areacommodityOrder&&type=1&&maps="+$("#searchForm").serialize();
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


    function paType(rowData){
        if(rowData.payment_type=="0"){
            return "微信";
        }
        if(rowData.payment_type=="1"){
            return "支付宝";
        }
        return "---";
    }
    
    /*enter查询*/
    function enterEvent(event){
    	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
    	if (keyCode ==13){
    		search();
    	}
    }

	</script>
	
</body>
</html>
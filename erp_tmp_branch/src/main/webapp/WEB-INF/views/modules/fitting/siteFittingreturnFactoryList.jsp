<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html> 	
  <head>
    <title>收入明细</title>
    <meta name="decorator" content="base"/>
	  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	  <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	  <script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
	  <style type="text/css">
		  #select2-applicant-container{
			  line-height: 26px;
		  }
	  </style>
  </head>
  
  <body>
  <div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
	<div class="page-orderWait">
	
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="FITTINGMGM_OUTINFITDETAIL_COMPANYDETAIL_TAB" html='<a class="btn-tabBar " href="${ctx}/fitting/siteFittingKeep/newFittlist">新件返厂</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="FITTINGMGM_OUTINFITDETAIL_ENIGEERDETAIL_TAB" html='<a class="btn-tabBar current"  href="${ctx}/fitting/returnFactoryStockFitting">旧件返厂</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" onclick="reset()" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">状态：</th>
							<td>
								<select class="select" name="status" style="width: 140px;"><!--   类型：0领取，1工单使用  2零售，3返还  4调拨 -->
										<option value="">请选择</option>
										<option value="3">返厂在途</option>
										<option value="5">已到厂</option>
									</select>
							</td>
							<th style="width: 76px;" class="text-r">旧件条码：</th>
							<td>
								<input type="text" class="input-text" name= "code"/>
							</td>
							<th style="width: 76px;" class="text-r">旧件名称：</th>
							<td>
								<input type="text" class="input-text" name = "name"/>
							</td>
							<th style="width: 76px;" class="text-r">旧件品牌：</th>
							<td>
								<input type="text" class="input-text" name = "brand"/>
							</td>
							
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td>
								<input type="text" class="input-text" name = "employeName"/>
							</td>
							<th style="width: 76px;" class="text-r">操作人：</th>
							<td>
								<input type="text" class="input-text" name = "confirmName"/>
							</td>
							<td colspan="4">
								<label  style="margin-left: -12px">返厂操作时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="endTimeMin" value="" class="input-text Wdate w-140">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="endTimeMax" value="" class="input-text Wdate w-140">
							</td>
						</tr>
					</table>
				</div>
				<div class="pt-10 pb-5 cl">
				<div class="f-l">
				<a href="javascript:fittingqrrks();" class="sfbtn sfbtn-opt" id="xzhelp"><i class="sficon sficon-plcopy"></i>批量到厂</a>
			</div>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<sfTags:pagePermission authFlag="FITTINGMGM_OUTINFITDETAIL_COMPANYDETAIL_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
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
			</form>
		</div>
	</div>
</div>

</div>
</div>
  
<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">
		提示
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
			</div>
		</div>
	</div>
</div>
   <!-- 确认入库提示框 -->
<div class="popupBox notDispatch showwxgddiv">
	<h2 class="popupHead">
		确认到厂
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<p class="lb lb1" style='width:300px;padding-left: 18px;margin-top: 7px;' id="dsnfnsd"></p>
			<div class="txtwrap1 pos-r mb-30" style="padding-left: 55px;">
				<label class="lb lb1" style="width:55px;">备注：</label>
				<textarea id="reasonofwxgd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
			<input type="hidden" id="fittingkeepId">
				<input onclick="saveqrdc()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="closeDivWX()"  class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
		if(result=="showPopup"){
			
			$(".vipPromptBox").popup();
			$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		}
	});
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});


//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	sfGrid = $("#table-waitdispatch").sfGrid({
		
		url : '${ctx}/fitting/getreturnFactory',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		 multiselect:true,
         autoWidth:false,
         rownumbers:true,
		gridComplete : function() {
			_order_comm.gridNum();
		}
		//shrinkToFit:true
		
	});
}

function closeDivWX(){
	$.closeDiv($(".showwxgddiv"), true);
}

 function fmtOperation(rowData){
	 if(rowData.status==3){
			return "<span><a class='c-0383dc' href=javascript:showDetail('"+rowData.id+"','"+rowData.name+"');>确认到厂</a></span>";
		}else{
			return "<span>已到厂</span>";
		}	
} 
function fmtStatus(rowData){
 	if(rowData.status==3){
		return "<span>返厂在途</span>";
	}else{
		return "<span>已到厂</span>";
	} 
}

	function fittingqrrks(){
		var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
		if (idArr.length < 1) {
			layer.msg("请选择数据！");
		}else {
			for (var i = 0; i < idArr.length; i++) {
				var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
			 	if ($.trim(rowData.ktype) == "已到厂") {
					layer.msg("选择的数据有不可操作确认到厂！");
					return;
				}
			}
			$('body').popup({
	              level: '3',
	              type: 2,  // 提示是否进行某种操作
	              content: '您确认所选备件已到厂？',
	              fnConfirm: function () {
					  $.ajax({
		                    url: '${ctx}/fitting/updateoldFittingIds?ids=' + idArr.join(","),
		                    type: 'post',
		                    success: function(data) {
		                    	if(data){
		    						layer.msg("确认到厂更新完毕!", {time: 2000});
		    						search();
		    					}else{
		    						layer.msg("操作失败!",{time:2000});
		    					}
		                    }
		                });
	              },
	              fnCancel: function () {
	              }
	           });
		}
		
	}
function showDetail(id,name){
	$("#dsnfnsd").html("确认旧件("+name+" )已到厂？");
	$("#fittingkeepId").val(id);
	$(".showwxgddiv").popup();
	$("#reasonofwxgd").val('');
}
//单个确认入库
function saveqrdc(){
	var id = $("#fittingkeepId").val();
	var remarks = $("#reasonofwxgd").val();
	$.ajax({
		type:"POST",
		url:"${ctx}/fitting/updateoldFittingById",
				data:{
					id:id,
					remarks:remarks
				},
				async:false,
				success:function(data){
					if(data){
						layer.msg("确认到厂更新完毕!", {time: 2000});
						search();
						$.closeDiv($('.showwxgddiv'));
					}else{
						layer.msg("操作失败!",{time:2000});
					}
				},
				error:function(){
					layer.msg("系统繁忙!");
					return;
				}
	});
}

function reset(){
	 location.href="${ctx}/fitting/returnFactoryStockFitting";
}

function search(){
	var pageSize = $("#pageSize").val();
	if($.trim(pageSize)=='' || pageSize==null){
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
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
				 location.href="${ctx}/fitting/older/export?formPath=/a/fitting/returnFactoryStockFitting&&maps="+$("#searchForm").serialize();
			 }
	
		});
		
	}else{
		 location.href="${ctx}/fitting/older/export?formPath=/a/fitting/returnFactoryStockFitting&&maps="+$("#searchForm").serialize();
	}

}


function jumpToVIP(){
	layer.open({
		type : 2,
		content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}
</script>
  </body>
</html>

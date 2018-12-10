<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
  </head>
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMDETAIL_TAB" html='<a class="btn-tabBar " href="${ctx }/operate/siteAlarm/headerList">系统预警消息</a>'></sfTags:pagePermission>
		<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_XITONGGONGGAO_TAB" html='<a class="btn-tabBar  current" href="${ctx}/order/announcement/read">系统公告</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<div class="tabCon">
			<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1"> <input
								type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">公告类型：</label></th>
										<td>
											<select class="select w-140 f-l" name="type">
													<option value="" selected="selected">--请选择--</option>
													<option value="1">系统升级</option>
													<option value="2">功能说明</option>
													<option value="3">系统通知</option>
											</select>
										</td>
									</tr>
								</table>
							</div>
							<div class="pt-10 pb-5 cl">
								<div class="f-l"></div>

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


<div class="popupBox sysNotice showNotice">
	<h2 class="popupHead">
		系统通知
		<a href="javascript:;" class="sficon closePopup" onclick="closed()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20">
			<h3 class="text-c lh-22 f-16"><strong class="title"></strong></h3>
			<p class="c-888 text-c lh-24 createTime"></p>
			<textarea class="mt-10 bk-blue-dotted noticeTxt" readonly="true" style="width: 100%">
				
			</textarea>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70" onclick="closed()">关闭</a>
			</div>
		</div>
	</div>
</div>





<!--_footer 作为公共模版分离出去-->


<!--_footer 作为公共模版分离出去-->

<script type="text/javascript">

var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/order/announcement/getannouncementplatlist";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		multiselect: false,
		rownumbers : true,
  		gridComplete:function(){
  			_order_comm.gridNum();
  		}
	});
}



function openContent(rowData){	
	return "<span><a href=javascript:updateMsg(this,'"+rowData.id+"') class='c-0383dc'>"+rowData.title+"</a></span>";	
}

function openType(rowData){
	if(rowData.type==1){
		return "<span>系统升级</span>"
	}else if(rowData.type==2){
		return "<span>功能说明</span>"
	}else if(rowData.type==3){
		return "<span>系统通知</span>"
	}else{
		return "<span>自定义公告</span>"
	}
	
}

function openStatus(rowData){
	if(rowData.flag==0){
		return "<span style='color:red'>未读</span>"
	}else{
		return "<span>已读</span>"
	}
}




function updateMsg(obj,id){
	layer.open({
		type : 2,
		content : '${ctx}/order/orderDispatch/showLatestAnnounce?id='+id+"&mark=2",
		title : false,
		area : [ '100%', '100%' ],
		closeBtn : 0,
		shade : 0,
		fadeIn : 0,
		anim : -1
	});
}



function closed(){
	
	$.closeDiv($(".showNotice"));
	//window.location.reload(true);
	//$.closeDiv($(".editOrigin"));
	search();
	
}

function jsClearForm() {
	$("#searchForm :input[type='text']").each(function () { 
	$(this).val(""); 
	}); 
	
	$("select").val(""); 

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
</script>
  </body>
</html>
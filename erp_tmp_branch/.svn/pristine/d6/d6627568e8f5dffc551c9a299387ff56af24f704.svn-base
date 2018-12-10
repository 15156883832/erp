<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
</head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<a class="btn-tabBar  current" href="${ctx}/operate/SiteManager/areaTubesiteManager">服务商管理</a>
		<sfTags:pagePermission authFlag="SYSTEM_AUTH_USEAGE_STAT_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/siteLoginStatistic?types=1&areaId=${areaId}">系统使用统计</a>'/>
			<p class="f-r btnWrap">
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<input type="hidden" name="areaId" id="areaId" value="${areaId}">
								<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
					<th style="width: 76px;" class="text-r">服务商名称：</th>
							<td>
                              <input type="text" class="input-text" onkeydown="enterEvent(event)" name= "name"/>
							</td>
							<th style="width: 76px;" class="text-r">登陆账号：</th>
							<td>
								<input type="text" class="input-text" name= "login_name"/>
							</td>
							<th style="width: 76px;" class="text-r">联系电话：</th>
							<td>
								<input type="text" class="input-text" onkeydown="enterEvent(event)" name= "telephone"/>
							</td>
							<th style="width: 76px;" class="text-r">省：</th>
							<td>
								<input type="text" class="input-text" onkeydown="enterEvent(event)" name= "province"/>
							</td>
							<th style="width: 76px;" class="text-r">当前版本：</th>
							<td><select class="select w-140 f-l" name="version">
								<option value="" selected="selected">请选择</option>
								<option value="1">免费版</option>
								<option value="2">收费版</option>
							</select>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<label class="text-r lb" style="width: 76px;">注册时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimemax\')||\'%y-%M-%d\'}'})" id="createTimemin" name="createTimemin" value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimemin\')}',maxDate:'%y-%M-%d'})" id="createTimemax" name="createTimemax"  value="" class="input-text Wdate w-120" style="width:120px">
								<label class="text-r lb" style="width: 76px;">到期时间：</label>
								<input type="text" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="dueTimemin" name="dueTimemin"  value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="dueTimemax" name="dueTimemax" value="" class="input-text Wdate w-120" style="width:120px">
							</td>
							</tr>
							</table>
							</div>
							<div class="pt-10 pb-5 cl">
				<div class="f-l">

				</div>
					<div class="f-r">
					<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>
				</div>
								
			</div>
				<div>
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
				<!-- 	<div class="cl pt-10">
							<div class="f-l">
							<span class="c-f55025">注：</span>
							<i class='sficon sficon-disabled'></i><span >已停用</span>
						</div> -->
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


<div class="popupBox w-580 fwsxq">
	<h2 class="popupHead">
		服务商详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15">
			<div class="cl mb-10">
				<label class="f-l w-100">服务商名称：</label>
				<input type="text" class="input-text w-380 f-l"  value=""  id="sitename"  readonly="true"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">联系人：</label>
				<input type="text" class="input-text w-140 f-l "  id="siteconcate"  readonly="true"/>
				<label class="f-l w-100	">联系电话：</label>
				<input type="text" class="input-text w-140 f-l"  value=""  id="sitemobile" readonly="true"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">登录账号：</label>
				<input type="text" class="input-text w-140 f-l "  id="siteloginname"  readonly="true"/>
				<label class="f-l w-100	">注册日期：</label>
				<input type="text" class="input-text w-140 f-l"  value=""  id="sitecreatetime" readonly="true"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">企业地址：</label>
				<input type="text" class="input-text w-380 f-l"  value="" id="siteadress"  readonly="true"/>
			</div>
			<div class="line-dashed mb-10"></div>
			<div class="cl mb-10">
				<label class="f-l w-100">会员等级：</label>
				<input type="text" class="input-text w-140 f-l "  id="sitelevel" readonly="true" />
				<label class="f-l w-100	">当前版本：</label>
				<input type="text" class="input-text w-140 f-l"  value=""  id="siteversion" readonly="true"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">激活码：</label>
				<input type="text" class="input-text w-140 f-l "  id="sitecode" readonly="true"/>
				<label class="f-l w-100	">分享数量：</label>
				<input type="text" class="input-text w-140 f-l"  value=""  id="sitesharecount" readonly="true"/>
			</div>
			<div class="cl mb-10" >
				<label class="f-l w-100" id="daoqi">到期日期：</label>
				<input type="text" class="input-text w-140 f-l "  id="siteduetime"  readonly="true"/>
				<label class="f-l w-100	">分享人：</label>
				<input type="text" class="input-text w-140 f-l"  value="" id="sitesharename"  readonly="true"/>
			</div>
			
			
		</div>
	</div>
</div>


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
	var url = "${ctx}/operate/SiteManager/siteManagerList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		postData:$("#searchForm").serializeJson(),
		shrinkToFit: false,
		multiselect: false,
		rownumbers : true,
		gridComplete:function(){
			_order_comm.gridNum();
		}
	});
}

function siteType(rowData){
    if(rowData.type=='0'){
        return "普通网点";
    }else if(rowData.type=='1'){
        return "一级网点";
    }else if(rowData.type=='2'){
        return "二级网点";
    }else {
        return "";
    }
}



function nameOper(rowData){	
	if(rowData.status=="3"){
		return "<span><a  href=javascript:opendetail('"+rowData.id+"') class='c-0383dc' ><i class='sficon sficon-disabled'></i>"+rowData.name+"</a></span>";	
	}else{
		return "<span><a href=javascript:opendetail('"+rowData.id+"') class='c-0383dc'>"+rowData.name+"</a></span>";	
	}

}

function siteOper(rowData){	
	return "<span><a href=javascript:opensite('"+rowData.id+"') class='c-0383dc'>"+rowData.sharecount+"</a></span>";	
}

function versionOper(rowData) {
    var oDate = new Date();
    if (!rowData.due_time) {
        return "<span>免费版</span>";
    } else {
        var dueTime = new Date(rowData.due_time);
        if (oDate <= dueTime){
            return "<span>收费版</span>";
		} else {
            return "<span>免费版</span>";
		}
	}
}

function levelOper(rowData){
	if(rowData.level=="0"){
		return "<span>普通会员</span>"
	}else if(rowData.level=="1"){
		return "<span>银牌会员</span>"
	}else if(rowData.level=="2"){
		return "<span>金牌会员</span>"
	}else if(rowData.level=="3"){
		return "<span>钻石会员</span>"
	}else{
		return "<span>普通会员</span>"
	}
	
}

function countOper(rowData){
	if(rowData.sms_available_amount==null){
		return "<span>0</span>";
	}else{
		return "<span>"+rowData.sms_available_amount+"</span>";
	}
}

function closeds(){
	$.closeDiv($(".addNotice"));
}

function quxiao(){
	$.closeDiv($(".editeNotice"));
}
function jsClearForm() {
	$("#searchForm :input[type='text']").each(function () { 
	$(this).val(""); 
	}); 
	
	$("select").val(""); 
	$(".textbox-value").val("");
	 

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


function isPhoneNo(phone) {
	var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
	return pattern.test(phone);
}

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}


function isCode(code){
	var pattern =/^[a-zA-Z0-9]{4}$/;
	return pattern.test(code);
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


function opendetail(id){
   	$.ajax({
		type:'POST',
		url:"${ctx}/operate/SiteManager/opendetail",
		traditional: true,
		data:{
			"id":id,
		},
		success:function(sitemsg){
			if(sitemsg!=null){
				$('.fwsxq').popup();
				var create_time="";
				var due_time="";
				if(sitemsg.columns.create_time!=null){
					var date=new Date(parseInt(sitemsg.columns.create_time,10));
					create_time=getDateTime(date);
				}
				if(sitemsg.columns.due_time!=null){
					var date2=new Date(parseInt(sitemsg.columns.due_time,10));
					due_time=getDateTime(date2);
				}

				if(sitemsg.columns.type != '1'){
				    $(".buntonStype").addClass("hide");
				}else{
                    $(".buntonStype").removeClass("hide");
				}
				$("#siteIdX").val(id);
				$("#sitename").val(sitemsg.columns.name);
				$("#siteconcate").val(sitemsg.columns.contacts);
				$("#sitemobile").val(sitemsg.columns.mobile);
				$("#siteloginname").val(sitemsg.columns.login_name);
				$("#sitecreatetime").val(create_time);
				var adress="";
				var province="";
				var city="";
				var area="";
				var levels="普通会员";
				if(sitemsg.columns.province!=null){
					province=sitemsg.columns.province;
				}
				if(sitemsg.columns.city!=null){
					city=sitemsg.columns.city;
				}
				if(sitemsg.columns.area!=null){
					area=sitemsg.columns.area;
				}
				adress=province+city+area+sitemsg.columns.address;
				$("#siteadress").val(adress);
				if(sitemsg.columns.level=="0"){
					levels="普通会员";
				}else if(sitemsg.columns.level=="1"){
					levels="银牌会员";
				}else if(sitemsg.columns.level=="2"){
					levels="金牌会员";
				}else if(sitemsg.columns.level=="3"){
					levels="钻石会员";
				}else{
					levels="普通会员";
				}
				$("#sitelevel").val(levels);
				$("#siteversion").val(sitemsg.columns.version);
				$("#sitecode").val(sitemsg.columns.share_code);
				$("#sitesharecount").val(sitemsg.columns.sharecount);
				if(sitemsg.columns.due_time==null||sitemsg.columns.due_time==""){
					$("#daoqi").hide();
					$("#siteduetime").hide();
				}else{
					$("#daoqi").show();
					$("#siteduetime").show();
					$("#siteduetime").val(due_time);
				}
				$("#sitesharename").val(sitemsg.columns.shareParentName);
				
			}else{
				layer.msg("查询失败");
				return;
			}
		},
		error:function(){
			layer.msg("系统繁忙请稍后重试")
			return;
		}
	})
}

function guanbi(){
	$.closeDiv($(".fwsxq"));
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
				 location.href="${ctx}/operate/SiteManager/export?formPath=/a/operate/SiteManager/areaTubesiteManager&&maps="+$("#searchForm").serialize();
			 }
	
		});
	}else{
		location.href="${ctx}/operate/SiteManager/export?formPath=/a/operate/SiteManager/areaTubesiteManager&&maps="+$("#searchForm").serialize();
	}

}

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		search();
	}
}

function scsTypeeFuc(rowData){
	var type = rowData.scsType;
	if(type=='1'){
		return "自定义";
	}
	return "系统默认";
}

</script>
  </body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage  table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar  current" href="${ctx}/order/siteSet">服务商设置</a>
			<p class="f-r btnWrap">
				<a class="sfbtn sfbtn-opt" onclick="addEdit('')"><i class="sficon sficon-add"></i>添加</a>
			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
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


<!-- 添加 -->
<div class="popupBox gysxzsp" style="width:450px">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="" method="post" id="addOrEdit">
	<div class="popupContainer">
		<div class="popupMain">
			<div style="padding-left:50px">
				<div class="cl mb-10">
				<input type="hidden"  name="siteId" id="siteId"/>
				<input type="hidden"  name="userId" id="userId"/>
					<label class="f-l w-90"><em class="mark">*</em>服务商名称：</label>
					<input type="text" class="input-text w-200 f-l gyname"  id="name" name="name"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>登陆账号：</label>
					<input type="text" class="input-text w-200 f-l gycontactor"  id="loginName" name="loginName"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>登陆密码：</label>
					<input type="text" class="input-text w-200 f-l gyphone"  id="password" name="password"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>手机号：</label>
					<input type="text" class="input-text w-200 f-l gyphone"  id="mobile" name="mobile"/>
					<input type="hidden"  id="type" name="type"/>
					<input type="hidden"  id="oId" name="oId"/>
				</div>
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  onclick="save()">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
			</div>
		
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
var type;
var oId;
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
	var url = "${ctx}/order/siteSet/siteSetList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		multiselect: false,
	});
}

function OpenSupplier(rowData){
	return "<a href=javascript:openMsg('"+rowData.id+"') >"+rowData.name+"</a>";
}


function fmtOper(rowData){	
	return "<span><a href=javascript:addEdit('"+rowData.id+"') style='color:blue'>修改</a></span>&nbsp;&nbsp;<span><a style='color:blue' href=javascript:deleteMsg('"+rowData.id+"')>删除</a></span>";	
}

function addEdit1(siteId){
	$("#name").val('');
	$("#loginName").val('');
	$("#password").val('');
	$("#mobile").val('');
	$("#type").val('');
	$("#oId").val('');
	if($.trim(siteId)!="" && siteId!=null){//编辑
		type="1";
		oId=siteId;
		$.ajax({
			type:"POST",
			url:"${ctx}/order/siteSet/siteDetail",
			data:{siteId:siteId},
			success:function(data){
				$("#name").val(data.columns.name);
				$("#loginName").val(data.columns.login_name);
				//$("#password").val(data.columns.password);
				$("#mobile").val(data.columns.mobile);
				$('.gysxzsp').popup();
			}
		})
		
	}else{//新增
		type="2";
		oId="";
		$('.gysxzsp').popup();
	}
}

function save(){
	$("#type").val(type);
	$("#oId").val(oId);
	var name = $("#name").val();
	var loginName = $("#loginName").val();
	var password = $("#password").val();
	var mobile = $("#mobile").val();
	if(isBlank(name)){
		layer.msg("请填写服务商名称！");
		$("#name").focus();
		return false;
	}
	if(isBlank(loginName)){
		layer.msg("请填写登陆账号！");
		$("#loginName").focus();
		return false;
	}
	if(type=="2"){
		if(isBlank(password)){
			layer.msg("请填写登陆密码！");
			$("#password").focus();
			return false;
		}
	}
	if(isBlank(mobile)){
		layer.msg("请填写手机号！");
		$("#mobile").focus();
		return false;
	}else if(checkMobile(mobile)==false){
		layer.msg("请填写正确的手机号！");
		$("#mobile").focus();
		return false;
	}
	$.ajax({
		type:"POST",
		url:"${ctx}/order/siteSet/save",
		data:$("#addOrEdit").serializeJson(),
		success:function(result){
			if(result=="ok"){
				if(type=="2"){
					layer.msg("添加成功！");
				}else{
					layer.msg("修改成功！");
				}
				setTimeout(function(){
					$.closeDiv($(".gysxzsp"));
					window.location.reload(true);
				},200);
			}else{
				if(type=="2"){
					layer.msg("添加失败，请检查！");
				}else{
					layer.msg("修改失败，请检查！");
				}
			}
		}
	})
}

function checkMobile(number){
	if(number.length==11){
		if(number.substring(0,1)=="1"){
			return true;
		}
	}
	return false;
}

function checkPassword(password){
	//var mima = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
	//var re = new RegExp(mima);
	if(/^[a-z0-9A-Z]{6,16}$/.test(password)){
		return true;
	}
	return false;
}

function isBlank(val) {
	if (val == null || $.trim(val) == '' || val == undefined) {
		return true;
	}
	return false;
}

function deleteMsg(id){
	var content="确定要删除该服务商？";
		$('body').popup({
			level:3,
			title:"删除",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/siteSet/deleteSite",
						traditional: true,
								data:{
								"id":id
								},
								async:false,
							 success:function(data){
									if(data==true){
									layer.msg("删除完成!",{time:2000});
										 window.location.reload(true);
									}else{			
									layer.msg("操作失败!",{time:2000});
									}
								},
								error:function(){
									layer.alert("系统繁忙!");
									return;
								}
					});
					layer.closeAll('dialog');
			 }
		});
}

function addEdit(id) {
	layer.open({
		type: 2,
		content: '${ctx}/order/siteSet/openForm?id=' + id,
		title: false,
		area: ['100%', '100%'],
		closeBtn: 0,
		shade: 0,
		anim: -1
	})
}

function search() {
	$("#table-waitdispatch").sfGridSearch({
		postData: $("#searchForm").serializeJson()
	});
}
</script>
  </body>
</html>
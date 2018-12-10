<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>厂家资料管理</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/easyui.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
</head>
<body>
<div class="sfpagebg">
<div class="sfpage bk-gray table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<sfTags:pagePermission authFlag="SYSSETTLE_FACTORYMSG_FACTORYMSG_TAB" html='<a class="btn-tabBar current" href="${ctx}/order/siteVenderAccount">厂家资料</a> '></sfTags:pagePermission>
		    
			<p class="f-r btnWrap">
			<sfTags:pagePermission authFlag="SYSSETTLE_FACTORYMSG_FACTORYMSG_ADD_BTN" html='<a onclick="add()" class="sfbtn sfbtn-opt" ><i class="sficon sficon-add"></i>添加</a> '></sfTags:pagePermission>
				
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

<!-- 添加厂家资料 -->


<!-- 修改厂家资料-->
<div class="popupBox pmanufacture editManufacture">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="#"  class="form-add-malfunction" method="post">
		<div class="popupContainer pos-r">
			<div class="popupMain">
			<!-- 	<div  id="editBox">
				</div> -->
				<input type="hidden" id="idedite"/>
				<div class="cl mb-10">
				<label class="f-l w-90">厂家名称：</label>
				<input type="text" class="input-text w-210 f-l readonly" readonly="readonly" id="nameedite" />
			</div>
								<div class="cl mb-10">
					<label class="f-l w-90">账号：</label>
					<input type="text" id="loginNameedite" class="input-text w-210 f-l"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90">密码：</label>
					<input type="text" id="passwordedite" class="input-text w-210 f-l"/>
				</div>
				<div class="cl mb-10">
				<label class="f-l w-90">链接：</label>
				<input type="text" class="input-text w-210 f-l readonly" readonly="readonly"  id="linkedite"/>
			</div>
				<div class="text-c mt-25 pt-20">
					<a onclick="editSave()" class="sfbtn sfbtn-opt3 w-70 mr-5" id=" btn-edit-save" >保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="btn-edit-cancel" onclick="quxiaoxg()">取消</a>
				</div>
			</div>
		</div>
	</form>
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

<script type="text/javascript">
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
//var platformCategoryList = [];
var rId;

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
function initSfGrid(){//headerList
	sfGrid = $("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/siteVenderAccount/siteVenderAccountGrid', 
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		multiselect: false,
		shrinkToFit: true,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
	});
}

function fmtOper(rowData){
	
	var authFlage = '${fns:checkBtnPermission("SYSSETTLE_FACTORYMSG_FACTORYMSG_EDITE_BTN")}';
	var authFlagd = '${fns:checkBtnPermission("SYSSETTLE_FACTORYMSG_FACTORYMSG_DELETE_BTN")}';
	var uphtml = ''; 
	//var editehtml = ''; 
	var deletehtml = ''; 
	
	if(authFlage === 'true'){
		uphtml +="<span ><a class='c-0383dc' onclick=editOne('"+rowData.id+"') ><i class='sficon sficon-edit'></i>修改</a></span>&nbsp;&nbsp;"
	}
	if(authFlagd === 'true'){
		deletehtml += "&nbsp;<span><a class='c-0383dc' onclick=delOne('"+rowData.id+"') ><i class='sficon sficon-del'></i>删除</a></span>"
	}
		return uphtml+deletehtml;
}

function delOne(rowId){
	var content = "确认要删除该厂家资料？";
	//$("#decategory").val($("#tabswitchCurrent").text());
	//$("#deserviceMeasures").val(_name);
	$('body').popup({
		level:3,
		title:"删除",
		content:content,
		 fnConfirm :function(){
				$.ajax({
					url:"${ctx}/order/siteVenderAccount/delOne",
					data:{rowId:rowId}, 
					dataType:'json',
					success:function(result){
						if(result==true){
							layer.msg("删除成功！");
                            $("#table-waitdispatch").trigger("reloadGrid");
							//window.location.reload(true);
						}else{
							layer.smg("删除失败，请联系管理员！");
						}
					}
				})
		 }
	})
}

function editOne(rowId){
	//$('#editBox').empty();
				$.ajax({
					
					type:'POST',
					url:"${ctx}/order/siteVenderAccount/editOne",
					data:{rowId:rowId}, 
					traditional: true,
					//dataType:'json',
					//async:false,
					success:function(result1){
						$('#idedite').val(rowId);
					    $("#nameedite").val(result1.columns.name);
					    $("#loginNameedite").val(result1.columns.login_name);
					    $("#passwordedite").val(result1.columns.password);
					    $("#linkedite").val(result1.columns.link);
					$('.editManufacture').popup({fixedHeight:false});
					
					}
				});
	
	
	
}

function editSave(){
	var rowId=$("#idedite").val();
	var loginName = $("#loginNameedite").val();
	var password = $("#passwordedite").val();
	
	if($.trim(loginName)==""|| $.trim(loginName)==null){
		layer.msg("请填写账号！");
	}else if($.trim(password)==""|| $.trim(password)==null){
		layer.msg("请填写密码！");
    } else {
        $.ajax({
            type: 'POST',
            url: "${ctx}/order/siteVenderAccount/saveEdit",
            data: {
                rowId: rowId,
                loginName: loginName,
                password: password
            },
            dataType: 'text',
            success: function (result) {
                if (result == 'ok') {
                    layer.msg("修改成功！");
                    $.closeDiv($(".editManufacture"))
                    $("#table-waitdispatch").trigger("reloadGrid");
                } else if (result == 'exit') {
                    layer.msg("该账号已存在！");
                }else{
                    layer.msg("修改账号失败！");
				}
            }
        });

    }
	
}
function add(){
	layer.open({
		type : 2,
		content:'	${ctx}/order/siteVenderAccount/sitevenderForm',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	})
}






function quxiaoxg(){
	$.closeDiv($('.editManufacture'));
}
	

function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch($("#searchForm").serializeJson());
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

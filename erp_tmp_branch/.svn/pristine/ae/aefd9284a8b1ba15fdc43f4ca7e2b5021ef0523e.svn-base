<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
    								<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->


<style type="text/css">
        .SelectBG{
            background-color:#DDD;
            }
    </style>


  </head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<a class="btn-tabBar  current" href="${ctx}/order/areaManager">区域人员管理</a>
			<p class="f-r btnWrap">
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
								<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
					<th style="width: 76px;" class="text-r">区域：</th>
							<td>
                               <span class="w-140">
									<select class="select easyui-combobox"  id="statusFlag"  name="area" style="width:100%;height:25px" panelMaxHeight="130px">
									  <option value="" selected="selected">--请选择--</option>
						         <c:forEach items="${listarea }" var="area">
						         <option value="${area.columns.area }">${area.columns.area }</option>
						         </c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">姓名：</th>
							<td>
								<input type="text" class="input-text" name= "name"/>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name= "phone"/>
							</td>
					<!-- <th style="width: 76px;" class="text-r">区管等级：</label></th>
			        <td><select class="select w-140 f-l" name="level">
			        <option value="" selected="selected">--请选择--</option>
				           <option value="1">一级区管</option>
				           <option value="2">二级区管</option>
				         
			                </select>
			          </td> -->
			          
							</tr>
							</table>
							</div>
										<div class="pt-10 pb-5 cl">
				<div class="f-l">
			<a href="javascript:add();" class="sfbtn sfbtn-opt"><i class="sficon sficon-add"></i>添加</a>

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


<div class="popupBox sysNotice addNotice" style="width:500px">
	<h2 class="popupHead">
		添加
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-25 pr-25 pb-15">
			<!-- <div class="cl mb-10">
				<label class="w-80 text-r f-l">区管等级：</label>
				<select class="select w-140 f-l addlevel" name="addlevel" id="addlevel" >
					<option value="1" selected="selected">一级区管</option>
					<option value="2">二级区管</option>
				</select>
				<label class="w-100 text-r f-l">上级区管：</label>
				<select class="select w-140 f-l " style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0" name="superiorDistrict" id="superiorDistrict" datatype="*" nullmsg="请选择上级区管！"  >
					<option value="">请选择</option>
				</select>
			</div> -->
			<input type="hidden" name="addlevel" id="addlevel" value="1">
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">姓名：</label>
				<input type="text" class="input-text w-140 f-l addphone"  id="addname" name="addcontent">
				<label class="w-100 text-r f-l">联系方式：</label>
				<input type="text"  id="addphone" name="addphone" value="" class="input-text w-140 f-l addphone">
			</div>
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">区域：</label>
				<input class="input-text w-140 f-l addarea"  id="addarea" name="addarea" type="text"/>
				<label class="w-100 text-r f-l">激活码：</label>
				<input class="input-text w-140 f-l addcode"  id="addcode" name="addcode" type="text"/>
			</div>
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">登陆账号：</label>
				<input type="text" class="input-text w-140 f-l "  id="loginName" name="loginName">
				<label class="w-100 text-r f-l">登陆密码：</label>
				<input type="text"  id="password" name="password" class="input-text w-140 f-l ">
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-publish" onclick="fabu()">确认</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">取消</a>
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
	$('#statusFlag').combobox({
		editable:false
	});


	
	$("#superiorDistrict").change(function(){
       if($("#superiorDistrict").val()!=""){
    	   $(".addlevel option:eq(2)").attr('selected','selected');
       }else{
    	   $(".addlevel option:eq(1)").attr('selected','selected');
       }
	 		 
		});

});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/order/areaManager/areaManagerList";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		multiselect: false,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 			   var ids = $("#table-waitdispatch").getDataIDs();
              for(var i=0;i<ids.length;i++){
                  var rowData = $("#table-waitdispatch").getRowData(ids[i]);
                  if(rowData.status == "1"){//如果等于0，则背景色置灰显示
                      $('#'+ids[i]).addClass("SelectBG");
                  }
              } 
 		}
	});
}
$('#addlevel').change(function(){ 
	var name=$(".addlevel").val();
	if(name==="2"){
		var strls = "";
		$.ajax({
			url:"${ctx}/order/areaManager/changedistrict",
			dataType:'json',
			data:{"name":name},
			async:false,
			success:function(result){
				$.each(result.changecstr,function(index,val){
		                 
						strls+="<option value="+val+">"+val+"</option>";
					
				});
				$("#superiorDistrict").html();
				$("#superiorDistrict").html(strls);
			},
			error:function(){
				return;
			}
			
		}); 
	}else{
		strls+="<option value=''>请选择</option>"
		$("#superiorDistrict").html(strls);
	}
})


function siteOper(rowData){	
	return "<span><a href=javascript:opensite('"+rowData.id+"') class='c-0383dc'>"+rowData.siteCount+"</a></span>";	
}

/* function districtoper(rowData){
	if(rowData.superior_district!=null){
		return "<span>"+rowData.superior_district+"</span>"
	}else{
		return "<span>--</span>"
	}
	
} */

function areaCountOper(rowData){
	return "<span><a href=javascript:bindingsite('"+rowData.id+"') class='c-0383dc'>"+rowData.areaCount+"</a></span>";	
}

function fmtOper(rowData){
	if(rowData.status=="0"){
		return "<span><a href=javascript:edite('"+rowData.id+"') class='c-0383dc'>修改</a></span>&nbsp;&nbsp;<span><a href=javascript:down('"+rowData.id+"') class='c-0383dc downs'  >停用</a></span>"
	}else{
		return "<span><a href=javascript:edite('"+rowData.id+"') class='c-0383dc'>修改</a></span>&nbsp;&nbsp;<span><a href=javascript:start('"+rowData.id+"') class='c-0383dc downs'  >启用</a></span>"
	}
	
}
function down(id){
    	  content = "确认要停用该区域人员吗？确定停用后，区域人员与关联服务商自动解除绑定。";
    	  msg="已停用";
    	  status="0";
		$('body').popup({
			level:3,
			title:"停用",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/areaManager/down",
						traditional: true,
								data:{
								"id":id,
								"status":status
								},
								async:false,
							 success:function(result){
									if(result=="ok"){
									layer.msg(msg,{time:2000});
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
function start(id){
	  content = "确认要启用该区域人员吗？";
	  msg="已启用";
	  status="1";
	$('body').popup({
		level:3,
		title:"启用",
		content:content,
		 fnConfirm :function(){
				$.ajax({
					type:"POST",
					url:"${ctx}/order/areaManager/down",
					traditional: true,
							data:{
							"id":id,
							"status":status
							},
							async:false,
						 success:function(result){
								if(result=="ok"){
								layer.msg(msg,{time:2000});
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
function add(){//打开添加弹出框
	
	$('.addNotice').popup();
	$(".addcode").val(randomWord(true,4,4))
}
function fabu(){
	var superiorDistrict=$("#superiorDistrict").val();
	var name=$("#addname").val();
	var phone=$("#addphone").val();
	var area=$("#addarea").val();
	var code=$("#addcode").val();
	var loginName=$("#loginName").val();
	var password=$("#password").val();
	
	if (isBlank(name)) {
		layer.msg("请输入姓名");
		$("#addname").focus();
		return;
	
	}
	 if (isBlank(phone)) {
			layer.msg("请输入联系方式");
			$("#addphone").focus();
			return;
			
	 }
	 if (isPhoneNo(phone) == false) {
			layer.msg("手机号码格式不正确");
			return;
		}
		if (isBlank(area)) {
			layer.msg("请输入区域");
			$("#addarea").focus();
			return;
		
		}
		if (isBlank(code)) {
			layer.msg("请输入激活码");
			$("#addcode").focus();
			return;
		
		}
		if(isCode(code)==false){
			layer.msg("激活码格式不正确");
			return;
			
		}
		if (isBlank(loginName)) {
			layer.msg("请输入登陆账号");
			$("#loginName").focus();
			return;
			
		}
		if (isBlank(password)) {
			layer.msg("请输入登陆密码");
			$("#password").focus();
			return;
			
		}
	$.ajax({
		type:'POST',
		url:"${ctx}/order/areaManager/addareaManager",
		traditional: true,
		data:{
			"superiorDistrict":superiorDistrict,
		    "name":name,
		    "phone":phone,
		    "area":area,
		    "code":code,
		    "loginName":loginName,
		    "password":password
		},
		success:function(result){
			if(result=="ok"){
				$.closeDiv($(".addNotice"));
				window.location.reload(true);
			}else if(result == "login"){
				 layer.msg("该登陆账号已存在!");
				$("#loginName").focus();
				return;
			}else if(result == ""){
				layer.msg("添加失败");
				return;
			}else {
				layer.msg(result);
				return;
			}
		},
		error:function(){
			layer.msg("系统繁忙请稍后重试")
			return;
		}
	})
}

function edite(id){//打开修改弹出框
	layer.open({
		type : 2,
		content:'${ctx}/order/areaManager/tovareaForm?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	})
}

function opensite(id){//打开关联服务商列表弹出框
	layer.open({
		type : 2,
		content:'${ctx}/order/areaManager/topensite?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	})
}

function bindingsite(id){//打开关联服务商列表弹出框
	layer.open({
		type : 2,
		content:'${ctx}/order/areaManager/bindingsite?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	});
}





function closeds(){
	$.closeDiv($(".addNotice"));
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

function randomWord(randomFlag, min, max){
    var str = "",
        range = min,
        arr = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
 
    // 随机产生
    if(randomFlag){
        range = Math.round(Math.random() * (max-min)) + min;
    }
    for(var i=0; i<range; i++){
        pos = Math.round(Math.random() * (arr.length-1));
        str += arr[pos];
    }
    return str;
}
function isPhoneNo(phone) {
	var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
	return pattern.test(phone);
}

function isCode(code){
	var pattern =/^[a-zA-Z0-9]{4}$/;
	return pattern.test(code);
}

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}
</script>
  </body>
</html>
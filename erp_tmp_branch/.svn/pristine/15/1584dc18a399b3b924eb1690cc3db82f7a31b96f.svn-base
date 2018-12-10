<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品信息管理</title>
	<meta name="decorator" content="base"/>
	
</head>
<body>
<div class="sfpagebg">
<div class="sfpage bk-gray table-header-settable">
<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
<a class="btn-tabBar  current" href="${ctx}/order/smsTemplate">短信模板</a>
			<p class="f-r btnWrap">
				<a href="javascript:;"  onclick="showwxgd()"class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>批量删除</a>
				<a class="sfbtn sfbtn-opt" id="btn-add"  onclick="openadd()"><i class="sficon sficon-add"></i>添加</a>
				<a class="sfbtn sfbtn-opt" id="btn-edite"  onclick="openedite()"><i class="sficon sficon-reset"></i>修改</a>
				
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


<div class="popupBox gysxzsp tjmb"  style="z-index:101;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>tid：</label>
					<input type="text" class="input-text w-140 f-l tjtid" />
					
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>模板名称：</label>
					<input type="text" class="input-text w-140 f-l tjname" />
					
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>标签：</label>
					<input type="text" class="input-text w-140 f-l tjtag" />
				</div>
				<div class="pl-90 pos-r mb-10" >
					<label class="w-90 lb">模板类容：</label>
					<textarea class="textarea h-50 tjcontent"></textarea>
				</div>

			</div>	
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  id="btnSubmitsave">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  id="guanbisave">取消</a>
			</div>
			<div>
			<p style="color: red">*注：模板类容中"@"符号代表模板自动获取的不确定类容，所有不确定类容请用"@"符号代替</p>
			</div>
		</div>
	</div>
</div>


<div class="popupBox gysxzsp xgmb"  style="z-index:101;">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<div class="cl mb-10">
				<input type="hidden"  id="ids" />
					<label class="f-l w-90"><em class="mark">*</em>tid：</label>
					<input type="text" class="input-text w-140 f-l xgtid" />
					
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>模板名称：</label>
					<input type="text" class="input-text w-140 f-l xgname" />
					
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>标签：</label>
					<input type="text" class="input-text w-140 f-l xgtag" />
				</div>
				<div class="pl-90 pos-r mb-10" >
					<label class="w-90 lb"><em class="mark">*</em>模板类容：</label>
					<textarea class="textarea h-50 xgcontent"></textarea>
				</div>

			</div>	
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  id="btnSubmitedite">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  id="guanbiedite">取消</a>
			</div>
			<div>
			<p style="color: red">*注：模板类容中"@"符号代表模板自动获取的不确定类容，所有不确定类容请用"@"符号代替</p>
			</div>
		</div>
	</div>
</div>



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
	sfGrid = $("#table-waitdispatch").sfGrid({
		url : '${ctx}/order/smsTemplate/smsTemplatelist', 
		/* url : '${ctx}/order/orderType/orderTypeList', */
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		shrinkToFit: true,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
	});
}
function statuTrans(rowData){
	if(rowData.status==0){
		return "<span>正常</span>";
	}else{
		return "<span>已删除</span>";
	}
}



function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch($("#searchForm").serializeJson());
}

function openadd(){//打开添加弹出框
	$('.tjmb').popup();
}

$('#btnSubmitsave').click(function(){//提交修改信息
	
	var tid=$('.tjtid').val();
	var name=$('.tjname').val();
	var tag=$('.tjtag').val();
	var content=$('.tjcontent').val();
	if(tid==null||tid==""){
		layer.msg("tid为必填项");
		return;
	}
	if(name==null||name==""){
		layer.msg("模板名称为必填项");
		return;
	}
	if(tag==null||tag==""){
		layer.msg("标签为必填项");
		return;
	}
	if(content==null||content==""){
		layer.msg("模板类容为必填项");
		return;
	}
	if(tid.match(/\D/)){
		layer.msg("tid请输入数字");
		return;
	}
	if(tag.match(/\D/)||tag.length>2){
		layer.msg("标签请输入不超过两位数数字");
		return;
	}
		$.ajax({
			type:'POST',
			url:"${ctx}/order/smsTemplate/addtemplate",
			traditional: true,
			data:{
				"tid":tid,
				"name":name,
				"tag":tag,
				"content":content
			},
			success:function(data){
				$.closeDiv($(".tjmb"));
				window.location.reload(true);
			},
			error:function(){
				layer.alert("系统繁忙!");
				return;
			}
			
		})
	
	

})

function openedite(){
	//打开修改弹出框
	
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){
		layer.msg("请选择数据")
		return;
		}else if(idArr.length>1){
			layer.msg("选择数据不能大于1")
		}else{
			var id=idArr[0];
			$.ajax({
				type:'POST',
				url:"${ctx}/order/smsTemplate/gettemplatebyid",
				traditional: true,
				data:{
					"id":id
				},
				success:function(template){
					
					$('#ids').val(template.columns.id)
					$('.xgtid').val(template.columns.number);
					$('.xgname').val(template.columns.name);
					$('.xgtag').val(template.columns.tag);
					$('.xgcontent').val(template.columns.content);
					$('.xgmb').popup();
					
				}
			})
			
			
		}

}

$('#btnSubmitedite').click(function(){
	var id=$('#ids').val();
	var tid=$('.xgtid').val();
	var name=$('.xgname').val();
	var tag=$('.xgtag').val();
	var content=$('.xgcontent').val();
	if(tid==null||tid==""){
		layer.msg("tid为必填项");
		return;
	}
	if(name==null||name==""){
		layer.msg("模板名称为必填项");
		return;
	}
	if(tag==null||tag==""){
		layer.msg("标签为必填项");
		return;
	}
	if(content==null||content==""){
		layer.msg("模板类容为必填项");
		return;
	}
	if(tid.match(/\D/)){
		layer.msg("tid请输入数字");
		return;
	}
	if(tag.match(/\D/)||tag.length>2){
		layer.msg("标签请输入两位数数字");
		return;
	}
	$.ajax({
		type:'POST',
		url:"${ctx}/order/smsTemplate/updatetemplate",
		traditional: true,
		data:{
			"id":id,
			"tid":tid,
			"name":name,
			"tag":tag,
			"content":content
		},
		success:function(data){
			$.closeDiv($(".xgmb"));
			window.location.reload(true);
		},
		error:function(){
			layer.alert("系统繁忙!");
			return;
		}
		
	})

})
$('#guanbisave').on('click', function() {
	$.closeDiv($('.tjmb'));
});
$('#guanbiedite').on('click',function(){
	$.closeDiv($('.xgmb'));
})


function showwxgd(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){layer.msg("请选择数据！");}else{
		var content = "确认要删除"+idArr.length+"条短信模板？";
		//$("#decategory").val($("#tabswitchCurrent").text());
		//$("#deserviceMeasures").val(_name);
		
		$('body').popup({
			level:3,
			title:"删除",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/smsTemplate/deletetemplate",
						traditional: true,
								data:{
								"idArr":idArr
								},
								async:false,
							 success:function(data){
									if(data){
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
}









</script>
</body>
</html>
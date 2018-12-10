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
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
		<div class="tabBar cl mb-10">
			<a class="btn-tabBar  current" href="${ctx}/order/VendorSet">厂家设置</a>
			<a class="btn-tabBar" href="${ctx}/order/serviceType">服务类型</a>
			<a class="btn-tabBar " href="${ctx}/order/serviceMode">服务方式</a>
		</div>
		<div class="mt-10"><a class="sfbtn sfbtn-opt" id="btn-add" ><i class="sficon sficon-add"></i>添加</a></div>
		<div class="mt-10">
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


<div class="popupBox gysxzsp"  style="z-index:101;  width:400px;">
	<h2 class="popupHead">
		修改厂家信息
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl mb-10">
				<input type="hidden"  name="venderid" id="venderid"/>
			    <input type="hidden"  name="vendernames" id="venderoldname"/>
					<label class="f-l w-80">厂家名称：</label>
					<input type="text" class="input-text w-240 f-l vendername"  />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">厂家链接：</label>
					<input type="text" class="input-text w-240 f-l venderurl"  />
				</div>
		
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$('#btn-add').click(function(){
	layer.open({
		type : 2,
		content:'${ctx}/order/VendorSet/tovenderForm',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1 
	})
});
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/order/VendorSet/venderList";
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




function fmtOper(rowData){	
	return "<span><a href=javascript:updateMsg('"+rowData.id+"') class='c-0383dc mr-15'><i class='sficon sficon-edit'></i>修改</a></span>&nbsp;&nbsp;<span><a class='c-0383dc' href=javascript:deleteMsg('"+rowData.id+"')><i class='sficon sficon-del'></i>删除</a></span>";	
}
function deleteMsg(id) {
	var content = "确定要删除该厂家？";
	$('body').popup({
		level: 3,
		title: "删除",
		content: content,
		fnConfirm: function () {
			$.ajax({
				type: "POST",
				url: "${ctx}/order/VendorSet/delete",
				traditional: true,
				data: {
					"id": id
				},
				success: function (data) {
					if (data > 0) {
						layer.msg("删除完成!", {time: 2000});
						window.location.reload(true);
					} else {
						layer.msg("操作失败!", {time: 2000});
					}
				},
				error: function () {
					layer.msg("系统繁忙!");
					return;
				}
			});
			layer.closeAll('dialog');
		}
	});


}

function updateMsg(id){
	//打开修改弹出框
			$.ajax({
				type:'POST',
				url:"${ctx}/order/VendorSet/getVenderById",
				traditional: true,
				data:{
					"id":id
				},
				success:function(vender){
					$('#venderid').val(id);
					$('.vendername').val(vender.columns.name);
					$('.venderurl').val(vender.columns.url);
					$('#venderoldname').val(vender.columns.name);
					$('.gysxzsp').popup();
				}
			})
}

$('#btnSubmit').click(function(){
	var id=$('#venderid').val()
	var name=$('.vendername').val();
	var oldname=$('#venderoldname').val();
	var url=$('.venderurl').val();
	var nameArr = [];
	<c:forEach items="${nameList}" var="item">
	nameArr.push("${item}");
	
	</c:forEach>
	if(name!=oldname){
		if($.inArray(name, nameArr)!=-1){
			layer.msg("厂家名称有重复")
			return;
		}
	}
	if (url == null || !/^(http:\/\/|https:\/\/)?\w+(\.\w+)+/i.test(url)) {
		layer.msg("链接格式不正确");
		return;
	}
	
	$.ajax({
		type:'POST',
		url:"${ctx}/order/VendorSet/saveVender",
		traditional: true,
		data:{
			"id":id,
			"name":name,
			"url":url
		},
		success:function(flag){
			if(flag){
				layer.msg("修改成功");
				$.closeDiv($(".gysxzsp"));
				window.location.reload(true);
			}else{
				layer.msg("修改失败");
				return;
			}
		},
		error:function(){
			layer.msg("系统错误，请稍后重试")
			return;
		}
	})
})

function closed(){
	$.closeDiv($(".gysxzsp"));
}


</script>
  </body>
</html>
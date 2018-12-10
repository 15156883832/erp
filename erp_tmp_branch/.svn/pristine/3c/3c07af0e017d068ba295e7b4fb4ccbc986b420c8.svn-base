<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">

.webuploader-pick{
	width:80px;
	height:26px;
	background: #0e8ee7;
	color: #fff;
	line-height: 26px;
	padding: 0;
}

</style>
  </head>
  
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<a class="btn-tabBar  " href="${ctx}/order/announcement/set">公告设置</a>
		<a class="btn-tabBar current" href="${ctx}/order/docupload/set">下载设置</a>
			<p class="f-r btnWrap">

			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="10">
						
										<div class="pt-10 pb-5 cl">
				<div class="f-r">
			<a href="javascript:add();" class="sfbtn sfbtn-opt"><i class="sficon sficon-add"></i>添加</a>
				<a href="javascript:deletes();" class="sfbtn sfbtn-opt"><i class="sficon sficon-rubbish"></i>删除</a>
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


<div class="popupBox w-500 addNotice">
	<h2 class="popupHead">
		上传文件
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-15 pr-25 pb-15">
			<div class="cl mb-10">
				<label class="w-80 text-r  f-l"><em class="mark">*</em>文件名称：</label>
				<input type="text" class="input-text addname w-140 f-l" name="addname"/>
				<label class="w-80 text-r f-l"><em class="mark">*</em>文件类型：</label>
				<select class="select w-140 f-l adddoctype" name="adddoctype">
				
					<option value="1">doc</option>
					<option value="1">docx</option>
					<option value="2">xls</option>
					<option value="2">xlsx</option>
					<option value="3">ppt</option>
					<option value="3">pptx</option>
					<option value="5">其他</option>
				</select>
			</div>

			<div class="pos-r pl-80 mb-10">
				<label class="w-80 text-r lb"><em class="mark">*</em>文件描述：</label>
				<textarea class="textarea adddescription" style="" id="textarea" name="adddescription"></textarea>
			</div>
			<div class="cl ">
				<label class="w-80 text-r f-l"><em class="mark">*</em>文件上传：</label>
				<div class="f-l">
					<input type="text" class="input-text w-240 f-l" id="docpath">
					<input type="hidden"  id="realdocpath" >
					<input type="hidden"  id="extpath" value="5">
					<input type="hidden"  id="elseexttype" >
					<input type="hidden"  id="filesize" >
					<a class=" w-80 text-c lh-26 ml-10 f-l" style="color:#fff" id="ups" >上传</a>
				</div>
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-publish" onclick="fabu()">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">取消</a>
			</div>
		</div>
	</div>
</div>




<!--_footer 作为公共模版分离出去-->


<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
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
	var url = "${ctx}/order/docupload/getdocsetlist";
	sfGrid = $("#table-waitdispatch").sfGrid({
		url:url, 
		sfHeader:defaultHeader,
		sfSortColumns:sortHeader,
		shrinkToFit: true,
		rownumbers : true,
 		gridComplete:function(){
 			_order_comm.gridNum();
 		}
		//multiselect: false,
	});
}



$(function(){  
	var uploader=WebUploader.create({
		auto : true,
		swf : '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
		server : '${ctx}/common/uploadFile2',
		duplicate : true,
		fileSingleSizeLimit : 1024 * 1024 * 40,
		//fileNumLimit: 1, 
		pick : '#ups',
		accept : {
			title : 'Applications',
			extensions : 'doc,docx,ppt,pptx,xls,xlsx',
			mimeTypes : 'application/doc,application/docx,application/ppt,application/pptx,application/xls,application/xlsx'
		},
		method : 'POST'
	  
  });
	uploader.on('beforeFileQueued', function(file) {
		uploader.reset();
	});
	uploader.on('uploadSuccess', function(file, response) {
		var filesizestr=(file.size).toString();
		$("#docpath").val(response.filename);
		$("#realdocpath").val(response.path);
		$("#filesize").val(filesizestr);
		if(response.extName==".doc"||response.extName==".docx"){
			$("#extpath").val(1)
			$("#elseexttype").val(response.extName)
		}else if(response.extName==".xls"||response.extName==".xlsx"){
			$("#extpath").val(2)
			$("#elseexttype").val(response.extName)
		}else if(response.extName==".ppt"||response.extName==".pptx"){
			$("#extpath").val(3)
			$("#elseexttype").val(response.extName)
		}else{
			$("#extpath").val(5)
			$("#elseexttype").val(response.extName)
		}
	});
  uploader.on("error", function(type) {
		if (type == "Q_TYPE_DENIED") {
			layer.alert("请上传XLS、PPTX、DOCX格式文件");
		} else if (type == "F_EXCEED_SIZE") {
			layer.alert("文件大小不能超过40M");
		}
	});
  uploader.on("uploadProgress", function(file,percentage) {

	});
	uploader.on('uploadError', function(file, reason) {
        layer.msg(reason);
	});
	

	uploader.on('fileQueued', function(file) {
		$("#up").text("重新选择");
		//   uploader.upload();  
	});

})
	  

		 
		 







function add(){//打开添加弹出框
	$('.addNotice').popup();
}

var flag = false;
function fabu(){
	if(flag) {
	    return;
    }

	var name=$(".addname").val();
	var doctype=$(".adddoctype").val();
	var htype=$("#extpath").val();
	var realdoctype=$("#elseexttype").val();
	var description=$(".adddescription").val();
	var docpath=$("#docpath").val();
	var realdocpath=$("#realdocpath").val();
	var filesize=$("#filesize").val();
	
	if(name==null||name==""){
		layer.msg("文件名称为必填");
		return;
	}
	if(doctype==null||doctype==""){
		layer.msg("请选择文件类型");
		return;
	}

	if(description==null||description==""){
		layer.msg("文件描述为必填项");
		return;
	}
	if(doctype!=htype){
		layer.msg("所选文件类型与上传文件类型不符合");
		return;
	}
	 var thisid= $("#table-waitdispatch").getCol("name",false)
	 if(thisid.indexOf(name)>=0){
 		var content=name+"已存在，确认覆盖该文件？"
		$('body').popup({
			level:3,
			title:"提示",
			content:content,
			 fnConfirm :function(){
					flag = true;
					$.ajax({
						type:'POST',
						url:"${ctx}/order/docupload/save",
						traditional: true,
						data:{
							"name":name,
							"doctype":realdoctype,
						    "description":description,
						    "realdocpath":realdocpath,
						    "icon":htype,
						    "filesize":filesize
						},
						//async:false,
						success:function(result){
							if(result=="ok"){
								$.closeAllDiv();
								search();
								clear();
							}else{
								layer.msg(result);
								return;
							}
						},
						 complete: function() {
				             flag = false;
				         },
						error:function(){
							layer.msg("系统繁忙请稍后重试")
							return;
						}
					})
					layer.closeAll('dialog');
			 }
		});
	 }else{
 		flag = true;
		$.ajax({
			type:'POST',
			url:"${ctx}/order/docupload/save",
			traditional: true,
			data:{
				"name":name,
				"doctype":realdoctype,
			    "description":description,
			    "realdocpath":realdocpath,
			    "icon":htype,
			    "filesize":filesize
			},
			success:function(result){
				if(result=="ok"){
					$.closeDiv($(".addNotice"));
					//window.location.reload(true);
					search();
					clear();
				}else{
					layer.msg(result);
					return;
				}
			},
			 complete: function() {
	             flag = false;
	         },
			error:function(){
				layer.msg("系统繁忙请稍后重试")
				return;
			}
		})
	 }

}

function deletes(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){layer.msg("请选择数据！");}else{
		var content = "确认要删除"+idArr.length+"个文档吗？";
		$('body').popup({
			level:3,
			title:"删除",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/docupload/delete",
						traditional: true,
								data:{
								"idArr":idArr
								},
								async:false,
							 success:function(result){
									if(result=="ok"){
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



function closeds(){
	$.closeDiv($(".addNotice"));
	clear();
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

function clear(){
		$("input").val("");
		$("select").val("");
		$("textarea").val("");
		$("hidden").val("");
}
</script>
  </body>
</html>
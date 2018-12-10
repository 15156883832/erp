<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all2.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
  </head>
  <body>
    <div class="sfpagebg">
	<div class="sfpage bk-gray table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-10">
		<a class="btn-tabBar  current" href="${ctx}/order/announcement/set">公告设置</a>
		<a class="btn-tabBar" href="${ctx}/order/docupload/set">下载设置</a>
			<p class="f-r btnWrap">
			<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
			
		<div class="tabCon">
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="10">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">公告类型：</label></th>
					        <td>
						        <select class="select w-140 f-l" name="type" id="typeAnn">
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
				<div class="f-l">
					<a href="javascript:add();" class="sfbtn sfbtn-opt"><i class="sficon sficon-add"></i>发布公告</a>
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


<div class="popupBox sysNotice addNotice" style="width:900px;">
	<h2 class="popupHead">
		发布公告
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r pb-50">
			<div class="pcontent pt-15 pr-15 pb-15" >
				<div class="pos-r pl-80 mb-10">
					<label class="w-80 text-r lb">公告类型：</label>
					<select class="select w-140  addtype" name="addtype">
					
						<option value="1">系统升级</option>
						<option value="2">功能说明</option>
						<option value="3">系统通知</option>
					</select>
				</div>
				<div class="pos-r pl-80 mb-10">
					<label class="w-80 text-r lb">公告标题：</label>
					<input type="text" class="input-text addtitle w-600" name="addtitle"/>
				</div>
				<div class="mb-10 cl">
					<label class="w-80 text-r f-l">公告内容：</label>
					<div class="f-l" style="width:790px">
						<div class="">
							<!-- 编辑器 -->
							<script id="container" name="content" type="text/plain">
       				 
   						</script>
							<textarea class="textarea h-50 hide addcontent" value="" id="html" name="html"></textarea>
						</div>
					</div>
				</div>
				<div class="pos-r pl-80">
					<label class="w-80 text-r lb">发布时间：</label>
					<input type="text" onclick="WdatePicker()" id="bxdatemin" name="bxdatemin" value="" class="input-text Wdate w-140 addtime">
				</div>
			</div>
			<div class="text-c btnWrap">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-publish" onclick="fabu()">发布</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">关闭</a>
			</div>
			
		</div>
	</div>
</div>



<div class="popupBox sysNotice editeNotice" style="width:900px;">
	<h2 class="popupHead">
		修改公告
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r pb-50">
			<div class="pcontent pt-15 pr-15 pb-15" >
				<div class="pos-r pl-80 mb-10">
				<input type="hidden"  id="ids"/>
					<label class="w-80 text-r lb">公告类型：</label>
					<select class="select w-140    editetype"   name="editetype">
						<option value="1">系统升级</option>
						<option value="2">功能说明</option>
						<option value="3">系统通知</option>
					</select>
				</div>
				<div class="pos-r pl-80 mb-10">
					<label class="w-80 text-r lb">公告标题：</label>
					<input type="text" class="input-text editetitle w-600"   name="editetitle" id="editetitle"/>
				</div>
				<div class="cl mb-10">
					<label class="w-80 f-l">公告内容：</label>
					<div class="f-l " style="width:790px" >
						<div class="">
							<!-- 编辑器 -->
							<script id="container1" name="content1" type="text/plain">
       				 
   						</script>
							<textarea class="textarea h-50 hide addcontent" value="" id="html1" name="html1"></textarea>
						</div>
					</div>
				</div>
				<div class="cl">
					<label class="w-80 text-r f-l">发布时间：</label>
					<input type="text " onclick="WdatePicker()" id="bxdatemin" name="bxdatemin" value="" class="input-text Wdate w-140 editetime">
				</div>
			</div>
			<div class="text-c btnWrap ">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5 " id="btn-publish" onclick="edite()">修改</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closed()">关闭</a>
			</div>
			
		</div>
	</div>
</div>

<script type="text/javascript">
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var ue1;
$(function(){
	//防止图片过宽
	fixImgWidth();
	ue = UE.getEditor('container',{
		serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
		toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
                      'simpleupload', 'insertimage', 'preview','fullscreen']],
                      autoHeightEnabled: false,
                      autoFloatEnabled: false,
                   elementPathEnabled : true,
                   initialFrameHeight: 400  //150
	});
	ue.ready(function(){
		//ue.setContent('<p>顶顶顶顶</p><p style="text-align: center;"><img src="http://192.168.2.23:80/sfimggroup/M00/00/15/wKgCF1mT4pmAGyYbAAB_8JXQmeU610.jpg" alt="u=2677606714,1573372941&amp;fm=26&amp;gp=0.jpg" width="266" height="219" style="width: 266px; height: 219px;"/></p>');
		 // 阻止工具栏的点击向上冒泡
	    $(this.container).click(function(e){
	        e.stopPropagation();
	    });
	    // 解决悬浮问题
	    if (UE.browser.ie && UE.browser.version <= 7) {
    		FixIe7Bug();
    	}
	}) 
	
	ue1 = UE.getEditor('container1',{
			serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
			toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
                      'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',  
                      'simpleupload', 'insertimage', 'preview','fullscreen']],
                      autoHeightEnabled: false,
                      autoFloatEnabled: false,
                   elementPathEnabled : true,
                   initialFrameHeight: 400
			});
			ue1.ready(function(){
				 // 阻止工具栏的点击向上冒泡
			    $(this.container).click(function(e){
			        e.stopPropagation();
			    });
			    // 解决悬浮问题
			    if (UE.browser.ie && UE.browser.version <= 7) {
		    		FixIe7Bug();
		    	}
			});
	
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid();
});

//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	var url = "${ctx}/order/announcement/getannouncementsyslist";
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



function openContent(rowData){	
	return "<span><a href=javascript:updateMsg('"+rowData.id+"') class='c-0383dc'>"+rowData.title+"</a></span>";	
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
function deletes(){
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	if(idArr.length<1){layer.msg("请选择数据！");}else{
		var content = "确认要删除"+idArr.length+"条系统公告吗？";
		$('body').popup({
			level:3,
			title:"删除",
			content:content,
			 fnConfirm :function(){
					$.ajax({
						type:"POST",
						url:"${ctx}/order/announcement/delete",
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
function add(){//打开添加弹出框
	
	$('.addNotice').popup();
	$('.addNotice').css({"top":"10px"});
}
function fabu(){
	$("#html").val(ue.getContent());
	var type=$(".addtype").val();
	var title=$(".addtitle").val();
	var content=$(".addcontent").val();
	var createTime=$(".addtime").val();
	$.ajax({
		type:'POST',
		url:"${ctx}/order/announcement/addannouncement",
		traditional: true,
		data:{
			"type":type,
		    "title":title,
		    "content":$("#html").val(),
		    "createTime":createTime
		},
		success:function(result){
			if(result){
				$.closeDiv($(".addNotice"));
				window.location.reload(true);
			}else{
				layer.msg("添加失败");
				return;
			}
		},
		error:function(){
			layer.msg("系统繁忙请稍后重试")
			return;
		}
	}) 
}

function updateMsg(id){//打开修改弹出框
	$.ajax({
		type:'POST',
		url:"${ctx}/order/announcement/getannouncementbyid",
		traditional: true,
		data:{
			"id":id
		},
		success:function(announcement){
			$('#ids').val(announcement.columns.id)
			$('.editetype').val(announcement.columns.type);
			$('.editetitle').val(announcement.columns.title);
			$('.editetime').val(announcement.columns.create_time);
			ue1.setContent(announcement.columns.content);
			
			$('.editeNotice').popup();
			$('.editeNotice').css({"top":"10px"});
		}
	})
} 

function edite(){//修改公告
	$("#html1").val(ue1.getContent());
	var id=$('#ids').val();
	var type=$('.editetype').val();
	var title=$('.editetitle').val();
	var content=$('.editecontent').val();
	var createTime=$('.editetime').val();
	$.ajax({
		type:'POST',
		url:"${ctx}/order/announcement/updateannouncement",
		traditional: true,
		data:{
			"id":id,
			"type":type,
			"title":title,
			"content":$("#html1").val(),
			"createTime":createTime
		},
		success:function(resulte){
			if(resulte=="ok"){
				$.closeDiv($(".editeNotice"));
				window.location.reload(true);
			}else{
				layer.msg("修改失败");
				return;
			}
		},
		error:function(){
			layer.msg("系统繁忙请稍后重试")
			return;
		}
	})
}

function closed(){
	$.closeDiv($(".editeNotice"));
}

function closeds(){
	$.closeDiv($(".addNotice"));
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

//防止图片过宽
function fixImgWidth(){
	$('#activeEditor img').each(function(item,index){
			$(this).bind('load', function() {//针对谷歌浏览器解决图片不能缩小的bug
				if($(this).width()>600){
					$(this).width(600);
				}
				$(this).parent().width($(this).width());
			});
			if($(this).width()>600){
					$(this).width(600);
				}
				$(this).parent().width($(this).width());
		});
}

</script>
  </body>
</html>
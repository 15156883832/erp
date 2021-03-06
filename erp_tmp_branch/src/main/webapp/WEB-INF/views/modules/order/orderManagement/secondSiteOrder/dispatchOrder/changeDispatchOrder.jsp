<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>待处理工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<style type="text/css">
.webuploader-pick{
	width:44px;
	height:20px;
	line-height:20px;
	padding:0;
	overflow:visible;
}

.webuploader-pick img{
	width:100%;
	height:100%;
	position:absolute;
	left:0;
	top:0;
}
.table-border {
    border-top: none;
}
.backcolor-defined{
	background-color:#d2e9ff;
}
.hoverDefined:hover{
	background-color:#d2e9ff!important;
}
.backcolor-defined1{
	background-color:#FEF3F3;
}
</style>
</head>
<body>
<!-- 指派到二级网点 -->
<div class="popupBox  dispatchOrder" style="display: block;width:600px">
    <h2 class="popupHead">
        转派
        <a href="javascript:closeLsDiv();" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="pcontent">
            <div class="popupMain pl-15 pt-5 pb-15">
                <div class="searchEr">
                    <input type="text" id="searchName" style="height:100%;" placeholder="请输入二级网点"><img src="${ctxPlugin}/static/h-ui.admin/images/search.png" alt="">
                    <input id="searchCategory" value="${selectcategory }" hidden="hidden" />
                    <input id="selectbrand" value="${selectbrand }" hidden="hidden" />
                    <input id="orderId" value="${orderId }" hidden="hidden" />
                </div>
                <!-- <div class="mt-10 showLatestlook" hidden="hidden">
					<a class="iconDec1"></a>该用户最近一次（30天内）的服务工程师：<span id="latestEmps" style="width: 195px;overflow:hidden;text-overflow: ellipsis;white-space: nowrap;" ></span>
				</div> -->
                <!-- <p>该用户最近一次（30天内）的服务工程师：张三—张三</p> -->
                <div class="custom-fold-table text-l pushEr">
                    <table class="table-bg table ellipsis-thead custom-table last-column-center table-border">
                        <thead>
                        <tr class="h-30">
                            <th width="350px" class="text-c">二级网点</th>
                            <th width="200px" class="text-c">选择</th>
                        </tr>
                        </thead>
                    </table>
                    <div id="allList">
	                    <c:forEach items="${siteList }" var="sl" varStatus="ids">
		                    <div class="tree-table">
		                        <div class="tr-level-1">
		                            <table class="custom-table ellipsis-table last-column-center table-border">
		                                <tbody>
			                                <tr  class="fold-click hoverDefined " siteType="${sl.columns.site_type}" style="cursor:pointer;" markIndex="${ids.index }">
			                                    <td width="350px"  class="<c:if test="${sl.columns.site_type=='1' }">siteNameClick</c:if>" sId="${sl.columns.site_id }" >${sl.columns.name }<c:if test="${sl.columns.site_type=='2' }"><span style="color:#9d9d9d;">（合作型）</span></c:if></td>
			                                    <td width="200px" class="text-c"><input class="selectChecked  thischecked" mark="1" sname="${sl.columns.name }" value="${sl.columns.site_id }" type="radio"></td>
			                                </tr>
		                                </tbody>
		                            </table>
		                            <div class="level-2">
		                                <div class="tr-level-2">
		                                    <table class="custom-table ellipsis-table last-column-center table-border">
		                                        <tbody id="bodys${ids.index }" bodySite="${sl.columns.name }">
		                                        
		                                        </tbody>
		                                    </table>
		                                </div>
		                            </div> 
		                        </div>
		                    </div>
	                    </c:forEach>
                    </div>
                </div>
                <p class="surePush"><span class="mark">转派至：</span><span id="dispatchPeople"></span></p>
                <div class="pos-r pl-70 pr-10 mb-5 mt-10">
					<label class="w-70 pos"><em class="mark">*</em>转派原因：</label>
					<textarea class="textarea h-40 mustfill" id="zpReson"></textarea>
				</div>
                <div class="text-c ">
                    <a href="javascript:dispatchChangeOrderSave();" class="sfbtn sfbtn-opt3 w-100">确认转派</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
	$(function(){
		$(".dispatchOrder").popup();
		suitTAbleGrid();
		changeCheckBox();
		treeAdjust();
		$('#searchName').keyup(function(){
			$('#allList tr').hide()     
			.filter(":contains('" +($(this).val()) + "')").show();  
			if(isBlank($(this).val())){
				$('#allList tr').show();
			}
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发  
	})
	
	function suitTAbleGrid(){
		 // 折叠表格数组件
		$(document).on('click', '.tree-table .fold-click', function (e) {
	    	var siteType = $(this).attr("siteType");
	    	var selectCheckedName = $(this).find(".selectChecked").attr("sname");
	    	$(".fold-click").each(function(){
	    		$(this).removeClass("backcolor-defined");
	    	})
	    	$(this).addClass("backcolor-defined");
	    	$("#dispatchPeople").text(selectCheckedName);
	    	var markIndex = $(this).attr("markIndex");
	    	var obj = this;
	    	var str = "bodys"+markIndex;
	        if ($(this).hasClass('active')) {
	        	$(this).find(".selectChecked").attr("checked",true);
	            $(this).removeClass('active').closest('table').nextAll().children().slideUp();
	            $(".employeChecked").each(function(){
	            	$(this).attr("checked",false);
	            });
	            $(".thisEmpchecked").each(function(){
	            	$(this).removeClass("backcolor-defined1");
	            });
	        }else {
	        	$(".employeChecked").each(function(){
	            	$(this).attr("checked",false);
	            });
	        	$(".fold-click").each(function(){
	        		$(this).find(".selectChecked").attr("checked",false);
	        		$(this).removeClass('active').closest('table').nextAll().children().slideUp();
	        	}); 
	        	$(this).find(".selectChecked").attr("checked",true);
	        	if(siteType=='2'){
	        		//layer.msg("该网点为合作型网点！");
	        		return;
	        	}
	        	$.ajax({
	        		type:"post",
	        		url:"${ctx}/secondOrder/getEmployeBuSiteId",
	        		data:{siteId:$(this).find(".siteNameClick").attr("sId"),category:$("#searchCategory").val()},
	        		dataType:"json",
	        		success:function(data){
	        			var html = "";
	        			if(data.length > 0){
	        				for(var i=0;i<data.length;i++){
	        					html += '<tr class="thisEmpchecked" style="cursor:pointer;">'+
			                                '<td width="350px" style="color:#6c6c6c;">'+data[i].columns.name+'</td>'+
			                                '<td width="200px" class="text-c "><input mark="2" ename="'+data[i].columns.name+'" sid="'+$(obj).attr("sId")+'" sname="'+$(obj).text()+'" value="'+data[i].columns.id+'" class="employeChecked" type="checkbox"></td>'+
			                            '</tr>';
	        				}
	        			}else{
	        				layer.msg("此网点无服务工程师");
	        			}
	        			$("#"+str).empty().append(html);
	        			changeCheckBox();
	        			treeAdjust();
	        			$(obj).addClass('active').closest('table').nextAll().children().slideDown();
	        		}
	        	})
	        }
	    });
	}
	
	function treeAdjust(){
		 // 给每一层级的最后一行添加last-child类，兼容ie8左侧线条
	    $(".tree-table .tr-level-1 .tr-level-2:last-child,.tree-table .tr-level-2 .tr-level-3:last-child,.tree-table .tr-level-3 .tr-level-4:last-child,.tree-table .tr-level-4 .tr-level-5:last-child").addClass('last-child');
	}
	
	function changeCheckBox(){
		/* $(".thischecked").off('click');
		$(".thischecked").on('click',function(){
			$(".employeChecked").each(function(){
				$(this).attr("checked",false);
			})
			$(".selectChecked").each(function(){
				$(this).attr("checked",false);
			})
			if($(this).find(".selectChecked").attr("checked")){
				$(this).find(".selectChecked").attr("checked",false);
			}else{
				$(this).find(".selectChecked").attr("checked",true);
			}
			$("#dispatchPeople").text($(this).find(".selectChecked").attr("sname"));
		})
		$(".selectChecked").off('click');
		$(".selectChecked").on('click',function(){
			$(".employeChecked").each(function(){
				$(this).attr("checked",false);
			})
			$(".selectChecked").each(function(){
				$(this).attr("checked",false);
			})
			if($(this).attr("checked")){
				$(this).attr("checked",false);
			}else{
				$(this).attr("checked",true);
			}
			$("#dispatchPeople").text($(this).attr("sname"));
		}) */
		$(".employeChecked").off('click');
		$(".employeChecked").on('click',function(){
			if($(this).attr("checked")){
				$(this).attr("checked",false);
				$(this).parent("td").parent("tr").removeClass("backcolor-defined1");
			}else{
				$(this).attr("checked",true);
				$(this).parent("td").parent("tr").addClass("backcolor-defined1");
			}
			var selectEmployes = "";
			$(".employeChecked").each(function(){
				if($(this).attr('checked')){
					if(isBlank(selectEmployes)){
						selectEmployes = $(this).attr("ename");
					}else{
						selectEmployes +="、"+ $(this).attr("ename");
					}
				}
			})
			if(isBlank(selectEmployes)){
				$("#dispatchPeople").text('');
			}else{
				$("#dispatchPeople").text($(this).attr("sname")+"-"+selectEmployes);
			}
		})
		$(".thisEmpchecked").off('click');
		$(".thisEmpchecked").on('click',function(){
			if($(this).find(".employeChecked").attr("checked")){
				$(this).find(".employeChecked").attr("checked",false);
				$(this).removeClass("backcolor-defined1");
			}else{
				$(this).find(".employeChecked").attr("checked",true);
				$(this).addClass("backcolor-defined1");
			}
			
			var selectEmployes = "";
			$(".employeChecked").each(function(){
				if($(this).attr('checked')){
					if(isBlank(selectEmployes)){
						selectEmployes = $(this).attr("ename");
					}else{
						selectEmployes +="、"+ $(this).attr("ename");
					}
				}
			})
			if(isBlank(selectEmployes)){
				$("#dispatchPeople").text('');
			}else{
				$("#dispatchPeople").text($(this).find(".employeChecked").attr("sname")+"-"+selectEmployes);
			}
		})
	}
	
	function isBlank(val){
		if(val==null || $.trim(val)=='' || val==undefined){
			return true;
		}
		return false;
	}
	
	var disPmark=false;
	function dispatchChangeOrderSave(){
		if(disPmark){
			return;
		}
		var zpReson = $("#zpReson").val();
		var siteId = "";
		var siteName = "";
		var mark = "";
		var empIds = "";
		var empNames = "";
		$(".selectChecked").each(function(){
			if($(this).attr("checked")){
				mark = "1";//派工至网点
				siteId = $(this).val();
				siteName = $(this).attr(siteName);
			}
		})
		
		$(".employeChecked").each(function(){
			if($(this).attr('checked')){
				mark = "2";//派工至网点下的服务工程师
				if(isBlank(empIds)){
					empIds = $(this).val();
					empNames = $(this).attr("ename");
				}else{
					empIds += ","+ $(this).val();
					empNames += ","+ $(this).attr("ename");
				}
			}
		})
		if(isBlank(mark)){
			layer.msg("请选择您要派工的网点或者服务工程师！");
			return;
		}
		if(isBlank(zpReson)){
			layer.msg("请填写转派原因！");
			return;
		}
		var postData = {
				siteId:siteId,
				siteName:siteName,
				mark:mark,
				empIds:empIds,
				empNames:empNames,
				orderId :$("#orderId").val(),
				zpReson:zpReson,
				origin:'${origin}'
		};
		disPmark=true;
		$.ajax({
			type:"post",
			data:postData,
			url:"${ctx}/secondOrder/dispatchChangeOrderSave",
			success:function(result){
				if(result=='200'){
					if('${position}'=='2'){
						parent.parent.parent.layer.msg("转派成功！");
						parent.parent.search();
					}else{
						parent.parent.layer.msg("转派成功！");
						parent.search();
					}
					$.closeAllDiv();
				}else if(result=="420"){
					layer.msg("工单信息已过时，请刷新后重试！");
				}else{
					layer.msg("转派失败，请检查！");
				}
				disPmark=false;
				return;
			},
			error:function(e){
				layer.msg("error！");
				disPmark=false;
				return;
			}
		})
	}
</script>
</body>
</html>
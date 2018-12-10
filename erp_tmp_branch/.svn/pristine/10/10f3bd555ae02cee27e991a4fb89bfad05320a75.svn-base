<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix2.js"></script>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> --%>
	<style type="text/css">
		.dropdown-clear-all{
			line-height: 22px
		}
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
</head>
<body>
<!-- 单个转自接 -->
<div class="popupBox zzjBox dange">
	<h2 class="popupHead">
		转自接
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain" style="padding-top: 20px;">
			<div class="lh-22">当前服务工程师：<span class="c-0e8ee7 f-14 pl-5 pr-5" id="employes"><c:if test="${empty emps }">无</c:if><c:if test="${not empty emps }">${emps }</c:if></span></div>
			<div class="cl mt-15" id="stateBoxS">
				<span class="lh-26 f-l">请选择转自接后的工单状态：</span>
				<a class="f-l w-80 selectLabel selectedLabel">
				<input hidden="hidden" name="orderStatus" value="1" />
					待派工<i class="icon-sel"></i>
				</a>
				<a class="f-l ml-5 w-80 selectLabel">
				<input hidden="hidden" name="orderStatus" value="2" />
					服务中<i class="icon-sel"></i>
				</a>
				<a class="f-l ml-5 w-80 selectLabel">
				<input hidden="hidden" name="orderStatus" value="3" />
					待回访<i class="icon-sel"></i>
				</a>
			</div>
			<div style="height: 60px">
				<div  class="pt-15 cl hide" id="engineerNameS">
					<div class="pb-10">
						<span class="f-l lh-26">请选择服务工程师：</span>
						<!-- 多选 -->
						<span class=" dropdown-sin-2" style="width: 298px;">
						<select class="select ml-5 f-l " style="width: 298px;" multiple="true"   id="selectEmployes">
							<c:forEach items="${empList }" var="el">
								<option value="${el.columns.name }" <c:if test="${el.columns.name==emp1 }">selected="selected"</c:if><c:if test="${el.columns.name==emp2 }">selected="selected"</c:if><c:if test="${el.columns.name==emp3 }">selected="selected"</c:if>>${el.columns.name }</option>
							</c:forEach>
						</select>
						</span>
					</div>
					<p class="c-f55025">备注：转自接后的工程师如果发生变化，请在上面重新选择服务工程师</p>
				</div>
			</div>

			<div class="text-c mt-20">
				<a href="javascript:;" onclick="confirmOne()" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
				<a href="javascript:;" onclick="cancel()" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
var id400 = '${id}';
$(function(){
	$("#engineerNameS  .combo").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
	$('.dange').popup();
	selectStateS('stateBoxS','engineerNameS'); // 选择转自接状态

    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });
});

function isBlank(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}

function selectStateS(id1, id2){
	$('#'+id1+' .selectLabel').each(function(index){
		$(this).on('click', function(){
			$('#'+id1+' .selectLabel').removeClass('selectedLabel');
			$(this).addClass('selectedLabel');
			if(index == 0){
				$('#'+id2).hide();
			}else{
				$('#'+id2).show();
			}
		});
	})
}

function cancel(){
	$.closeDiv($('.dange'));
}

var adpoting = false;
function confirmOne(){
	if(adpoting) {
	    return;
    }
	
	var orderStatus = $(".selectedLabel input[name='orderStatus']").val();//工单状态
	var employes = $('#selectEmployes').val();//$('#selectEmployes').combobox('getValues');//多选的服务工程师
	if(orderStatus=="1"){//不需要考虑任何的条件
		adpoting = true;
		$.ajax({
			type:"post",
			url:"${ctx}/order/ChangeSelfOrder/confirmOne",
			data:{id400:id400,employes:null,orderStatus:orderStatus},
			success:function(result){
				if(result=="ok"){
                    window.top.layer.msg("转自接成功!");
                    if (parent.parent === window.top) {
                        parent.search();
                    } else if (parent.parent.parent === window.top) {
                        parent.parent.search();
					}

					$.closeAllDiv();
				}else if(result=="noEmployes"){
					layer.msg("服务工程师不存在，请重新选择!");
				}else if(result=="orderNoExist"){
					layer.msg("工单信息不存在！");
					return;
				}else if(result=="alreadyZzj"){
					layer.msg("已转自接，请刷新！");
					return;
				}else{
					layer.msg("转自接失败，请检查!");
				}
			},
            complete: function() {
                adpoting = false;
            }
		});
	}else{//考虑工程师
		if($.trim(employes)=="" || employes==null){//工程师为空
			layer.msg("请选择服务工程师！");
			return false;
		}else{//工程师不为空
			adpoting = true;
			$.ajax({
				type:"post",
				traditional:true,
				url:"${ctx}/order/ChangeSelfOrder/confirmOne",
				data:{id400:id400,employes:employes,orderStatus:orderStatus},
				success:function(result){
					if(result=="ok"){
                        window.top.layer.msg("转自接成功!");
                        <%--setTimeout(function(){--%>
                            <%--//window.parent.location.reload(true);--%>
                            <%--parent.search();--%>
                            <%--$.closeDiv($(".zzjBox"));--%>
                        <%--},200);--%>
                        <%--//$("iframe", window.top.document).attr("src", '${ctx}/order/ChangeSelfOrder/headerList');--%>
						<%--$('#Hui-article-box',window.top.document).css({'z-index':'9'});--%>
						<%--/* setTimeout(function(){--%>
							<%--window.parent.location.reload(true);--%>
							<%--$.closeDiv($(".dange"));--%>
						<%--},200); */--%>
                        if (parent.parent === window.top) {
                            parent.search();
                        } else if (parent.parent.parent === window.top) {
                            parent.parent.search();
                        }
						$.closeAllDiv();
					}else if(result=="noEmployes"){
						layer.msg("服务工程师不存在，请重新选择!");
					}else if(result=="noEmployes"){
						layer.msg("服务工程师不存在，请重新选择!");
					}else if(result=="orderNoExist"){
						layer.msg("工单信息不存在！");
						return;
					}else if(result=="alreadyZzj"){
						layer.msg("已转自接，请刷新！");
						return;
					}else{
						layer.msg("转自接失败，请检查!");
					}
				},
	            complete: function() {
	                adpoting = false;
	            }
			})
		}
		
	}
}
</script>
	
</body>
</html>
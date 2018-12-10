<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>  --%>
	<style type="text/css">
	.dropdown-clear-all{
		line-height: 22px
	}
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
	</style>
</head>
<body>
<!-- 转自接 -->
<div class="popupBox zzjBox">
	<h2 class="popupHead">
		转自接
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="lh-22">您已选中<strong class="c-0e8ee7 f-14 pl-5 pr-5">${legh }</strong>条工单</div>
			<div class="cl mt-5" id="stateBox">
				<span class="f-l">请选择转自接后的工单状态：</span>
				<a class="f-l ml-5 w-80 selectLabel selectedLabel">
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
				<div  class="pt-15 hide" id="engineerName">
					<div class="pb-10 cl ">
						<span class="f-l lh-26">是否指定工程师：</span>
						<a class="f-l mt-3 mr-10 radiobox radiobox-selected" data-checked="true">是</a>
						<a class="f-l mt-3 mr-10 radiobox " data-checked="false">否</a>
						<!-- 多选 -->
						<span class=" f-l dropdown-sin-2" id="engName" style="width: 221px;">
							<select class="select" style="width:221px" multiple="true" id="engNamelist">
								<c:forEach items="${empList }" var="el">
									<option value="${el.columns.name }">${el.columns.name }</option>
								</c:forEach>
							</select>
						</span>
					</div>
					<p class="c-f55025">备注：转自接后的工程师如果发生变化，请在上面重新选择服务工程师</p>
				</div>
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" onclick="confirmMore()" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
				<a href="javascript:;" onclick="cancel()" class="sfbtn sfbtn-opt w-70">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
var noIsZzj = '${noIsZzj}';/*否的时候是否可以转自接，true表示可以，false表示不可以*/
var mark = '${mark}';//选择的400工单存在一条工单三个工程师为空，则mark返回为“0”
var ids="${ids}";

$(function(){
	$("#engineerName  .combo").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
	selectState('stateBox','engineerName','engName');
	
	selectEng('engineerName','engName');
	$('.zzjBox').popup();
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

function selectState(id1, id2,id3){
	
	$('#'+id1+' .selectLabel').each(function(index){
		$(this).on('click', function(){
			$('#'+id1+' .selectLabel').removeClass('selectedLabel');
			$(this).addClass('selectedLabel');
			if(index == 0){
				$('#'+id2).hide();
			}else{
				$('#'+id2).show();
				$('#'+id2).find('.radiobox').removeClass('radiobox-selected');
				$('#'+id2).find('a[data-checked="true"]').addClass('radiobox-selected');
				$('#'+id3).show();
			}
		});
	})
}

function selectEng(id,id2){
	$('#'+id+' .radiobox').each( function(){
		$(this).on('click', function(){
			$('#'+id+' .radiobox').removeClass('radiobox-selected');
			$(this).addClass('radiobox-selected');
			if($(this).attr('data-checked')=='true'){
				$('#'+id2).show();
			}else{
				$('#'+id2).hide();
			}
		})
	});
}

function cancel(){
	$.closeDiv($('.zzjBox'));
}

var adpoting = false;
function confirmMore(){
	if(adpoting) {
	    return;
    }
	var orderStatus = $(".selectedLabel input[name='orderStatus']").val();//工单状态
	var isEmployes = $(".radiobox-selected").text();//是否指定工程师
	var employes = $('#engNamelist').val();//多选的服务工程师
	if(orderStatus=="1"){//不需要考虑任何的条件
		adpoting = true;
		$.ajax({
			type:"post",
			traditional:true,
			url:"${ctx}/order/ChangeSelfOrder/confirmMore",
			data:{ids:ids,employes:"",orderStatus:orderStatus,isEmployes:""},
			success:function(result){
				if(result=="ok"){
					layer.msg("转自接成功!");
					setTimeout(function(){
						//window.parent.location.reload(true);
						parent.search();
						$.closeDiv($(".zzjBox"));
					},200);
				}else  if(result=="alreadyZzj"){
					layer.msg("已转自接，请刷新！");
					return;
				}else if(result=="numbersRepeat"){
					layer.msg("选择的工单中存在重复的工单编号，请检查后在转");
					return;
				}else{
					layer.msg("转自接失败，请检查!");
				}
			},
            complete: function() {
                adpoting = false;
            }
		})
		
	}else{//考虑工程师
		if(isEmployes=="否"){//如果不指定工程师
			if(mark=="0" || noIsZzj=="false"){
				layer.msg("您选择的工单中服务工程师信息有误，不可转自接！");
				return false;
			}else{//可以转自接
				adpoting = true;
				$.ajax({
					type:"post",
					traditional:true,
					url:"${ctx}/order/ChangeSelfOrder/confirmMore",
					data:{ids:ids,employes:employes,orderStatus:orderStatus,isEmployes:isEmployes},
					success:function(result){
						if(result=="ok"){
							layer.msg("转自接成功!");
							setTimeout(function(){
								parent.search();
								$.closeDiv($(".zzjBox"));
							},200);
						}else if(result=="alreadyZzj"){
							layer.msg("已转自接，请刷新！");
							return;
						}else if(result=="numbersRepeat"){
							layer.msg("选择的工单中存在重复的工单编号，请检查后在转");
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
		}else if(isEmployes=="是"){//如果指定工程师
			if(isBlank(employes)){//工程师为空
				layer.msg("请选择服务工程师！");
				return false;
			}else{//工程师不为空，则执行批量转自接操作
				adpoting = true;
				$.ajax({
					type:"post",
					traditional:true,
					url:"${ctx}/order/ChangeSelfOrder/confirmMore",
					data:{ids:ids,employes:employes,orderStatus:orderStatus,isEmployes:isEmployes},
					success:function(result){
						if(result=="ok"){
							layer.msg("转自接成功!");
							setTimeout(function(){
								parent.search();
								$.closeDiv($(".zzjBox"));
							},200);
						}else if(result=="noEmployes"){
							layer.msg("服务工程师不存在，请重新选择!");
						}else if(result=="alreadyZzj"){
							layer.msg("已转自接，请刷新！");
							return;
						}else if(result=="numbersRepeat"){
							layer.msg("选择的工单中存在重复的工单编号，请检查后在转");
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
}
</script>
	
</body>
</html>
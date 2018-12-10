<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
<title>预警设置</title>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
	<div class="page-orderWait">
		<div class="mt-10 text-c">
			<form id="subForm">
			<table class="table table2" style="table-layout: auto;">
				<tr style="border-right: 0;">
					<td colspan="5" class="titletd" style="border-left: 0;">
						<div class="modelHead text-l mt-10 mb-10">备件预警</div>
					</td>
				</tr>
				<tr>
					<th >预警类型</th>
					<th >预警开始时间</th>
					<th >预警接收人</th>
					<th >预警方式</th>
					<th >操作</th>
				</tr>
				<c:forEach var="alarm" begin="2" items="${alarmList }" varStatus="idx">
					<tr>
						<td>
							<c:if test="${idx.index eq '2' }">库存预警</c:if>
							<c:if test="${idx.index eq '3' }">缺件预警</c:if>
						</td>
						<td>
							<c:if test="${idx.index eq '2' }"><span class="text-l">当备件库存数量低于库存预警数量时</span></c:if>
							<c:if test="${idx.index eq '3' }"><span class="text-l">当备件的库存数量为0时，服务工程师提交配件申请后提示缺件预警</span></c:if>
						</td>
						<td>
							<select class="select w-140 easyui-combobox" multiple="true" multiline="false" labelPosition="top" name="receiver_type@${idx.index}" style="height:25px;">
								<c:forEach var ="roles" items="${roleList }">
								<c:if test="${idx.index eq '2'}">
									<option value="${roles.id }" <c:forEach var ="rec" items="${reciverList3 }"> <c:if test="${rec.id eq  roles.id}"> selected="selected" </c:if> </c:forEach>>${roles.name }</option>
								</c:if>
								</c:forEach>
								
								<c:forEach var ="roles" items="${roleList }">
								<c:if test="${idx.index eq '3'}">
									<option value="${roles.id }" <c:forEach var ="rec" items="${reciverList4 }"> <c:if test="${rec.id eq  roles.id}"> selected="selected" </c:if> </c:forEach> >${roles.name }</option>
								</c:if>
								</c:forEach>
							</select>
						</td>
						<td>
							<label class="label-cbox2 ${fns:strInStrs('1', alarm.columns.notify_type, ",") ? 'label-cbox2-selected' : ''}" >
								<input type="checkbox" value="1" name="notify_type@${idx.index}" 
									${fns:strInStrs('1', alarm.columns.notify_type, ",") ? 'checked="checked"' : ''}
								/> 系统消息
							</label>
						</td>
						<td>
							<div class="switch switch-small va-t" data-on-label="开" data-off-label="关">
							    <input type="checkbox" name="status@${idx.index}" value="1" ${alarm.columns.status eq '1' ? 'checked="checked"' : '' }/>
							</div>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div class="mt-10 text-c">
				<a href="javascript:sub();" id="Butorder" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
			</div>
			</form>
		</div>
	</div>
</div></div>

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
	function sub(){
		var te=/^\d/;
		var str2=$("input[name='receiver_type@2']").val();
		var str3=$("input[name='receiver_type@3']").val();

		if($("input[name='status@2']").parent("div").hasClass('switch-on')){
            if(isBlank(str2)){
                layer.msg("请选择库存预警接收人！");
                return;
            }
		}
		if($("input[name='status@3']").parent("div").hasClass('switch-on')){
            if(isBlank(str3)){
                layer.msg("请选择缺件预警接收人！");
                return;
            }
		}

		var json = $("#subForm").serializeJson();
		$.post("${ctx}/operate/site/saveAlarm", json, function(result){
			layer.msg("保存成功!");
		});
	}

	$(function() {
		$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
			if(result=="showPopup"){
				
				$(".vipPromptBox").popup();
				$('#Hui-article-box',window.top.document).css({'z-index':'9'});
			}
		});
		$('input[type="checkbox"]').on('click', function() {
			if ($(this).is(":checked")) {
				$(this).parent('label').addClass(' label-cbox2-selected');
			} else {
				$(this).parent('label').removeClass(' label-cbox2-selected');
			}
		});
	});
	
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style>

	/* WebKit browsers */
	input::-webkit-input-placeholder {
		color: #777;
	}
	/* Mozilla Firefox 4 to 18 */
	input:-moz-placeholder {
		color: #777;
		opacity: 1;
	}
	/* Mozilla Firefox 19+ */
	input::-moz-placeholder {
		color: #777;
		opacity: 1;
	}
	/* Internet Explorer 10+ */
	input:-ms-input-placeholder {
		color: #777;
	}
</style>

<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>

<body>


<!-- 待派工工单下和服务中工单下 -->
<div class="popupBox msgText msgText1" style="height:470px;">
	<h2 class="popupHead">
		发送短信
		<a href="javascript:;" class="sficon closePopup" ></a>
	</h2>
	<div class="popupContainer" style="height:430px;overflow:auto;">
		<div class="popupMain pd-20" id="msgWrap" >
			<div class="tabBarP ">
				<a href="javascript:;" class="tabswitch current">模板发送</a>
				<a href="javascript:;" class="tabswitch ">编辑发送</a>
			</div>
			<div class="tabCon">
				<div class="pos-r pl-70 pr-80 mt-10">
					<label class="lb w-70 text-r">选择模板：</label>
					<span class="select-box w-160">
					<input type="hidden" class="input-text w-140" id="sign"   value=""/> 
					<input type="hidden" class="input-text w-140"  id="siteMsgNums" value=""/> 
						<select class="select radius h-26" id="select-msgmode" name="selectModel" onchange="selectMsgMould(this)">
							<c:forEach items="${listModel }" var="lm6">
								<c:if test="${lm6.columns.tag eq 6 }">
									<option value="${lm6.columns.tag }">上门前</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm7">
								<c:if test="${lm7.columns.tag eq 7 }">
									<option value="${lm7.columns.tag }">增值产品</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm4">
								<c:if test="${lm4.columns.tag eq 4 }">
									<option value="${lm4.columns.tag }">电话无人接听</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm4">
								<c:if test="${lm4.columns.tag eq 9 }">
									<option value="${lm4.columns.tag }">配件无人接听</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm3">
								<c:if test="${lm3.columns.tag eq 3 }">
									<option value="${lm3.columns.tag }">改约</option>
								</c:if>
							</c:forEach>
							<c:forEach items="${listModel }" var="lm2">
								<c:if test="${lm2.columns.tag eq 2 }">
									<option value="${lm2.columns.tag }">缺件</option>
								</c:if>
							</c:forEach>
						</select>
					</span>
				</div>
				<div class="msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务
							<input type="text" class="msg-input" id="siteName" value="${siteName }"  onkeyup="inputWidth(this)"/>已受理，
							<input type="text" class="msg-input" id="emNameMobile" value="${msg1 }" onkeyup="inputWidth(this)"/>，
							将为您提供服务，请保持电话通畅，监督电话：
							<input type="text" class="msg-input" id="jdMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign1" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel1">
							
						</div>
					</div>
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
						<div class="bk-gray pd-10">
							尊敬的用户：您的信息<input type="text" class="msg-input" id="custNameMobile" value="${siteName }(${jdPhone }) " onkeyup="inputWidth(this)"/>
							已经派工，服务工程师<input type="text" class="msg-input" id="emName" value="${msg2Names }" onkeyup="inputWidth(this)"/>，
							联系电话<input type="text" class="msg-input" id="emMobile" value="${msg2Mobiles }" onkeyup="inputWidth(this)"/>，
							请您对我们的服务进行监督！
							【<input type="text" class="msg-input" value="${serviceName }" id="sign2" onkeyup="inputWidth(this)"/>服务】
						</div>
						<div id="sendModel2">	</div>
					</div>
				</div>
				
				<div class="msgmould hide">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
						<div class="bk-gray pd-10">
							尊敬的<input type="text" class="msg-input" id="custName" value="${order.customerName }" onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }" onkeyup="inputWidth(this)"/>业务，我司已受理，
							指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
							<input type="text" class="msg-input" id="mode1" value="注意用电安全请点击${oneHref }">，详情咨询上门工程师。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign10" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel7">
							
						</div>
					</div>
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
						<div class="bk-gray pd-10">
							尊敬的<input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
							指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
							<input type="text" class="msg-input" id="mode2" value="另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命">，详情咨询上门工程师。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign11" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel8">	</div>
					</div>
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板三）</span></span>
						<div class="bk-gray pd-10">
							尊敬的<input type="text" class="msg-input" id="custName" value="${order.customerName }" onkeyup="inputWidth(this)" />您好，
							您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
							指派<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
							<input type="text" class="msg-input" id="mode3" value="另有安全用电家电伴侣产品等为您提供试用，使您拥有最安心的家电使用体验，">
							<input type="text" class="msg-input" id="mode4" value="洗衣机专用自动止水水龙头和洗衣机底座，可有效防止水淹事故导致财产损失，延长家电安全使用寿命">，详情咨询上门工程师。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign12" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel9">	</div>
					</div>
				</div>
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							尊敬的用户，您的电话无法接通状态，请您在方便的时候回复
							<input type="text" class="msg-input" id="siteMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>
							或服务工程师电话<input type="text" class="msg-input" value="${msg1 }" onkeyup="inputWidth(this)"/>,
							我们将尽快为您提供满意的服务！
							【<input type="text" class="msg-input" value="${serviceName }" id="sign3" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel3">	</div>
					</div>
				</div>
					<!-- 配件无人接听 -->
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							你好，你购买的商品
							<input type="text" class="msg-input" id="goodsTime" value="今天" onkeyup="inputWidth(this)"/>到
							<input type="text" class="msg-input" value="${siteArea }" id="pjArea" onkeyup="inputWidth(this)"/>,联系你电话无人接听，看到短信后请联系
							<input type="text" class="msg-input" value="${siteMobile }" id="pjMobile" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign20" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel20">	</div>
					</div>
				</div>
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
							您的预约时间已改至<input type="text" class="msg-input" id="proTime" value="${proTime } "  onkeyup="inputWidth(this)"/>，
							<input type="text" class="msg-input" id="promiseLimit" value="${order.promiseLimit }" onkeyup="inputWidth(this)"/>，
							具体上门时间，<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
							会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign4" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel4">	</div>
					</div>
				</div>
				<div class="hide msgmould">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
							因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
							<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
							会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign5" onkeyup="inputWidth(this)"/>服务】
						</div>	
						<div id="sendModel5">	</div>
					</div>
				</div>
			</div>
			<div class="tabCon">
				<p class="c-f55025 f-12 lh-30">
					注：自定义文字内容需要人工审核，等待时间较长
				</p>
				<div class="pr-80 pos-r">
					<div class="bk-gray" >
						<textarea class="textarea radius" placeholder="请输入短信内容" id="content" style="border-width: 0; height: 60px;"></textarea>
						<div class="h-26">
							<p class="f-r">【<input type="text" class="msg-input"  value="${serviceName }" id="sign6" onkeyup="inputWidth(this)"/>服务】</p>
						</div>
					</div>
					<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="sendMsgConfirm()">发送</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="popupBox msgText msgTextQuren" >
	<h2 class="popupHead">
		短信确认
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-20" >
			<div class="lh-26">
				<div>您确定给<span id="peoples" style="color: #999;" class="f-14"></span>发送</div>
				<div style="min-height:100px; text-indent:2em;color: #999;" id="sendContent" ></div> 
			</div>
			<div class="text-c mt-25 " id="clickSend">
				
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="customerMobile" value="${order.customerMobile }"/>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
var definedContentCd="";
var definedContentTz="";
var limitCount=0;
var mark="";
var orderMsgId="";
var orderMsgMobile="";
var isCheck="";
var customerPrice="";
$(function(){
	var content1="@您好，您的@业务@已受理，@，将为您提供服务，请保持电话通畅，监督电话：@。【@服务】";
	var content2="尊敬的用户：您的信息@已经派工，服务工程师@，联系电话@，请您对我们的服务进行监督！【@服务】";
	$("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("2","6","'+content1+'") >发送</a>');
	$("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("3","6","'+content2+'") >发送</a>');
	if($.trim('${order.customerMobile}')!=null && $.trim('${order.customerMobile}')!="" ){
		orderMsgMobile=$.trim('${order.customerMobile}');
	}
	orderMsgId='${order.id}';
	
	$.post("${ctx}/order/remainMsgNum",{},function(result){
		$("#sign").val(result.columns.sms_sign);//签名
		$("#siteMsgNums").val(result.columns.sms_available_amount);//服务商剩余可发送短信总数
	});


    $('#bjNavBox .tabswitch').each(function(i){
    	$(this).on('click', function(){
    		 $('#bjNavBox .tabswitch').removeClass('current');
    		 $(this).addClass('current');
    		 $('#bjNavBox2 .caption_lb').hide().eq(i).show();
    		 $('#bjNavBox2 .sfbtn').hide().eq(i).show();
        });
    });
    
});


function closeAll(){
	$.closeAllDiv();
}

</script>

<script type="text/javascript">
var ck = /^\d+(\.\d+)?$/;
	$(function(){
		$('.msgText1').popup({fixedHeight:false});
		$.Huitab("#msgWrap .tabBarP .tabswitch","#msgWrap .tabCon","current","click","0");
		$("input.sfbtn.sfbtn-opt3").click(function(){
			$(".lb.lb1").removeClass("readonly");
		});
		
		$(".closePopup").click(function(){
			closeAll();
		});
		
	});



		function isBlank(val) {
			if(val==null || val=='' || val == undefined) {
				return true;
					}
			return false;
		}
	

	function getoff(){
		window.location.reload();
	}
	


	// 下拉框切换模板
	function selectMsgMould(obj){
		var tag;
		var aDiv = $('.msgText1 .msgmould');
		var index = obj.selectedIndex;
		var tag = $('#select-msgmode option:selected') .val();
		$.ajax({
			type:"POST",
			url:"${ctx }/order/getTag",
			data:{tag:tag},
			success:function(result){
				if(tag==6){
						if(result[0].columns.id==2){
							$("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
						}else{
							$("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" >发送</a>');
						}
						if(result[1].columns.id="2"){
							$("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" >发送</a>');
						}else{
							$("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
						}
				}else if(tag==4){
					$("#sendModel3").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==3){
					$("#sendModel4").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==2){
					$("#sendModel5").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==7){
					//$("#mode1").text('另有安全用电家电伴侣产品等为您提供试用');
					//$("#mode2").text('另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命');
					$("#sendModel7").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',1)" >发送</a>');
					$("#sendModel8").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',2)" >发送</a>');
					$("#sendModel9").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',0)" >发送</a>');
				}else if(tag==9){
					$("#sendModel20").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
				}else if(tag==11){
					
				}
			}
		});
		aDiv.hide().eq(index).show();
	}
	
	var afl = false;
	function sendModel1(id,tag,content,mode){
		$("#clickSend").empty();
		if(afl) {
		    return;
	    }
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var custName = $("#custName").val();
		var mode1 = $("#mode1").val();
		var mode2 = $("#mode2").val();
		var mode3 = $("#mode3").val();
		var mode4 = $("#mode4").val();
		var yw = $("#yw").val();
		var siteName = $("#siteName").val();
		var jdMobile = $("#jdMobile").val();
		var goodsTime = $("#goodsTime").val();
		var pjArea = $("#pjArea").val();
		var pjMobile = $("#pjMobile").val();
		var emName = $("#emName").val();//工程师集合
		var emMobile = $("#emMobile").val();//电话集合
		var proTime = $("#proTime").val();
		var promiseLimit = $("#promiseLimit").val();
		var siteMobile = $("#siteMobile").val();
		var custNameMobile = $("#custNameMobile").val();
		var customerMobile = $("#customerMobile").val();//用户联系方式
		var sign = $("#sign").val();
		if($.trim(emName)=="" || emName==null){
			layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
			return ;
		}
		var emNameMobile = $("#emNameMobile").val();//工程师、加电话集合
		// 查询出"@"的所有位置
        var path_1 = content.indexOf("@");// 第一个位置
        var path_2 = path_1 + content.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
        var path_3 = path_2 + content.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
        var path_4 = path_3 + content.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
        var path_5 = path_4 + content.substring(path_4 + 1).indexOf("@") + 1;// 第四个位置
        var path_6 = path_5 + content.substring(path_5 + 1).indexOf("@") + 1;// 第四个位置
        var s_temp;
		if(id==2){//模板一
			if($.trim($("#sign1").val())=="" || $("#sign1").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign1").focus();
				return;
			}
			if($.trim($("#sign1").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign1").focus();
				return;
			}
			sign=$.trim($("#sign1").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + yw
            + content.substring(path_2 + 1, path_3) + siteName
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
            + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_6 + 1);
			
		}else if(id==3){//模板二
			if($.trim($("#sign2").val())=="" || $("#sign2").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign2").focus();
				return;
			}
			if($.trim($("#sign2").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign2").focus();
				return;
			}
			sign=$.trim($("#sign2").val());
			s_temp = content.substring(0, path_1) + custNameMobile 
            + content.substring(path_1 + 1, path_2) + emName
            + content.substring(path_2 + 1, path_3) + emMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
			
		}else if(id==4){//无法接通
			if($.trim($("#sign3").val())=="" || $("#sign3").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign3").focus();
				return;
			}
			if($.trim($("#sign3").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign3").focus();
				return;
			}
			sign=$.trim($("#sign3").val());
			s_temp = content.substring(0, path_1) + siteMobile
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + sign
            + content.substring(path_3 + 1);
			
		}else if(id==12){//配件无法接通
			/* if(mark=="no"){
			layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
			return;
		} */
		if($.trim(pjMobile)=="" || pjMobile==null){
			layer.msg("联系电话不能为空！");
			$("#pjMobile").focus();
			return;
		}
		if($.trim($("#sign20").val())=="" || $("#sign20").val()==null){
			layer.msg("短信签名不能为空！");
			$("#sign20").focus();
			return;
		}
		if($.trim($("#sign20").val()).length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			$("#sign20").focus();
			return;
		}
		sign=$.trim($("#sign20").val());
		s_temp = content.substring(0, path_1) + goodsTime
        + content.substring(path_1 + 1, path_2) + pjArea
        + content.substring(path_2 + 1, path_3) + pjMobile
        + content.substring(path_3 + 1, path_4) + sign
        + content.substring(path_4 + 1);
	}else if(id==5){//改约
			if($.trim($("#sign4").val())=="" || $("#sign4").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign4").focus();
				return;
			}
			if($.trim($("#sign4").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign4").focus();
				return;
			}
			sign=$.trim($("#sign4").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + proTime
            + content.substring(path_2 + 1, path_3) + promiseLimit
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
            + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_6 + 1);
		}else if(id==6){//缺件
			if($.trim($("#sign5").val())=="" || $("#sign5").val()==null){
				layer.msg("短信签名不能为空！");
				$("#sign5").focus();
				return;
			}
			if($.trim($("#sign5").val()).length>6){
				layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
				$("#sign5").focus();
				return;
			}
			sign=$.trim($("#sign5").val());
			s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + jdMobile
            + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_4 + 1);
		}else if(id==9){
			if(mode=="1"){
				if($.trim($("#sign10").val())=="" || $("#sign10").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign10").focus();
					return;
				}
				if($.trim($("#sign10").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign10").focus();
					return;
				}
				sign=$.trim($("#sign10").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode1
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}else if(mode=="2"){
				if($.trim($("#sign11").val())=="" || $("#sign11").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign11").focus();
					return;
				}
				if($.trim($("#sign11").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign11").focus();
					return;
				}
				sign=$.trim($("#sign11").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile
	            + content.substring(path_3 + 1, path_4) + mode2
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}else{
				if($.trim($("#sign12").val())=="" || $("#sign12").val()==null){
					layer.msg("短信签名不能为空！");
					$("#sign12").focus();
					return;
				}
				if($.trim($("#sign12").val()).length>6){
					layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
					$("#sign12").focus();
					return;
				}
				sign=$.trim($("#sign12").val());
				s_temp = content.substring(0, path_1) + custName
	            + content.substring(path_1 + 1, path_2) + yw
	            + content.substring(path_2 + 1, path_3) + emNameMobile 
	            + content.substring(path_3 + 1, path_4) + mode3+mode4
	            + content.substring(path_4 + 1, path_5) + sign
	            + content.substring(path_5 + 1);
			}
		}
		if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
			afl = true;
			$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
				type:"POST",
				//traditional:true,
				url:"${ctx }/order/msgNumbers", 
				data:{content:s_temp,
					sign:sign},
				success:function(result){
					if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					}else{
						$("#peoples").html('${order.customerName}');
						$("#sendContent").text("“"+s_temp+"”？");
						$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
								'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
						$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
					}
				},
	            complete: function() {
	                afl = false;
	            }
			})
		}else if($.trim(customerMobile)==""){
			layer.msg("请填写用户的手机号码！");
		}else{
			layer.msg("用户的手机号码格式不正确，请重新填写！");
		}
	}
	
	var aflModel=false;
	function sendConfirmMsgModel(id,sign,s_temp,tag,orderMsgId,customerMobile){
		if(aflModel) {
		    return;
	    }
		aflModel=true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsgModel",
			data:{temId:id,
				sign:sign,
				content:s_temp,
				extno:tag,
				orderId:orderMsgId,
				customerMobile:customerMobile
				},
			success:function(result){
				if(result=="ok"){
					window.top.layer.msg("发送成功!");
//					$.closeDiv($(".msgText1"));
//					window.location.reload();
					$.closeAllDiv();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				}else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
            complete: function() {
            	aflModel = false;
            }
		})
	}
	
	function inputWidth(obj){
		var textValue = obj.value,
			textLength = textValue.length,
			charCode = -1;
		var charLen = textValue.replace(/[^\x00-\xff]/g,"**").length;

		var minWidth = charLen*7 >10?charLen*7 : 10;
		minWidth = minWidth>448?448:minWidth;
		$(obj).css({'width':minWidth + 'px'});
	}
	
	var afs1= false;
	function sendMsgConfirm(){
		$("#clickSend").empty();
		if(afs1) {
		    return;
	    }
		afs1 = true;
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var sign = $("#sign").val();
		var customerMobile = $("#customerMobile").val();//用户联系方式
		if($.trim($("#sign6").val())=="" || $("#sign").val()==null){
			layer.msg("短信签名不能为空！");
			$("#sign6").focus();
			return;
		}
		if($.trim($("#sign6").val()).length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			$("#sign6").focus();
			return;
		}
		sign=$.trim($("#sign6").val());
		var content = $.trim($("#content").val());
		if(content=="" ){
			layer.msg("自定义发送短信内容不能为空");
			$("#content").focus();
			return;
		}
		if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
			//自定义模板
			
			$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
				type:"POST",
				url:"${ctx }/order/msgNumbers",
				data:{content:content,
					sign:sign},
				success:function(result){
					if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					}else{
						$("#peoples").html('${order.customerName}');
						$("#sendContent").text("“"+$("#content").val()+"”？");
						definedContentTz=content;
						$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsg(\''+sign+'\',\''+orderMsgMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
								'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
						$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
					}
				},
				complete: function() {
					afs1 = false;
				}
			});
		}else if($.trim(customerMobile)==""){
			layer.msg("请填写用户的手机号码！");
		}else{
			layer.msg("用户的手机号码格式不正确，请重新填写！");
		} 
	}
	
	var afs= false;
	function sendMsg(sign,orderMsgMobile,orderMsgId){
		if(afs) {
		    return;
	    }
		afs = true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsg",
			data:{content:definedContentTz,
				sign:sign,
				orderMsgMobile:orderMsgMobile,
				orderMsgId:orderMsgId
			},
			success:function(result){
				if(result=="ok"){
					window.top.layer.msg("发送成功!");
					$.closeAllDiv();
//					window.location.reload();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				}else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
			complete: function() {
				afs = false;
			}
		});
				
	}
	var afe = false;
	function sendMsgDXCD(type){
		$("#clickSend").empty();
		if(afe) {
		    return;
	    }
		var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
		var sign = $("#sign").val();
		if(sign.length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			return;
		}
		var customerMobile = $("#customerMobile").val();//用户联系方式
		var empMobiles = "${empMobile}".split(",");
		var contentRecord="";
		for(var i=0;i<empMobiles.length;i++){
			var empMobile = empMobiles[i];
			if($.trim(empMobile).length==11 && $.trim(empMobile).substring(0,1)=="1"){
			}else{
				layer.msg("工程师的手机号码信息有误，请确认后重新发送！");
				return;
			}
		}
		if($.trim(sign)=="" || sign==null){
			layer.msg("短信签名不能为空");
			$("#dxcdSn").focus();
			return;
		}
		if(sign.length>6){
			layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
			$("#dxcdSn").focus();
			return;
		}
		//自定义模板
		if(type=='1'){//固定模板
			afe = true;
			var danhao = "${order.number}";
			var pailei = "${order.applianceBrand}"+"${order.applianceCategory}";
			var useP = "${order.customerName}";
			var mobile = "${order.customerMobile}";
			var addreU = "${order.customerAddress}";
			$.ajax({
				type:"POST",
				url:"${ctx }/order/getTag",
				data:{tag:'11'},
				async:false,
				success:function(result){
					contentRecord = result[0].columns.content;
				},
	            complete: function() {
	                afe = false;
	            }
			});
			// 查询出"@"的所有位置
	        var path_1 = contentRecord.indexOf("@");// 第一个位置
	        var path_2 = path_1 + contentRecord.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
	        var path_3 = path_2 + contentRecord.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
	        var path_4 = path_3 + contentRecord.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
			var content = contentRecord.substring(0, path_1) + danhao+"("+pailei+")"
            + contentRecord.substring(path_1 + 1, path_2) + useP+"("+mobile+")"
            + contentRecord.substring(path_2 + 1,path_3) + addreU 
            + contentRecord.substring(path_3 + 1,path_4) + sign+ contentRecord.substring(path_4+1);
		}else if(type=='2'){//自定义模板
			var content = $.trim($("#content2").val());
			if(content=="" ){
				layer.msg("自定义发送短信内容不能为空");
				$("#content2").focus();
				return;
			}
			sign=$.trim($("#dxcdSn").val());
		}
		afe = true;
		$.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
			type:"POST",
			url:"${ctx }/order/msgNumbers",
			data:{content:content,
				sign:sign},
				async:false,
			success:function(result){
				if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				}else{
						 if(type=='1'){//模板
							$("#peoples").html('${order.employeName}');
							$("#sendContent").text("“"+content+"”？");
							$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsgEmpModel(\''+sign+'\',\''+content+'\',\''+orderMsgId+'\',\''+empMobiles+'\')" >确定</a>&nbsp;&nbsp;'+
									'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
							$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
						}else if(type=='2'){//自定义
							definedContentCd=content;
							$("#peoples").html('${order.employeName}');
							$("#sendContent").text("“"+content+"”？");
							$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsgEmp(\''+sign+'\',\''+empMobiles+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
									'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
							$(".msgTextQuren").popup({level:5,closeSelfOnly:true});
						}
				}
			},
            complete: function() {
                afe = false;
            }

		})
		
	}
	
	
	function cancelQueren(){
		$.closeDiv($(".msgTextQuren"),true);
	}
	
	var empModels=false;
	function sendMsgEmpModel(sign,content,orderMsgId,empMobiles){
		if(empModels){
			return;
		}
		empModels=true;
		 $.ajax({
				type:"POST",
				url:"${ctx }/order/fwzSendmsgModel",
				async:false,
				data:{
					temId:'8',
					sign:sign,
					content:content,
					extno:'11',//
					orderId:orderMsgId,
					customerMobile:empMobiles
					},
				success:function(result){
					if(result=="ok"){
						layer.msg("发送成功!");
						$.closeDiv($(".msgText2"));
						window.location.reload();
					}else if(result=="noMessage"){
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
						return;
					} else{
						layer.msg("发送失败，请稍后重试!");
					}
				},
	            complete: function() {
	            	empModels = false;
	            }
			}) 
	}
	
	var empNoModels=false;
	function sendMsgEmp(sign,empMobiles,orderMsgId){
		if(empNoModels){
			return;
		}
		empNoModels=true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsg",
			async:false,
			data:{
				content:definedContentCd+"【"+sign+"服务】",
				sign:sign,
				orderMsgMobile:empMobiles,//工程师号码
				orderMsgId:orderMsgId
				},
			success:function(result){
				if(result=="ok"){
					layer.msg("发送成功!");
					$.closeDiv($(".msgText2"));
					window.location.reload();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				} else{
					layer.msg("发送失败，请稍后重试!");
				}
			},
            complete: function() {
            	empNoModels = false;
            }
		}) 
	}

</script> 
</body>
</html>
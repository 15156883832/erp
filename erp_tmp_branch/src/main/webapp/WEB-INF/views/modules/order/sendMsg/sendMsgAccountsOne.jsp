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
	.sfbtn-gray {
	    color: #fff;
	    background: #bebebe;
    }

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

<!-- 短信群发 -->
<div class="popupBox msgText msgText1" style="height:460px;">
	<h2 class="popupHead">
		群发短信
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer" style="height:420px;overflow:auto;">
		<div class="popupMain pd-20" id="msgWrap" >
			<div class="tabBarP ">
				<a href="javascript:;" class="tabswitch current">模板发送</a>
				<a href="javascript:;" class="tabswitch ">编辑发送</a>
			</div>
			<div class="tabCon">
				<div class="pos-r pl-70 mt-10">
					<label class="lb w-70 text-r">选择模板：</label>
					<span class="select-box w-160">
						<select class="select radius h-26" id="select-msgmodedef" name="selectModel" onchange="selectMsgMould(this)">
							<!-- <option value="zzdx">增值产品</option> -->
							<c:if test="${type=='1' }">
								<c:forEach items="${listModel }" var="lm6">
								<c:if test="${lm6.columns.tag eq 6 }">
									<option value="${lm6.columns.tag }" reds="1">上门前</option>
								</c:if>
								</c:forEach>
								<c:forEach items="${listModel }" var="lm7">
									<c:if test="${lm7.columns.tag eq 7 }">
										<option value="${lm7.columns.tag }" reds="1">增值产品</option>
									</c:if>
								</c:forEach>
								<c:forEach items="${listModel }" var="lm4">
									<c:if test="${lm4.columns.tag eq 4 }">
										<option value="${lm4.columns.tag }" reds="1">电话无人接听</option>
									</c:if>
								</c:forEach>
								<c:forEach items="${listModel }" var="lm4">
									<c:if test="${lm4.columns.tag eq 9 }">
										<option value="${lm4.columns.tag }" reds="1">配件无人接听</option>
									</c:if>
								</c:forEach>
								<c:forEach items="${listModel }" var="lm3">
									<c:if test="${lm3.columns.tag eq 3 }">
										<option value="${lm3.columns.tag }" reds="1">改约</option>
									</c:if>
								</c:forEach>
								<c:forEach items="${listModel }" var="lm2">
									<c:if test="${lm2.columns.tag eq 2 }">
										<option value="${lm2.columns.tag }" reds="1">缺件</option>
									</c:if>
								</c:forEach>
								<c:if test="${target=='1' }">
									<c:forEach items="${listModel }" var="lm2">
										<c:if test="${lm2.columns.tag eq 5 }">
											<option value="${lm2.columns.tag }" reds="1">回访</option>
										</c:if>
									</c:forEach>
								</c:if>
							</c:if>

							<c:if test="${type=='3' }">
								<c:forEach items="${listModel }" var="lm2">
									<c:if test="${lm2.columns.tag eq 5 }">
										<option value="${lm2.columns.tag }" reds="1">回访</option>
									</c:if>
								</c:forEach>
							</c:if>
							
							<c:if test="${type=='2' }">
								<c:forEach items="${listModel }" var="lm">
									<c:if test="${lm.columns.tag eq 8 }">
										<option value="${lm.columns.tag }" reds="1">待派工</option>
									</c:if>
								</c:forEach>
								<c:forEach items="${listModel }" var="lm">
									<c:if test="${lm.columns.tag eq 9 }">
										<option value="${lm.columns.tag }" reds="1">配件无人接听</option>
									</c:if>
								</c:forEach>
							</c:if>
							<c:forEach items="${definedmodel}" var="def">
								<option value="${def.columns.id }" reds="2">${def.columns.name }(自定义)</option>
							</c:forEach>
						</select>
					</span>
				</div>
					<div id="smq" class=" sysModel" <c:if test="${type!='1' }">hidden="hihdden"</c:if> >
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
									【<span  id="sign1" >${serviceName }</span>】
									
								</div>
								<div id="sendModel1"></div>
							</div>
						</div>
						
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
								<div class="bk-gray pd-10">
									尊敬的用户：您的信息<input type="text" class="msg-input" id="custNameMobile" value="${siteName }(${jdPhone }) " onkeyup="inputWidth(this)"/>
									已经派工，服务工程师<input type="text" class="msg-input" id="emName" value="${msg2Names }" onkeyup="inputWidth(this)"/>，
									联系电话<input type="text" class="msg-input" id="emMobile" value="${msg2Mobiles }" onkeyup="inputWidth(this)"/>，
									请您对我们的服务进行监督！
									【<span  id="sign2" >${serviceName }</span>】
								</div>
								<div id="sendModel2"></div>
							</div>
						</div>
						
					</div>
					<div id="dpg" class=" sysModel" <c:if test="${type!='2' }">hidden="hihdden"</c:if> >
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
								<div class="bk-gray pd-10">
									<input type="text" class="msg-input" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
									您的<input type="text" class="msg-input"  value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务
									<input type="text" class="msg-input"  value="${siteName }" i onkeyup="inputWidth(this)"/>已受理，
									请保持电话通畅，监督电话：
									<input type="text" class="msg-input"  value="${jdPhone }" onkeyup="inputWidth(this)"/>。
									【<span  id="signD1" >${serviceName }</span>】
								</div>	
								<div id="sendModelD1">
									
								</div>
							</div>
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
								<div class="bk-gray pd-10">
									尊敬的用户，您的电话无法接通，请您在方便的时候回复
									<input type="text" class="msg-input"  value="${jdPhone }" onkeyup="inputWidth(this)"/>， 我们将尽快为您提供
									<input type="text" class="msg-input"  value="${order.serviceType }"  onkeyup="inputWidth(this)"/>服务！
									【<span  id="signD2" >${serviceName }</span>】
								</div>
								<div id="sendModelD2">	</div>
							</div>
						</div>
					</div>
					<div id="zzcp" hidden="hidden" class="sysModel">
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
								<div class="bk-gray pd-10">
									尊敬的<input type="text"  class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
									您的<input type="text"  class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
									指派<input type="text"  class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
									<input type="text"  class="msg-input" id="mode1" value="注意用电安全请点击${oneHref }" >，详情咨询上门工程师。
									【<span  id="sign10" >${serviceName }</span>】
								</div>
								<div id="sendModel3"></div>
							</div>
						</div>
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
								<div class="bk-gray pd-10">
									尊敬的<input type="text" class="msg-input"  id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
									您的<input type="text" class="msg-input"  id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
									指派<input type="text" class="msg-input"   value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
									<input type="text" class="msg-input"  id="mode2" value="另有专用自动止水水龙头和底座，可有效防止漏水和延长家电使用寿命">，详情咨询上门工程师。
									【<span  id="sign11" >${serviceName }</span>】
								</div>
								<div id="sendModel4"></div>	
							</div>
						</div>
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板三）</span></span>
								<div class="bk-gray pd-10">
									尊敬的<input type="text" class="msg-input"  id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
									您的<input type="text" class="msg-input"  id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务，我司已受理，
									指派<input type="text" class="msg-input"   value="${msg1 }" onkeyup="inputWidth(this)"/>为您服务，
									<input type="text" class="msg-input"  id="mode3" value="另有安全用电家电伴侣产品等为您提供试用，使您拥有最安心的家电使用体验，">
									<input type="text" class="msg-input"  id="mode4" value="洗衣机专用自动止水水龙头和洗衣机底座，可有效防止水淹事故导致财产损失，延长家电安全使用寿命">，详情咨询上门工程师。
									【<span  id="sign12" >${serviceName }</span>】
								</div>	
								<div id="sendModel5"></div>
							</div>
						</div>
					</div>
					<div id="dhwrjd" hidden="hidden" class="sysModel">
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：</span>
								<div class="bk-gray pd-10">
									尊敬的用户，您的电话无法接通状态，请您在方便的时候回复
									<input type="text" class="msg-input"  id="siteMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>
									或服务工程师电话<input type="text" class="msg-input"  value="${msg1 }" onkeyup="inputWidth(this)"/>,
									我们将尽快为您提供满意的服务！
									【<span  id="sign3" >${serviceName }</span>】
								</div>	
								<div id="sendModel6"></div>
							</div>
						</div>
					</div>
					<div id="pjwrjd" hidden="hidden" class="sysModel">
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：</span>
								<div class="bk-gray pd-10">
									你好，你购买的商品
									<input type="text" class="msg-input"  id="goodsTime" value="今天" onkeyup="inputWidth(this)"/>到
									<input type="text" class="msg-input"  value="${siteArea }" id="pjArea" onkeyup="inputWidth(this)"/>,联系你电话无人接听，看到短信后请联系
									<input type="text" class="msg-input"  value="${siteMobile }" id="pjMobile" onkeyup="inputWidth(this)"/>。
									【<span  id="sign20" >${serviceName }</span>】
								</div>	
								<div id="sendModel7"></div>
							</div>
						</div>	
					</div>
					<div id="gyemp" hidden="hidden" class="sysModel">
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：</span>
								<div class="bk-gray pd-10">
									<input type="text" class="msg-input"  value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
									您的预约时间已改至<input type="text"  class="msg-input" id="proTime" value="${proTime } "  onkeyup="inputWidth(this)"/>，
									<input type="text" class="msg-input"  id="promiseLimit" value="${order.promiseLimit }" onkeyup="inputWidth(this)"/>，
									具体上门时间，<input type="text" class="msg-input"  value="${msg1}" onkeyup="inputWidth(this)"/>，
									会与您联系的，监督电话：<input type="text"  class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
									【<span  id="sign4" >${serviceName }</span>】
								</div>	
								<div id="sendModel8"></div>	
							</div>
						</div>
					</div>
					<div id="qjpj" hidden="hidden" class="sysModel">
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：</span>
								<div class="bk-gray pd-10">
									<input type="text" class="msg-input"  value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
									因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
									<input type="text" class="msg-input"  value="${msg1}" onkeyup="inputWidth(this)"/>，
									会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
									【<span  id="sign5" >${serviceName }</span>】
								</div>
								<div id="sendModel9"></div>	
							</div>
						</div>
					</div>
					<div id="hfdx" class=" sysModel" <c:if test="${type!='3' }">hidden="hihdden"</c:if> >
						<div class=" msgmould">
							<div class="pos-r pl-70 pr-80 mt-10">
								<span class="lb w-70 text-c">发送内容：</span>
								<div class="bk-gray pd-10">
									<input type="text" class="msg-input"  value="${order.customerName }" onkeyup="inputWidth(this)" />你好，
									<input type="text" class="msg-input"  value="${siteName }${jdPhone }" onkeyup="inputWidth(this)"/>
									诚邀您回复数字对本次服务进行评：1.满意；2.一般；3.不满意；4.尚未联系；5.正在处理中，还未处理好。感谢您的支持！
									【<span  id="signD6" >${serviceName }</span>】
								</div>	
								<div id="sendModelD6">
								</div>
							</div>
						</div>
					</div>
					
					<div id="zdymb" hidden="hidden" >
						<div class="msgmould">
							<div class="pos-r pl-70 pr-80 mt-10 " >
								<div class="defmsgcontent"></div>
								<div id="sendModel"></div>	
							</div>
						</div>
					</div>
					<p class='mt-10 hide tipps c-fe0101'>
					<img class="mr-5" src="${ctxImg}/plug-in/static/h-ui.admin/images/tip___.png" alt="" style="margin-bottom:3px;display: inline-block;width: 18px;height:18px;vertical-align: middle">短信签名提交审核通过后，才可使用模板发送短信</a>
						
					</p>
			</div>
			<div class="tabCon">
				<p class="f-14 mb-10">自定义短信编辑：</p>
				<div class="bk-gray pos-r pb-30">
					<textarea class="textarea h-50" id="content" style="border: none;" placeholder="请输入短信内容"></textarea>
					<div class="senderWrap f-r">
						【<input type="text" id="sign" maxlength="8" value="${serviceName }"style="text-align:center" class="msg-input" />】
					</div>
				</div>
				<div class="text-c mt-20">
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="senMsg()">确定</a>
					<a  class="sfbtn sfbtn-opt w-70" onclick="cancelMsg()">取消</a>
				</div>
			</div>
			
			
		</div>
	</div>
</div>

<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
	<h2 class="popupHead">
		短信群发
		<a href="javascript:;" class="sficon closePopup" ></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="f-14">
				您已发送<strong class="c-005aab" id="sucMsg">0</strong>条，未发送<strong class="c-fd7e2a" id="wroMsg">0</strong>条！
			</div>
			<a id="exportLink" onclick="closePopup()" href="${ctx}/order/exportWrongNumberDuring?formPath=/a/order/during" target="_blank" class="c-0383dc mt-10" style="text-decoration: underline;">查看发送失败的工单</a>
			<div class="text-c mt-20" style="padding-right:60px;">
				<a  class="sfbtn sfbtn-opt w-70" onclick="closeThisDiv()">关闭</a>
			</div>
		</div>
	</div>
</div>

<div class="popupBox msgText msgTextQuren"  >
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
$(function(){
	if(isBlank('${serviceName}')){
		layer.msg("短信签名提交审核通过后，才可使用模板发送短信！");
		$(".tipps").show();
	}
	$.Huitab("#msgWrap .tabBarP .tabswitch","#msgWrap .tabCon","current","click","0");
	/* var ctt = "尊敬的@，您的@业务，我司已受理，指派@为您服务，@，详情咨询上门工程师。【@服务】";
	$("#sendModel").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(9,7,\''+ctt+'\',1)" >发送</a>'); */
	var content1="@您好，您的@业务@已受理，@，将为您提供服务，请保持电话通畅，监督电话：@。";
	var content2="尊敬的用户：您的信息@已经派工，服务工程师@，联系电话@，请您对我们的服务进行监督！";
	$("#sendModel1").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("2","6","'+content1+'") value="发送" />');
	$("#sendModel2").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("3","6","'+content2+'") value="发送" />');
	var contentD1="@您好，您的@业务@已受理，请保持电话通畅，监督电话：@。";
	var contentD2="尊敬的用户，您的电话无法接通，请您在方便的时候回复@，我们将尽快为您提供@服务！";
	$("#sendModelD1").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("10","8","'+contentD1+'") value="发送" />');
	$("#sendModelD2").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("11","8","'+contentD2+'") value="发送" />');
    var content3="@您好，@诚邀您回复数字对本次服务进行评价：1.满意；2.一般；3.不满意；4.尚未联系；5.正在处理中，还未处理好。感谢您的支持！";
    $("#sendModelD6").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("7","5","'+content3+'") value="发送" />');
    resetData();
    $(".msgText1").popup();
})


function resetData(){
	if(isBlank('${serviceName}')){
		$(".btn-sendmsg").each(function(){
			$(this).attr("disabled",true);
			$(this).removeClass("sfbtn-green").addClass("sfbtn-gray");
		}) 
	}
}

//下拉框切换自定义模板
	function selectMsgMould(obj){
	    var tag = $('#select-msgmodedef option:selected') .val();
	    var reds = $('#select-msgmodedef option:selected') .attr("reds");
	    if(reds=="1"){
	    	$.ajax({
				type:"POST",
				url:"${ctx }/order/getTag",
				data:{tag:tag},
				success:function(result){
					if(result==null ||result==''){
						layer.msg("信息有误！");
						return;
					}
			    	$(".defmsgcontent").empty();
			    	$(".sysModel").hide();
			    	$("#zdymb").hide();
			    	if(tag=='6'){//上门前
			    		$("#smq").show();
			    		if(result[0].columns.id==2){
							$("#sendModel1").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
						}else{
							$("#sendModel1").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" value="发送" />');
						}
						if(result[1].columns.id=="3"){
							$("#sendModel2").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" value="发送" />');
						}else{
							$("#sendModel2").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
						} 
			    	}
			    	if(tag=='8'){//待派工
			    		$("#dpg").show();
			    		if(result[0].columns.id=="10"){
							$("#sendModelD1").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
						}else{
							$("#sendModelD1").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" value="发送" />');
						}
						if(result[1].columns.id=="11"){
							$("#sendModelD2").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\',3)" value="发送" />');
						}else{
							$("#sendModelD2").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
						} 
			    	}
					if(tag=='7'){//增值产品
						$("#zzcp").show();
						$("#sendModel3").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',1)" value="发送" />');
						$("#sendModel4").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',2)" value="发送" />');
						$("#sendModel5").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',0)" value="发送" />');
			    	}
					if(tag=='4'){//电话无人接听
						$("#dhwrjd").show();
						$("#sendModel6").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
					}
					if(tag=='9'){//配件无人接听
						$("#pjwrjd").show();	
						$("#sendModel7").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');

					}
					if(tag=='3'){//改约
						$("#gyemp").show();
						$("#sendModel8").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
					}
					if(tag=='2'){//缺件
						$("#qjpj").show();
						$("#sendModel9").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
					}
                    if(tag=='5'){//缺件
                        $("#hfdx").show();
                        $("#sendModelD6").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" value="发送" />');
                    }
                    resetData();
                    return;
				}
	    	})
	    	
	    }else{
		    $.ajax({
		        type:"POST",
		        url:"${ctx }/order/getsmsbyid",
		        data:{id:tag},
		        success:function(result) {
		            if (result != "" || result != null) {
		            	$(".defmsgcontent").empty();
				    	$(".sysModel").hide();
		                var newcontent=result.columns.content;
		                while(newcontent.indexOf('@1') >= 0){
		                    newcontent = newcontent.replace("@1","<input type='text' class='msg-input' readonly='readonly'  value='${order.customerName }' onkeyup='inputWidth(this)' id='defcustomerName'/>");
		                }
		                while(newcontent.indexOf('@2') >= 0){
		                    newcontent = newcontent.replace("@2","<input type='text' class='msg-input' readonly='readonly'  value='${order.applianceBrand }' onkeyup='inputWidth(this)' id='defapplianceBrand'/>");
		                }
		                while(newcontent.indexOf('@3') >= 0){
		                    newcontent = newcontent.replace("@3","<input type='text' class='msg-input' readonly='readonly' value='${order.applianceCategory }' onkeyup='inputWidth(this)' id='defapplianceCategory'/>");
		                }
		                while(newcontent.indexOf('@4') >= 0){
		                    newcontent = newcontent.replace("@4","<input type='text' class='msg-input' readonly='readonly' value='${order.serviceType }' onkeyup='inputWidth(this)' id='defserviceType'/>");
		                }
		                while(newcontent.indexOf('@5') >= 0){
		                    if('${order.serviceMode }'=='1'){
		                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' readonly='readonly'  value='上门' onkeyup='inputWidth(this)' id='defserviceMode'/>");
		                    }else if('${order.serviceMode }'=='2'){
		                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' readonly='readonly'  value='拉修' onkeyup='inputWidth(this)' id='defserviceMode'/>");
		                    }else{
		                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' readonly='readonly' value='' onkeyup='inputWidth(this)' id='defserviceMode'/>");
		                    }
		                }
		                while(newcontent.indexOf('@6') >= 0){
		                    newcontent = newcontent.replace("@6","<input type='text' class='msg-input' readonly='readonly' value='${msg2Names}' onkeyup='inputWidth(this)' id='defmsg2Names'/>");
		                }
		                while(newcontent.indexOf('@7') >= 0){
		                    newcontent = newcontent.replace("@7","<input type='text' class='msg-input' readonly='readonly' value='${msg2Mobiles }' onkeyup='inputWidth(this)' id='defmsg2Mobiles'/>");
		                }
		                while(newcontent.indexOf('@8') >= 0){
		                    newcontent = newcontent.replace("@8","<input type='text' class='msg-input' readonly='readonly' value='${site.smsPhone }' onkeyup='inputWidth(this)' id='defjdPhone'/>");
		                }
		                $(".defmsgcontent").append('<span class="lb w-70 text-c">发送内容：</span><div class="bk-gray pd-10">'+newcontent+'</div>');
		                $("#sendModel").append('<input type="button" href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModeldef(\''+result.columns.id+'\',\''+result.columns.tag+'\',\''+result.columns.content+'\',2)" value="发送" />');
		                resetData();
		                $("#zdymb").show();
		            }else{
		
		            }
		        }
		    }) 
	    }

	}
	
function returnMobile(val1,val2,val3){
    var mobile=$.trim(val1);
    if(isBlank(mobile)){
        mobile= $.trim(val2);
    }
    if(isBlank(mobile)){
        mobile= $.trim(val3);
    }
    if(isBlank(mobile)){
        mobile= "";
    }
    return mobile;
}

function isBlank(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}
	
	
	/* 编辑发送短信 */
var sgMark = false;
function senMsg(){ //批量发送短信
	$("#clickSend").empty();
	if(sgMark){
		return;
	}
	
	var mobile="";
	var number="";
	var wrongNumber="";
	var showCustomers="";
	var yxId='${order.id}';
	var ph1=returnMobile('${order.customerMobile}');//去空格的mobile
	if($.trim(ph1)=="" || $.trim(ph1)==null ){
		layer.msg("用户联系方式为空！");
		return ;
	}
	if(ph1.substring(0,1)!='1' || ph1.length != 11){
		layer.msg("用户联系方式不正确！");
		return ;
	}
	var content = $("#content").val();
	var sign = $.trim($("#sign").val());
	if($.trim(content)=="" || content==null){
		layer.msg("自定义发送短信内容不能为空");
		$("#content").focus();
		return;
	}
	if($.trim(sign)=="" || sign==null ){
		layer.msg("短信签名不能为空！");
		$("#sign").focus();
		return false;
	}
	if($.trim(sign).length>8 ){
		layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
		$("#sign").focus();
		return false;
	}
	var siteMsgNums = '${site.smsAvailableAmount}';
	sgMark = true;
	$.ajax({
		type:"POST",
		traditional:true,
		url:"${ctx }/order/msgNumbers",
		data:{content:content,
			sign:sign},
		success:function(result){
			if(parseInt(result) > parseInt(siteMsgNums)){
				layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
			}else{
				$("#peoples").html('${order.customerName}');
				definedContentTz=content;
				$("#sendContent").text("“"+content+"”？");
				$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendAllConfirm(\''+sign+'\',\''+mobile+'\',\''+number+'\',\''+definedContentTz+'\')" >确定</a>&nbsp;&nbsp;'+
						'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
				$(".msgTextQuren").popup({level:2});
			}
		},complete: function() {
			sgMark = false;
		}
	}) 
		
}

var sgallMsg=false;
function sendAllConfirm(sign,mobile,number,definedContentTz){
	if(sgallMsg){
		return;
	}
	var msgNumbers = mobile.split(",");
	sgallMsg=true;
	$.ajax({
		type:"POST",
		traditional:true,
		url:"${ctx }/order/sendMsg",
		data:{content:definedContentTz,
			sign:sign,
			mobile:$("#customerMobile").val(),
			number:'${order.number}'
			},
		success:function(result){
			if(result=="ok"){
				var n = 0;
				for(var j=0;j<msgNumbers.length;j++){
					if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
						n++;
					}
				}
				parent.layer.msg("发送成功");
				//numerCheck();
				$.closeDiv($(".msgText1"));
			}else if(result=="noMessage"){
				layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
				return;
			}else{
				layer.msg("发送失败，请检查！");
				return;
			}
		},complete:function(){
			sgallMsg=false;
		}
	})
}
function closeThisDiv(){
	parent.search();
	$.closeAllDiv();
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

var aflTS = false;
function sendModel1(id,tag,content,mode){
	$("#clickSend").empty();
	if(aflTS){
		return;
	}
	var mobile="";
	var number="";
	var wrongNumber="";
	var showCustomers="";
	var yxId='${order.id}';
	var ph1=returnMobile('${order.customerMobile}');//去空格的mobile
	if($.trim(ph1)=="" || $.trim(ph1)==null ){
		layer.msg("用户联系方式为空！");
		return ;
	}
	if(ph1.substring(0,1)!='1' || ph1.length != 11){
		layer.msg("用户联系方式不正确！");
		return ;
	}
	var endMode = "1";
	var siteMsgNums = '${site.smsAvailableAmount}';
    var custName = $("#custName").val();
    var mode1 = $("#mode1").val();
    var mode2 = $("#mode2").val();
    var mode3 = $("#mode3").val();
    var mode4 = $("#mode4").val();
    var goodsTime = $("#goodsTime").val();
    var pjArea = $("#pjArea").val();
    var pjMobile = $("#pjMobile").val();
    var yw = $("#yw").val();
    var siteName = $("#siteName").val();
    var jdMobile = $("#jdMobile").val();
    var emName = $("#emName").val();//工程师集合
    var emMobile = $("#emMobile").val();//电话集合
    var proTime = $("#proTime").val();
    var promiseLimit = $("#promiseLimit").val();
    var siteMobile = $("#siteMobile").val();
    var custNameMobile = $("#custNameMobile").val();
    var customerMobile = $("#customerMobile").val();//用户联系方式
    var sign = $("#sign").val();
    if('${type}'=='1'){
    	if($.trim(emName)=="" || emName==null){
            layer.msg("工单中没有维护的服务工程师，请先到运营管理下的员工信息管理页面维护！");
            return ;
        }
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
        if($.trim($("#sign1").text())=="" || $("#sign1").text()==null){
            layer.msg("短信签名不能为空！");
            $("#sign1").focus();
            return;
        }
        if($.trim($("#sign1").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#sign1").focus();
            return;
        }
        sign=$.trim($("#sign1").text());
        s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + yw
            + content.substring(path_2 + 1, path_3) + siteName
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
           // + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_5 + 1);

    }else if(id==3){//模板二
        if($.trim($("#sign2").text())=="" || $("#sign2").text()==null){
            layer.msg("短信签名不能为空！");
            $("#sign2").focus();
            return;
        }
        if($.trim($("#sign2").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#sign2").focus();
            return;
        }
        sign=$.trim($("#sign2").text());
        s_temp = content.substring(0, path_1) + custNameMobile
            + content.substring(path_1 + 1, path_2) + emName
            + content.substring(path_2 + 1, path_3) + emMobile
           // + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_3 + 1);

    }else if(id==10){//模板一//待派工
        if($.trim($("#signD1").text())=="" || $("#signD1").text()==null){
            layer.msg("短信签名不能为空！");
            $("#signD1").focus();
            return;
        }
        if($.trim($("#signD1").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#signD1").focus();
            return;
        }
        sign=$.trim($("#signD1").text());
        s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + yw
            + content.substring(path_2 + 1, path_3) + siteName
            + content.substring(path_3 + 1, path_4) + jdMobile
         //   + content.substring(path_4 + 1, path_5) + sign
            + content.substring(path_4 + 1);

    }else if(id==11){//模板二//待派工
        if($.trim($("#signD2").text())=="" || $("#signD2").text()==null){
            layer.msg("短信签名不能为空！");
            $("#signD2").focus();
            return;
        }
        if($.trim($("#signD2").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#signD2").focus();
            return;
        }
        sign=$.trim($("#signD2").text());
        s_temp = content.substring(0, path_1) + siteMobile
            + content.substring(path_1 + 1, path_2) + yw
          //  + content.substring(path_2 + 1, path_3) + sign
            + content.substring(path_2 + 1);

    }else if(id==4){//无法接通
        if($.trim($("#sign3").text())=="" || $("#sign3").text()==null){
            layer.msg("短信签名不能为空！");
            $("#sign3").focus();
            return;
        }
        if($.trim($("#sign3").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#sign3").focus();
            return;
        }
        sign=$.trim($("#sign3").text());
        s_temp = content.substring(0, path_1) + siteMobile
            + content.substring(path_1 + 1, path_2) + emNameMobile
            //+ content.substring(path_2 + 1, path_3) + sign
            + content.substring(path_2 + 1);

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
        if($.trim($("#sign20").text())=="" || $("#sign20").text()==null){
            layer.msg("短信签名不能为空！");
            $("#sign20").focus();
            return;
        }
        if($.trim($("#sign20").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#sign20").focus();
            return;
        }
        sign=$.trim($("#sign20").text());
        s_temp = content.substring(0, path_1) + goodsTime
            + content.substring(path_1 + 1, path_2) + pjArea
            + content.substring(path_2 + 1, path_3) + pjMobile
            //+ content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_3 + 1);
    }else if(id==5){//改约
        if($.trim($("#sign4").text())=="" || $("#sign4").text()==null){
            layer.msg("短信签名不能为空！");
            $("#sign4").focus();
            return;
        }
        if($.trim($("#sign4").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#sign4").focus();
            return;
        }
        sign=$.trim($("#sign4").text());
        s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + proTime
            + content.substring(path_2 + 1, path_3) + promiseLimit
            + content.substring(path_3 + 1, path_4) + emNameMobile
            + content.substring(path_4 + 1, path_5) + jdMobile
          //  + content.substring(path_5 + 1, path_6) + sign
            + content.substring(path_5 + 1);
    }else if(id==6){//缺件
        if($.trim($("#sign5").text())=="" || $("#sign5").text()==null){
            layer.msg("短信签名不能为空！");
            $("#sign5").focus();
            return;
        }
        if($.trim($("#sign5").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#sign5").focus();
            return;
        }
        sign=$.trim($("#sign5").text());
        s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) + emNameMobile
            + content.substring(path_2 + 1, path_3) + jdMobile
        //    + content.substring(path_3 + 1, path_4) + sign
            + content.substring(path_3 + 1);
    }else if(id==7){//回访
        if($.trim($("#signD6").text())=="" || $("#signD6").text()==null){
            layer.msg("短信签名不能为空！");
            $("#signD6").focus();
            return;
        }
        if($.trim($("#signD6").text()).length>8){
            layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
            $("#signD6").focus();
            return;
        }
        sign=$.trim($("#signD6").text());
        s_temp = content.substring(0, path_1) + custName
            + content.substring(path_1 + 1, path_2) +siteName + jdMobile
        //    + content.substring(path_2 + 1, path_3) + sign
            + content.substring(path_2 + 1);
    } else if(id==9){
        if(mode=="1"){
        	endMode = "2";
            if($.trim($("#sign10").text())=="" || $("#sign10").text()==null){
                layer.msg("短信签名不能为空！");
                $("#sign10").focus();
                return;
            }
            if($.trim($("#sign10").text()).length>8){
                layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
                $("#sign10").focus();
                return;
            }
            sign=$.trim($("#sign10").text());
            s_temp = content.substring(0, path_1) + custName
                + content.substring(path_1 + 1, path_2) + yw
                + content.substring(path_2 + 1, path_3) + emNameMobile
                + content.substring(path_3 + 1, path_4) + mode1
              //  + content.substring(path_4 + 1, path_5) + sign
                + content.substring(path_4 + 1);
        }else if(mode=="2"){
        	endMode = "3";
            if($.trim($("#sign11").text())=="" || $("#sign11").text()==null){
                layer.msg("短信签名不能为空！");
                $("#sign11").focus();
                return;
            }
            if($.trim($("#sign11").text()).length>8){
                layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
                $("#sign11").focus();
                return;
            }
            sign=$.trim($("#sign11").text());
            s_temp = content.substring(0, path_1) + custName
                + content.substring(path_1 + 1, path_2) + yw
                + content.substring(path_2 + 1, path_3) + emNameMobile
                + content.substring(path_3 + 1, path_4) + mode2
             //   + content.substring(path_4 + 1, path_5) + sign
                + content.substring(path_4 + 1);
        }else{
        	endMode = "4";
            if($.trim($("#sign12").text())=="" || $("#sign12").text()==null){
                layer.msg("短信签名不能为空！");
                $("#sign12").focus();
                return;
            }
            if($.trim($("#sign12").text()).length>8){
                layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
                $("#sign12").focus();
                return;
            }
            sign=$.trim($("#sign12").text());
            s_temp = content.substring(0, path_1) + custName
                + content.substring(path_1 + 1, path_2) + yw
                + content.substring(path_2 + 1, path_3) + emNameMobile
                + content.substring(path_3 + 1, path_4) + mode3+mode4
             //   + content.substring(path_4 + 1, path_5) + sign
                + content.substring(path_4 + 1);
        }
    }
	aflTS = true;
	$.ajax({
		type:"POST",
		traditional:true,
		url:"${ctx }/order/msgNumbers",
		data:{content:s_temp,
			sign:sign},
		success:function(result){
			if(parseInt(result) > parseInt(siteMsgNums)){
				layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
			}else{
				$("#peoples").html('${order.customerName}');
				definedContentTz=s_temp;
				$("#sendContent").text("“"+s_temp+"”？");
				$("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+number+'\',\''+mobile+'\',\''+yxId+'\',\''+endMode+'\')" >确定</a>&nbsp;&nbsp;'+
						'<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
				$(".msgTextQuren").popup({level:2});
			}
		},complete: function() {
			aflTS = false;
		}
	})  
}

var aflModel=false;
function sendConfirmMsgModel(id,sign,s_temp,tag,number,customerMobile,yxId,endMode){
if(aflModel) {
    return;
}
var msgNumbers = customerMobile.split(",");
var oneHref = $("#mode1").val();
aflModel=true;
$.ajax({
	type:"POST",
	url:"${ctx }/order/fwzSendmsgModelFwzOne",
	data:{temId:id,
		sign:sign,
		content:s_temp,
		extno:tag,
		number:number,
		customerMobile:$("#customerMobile").val(),
		yxId:yxId,
		oneHref:oneHref,
		endMode:endMode,
		definedContentTz:definedContentTz
		},
	success:function(result){
		if(result=="ok"){
			layer.msg("发送成功!");
			var n = 0;
			for(var j=0;j<msgNumbers.length;j++){
				if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
					n++;
				}
			}
			parent.layer.msg("发送成功");
			$.closeDiv($(".msgText1"));
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

function tishi(){
	layer.msg("没有未发送的工单！");
}

//服务商自定义模板
var defafl=false;
function sendModeldef(id,tag,content,markType){
    $("#clickSend").empty();
    if(defafl) {
        return;
    }
    $("#clickSend").empty();
	if(aflTS){
		return;
	}
	var mobile="";
	var number="";
	
	var wrongNumber="";
	var showCustomers="";
	var yxId='${order.id}';
	var ph1=returnMobile('${order.customerMobile}');//去空格的mobile
	if($.trim(ph1)=="" || $.trim(ph1)==null ){
		layer.msg("用户联系方式为空！");
		return ;
	}
	if(ph1.substring(0,1)!='1' || ph1.length != 11){
		layer.msg("用户联系方式不正确！");
		return ;
	}
    var customerMobile = $("#customerMobile").val();//用户联系方式
    var siteMsgNums = '${site.smsAvailableAmount}';//服务商已购还有短信数
    var custName = $("#defcustomerName").val();
    var applianceBrand = $("#defapplianceBrand").val();
    var applianceCategory = $("#defapplianceCategory").val();
    var  serviceType =$("#defserviceType").val();
    var  serviceMode =$("#defserviceMode").val();
    var defempName=$("#defmsg2Names").val();
    var defempMobile=$("#defmsg2Mobiles").val();
    var smsmobile=$("#defjdPhone").val();
    var defsign ='${serviceName }';
    while(content.indexOf('@1') >= 0){
        content = content.replace("@1",custName);
    }
    while(content.indexOf('@2') >= 0){
        content = content.replace("@2",applianceBrand);
    }
    while(content.indexOf('@3') >= 0){
        content = content.replace("@3",applianceCategory);
    }
    while(content.indexOf('@4') >= 0){
        content = content.replace("@4",serviceType);
    }
    while(content.indexOf('@5') >= 0){
        content = content.replace("@5",serviceMode);
    }
    while(content.indexOf('@6') >= 0){
        content = content.replace("@6",defempName);
    }
    while(content.indexOf('@7') >= 0){
        content = content.replace("@7",defempMobile);
    }
    while(content.indexOf('@8') >= 0){
        content = content.replace("@8",smsmobile);
    }
    var newdefcontent=content;
    var s_temp;
    if($.trim(defsign)=="" || defsign==null){
        layer.msg("短信签名不能为空！");
        return;
    }
    if($.trim(defsign).length>8){
        layer.msg("短信签名过长，最多为8个汉字！请在系统设置-短信签名中设置！");
        return;
    }
    var sign=defsign;
    s_temp =newdefcontent;

    defafl = true;
    $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
        type:"POST",
        url:"${ctx }/order/msgNumbers",
        data:{content:s_temp,
            sign:sign,
            markType:markType},
        success:function(result){
            if(parseInt(result) > parseInt(siteMsgNums)){//发送短信数大于购买数
                layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
            }else{
                $("#peoples").html('${order.customerName}');
                $("#sendContent").text("“"+s_temp+"”？");
                $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModelDefined(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+number+'\',\''+mobile+'\',\''+yxId+'\',\''+markType+'\')" >确定</a>&nbsp;&nbsp;'+
                    '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                $(".msgTextQuren").popup({level:2,closeSelfOnly:true});
            }
        },
        complete: function() {
            defafl = false;
        }
    })
   /*  }else if($.trim(customerMobile)==""){
        layer.msg("请填写用户的手机号码！");
    }else{
        layer.msg("用户的手机号码格式不正确，请重新填写！");
    } */
}

var aflModel=false;
function sendConfirmMsgModelDefined(id,sign,s_temp,tag,number,customerMobile,yxId,markType){
	if(aflModel) {
	    return;
    }
	var msgNumbers = customerMobile.split(",");
	aflModel=true;
	$.ajax({
		type:"POST",
		url:"${ctx }/order/fwzSendmsgModelFwzDefined1",
		data:{temId:id,
			sign:sign,
			content:s_temp,
			extno:tag,
			number:number,
			customerMobile:$("#customerMobile").val(),
			yxId:yxId,
			markType:markType
			},
		success:function(result){
			if(result=="ok"){
				var n = 0;
				for(var j=0;j<msgNumbers.length;j++){
					if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
						n++;
					}
				}
				/* $("#sucMsg").text(n);
				$("#wroMsg").text(parseInt(msgNumbers.length)-parseInt(n)); */
				parent.layer.msg("发送成功");
				//numerCheck();
				$.closeDiv($(".msgText1"));
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

function cancelQueren(){
	$.closeDiv($(".msgTextQuren"));
}

function closePopup(){
	$.closeDiv($(".massTextNote"));
	$.closeDiv($(".msgTextQuren"));
	$.closeDiv($(".massText"));
}
</script>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<meta http-equiv="Cache-Control" content="no-store" />

	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/layer/2.1/skin/layer.css" />
	<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.1/layer.js"></script>

	<!--[if lt IE 9]>
	<script type="text/javascript" src="${ctxPlugin}/lib/html5shiv.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/respond.min.js"></script>
	<![endif]-->


	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/order-st/partner/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/order-st/partner/css/style.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/order-st/partner/css/ygcxlm.css"/>
	<!--[if IE 6]>
	<script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->

	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<style type="text/css">
		html,body{ position: relative; height: 100%; }
		body{ overflow: auto;}
	</style>
</head>

<body>
	<div class="loginbg"></div>
	
	<div class="loginWrap">
		<div class="loginWrapBg registerpage" style="padding-top: 42px;">
			<h2 class="webName mb-40" style="margin-left: 50px;"></h2>
			<form action="" id="formAll" method="post"> 
			<div class="loginMain resetMain" id="resetMain">
				<h3 class="lh-26 resetTitle pb-5"> 
					用户注册
					<div class="loginlink" style="right: 90px;">
						<span class="lh-20 va-t">已有账号</span>
						<a  class="btn-forgetpwd" onclick="retn()" href="${ctx}/main/redirect?origin=jdxh">马上登录</a>
					</div>
				</h3>
				<div class="cl pl-80 ml-5 mb-25" id="regSeqWrap">
					<div class="f-l registerSeq registerNext currentSeq">
						<span class="iconSeq">1</span>完善信息
					</div>
					<div class="f-l registerSeq registerNext">
						<span class="iconSeq">2</span>注册账号
					</div>
					<div class="f-l registerSeq ">
						<span class="iconSeq">3</span>完成
					</div>
				</div>
				
				
					<div class="tabCon tabCon1" style="display: block;">
							<div style="height: 200px;">
								<div class="cl mb-10 pl-5">
									<label class="f-l text-r w-180"><em class="mark">*</em>企业名称：</label>
									<input type="text" class="f-l w-300 input-text" name="name" id="name" placeholder="请输入网点名称" datatype="*" errormsg="格式错误" nullmsg="请输入登录名"/>
								</div>
								<div class="cl mb-20 pl-5">
									<label class="f-l text-r w-180"><em class="mark">*</em>企业地址：</label>
									<select class="select mr-10 f-l" style="width: 94px;" id="province" name="province">
										<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }" >${pro.columns.ProvinceName }</option>
										</c:forEach>
										<input hidden="hidden" id="province1" name="province1" />
										<input hidden="hidden" id="zfTypeCopy" name="zfTypeCopy" />
										<input hidden="hidden" id="gmMonthCopy" name="gmMonthCopy" />
										<input hidden="hidden" id="countMoneyCopy" name="countMoneyCopy" />
									</select>
									<select class="select mr-10 f-l" style="width: 94px;" id="city" name="city">
										<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }" >${cs.columns.CityName }</option>
										</c:forEach>
										<input hidden="hidden" id="city1" name="city1" />
									</select>
									<select class="select f-l" style="width: 92px;" id="area" name="area">
										<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }" >${ds.columns.DistrictName }</option>
										</c:forEach>
										<input hidden="hidden" id="area1" name="area1" />
									</select><br />
									<input type="text" class="f-l w-300 input-text mt-10 ml-180" id="address" name="address" placeholder="请输入企业详细地址"  errormsg="格式错误" nullmsg="请输入详细地址"/>
								</div>
								<div class="ml-180 h-26 hide" id="errorTip" >
									<!-- <p class="c-fe0101 f-13 lh-20 hide1"><i class="sficon sficon-errorwran2"></i>您输入的网点名称错误，请重新输入！</p> -->
								</div>
							</div>
						<div class="cl pl-180">
							<a class="btn-login f-l w-120 ml-60 btnNext" id="btnNext">下一步</a>
						</div>
					</div>
					<div class="tabCon tabCon2">
						<div style="height: 200px;">
							<div class="cl mb-10 pl-5">
								<label class="f-l text-r w-180"><em class="mark">*</em>手机号：</label>
								<input type="text" class="f-l w-300 input-text" placeholder="输入的手机号将作为登录的账户名" name="mobile" id="mobile"/>
								<input type="text" class="f-l w-300 input-text hide"  name="msgMark" id="msgMark" value="0"/>
							</div>
							<div class="cl mb-10 pl-5">
								<label class="f-l text-r w-180"><em class="mark">*</em>设置密码：</label>
								<input type="text" class="f-l w-300 input-text" placeholder="6-16位的数字、字母或组合" name="password" id="password"/>
							</div>
							<div class="cl mb-10 pl-5">
								<label class="f-l text-r w-180"><em class="mark">*</em>短信验证码：</label>
								<input type="text" class="f-l w-190 input-text" placeholder="请输入短信验证码" name="confirmCode" id="confirmCode"/>
								<input type="button" id="btn" value="获取验证码" class="f-l ml-10 w-100 btn-getCode btn"/>  
								<!-- <a href="javascript:;" onclick="getConfirmCode()" class="f-l ml-10 w-100 btn-getCode btn">获取验证码</a> -->
							</div>
							<div class="cl mb-10 pl-5">
								<label class="f-l text-r w-180"><em class="mark">*</em>激活码：</label>
								<input type="text" class="f-l w-300 input-text " placeholder="输入激活码，可获得系统免费使用权" id="shareCode" name="shareCode" />
							</div>
							<div class="ml-180 h-26 hide" id="errorTip1">
								<!-- <p class="c-fe0101 f-13 lh-20 hide1"><i class="sficon sficon-errorwran2"></i>您输入的网点名称错误，请重新输入！</p>  -->
							</div>
						</div>
						<div class="cl ml-180 ">
							<a class="btn-prevStep f-l w-120 mr-10" id="btnPrev1">上一步</a>
							<a class="btn-login f-l w-120 btnNext" id="btnNext2">下一步</a>
							
							<!-- <a class="btn-login f-l w-120 mr-10 btnNext btnRegister"  id="btnRegister">注册</a>
							<a class="btn-prevStep f-l w-120" id="btnPrev">上一步</a> -->
						</div>
					</div>
				 
				<div class="tabCon tabCon3">
					<div style="height: 200px;padding-top: 40px;">
						<div class="registerSucess">
							<i class="iconType_sucess "></i>
							<p><strong class="f-18 c-black">注册成功！</strong></p>
							<p class="c-888 f-13">恭喜您 获得思方系统免费功能使用权限！</p>
						</div>
					</div>
					<div class="cl pl-180" id="dlOrGm">
						<!-- <a class="btn-login f-l w-120 ml-60"  onclick="retn()" >立即登录系统</a> -->
					</div>
				</div>
				
			</div>
			</form>
			
		</div>
		
		<div class="loginWrapBg2 registerpage hide" id="rgzc">
			<h2 class="webName mb-40" style="margin-left: 50px;"></h2>
			<div class="loginMain resetMain2">
				<h3 class="lh-26 pb-5 resetTitle"> 
					用户注册
					<div class="loginlink" >
						<span class="lh-20 va-t">已有账号</span>
						<a  class="btn-forgetpwd" onclick="retn()" href="${ctx}/main/redirect?origin=jdxh">马上登录</a>
					</div>
				</h3>
				<div class="cl ml-40 mb-20" id="regSeqWrap2">
					<div class="f-l registerSeq registerNext currentSeq registerFinish">
						<span class="iconSeq">1</span>完善信息
					</div>
					<div class="f-l registerSeq registerNext currentSeq">
						<span class="iconSeq">2</span>注册账号
						<span class="resStep resStep_cur" style="left: 109px;z-index: 9;"></span>
						<span class="resStep " style="left: 170px;z-index: 10;"></span>
					</div>
					<div class="f-l registerSeq " id="currentSeq1">
						<span class="iconSeq">3</span>完成
					</div>
				</div>
				<div class="buyVipStep tabCon1" >
					<div class="mb-20" style="height: 250px;" >
						<div class="buyTitle mb-20">开通VIP会员</div>
						<div class="vipPriceWrap">
							<div class="cl mb-20 vipPriceW">
								<div class="f-l w-130 pb-5 mr-15 vipPrice">
									<p class="mt-15 lh-30">
										<strong class="c-fd6e32 f-20">300元/</strong>
										<span class="lh-30">一月</span>
										<input value="300" name="countMoneyAll" hidden="hidden" />
										<input value="1" name="gmMonth" hidden="hidden" />
									</p>
									<p class="lh-20 c-666"><del>（原价300元）</del></p>
									<div class="line-dashed"></div>
									<div class="lh-22 ">
										仅需10 元/天
									</div>
									<i class="iconChoice"></i>
								</div>
								<div class="f-l w-130 pb-5 mr-15 vipPrice">
									<p class="mt-15 lh-30">
										<strong class="c-fd6e32 f-20">1620元/</strong>
										<span class="lh-30">半年</span>
										<input value="1620" name="countMoneyAll" hidden="hidden" />
										<input value="6" name="gmMonth" hidden="hidden" />
									</p>
									<p class="lh-20 c-666"><del>（原价1825元）</del></p>
									<div class="line-dashed"></div>
									<div class="lh-22">
										仅需9 元/天
									</div>
									<i class="iconChoice"></i>
								</div>
								<div class="f-l w-130 pb-5 mr-15 vipPrice vipCur">
									<span class="sficon-recomendTxt"></span>
									<p class="mt-15 lh-30">
										<strong class="c-fd6e32 f-20">2920元/</strong>
										<span class="lh-30">一年</span>
										<input value="2920" name="countMoneyAll" hidden="hidden" />
										<input value="12" name="gmMonth" hidden="hidden" />
									</p>
									<p class="lh-20 c-666"><del>（原价3650元）</del></p>
									<div class="line-dashed"></div>
									<div class="lh-22">
										仅需8元/天
									</div>
									<i class="iconChoice"></i>
								</div>
								<div class="f-l w-130 pb-5 mr-15 vipPrice">
									<p class="mt-15 lh-30">
										<strong class="c-fd6e32 f-20">5110元/</strong>
										<span class="lh-30">二年</span>
										<input value="5110" name="countMoneyAll" hidden="hidden" />
										<input value="24" name="gmMonth" hidden="hidden" />
									</p>
									<p class="lh-20 c-666"><del>（原价7300元）</del></p>
									<div class="line-dashed"></div>
									<div class="lh-22">
										仅需7 元/天
									</div>
									<i class="iconChoice"></i>
								</div>
								<div class="f-l w-130 pb-5 vipPrice">
									<p class="mt-15 lh-30">
										<strong class="c-fd6e32 f-20">6570元/</strong>
										<span class="lh-30">三年</span>
										<input value="6570" name="countMoneyAll" hidden="hidden" />
										<input value="36" name="gmMonth" hidden="hidden" />
									</p>
									<p class="lh-20 c-666"><del>（原价10950元）</del></p>
									<div class="line-dashed"></div>
									<div class="lh-22">
										仅需6 元/天
									</div>
									<i class="iconChoice"></i>
								</div>
							</div>
							<div class="cl vipPriceW">
								<span class="f-l f-14 lh-30 pt-10 pb-10">支付方式：</span>
								<div class="f-l ml-5">
									<div class="w-120 pt-10 pb-10 f-l f-14 mr-10 vipPrice vipCur zfbCheck">
										<i class="sficon-pay sficon-pay_zfb mr-5"></i>支付宝
										<input hidden="hidden" name="zfbWx" value="zfb"/>
										<i class="iconChoice"></i>
									</div>
									<div class="w-120 pt-10 pb-10 f-l f-14 vipPrice wxCheck">
										<i class="sficon-pay sficon-pay_wx mr-5"></i>微信支付
										<input hidden="hidden" name="zfbWx" value="wx"/>
										<i class="iconChoice"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="text-c">
						<a class="btn-login w-120 btn-prevStep mr-10" id="btnPrev2">上一步</a>
						<a class="btn-login w-120 btnNext" id="btnNext3" onclick="zfPage()">立即支付</a>
					</div>
				</div>
				<div class="tabCon tabCon2 zfbPay ljzf">
					<div class="payment" style="height: 250px;">
					
						<!-- 支付二维码 -->
						<div class="payWrap hide1" id="paymentPart">
							<div class="payWrapTitle">
								支付<span class="c-fd7e2a pl-5 pr-5"><span id="zfbWxMoney"></span></span>元
							</div>
							<div class="cl">
								<div class="payCode">
									<!-- <img src="static/h-ui.admin/images/code.jpg" /> -->
									<!-- 二维码 -->
								</div>
								<div class="payNote"></div>
							</div>
						</div>
						
						<!-- 支付结果（成功） -->
						<div class="text-c payResultS hide" style="padding-top: 100px;">
							<i class="prnote mr-10"></i>
							<span class="text-l pt-10">
								<strong class="f-18">您已成功付款</strong><br>
								<span class="c-888 f-13">对方将立即收到您的付款。</span>
							</span>
						</div>
						<!-- 支付结果（失败） -->
						<div class="text-c payResultF hide" style="padding-top: 100px;" >
							<i class="prnote mr-10"></i>
							<span class="text-l pt-10">
								<strong class="f-18">支付失败</strong>
							</span>
						</div>
						
					</div>
					<div class="text-c pt-5">
						<a class="btn-login w-120 btnNext" id="btnNext4">完成</a>
					</div>
				</div>
					
				<div class="tabCon tabCon3">
					<div style="height: 250px;padding-top: 100px;">
						<div class="registerSucess">
							<i class="iconType_sucess "></i>
							<p><strong class="f-18 c-black">注册成功！</strong></p>
							<p class="c-888 f-13">恭喜您 获得思方系统使用权限！</p>
						</div>
						
					</div>
					<div class=" text-c">
						<a class="btn-login w-120 " onclick="retn()" href="${ctx}/main/redirect?origin=jdxh">立即登录系统</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="copyright">Copyright ©2014-2018 安徽思方网络科技有限公司 皖ICP备17000071号</div>
	<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/jqGrid_5.2/plugins/jquery.contextmenu.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript">
var dueTime="";
var monitor;
var fsMsg="";
var marks="";
	$(function(){

        window.onresize = function(){
            initCopyRight();
        };

		$("#province")
		.change(
				function() {
					var province = $("#province").val();
					$
							.ajax({
								type : "post",
								url : "${ctx}/main/redirect/getCity1",
								async : false,
								data : {
									province : province
								},
								dataType : "json",
								success : function(data) {
									var obj = eval(data);
									var length = obj.length;
									if (length < 1) {
										layer.msg("无数据");
									} else {
										$("#city").empty();
										$("#area").empty();
										var HTML = " ";
										for (var i = 0; i < length; i++) {
											if (i == 0) {
												HTML += '<option value="'+obj[i].columns.CityName+'" selected="selected">'
														+ obj[i].columns.CityName
														+ '</option>';
											} else {
												HTML += '<option value="'+obj[i].columns.CityName+'">'
														+ obj[i].columns.CityName
														+ '</option>';
											}
										}

										$("#city").append(HTML);
									}

								},
								error : function() {
									return;
								},
								complete : function() {
									var cls = $("#city").find(
											"option:selected").prop(
											"value");
									$.ajax({
												type : "post",
												url : "${ctx}/main/redirect/getArea1",
												async : true,
												data : {
													city : cls
												},
												dataType : "json",
												success : function(data) {
													var obj = eval(data);
													var length = obj.length;
													if (length < 1) {
														layer
																.msg("无数据");
													} else {

														$("#area")
																.empty();
														var HTML = " ";
														for (var i = 0; i < length; i++) {
															if (i == 0) {
																HTML += '<option value="'+obj[i].columns.DistrictName+'" selected="selected">'
																		+ obj[i].columns.DistrictName
																		+ '</option>';
															} else {
																HTML += '<option value="'+obj[i].columns.DistrictName+'" >'
																		+ obj[i].columns.DistrictName
																		+ '</option>';
															}
														}
														$("#area")
																.append(
																		HTML);
													}
												}
											});

									return;
								}
							});
				});
	})
	
	//选择市获取区县
$("#city")
		.change(
				function() {
					var city = $("#city").val();
					$.ajax({
								type : "post",
								url : "${ctx}/main/redirect/getArea1",
								async : false,
								data : {
									city : city
								},
								dataType : "json",
								success : function(data) {
									var obj = eval(data);
									var length = obj.length;
									if (length < 1) {
										layer.msg("无数据");
									} else {

										$("#area").empty();
										var HTML = " ";
										for (var i = 0; i < length; i++) {
											if (i == 0) {
												HTML += '<option value="'+obj[i].columns.DistrictName+'" selected="selected">'
														+ obj[i].columns.DistrictName
														+ '</option>';
											} else {
												HTML += '<option value="'+obj[i].columns.DistrictName+'" >'
														+ obj[i].columns.DistrictName
														+ '</option>';
											}
										}
										$("#area").append(HTML);
									}
								}
							});
				});
	
	$('#btnNext').on('click', function(){
		 $("#errorTip").empty();
		 var name = $("#name").val();
		 var address = $("#address").val();
		 var gg = $(this);
		 if(isBlank(name)){
			 $("#name").focus();
			 $("#errorTip").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>输入企业名称！</p>');
			 $("#errorTip").removeClass("hide");
			 return ;
		 } 
		 if(name.length < 4  ){
			 $("#name").focus();
			 $("#errorTip").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您输入的企业名称错误，请重新输入！</p>');
			 $("#errorTip").removeClass("hide");
			 return ;
		 }
		 if(name.length > 20  ){
			 $("#name").focus();
			 $("#errorTip").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您输入的企业名称错误，请重新输入！</p>');
			 $("#errorTip").removeClass("hide");
			 return ;
		 }
		 $.ajax({
			 type:"post",
			 url:"${ctx}/main/redirect/checkSiteName",
			 data:{name:name},
			 success:function(result){
				 if(result=="no"){
					 $("#name").focus();
					 $("#errorTip").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您输入的企业名称已存在，请重新输入！</p>');
					 $("#errorTip").removeClass("hide");
					 return ;
				 }else{
					 if(isBlank(address)){
						 $("#address").focus();
						 $("#errorTip").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入详细地址！</p>');
						 $("#errorTip").removeClass("hide");
						 return ;
					 } 
					$('#regSeqWrap').find('.currentSeq').addClass('registerFinish');
				    $('#regSeqWrap').find('.currentSeq').next().addClass('currentSeq');
					gg.closest('.tabCon').hide().next().show();
				 }
			 }
		 })
		 
	});

	var registering = false;
	$('#btnNext2').on('click', function(){
		if(registering) {
			return;
		}
		$("#dlOrGm").empty();
		var gg = $(this);
		$("#area1").val($('#area option:selected') .val());
		$("#province1").val($('#province option:selected') .val());
		$("#city1").val($('#city option:selected') .val());
		var mobile = $("#mobile").val();
		var password = $("#password").val();
		var shareCode = $("#shareCode").val();
		var confirmCode = $("#confirmCode").val();
		$("#errorTip1").empty();
		isBlank(password);
		if(isBlank(password)){
			 $("#password").focus();
			 $("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入6-16位字符的密码</p>');
			 $("#errorTip1").removeClass("hide");
			 return ;
		}
		if(CheckPassWord(password)==false){
			$("#password").focus();
			 $("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入6-16位字符的密码</p>');
			 $("#errorTip1").removeClass("hide");
			 return ;
		} 
		if(fsMsg=="1"){
			if(isBlank(confirmCode)){
				layer.msg("请输入您获取的短信验证码");
				$("#confirmCode").focus();
				return;
			}
		}else{
			layer.msg("请先点击发送短信验证码");
			$("#confirmCode").focus();
			return;
		}
		
		if(isBlank(shareCode)){
			 $("#shareCode").focus();
			 $("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请填写激活码，输入激活码即可获取免费使用权限</p>');
			 $("#errorTip1").removeClass("hide");
			 return ;
		} 
		//激活码、验证码的验证在后台注册的时候验证
		registering = true;
		$.ajax({
			type:"post",
			url:"${ctx}/main/redirect/registerSign",
			data:$("#formAll").serialize(),
			success:function(result){
				if(result=="existName"){
					$("#mobile").focus();
					$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>该号码已注册，请勿重复注册</p>');
					$("#errorTip1").removeClass("hide");
				}else if(result=="wrongMsg"){
					$("#confirmCode").focus();
					$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您的短信验证码输入错误，请重新输入</p>');
					$("#errorTip1").removeClass("hide");
				}else if(result=="wrongCode"){
					$("#shareCode").focus();
					$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您输入的激活码不存在，请联系思方客服0551-66556995</p>');
					$("#errorTip1").removeClass("hide");
				}else if(result=="qgOk" || result=="shOk"){
					$("#dlOrGm").append('<a class="btn-login f-l w-120 ml-60" onclick="retn()" >立即登录系统</a>');
					$('#regSeqWrap').find('.currentSeq').addClass('registerFinish');
				    $('#regSeqWrap').find('.currentSeq').next().addClass('currentSeq');
					gg.closest('.tabCon').hide().next().show();
					$('.loginlink').hide();
				}/* else if(result=="shOk"){//无论是区管码还是服务商的分享码都是免费版
					$('.loginWrapBg').hide();
					$('.loginWrapBg2').show();
				} */else if(result=="qgLimit"){
					$("#shareCode").focus();
					$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您输入的激活码分享次数已超上限，请更换其他激活码或联系思方客服：0551-66686515.</p>');
					$("#errorTip1").removeClass("hide");
				}else if(result=="nothing"){
					$("#confirmCode").focus();
					$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>您的短信验证码已失效，请重新获取</p>');
					$("#errorTip1").removeClass("hide");
				}else{
					$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>注册失败，请检查！</p>');
					$("#errorTip1").removeClass("hide");
				} 
			},
			complete: function() {
				registering =  false;
			}
		});
	});
	
	
	$('#btnPrev').on('click', function(){
		$('#regSeqWrap').find('.currentSeq').last().prev().removeClass('registerFinish');
		$('#regSeqWrap').find('.currentSeq').last().removeClass('currentSeq');
		$(this).closest('.tabCon').hide().prev().show();
	});
	
	function isBlank(val) {
		if (val == null || $.trim(val) == '' || val == undefined) {
			return true;
		}
		return false;
	}
	
	function CheckPassWord(password) {
		
		   var str = password;
		   if ((str.length < 6) || (str.length > 16) ) {
		        return false;
		    } 
		   /*  var reg1 = new RegExp(/^[a-zA-Z0-9]{6,16}$/);
		    if (!reg1.test(str)) {
		        return false;
		    } */
		} 
	
	var wait=60; 
	function time(o) { 
		
			 if (wait == 0) { 
				 o.removeAttribute("disabled");            
	             o.value="获取验证码";  
	             wait = 60;
		        } else {  
		            o.setAttribute("disabled", true);  
		            o.value="重新发送(" + wait + ")";  
		            wait--;  
		            setTimeout(function() {  
		                time(o)  
		            },  
		            1000)  
		        }  
    }  
	document.getElementById("btn").onclick=function(){
		var ff = this;
		$("#errorTip1").empty();
    	var mobile = $("#mobile").val();
    	if(mobile.length==11 && (/^1[3|4|5|7|8|9][0-9]\d{4,8}$/.test(mobile))){//点击发送短信验证码
    		fsMsg="1";
	    	$.ajax({
	    		type:"post",
	    		url:"${ctx}/main/redirect/sendMsg",
	    		data:{mobile:mobile},
	    		success:function(result){
	    			if(result=="ok"){
	    				time(ff);
	    				$("#msgMark").val("0") ;
	    			}else if(result=="existName"){
	    				$("#mobile").focus();
						$("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>该号码已注册，请勿重复注册</p>');
						$("#errorTip1").removeClass("hide");
	    			}else{
	    				layer.msg("发送失败，请检查！");
	    				return ;
	    			}
	    		}
	    	})
    	}else{
    		 $("#mobile").focus();
			 $("#errorTip1").append('<p class="c-fe0101 jdxhIcon jdxhIcon_errorWarn hide1"><i class="sficon sficon-errorwran2"></i>请输入正确的手机号</p>');
			 $("#errorTip1").removeClass("hide");
    	}
	}
	
	function retn(){
		/* layer.open({
			type : 2,
			content:'${ctx}/main/redirect/mainIndex',
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		}); */
		window.parent.location.reload(true);
		window.close();
	}
	
	function bugSystem(){
		var mobile = $("#mobile").val();
		layer.open({
			  type: 2, 
			  content: '${ctx}/main/redirect/openVIPSign?mobile='+mobile, 
			  //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://baidu.com', 'no']
			  title:false,
			  area: ['100%','100%'],
			  closeBtn:0,
			  shade:0
		});
	}
	
	$('#btnPrev1').on('click', function(){
		$('#regSeqWrap').find('.currentSeq').last().prev().removeClass('registerFinish');
		$('#regSeqWrap').find('.currentSeq').last().removeClass('currentSeq');
		$('.loginWrapBg').find('.tabCon2').hide();
		$('.loginWrapBg').find('.tabCon1').show();
	});
	
	$('#btnNext3').on('click', function(){
		$('#regSeqWrap2').find('.resStep').eq(1).addClass('resStep_cur');
		$('.loginWrapBg2').find('.tabCon1').hide();
		$('.loginWrapBg2').find('.tabCon2').show();
	});
	
	 var formPosted = false;
	function zfPage(){
		if(formPosted) {
			return false;
		}
		marks="";
		formPosted = true;
		var index = layer.load(0, {shade: false});
		$(".payCode").empty();
		var countMoney = $(".vipCur input[name='countMoneyAll']").val();
		var gmMonth = $(".vipCur input[name='gmMonth']").val();
		var zfType = $(".vipCur input[name='zfbWx']").val();//支付宝：zfb；微信：wx;
		$("#countMoneyCopy").val(countMoney);
		$("#zfTypeCopy").val(zfType);
		$("#gmMonthCopy").val(gmMonth);
		$.ajax({
			type:"POST",
			url:"${ctx}/main/redirect/scPlatOrderSign",
			data:$("#formAll").serialize(),
			success:function(data){
				if (data.result.code == "200") {
					var qrCodeUrl = data.result.data[0];
					$('.payCode').qrcode({width: 150, height: 150, text: qrCodeUrl});
					if(zfType=="zfb"){
						$(".ljzf").removeClass("wxPay").addClass("zfbPay");
					}else if(zfType=="wx"){
						$(".lizf").removeClass("zfbPay").addClass("wxPay");
					}
					//$("#yfMoney").text(countMoney);
					$("#zfbWxMoney").text(countMoney);
					//$("#orderNo").text(data.result.data[2]);
					/* var startTime;
					var endTime;
					var date =  new Date();
					if(dueTime==null || dueTime==""){
						startTime="";
						endTime = "";
					}else{
						startTime="";
						endTime="";
					}
					$("#dateRange").text("("+data.timeList[0].start +"-"+data.timeList[0].end+")");
					var sbJect = "";
					if(gmMonth=="1"){//
						sbJect="一个月";
					}else if(gmMonth=="6"){
						sbJect="半年";
					}else if(gmMonth=="12"){
						sbJect="一年";
					}else if(gmMonth=="24"){
						sbJect="两年";
					}else if(gmMonth=="36"){
						sbJect="三年";
					}
					$("#limitDate").text(sbJect); */
					$(".zfbCheck").addClass("vipCur");
					$(".wxCheck").removeClass("vipCur");
					//$.setPos($('.spPayWrap'));
					//$('.payshadeBg').show();
				//	$('.spPayWrap').show();
					
					unipay.config({
						cancelPath: "${ctx}/main/redirect/cancel",
						queryOrderStatusPath: "${ctx}/main/redirect/status"
					});
					var payType="";
					if(zfType=="zfb"){
						payType="alipay";
					}else{
						payType="wx";
					}
					monitor = new unipay.Monitor(payType, data.result.data[1], {
						onPaySuccess: function() {
							$("#currentSeq1").addClass("currentSeq");
							$(".payResultS").show();
							$("#paymentPart").hide();
							marks="ok";
						},
						onPayTimeout: function () {
							layer.msg("支付超时");
							//qquxiaozhifu();
						}
					});
					monitor.start();
				}else{
					$(".payResultF").show();
				} 
			},
			error: function(a, b, c) {
			},
			complete: function () {
				formPosted = false;
				layer.close(index);
			}
		}) 
	}
	
	$('#btnNext4').on('click', function(){//点击完成
		if(marks=="ok"){
			$('#regSeqWrap2').find('.registerSeq').eq(1).addClass('registerFinish');
			$('#regSeqWrap2').find('.registerSeq').eq(2).addClass('currentSeq');
			$('.loginWrapBg2').find('.tabCon2').hide();
			$('.loginWrapBg2').find('.tabCon3').show();
		}else{
			layer.msg("请先完成支付！");
			return ;
		}
		
	});
	
	$('.vipPrice').on('click', function(){
		$(this).closest('.vipPriceW').find('.vipPrice').removeClass('vipCur');
		$(this).addClass('vipCur');
	});
	
	$('#btnPrev2').on('click', function(){
		$("#rgzc").hide();
		$('.loginWrapBg2').find('.tabCon2').hide();
		$('.loginWrapBg').show();
	});

	// 底部版权信息位置
	function initCopyRight(){
		var pageHeight = $(window).height();

		if( pageHeight <= 768){
			$('body').height('768px');
		}else{
			$('body').height('100%');
		}
	}
	
</script>

</body>
</html>
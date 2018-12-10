<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>

  </head>
  
  <body>
<!-- 添加 -->
<div class="popupBox gysxzsp" style="width:450px">
	<h2 class="popupHead">
	<c:if test="${empty oId }">
		添加
	</c:if>
	<c:if test="${not empty oId }">
		修改
	</c:if>
	<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form action="" method="post" id="addOrEdit">
	<c:if test="${empty oId }">
		<div class="popupContainer">
		<div class="popupMain">
			<div style="">
				<div class="cl mb-10">
				<input type="hidden"  name="siteId" id="siteId"/>
				<input type="hidden"  name="userId" id="userId"/>
					<label class="f-l w-90"><em class="mark">*</em>服务商名称：</label>
					<input type="text" class="input-text w-200 f-l gyname" value=""  id="name" name="name"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>登陆账号：</label>
					<input type="text" class="input-text w-200 f-l gycontactor" value=""   id="loginName" name="loginName"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>登陆密码：</label>
					<input type="text" class="input-text w-200 f-l gyphone"  id="password" name="password"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>手机号：</label>
					<input type="text" class="input-text w-200 f-l gyphone" value=""  id="mobile" name="mobile"/>
					<input type="hidden"  id="type" value="${type }" name="type"/>
					<input type="hidden"  id="oId" value="${oId }" name="oId"/>
					<input type="hidden"  id="provi"  name="provi"/>
					<input type="hidden"  id="cty"  name="cty"/>
					<input type="hidden"  id="distc"  name="distc"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90"><em class="mark">*</em>企业地址：</label>
					<span class="select-box w-90 f-l mb-10" id="showProvince" >
						<select class="select" id="province" >
							<c:forEach items="${provincelist }" var="pro">
								<option value="${pro.columns.ProvinceName }" >${pro.columns.ProvinceName }</option>
							</c:forEach>
						</select>
					</span>
					<span class="select-box w-90 f-l ml-15 mb-10" id="showCity"  >
						<select class="select" id="city"  >
							<c:forEach items="${cities }" var="cs">
								<option value="${cs.columns.CityName }" >${cs.columns.CityName }</option>
							</c:forEach>
						</select>
					</span>
					<span class="select-box w-90 f-l ml-15 mb-10" id="showArea" >
						<select class="select"  id="area" value=""  >
						<c:forEach items="${districts }" var="ds">
								<option value="${ds.columns.DistrictName }" >${ds.columns.DistrictName }</option>
						</c:forEach>
						</select>
					</span><br>
					<input id="spanadress" type="text" name="spanadress"  style="margin-left:90px" class="input-text f-l w-300 " value=""/>
				</div>
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  onclick="save()">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
			</div>
		
		</div>
	</div>
	</c:if>
	
	<c:if test="${not empty oId }">
		<div class="popupContainer">
			<div class="popupMain">
				<div>
					<div class="cl mb-10">
					<input type="hidden"  name="siteId" id="siteId"/>
					<input type="hidden"  name="userId" id="userId"/>
						<label class="f-l w-90"><em class="mark">*</em>服务商名称：</label>
						<input type="text" class="input-text w-200 f-l gyname" value="${record.columns.name }"  id="name" name="name"/>
						<input type="text" class="input-text w-200 f-l gyname hide" value="${record.columns.name }"  id="oldName" name="oldName"/>
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90"><em class="mark">*</em>登陆账号：</label>
						<input type="text" class="input-text w-200 f-l gycontactor " value="${record.columns.login_name }"   id="loginName" name="loginName"/>
						<input type="text" class="input-text w-200 f-l gycontactor hide" value="${record.columns.login_name }"   id="oldLoginName" name="oldLoginName"/>
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90"><em class="mark">*</em>登陆密码：</label>
						<input type="text" class="input-text w-200 f-l gyphone"  id="password" name="password"/>
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90"><em class="mark">*</em>手机号：</label>
						<input type="text" class="input-text w-200 f-l gyphone" value="${record.columns.mobile }"  id="mobile" name="mobile"/>
						<input type="text" class="input-text w-200 f-l gyphone hide" value="${record.columns.mobile }"  id="oldMobile" name="oldMobile"/>
						<input type="hidden"  id="type" value="${type }" name="type"/>
						<input type="hidden"  id="oId" value="${oId }" name="oId"/>
						<input type="hidden"  id="provi"  name="provi"/>
						<input type="hidden"  id="cty"  name="cty"/>
						<input type="hidden"  id="distc"  name="distc"/>
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90"><em class="mark">*</em>企业地址：</label>
						<span class="select-box w-90 f-l mb-10" id="showProvince" >
							<select class="select" id="province" >
								<c:forEach items="${provincelist }" var="pro">
									<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==record.columns.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
								</c:forEach>
							</select>
						</span>
						<span class="select-box w-90 f-l ml-15 mb-10" id="showCity"  >
							<select class="select" id="city"  >
								<c:forEach items="${cities }" var="cs">
									<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==record.columns.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
								</c:forEach>
							</select>
						</span>
						<span class="select-box w-90 f-l ml-15 mb-10" id="showArea" >
							<select class="select"  id="area" value=""  >
							<c:forEach items="${districts }" var="ds">
									<option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==record.columns.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
							</c:forEach>
							</select>
						</span><br>
						<input id="spanadress" type="text" name="spanadress"  style="margin-left:90px" class="input-text f-l w-300 " value="${record.columns.address }"/>
					</div>
				</div>
				<div class="text-c mt-20">
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5"  onclick="save()">保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
				</div>
			
			</div>
		</div>
	</c:if>
	</form>
</div>

<script type="text/javascript">
var type;
var oId;
var sfGrid;
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

$(function(){
	$(".gysxzsp").popup();
	$("#province")
	.change(
			function() {
				var province = $("#province").val();
				$
						.ajax({
							type : "post",
							url : "${ctx}/order/getCity",
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
											url : "${ctx}/order/getArea",
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
	/* $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	initSfGrid(); */
});


function save(){
	$("#provi").val($('#province option:selected') .val());
	$("#cty").val($('#city option:selected') .val());
	$("#distc").val($('#area option:selected') .val());
	var name = $("#name").val();
	var loginName = $("#loginName").val();
	var password = $("#password").val();
	var mobile = $("#mobile").val();
	var type=$("#type").val();
	if(isBlank(name)){
		layer.msg("请填写服务商名称！");
		$("#name").focus();
		return false;
	}
	if(isBlank(loginName)){
		layer.msg("请填写登陆账号！");
		$("#loginName").focus();
		return false;
	}
	if(type=="2"){
		if(isBlank(password)){
			layer.msg("请填写登陆密码！");
			$("#password").focus();
			return false;
		}
	}
	if(isBlank(mobile)){
		layer.msg("请填写手机号！");
		$("#mobile").focus();
		return false;
	}else if(checkMobile(mobile)==false){
		layer.msg("请填写正确的手机号！");
		$("#mobile").focus();
		return false;
	}
	if(isBlank($("#spanadress").val())){
		layer.msg("请填写详细地址！");
		$("#spanadress").focus();
		return false;
	}
	$.ajax({
		type:"POST",
		url:"${ctx}/order/siteSet/save",
		data:$("#addOrEdit").serializeJson(),
		success:function(result){
			if(result=="existName"){
				layer.msg("该服务商名称已存在！");
			}else if(result=="existLoginName"){
				layer.msg("该登陆账号已存在！");
			}else if(result=="existMobile"){
				layer.msg("该手机号已注册！");
			}else if(result=="ok"){
				if(type=="2"){
					layer.msg("添加成功！");
				}else{
					layer.msg("修改成功！");
				}
				//$.closeDiv($(".gysxzsp"));
				//window.location.parent.reload(true);
				
				window.location.href='${ctx}/order/siteSet';
				$('#Hui-article-box',window.top.document).css({'z-index':'9'});
			}else{
				if(type=="2"){
					layer.msg("添加失败，请检查！");
				}else{
					layer.msg("修改失败，请检查！");
				}
			}
		}
	})
}

function checkMobile(number){
	if(number.length==11){
		if(number.substring(0,1)=="1"){
			return true;
		}
	}
	return false;
}

function checkPassword(password){
	//var mima = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
	//var re = new RegExp(mima);
	if(/^[a-z0-9A-Z]{6,16}$/.test(password)){
		return true;
	}
	return false;
}

function isBlank(val) {
	if (val == null || $.trim(val) == '' || val == undefined) {
		return true;
	}
	return false;
}

//选择市获取区县
$("#city")
		.change(
				function() {
					var city = $("#city").val();
					$.ajax({
								type : "post",
								url : "${ctx}/order/getArea",
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
				
				function closed(){
					$.closeDiv($(".gysxzsp"));
				}

</script>
  </body>
</html>
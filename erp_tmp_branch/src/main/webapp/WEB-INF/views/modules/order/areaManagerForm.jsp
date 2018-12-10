<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script> 
<title>区域管理-区域人员管理</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox sysNotice editeNotice" style="width:500px">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
				<div class="popupMain pt-25 pr-25 pb-15">
			<div class="cl mb-10">
				<input type="hidden" id="ids" value="${areaManager.columns.id }">
				<input type="hidden" id="oldname" value="${areaManager.columns.name }">
				<%-- <label class="w-80 text-r f-l">区管等级：</label>
				<select class="select w-140 f-l addlevel" name="addlevel"  id="addlevel">
                  <c:if test="${empty areaManager.columns.superior_district  }">
                  	<option value="1"  selected="selected">一级区管</option>
					<option value="2">二级区管</option>
                  </c:if>
                           <c:if test="${not empty areaManager.columns.superior_district  }">
                  	<option value="1" >一级区管</option>
					<option value="2"  selected="selected">二级区管</option>
                  </c:if>
				</select> --%>
				<%-- <label class="w-100 text-r f-l">上级区管：</label>
				<select class="select w-140 f-l" style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0" name="superiorDistrict" id="superiorDistrict" datatype="*" nullmsg="请选择上级区管！"  >
					<c:if test="${empty areaManager.columns.superior_district  }">
     	            	<option value="">请选择</option>   
            		</c:if>
		              <c:if test="${not empty areaManager.columns.superior_district  }">
		              <c:forEach items="${supplist }" var="sup">
		              <c:if test="${areaManager.columns.superior_district == sup.columns.name }">
		              <option value="${areaManager.columns.superior_district }" selected="selected">${areaManager.columns.superior_district }</option>
		              </c:if>
		                     <c:if test="${areaManager.columns.superior_district !=  sup.columns.name }">
		              <option value="${sup.columns.name}">${sup.columns.name }</option>
		              </c:if>
		              
		              </c:forEach>
		              
		              </c:if>
				</select> --%>
			</div>
		
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">姓名：</label>
				<input type="text" class="input-text w-140 f-l addphone"  id="addname" name="addcontent" value="${areaManager.columns.name }" >
				<label class="w-100 text-r f-l">联系方式：</label>
				<input type="text"  id="addphone" name="addphone" class="input-text w-140 f-l addphone" value="${areaManager.columns.phone }">
			</div>
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">区域：</label>
				<input class="input-text w-140 f-l addarea"  id="addarea" name="addarea" type="text" value="${areaManager.columns.area }"/>
				<label class="w-100 text-r f-l">激活码：</label>
				<input class="input-text w-140 f-l addcode"  id="addcode" name="addcode" type="text" value="${areaManager.columns.code }"/>
			</div>
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">登陆账号：</label>
				<input type="text" class="input-text w-140 f-l readonly"  id="loginName" name="loginName" value="${loginName}" readonly="readonly">
				<label class="w-100 text-r f-l">登陆密码：</label>
				<input type="text"  id="password" name="password" class="input-text w-140 f-l " value="">
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-publish" onclick="fabu()">确认</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closeds()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function(){
	$('.editeNotice').popup();
	
  	$("#superiorDistrict").change(function(){
       if($("#superiorDistrict").val()!=""){
    	   $(".addlevel option:eq(2)").attr('selected','selected');
       }else{
    	   $(".addlevel option:eq(1)").attr('selected','selected');
       }
	 		 
		});  
	
	});
	
	$('#addlevel').change(function(){ 
		var name=$(".addlevel").val();
		if(name==="2"){
			var strls = "";
			$.ajax({
				url:"${ctx}/order/areaManager/changedistrict",
				dataType:'json',
				data:{"name":name},
				async:false,
				success:function(result){
					$.each(result.changecstr,function(index,val){
			                 
							strls+="<option value="+val+">"+val+"</option>";
						
					});
					$("#superiorDistrict").html();
					$("#superiorDistrict").html(strls);
				},
				error:function(){
					return;
				}
				
			}); 
		}else{
			strls+="<option value=''>请选择</option>"
			$("#superiorDistrict").html(strls);
		}
	})
	function closeds(){
		   //window.location.href="${ctx}/order/unit"
		$.closeDiv($('.editeNotice'));
	}


	function fabu(){
		var oldname=$("#oldname").val();
		var id=$("#ids").val();
		var superiorDistrict=$("#superiorDistrict").val();
		var name=$("#addname").val();
		var phone=$("#addphone").val();
		var area=$("#addarea").val();
		var code=$("#addcode").val();
		var password=$("#password").val();
		if (isBlank(name)) {
			layer.msg("请输入姓名");
			$("#addname").focus();
			
		}
		 if (isBlank(phone)) {
				layer.msg("请输入联系方式");
				$("#addphone").focus();
				
		 }
		 if (isPhoneNo(phone) == false) {
				layer.msg("手机号码格式不正确");
				return;
			}
			if (isBlank(area)) {
				layer.msg("请输入区域");
				$("#addarea").focus();
			
			}
			if (isBlank(code)) {
				layer.msg("请输入激活码");
				$("#addcode").focus();
			
			}
			if(isCode(code)==false){
				layer.msg("激活码格式不正确");
				return;
				
			}
		
		$.ajax({
			type:'POST',
			url:"${ctx}/order/areaManager/addareaManager",
			traditional: true,
			data:{
				"oldname":oldname,
				"id":id,
				"superiorDistrict":superiorDistrict,
			    "name":name,
			    "phone":phone,
			    "area":area,
			    "code":code,
			    password:password
			},
			success:function(result){
				if(result=="ok"){
					parent.location.reload(); 
					$.closeDiv($(".editeNotice"));
					//window.location.reload(true);
				}else if(result!=""){
					layer.msg(result);
					return;
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
	
	function isPhoneNo(phone) {
		var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
		return pattern.test(phone);
	}

	function isCode(code){
		var pattern =/^[a-zA-Z0-9]{4}$/;
		return pattern.test(code);
	}

	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}

</script> 
</body>
</html> 
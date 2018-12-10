]<%@page import="com.google.common.collect.Lists"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<%-- <link href="${ctxPlugin}/lib/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />	 --%>
	<link href="${ctxPlugin}/static/h-ui.admin/css/style.css" type="text/css" rel="stylesheet" />
	<link href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" type="text/css" rel="stylesheet" />	
	<link href="${ctxPlugin}/static/order-st/infosysterm/css/infosys.css" type="text/css" rel="stylesheet" />	
	<style type="text/css">
		thead tr td {background-color: #c4c4c4;}
	</style>
<script type="text/javascript">
function dele(id){
    if(confirm('确认要删除该角色吗？')){  
    	location.href='${ctx}'+ "/sys/role/delete?id=" + id;
    }
}
</script>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
    <%-- <div class="btnWrap">
    	<ul>
        	<li><a href="${ctx}/sys/role/form" class="btnBg1">添加</a></li>
    	</ul>
    </div> --%>
    <div class="btn-fwscxbox">
		<a class="btn btn-primary btn-fwscx" href="${ctx}/sys/role/form"><i class="cxicon"></i>添加</a>
		<a class="btn btn-success" href="javascript:showSysForm();"><i class="cxicon"></i>一键添加运营人员</a>
		<a class="btn btn-success" href="${ctx}/sys/user/sysUserList"><i class="cxicon"></i>维护运营人员</a>
		<a class="btn btn-success" href="javascript:showSysAuthForm();"><i class="cxicon"></i>一键配置运营人员权限</a>
	</div>
		
    <br>
	<tags:message content="${message}"/>
	<table id="contentTable" cellpadding="0" cellspacing="0" class="messkt" width="100%">
		<thead>
		<tr class="header"><td>角色名称</td><td>操作</td></tr>
		</thead>
		<c:forEach items="${list}" var="role">
			<tr>
				<td><a href="${ctx}/sys/role/form?id=${role.id}">${role.name}</a></td>
				<%-- <shiro:hasPermission name="sys:role:edit"> --%><td>
					<%-- <a href="${ctx}/sys/role/assign?id=${role.id}">分配</a> --%>
					<c:if test="${role.id != '1'}">
					<a href="${ctx}/sys/role/form?id=${role.id}">修改</a>
					<a href="javascript:;" onclick="dele('${role.id}')">删除</a>
					</c:if>
				</td><%-- </shiro:hasPermission>	 --%>
			</tr>
		</c:forEach>
	</table>
</div></div>

<div id="sysForm" class="popupBox sysForm">
	<h2 class="popupHead">验证框 <a class="sficon closePopup"></a> </h2>
	<form class="layui-form" >
		<div class="popupContainer pd-20">
			<div class="popupMain">
			  <div class="cl mb-10">
			    <label class="w-80 text-r">登录名：</label>
			    <input id="sysUserLoginName" lay-verify="title" autocomplete="off" placeholder="" class="input-text w-140" type="text">
			  </div>
			  <div class="cl mb-10">
			    <label class="w-80 text-r">密码：</label>
			    <input id="sysUserPwd" lay-verify="title" autocomplete="off" placeholder="" class="input-text w-140" type="text">
			  </div>
			   <div class="text-c pt-20">
			   		<a href="javascript:saveSysUser();" class="sfbtn sfbtn-opt3　w-70" style="background: #0e8ee7; order: 1px solid #0e8ee7;color: #fff;">保存</a>
			  </div>
		  </div>
	 	</div>
	 </form>
</div>

<div class="popupBox sysAuthForm">
	<h2 class="popupHead">验证框 <a class="sficon closePopup"></a> </h2>
	<div class="popupContainer pd-15">
		<div clss="popupMain">
			<textarea style="height:600px;width: 800px;" id="sysAuthMsg"></textarea>
		</div>
		<div class="text-c pt-20">
		   		<a href="javascript:saveSysAuth();" class="sfbtn sfbtn-opt3　w-70" style="background: #0e8ee7; order: 1px solid #0e8ee7;color: #fff;">保存</a>
		  </div>
	</div>

</div>

<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	function showSysForm(){
		$(".sysForm").popup();	
	}
	
	function showSysAuthForm(){
		$.ajax({
			url:'${ctx}/sys/user/getSysAuthMsg',
			success:function(data){
				var data_ = eval(data);
				$("#sysAuthMsg").append(JSON.stringify(data_, null, 4));
				$(".sysAuthForm").popup();
			}
		});
		
	}
	
	function saveSysUser(){
		var postData = {"loginName":$("#sysUserLoginName").val(), "pwd": $("#sysUserPwd").val()}
		$.ajax({
			url:'${ctx}/sys/user/addSysUser',
			type:'post',
			data: postData,
			success: function(info){
				if("ok" == info){
					layer.msg("保持成功");
				}else if("exist" == info){
					layer.msg($("#sysUserLoginName").val() + "人员已存在!");
				}else{
					layer.msg("保存失败!");
				}
			}
		});
	}
	
	function saveSysAuth(){
		var jsondata = $.parseJSON($("#sysAuthMsg").val());
		$.ajax({
			url:'${ctx}/sys/user/saveSysAuth',
			type:'post',
			data: {data: $("#sysAuthMsg").val()},
			success: function(info){
				if("ok" == info){
					layer.msg("保持成功");
				}else{
					layer.msg("保存失败，请检查json格式!");
				}
			}
		});
	}
</script>
</body>

</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<%-- <link rel="stylesheet" href="${ctxPlugin}/lib/zTree/v3/css/demo.css" type="text/css"> --%>
<link rel="stylesheet" href="${ctxPlugin}/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery.ztree.excheck-3.5.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/zTreeStyle.css"/>

<title>全部工单</title>

</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEMSGMGM_EMPLOYEMGM_TAB" html='<a class="btn-tabBar " href="${ctx}/operate/nonServiceman/WholeServiceManHeader">员工管理</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEMSGMGM_ROLEPOWER_TAB" html='<a class="btn-tabBar current" href="${ctx}/operate/siteRolePermission/existRolePermission">角色权限管理</a>'></sfTags:pagePermission>
			</div>
			<div class="bk-gray roleWrap">
				<div class="roleNameWrap">
					<div class="title">角色</div>
					<div class="namelist">
						<div class="roleBox">
						<ul class="roleList roleList_dis">
							<li><a href="${ctx}/operate/siteRolePermission/existRolePermission?sysRoleId=1">信息员</a></li>
							<li><a href="${ctx}/operate/siteRolePermission/existRolePermission?sysRoleId=2">配件员</a></li>
							<li><a href="${ctx}/operate/siteRolePermission/existRolePermission?sysRoleId=3">财务人员</a></li>
						</ul>
						<div class="line-dashed mt-10"></div>
						<ul class="roleList mt-10 roleList_edit">
							
								<c:forEach items="${list}" var="defineRole">
								<li class="pos-r"> 
									<a href="${ctx}/operate/siteRolePermission/defineRoleRolePermission?sysRolePermissionId=${defineRole.columns.id}">
										${defineRole.columns.site_role_name}
									</a>
									<i class="sficon btn-del  f-r mt-3 biaojishanchu"><input hidden="hidden" value="${defineRole.columns.id }" id="${defineRole.columns.id }"/></i>
								</li>
								</c:forEach> 
						</ul>
						</div>
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEMSGMGM_ROLEPOWER_ADDROLE_BTN" html='<div class="box-btnAddRole"><a href="${ctx}/operate/siteRolePermission/defineRoleRolePermission1" class="mt-5 btn-addRole"><i class="sficon sficon-add"></i> 新增角色</a></div>'></sfTags:pagePermission>
					</div>
				</div>
				<div class="">
					<div class="title">操作</div>
					<div class=" pd-10 authoritybox">
						<div class="cl mb-10">
							<label class="text-r w-90 f-l">角色名称：</label>
							<c:if test="${type eq 1}">
								<c:if test="${siteRoleName eq 1}"><input type="text" class="input-text f-l w-210 mr-10 readonly" id="siteRoleName" readonly="readonly" value="信息员" /></c:if>
								<c:if test="${siteRoleName eq 2}"><input type="text" class="input-text f-l w-210 mr-10 readonly" id="siteRoleName" readonly="readonly" value="配件员" /></c:if>
								<c:if test="${siteRoleName eq 3}"><input type="text" class="input-text f-l w-210 mr-10 readonly" id="siteRoleName" readonly="readonly" value="财务人员" /></c:if>
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="addOrEdit" value="3" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="defaultAddOrEdit" value="${siteRoleName}" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="siteRolePermissionId1" value="" />
							</c:if>
							<c:if test="${type eq 2}">
								<input type="text" class="input-text f-l w-210 mr-10" id="siteRoleName" value="${siteRoleName.columns.site_role_name }" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="addOrEdit" value="1" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="defaultAddOrEdit" value="" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="siteRolePermissionId1" value="${siteRoleName.columns.id }" />
							</c:if>
							<c:if test="${type eq 3}">
								<input type="text" class="input-text f-l w-210 mr-10" id="siteRoleName" value="" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="addOrEdit" value="2" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="defaultAddOrEdit" value="" />
								<input type="text" hidden="hidden" class="input-text f-l w-210 mr-10" id="siteRolePermissionId1" value="" />
							</c:if>
							<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEMSGMGM_ROLEPOWER_EDIT_BTN" html='<a href="javascript:saveMenu();" class="sfbtn sfbtn-opt3 w-70 text-c f-l">保存</a>'></sfTags:pagePermission>
						</div>
						<div class="cl mb-10">
							<label class="text-r w-90 f-l">排序：</label>
							<input type="text" class="input-text f-l w-210 mr-10" id="sort" name="sort" value="${sort}" />
						</div>
						<div class="pl-90 pos-r">
							<label class="lb w-90 text-r">角色权限：</label>
							<ul id="treeDemo" class="ztree"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div></div>

<script type="text/javascript">
var setting = {
		check: {
	        enable: true,
	        //chkboxType : { "Y" : "ps", "N" : "ps" }
	        chkboxType : { "Y" : "p", "N" : "s" }
	    },
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid",
				rootPId: 0
			}
		},
		callback: {
			onCheck: zTreeOnCheck
		}
	};

var ztreeNode;
$(function(){
	setBtnPos();
	ztreeNode = $.fn.zTree.init($("#treeDemo"), setting, eval('${nodes}'));
	ztreeNode.expandAll(false);
});

function zTreeOnCheck(event, treeId, treeNode) {
  //  saveMenu();
};

function saveMenu(){
	var addOrEdit = $("#addOrEdit").val();
	var siteRoleName = $("#siteRoleName").val();
	var defaultAddOrEdit = $("#defaultAddOrEdit").val();
	var siteRolePermissionId1 = $("#siteRolePermissionId1").val();
	var sort = $("#sort").val();
	if($.trim(siteRoleName)==null || $.trim(siteRoleName)=="" ){
		$('body').popup({
			level:'3',
			type:1,
			content:"角色名称不能为空！"
		})
	}else{
		var nodes = ztreeNode.getCheckedNodes(true);
		var permissions = "";
		for(var i = 0; i < nodes.length; i++){
			permissions += "," + nodes[i].id;
		}
		$.ajax({
			type: "POST",
			traditional :true,
			url: "${ctx}/operate/siteRolePermission/addSave",
			data:{permissions:permissions,
				siteRoleName:siteRoleName,
				addOrEdit:addOrEdit,
				defaultAddOrEdit:defaultAddOrEdit,
				sort:sort,
				siteRolePermissionId1:siteRolePermissionId1},
			success: function (result) {
				if(result=="1"){
					layer.msg("添加成功！");
					window.location.reload(true);
				}else if(result=="2"){
					layer.msg("修改成功！");
					window.location.reload(true);
				}else{
					$('body').popup({
						level:'3',
						type:1,
						content:"保存失败，请检查！"
					})
				}
			}
		})
	}	
}

$('.btn-del').bind('click',function(){
	var sysRolePermissionId = $(this).parents('li').find("input").val();
	$('body').popup({
		level:'3',
		type:2,
		content:"确定删除该角色?",
		fnConfirm:function(){
			$.ajax({
				type: "POST",
				url: "${ctx}/operate/siteRolePermission/deleteRole",
				data:{sysRolePermissionId:sysRolePermissionId},
				success: function (result) {
					if(result==true){
						layer.msg("删除成功！");
						$(this).parents('li').remove();
						window.location.reload(true);
					}else{
						$('body').popup({
							level:'3',
							type:1,
							content:"删除失败，请检查！"
						})
					}
				}
			})
		}
	})
})

$('.roleList_edit li').hover(function(){
		$(this).addClass('current');
	},function(){
		$(this).removeClass('current');
})

$('.btn-addRole').on('click',function(){
	document.getElementById("siteRoleName").valueOf("");
});

function setBtnPos(){
	var outerBox = $('.namelist'),
		outerH = outerBox.height(),
		innerBox = $('.roleBox'),
		innerH = innerBox.height();
	if( innerH > (outerH-52) ){
		innerBox.height(outerH-60);
		outerBox.addClass('rolePos');
	}
	
}

</script>
</body>
</html>
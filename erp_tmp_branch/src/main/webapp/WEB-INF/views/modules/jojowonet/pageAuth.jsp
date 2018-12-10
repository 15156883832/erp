<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<link rel="stylesheet" href="${ctxPlugin}/lib/zTree/v3/css/demo.css" type="text/css">
<link rel="stylesheet" href="${ctxPlugin}/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery.ztree.excheck-3.5.js"></script>
<title>全部工单</title>

</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">

<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</div>
</div>
</div>

<script type="text/javascript">
var setting = {
		check: {
	        enable: true,
	        chkboxType : { "Y" : "ps", "N" : "ps" }
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

	var zNodes =[
		{ id:1, pId:0, name:"随意勾选 1", open:true},
		{ id:11, pId:1, name:"随意勾选 1-1", open:true},
		{ id:111, pId:11, name:"随意勾选 1-1-1"},
		{ id:112, pId:11, name:"随意勾选 1-1-2"},
		{ id:12, pId:1, name:"随意勾选 1-2", open:true},
		{ id:121, pId:12, name:"随意勾选 1-2-1"},
		{ id:122, pId:12, name:"随意勾选 1-2-2"},
		{ id:2, pId:0, name:"随意勾选 2", checked:true, open:true},
		{ id:21, pId:2, name:"随意勾选 2-1"},
		{ id:22, pId:2, name:"随意勾选 2-2", open:true},
		{ id:221, pId:22, name:"随意勾选 2-2-1", checked:true},
		{ id:222, pId:22, name:"随意勾选 2-2-2"},
		{ id:23, pId:2, name:"随意勾选 2-3"}
	];
var ztreeNode;
$(function(){
	ztreeNode = $.fn.zTree.init($("#treeDemo"), setting, eval('${nodes}'));
	ztreeNode.expandAll(true);
});

function zTreeOnCheck(event, treeId, treeNode) {
    saveMenu();
};

function saveMenu(){
	var nodes = ztreeNode.getCheckedNodes(true);
}
</script>
</body>
</html>
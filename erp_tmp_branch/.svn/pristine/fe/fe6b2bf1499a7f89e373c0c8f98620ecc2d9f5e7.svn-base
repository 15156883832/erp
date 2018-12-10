<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="base" />
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>H-ui.admin v3.0</title>
<meta name="keywords"
	content="H-ui.admin v3.0,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description"
	content="H-ui.admin v3.0，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
	<div style="text-align: center; ">
		<font size="10">welcome base!</font>
		<table id="grid-table" style="width: 1000px;"></table>
		<div id="grid-pager"></div>
	</div>
	<script type="text/javascript">
		function testSort(obj, st){
			var stArr = st.split(",");
			var stLen = stArr.length;
			var len = obj.length;
			var dest = [];
			for(var j = 0; j < stLen; j++){
				var stVal = stArr[j];
				for(var i = j; i < len; i++){
					var item = obj[i];
					if(item.frozen){
						dest.push(item);
						continue;
					}else if(item.index.indexOf(stVal) != -1){
						dest.push(item);
						continue;
					}
				}
			}
			return dest;
		}
	
		var header = eval('${headerData.tableHeader}');
		$(function() {
			$("#grid-table").sfGrid({
				url : '${ctx}/operate/site/ajaxList',
				colModel : testSort(header, '${headerData.sortHeader}')
			});
		});
		function fmtDate(rowId, cellval , colpos){
			if(rowId){
				return $.dateUtils.formatDate(rowId.time);	
			}
			return "";
		}
	</script>
</body>
</html>
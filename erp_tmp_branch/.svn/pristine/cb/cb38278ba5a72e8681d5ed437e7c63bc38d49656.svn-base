<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
    <title>wangEditor 菜单和编辑器区域分离</title>
    <style type="text/css">
        .toolbar {
            border: 1px solid #ccc;
        }
        .text {
            border: 1px solid #ccc;
            height: 600px;
        }
        .w-e-text-container{
            height:600px;
        }
    </style>
</head>
<body>
   <div id="div1">
    <p>欢迎使用富文本编辑器</p>
    </div>
<a href="javascript:getHtml();">GetHtml</a>
<script type="text/javascript" src="${ctxPlugin }/lib/sfEditor/wangEditor.js"></script>
<script type="text/javascript">
    var E = window.wangEditor
    var editor = new E('#div1')

    // 下面两个配置，使用其中一个即可显示“上传图片”的tab。但是两者不要同时使用！！！
    editor.customConfig.uploadImgShowBase64 = true   // 使用 base64 保存图片
    //editor.customConfig.uploadImgServer = '${ctx}/common/uploadFile';  // 上传图片到服务器
	editor.customConfig.previewUrl = '${ctx}/main/redirect/goodsPreview?id=402882165d07902b015d0796f73a0000';
	editor.customConfig.priviewHtmlSavePath = '${ctx}/main/redirect/saveGoodsPreview?id=402882165d07902b015d0796f73a0000';
	editor.customConfig.uploadImgHooks;
	
	editor.customConfig = {
		//"uploadImgServer": "${ctx}/common/uploadFile",
		"previewUrl": "${ctx}/main/redirect/goodsPreview?id=402882165d07902b015d0796f73a0000",
		"priviewHtmlSavePath": "${ctx}/main/redirect/saveGoodsPreview?id=402882165d07902b015d0796f73a0000",
		"uploadImgHooks": {
			before: function before(xhr, editor, files) {
	            // 图片上传之前触发
	        },
	        success: function success(xhr, editor, result) {
	            // 图片上传并返回结果，图片插入成功之后触发
	        },
	        fail: function fail(xhr, editor, result) {
	            // 图片上传并返回结果，但图片插入错误时触发
	        },
	        error: function error(xhr, editor) {
	            // 图片上传出错时触发
	        },
	        timeout: function timeout(xhr, editor) {
	            // 图片上传超时时触发
	        }
		}
	}
	
    editor.create();

    function getHtml(){
      //  console.log(editor.txt.html());
    }
</script>

</body>
</html>
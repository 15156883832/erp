<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<style type="text/css">
img{
	width:100%;
	height:auto;
}
p{
	font-size:36px;
}
</style>
</head>
<body onload="adjustImg();">
${htmlContent}
<script type="text/javascript">
    function adjustImg(){
        var imgs = document.getElementsByTagName("img");
        for(var i = 0; i < imgs.length; i++){
            var img = imgs[i];
            img.setAttribute("style", "width:100%;heigth:auto;");
            img.parentNode.setAttribute("style", "padding:0;margin:0");
        }
    }
</script>
</body>
</html>
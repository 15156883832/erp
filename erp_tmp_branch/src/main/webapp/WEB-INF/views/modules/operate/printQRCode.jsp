<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctxPlugin" value="${pageContext.request.contextPath}/plug-in"/>
<html>
<head>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/printQRCode.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/zTree/v3/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery-migrate-1.4.1.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.jqprint-0.3.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
    <script type="text/javascript">
        var str = '${relist}';
        var siteId = '${siteId}';
        function printOrder() {
            document.getElementById("btn").style.display = "none";
            $(".obox").jqprint({
                debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
                importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
                printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
                operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
            });
        }

        window.onload = function () {
            var strs = str.split(",");
            for (var i = 0; i < strs.length; i++) {
                var url = "http://www.sifangerp.com/wxweb/toScan?sid=" + siteId + "&xcode=" + strs[i];
                $("#qrcode").empty().qrcode({
                    render: "canvas",
                    ecLevel: 'H',
                    width: 97,
                    height: 97,
                    text: url
                });
                var myImage = document.getElementById('logo${logo}');

                $("canvas").attr("id", "erw");
                var canvas = document.getElementById('erw');
                var context = canvas.getContext('2d');
                context.drawImage(myImage, 31.5, 31.5, 34, 34);
                context.lineWidth = 5;
                context.strokeStyle = '#ffffff';
                context.stroke();

                var image = new Image();
                document.getElementById('myImg' + i).src = canvas.toDataURL("image/png");
            }
            $(".imgBox").removeAttr("style");
        }
    </script>
</head>
<body>
<div style="display: none">
    <img src="${ctxPlugin}/static/h-ui.admin/images/sifangTel.png" id="logo1">
    <img src="${ctxPlugin}/static/h-ui.admin/images/serviceManager.png" id="logo2">
</div>
<div id="qrcode" style="display: none"></div>

<c:forEach begin="0" end="${pageSize-1}" varStatus="stat">
    <div class="obox" style="width:680px;overflow:auto;  margin: -4px auto 0; padding-left:4px">
        <c:forEach begin="${stat.index*54}" end="${stat.index*54+53}" varStatus="status">
            <div class="imgBox" style="display: none">
                <img src="" class="img" id="myImg${status.index}"/>
            </div>
        </c:forEach>
    </div>
</c:forEach>
<input type="button" value="打印" id="btn" onclick="printOrder();" class="btn-print"
       style="width:100px;display:block;margin:10px auto;height:30px; line-height:30px;"/>
</body>
</html>
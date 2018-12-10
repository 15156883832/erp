<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base"/>
    <title>进入奥莱</title>
</head>
<body>

<div class="shadeBg" style="z-index:9999;"></div>
<div class="goAolai" style="height: 528px;">
    <a href="javascript:;" class="sficon sficon-close_white btnClose"></a>
    <div class="vipInfoBox">
        <div class="cl mb-20">
            <div class="f-l col-6 text-c">
                <img src="${ctxPlugin}/static/h-ui.admin/images/bg_goaolai_step1.png" />
            </div>
            <div class="f-l col-6 text-c">
                <img src="${ctxPlugin}/static/h-ui.admin/images/bg_goaolai_step1.png" />
            </div>
            <div class="f-l"></div>
        </div>
        <div class="text-c">
            <a href="javascript:;" class="btnGoAl"></a>
        </div>
    </div>
</div>

<script src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    $(function(){
            openAolai();
            $(".btnGoAl").on('click', function() {
            var topWin = window.top;
            closeBox();
            topWin.jumpToMenuItem("商品管理", "奥莱家电");
           });
    });

    function openAolai(){
        $('#Hui-article-box',window.top.document).css({'z-index':'1999'});
        $.setPos($('.goAolai'));
    }

    $('.btnClose').on('click', closeBox);

    function closeBox() {
        $('#Hui-article-box',window.top.document).css({'z-index':'9'});
        $("div.loadBg", window.top.document).remove();
        window.top.layer.closeAll();
    }
</script>
</body>
</html>
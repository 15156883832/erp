<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctxPlugin}/lib/html5shiv.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />

    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />

    <!--[if IE 6]>
    <script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <meta name="decorator" content="base" />
    <title>净水器-商品详情</title>
</head>
<body>
<!--  -->
<div class="popupBox protoDetailWrap" style="width:812px">
    <h2 class="popupHead">
        商品详情
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <div class="popupMain pt-15 pl-15">
            <div class="pcontent">
                <div class="">
                    <div class="cl mb-10">
                        <div class="f-l spimgWrap">
                            <div class=" f-l  readonly">
                                <img src="${commonStaticImgPath}${platform.columns.icon}" id="img-view" />
                                <input type="hidden" name="icon" value="${platform.columns.icon}" id="img-input">
                            </div>
                        </div>
                        <div class="f-l protoInfoWrap2">
                            <h3 class="title">${platform.columns.name} </h3>
                            <div class="cl bg-fff9f5 pt-10 pb-10 pl-10 lh-24 ">
                                <div class="f-l w-250">
                                    <span class="c-666">官方指导价：</span><span class="c-fd6e32 f-16">￥2979.00</span>
                                </div>
                                <span class="c-666">建议零售：</span><span class="c-fd6e32 f-16">￥2198.00</span>
                            </div>
                            <div class="cl bg-fff2e8 pt-10 pb-10 pl-10 lh-24">
                                <span class="c-666">促销奖励金：</span><strong class="c-fd6e32 f-20">￥1000.00</strong>
                            </div>
                            <div class="cl pt-5 pb-5 pl-10 lh-24">
                                <div class="f-l w-250">
                                    <span class="c-666">商品编号：</span><span>${platform.columns.number }</span>
                                </div>
                                <div class="f-l">
                                    <span class="c-666">商品类别：</span><span>${platform.columns.category}</span>
                                </div>
                            </div>
                            <div class="cl pt-5 pb-5 pl-10 lh-24">
                                <div class="f-l w-250">
                                    <span class="c-666">商品品牌：</span><span>${platform.columns.brand }</span>
                                </div>
                                <div class="f-l">
                                    <span class="c-666">商品单位：</span><span>${platform.columns.unit }</span>
                                </div>
                            </div>
                            <div class="cl pt-5 pb-5 pl-10 lh-24">
                                <div class="f-l w-250">
                                    <span class="c-666">商品型号：</span><span>${platform.columns.model }</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h3 class="sptitle2">商品介绍</h3>
                    <div class="text-c mt-10" style="max-height: 320px; overflow: auto;">
                        ${platform.columns.html}
                    </div>
                </div>
            </div>
        </div>
        <div class="text-c btbWrap">
            <a href="javascript:showBuy('${platform.columns.id }');" class="btn_buyPrototype" id="btn_buyPrototype">购买</a>
        </div>
    </div>
</div>


<!--_footer 作为公共模版分离出去-->
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery.jqGrid.src.revised.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    $(function(){
        $('.protoDetailWrap').popup();
    })

  /*  $('#btn_buyPrototype').on('click', function(){
        $('.paywayWrap').popup({level:2});
    })*/

    $('.paywayWrap .vipPrice').on('click', function(){
        $('.paywayWrap .vipPrice').removeClass('vipCur');
        $(this).addClass('vipCur');
    })

    //购买
    function showBuy(id){
        layer.open({
            type : 2,
            content:'${ctx}/goods/sitePlatformGoods/showBuyCOP?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }

</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base"/>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="${ctxPlugin}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>商品详情</title>
</head>
<body class="">
<div class="sfpagebg bk-gray">
    <div class="pt-25 pb-25 pl-20 pr-20">
        <div class="goodsDetail">
            <div class="cl mb-20">
                <div class="f-l w-480">
                    <div class="f-l mr-15 commodityImgWrap" id="commodityImgWrap">
                        <!--<img src="static/h-ui.admin/images/sp_img1.png" id="commodityImg" />-->
                    </div>
                    <div class="commodityImgListWrap f-l" id="commodityImgListWrap">
                        <a class="btn_com btn_comPrev" id="btn_comPrev"> </a>
                        <a class="btn_com btn_comNext" id="btn_comNext"></a>
                        <div class="commodityImgList">
                            <ul id="adlist">
                                <li class="">
                                    <img src="${ctxPlugin}/static/h-ui.admin/images/goodsImgs/TPDetailImgs/theme1.jpg" />
                                </li>
                                <li>
                                    <img src="${ctxPlugin}/static/h-ui.admin/images/goodsImgs/TPDetailImgs/theme2.jpg" />
                                </li>
                                <li>
                                    <img src="${ctxPlugin}/static/h-ui.admin/images/goodsImgs/TPDetailImgs/theme3.jpg" />
                                </li>
                                <li>
                                    <img src="${ctxPlugin}/static/h-ui.admin/images/goodsImgs/TPDetailImgs/theme4.jpg" />
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="f-l">
                    <h3 class="goodsName">
                        ${platform.columns.name}(质保一年)
                    </h3>
                    <div class="goodsPrice mb-15 cl">
                        <div class="f-l col-3-1">
                            <span class="f-13">普通会员价：</span><strong class="c-fd6e32 f-18">￥${platform.columns.no_vip_price}</strong>
                        </div>
                        <div class="f-l col-3-1">
                            <span class="f-13">VIP会员价：</span><strong class="c-fd6e32 f-18">￥${platform.columns.site_price}</strong>
                        </div>
                    </div>
                    <p class="lh-20 f-14 mb-15 w-640 c-888"></p>
                    <a class="btn_buyGoods radius" href="javascript:showBuy('${platform.columns.id}');">立即购买</a>
                </div>
            </div>

            <div class="producttitle mb-25">
					<span class="producttitle_1">
						<span class="f-16">商品介绍 </span>
						<span class="f-16 c-888">/</span>
						<span class="c-888">Product Introduction</span>
					</span>
            </div>
            <div class="text-c goodsImgsMain">
                <img src="${ctxPlugin}/static/h-ui.admin/images/goodsImgs/TPDetailImgs/detail_01.jpg"/>
                <img src="${ctxPlugin}/static/h-ui.admin/images/goodsImgs/TPDetailImgs/detail_02.jpg" />
            </div>
        </div>
    </div>
</div>


<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="static/h-ui.admin/js/jquery.jqGrid.src.revised.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/easyui-revised.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/carousel.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(function(){
        $('#commodityImgListWrap').carousel();

    })

    $('#btn_goTop').on('click', function(){
        $(".sfpagebg").animate({ scrollTop: 0 }, 520);
    })


    //购买
    function showBuy(id){
        layer.open({
            type : 2,
            content:'${ctx}/goods/sitePlatformGoods/showBuy?id='+id,
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
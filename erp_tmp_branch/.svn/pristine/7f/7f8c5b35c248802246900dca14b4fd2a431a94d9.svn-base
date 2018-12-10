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
                                <c:forEach items="${images}" var="image">
                                    <c:if test="${not empty image}">
                                        <li class="">
                                            <img src="${commonStaticImgPath}${image}"/>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="f-l">
                    <h3 class="goodsName">
                        ${platform.columns.name}
                    </h3>
                    <div class="goodsPrice mb-15 cl">
                        <div class="f-l col-3-1">
                            <span class="f-13">商品价格：</span><strong class="c-fd6e32 f-18">￥${platform.columns.no_vip_price}</strong>
                        </div>
                     <%--   <div class="f-l col-3-1">
                            <span class="f-13">VIP会员价：</span><strong class="c-fd6e32 f-18">￥${platform.columns.site_price}</strong>
                        </div>--%>
                        <div class="f-l col-3-1">
                            <span class="f-13">建议零售价：</span><strong class="c-fd6e32 f-18">￥${platform.columns.advice_price}</strong>
                        </div>
                    </div>
                    <p class="lh-20 f-14 mb-15 w-640 c-888">${platform.columns.description}</p>
                    <p class="lh-20 f-14 mb-15 w-640 c-888">
                        <c:if test="${platform.columns.tmall_seller_link!='' && platform.columns.tmall_seller_link!=null }">
                            <a href="${platform.columns.tmall_seller_link }" target="_blank"  class="underline c-0e8ee7 mr-20 icon_TM">天猫比价</a>
                        </c:if>
                        <c:if test="${platform.columns.jd_seller_link!='' && platform.columns.jd_seller_link!=null }">
                            <a href="${platform.columns.jd_seller_link }" target="_blank"  class="underline c-0e8ee7 mr-20 icon_JD">京东比价</a>
                        </c:if>
                    </p>
                    <a class="btn_buyGoods radius" onclick="showBuy('${platform.columns.id}','${platform.columns.name}')">立即购买</a>
                </div>
            </div>

            <div class="producttitle mb-25">
					<span class="producttitle_1">
						<span class="f-16">商品介绍 </span>
						<span class="f-16 c-888">/</span>
						<span class="c-888">Product Introduction</span>
					</span>
            </div>
            <div class="" style="width: 1000px; margin: 0 auto 25px;" >
                <table class="table table-border table-bordered productParameters">
                    <tr>
                        <th>商品编号</th>
                        <td>${platform.columns.number}</td>
                        <th>商品名称</th>
                        <td>${platform.columns.name}</td>
                    </tr>
                    <tr>
                        <th>商品品牌</th>
                        <td>${platform.columns.brand}</td>
                        <th>商品型号</th>
                        <td>${platform.columns.model}</td>
                    </tr>
                    <tr>
                        <th>商品类别</th>
                        <td>${platform.columns.category}</td>
                        <th>序号</th>
                        <td>${platform.columns.sort_num}</td>
                    </tr>
                </table>
            </div>
            <div class="text-c goodsImgsMain">
                ${platform.columns.html}
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

    function showBuy(id,name){
        var bStop = false;
        var bStopIndex = 1;
        var show_navLi = $('#min_title_list li',window.top.document);
        show_navLi.each(function () {
            $(this).removeClass('active');
            if ($(this).find('span').text() == name) {
                bStopIndex = show_navLi.index($(this));
                bStop = true;
            }
        });
        if (!bStop) {
            creatIframe('${ctx}/goods/sitePlatformGoods/showBuyDetergentDetail?id='+id,name);
        } else {
            show_navLi.eq(bStopIndex).addClass('active');
            $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).show().find('iframe').attr({'src': '${ctx}/goods/sitePlatformGoods/showBuyDetergentDetail?id='+id,});

        }
    }
</script>
</body>
</html>
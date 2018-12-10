<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

    <meta name="decorator" content="base"/>
</head>
<body class="">
<div class="sfpagebg bk-gray"><div class="sfpage">
    <div class="page-orderWait f-13">
        <div class="tabBar cl mb-10">
            <sfTags:pagePermission authFlag="SITESETTLE_FAPIAOAPPLYSET_FAPIAOAPPLY_TAB" html='<a class="btn-tabBar current" href="${ctx}/finance/invoiceMsg/invoiceManager">发票申请</a>'></sfTags:pagePermission>
            <sfTags:pagePermission authFlag="SITESETTLE_FAPIAOAPPLYSET_FAPIAOAPPLYRECORD_TAB" html='<a class="btn-tabBar  " href="${ctx}/finance/invoiceApplication/record">发票申请记录</a>'></sfTags:pagePermission>
        </div>
        <div class="receiptFlowWrap mt-20">
            <span class="receiptLb">发票申请流程</span>
            <div class="cl receiptFlow" >
                <div class="f-l w-160 text-c">
                    <p class="lh-20 mb-10">维护信息</p>
                    <span class="flowStep">1</span>
                </div>
                <div class="f-l w-420 text-c">
                    <p class="lh-20 mb-10">选择开票订单</p>
                    <span class="flowStep">2</span>
                </div>
                <div class="f-l w-160 text-c">
                    <p class="lh-20 mb-10">申请发票</p>
                    <span class="flowStep">3</span>
                </div>
            </div>
            <div class="mt-10">
                <c:choose>
                    <c:when test="${empty invoiceMsg.columns.id}">
                        <a class="btn_recep ml-10 insertinvoice"><i class="sficon sficon-edit "></i> 维护发票信息</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn_recep ml-10 insertinvoice"><i class="sficon sficon-edit "></i> 修改发票信息</a>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${empty invoiceAddress.columns.id}">
                        <a class="btn_recep ml-5 insertaddress"><i class="sficon sficon-edit "></i> 发票寄送地址</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn_recep ml-5 insertaddress"><i class="sficon sficon-edit "></i> 修改寄送地址</a>
                    </c:otherwise>
                </c:choose>

                <!--<a class="btn_recep ml-10"><i class="sficon sficon-edit"></i> 修改发票信息</a>
                <a class="btn_recep ml-5"><i class="sficon sficon-edit"></i> 修改寄送地址</a>-->
            </div>
        </div>
    </div>
</div></div>




<!--_footer 作为公共模版分离出去-->
<script src="static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script src="static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    $(function(){
        if($(".insertinvoice").text()==" 维护发票信息"||$(".insertaddress").text()==" 发票寄送地址"){
           $(".receiptFlow").addClass("receiptFlow_maintain");
        }else{
            $(".receiptFlow").removeClass("receiptFlow_maintain");
        }
//		$('.maintainReceipt').popup();
//		$('.receiptAddress').popup();
//		$('.receiptWarn').popup();
       // $('.receiptInfoWrap').popup();
        tableHeight();
    })
    window.onresize = function(){
        tableHeight();
    }
    function tableHeight(){
        var tHeight = $('.sfpagebg').height()-290;
        $('.table_reWrap').css({
            'max-height':tHeight+'px',
            'overflow':'auto',
        })
    }




/*    $('#tableRe').on('click','.selectWrap', function(){
        var hasClass = $(this).find('.label-cbox3').hasClass('label-cbox3-selected');
        var isSelectAll = $(this).parent('tr').parent().is('thead');
        if(hasClass){
            if(isSelectAll){
                $('#tableRe .selectWrap').find('.label-cbox3').removeClass('label-cbox3-selected');
                $('#tableRe .selectWrap').find('input').prop({'checked':'false'});

            }else{
                $(this).find('.label-cbox3').removeClass('label-cbox3-selected');
                $(this).find('input').prop({'checked':'false'});
            }
        }else{
            if(isSelectAll){
                $('#tableRe .selectWrap').find('.label-cbox3').addClass('label-cbox3-selected');
                $('#tableRe .selectWrap').find('input').prop({'checked':'true'});
            }else{
                $(this).find('.label-cbox3').addClass('label-cbox3-selected');
                $(this).find('input').prop({'checked':'true'});
            }
        }
    })*/


$(".insertinvoice").on('click',function(){
        layer.open({
            type : 2,
            content:'${ctx}/finance/invoiceMsg/toform',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    })

    $(".insertaddress").on('click',function(){
        layer.open({
            type : 2,
            content:'${ctx}/finance/invoiceMsg/tofromAddress',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    })


</script>
</body>
</html>
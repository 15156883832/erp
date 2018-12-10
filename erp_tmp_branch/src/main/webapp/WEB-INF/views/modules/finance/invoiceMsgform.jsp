<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

    <style type="text/css">
        .webuploader-pick{
            background:none;
            color:#22a0e6;
            width:80px;
            padding:0;
            height:80px;
        }
        .webuploader-pick img{
            width:100px;
            height:100px;
            position:absolute;
            left:0;
            top:0;
        }
    </style>

</head>
<body>
<!-- 维护发票信息 -->
<div class="popupBox w-600  maintainReceipt">
    <h2 class="popupHead">
        维护发票信息
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <form id="invoicemsgform">
    <div class="popupContainer pb-50">
        <div class="popupMain pt-25">
            <div class="cl mb-10">
                <label class="f-l w-180 text-r f-13"><em class="mark">*</em>开票类型：</label>
                <div class="f-l receiptType">
                    <span class="radiobox w-130 radiobox0"><input type="radio"  id="geren" name="type1" />个人 </span>
                    <span class="radiobox w-130 radiobox1" data-type="receipt_ent"><input type="radio" id="qiye" name="type1"/>企业 </span>
                    <input type="hidden" name="MakeIvtype" id="MakeIvtype">
                </div>
            </div>
            <div class="cl mb-10">
                <label class="f-l w-180 text-r f-13"><em class="mark">*</em>发票抬头：</label>
                <input type="text" class="input-text f-l w-320" placeholder="请填写发票抬头的个人信息" name="invoiceTitle" id="invoiceTitle" value="${invoiceMsg.columns.invoice_title}" datatype="*" nullmsg="请填写发票抬头"  />
            </div>
            <div class="cl mb-10">
                <label class="f-l w-180 text-r f-13"><em class="mark">*</em>发票类型：</label>
                <div class="f-l ">
                    <span class="radiobox w-130 radioboxp"><input type="radio"  id="putong" name="type2" />增值税普通发票 </span>
                    <span class="radiobox w-130 radioboxz"><input type="radio"  id="zhuanyongs" name="type2" />增值税专用发票 </span>
                    <input type="hidden" name="invoiceType" id="invoiceType">
                </div>
            </div>

            <div class="uploadIcon hide">
                <div class="cl mb-10">
                    <label style="margin-left: 105px" class=" text-c f-13"><em class="mark">*</em>请上传增值税一般纳税人资格登记表</label>
                </div>
                <div class="cl mb-10">
                    <div class="f-l" style="margin-left: 150px">
                        <div class="imgWrap1 f-l  mr-15 hide" id="img">
                            <div class="imgWrap ">
                                <a class="sficon btn-delimg"  onclick="deleteImg()"></a>
                                <img  class="img" src="${commonStaticImgPath}${invoiceMsg.columns.icon}" id="${commonStaticImgPath}${invoiceMsg.columns.icon}" />
                            </div>
                        </div>

                        <div class="imgWrap1 f-l  mr-15" id="Imgprocess">
                            <div class="imgWrap" id="imgsAdd">
                                <a class="btn-upload bk_dashed hide"></a>
                            </div>
                        </div>
                        <input type="hidden" name="icon" value="${invoiceMsg.columns.icon}">
                    </div>
                    <span class="c-888 f-12 ml-10 mt-50 pt-10" style="margin-left: -10px">提示：导入的图片需要盖有办税服务厅业务专用章</span>
                </div>
            </div>

            <div id="enterpriceInfo" class="hide">
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>税务登记证号：</label>
                    <input type="text" class="input-text f-l w-320" name="taxRegistrationNumber" id="taxRegistrationNumber" value="${invoiceMsg.columns.tax_registration_number}" datatype="*" nullmsg="请填写税务登记证号"  />
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>企业地址：</label>
                    <input type="text" class="input-text f-l w-320" placeholder="请填写营业执照上的企业注册地址" name="address" id="address" value="${invoiceMsg.columns.address}" datatype="*" nullmsg="请填写企业地址" />
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>联系电话：</label>
                    <input type="text" class="input-text f-l w-320" placeholder="请填写营业执照上的企业联系电话" name="mobile" id="mobile" value="${invoiceMsg.columns.mobile}" datatype="mobiles" nullmsg="请填写联系电话" errormsg="请填写真实的手机号"/>
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>基本开户银行：</label>
                    <input type="text" class="input-text f-l w-320" name="bankOfDeposit" id="bankOfDeposit" value="${invoiceMsg.columns.bank_of_deposit}" datatype="*" nullmsg="请填写基本开户银行" />
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-180 text-r f-13"><em class="mark">*</em>基本开户账号：</label>
                    <input type="text" class="input-text f-l w-320"  name="openAccount" id="openAccount" value="${invoiceMsg.columns.open_account}" datatype="*" nullmsg="请填写基本开户账号"/>
                </div>
            </div>
        </div>
        <div class="text-c btbWrap">
            <a href="javascript:;" id="subBtn" class="sfbtn sfbtn-opt3">保存</a>
            <a href="javascript:;" class="sfbtn sfbtn-opt" onclick="quxiaomsg()">取消</a>
        </div>
    </div>
    </form>
</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script>
    $(function () {
        if('${invoiceMsg.columns.make_ivtype}' == "1"){
           // $("input[name='type1']:eq(1)").attr("checked",'checked');
            $(".radiobox1").addClass('radiobox-selected');
            $("#qiye").attr("checked",true);
            $('#enterpriceInfo').show();
        } else {
            //$("input[name='type1']:eq(0)").attr("checked",'checked');
            $(".radiobox0").addClass('radiobox-selected');
            $("#geren").attr("checked",true);
            $('#enterpriceInfo').hide();
        }

        if('${invoiceMsg.columns.invoice_type}' == "1"){
            $(".radioboxz").addClass('radiobox-selected');
            $("#zhuanyongs").attr("checked",true);

            $(".uploadIcon").removeClass("hide");

            if(isBlank('${invoiceMsg.columns.icon}')){
                $("#Imgprocess").removeClass("hide");
                $("#img").addClass("hide");
            }else{
                $("#Imgprocess").addClass("hide");
                $("#img").removeClass("hide");
            }
        } else {
            $(".radioboxp").addClass('radiobox-selected');
            $("#putong").attr("checked",true);

            $(".uploadIcon").addClass("hide");
            if(isBlank('${invoiceMsg.columns.icon}')){
                $("#Imgprocess").removeClass("hide");
                $("#img").addClass("hide");
            }else{
                $("#Imgprocess").addClass("hide");
                $("#img").removeClass("hide");
            }
        }

        $('.maintainReceipt').popup();
        $('#invoicemsgform').Validform({
            btnSubmit: "#subBtn",
            ignoreHidden:true,
            beforeCheck: function (curform) {

            },
            tiptype: function (msg, o, cssctl) {
                if (msg) {
                    layer.msg(msg);
                }
            },
            beforeSubmit:function(curform){
               if($("#qiye").attr("checked")){
                   $("#MakeIvtype").val("1");
               }else{
                   $("#MakeIvtype").val("0");
                   $("#taxRegistrationNumber").val("");
                   $("#address").val("");
                   $("#mobile").val("");
                   $("#bankOfDeposit").val("");
                   $("#openAccount").val("");
               }
                if($("#zhuanyongs").attr("checked")){
                    $("#invoiceType").val("1");
                }else{
                    $("#invoiceType").val("0");
                }

                var invoiceType=$("#invoiceType").val();
               if(invoiceType=='1'){
                    var icon=$("input[name='icon']").val();
                    if(isBlank(icon)){
                        layer.msg("请上传一般纳税人资格登记图片");
                        return false;
                    }
               }

            },
            postonce: true,
            datatype: {
                "mobiles":/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/
            },
            callback: function (form) {
                $.ajax({
                    url: "${ctx}/finance/invoiceMsg/saveinvoiceMsg",
                    type: "POST",
                    data: $("#invoicemsgform").serialize(),
                    success: function (data) {
                        if (data == "saveok") {
                            parent.layer.msg("保存成功");
                            parent.window.location.reload(true);
                            $.closeDiv($('.maintainReceipt'));
                        } else if(data == "updateok"){
                            parent.layer.msg("修改成功");
                            parent.window.location.reload(true);
                            $.closeDiv($('.maintainReceipt'));
                        }else{
                            layer.msg(data);
                        }
                    }
                });
                return false;
            }
        });

        createUploader("#imgsAdd","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");
    });

    function createUploader(picker,site, el,id,delimg) {
        var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档
        var thumbnailHeight = 130;
        uploader = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: true,
            swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
            server: '${ctx}/common/uploadFile',
            duplicate:true,
            fileSingleSizeLimit:1024*1024*5,
            pick: picker,
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
            },
            method:'POST'
        });
        uploader.on("error",function (type){
            if (type=="Q_TYPE_DENIED"){
                layer.msg("请上传JPG、PNG格式文件");
            }else if(type=="F_EXCEED_SIZE"){
                layer.msg("文件大小不能超过5M"); }
        });

        uploader.on('beforeFileQueued', function(file){
        });
        uploader.on( 'uploadSuccess', function( file, response ) {
            $("input[name='icon']").val(response.path);
        });
        uploader.on( 'uploadError', function( file, reason ) {

        });
        uploader.on( 'uploadFinished', function() {
            if(uploader){
                uploader.reset();
            }
        });

        uploader.on( 'fileQueued', function( file ) {
            uploader.makeThumb( file, function( error, src ) {
                if (error) {
                    layer.msg('不能预览');
                }else{
                    $(".img").attr("src",src);
                    $("#img").removeClass("hide");
                    $("#Imgprocess").addClass("hide");
                }
            }, thumbnailWidth, thumbnailHeight );
        });

    }

    function deleteImg(){
        $(".img").attr("src","");
        $("#img").addClass("hide");
        $("#Imgprocess").removeClass("hide");
        $("input[name='icon']").val("");
    }

    $('.receiptType .radiobox').on('click', function(){
        if($(this).attr('data-type') == 'receipt_ent' ){
            $("#invoiceTitle").attr('placeholder',"请填写营业执照上的企业名称");
            $('#enterpriceInfo').show();
        }else{
            $("#invoiceTitle").attr('placeholder',"请填写发票抬头的个人信息");
            $('#enterpriceInfo').hide();
        }
        $.setPos($('.maintainReceipt'));
    });

    $('.maintainReceipt').on('click', '.radiobox' ,function(){
        var oP = $(this).closest('div');
        var id=$(this).find("input").attr("id");
        var hasClass = $(this).hasClass('radiobox-selected');
        if( !hasClass ){
            oP.find('.radiobox').removeClass('radiobox-selected');
            oP.find('.radiobox input').prop({'checked':'false'});
            $(this).addClass('radiobox-selected');
            $(this).find('input').prop({'checked':'true'});
        }

        if($.trim(id)=='putong'){
            $(".uploadIcon").addClass("hide");
        }else if($.trim(id)=='zhuanyongs'){
            $(".uploadIcon").removeClass("hide");

            if($("#geren").attr("checked")){
                $(".uploadIcon").addClass("hide");
                $("#putong").parent("span").addClass('radiobox-selected');
                $("#putong").attr("checked");

                $("#zhuanyongs").parent("span").removeClass('radiobox-selected');
                $("#zhuanyongs").removeAttr("checked");
            }

        }
        if($.trim(id)=='geren'){
            $(".uploadIcon").addClass("hide");

            $("#putong").parent("span").addClass('radiobox-selected');
            $("#putong").attr("checked");

            $("#zhuanyongs").parent("span").removeClass('radiobox-selected');
            $("#zhuanyongs").removeAttr("checked");

        }else if($.trim(id)=='qiye'){
            if($("#zhuanyongs").attr("checked")){
                $(".uploadIcon").removeClass("hide");
            }else{
                $(".uploadIcon").addClass("hide");
            }
        }
    })

    function quxiaomsg(){
        $.closeDiv($(".maintainReceipt"));
    }

    function isBlank(val) {
        if (val == null || $.trim(val) == '' || val == undefined) {
            return true;
        }
        return false;
    }

    $('#img').imgShow();
</script>
</body>
</html>
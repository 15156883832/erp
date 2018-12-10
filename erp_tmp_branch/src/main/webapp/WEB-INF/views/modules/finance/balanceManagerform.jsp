<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta name="decorator" content="base"/>
    <title>添加票据</title>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
    <script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <style>
        .ticketAdd .dropdown-clear-all{ line-height: 24px;}
        .dropdown-display{font-size: 12px}
        .dropdown-selected{margin-top: 4px}
.webuploader-pick{
    padding:0;
}
    </style>
</head>
<body>
<div class="popupBox ticketAdd">
    <h2 class="popupHead">
        添加票据
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <form id="addbalanceform">
            <input type="hidden" id="siteId" name="siteId" value="${siteId}">
            <div class="popupMain pt-15 pb-15 pr-20" >
                <div class="cl mb-10">
                    <label class="w-100 text-r f-l"><em class="mark">*</em>费用科目：</label>
                    <span class="w-170 f-l dropdown-sin-2 addspan">
                         <select class="select-box w-120 "  id="exacctName"  placeholder="请选择"  multiline="true" name="exacctName" datatype="*" nullmsg="请选择费用科目"   >
                        <c:forEach items="${exacctlist}" var="exa">
                            <option value="${exa.columns.id }">${exa.columns.name }</option>
                        </c:forEach>
                        </select>
                    </span>
                    <label class="w-110 text-r f-l"><em class="mark">*</em>费用类型：</label>
                    <select class="select w-170  f-l" name="cost_type" datatype="*" id="cost_type" nullmsg="请选择费用类型">
                        <option value="">请选择</option>
                        <option value="0">收入</option>
                        <option value="1">支出</option>
                        <option value="2">欠款</option>
                    </select>
                </div>
                <div class="cl mb-10">
                    <label class="w-100 text-r f-l"><em class="mark">*</em>费用总额：</label>
                    <div class="priceWrap w-170 f-l">
                        <input type="text" class="input-text" name="cost_total" id="cost_total" datatype="price"  errormsg="实收总额格式不正确（至多两位小数）" nullmsg="请填写费用总额" >
                        <span class="unit">元</span>
                    </div>
                    <label class="w-110 text-r f-l">票据信息：</label>
                    <select class="select w-80  f-l" name="bill_type" id="bill_type">
                        <option value="" selected="selected">请选择</option>
                        <option value="0" >收据</option>
                        <option value="1" >发票</option>
                    </select>
                    <div class="priceWrap w-80 f-l ml-10">
                        <input type="text" class="input-text" name="bill_amount" id="bill_amount" datatype="pages" errormsg="请输入正整数">
                        <span class="unit">张</span>
                    </div>
                </div>
                <div class="cl mb-10">
                    <label class="w-100 text-r f-l">详细内容：</label>
                    <textarea class="textarea h-50 f-l" style="width: 450px;" name="detail_content" id="detail_content" ></textarea>
                </div>
        
                <div class="cl mb-10">
                    <label class="w-100 text-r f-l"><em class="mark">*</em>费用发生人：</label>
                    <span class="w-170 f-l dropdown-sin-2 addspan2">
                        <select class="select"  id="createName"   placeholder="请选择" multiline="true" name="createName" datatype="*" nullmsg="请选择费用发生人"   >
                            <c:forEach items="${sitealllist}" var="site">
                                <option value="${site.columns.user_id }">${site.columns.name }</option>
                            </c:forEach>
                        </select>
                     </span>
                    <label class="w-110 text-r f-l">发生时间：</label>
                    <input type="text" onfocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})"  id="occurTimes" name="occurTimes" value="${occurtimemax}" class="input-text Wdate w-170 f-l">
                </div>
                <div class="cl mb-10">
                    <label class="w-100 text-r f-l">品牌：</label>
                    <div class="priceWrap w-170 f-l">
                       <input type="text"   id="exacct_brand" name="exacct_brand" class="input-text w-140 "  >
                    </div>
                    <label class="w-110 text-r f-l">记账人：</label>
                    <input type="text"   id="create_by" name="create_by" value="${username}" class="input-text w-170 readonly f-l" readonly="readonly" >
                    <input type="hidden" id="userId" name="userId" value="${userId}">
                </div>
                <div class="cl mb-10">
                    <label style="width: 211px;" class="text-r f-l">上传图片：(<span style="color: red;">最多可上传5张照片</span>)</label>
                </div>
                <div class="cl mb-10">
                    <label class="w-100 text-r f-l"></label>
                    <div id="Imgprocess" class="f-l" >
                    </div>
                    <div class="f-l">
                        <div class="imgWrap jiahao" id="jiahao">
                            <div id="filePicker-add">
                                <a href="javascript:;" class="btn-upload"></a>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="imgs" value="" id="imgs">
                </div>
                <div class="text-c mt-20">
                    <a id="subBtn"  class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
                    <a  class="sfbtn sfbtn-opt w-70 " id="btnCancel">取消</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script>
    var feedImgsCount = 0;

    $(function () {
        $('.ticketAdd').popup();
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });

        createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");
        $(".dropdown-main").find(".dropdown-chose").removeClass("dropdown-chose");

        $(".dropdown-selected").remove();
        $('#addbalanceform').Validform({
            btnSubmit: "#subBtn",
            beforeCheck: function (curform) {
                var exacct_id = $(".addspan .del").attr("data-id");
                var producerid = $(".addspan2 .del").attr("data-id");
                var cost_type_id = $("#cost_type").val();
                if (exacct_id == null || exacct_id == "" || exacct_id == undefined) {
                    layer.msg("请选择费用科目");
                    return false;
                }
                if (cost_type_id == null || cost_type_id == "" || cost_type_id == undefined) {
                    layer.msg("请选择费用类型");
                    return false;
                }
                if (producerid == null || producerid == "" || producerid == undefined) {
                    layer.msg("请选择费用发生人！");
                    return false;
                }
            },
            tiptype: function (msg, o, cssctl) {
                if (msg) {
                    layer.msg(msg);
                }
            },
            postonce: true,
            datatype: {
                "price": /^\d+(\.\d{1,2})?$/,
                "pages": /^\s*$|^[1-9]+$/
            },
            callback: function (form) {
                var siteId = $("#siteId").val();
                var exacctName = $("#exacctName").val();
                var cost_type = $("#cost_type").val();
                var cost_total = $("#cost_total").val();
                var bill_type = $("#bill_type").val();
                var bill_amount = $("#bill_amount").val();
                var detail_content = $("#detail_content").val();
                var createName = $("#createName").val();
                var cost_producer_name = $(".addspan2 .dropdown-selected").text();
                var occurTimes = $("#occurTimes").val();
                var create_by = $("#create_by").val();//记账人姓名
                var create_by_id = $("#userId").val();//记账人id
                var exacct_brand = $("#exacct_brand").val();//
                var imgs = $("#imgs").val();
                $.ajax({
                    url: "${ctx}/finance/balanceManager/savebalance",
                    type: "POST",
                    data: {
                        siteId: siteId,
                        exacctName: exacctName,
                        cost_type: cost_type,
                        cost_total: cost_total,
                        bill_type: bill_type,
                        bill_amount: bill_amount,
                        detail_content: detail_content,
                        createName: createName,
                        occurTimes: occurTimes,
                        create_by: create_by,
                        create_by_id: create_by_id,
                        cost_producer_name: cost_producer_name,
                        exacct_brand: exacct_brand,
                        imgs:imgs
                    },
                    success: function (data) {
                        if (data == "ok") {
                            parent.layer.msg("保存成功");
                            parent.search();
                            $.closeDiv($('.ticketAdd'));
                        } else {
                            layer.msg(data);
                        }
                    }
                });
                return false;
            }
        });
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
            $("input[name='markAble']").each(function(index,items){
                if(items.value==file.id){
                    $(site).append('<input type="hidden"  name="pickerImg" id="pickerImg'+file.id+'" value="'+response.path+'">');
                }
            })
        });
        uploader.on( 'uploadError', function( file, reason ) {

        });
        uploader.on( 'uploadFinished', function() {
            var images="";
            var array=$("input[name='pickerImg']");//单引号 的name替换为相应的name
            for(var i=0;i<array.length;i++) {
                images += $(array[i]).val() + ",";
            }
            $("#imgs").val(images);
            if(uploader){
                uploader.reset();
            }
        });

        uploader.on( 'fileQueued', function( file ) {
            if(feedImgsCount==5){
                $("#jiahao").addClass('hide');
            }
            if(parseInt(feedImgsCount) >= 5 ){
                layer.msg("最多可上传5张图片！");
                return false;
            }
            uploader.makeThumb( file, function( error, src ) {
                if (error) {
                    layer.msg('不能预览');
                } else {
                    img(id,src,file,site);
                }
            }, thumbnailWidth, thumbnailHeight );
        });

    }

    function img(id,src,file,site){
        if(feedImgsCount >= 5){
            $("#jiahao").addClass('hide');
            layer.msg("最多可上传5张图片！");
            return false;
        }
        feedImgsCount=parseInt(feedImgsCount)+1;
        var html =' <div class="f-l imgWrap1 mb-10 appendImage" id="file'+file.id+'"><div class="imgWrap"> ';
        html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="deletePicture(this, \''+file.id+'\')"></a></div>'+
            '<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
        $(site).append(html);
        if(feedImgsCount>=5){
            $("#jiahao").addClass('hide');
        }
        $(".appendImage .imgWrap").imgShow();
    }

    function deletePicture(obj,fileId) {
        $("#file"+fileId+"").remove();
        $("#mark"+fileId+"").remove();
        $(obj).parent('.imgWrap1').remove();
        $("#pickerImg"+fileId).remove();
        feedImgsCount = feedImgsCount-1;
        if(feedImgsCount<=5){
            $("#jiahao").removeClass('hide');
        }
        getImages();
        return ;
    }

    function getImages(){
        var images="";
        var array=$("input[name='pickerImg']");//单引号 的name替换为相应的name
        for(var i=0;i<array.length;i++) {
            images += $(array[i]).val() + ",";
        }
        $("#imgs").val(images);
    }

    $('#btnCancel').on('click', function(){
        $.closeDiv($('.ticketAdd'));
    })

</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="decorator" content="base"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />


	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/sfskin_blue.css" />
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/styleGoods.css" />
	<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>

	<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/ueditor.all.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
	<title>新增商品</title>
</head>
<body >
<div class="sfpagebg bk-gray pt-25 pl-25 pr-25 pb-80">
	<form id="tf">
		<div class="">
			<div class="cl mb-15">
				<label class="lb w-100 text-r f-l"><em class="mark">*</em>商品名称：</label>
				<input type="text " class="input-text f-l w-460 readonly" readonly="readonly"  value="${platform.columns.name }" name="name" />
			</div>
			<div class="cl mb-15 ">
				<label class="lb w-100 text-r f-l"><em class="mark">*</em>商品图片：</label>
				<div class="f-l">
					<c:forEach items="${images }" var="icn" varStatus="da">
						<div class="imgWrap1 f-l  mr-15" id="img${da.index}">
							<div class="imgWrap ">
								<a class="sficon btn-delimg"  onclick="deleteImg('img${da.index}')"></a>
								<img  class="img" src="${commonStaticImgPath}${icn}" id="${commonStaticImgPath}${icn}" />
								<input type="hidden" value="${icn}" name="pickerImg" >
							</div>
						</div>
					</c:forEach>
					<div class="imgWrap1 f-l  mr-15 ${count eq 5?'hide':''}" id="Imgprocess">
						<div class="imgWrap" id="imgsAdd">
							<a class="btn-upload bk_dashed"></a>
						</div>
					</div>
					<input type="hidden" name="icon" value="${platform.columns.icon}">
					<input type="hidden" name="platformGoodId" value="${platform.columns.id}" >
				</div>
				<span class="c-888 f-12 ml-10 mt-50 pt-10">建议主图上传图片大小：800*800px，最多5张</span>
			</div>

			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">基本信息：</strong></div>
			<div class="cl mb-10">
				<label class="w-180 f-l"><em class="mark">*</em> 商品编号：</label>
				<input type="text" class="f-l input-text w-300 readonly" readonly="readonly" value="${platform.columns.number }" name="number" />
				<label class="w-120 f-l">商品品牌：</label>
				<input type="text" class="f-l input-text w-300 readonly" readonly="readonly" value="${platform.columns.brand }" name="brand" />
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l"><em class="mark">*</em>商品类别：</label>
				<select class="select w-300 f-l" name="category">
					<option value="">请选择</option>
					<c:forEach var ="cg" items="${categoryList}">
						<option value="${cg.columns.name }" <c:if test="${cg.columns.name==platform.columns.category }">selected="selected"</c:if>  >${cg.columns.name }</option>
					</c:forEach>
				</select>
				<label class="w-120 f-l">商品型号：</label>
				<input type="text" class="input-text w-300 f-l readonly" readonly="readonly" value="${platform.columns.model }" name="model"/>
				<input type="text" class="input-text w-300 f-l readonly hide" readonly="readonly" value="${platform.columns.category }" name="oldCategory"/>
			</div>
			<div class="cl mb-10"  id="nojingshuiPrice">
				<label class="w-180 f-l"><em class="mark">*</em> 新增数量：</label>
				<input type="text" class="f-l input-text w-300 mustfill " id="gstocks" name="gstocks"  />
				<label class="w-120 f-l">商品单位：</label>
				<select class="select w-300 f-l" name="unit">
					<option value="">请选择</option>
					<c:forEach items="${units}" var="item">
						<option value="${item.name}" <c:if test="${item.name == platform.columns.unit }">selected="selected"</c:if>>${item.name}</option>
					</c:forEach>
				</select>
			</div>

			<div class="cl mb-10 " >
				<label class="f-l w-180"><em class="mark">*</em>是否上架：</label>
				<select class="select w-300 f-l" name="sellFlag">
					<option value="1">确认上架</option>
					<option value="2">暂不上架</option>
				</select>
				<label class="f-l w-120" id="unitName">商品单位：</label>
				<input type="text" id="esunit" class="input-text w-300 f-l readonly" readonly="readonly"  value="${platform.columns.unit}" name="unit"/>

				<label class="w-120 f-l" id="locationName">库位：</label>
				<input type="text" class="f-l input-text w-300" maxlength="50" value="" name="location" />
			</div>

			<c:if test="${platform.columns.allowEdit=='ok' }">
				<div class="cl mb-10 " >
					<label class="w-180 f-l" >保修期限：</label>
					<input type="text" class="input-text readonly w-300 f-l" maxlength="10" readonly="readonly" value="${platform.columns.repair_term }" id="repairTerm" name="repairTerm" />
				</div>
			</c:if>
			<c:if test="${platform.columns.allowEdit!='ok' }">
				<div class="cl mb-10 " >
					<label class="w-180 f-l" >保修期限：</label>
					<input type="text" class="input-text w-300 f-l" maxlength="10"  value="${platform.columns.repair_term }" id="repairTerm" name="repairTerm" />
				</div>
			</c:if>
			<%--<div class="cl mb-10">
				<label class="f-l w-180" id="unitName">商品单位：</label>
				<input type="text" id="esunit" class="input-text w-300 f-l readonly" readonly="readonly"  value="${platform.columns.unit}" name="unit"/>
			</div>--%>
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">价格信息：</strong></div>
			<div class="cl mb-15 feiespecialy">
				<label class="w-180 f-l"><em class="mark">*</em>入库价格：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<input type="text" class="input-text readonly" readonly="readonly" name="gsitePrice" id="gsitePrice" value="${platform.columns.site_price }"/>
					<span class="unit">元</span>
				</div>
				<label class="w-120 f-l">工程师价格：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<input type="text" class="input-text" name="gemployePrice" value=""/>
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-15 feiespecialy">
				<label class="w-180 f-l"><em class="mark">*</em>零售价格：</label>
				<div class="priceWrap f-l w-300 mustfill">
					<c:if test="${platform.columns.good_sign eq 'DZ20180110' || platform.columns.good_sign eq 'DZ20180111' || platform.columns.good_sign eq 'DZ20180113' || platform.columns.good_sign eq 'DZ20180114'
						|| platform.columns.good_sign eq 'DZ20180115' || platform.columns.good_sign eq 'DZ20180116' || platform.columns.good_sign eq 'LB20180105' || platform.columns.good_sign eq 'LB20180106'
						|| platform.columns.good_sign eq 'LB18102202' || platform.columns.good_sign eq 'LB18102201'
						|| platform.columns.good_sign eq 'BS20180107' || platform.columns.good_sign eq 'BS20180108' || platform.columns.good_sign eq 'QJ18040201'
						|| 'QJ18040202' eq  platform.columns.good_sign || 'WT18040301' eq platform.columns.good_sign || 'CW08040801' eq platform.columns.good_sign
						|| 'MD20180716' eq platform.columns.good_sign || 'MD20180717' eq platform.columns.good_sign || 'WT18040302' eq platform.columns.good_sign|| 'WT18040303' eq platform.columns.good_sign}">
						<input type="text" class="input-text" name="gcustomerPrice" id="gcustomerPrice" value="${platform.columns.advice_price}"/>
					</c:if>
					<c:if test="${platform.columns.good_sign ne 'DZ20180110' && platform.columns.good_sign ne 'DZ20180111' && platform.columns.good_sign ne 'DZ20180113'
						&& platform.columns.good_sign ne 'DZ20180114' && platform.columns.good_sign ne 'DZ20180115' && platform.columns.good_sign ne 'DZ20180116'
						&& platform.columns.good_sign ne 'LB20180105' && platform.columns.good_sign ne 'QJ18040201' && platform.columns.good_sign ne 'QJ18040202'
						&& platform.columns.good_sign ne 'WT18040301' && platform.columns.good_sign ne 'CW08040801'
						&& 'MD20180716' ne platform.columns.good_sign && 'MD20180717' ne platform.columns.good_sign} ">
						<input type="text" class="input-text " name="gcustomerPrice" id="gcustomerPrice" value=""/>
					</c:if>
					<span class="unit">元</span>
				</div>

				<span class="f-l w-120 text-r">
					<label class="label-cbox4" for="isDiscount"><input type="checkbox" name="isDiscount" id="isDiscount"  value="1"/> 折扣价格：</label>
					</span>
				<div class="priceWrap w-300 f-l readonly" id="discount">
					<input type="text" class="input-text readonly" readonly="readonly" name="grebatePrice"/>
					<span class="unit">元</span>
				</div>
			</div>

			<div class="cl mb-15" >
				<label class="f-l w-180">工程师提成：</label>
				<div class="f-l w-300">
					<label class="f-l mt-3 mr-10 radiobox radiobox-selected" for="normal_tc">
						<input type="radio" name="deductType" id="normal_tc" value="1" checked="checked" />常规提成
					</label>
					<label class="f-l mt-3 mr-10 radiobox" for="ratio_tc">
						<input type="radio" name="deductType" id="ratio_tc"  value="2"/>比例提成
					</label>
				</div>
				<div class="f-l tcbox" id="normal_box">
					<label class="f-l w-120">提成金额：</label>
					<div class="priceWrap f-l w-300">
						<input type="text" class="input-text" name="gnormalDeductAmount"/>
						<span class="unit">元</span>
					</div>
				</div>
				<div class="f-l hide tcbox" id="ratio_box">
					<label class="f-l w-120">提成比例：</label>
					<div class="priceWrap f-l w-300">
						<span><input type="text" class="input-text" name="ratioDeductVal"/></span>
						<span class="unit">%</span>
					</div>
				</div>
			</div>
			<div class="cl mb-15" >
				<!-- 特殊商品 -->
				<div class="f-l  " id="jingshuiPrice">
					<label class="f-l w-180">官方指导价：</label>
					<div class="priceWrap w-300 f-l">
						<input type="text" class="input-text w-300 f-l readonly" readonly="readonly"  value="2979" name="gcustomerPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-120">建议零售价：</label>
					<div class="priceWrap w-300 f-l">
						<input type="text" class="input-text w-300 f-l readonly" readonly="readonly"  value="2198"  name="grebatePrice"/>
						<span class="unit">元</span>
					</div>
				</div>
			</div>
			<div class="cl mb-15">
				<div class="f-l mb-10" id="jiangli">
					<label class="f-l w-180">促销奖励：</label>
					<div class="priceWrap w-300 f-l">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  value="" name="orderPrice"/>
						<span class="unit">元</span>
					</div>
					<input type='hidden' name="gsitePrice"  value="${platform.columns.site_price }"/><!-- 入库价格 -->
				</div>
			</div>
			<div class="cl mb-10">
				<label class="w-180 f-l">京东比较链接：</label>
				<input type="text" class="f-l input-text w-300" value="${platform.columns.jd_seller_link }" name="jdSellerLink" />
				<label class="w-120 f-l">淘宝比较链接：</label>
				<input type="text" class="f-l input-text w-300" value="${platform.columns.tmall_seller_link }" name="tmallSellerLink" />
			</div>
			<div class="bg-e8f2fa mb-15"><strong class="w-100 text-r lh-30 f-13">商品介绍：<strong></div>
			<div class="" style="margin: 0 auto; width: 1000px;">
				<div class="">
					<script id="container" name="content" type="text/plain">

					</script>
					<textarea class="textarea h-50 hide" value="" id="html" name="html"></textarea>
				</div>
			</div>
		</div>
	</form>
	<div class="btnsWrapFixbBg bgOpacity"></div>
	<div class="btnsWrapFixb pt-15 text-c">
		<a class="btnBlue pt-10 pb-10 lh-26 f-16 w-180 c-white radius singleSubmit mr-10" onclick="sellGoods()" >我要销售</a>
		<a class="bg-eee pt-10 pb-10 lh-26 f-16 w-180 radius" onclick="closeTable()" >取消</a>
	</div>
</div>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    var feedImgsCount ='${count}';
    var goodsname='${platform.columns.name}';
    var goodSign='${platform.columns.good_sign}';
    var sitePri='${platform.columns.site_price }';
    $(function(){
        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){
                if(goodSign=='LB20180105'){
                    $("input[name='gsitePrice']").val('${platform.columns.no_vip_price}');
                }else if(goodSign=='LB20180106'){
                    $("input[name='gsitePrice']").val('${platform.columns.no_vip_price}');
                }else if(goodSign=='CZ20180117'){
                    $("input[name='gsitePrice']").val('${platform.columns.no_vip_price}');
                }else if(goodSign=='BS20180107' || goodSign=='BS20180108'){
                    $("input[name='gsitePrice']").val('${platform.columns.no_vip_price}');
                }else{
                    var price=parseFloat(sitePri)+parseFloat(5);
                    $("input[name='gsitePrice']").val(price);
                }
            }
        });

        //防止图片过宽
        fixImgWidth();
        ue = UE.getEditor('container',{ serverUrl:'${ctxPlugin}/lib/ueditor/1.4.3/jsp/controller.jsp',
            toolbars: [['bold', 'italic', 'underline', 'fontborder',  'forecolor', 'backcolor',
                'fontfamily', 'fontsize','justifyleft','justifycenter','justifyright','justifyjustify',
                'simpleupload', 'insertimage', 'preview','fullscreen']],
            elementPathEnabled : false,
            autoFloatEnabled :false,
            initialFrameHeight: 150});
        ue.ready(function(){
            ue.setContent('${platform.columns.html }');
            // 阻止工具栏的点击向上冒泡
            $(this.container).click(function(e){
                e.stopPropagation();
            });
            // 解决悬浮问题
            if (UE.browser.ie && UE.browser.version <= 7) {
                FixIe7Bug();
            }
        })

        createUploader("#imgsAdd","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");
        var goodSn='${platform.columns.good_sign }';
        if($.trim(goodSn)=='HZ20180104'){
            $("#locationName").remove();
            $("input[name='location']").remove();
            $("#nojingshuiPrice").remove();
            $(".feiespecialy").remove();
            $("#textdescription").addClass("readonly");
            $("#textdescription").prop("readonly",true);
            $("#btn-img2").remove();
            $("#img-picker").remove();
            $(".btn-delimg").remove();

            var sitePrice=$("input[name='gsitePrice']").val();/* 入库价格 */
            var grebatePrice=$("input[name='grebatePrice']").val();/* 建议零售价格 */
            var prize=grebatePrice-sitePrice;
            $("input[name='orderPrice']").val(prize);//促销奖励
        }else{
            $("#unitName").remove();
            $("#esunit").remove();
            $("#jingshuiPrice").remove();
            $("#jiangli").remove();
        }

    });
    function closeDiv(){
        $.closeDiv($(".ptAddsp"));
    }

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
            var path="";
            var icons=$("input[name='pickerImg']")
            for(var i=0;i<icons.length;i++) {
                path += $(icons[i]).val() + ",";
            }
            $("input[name='icon']").val(path);
            if(uploader){
                uploader.reset();
            }
        });

        uploader.on( 'fileQueued', function( file ) {
            if(feedImgsCount==7){
                $("#imgsAdd").hide();
            }
            if(parseInt(feedImgsCount) > 7 ){
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

    function delx(obj,fileId) {
        $("#file"+fileId+"").remove();
        $(obj).parent('.imgWrap1').remove();
        $("#pickerImg"+fileId).remove();
        feedImgsCount = parseInt(feedImgsCount)-1;
        if(feedImgsCount<=4){
            $("#imgsAdd").show();
        }
        var path="";
        var icons=$("input[name='pickerImg']")
        for(var i=0;i<icons.length;i++) {
            path += $(icons[i]).val() + ",";
        }
        $("input[name='icon']").val(path);
        return ;
    }


    function img(id,src,file,site){
        if(feedImgsCount > 4){
            $("#imgsAdd").hide();
            layer.msg("最多可上传5张图片！");
            return false;
        }
        feedImgsCount=parseInt(feedImgsCount)+1;
        var html =' <div class="f-l imgWrap1 mr-15" id="file'+file.id+'"><div class="imgWrap"> ';
        html +='<img src="'+src+'" id="" class="img"></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
            '<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
        $(site).append(html);
        if(feedImgsCount>=5){
            $("#imgsAdd").hide();
        }
    }

    function deleteImg(ff) {
        $("#" + ff).remove();
        feedImgsCount = feedImgsCount - 1;
        if (feedImgsCount == 4) {
            $("#imgsAdd").removeClass('hide');
            $("#Imgprocess").removeClass("hide");
        }
        var path="";
        var icons=$("input[name='pickerImg']");
        for(var i=0;i<icons.length;i++) {
            path += $(icons[i]).val() + ",";
        }
        $("input[name='icon']").val(path);
        if (uploader) {
            uploader = null;
        }
        createUploader("#imgsAdd", "#Imgprocess", "file_fake_addimg","file_fake_add", "delimgs");
    }

    //防止图片过宽
    function fixImgWidth(){
        $('#activeEditor img').each(function(item,index){
            $(this).bind('load', function() {//针对谷歌浏览器解决图片不能缩小的bug
                if($(this).width()>600){
                    $(this).width(600);
                }
                $(this).parent().width($(this).width());
            });
            if($(this).width()>600){
                $(this).width(600);
            }
            $(this).parent().width($(this).width());
        });
    }


    $('#isDiscount').click(function(){
        if($(this).attr('checked')){
            $(this).parent('label').addClass('label-cbox4-selected');
            $('#discount').removeClass('readonly');
            $('#discount').children('input').removeClass('readonly').removeAttr('readonly');
            $("#discount").val("1");
        }else{
            $(this).parent('label').removeClass('label-cbox4-selected');
            $('#discount').addClass('readonly');
            $('#discount').children('input').addClass('readonly').attr({'readonly':'readonly'});
            $("#discount").val("0");
        }
    })

    $('input[name="deductType"]').each(function(){
        $(this).click(function(){
            var isChecked = $(this).attr('checked');
            if(isChecked){
                $('input[name="deductType"]').parent('label').removeClass('radiobox-selected');
                $(this).parent().addClass('radiobox-selected');
                $('.tcbox').hide();
                var boxId = $(this).attr('id').split('_')[0]+'_box';
                $('#'+boxId).show();
            }
        });
    })
    var adpoting = false;
    function sellGoods(){
        $("#html").val(ue.getContent());
        if(adpoting) {
            return;
        }
        var goodName=$("input[name='name']").val();
        var category=$("select[name='category']").val();
        var repairTerm = $("input[name='repairTerm']").val();
        if($.trim(goodSign)=='HZ20180104'){
            if(isBlank(category)){
                layer.msg("请选择商品类别！");
                return;
            }
            adpoting = true;
            $.ajax({
                type:"POST",
                traditional:true,
                url:"${ctx}/goods/sitePlatformGoods/doXS",
                data:$("#tf").serializeJson(),
                dataType:'json',
                success:function(result){
                    if(result==true){
                        window.top.layer.msg("添加成功！");
                        var href="${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist";
                        var liMark = $('#min_title_list li',window.top.document);
                        liMark.each(function(idx,el){
                            if($(el).hasClass("active")){
                                var aCloseIndex = $(this).index();
                                $(el).remove();
                                //$('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();
                                setTimeout(function(){
                                    $('#iframe_box',window.top.document).find('.show_iframe').eq(aCloseIndex).remove();
                                }, 20);
                            }
                        });
                        updateOrCreate("平台商品",href);
                    }else{
                        layer.msg("添加失败，请检查！");
                    }
                },
                complete: function() {
                    adpoting = false;
                }
            })
        }else if($.trim(goodSign)!='HZ20180104'){
            if(isBlank($('input[name="gstocks"]').val())){
                layer.msg("请输入新增数量！");
                $("#gstocks").focus();
                return;
            }else if(isBlank($('select[name="unit"]').val())){
                layer.msg("请选择商品单位！");
                return;
            }else if(isBlank($('input[name="gcustomerPrice"]').val())){
                layer.msg("请填写零售价格！");
                $("#gcustomerPrice").focus();
                return;
            }else if(isBlank($('input[name="icon"]').val())){
                layer.msg("请添加商品图片！");
                return;
            }
            adpoting = true;
            $.ajax({
                type:"POST",
                traditional:true,
                url:"${ctx}/goods/sitePlatformGoods/doXS",
                data:$("#tf").serializeJson(),
                dataType:'json',
                success:function(result){
                    if(result==true){
                        window.top.layer.msg("添加成功！");
                        var href="${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist";
                        var liMark = $('#min_title_list li',window.top.document);
                        liMark.each(function(idx,el){
                            if($(el).hasClass("active")){
                                var aCloseIndex = $(this).index();
                                $(el).remove();
                                //$('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();
                                setTimeout(function(){
                                    $('#iframe_box',window.top.document).find('.show_iframe').eq(aCloseIndex).remove();
                                }, 20);
                            }
                        });
                        updateOrCreate("平台商品",href);
                    }else{
                        layer.msg("添加失败，请检查！");
                    }
                },
                complete: function() {
                    adpoting = false;
                }
            })
        }

    }

    function updateOrCreate(name,href){
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
            creatIframe(href,name);
        } else {
            show_navLi.eq(bStopIndex).addClass('active');
            $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).show().find('iframe').attr({'src':href,});

        }
    }

    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }

    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }

    function closeTable(){
        var href="${ctx}/goods/sitePlatformGoods/getSitePlatformGoodslist";
        removeIframe();
        updateOrCreate("平台商品",href);
    }

</script>
</body>
</html>
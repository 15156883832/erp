<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>备件库存管理-修改备件</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
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
	.select2-container--default .select2-selection--single .select2-selection__rendered{
		line-height:26px;
	}
	.select2-container .select2-selection--single{ height:26px;}
	.select2-container--default .select2-selection--single{ border-radius:0;}
</style>
</head>
<body>
<!-- 修改备件 -->
<!-- 工程师库存 (单个工程师)-->
<div class="popupBox gcskc gcskc1">
	<h2 class="popupHead">
		工程师库存
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<form action="" method="post" id="fcha" class="cha">
			<div class="popupMain pos-r">
				<div class="cl mb-10 pos-a bg-fff" style="left: 15px;top: 10px; right: 15px; z-index: 10;">
					<label class="f-l">工程师：</label>
					<span class="f-l c-0e8ee7 lh-26">${epName}</span>
					<input type="hidden" name="empId" value="${empId }">
					<label class="f-l ml-15">备件条码：</label>
					<input type="text" name="chacode" class="input-text f-l w-140" value="${params.chacode }"/>
					<label class="f-l ml-15">备件名称：</label>
					<input type="text" name="chafittingName" class="input-text f-l w-140" />
					<label class="f-l ml-15">适用品类：</label>
					<span class="select-box w-140 f-l">
							<select class="select" name="chasuitCategory">
								<option value="">请选择</option>
								<c:forEach var="category" items="${listR}">
									<option value="${category.columns.name}">${category.columns.name}</option>
								</c:forEach>
							</select>
						</span>
					<a onclick="return exports()"class="sfbtn sfbtn-opt w-70 f-r mr-10 ml-5"><i class="sficon sficon-export"></i>导出</a>
					<a href="javascript:searchEmpItem();" class="sfbtn sfbtn-opt w-70 f-r "  ><i class="sficon sficon-search"></i>查询</a>
				</div>
			</form>
			<div class="pcontent pt-30">



				<div class="cl">
					<table class="table table-border table-bordered table-bg table-sdrk" id="bjStock_table">
						<thead>
							<tr>
								<th class="w-70">操作</th>
								<th class="w-120">备件条码</th>
								<th class="w-200">备件名称</th>
								<th class="w-150">备件型号</th>
								<th class="w-80">库存量</th>
								<th class="w-80">待核销数</th>
								<th class="w-80">待返还数</th>
								<th class="w-80">计量单位</th>
								<th class="w-80">备件类型</th>
								<th class="w-80">备件品牌</th>
								<th class="w-80">适用品类</th>
								<th class="w-80">零售价格</th>
								<th class="w-210">最新一次出库时间</th>
							</tr>
						</thead>
						<tbody id="sdrk_tbd">
						<input type="hidden" name="id" value="${id}"/>
						<c:forEach var="emp" items="${rds}">
							<tr>
								<td class="text-c">
									<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_DB_BTN" html='<a href="javascript:showDiaoBo(\'${emp.columns.id}\');" class="oState state-diaobo c-0e8ee7 btn-tiaobo">调拨</a>'></sfTags:pagePermission>
									<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_LS_BTN" html='<a href="javascript:showEmpRetail(\'${emp.columns.id}\');" class="c-0e8ee7 btn-tiaobo"><i class="sficon sficon-ls"></i>零售</a>'></sfTags:pagePermission>
									<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_FH_BTN" html='<a href="javascript:showEmployTurnBack(\'${emp.columns.id}\');" class="c-0e8ee7 btn-tiaobo"><i class="sficon sficon-gh_mx"></i>返还</a>'></sfTags:pagePermission>
								</td>
								<td class="text-c"> ${emp.columns.code }</td>
								<td class="text-c"> ${emp.columns.name }</td>
								<td class="text-c">${emp.columns.version }</td>
								<td class="text-c">${emp.columns.warning }</td>
								<td class="text-c">${emp.columns.employe_number }</td>
								<td class="text-c">${emp.columns.allNum }</td>
								<td class="text-c">${emp.columns.unit }</td>
	
								<c:if test="${emp.columns.type==1 }">
								<td class="text-c">配件</td>
								</c:if>
								<c:if test="${emp.columns.type==2 }">
								<td class="text-c">耗材</td>
								</c:if>
								<c:if test="${emp.columns.type!=1 and emp.columns.type!=2}">
								<td class="text-c"></td>
								</c:if>
								<td class="text-c">${emp.columns.suit_brand }</td>
								<td class="text-c">${emp.columns.suit_category }</td>
								<td class="text-c">${emp.columns.customer_price }</td>
								<td class="text-c"><fmt:formatDate value="${emp.columns.newest_keep_time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="text-c btnWrap pb-10">
		<a href="javascript:gcstcClose();" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
		<a href="javascript:gcstcClose();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
	</div>
</div>

<!-- 调拨 -->
<div class="popupBox gcstb">
	<h2 class="popupHead">
		调拨
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form id="tz_form">
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl mb-10">
				<label class="f-l w-100">调拨出库：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="diaoP" value=""/>
				<label class="f-l w-100">备件条码：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="code" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">备件名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="fName" value=""/>
				<label class="f-l w-100">备件型号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="version" value=""/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">备件类型：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="type" value=""/>
				<label class="f-l w-100">当前库存：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" readonly="readonly" name="war" value=""/>
					<span class="unit danwei" >米</span>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100"><em class="mark">*</em>调拨入库：</label>
				<span class="f-l">
				<select class="select select-box w-140"  id="idT"  multiline="true" name="empId"  style="height:26px">
				<!-- <select class="select f-l w-140" id="idT"> -->
					<option value="">请选择</option>
					<c:forEach var="emp" items="${list}">
						<option value="${emp.id}">${emp.name }</option>
					</c:forEach>
				</select>
				</span>
				<label class="f-l w-100"><em class="mark">*</em>调拨数量：</label>
				<div class="priceWrap w-140 f-l">
					<input type="text" class="input-text" datatype="num" name="amount"/>
					<span class="unit danwei" ></span>
				</div>
			</div>
			<div class="text-c">
				<input type="hidden" name="idO" value=""/>
				<input type="hidden" name="fittingId">
				<a href="javascript:doDB();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:tiaoboClose();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
		</div>
	</div>
	</form>
</div>


<!-- 零售 -->
<div class="popupBox bjlsbox">
	<form id="ls_form">
		<h2 class="popupHead">
			零售
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="f-l w-80">备件条码：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="code"/>
					<label class="f-l w-100">备件名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="name" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">备件型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="version"/>
					<label class="f-l w-100">入库价格：</label>
					<div class="priceWrap w-140 f-l readonly">
						<input type="text" class="input-text readonly" readonly="readonly" name="sitePrice" />
						<span class="unit">元</span>
					</div>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">零售价格：</label>
					<div class="priceWrap w-140 f-l readonly">
						<input type="text" class="input-text readonly" readonly="readonly" name="customerPrice"/>
						<span class="unit">元</span>
					</div>
					<label class="f-l w-100">当前库存：</label>
					<div class="f-l">
						<div class="priceWrap w-140  readonly">
							<input type="text" class="input-text readonly" readonly="readonly" name="warning" />
							<span class="unit">件</span>
						</div>
						<div class="c-888">不包含待出库备件</div>
					</div>
				</div>
				<div class="cl">
					<label class="f-l w-80">零售数量：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="saleAmount" />
						<span class="unit">件</span>
					</div>
					<label class="f-l w-100">零售总价：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="saleTotalPrice"/>
						<span class="unit">元</span>
						<input type="hidden" name="id" value="">
						<input type="hidden" name="employePrice" value="">
					</div>
				</div>
				<div class="text-c mt-20">
					<a href="javascript:doRetail();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
					<a href="javascript:close('.bjlsbox');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>
		</div>
	</form>
</div>


<!-- 返还 -->
<div class="popupBox bjBack">
		<h2 class="popupHead">
			返还
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pd-20">
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="f-l w-80">备件条码：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="code"/>
					<label class="f-l w-100">备件名称：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="name" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">备件型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="version"/>
					<label class="f-l w-100">备件品牌：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="brand"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">适用品类：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="category"/>
					<label class="f-l w-100">当前库存：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="warning" />
				</div>
				<div class="cl">
					<label class="f-l w-80">返还数量：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text" name="returnAmount" />
						<span class="unit">件</span>
					</div>
				</div>
				<div class="text-c mt-20">
					<input type="hidden" name="fitId" value=""/>
					<input type="hidden" name="empId" value=""/>
					<a href="javascript:turnToStock();" class="sfbtn sfbtn-opt3 w-120 mr-5">保存并入库</a>
					<a href="javascript:turnBack();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
					<a href="javascript:closeTurnBack();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>
		</div>
</div>
<script type="text/javascript">

	var uploader;
	
	//工程师库村明细弹窗
	$(function(){
		$('#idT').select2();
		//2.监听父层按钮的动作
		$('#pngfix-nav-btn', parent.document).click(function(){
			//3.给定一个时间点
			setTimeout(function(){
				//4.再次执行全屏
				layer.restore(full_idx);
			},200);
		});
		
		$(".selection").css({"width":"140px",'height':'26px'});
		
		$(".gcskc1").popup({fixedHeight:false});
	});
	
	function gcstcClose(){
		$.closeDiv($(".gcskc1"));
	};
	
	//关闭调拨弹窗
	function tiaobo(){
		$(".gcstb").popup({fixedHeight:false});
	}
	function tiaoboClose(){
		$.closeDiv($(".gcstb"));
	}

	function closeTurnBack(){
        $.closeDiv($(".bjBack"));
	}

	//工程师备件返还
	function showEmployTurnBack(id){
        $.ajax({
            url:'${ctx}/fitting/stock/tiaoBo', // 查询工程师备件详情
            data:{id: id},
            type: 'POST',
            success:function(re){
                $(".bjBack").find("input[name='fitId']").val(re.columns.fitting_id);
                $(".bjBack").find("input[name='empId']").val(re.columns.empFitId);
                $(".bjBack").find("input[name='code']").val(re.columns.code);
                $(".bjBack").find("input[name='name']").val(re.columns.fittingName);
                $(".bjBack").find("input[name='version']").val(re.columns.version);
                $(".bjBack").find("input[name='brand']").val(re.columns.suit_brand);
                $(".bjBack").find("input[name='category']").val(re.columns.suit_category);
                $(".bjBack").find("input[name='warning']").val(re.columns.warning);
                $(".bjBack").popup({level:2})
            }
        });
    }

    var reg=/^([0-9]*)+(.[0-9]{1,2})?$/;
    $(".bjBack").find("input[name='returnAmount']").blur(function(){
        var warning= $(".bjBack").find("input[name='warning']").val();//库存数量
        if(isBlank($(this).val())){
            layer.msg("请输入返还数量！");
        }else if(!reg.test($(this).val())){
            layer.msg("返还数量格式不正确！");
		}else if(parseFloat($(this).val())>parseFloat(warning)){
            layer.msg("库存数量不足,请重新输入");
        }
	});
    //返还并入库
    var fale=false;
    function turnToStock(){
        if(fale){
            return;
		}
        var empId=$(".bjBack").find("input[name='empId']").val();
        var fitId = $(".bjBack").find("input[name='fitId']").val();
        var num = $(".bjBack").find("input[name='returnAmount']").val();//返还数量
        var warning= $(".bjBack").find("input[name='warning']").val();//库存数量

        if(isBlank(num)){
            layer.msg("请输入返还数量！");
		}else if(parseFloat(num)=='0'){
            layer.msg("返还数量不能为0！");
        }else if(!reg.test(num)){
            layer.msg("返还数量格式不正确！");
        }else if(parseFloat(num)>parseFloat(warning)){
			layer.msg("库存数量不足,请重新输入");
		}else{
            fale=true;
            $.ajax({
                url:'${ctx}/fitting/stock/turnToStock',
                data:{empId: empId,fitId:fitId,num:num},
                type: 'POST',
                success:function(re){
                    if(re.code=='200'){
                        layer.msg("返还成功！");
                        $.closeDiv($(".bjBack"));
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        window.location.reload(true);
                    }else if(re.code=='422'){
                        layer.msg(re.msg);
                        $.closeDiv($(".bjBack"));
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        window.location.reload(true);
					}else if(re.code=='203'){
                        parent.layer.msg("返还失败，库存数量不足？");
                        window.location.reload(true);
                    }else{
                        layer.msg("配件信息有误");
                        $.closeDiv($(".bjBack"));
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        window.location.reload(true);
					}
                }
                ,complete:function(){
                    fale=false;
                }
            });
        }
	}

	//工程师返还保存操作
	var fall=false;
	function turnBack(){
	    if(fall){
	        return;
		}
        var empId=$(".bjBack").find("input[name='empId']").val();
        var fitId = $(".bjBack").find("input[name='fitId']").val();
        var num = $(".bjBack").find("input[name='returnAmount']").val();//返还数量
        var warning= $(".bjBack").find("input[name='warning']").val();//库存数量

        if(isBlank(num)){
            layer.msg("请输入返还数量！");
        }else if(parseFloat(num)=='0'){
            layer.msg("返还数量不能为0！");
		}else if(!reg.test(num)){
            layer.msg("返还数量格式不正确！");
        }else if(parseFloat(num)>parseFloat(warning)){
            layer.msg("库存数量不足,请重新输入");
        }else{
            fall=true;
            $.ajax({
                url:'${ctx}/fitting/stock/employTurnBack',
                data:{empId: empId,fitId:fitId,num:num},
                type: 'POST',
                success:function(re){
                    if(re.code=='200'){
                        parent.layer.msg("返还成功！");
                        $.closeDiv($(".bjBack"));
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        window.location.reload(true);
                    }else if(re.code=='422'){
                        parent.layer.msg(re.msg);
                        $.closeDiv($(".bjBack"));
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        window.location.reload(true);
                    }else if(re.code=='203'){
                        parent.layer.msg("返还失败，库存数量不足？");
                        window.location.reload(true);
					}else{
                        parent.layer.msg("配件信息有误");
                        $.closeDiv($(".bjBack"));
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        window.location.reload(true);
                    }
                }
                ,complete:function(){
                    fall=false;
                }
            });
        }
	}



	function showDiaoBo(id){
		$.ajax({
			url:'${ctx}/fitting/stock/tiaoBo',
			data:{id: id},
			type: 'POST',
			success:function(re){
                $("#tz_form").find("input").val("");
				$("#tz_form").find("input[name='idO']").val(re.columns.id);
				$("#tz_form").find("input[name='diaoP']").val(re.columns.diaoPeople);
				$("#tz_form").find("input[name='code']").val(re.columns.code);
				$("#tz_form").find("input[name='fName']").val(re.columns.fittingName);
				$("#tz_form").find("input[name='version']").val(re.columns.version);
                if(parseInt(re.columns.type)=='1'){
                    $("#tz_form").find("input[name='type']").val("配件");
                }else if(parseInt(re.columns.type)=='2'){
                    $("#tz_form").find("input[name='type']").val("耗材");
                }else{
                    $("#tz_form").find("input[name='type']").val(re.columns.type);
                }
				$("#tz_form").find("input[name='war']").val(re.columns.warning);
				$("#tz_form").find(".danwei").html(re.columns.unit);
				$("#tz_form").find("input[name='fittingId']").val(re.columns.fitting_id);
				$(".gcstb").popup({level:2});
			}
		});
	}

	function showEmpRetail(id){
        $.ajax({
            url:'${ctx}/fitting/stock/showEmpRetail',
            data:{id: id},
            type: 'POST',
            success:function(re){
                $("#ls_form").find("input").val("");
                $("#ls_form").find("input[name='code']").val(re.columns.code);
                $("#ls_form").find("input[name='name']").val(re.columns.fittingName);
                $("#ls_form").find("input[name='version']").val(re.columns.version);
                $("#ls_form").find("input[name='sitePrice']").val(re.columns.site_price);
                $("#ls_form").find("input[name='customerPrice']").val(re.columns.customer_price);
                $("#ls_form").find("input[name='warning']").val(re.columns.warning);
                $("#ls_form").find("input[name='id']").val(re.columns.empFitId);//传个id
                $("#ls_form").find("input[name='employePrice']").val(re.columns.employe_price);//工程师价格
                $(".bjlsbox").popup({level:2});
            }
        });
	}

    $("input[name='saleAmount']").blur(function(){
        var amount=$(this).val();//零售数量
        var warning=$("input[name='warning']").val();//库存数量
		if(isBlank(amount)){
			layer.msg("请输入零售数量！");
		}else if(parseInt(amount)>parseInt(warning)){
            layer.msg("库存数量不足!");
            $(this).val("").focus();
            $("input[name='saleTotalPrice']").val("");
        }else{//计算零售总价
            var lingshou=$("input[name='customerPrice']").val();
            var num=$("input[name='saleAmount']").val();
            var zong=lingshou*num;
            $("input[name='saleTotalPrice']").val(zong);
		}
    });

    function close(selector){
        $.closeDiv($(selector));
    }

	var adp=false;
	function doRetail(){
		if(adp){
		    return;
		}
        var amount=$("input[name='saleAmount']").val();//零售数量
        var warning=$("input[name='warning']").val();//库存数量
		if(isBlank(amount)){
			layer.msg("请输入零售数量！");
		}else if(amount<=0){
            layer.msg("请重新输入零售数量！");
		}else if(parseInt(amount)>parseInt(warning)){
            layer.msg("库存数量不足!");
        }else{
            adpoting = true;
            var postData = $("#ls_form").serializeJson();
            $.post("${ctx}/fitting/stock/doEmpRetail", postData, function(result){
                if(result==2){
                    layer.msg('零售成功！');
                    $.closeDiv($(".bjlsbox"));
                    $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                    window.location.reload(true);
                    adp = false;
                }else if(result==0){
                    layer.msg('库存数量不足！');
                    $.closeDiv($(".bjlsbox"));
                    $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                    window.location.reload(true);
                    adp = false;
                }else{
                    layer.msg('零售失败！');
                    $.closeDiv($(".bjlsbox"));
                    $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                    window.location.reload(true);
                    adp = false;
                }

            });
        }
	}

	
	/* 调拨动作 */
	var adpoting = false;
	function doDB(){
		if(adpoting) {
		    return;
	    }
		
		var idO = $("input[name='idO']").val();//调拨人
		var idT = $("#idT").val();//受调拨人
		var amount = $("input[name='amount']").val();//调拨数量
		var warning = $("input[name='war']").val();//当前库存
		var fittingId = $("input[name='fittingId']").val();//备件id
		if (isBlank(idT)) {
			layer.msg('请选择受调拨人！！！');
			return;
		}
		if (idO == idT) {
			layer.msg('请重新选择服务工程师！');
			return;
		}
		if (parseInt(amount)==0 || isBlank(amount)) {
			layer.msg('调拨数量不能为0或空');
			return;
		}
		if (parseInt(amount)>parseInt(warning)) {
			layer.msg('库存数量不足');
		} else {
			adpoting = true;
			$.ajax({
				url: '${ctx}/fitting/stock/doDB',
				data: {idO: idO, idT: idT, amount: amount, fittingId: fittingId},
				success: function (re) {
					if (re == "ok") {
						layer.msg('调拨成功');
						$.closeDiv($('.gcstb'));
						window.parent.location.href="${ctx}/fitting/stock/empFitting";
						$('#Hui-article-box', window.top.document).css({'z-index': '9'});
					}
				},
                complete: function() {
                    adpoting = false;
                }
			});
		}
	}
	
	//判断数据是否为空
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}
	
	 //查询
	function searchEmpItem(){
		var empId=$("input[name='empId']").val();
	 	var code=$("input[name='chacode']").val();
		var fitName=$("input[name='chafittingName']").val();
		var category=$("select[name='chasuitCategory']").val();
		
		var dbFlag = false;//调拨标识
		var lsFlag = false;//零售标识
		var fhFlag = false;//返还标识
		
		if ('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_DB_BTN")}' === 'true') {dbFlag = true;}
		if ('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_LS_BTN")}' === 'true') {lsFlag = true;}
		if ('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_FH_BTN")}' === 'true') {fhFlag = true;}
		
		$.ajax({
			type:"POST",
			url:'${ctx}/fitting/stock/empSelFitting',
			data:{id:empId,code:code,fitName:fitName,category:category},
			success:function(data){
				 var Html="";
				 var length = data.length;
				 for(var i = 0;i<length;i++){
					Html +='<tr>';
					Html +='<td class="text-c">';
					if(dbFlag){Html +='<a href="javascript:showDiaoBo(\''+data[i].columns.id+'\');" class="oState state-diaobo c-0e8ee7 btn-tiaobo">调拨</a>';}
					if(lsFlag){Html +='<a href="javascript:showEmpRetail(\''+data[i].columns.id+'\');" class="c-0e8ee7 btn-tiaobo"><i class="sficon sficon-ls"></i>零售</a>';}
					if(fhFlag){Html +='<a href="javascript:showEmployTurnBack(\''+data[i].columns.id+'\');" class="c-0e8ee7 btn-tiaobo"><i class="sficon sficon-gh_mx"></i>返还</a>';}
					Html +='</td>';
					Html +='<input type="hidden" name="id" value="'+data[i].columns.id+'"/>';
					Html +='<td class="text-c">' +data[i].columns.code+'</td>';
					Html +='<td class="text-c">' +data[i].columns.name+'</td>';
					Html +='<td class="text-c">'+data[i].columns.version+'</td>';
					Html +='<td class="text-c">'+data[i].columns.warning+'</td>';
                     Html +='<td class="text-c">'+data[i].columns.employe_number+'</td>';
					Html +='<td class="text-c">'+data[i].columns.unit+'</td>';
					if(data[i].columns.type==1){
						Html +='<td class="text-c">配件</td>';
					}else if(data[i].columns.type==2){
						Html +='<td class="text-c">耗材</td>';
					}else{
						Html +='<td class="text-c"></td>';
					}
					Html +='<td class="text-c">'+data[i].columns.suit_brand+'</td>';
					Html +='<td class="text-c">'+data[i].columns.suit_category+'</td>';
                     Html +='<td class="text-c">'+data[i].columns.sitePrice+'</td>';
					Html +='</tr>';
				}
				$("#sdrk_tbd").empty().append(Html);
			}
		}); 
   }
	 
	 
	function exports(){
		var idArr=document.getElementById("bjStock_table").rows.length ;
		var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
					 location.href="${ctx}/fitting/stock/export2?"+$("#fcha").serialize();
				 }
		
			});
		}else{
			location.href="${ctx}/fitting/stock/export2?"+$("#fcha").serialize();
		}
	
	}
</script> 
</body>
</html>
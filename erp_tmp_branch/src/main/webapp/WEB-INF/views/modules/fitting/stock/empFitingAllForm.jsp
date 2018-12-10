<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="decorator" content="base"/>
	<title>库存管理</title>
	<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>

	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
	<style type="text/css">
		.webuploader-pick{
			width:44px;
			height:20px;
			line-height:20px;
			padding:0;
			overflow:visible;
		}

		.webuploader-pick img{
			width:100%;
			height:100%;
			position:absolute;
			left:0;
			top:0;
		}
		
		.fs-14{
		font-size:14px;}
	</style>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
	<div class="page-orderWait">
		<div id="tab-system" class="HuiTab">
			<div class="tabBar cl">
				<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_COMPANYSTOCK_TAB" html='<a class="btn-tabBar"  href="${ctx }/fitting/stock/index">公司库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_TAB" html='<a class="btn-tabBar current"  href="${ctx }/fitting/stock/empFitting">工程师库存</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_WAITERETURN_TAB" html='<a class="btn-tabBar"  href="${ctx }/fitting/stock/waitReturn">工程师返还<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
				<p class="f-r btnWrap">
					<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:reset();" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<div class="tabCon">
				<form id="searchForm">
					<input type="hidden" name="page" id="pageNo" value="1">
					<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
					<div style="height:35px;line-height:30px;padding-bottom:5px;">
						<a  href="${ctx }/fitting/stock/empFitting" class="fs-14">工程师库存</a>
						
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_STOCKDETAIL_BTN" html='<span style="display:inline-block;border-left: 2px solid #aaa;height: 20px;margin: 0 10px;"></span><a class="c-0e8ee7 fs-14" onclick="toempDetaol()" class="fs-14">工程师库存明细</a>'></sfTags:pagePermission>
					</div>
					<div class="bk-gray pt-10 pb-5">
						<table class="table table-search">
							<tr>
								<th style="width: 76px;" class="text-r">工程师：</th>
								<td>
									<span class="f-l">
										<select class="select select-box w-140"  id="employs"  multiline="true" name="empId"  style="height:26px">
											<option value="">请选择</option>
											<c:forEach var="emp" items="${list}">
												<option value="${emp.id}"  <c:if test="${empId==emp.id }">selected="selected"</c:if>>${emp.name }<c:if test="${emp.status=='3'}">（离职）</c:if></option>
											</c:forEach>
										</select>
									</span>
								</td>
								<th style="width: 76px;" class="text-r">备件条码：</th>
								<td>
									<input type="text" class="input-text f-l w-140" name="chacode"/>
								</td>
								<th style="width: 76px;" class="text-r">备件名称：</th>
								<td>
									<input type="text" class="input-text f-l w-120" name="chafittingName"/>
								</td>
								<th style="width: 76px;" class="text-r">适用品类：</th>
								<td>
									<span class="f-l">
										<select class="select select-box w-140" name="chasuitCategory" style="height:26px">
											<option value="">请选择</option>
											<c:forEach var="category" items="${listR}">
												<option value="${category.columns.name}">${category.columns.name}</option>
											</c:forEach>
										</select>
									</span>
								</td>
							</tr>
						</table>
					</div>
				</form>
				<div class="pt-10 pb-5 cl">
					<div class="f-l">
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_DB_BTN" html='<a href="javascript:addDiaoBo();" class="oState state-diaobo c-0e8ee7 btn-tiaobo">调拨</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_LS_BTN" html='<a href="javascript:addSales();" class="c-0e8ee7 btn-tiaobo ml-10"><i class="sficon sficon-ls"></i>零售</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_FH_BTN" html='<a href="javascript:addReturn();" class="c-0e8ee7 btn-tiaobo ml-10"><i class="sficon sficon-gh_mx"></i>返还</a>'></sfTags:pagePermission>
					</div>
					<div class="f-r">
						<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_EXPORTDETAIL_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					</div>

				</div>
				<div>
					<table id="table-waitdispatch" class="table"></table>
					<!-- pagination -->
					<div class="cl pt-10">

						<div class="f-r">
							<div class="pagination"></div>
						</div>
					</div>
					<!-- pagination -->
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<!-- 表头设置 -->
<div class="">
	<div>
		<h2></h2>
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
				<!-- <select class="select f-l w-140 readonly" disabled="disabled">
					<option value="1">张三</option>
					<option value="2">李四</option>
				</select> -->
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
					<span class="unit" id="danwei">米</span>
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
					<span class="unit" id="danwei2"></span>
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

<form action="${ctx}/printFitting/printStockList" id="printForm" target="_blank" method="post"></form>
<script type="text/javascript">

    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';			//系统表格的ID
    var ck = /^\d+(\.\d+)?$/;
    var manuallyStockPosted;
    var hrefs;
    $(function(){
        $('#xzhelp').goHelp('${ctx}/helpindex/indexHelp?a=bjrk');
        $('#rkhelp').goHelp('${ctx}/helpindex/indexHelp?a=bjrk');
        $('#btnImport').goHelp('${ctx}/helpindex/indexHelp?a=bjrk');
        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){

                $(".vipPromptBox").popup();
                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
            }
        });
		$("select[name='chasuitCategory']").select2();
        $("select[name='empId']").select2();
		$(".selection").css("width","140px");
        //获取tab页面统计数字
        $.post("${ctx}/fitting/stock/getWaitReturnCount1",function(result){
			$("#tab_c1").text(result[0].count);
		});
        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        $.tabfold("#moresearch",".moreCondition",1,"click");

        initSfGrid();
    });
    
    
    

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/fitting/stock/getEmpKeepList',
            sfHeader: defaultHeader,
            postData: $("#searchForm").serializeJson(),
            rownumbers : true,
			gridComplete : function() {
				_order_comm.gridNum();
			}
        });
    }
    var che = /^[0-9]*[1-9][0-9]*$/;
    function checkField(val){	
    if(isBlank(val)){
    	val=1;
    }else if(!che.test(val)){
    	layer.msg("请输入正确的格式！");
    }
    $("#printStock").prop("href",hrefs+"&number="+val);
    
    }
    function showTiao(){
        $(".jjcodebox").popup({level:2});
    }



    function search(){
    	var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }
    
    
    var uploader;
	function closeDivThis(){
		$.closeDiv($(".gcskc2"));
	}
	$(function(){
		 $('#employs').select2();
			//2.监听父层按钮的动作
			$('#pngfix-nav-btn', parent.document).click(function(){
				//3.给定一个时间点
				setTimeout(function(){
					//4.再次执行全屏
					layer.restore(full_idx);
				},200);
			});
			
		
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
		//$(".selection").css({"width":"140px",'height':'26px'});
		
		//$(".gcskc2").popup({fixedHeight:false});

  	$('.ui-jqgrid-bdiv').css({'height':$(window).height()-260+'px'},{
  	    'overflow-y': 'auto'
  	}); 
  	window.onresize=function(){
  		$('.ui-jqgrid-bdiv').css({'height':$(window).height()-260+'px'},{
	  	    'overflow-y': 'auto'}); 
  	}
  	
	});
	
	function tiaobo(){
		$(".gcstb").popup({fixedHeight:false});
	}
	function tiaoboClose(){
		$.closeDiv($(".gcstb"));
	}
    function closeTurnBack(){
        $.closeDiv($(".bjBack"));
    }
	//判断数据是否为空
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}
	
	/* 显示调拨 */
	function showDiaoBo(id){
		$.ajax({
			url:'${ctx}/fitting/stock/tiaoBo',
			data:{id: id},
			success:function(re){
				$("#tz_form").find("input[name='idO']").val(re.columns.id);
				$("#tz_form").find("input[name='diaoP']").val(re.columns.diaoPeople);
				$("#tz_form").find("input[name='code']").val(re.columns.code);
				$("#tz_form").find("input[name='fName']").val(re.columns.fittingName);
				$("#tz_form").find("input[name='version']").val(re.columns.version);
				if(re.columns.type=="1"){
                    $("#tz_form").find("input[name='type']").val("配件");
                }else if(re.columns.type=="2"){
                    $("#tz_form").find("input[name='type']").val("耗材");
                }else{
                    $("#tz_form").find("input[name='type']").val(re.columns.type);
				}
				$("#tz_form").find("input[name='war']").val(re.columns.warning);
				$("#tz_form").find("#danwei2").html(re.columns.unit);
				$("#tz_form").find("input[name='fittingId']").val(re.columns.fitting_id);
				$(".gcstb").popup({level:2});
			}
		});
	}

    //工程师备件返还
    function showEmployTurnBack(id){
        $.ajax({
            url:'${ctx}/fitting/stock/tiaoBo',
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
        }else if(!reg.test(num)){
            layer.msg("返还数量格式不正确！");
        }else if(parseFloat(num)=='0'){
            layer.msg("返还数量不能为0！");
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
        }else if(!reg.test(num)){
            layer.msg("返还数量格式不正确！");
        }else if(parseFloat(num)=='0'){
            layer.msg("返还数量不能为0！");
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
                        parent.layer.msg("返还失败，库存数量不足!");
                        window.location.reload(true);
                    }else{
                        layer.msg("配件信息有误");
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



    /* 调拨动作 */
	var adpoting = false;
	function doDB(){
		if(adpoting) {
		    return;
	    }
		
		var idO=$("input[name='idO']").val();//调拨人
		var idT=$("#idT").val();//受调拨人
		var amount=$("input[name='amount']").val();//调拨数量
		var warning=$("input[name='war']").val();//当前库存
		var fittingId=$("input[name='fittingId']").val();//备件id
		if(isBlank(idT)){
			layer.msg('请选择受调拨人！！！');
			return;
		}
		if(idO==idT){
			layer.msg('请重新选择服务工程师！');
			return;
		}if(parseInt(amount)==0 || isBlank(amount)){
			layer.msg('调拨数量不能为0或空');
			return;
		}
		if(parseInt(amount)>parseInt(warning)){
			layer.msg('库存数量不足');
			return;
		}
		else{
			adpoting = true;
			$.ajax({
				datatype:{
					"num":/^\d+(\.\d+)?$/
					},
				url:'${ctx}/fitting/stock/doDB',
				data:{idO:idO,idT:idT,amount:amount,fittingId:fittingId},
				success:function(re){
					 if(re=="ok"){
						 layer.msg('调拨成功');
						 $.closeDiv($('.gcstb'));
						 window.parent.location.href="${ctx}/fitting/stock/empFitting";
						// window.location.href='${ctx}/fitting/stock/getWaitReturnCount1';
						 $('#Hui-article-box',window.top.document).css({'z-index':'9'});
					 }
				},
                complete: function() {
                    adpoting = false;
                }
			});
		}
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



    /* //查询
	function searchEmpItem(){
		var empId=$("select[name='empId']").val();
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
					Html +='<td class="text-c">' +data[i].columns.empName+'</td>';
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
} */
	function exports(){
		var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
		var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
		if(idArr>10000){
			$('body').popup({
				level:3,
				title:"导出",
				content:content,
				 fnConfirm :function(){
				 location.href="${ctx}/fitting/stock/export2?"+$("#searchForm").serialize();
				 }
		
			});
		}else{
			 location.href="${ctx}/fitting/stock/export2?"+$("#searchForm").serialize();
		}
	}
	
	function fmtOper(rowData){
        var html1 = '';
        var html2 = '';
        var html3 = '';
        if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_DB_BTN")}' === 'true'){
            html1 = '<a href="javascript:showDiaoBo(\''+rowData.id+'\');" class="oState state-diaobo c-0e8ee7 btn-tiaobo">调拨</a></br>';
        }
        if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_DB_BTN")}' === 'true'){
            html2 = '<a href="javascript:showEmpRetail(\''+rowData.id+'\');" class="c-0e8ee7 btn-tiaobo"><i class="sficon sficon-ls"></i>零售</a></br>';
        }
        if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_DB_BTN")}' === 'true'){
            html3 = '<a href="javascript:showEmployTurnBack(\''+rowData.id+'\');" class="c-0e8ee7 btn-tiaobo"><i class="sficon sficon-gh_mx"></i>返还</a>';
        }

        return html1 + html2 +html3;
    }
    
    function fmtFitType(rowData){
    	var type= rowData.type;
    	if(type=='1'){
    		return "配件";
    	}
    	if(type=='2'){
    		return "耗材";
    	}
    	return "";
    }
    
    function toempDetaol(){
		window.location.href="${ctx}/fitting/stock/empFittingItem";
	}
	
	function toempFitting(){
		window.location.href="${ctx }/fitting/stock/empFitting";
	}
	
	function reset() {
		$("select[name='empId']").select2('val','请选择');
		$("select[name='chasuitCategory']").select2('val','请选择');
	}
	
	
	
	//工程师调拨
    function addDiaoBo() {
    	var idArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
    	if(idArr.length < 1){
    		layer.open({
                type: 2,
                content: '${ctx }/fitting/stock/toAdjustFittingPage?ids=&employeId=',
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0,
                fadeIn: 0,
                anim: -1
            });
    		return ;
    	}
    	var employeId = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]).employe_id;
        var ids = "";
        var mark = "";
        for (var i = 0; i < idArr.length; i++) {
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if(employeId!=rowData.employe_id){
            	mark = "1";
            	layer.msg("请选择工程师相同的数据进行操作！");
            	return ;
            }
            if(rowData.estatus=='1'){
            	mark='2';
            	layer.msg("工程师不存在！");
            	return;
            }
            /* if(rowData.estatus=='3'){
            	mark='3';
            	layer.msg("工程师已离职！");
            	return;
            } */
            if (isBlank(ids)) {
            	ids = idArr[i];
            }else{
            	ids =ids +","+ idArr[i];
            }
        }
        if(mark=='1'){
        	
    		return ;
        }
        if(mark=='2'){
        	
    		return ;
        }
        /* if(mark=='3'){
    		return ;
        } */
        layer.open({
            type: 2,
            content: '${ctx }/fitting/stock/toAdjustFittingPage?ids='+ids+'&employeId='+employeId,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }
	
	
  //工程师零售
    function addSales() {
    	var idArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
    	if(idArr.length < 1){
    		layer.open({
                type: 2,
                content: '${ctx }/fitting/stock/toSalesFittingPage?ids=&employeId=',
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0,
                fadeIn: 0,
                anim: -1
            });
    		return ;
    	}
    	var employeId = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]).employe_id;
        var ids = "";
        var mark = "";
        for (var i = 0; i < idArr.length; i++) {
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if(employeId!=rowData.employe_id){
            	layer.msg("请选择工程师相同的数据进行操作！");
            	mark = "1";
            	return ;
            }
            if(rowData.estatus=='1'){
            	layer.msg("工程师不存在！");
            	mark='2';
            	return;
            }
           /*  if(rowData.estatus=='3'){
            	mark='3';
           		layer.msg("工程师已离职！");
            	return;
            } */
            if (isBlank(ids)) {
            	ids = idArr[i];
            }else{
            	ids =ids +","+ idArr[i];
            }
        }
        if(mark=='1'){
        	
    		return ;
        }
        if(mark=='2'){
        	
    		return ;
        }
       /*  if(mark=='3'){
        	
    		return ;
        } */
        layer.open({
            type: 2,
            content: '${ctx }/fitting/stock/toSalesFittingPage?ids='+ids+'&employeId='+employeId,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }
  
  //工程师调拨
    function addReturn() {
    	var idArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
    	if(idArr.length < 1){
    		layer.open({
                type: 2,
                content: '${ctx }/fitting/stock/toReturnFittingPage?ids=&employeId=',
                title: false,
                area: ['100%', '100%'],
                closeBtn: 0,
                shade: 0,
                fadeIn: 0,
                anim: -1
            });
    		return ;
    	}
    	var employeId = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]).employe_id;
        var ids = "";
        var mark = "";
        for (var i = 0; i < idArr.length; i++) {
            var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            if(employeId!=rowData.employe_id){
            	layer.msg("请选择工程师相同的数据进行操作！");
            	mark = "1";
            	return ;
            }
            if(rowData.estatus=='1'){
            	layer.msg("工程师不存在！");
            	mark='2'
            	return;
            }
            /* if(rowData.estatus=='3'){
            	layer.msg("工程师已离职！");
            	mark='3'
            	return;
            } */
            if (isBlank(ids)) {
            	ids = idArr[i];
            }else{
            	ids =ids +","+ idArr[i];
            }
        }
        if(mark=='1'){
        	
    		return ;
        }
        if(mark=='2'){
        	
    		return ;
        }
        /*if(mark=='3'){
         	
    		return ;
        } */
        layer.open({
            type: 2,
            content: '${ctx }/fitting/stock/toReturnFittingPage?ids='+ids+'&employeId='+employeId,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }
  
    function numberCheck(){
    	$.post("${ctx}/fitting/stock/getWaitReturnCount1",function(result){
			$("#tab_c1").text(result[0].count);
		});
    }
   
	
   
</script>
<script type="text/javascript" src="${ctxPlugin}/lib/JsBarcode.all.min.js"></script>
</body>
</html>
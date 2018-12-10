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
	</style>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
	<div class="page-orderWait">
		<div id="tab-system" class="HuiTab">
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_MESSAGE_TAB" html='<a class="btn-tabBar current"  href="${ctx }/factoryfitting/stocks/factoryfittingStocksHeaderLook">家电协会</a>'></sfTags:pagePermission>
				<p class="f-r btnWrap">
					<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<div class="tabCon">
				<form id="searchForm">
					<input type="hidden" name="page" id="pageNo" value="1">
					<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
					<div class="bk-gray pt-10 pb-5">
						<table class="table table-search">
							<tr>
								<th style="width: 76px;" class="text-r">备件条码：</th>
								<td>
									<input type="text" class="input-text" name= "code"/>
								</td>
								<th style="width: 76px;" class="text-r">备件名称：</th>
								<td>
									<input type="text" class="input-text" name = "name"/>
								</td>
								<th style="width: 76px;" class="text-r">适用品类：</th>
								<td>
								<span class="select-box">
									<select class="select" name="suitCategory">
										<option value="">请选择</option>
										<c:forEach var="category" items="${listR}">
											<option value="${category.name}">${category.name}</option>
										</c:forEach>
									</select>
								</span>
								</td>
								
								<!-- <th style="width: 76px;" class="text-r">有效期起：</th>
								<td colspan="2">
									<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'startDateMax\')||\'%y-%M-%d\'}'})" id="startDateMin" name="startDateMin" value="" class="input-text Wdate w-140">
									至
									<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDateMin\')}',maxDate:'%y-%M-%d'})" id="startDateMax" name="startDateMax" value="" class="input-text Wdate w-140">
								</td> -->
							</tr>
							<!-- <tr>
								<th style="width: 76px;" class="text-r">有效期至：</th>
								<td colspan="3">
									<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDateMax\')||\'%y-%M-%d\'}'})" id="endDateMin" name="endDateMin" value="" class="input-text Wdate w-140">
									至
									<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDateMin\')}',maxDate:'%y-%M-%d'})" id="endDateMax" name="endDateMax" value="" class="input-text Wdate w-140">
								</td>
							</tr> -->
						</table>
					</div>
				</form>
				<div class="pt-10 pb-5 cl">
					<div class="f-l">
                		<sf:hasPermission perm="FACTORYFITTING_FACTORYFITTING_MESSAGE_ADDGITTING_BTN"><a href="javascript:addFactoryFittingApply();" class="sfbtn sfbtn-opt" id="xzhelp"><i class="sficon sficon-add"></i>添加申请</a></sf:hasPermission>
					</div> 
					<div class="f-r">
						<%-- <sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_COMPANYSTOCK_PLDELETE_BTN" html='<a href="javascript:plsc();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-rubbish"></i>删除</a>'></sfTags:pagePermission> --%>
						<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
						<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_MESSAGE_EXPORTGITTING_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
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

<!-- 调整库存 -->
<div class="popupBox bjtzkkbox">
	<h2 class="popupHead">
		调整库存
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<form id="tz_form">
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="f-l w-80">备件条码：</label>
					<input type="text" class="input-text w-160 f-l readonly" readonly="readonly" name="code" />
					<label class="f-l w-100">备件名称：</label>
					<input type="text" class="input-text w-160 f-l readonly" readonly="readonly" name="name" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">备件型号：</label>
					<input type="text" class="input-text w-160 f-l readonly" readonly="readonly" name="version" />
					<label class="f-l w-100">备件类型：</label>
					<input type="text" class="input-text w-160 f-l readonly" readonly="readonly" name="type" />
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">操作人：</label>
					<input type="text" class="input-text w-160 f-l readonly" readonly="readonly" name="userName" value="${userName }"/>
					<input type="hidden" name="userId" value="${userId }"/>
					<label class="f-l w-100">操作时间：</label>
					<input type="text" class="input-text w-160 f-l readonly" readonly="readonly" name="curTime" value="${curTime }"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-80">当前库存：</label>
					<div class="priceWrap w-160 f-l readonly">
						<input type="text" class="input-text readonly" readonly="readonly" name="warning" id="fittingWarning"/>
						<span class="unit">件</span>
					</div>
					<label class="f-l w-100"><em class="mark">*</em>调整后库存：</label>
					<div class="f-l">
						<a href="javascript:subNum();" class="f-l mr-5 btn-count"><i class="sficon sficon-minus"></i></a>
						<div class="priceWrap w-80 f-l">
							<input type="text" class="input-text"  id="adj_num" name="adj_num" value="1"/>
							<span class="unit readonly">件</span>
						</div>
						<a href="javascript:addNum();" class="f-l ml-5 btn-count"><i class="sficon sficon-plus"></i></a>
					</div>
				</div>
				<div class="cl">
					<label class="f-l w-80"><em class="mark">*</em>调整原因：</label>
					<textarea id="tkccresource" class="textarea h-50 w-420" name="tkccresource"></textarea>
				</div>
				<div class="text-c mt-20">
					<input type="hidden" name="fittingId" value=""/>
					<a href="javascript:saveAdjust();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
					<a href="javascript:close('.bjtzkkbox');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- 手动入库 -->
<div class="popupBox bjsdrkbox" style="width: 1045px;">
	<h2 class="popupHead">
		手动入库
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<table class="table table-border table-bordered table-bg table-sdrk">
					<thead>
					<tr>
						<th class="w-160">备件条码</th>
						<th class="w-160">备件名称</th>
						<th class="w-160">备件型号</th>
						<!-- <th class="w-80">备件品牌</th> --> 
						<th class="w-80">适用品类</th>
						<th class="w-120">入库数量</th>
						<th class="w-140">最新入库价格（元）</th>
						<th class="w-100">操作</th>
					</tr>
					</thead>
					<tbody id="sdrk_tbd"></tbody>
				</table>
			</div>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:doSdrk();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
			<a href="javascript:close('.bjsdrkbox');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
</div>
<!-- 备件详情 -->
<div class="popupBox bjdetailbox" style="width:760px">
	<h2 class="popupHead">
		备件详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pd-20">
			<div class="cl mb-10">
                <input id="fttId" hidden="hidden" />
				<label class="f-l w-100"> 备件条码：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="code" readonly="readonly" unselectable="on" value="" id="barcode2"/>
				<label class="f-l w-100"> 备件名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="fname" readonly="readonly" unselectable="on" value="" />

				<label class="f-l w-100">备件品牌：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="brand" readonly="readonly" unselectable="on" value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100"> 备件型号：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="version" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 适用品类：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="category" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 备件类型：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="type" readonly="readonly"  unselectable="on"value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">计量单位：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="unit" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 入库数量：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="warning" readonly="readonly" unselectable="on" value="2" />
				<label class="f-l w-100"> 入库价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" name="sitePrice" readonly="readonly" unselectable="on" />
					<span class="unit">元</span>
				</div>
			</div>
			<div class="cl mb-10">

				<label class="f-l w-100">工程师价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" name="employePrice" readonly="readonly" unselectable="on" />
					<span class="unit">元</span>
				</div>
				<label class="f-l w-100">零售价格：</label>
				<div class="priceWrap w-140 f-l readonly">
					<input type="text" class="input-text readonly" name="customerPrice" readonly="readonly" unselectable="on" />
					<span class="unit">元</span>
				</div>
				<label class="f-l w-100">库位：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="location" readonly="readonly" unselectable="on" value="" />
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">返还旧件：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="refundOldFlag" readonly="readonly" unselectable="on" value="" />
				<label class="f-l w-100"> 备件来源：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="supplier" readonly="readonly" unselectable="on" value="" />
			</div>

			<div class="cl mb-10">
				<label class="f-l w-100">二维码：</label>
				<div class="f-l w-140">
					<div class="imgbox " id="qrcode" style="border:0;"></div>
				</div>

				<label class="f-l w-100">图片：</label>
				<p id="imagesHtml">
				</p>
			</div>
			<div class="text-c pt-25">
				<a class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="lastFitting()">上一个</a>
				<a class="sfbtn sfbtn-opt w-70 mr-5" onclick="nextFitting()">下一个</a>
				<a href="javascript:showTiao();" class="sfbtn sfbtn-opt3 w-80 mr-5">打印二维码</a>
				<a href="javascript:closeDetail();" class="sfbtn sfbtn-opt w-70 mr-5">关闭</a>
			</div>
		</div>
	</div>
</div>


<!-- 备件形码 -->
<div class="popupBox jjcodebox">
	<h2 class="popupHead">
		配件二维码
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="cl pd-10 bk-gray w-460">
				<!-- 条码 -->
				<div class="f-l ml-10">
					<div style="width:110px; height:110px;" id="barcode"></div>
					<p id="tiaoCode" class="text-c">${fitting.code}</p>
				</div>
				<div class="f-l ml-10" >
					<p class=" mb-10 w-300 pos-r pl-50"><span class="pos w-50 text-r lh-22">名称：</span><span id="tiaoName" class="lh-20"></span> </p>
					<p class=" mb-10 w-300 pos-r pl-50 "><span class="pos w-50 text-r lh-22">型号：</span><span id="tiaoVersion" class="lh-20"></span> </p>
					<p class=" mb-10 w-300 pos-r pl-50 "><span class="pos w-50 text-r lh-22">品牌：</span><span id="tiaoBrand" class="lh-20"></span>&nbsp;库位：<span id="kuweiV" class="lh-20"></span></p>
					<p class="mb-10 w-300 pos-r pl-50 "><span class="pos w-50 text-r lh-22">适用：</span><span id="tiaoV" class="lh-20"></span></p>
				</div>
			</div>
			<div class="cl mt-10">
				<label class="f-l">打印份数：</label>
				<div class="priceWrap f-l w-100">
					<input class="input-text" value="1" id="number" onchange="checkField(this.value)"/>
					<span class="unit">份</span>
				</div>
			</div>
			<div class="text-c mt-15">
				<a  id="printStock" target="_blank" onclick="closeDivTiao()" class="sfbtn sfbtn-opt3 w-70 mr-5">打印</a>
				<a href="javascript:closeDivTiao();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
		</div>
	</div>
</div>

<!-- 导入结果框 -->
<div class="popupBox massTextNote importEndDiv">
	<h2 class="popupHead">
		导入提示
		<a href="javascript:closeAll_();" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="f-14">
				<i class="sficon sficon-sendSucess mr-5"></i>您已成功导入<strong class="c-5fa666 f-14 va-t" id="excelSuccessCount">40</strong>条
			</div>
			<div class="f-14 mt-10 lh-24" id="excelErrorDiv">
				<i class="sficon sficon-sendFail mr-5"></i>导入失败<strong class="c-fe0101 f-14 va-t" id="excelErrorCount">10</strong>条
				<a href="${ctx}/common/downloadFile?fileName=ErrorDetail.txt&msg=" id="excelErrorDetail" class="c-0383dc ml-10" style="text-decoration: underline;" target="_blank">
					查看导入失败的工单
				</a>
			</div>
			<div class="text-c mt-30 pt-10 pr-30 mr-30 ">
				<a href="javascript:closeAll_();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
			</div>
		</div>
	</div>
</div>
<!-- 导入数据 -->
<div class="popupBox importLayer">
	<form id="importForm" action="${ctx}/order/fitting/check" method="post" enctype="multipart/form-data">
		<h2 class="popupHead">
			导入
			<a href="javascript:closeAll_();" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-10">
				<div class="cl">
					<label class="w-100 f-l text-r">Excel文件：</label>
					<div class="impotbox f-l w-400">
						<input type="text" class="input-text filename" id="filename" />
						<a class="btn-import radius" id="btn-import" href="javascript:;">选择</a>
						<input type="file" id="input-file" class="input-file" onchange="getfileName()" />
					</div>
				</div>
				<div class="mt-15 cl c-fd7e2a">
					<label class="w-80 f-l text-r">提示：</label>
					<div class="f-l w-420 lh-26">
						<p>1、仅允许导入“xls”或“xlsx”格式文件，且每次导入建议不超过1000条。</p>
						<p>2、备件条码唯一，为1-20位字母或数字，如果导入编号存在将会导入失败。</p>
					</div>
				</div>
				<div class="cl mt-20 mb-15">
					<div class="f-l ml-20">
						<a href="${commonFileHead}/fileDownload/fitting_excel_template.xls" class="sfbtn sfbtn-opt3 w-100">下载模板</a>
					</div>
					<div class="f-r pr-10">
						<input type="button" class="sfbtn sfbtn-opt w-60 mr-5" id="checkExcelBtn" value="校验"/>
						<input type="button" onclick="importExcel();" class="sfbtn sfbtn-opt sfbtn-disabled w-60 mr-5" id="importExcelBtn" value= "导入"/>
						<a href="javascript:closeAll_();" class="sfbtn sfbtn-opt w-60">取消</a>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>


<div class="popupBox drtsBox">
	<h2 class="popupHead">
		提示
		<a href="javascript:closeDrtsBox();" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain">
			<div class="w-520" id="errorMessage">
			</div>
		</div>
		<div class="text-c mt-20 mb-15">
			<a href="javascript:closeDrtsBox();" class="sfbtn sfbtn-opt3 w-70">关闭</a>
		</div>
	</div>
</div>

<div class="popupBox w-320 vipPromptBox">
	<h2 class="popupHead">
		提示
	</h2>
	<div class="popupContainer">
		<div class="popupMain text-c pt-30 pb-20">
			<div class="">
				<i class="iconType iconType2"></i>
				<strong class="f-16">VIP会员功能</strong>
			</div>
			<p class="c-666 lh-26">
				抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
			</p>
			<div class="text-c mt-30">
				<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
				<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
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
        //获取tab页面统计数字
        $.post("${ctx}/fitting/stock/getWaitReturnCount1",function(result){
            $("#tab_c1").text(result[0].count);
        });
        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        $.tabfold("#moresearch",".moreCondition",1,"click");

        initSfGrid();

        $("#adj_num").change(function (){
            var num = $("#adj_num").val();
            var warn = $("#fittingWarning").val();
            if(isBlank(num)){
                layer.msg("请输入调整后库存数量");
                return;
            }
            if(!ck.test(num)){
                layer.msg("请输入正确的格式");
            }
        });

        var $btn =$("#checkExcelBtn");   //校验
        uploader = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: false,
            swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
            server: '${ctx}/factoryfitting/stocks/checkFactoryFittingExcel',
            pick: {
                id: '#btn-import',
                multiple:false            //默认为true，true表示可以多选文件，HTML5的属性
            },
            accept: {
                title: 'XLSX',
                extensions: 'xlsx,xls',
                mimeTypes: '.xlsx,.xls'
            },
            method:'POST',
            duplicate:true
        });
        uploader.on('beforeFileQueued', function(file){
            //uploader.reset();
            //file.setStatus('queued');
            $("#importExcelBtn").addClass("sfbtn-disabled");
            $("#importExcelBtn").attr("disabled", true);
            $("#checkExcelBtn").removeClass("sfbtn-disabled");
            $("#checkExcelBtn").attr("disabled", false);
            uploader.option( 'server', '${ctx}/factoryfitting/stocks/checkFactoryFittingExcel');
        });
        uploader.on( 'uploadSuccess', function( file, response ) {
            if(response.operType == "check"){//校验
                if(response.templateError == "y"){
                    $("#filename").val('');
                    layer.msg("校验失败，模板不匹配!");
                }else if(response.overLimit == "y"){
                    $("#filename").val('');
                    layer.msg("校验失败，Excel文件记录超过1000条限制!");
                }else if(response.errorMessage == "y"){
                    $("#filename").val('');
                    $("#errorMessage").html(response.errorDetail);
                    $(".drtsBox").popup();
                }else if(response.pass == "y"){
                    $("#importExcelBtn").removeClass("sfbtn-disabled");
                    $("#importExcelBtn").attr("disabled", false);
                    $("#checkExcelBtn").addClass("sfbtn-disabled");
                    $("#checkExcelBtn").attr("disabled", true);
                    uploader.stop();
                    file.setStatus('queued');
                    uploader.option( 'server', '${ctx}/factoryfitting/stocks/importFactoryFitting');
                    layer.msg("校验成功，可以导入!");
                }else{
                    $("#filename").val('');
                    layer.msg("解析Excel错误!");
                }
            }else if(response.operType == "import"){//导入
                layer.closeAll();
                if(response.pass == "y"){
                    uploader.option( 'server', '${ctx}/factoryfitting/stocks/checkFactoryFittingExcel');
                    $.closeAllDiv();
                    if(response.errorCount > 0){
                        $("#excelErrorDiv").show();
                        $("#excelErrorDetail").attr("href", "${ctx}/common/downloadFile?fileName=ErrorDetail.txt&msg=" + response.errorDetail);
                        $("#excelErrorCount").text(response.errorCount);
                    }else{
                        $("#excelErrorDiv").hide();
                    }
                    $("#excelSuccessCount").text(response.successCount);
                    $(".importEndDiv").popup();
                    search();
                }else if(response.reporterrors == "y"){
                    $("#filename").val('');
                    layer.msg("导入失败,请联系管理员!");
                }else{
                    $("#filename").val('');
                    layer.msg("导入失败,请联系管理员!");
                }
            }
        });
        uploader.on( 'fileQueued', function( file ) {
            var inputTxt = document.getElementById('filename');
            inputTxt.value =file.name;
        });

        $btn.on( 'click', function(file) {
            var fulen = $("#filename").val();
            if(fulen == null || fulen == ""){
                layer.msg("请添加文件!");
                uploader.reset();
            }else{
                uploader.upload();
            }
        });

        $("#btnImport").click(function(){
            $(".importLayer").popup();
            $("#filename").val("");
            uploader.option( 'server', '${ctx}/order/checkUnfinishedOrderExcel');
            $("#importExcelBtn").addClass("sfbtn-disabled");
            $("#importExcelBtn").attr("disabled", true);
            $("#checkExcelBtn").removeClass("sfbtn-disabled");
            $("#checkExcelBtn").attr("disabled", false);
        });

    });

    function importExcel(){
        layer.msg("数据导入中，请耐心等待...",{
            time:5000000
        });
        uploader.upload();
    }

    function closeDrtsBox(){
        $.closeDiv($(".drtsBox"));
    }

    function closeDivTiao(){
        $.closeDiv($(".jjcodebox"));
    }
    function closeDetail(){
        $.closeDiv($('.bjdetailbox'));
    }
    function closeAll_(){
        $.closeAllDiv();
    }
    
    function prinTurnBack(){
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        if(ids == null || ids.length == 0){
            layer.msg("请选择记录!");
            return ;
        }else{
        	 $("#printForm").empty();
             $.each(ids, function(index, item){
             	$("#printForm").append('<input type="hidden" name="fittingId" value="'+item+'"/>');            	
             });
        }
        $("#printForm").submit();
    }

    function showTurnBack(){
        $("input[name='backNum']").val("");
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        if(ids == null || ids.length == 0){
            layer.msg("请选择记录!");
            return ;
        }else if(ids.length >1){
            layer.msg("一次只能选择一条记录!");
            return ;
        }
        $.ajax({
            url:'${ctx}/fitting/stock/ajaxFittingById',
            data:{id: ids[0]},
            success:function(result){
                $("#fc_form").find("input[name='code']").val(result.code);
                $("#fc_form").find("input[name='name']").val(result.name);
                $("#fc_form").find("input[name='version']").val(result.version);
                $("#fc_form").find("input[name='brand']").val(result.brand);
                $("#fc_form").find("input[name='category']").val(result.suitCategory);
                $("#fc_form").find("input[name='id']").val(result.id);//传个id
                if(result.type=="1"){
                    $("#fc_form").find("input[name='type']").val("配件");
                }else if(result.type=="2"){
                    $("#fc_form").find("input[name='type']").val("耗材");
                }
                $("#fc_form").find("input[name='stock']").val(result.warning);
                $(".bjfcbox").popup();
            }
        });
    }

    $("#fc_form").find("input[name='backNum']").blur(function(){
        var checkNum= /^[0-9]*$/;
        var num=$(this).val();
        var stock=$("#fc_form").find("input[name='stock']").val();//总库存量
        if(isBlank(num) || parseInt(num)=="0"){
            layer.msg("请输入返厂数量！");
            return;
        }
        if(!checkNum.test(num)){
            layer.msg("返厂数量格式不正确！");
            return;
        }
        if(parseInt(num) > parseInt(stock)){
            layer.msg("库存数量不足!");
            return;
        }
    })

    //新件返厂
    var adpo = false;
    function doTurnBack(){
        var checkNum= /^[0-9]*$/;
        if(adpo) {
            return;
        }
        var stock=$("#fc_form").find("input[name='stock']").val();//总库存量
        var num=$("#fc_form").find("input[name='backNum']").val();//返厂数量
        var id=$("#fc_form").find("input[name='id']").val()
        if(isBlank(num) || parseInt(num)=="0"){
            layer.msg("请输入返厂数量！");
            return;
        }
        if(!checkNum.test(num)){
            layer.msg("返厂数量格式不正确！");
            return;
        }
        if(parseInt(num)>parseInt(stock)){
            layer.msg("库存数量不足!");
            return;
        }
        adpo = true;
        var postData = $("#ls_form").serializeJson();
        $.post("${ctx}/fitting/stock/doTurnBack", {id:id,num:num}, function(result){
            if(result=="ok"){
                layer.msg('返厂成功');
                $.closeDiv($(".bjfcbox"));
                $('#table-waitdispatch').trigger("reloadGrid");
                //window.location.href="${ctx}/fitting/stock/index";
                adpo = false;
            }else if(result=="noFull"){
                layer.msg('库存数量不足');
                $.closeDiv($(".bjfcbox"));
                $('#table-waitdispatch').trigger("reloadGrid");
                adpo = false;
            }else{
                layer.msg('返厂失败！');
                $.closeDiv($(".bjfcbox"));
                $('#table-waitdispatch').trigger("reloadGrid");
            }
        });
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/factoryfitting/stocks/getFactoryfittingStocksList',
            sfHeader: defaultHeader,
            rownumbers : true,
            shrinkToFit:true,
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
   
    function closeBatchForm() {
        layer.close(xiugai);
    }

    function fmtCode(rowData){
        return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.code+'</a>';
    }


    function showDetail(id){
        var a = document.getElementById("printStock");
        a.removeAttribute("href");
        $("#printStock").prop("href","${ctx}/printFitting/printStock?id="+id+"&number=1");
        hrefs = "${ctx}/printFitting/printStock?id="+id;
        $.ajax({
            url:'${ctx}/fitting/stock/ajaxFittingById',
            data:{id: id},
            success:function(result){
                var code=result.code;
                var imgstr='';
                if(!isBlank(result.img)){
                    var images=result.img.split(",");
                    for(var i=0;i<images.length;i++){
                        if(!isBlank(images[i])){
                            imgstr+="<div class='imgWrap f-l spimg1 mr-10' >";
                            imgstr+="<img src='${commonStaticImgPath}"+images[i]+"'/>";
                            imgstr+=" </div>";
                        }
                    }
                }
                $("#imagesHtml").empty().append(imgstr);
                $("#imagesHtml .imgWrap").imgShow();

                $(".bjdetailbox").find("#qrcode").empty();
                $('.bjdetailbox').find("#qrcode").qrcode({width: 100, height: 100, text: code});
                $(".bjdetailbox").find("input[name='code']").val(result.code);
                $(".bjdetailbox").find("input[name='fname']").val(result.name);
                $(".bjdetailbox").find("input[name='brand']").val(result.brand);
                $(".bjdetailbox").find("input[name='version']").val(result.version);
                $(".bjdetailbox").find("input[name='category']").val(result.suitCategory);
                $("#fttId").val(result.id);
                if(result.type==1){
                    $(".bjdetailbox").find("input[name='type']").val("配件");
                }else if(result.type==2){
                    $(".bjdetailbox").find("input[name='type']").val("耗材");
                }
                $(".bjdetailbox").find("input[name='unit']").val(result.unit);
                $(".bjdetailbox").find("input[name='warning']").val(result.warning);
                $(".bjdetailbox").find("input[name='sitePrice']").val(result.sitePrice);
                $(".bjdetailbox").find("input[name='employePrice']").val(result.employePrice);
                $(".bjdetailbox").find("input[name='customerPrice']").val(result.customerPrice);
                $(".bjdetailbox").find("input[name='location']").val(result.location);
                if(result.refundOldFlag==0){
                    $(".bjdetailbox").find("input[name='refundOldFlag']").val("不需要返还 ");
                }else if(result.refundOldFlag==1){
                    $(".bjdetailbox").find("input[name='refundOldFlag']").val("需要返还 ");
                }
                $(".bjdetailbox").find("input[name='supplier']").val(result.supplier);

                $("#tiaoCode").html(result.code);
                $("#tiaoName").html(result.name);
                $("#tiaoVersion").html(result.version);
                $("#tiaoBrand").html(result.brand);
                $("#tiaoV").html(result.suitCategory);
                if(isBlank(result.location)){
                $("#kuweiV").html('');
                }else{
                $("#kuweiV").html(result.location);
                }
                var code=result.code;
                $('#barcode').empty().qrcode({width: 110, height: 110, text:code});
                $(".bjdetailbox").popup();
            }
        });
    }

    function search(){
    	var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
        var checkFlag = true;
        $("input.numberTest").each(function(){
            if($(this).val() != "" && !Number($(this).val()) && $(this).val() !='0'){
                layer.msg("请输入正确库存数量!");
                $(this).val("");
                checkFlag = false;
            }
        });
        if(!checkFlag){
            return;
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    // 弹出手动入库页面
    var lon=0;//计算行数
    var flge=false;
    function sdruku(){
        $("#sdrk_tbd").empty();
        if(flge){
            return;
        }
        $(".bjsdrkbox").popup();
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var rowDatas =[];
        if(ids != null || ids.length != 0){
            for(var i = 0; i < ids.length; i++){
                var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
                rowDatas.push(rowData);
            }
        }
        var html = '';
        lon=ids.length+1;
        flge = true;
        for (var i = 0; i < rowDatas.length; i++) {
            html += '';
            html += '<tr name="sdrk_tr">';
            html += '<td class="text-c code-' + i + '" title="' + rowDatas[i].code + '"> ' + rowDatas[i].code + '</td>';
            html += '<td class="text-c name-' + i + ' text-overflow" title="' + rowDatas[i].name + '"> ' + rowDatas[i].name + '</td>';
            html += '<td class="text-c version-' + i + ' text-overflow" title="' + rowDatas[i].version + '"> ' + rowDatas[i].version + '</td>';
            html += '	<input type="hidden" class="warning-' + i + '" name="warning" value="' + rowDatas[i].warning + '">';
            html += '	<input type="hidden" class="id-' + i + '" name="id" value="' + ids[i] + '">';
           /*  html += '	<td class="text-c brand-' + i + '"> ' + rowDatas[i].suit_brand + '</td>';  */
            html += '	<td class="text-c category-' + i + '">' + rowDatas[i].suit_category + '</td>';
            html += '	<td class="text-c"><input type="text" class="input-text num-' + i + '" name="num"/></td>';
            html += '	<td class="text-c"><input type="text" class="input-text price-' + i + '" name="price" value="' + rowDatas[i].site_price + '"/></td>';
            html += '<td class="text-c"><a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>';
            html += '</tr>';
        }

        html += '<tr name="sdrk_tr">';
        html += '	<td class="text-c">';
        html += '	<select class="select w-130 code code-' + ids.length + '"  name="fittingCode"  >    ';
        html += '  <option value=""></option>';
        html += '    </select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 name name-' + ids.length + '"  name="fittingName" id="fittingName" >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 version version-' + ids.length + '" name="fittingVersion" id="fittingVersion" >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<input type="hidden" class="warning-' + ids.length + '" name="warning" >';
        html += '	<input type="hidden" class="id-' + ids.length + '" name="id" >';
       /*  html += '	<td class="text-c  brand-' + ids.length + '"></td>'; */
        html += '	<td class="text-c  category-' + ids.length + '"></td>';
        html += '	<td class="text-c"><input type="text" class="input-text num-' + ids.length + '" name="num"/></td>';
        html += '	<td class="text-c"><input type="text" class="input-text price-' + ids.length + '" name="price" /></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';


        $("#sdrk_tbd").empty().html(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".code-" + ids.length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/factoryfitting/stocks/getFactoryFittingsBySelect',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i = 0; i < data.list.length; i++) {
                            var code = data.list[i].columns.code;
                            itemList.push({id: code, text: code});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) {
                    return markup;
                }, // 自定义格式化防止xss注入
                minimumInputLength: 3,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo) {
                    return repo.text;
                }, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo) {
                    return repo.text;
                } // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".name-" + ids.length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/factoryfitting/stocks/getFactoryFittingsNameBySelect',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i = 0; i < data.list.length; i++) {
                            var code = data.list[i].columns.code;
                            var name = data.list[i].columns.name;
                            itemList.push({id: code, text: name});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) {
                    return markup;
                }, // 自定义格式化防止xss注入
                minimumInputLength: 1,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo) {
                    return repo.text;
                }, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo) {
                    return repo.text;
                } // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".version-" + ids.length).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/factoryfitting/stocks/getFactoryFittingsVersionBySelect',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i = 0; i < data.list.length; i++) {
                            var code = data.list[i].columns.code;
                            var version = data.list[i].columns.version;
                            itemList.push({id: code, text: version});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder: '请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) {
                    return markup;
                }, // 自定义格式化防止xss注入
                minimumInputLength: 2,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo) {
                    return repo.text;
                }, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo) {
                    return repo.text;
                } // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width", "130");
        });
        flge = false;
        manuallyStockPosted = false;
    }

    function deleteTR(z){
        $(z).parent('td').parent('tr').remove();
    }

    function addNewTR(length){
        var html = '';
        html += '<tr name="sdrk_tr">';
        html += '	<td class="text-c">';
        html += '	<select class="select w-130 code code-' + length + '"  name="fittingCode" datatype="*" nullmsg ="请选择工程师" >    ';
        html += '  <option value=""></option>';
        html += '    </select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 name name-' + length + '"  name="fittingName" id="fittingName" >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 version version-' + length + '" name="fittingVersion" id="fittingVersion">    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<input type="hidden" class="warning-' + length + ' " name="warning" >';
        html += '	<input type="hidden" class="id-' + length + ' " name="id" >';
       /*  html += '	<td class="text-c brand-' + length + '"></td>'; */
        html += '	<td class="text-c category-' + length + '"></td>';
        html += '	<td class="text-c"><input type="text" class="input-text num-' + length + '" name="num"/></td>';
        html += '	<td class="text-c"><input type="text" class="input-text price-' + length + '" name="price" /></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';

        $("#sdrk_tbd").append(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js",function(){
            $("#sdrk_tbd").find(".code-"+length).select2({
                ajax: {
                    type:'post',
                    url: '${ctx}/factoryfitting/stocks/getFactoryFittingsBySelect',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i=0;i<data.list.length;i++) {
                            var code=data.list[i].columns.code;
                            itemList.push({id: code, text: code});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder:'请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) { return markup; }, // 自定义格式化防止xss注入
                minimumInputLength: 3,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo){return repo.text;}, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo){return repo.text;} // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width","130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js",function(){
            $("#sdrk_tbd").find(".name-"+length).select2({
                ajax: {
                    type:'post',
                    url: '${ctx}/factoryfitting/stocks/getFactoryFittingsNameBySelect',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i=0;i<data.list.length;i++) {
                            var code=data.list[i].columns.code;
                            var name=data.list[i].columns.name;
                            itemList.push({id: code, text: name});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder:'请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) { return markup; }, // 自定义格式化防止xss注入
                minimumInputLength: 1,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo){return repo.text;}, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo){return repo.text;} // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width","130");
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js",function(){
            $("#sdrk_tbd").find(".version-"+length).select2({
                ajax: {
                    type:'post',
                    url: '${ctx}/factoryfitting/stocks/getFactoryFittingsVersionBySelect',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i=0;i<data.list.length;i++) {
                            var code=data.list[i].columns.code;
                            var version=data.list[i].columns.version;
                            itemList.push({id: code, text: version});
                        }
                        return {
                            results: itemList,//itemList
                            pagination: {
                                more: (params.page * 10) < data.total_count
                            }
                        };
                    },
                    cache: true
                },
                placeholder:'请输入搜索',//默认文字提示
                language: "zh-CN",
                // tags: true,//允许手动添加
                allowClear: true,//允许清空
                escapeMarkup: function (markup) { return markup; }, // 自定义格式化防止xss注入
                minimumInputLength: 2,//最少输入多少个字符后开始查询
                formatResult: function formatRepo(repo){return repo.text;}, // 函数用来渲染结果
                formatSelection: function formatRepoSelection(repo){return repo.text;} // 函数用于呈现当前的选择
            });
            $("#sdrk_tbd").find(".selection").css("width","130");
        });

    }


    var fla=false;
    $(function(){
        $("#sdrk_tbd").change(function(e){
            if(fla){
                return;
            }
            var codeOrnameOrversion = $(e.target).attr('class');//选中的值的class
            var valu=$(e.target).val();//选中的值（code）
            if(codeOrnameOrversion.indexOf("code")>0){
                fla=true;
                var va=new Array();
                va=codeOrnameOrversion.split(" ");
                var val=new Array();
                val=va[3].split("-");
                var fitName="name-"+val[1];//获取配件名称的class
                var fitversion="version-"+val[1];//获取配件型号的class
                var price="price-"+val[1];//获取配件最新入库价格的class
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var brand="brand-"+val[1];//获取备件品牌class
                var category="category-"+val[1];//获取备件品类class

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/factoryfitting/stocks/getFactoryFittingsByCode',dataType:"json",
                    success: function (result) {
                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }


                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow " title="'+valu+'">'+valu+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c  text-overflow"  title="'+result.columns.code+'">'+result.columns.name+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c  text-overflow" title="'+result.columns.code+'">'+result.columns.version+'</td>');

                        //最新入库价格
                        $("."+price).val(result.columns.site_price);
                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        /* $("."+brand).text(result.columns.suit_brand); */
                        $("."+category).text(result.columns.suit_category);
                    }
                })


                fla=false;
            }else if(codeOrnameOrversion.indexOf("name")>0){
                fla=true;
                var va=new Array();
                va=codeOrnameOrversion.split(" ");
                var val=new Array();
                val=va[3].split("-");
                var fitName="code-"+val[1];//获取配件条码的class
                var fitversion="version-"+val[1];//获取配件型号的class
                var price="price-"+val[1];//获取配件最新入库价格的class
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var brand="brand-"+val[1];//获取备件品牌class
                var category="category-"+val[1];//获取备件品类class

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/factoryfitting/stocks/getFactoryFittingsByCode',dataType:"json",
                    success: function (result) {

                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }

                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow  " title="'+valu+'">'+result.columns.name+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.code+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.version+'</td>');

                        //最新入库价格
                        $("."+price).val(result.columns.site_price);
                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        /* $("."+brand).text(result.columns.suit_brand); */
                        $("."+category).text(result.columns.suit_category);
                    }
                })
                fla=false;
            }else if(codeOrnameOrversion.indexOf("version")>0){
                fla=true;
                var va=new Array();
                va=codeOrnameOrversion.split(" ");
                var val=new Array();
                val=va[3].split("-");
                var fitName="code-"+val[1];//获取配件条码的class
                var fitversion="name-"+val[1];//获取配件名称的class
                var price="price-"+val[1];//获取配件最新入库价格的class
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var brand="brand-"+val[1];//获取备件品牌class
                var category="category-"+val[1];//获取备件品类class

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/factoryfitting/stocks/getFactoryFittingsByCode',dataType:"json",
                    success: function (result) {

                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }

                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.version+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.code+'</td>');
                        $(".name-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.name+'</td>');

                        //最新入库价格
                        $("."+price).val(result.columns.site_price);
                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        /* $("."+brand).text(result.columns.suit_brand); */
                        $("."+category).text(result.columns.suit_category);
                    }
                })
                fla=false;
            }
        })
    })



    function fmtFitType(rowDate){
        if(rowDate.type==1){
            return '配件';
        }else if(rowDate.type==2){
            return "耗材";
        }else{
            return "--";
        }
    }

    //手动入库
    function doSdrk() {
        if (manuallyStockPosted) {
            // 防多次点击
            return;
        }

        var str = "";
        var check = true;
        var si=$("tr[name='sdrk_tr']").length;
        $("tr[name='sdrk_tr']").each(function (index) {
            var numReg =  /^(-?\d+)(\.\d+)?$/;
            var id = $(this).find("input[name='id']").val();//备件id
            var num = $(this).find("input[name='num']").val();//新的入库数量
            var price = $(this).find("input[name='price']").val(); //最新入库价格

            if(((index+1)!=si) && num==''){
                layer.msg("请输入第"+(index+1)+"行的入库数量");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if(((index+1)!=si) && !numReg.test(num)){
                layer.msg("您输入的第"+(index+1)+"行的入库数量格式不正确，请重新输入!");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if (((index+1)!=si) && num * 1 <= 0) {
                layer.msg("第"+(index+1)+"行的入库数量要求大于0!");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            var tests = /^\d+(\.\d+)?$/;
            if(!tests.test(price) && ((index+1)!=si) ){
            	layer.msg("第"+(index+1)+"行的入库价格要求不小于0!");
                $(this).find("input[name='price']").focus();
                check = false;
                return;
            }
            if(((index+1)!=si) && isBlank(price)){
                price="no";
            }
            if((index+1)==si){
                return true;
            }
            str = str + id + "," + num + "," + price + "-";
        });
        if (!check) {
        } else {
            manuallyStockPosted = true;
            $.post("${ctx}/factoryfitting/stocks/doInStock", {"data": str}, function (result) {
                if(result==="200"){
                    layer.msg("入库成功!", {time: 500}, function () {
                        $.closeDiv($('.bjsdrkbox'));
                        $("#table-waitdispatch").trigger("reloadGrid");
                    });
                }else if(result==="201"){
                    layer.msg("入库失败，数据传输有误!");
				}else{
                    layer.msg("入库失败!");
				}
            });
        }
    }
    //判断数据是否为空
    function isBlank(val) {
        if(val==null || $.trim(val)=='' || val == undefined) {
            return true;
        }
        return false;
    }

    //批量删除
    function plsc(){
        var idArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");

        if(idArr.length<1){
            layer.msg("请选择记录！");
        }
        else{
            var id;
            var content ="确定删除这个"+idArr.length+"备件？";
            $('body').popup({
                level:3,
                title:"删除备件",
                content:content,
                fnConfirm:function(){
                    for(var i=0 ;i<idArr.length;i++){
                        if(isBlank(id) ){
                            id=idArr[i];
                        }else{
                            id=id+","+idArr[i];
                        }
                    }
                    $.ajax({
                        type : "POST",
                        url : "${ctx}/factoryfitting/stocks/deleteFittings",
                        data :{"ids":id},
                        success : function(data) {
                            if(data=="200"){
                                layer.msg('删除成功!');
                                $("#table-waitdispatch").trigger("reloadGrid");
                                //window.location.reload(true);
                            }else if(data=="420"){
                                layer.msg('备件有申请未完成的记录,不可删除!', {time: 1000});
                            }else{
                            	layer.msg("未知错误，请联系管理员！");
                            }
                        }
                    });
                }
            });
        }
    }

    //备件零售
    function bjls(){
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        if(ids == null || ids.length == 0){
            layer.msg("请选择记录!");
            return ;
        }else if(ids.length >1){
            layer.msg("零售只能选择一条记录!");
            return ;
        }
        $.ajax({
            url:'${ctx}/fitting/stock/ajaxFittingById',
            data:{id: ids[0]},
            success:function(result){
                $("#ls_form").find("input").val("");
                $("#ls_form").find("input[name='code']").val(result.code);
                $("#ls_form").find("input[name='name']").val(result.name);
                $("#ls_form").find("input[name='version']").val(result.version);
                $("#ls_form").find("input[name='sitePrice']").val(result.sitePrice);
                $("#ls_form").find("input[name='customerPrice']").val(result.customerPrice);
                $("#ls_form").find("input[name='warning']").val(result.warning);
                $("#ls_form").find("input[name='id']").val(result.id);//传个id
                $("#ls_form").find("input[name='employePrice']").val(result.employePrice);//工程师价格
                $(".bjlsbox").popup();
            }
        });
    }

    //计算零售总价
    $("input[name='saleAmount']").blur(function(){
        var lingshou=$("input[name='customerPrice']").val();
        var num=$("input[name='saleAmount']").val();
        var zong=lingshou*num;
        $("input[name='saleTotalPrice']").val(zong);
    });

    $("input[name='saleAmount']").blur(function(){
        var amount=$(this).val();//零售数量
        var warning=$("input[name='warning']").val();//库存数量
        if(parseInt(amount)>parseInt(warning)){
            layer.msg("库存数量不足!");
        }
    })

    //零售
    var adpoting = false;
    function doLS(){
        if(adpoting) {
            return;
        }
        var amount=$("input[name='saleAmount']").val();//零售数量
        var warning=$("input[name='warning']").val();//库存数量
        if (!$.trim(amount)) {
            layer.msg("请输入零售数量!");
            return;
        }
        if(parseInt(amount)>parseInt(warning)){
            layer.msg("库存数量不足!");
            return;
        }
        adpoting = true;
        var postData = $("#ls_form").serializeJson();
        $.post("${ctx}/fitting/stock/doLS", postData, function(result){
            if(result==1){
                adpoting = false;
                layer.msg('保存成功');
                $.closeDiv($(".bjlsbox"));
                $('#table-waitdispatch').trigger("reloadGrid");
                adpoting = false;
            }else if(result==0){
                adpoting = false;
                layer.msg('库存数量不足');
                $.closeDiv($(".bjlsbox"));
                $('#table-waitdispatch').trigger("reloadGrid");
                adpoting = false;
            }

        });
    }

    //判断调整原因是否为空并做出提示
    $("#tkccresource").blur(function(){
        var yuanyin=$("#tkccresource").val();
        if(isBlank(yuanyin)){
            layer.msg("请输入调整原因！！");
        }
    });

    //调整库存
    var adpotin = false;
    function saveAdjust() {
        var yuanyin=$("#tkccresource").val();
        var num = $("#adj_num").val();
        var warn = $("#fittingWarning").val();
        if(isBlank(num) || !ck.test(num)){
            layer.msg("调整后库存格式不正确！");
        }else if(isBlank(yuanyin)){
            $("#tkccresource").addClass('mustfill');
            layer.msg("请输入调整原因！！");
        }else{
            if (adpotin) {
                return false;
            }
            var postData = $("#tz_form").serializeJson();
            adpotin = true;
            $.ajax({
                url: '${ctx}/fitting/stock/doTZKC',
                data: postData,
                type: 'post',
                success: function (result) {
                    if (result == "ok") {
                        layer.msg("调整成功！！");
                        $.closeDiv($(".bjtzkkbox"));
                        $("#adj_num").val("1");
                        $("#tkccresource").val("");
                        $("#table-waitdispatch").trigger("reloadGrid");
                    } else {
                        layer.msg("调整失败！！");
                        $.closeDiv($(".bjtzkkbox"));
                        $("#table-waitdispatch").trigger("reloadGrid");
                    }
                },
                complete: function () {
                    adpotin = false;
                }
            });
        }
    }

    //调整库存弹窗加载信息
    function tzkc(id){
        $.ajax({
            url:'${ctx}/fitting/stock/ajaxFittingById',
            data:{id: id},
            type: 'post',
            success:function(result){
                $("#tz_form").find("#tkccresource").val("");
                $("#tz_form").find("input[name='code']").val(result.code);
                $("#tz_form").find("input[name='name']").val(result.name);
                $("#tz_form").find("input[name='version']").val(result.version);
                $("#tz_form").find("input[name='type']").val(result.type);
                $("#tz_form").find("input[name='warning']").val(result.warning);
                $("#tz_form").find("input[name='fittingId']").val(result.id);
                $("#tz_form").find("#adj_num").val(result.warning);
                $(".bjtzkkbox").popup();
            }
        });
    }

    function fmtOper(rowData){
        var html1 = '';
        var html2 = '';
        if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_COMPANYSTOCK_EDIT_BTN")}' === 'true'){
            html1 = '<a href="javascript:modify(\''+rowData.id+'\');" class="c-0383dc"><i class="sficon sficon-edit"></i> 修改</a>&nbsp;&nbsp;';
        }
        if('${fns:checkBtnPermission("FITTINGMGM_FITSTOCK_COMPANYSTOCK_ADJUSTSTOCK_BTN")}' === 'true'){
            html2 = '<a href="javascript:tzkc(\''+rowData.id+'\');" class="c-0383dc"><i class="sficon  sficon-tzkc"></i>   调整库存</a>';
        }

        return html1 + html2;
    }

    function close(selector){
        $("#tkccresource").removeClass('mustfill');
        $.closeDiv($(selector));
    }


    function subNum(){
//	var num = $("#adj_num").val();
//	if(!Number(num*1) && num*1 <= 1){
//		$("#adj_num").val(0);
//	}else{
//		$("#adj_num").val(num*1 - 1);
//	}
        var num = $("#adj_num").val();
        num = $.trim(num) ? parseInt(num) : 0;
        num = num - 1 < 0 ? 0 : num -1;
        $("#adj_num").val(num);
    }
    function addNum(){
        var num = $("#adj_num").val();
        num = $.trim(num) ? parseInt(num) : 0;
//	var warn = $("#fittingWarning").val()
        $("#adj_num").val(num+1);
//	if(!Number(num*1)){
//		$("#adj_num").val(0);
//	}else{
//		if($("#adj_num").val() == "0" || $("#adj_num").val() == 0){
//			$("#adj_num").val(1);
//		}else{
//			$("#adj_num").val(num*1 + 1);
//		}
//	}
    }

    $('#spimg1').imgShow();

    function exports(){
        var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
        var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
        if(idArr>10000){
            $('body').popup({
                level:3,
                title:"导出",
                content:content,
                fnConfirm :function(){
                    location.href="${ctx}/factoryfitting/stocks/exportsSiteLook?formPath=/a/factoryfitting/stocks/factoryfittingStocksHeaderLook&&maps="+$("#searchForm").serialize();
                }

            });
        }else{
            location.href="${ctx}/factoryfitting/stocks/exportsSiteLook?formPath=/a/factoryfitting/stocks/factoryfittingStocksHeaderLook&&maps="+$("#searchForm").serialize();
        }

    }

    function jumpToVIP(){
        layer.open({
            type : 2,
            content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function addEmployFittingApply(){
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        if(ids.length >1){
            layer.msg("一次只能选择一条记录!");
        }else{
            layer.open({
                type : 2,
                content:'${ctx}/fitting/stock/addEmployeFittingApply?id='+ids,
                title:false,
                area: ['100%','100%'],
                closeBtn:0,
                shade:0,
                fadeIn:0,
                anim:-1
            });
        }
    }

    function lastFitting(){//上一条
    	//$.closeDiv($('.bjdetailbox'));
    	fittingDetailMsg('0');
    }

    function nextFitting(){//下一条
    	fittingDetailMsg('1');
    }



	function fittingDetailMsg(mark) {
		var fittingId = $("#fttId").val();
		$.ajax({
			url : '${ctx}/fitting/stock/nextOrLastfittingDetailMsg?mark='
					+ mark + '&id=' + fittingId + '&map='
					+ $("#searchForm").serialize(),
			data : {},
			success : function(data) {
				if (data.code == "200") {
					if (data.data == null) {
						var msg = "";
						if (mark == "0") {
							msg = "没有上一个备件了！";
						}
						if (mark == "1") {
							msg = "没有下一个备件了！";
						}
						layer.msg(msg);
						return false;
					}
					var result = data.data.columns;
					$("#fttId").val(result.id);
					$(".bjdetailbox").find("input[name='code']").val(
							result.code);
					$('#kcImg').removeAttr("src");
					$("#kcImg").attr("src",'${commonStaticImgPath}' + result.img);
					var imagess = result.img;
					$("#imagesHtml").empty();
					var imgHtml = "";
					if(!$.trim(imagess)=='' && imagess!=null){
						var imgArr = imagess.split(",");
						for(var i=0;i<imgArr.length;i++){
							if($.trim(imgArr[i])!='' && imgArr[i]!=null){
								imgHtml+='<div class="imgWrap f-l spimg1 mr-10" id="spimg1">'+
								'<img src="${commonStaticImgPath}'+imgArr[i]+'"  />'+
								'</div>';
							}
						}
					}
					$("#imagesHtml").append(imgHtml);
                    $("#imagesHtml .imgWrap").imgShow();
					$("#fittingImg").val(result.img);
					$(".bjdetailbox").find("#qrcode").empty();
					$('.bjdetailbox').find("#qrcode").qrcode({
						width : 100,
						height : 100,
						text : result.code
					});
					$(".bjdetailbox").find("input[name='fname']").val(result.name);
					$(".bjdetailbox").find("input[name='brand']").val(result.brand);
					$(".bjdetailbox").find("input[name='version']").val(result.version);
					$(".bjdetailbox").find("input[name='category']").val(result.suit_category);
					if (result.type == 1) {
						$(".bjdetailbox").find("input[name='type']").val("配件");
					} else if (result.type == 2) {
						$(".bjdetailbox").find("input[name='type']").val("耗材");
					}
					$(".bjdetailbox").find("input[name='unit']").val(result.unit);
					$(".bjdetailbox").find("input[name='warning']").val(result.warning);
					$(".bjdetailbox").find("input[name='sitePrice']").val(result.site_price);
					$(".bjdetailbox").find("input[name='employePrice']").val(result.employe_price);
					$(".bjdetailbox").find("input[name='customerPrice']").val(result.customer_price);
					$(".bjdetailbox").find("input[name='location']").val(result.location);
					if (result.refund_old_flag == 0) {
						$(".bjdetailbox").find("input[name='refundOldFlag']").val("不需要返还 ");
					} else if (result.refund_old_flag == 1) {
						$(".bjdetailbox").find("input[name='refundOldFlag']").val("需要返还 ");
					}
					$(".bjdetailbox").find("input[name='supplier']").val(result.supplier);
					$("#tiaoCode").html(result.code);
					$("#tiaoName").html(result.name);
					$("#tiaoVersion").html(result.version);
					return;
				} else if (data.code == "420") {
					layer.msg("当前备件信息有误，请刷新后重试！");
					return false;
				} else {
					layer.msg("加载失败，请检查！");
					return false;
				}
			}
		})
	}
	
	
	
	function CreateByFormat(rowData){
		if(!isBlank(rowData.serviceMan) || !isBlank(rowData.login_name)){
			return !isBlank(rowData.serviceMan) ? rowData.serviceMan : rowData.login_name;
		}
		return "";
	}
	
	function codeFormat(rowData){
		return rowData.code;
	}
	
	 function modify(type){
		var idd = "";
		if(type=="1"){
			var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
			if(ids.length < 1){
				layer.msg("请先选择数据！");
				return;
			}
			if(ids.length > 1){
				layer.msg("一次只能对一条数据进行修改！");
				return;
			}
			idd = ids[0];
			xiugai=layer.open({
	            type : 2,
	            content:'${ctx}/factoryfitting/stocks/factoryFittingEditForm?id='+idd,
	            title:false,
	            area: ['100%','100%'],
	            closeBtn:0,
	            shade:0,
	            anim:-1
	        });
		}else{
			xiugai=layer.open({
	            type : 2,
	            content:'${ctx}/factoryfitting/stocks/factoryFittingAddForm',
	            title:false,
	            area: ['100%','100%'],
	            closeBtn:0,
	            shade:0,
	            anim:-1
	        });
		}
        
    }
	 
	 //添加申请
	 //添加备件申请
     function addFactoryFittingApply() {
		var ids = "";
     	var idsArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
     	if(idsArr.length > 0){
     		ids = idsArr.join(",");
     	}
        layer.open({
            type: 2,
            content: '${ctx}/factoryfitting/Apply/addFactoryFittingApplyForm?ids='+ids,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
     }
</script>
<script type="text/javascript" src="${ctxPlugin}/lib/JsBarcode.all.min.js"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html> 	
  <head>
    <title>My JSP 'proLimitList.jsp' starting page</title>
    <meta name="decorator" content="base"/>
	  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	  <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
	  <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
	  <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	  <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	  <script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
	  <style type="text/css">
		 	.btn-import .webuploader-pick{
			  background: #0e8ee7;
			  padding: 0;
			  width: 44px;
			  height: 22px;
				color: #fff;
		  }
			.webuploader-pick{
				background:none;
				color:#22a0e6;
				padding:0;
				width: 100px;
				height: 80px;
			}

			.webuploader-pick img{
				width:100%;
				height:100%;
				position:absolute;
				left:0;
				top:0;
			}

		  .dropdown-display{font-size: 12px}
		  .dropdown-selected{margin-top: 4px}
	  </style>
  </head>
  
  <body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITREGISTE_TAB" html='<a class="btn-tabBar  "  href="${ctx}/fitting/OldFittingWhole?status=0">待入库<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_TAB" html='<a class="btn-tabBar current"  href="${ctx}/fitting/OldStockFittingWhole?status=1">旧件库存<sup  id="tab_c2">0</sup></a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
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
							<th style="width: 76px;" class="text-r">旧件条码：</th>
							<td>
								<input type="text" class="input-text" name= "code"/>
							</td>
							<th style="width: 76px;" class="text-r">旧件名称：</th>
							<td>
								<input type="text" class="input-text" name = "name"/>
							</td>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name = "oumber"/>
							</td>
							<th style="width: 76px;" class="text-r">是否原配：</th>
							<td>
								<span class="select-box">
									<select class="select" name="yrpz_flag">
										<option value="">请选择</option>
										<option value="1">是</option>
										<option value="2">否</option>
									</select>
								</span>
							</td>
							
							<th style="width: 76px;" class="text-r">服务工程师：</th>
							<td id="reloadSpan">
								<span class="w-140 dropdown-sin-2">
									<select class="select select-box w-140" multiple  id="employs" name="employs">
									<c:forEach items="${fns:getEmloyeListForAll(siteId) }" var="emp">
										<c:if test="${emp.columns.status ne 3}">
											<option value="${emp.columns.name }">${emp.columns.name }</option>
										</c:if>
										<c:if test="${emp.columns.status eq 3}">
											<option value="${emp.columns.name }">${emp.columns.name }【离职】</option>
										</c:if>
									</c:forEach>
									</select>
									</select>
								</span>
							</td>
						
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								 <input type="text" class="input-text" name = "customerMobile"/>
							</td>
								<th style="width: 76px;" class="text-r">旧件品牌：</th>
							<td>
								 <input type="text" class="input-text" name = "brand"/>
							</td>
							<th style="width: 76px;" class="text-r">保修类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="warrantyType">
										<option value="">请选择</option>
										<option value="1">保内</option>
										<option value="2">保外</option>  <!--  <span style="left:20px;padding-left: 50px;">&nbsp;&nbsp;&nbsp;&nbsp;</span> -->
									</select>
								</span>
							</td>
							
							<th style="width: 76px;" class="text-r">旧件状态：</th>
							<td>
								<span class="select-box">
									<select class="select" name="status">
										<option value="">请选择</option>
										<option value="1">已入库</option>
										<option value="3">已返厂</option>  
										<option value="4">已报废</option>  
									</select>
								</span>
							</td>
							
							
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">入库时间：</th>
							<td colspan="9">
								
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="ruTimeMin" name="endconfirmTimeMin" value="" class="input-text Wdate " style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="ruTimeMax" name="endconfirmTimeMax"  value="" class="input-text Wdate" style="width:120px">
						
								<label class="text-r lb">登记时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="endTimeMin" name="endTimeMin" value="" class="input-text Wdate" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="endTimeMax" name="endTimeMax"  value="" class="input-text Wdate" style="width:120px">
							
								<label class="text-r lb">返厂时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="returnMin" name="returnMin" value="" class="input-text Wdate w-140" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="returnMax" name="returnMax"  value="" class="input-text Wdate w-140" style="width:120px">
								<label class="text-r lb">报废时间：</label>
							
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})" id="baofeiMin" name="baofeiMin" value="" class="input-text Wdate w-140" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="baofeiMax" name="baofeiMax"  value="" class="input-text Wdate w-140" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<div class="f-l">
					<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_NEW_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="addNew();" id="btnAddnew"><i class="sficon sficon-add"></i>新增</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_FANCHANG_BTN" html='<a onclick="turnBack(3)" class="sfbtn sfbtn-opt"><i class="sficon sficon-fc"></i>返厂</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_BAOFEI_BTN" html='<a onclick="turnBack(4)"  class="sfbtn sfbtn-opt"><i class="sficon sficon-scrap"></i>报废</a>'></sfTags:pagePermission>
				</div>
				<div class="f-r">
					<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_PILIANGDAORU_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="btnImport"><i class="sficon sficon-import"></i>批量导入</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITREGISTE_DELETE_BTN" html='<a href="javascript:plsc();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-rubbish"></i>批量删除</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_EXPORT_BTN" html='<a onclick="return exports()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="FITTINGMGM_FITMSGMGM_FITSTOCK_SETHEADER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>
			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<div class="cl pt-10">
						<div class="f-r">
							<div class="pagination"></div>
						</div>
				</div>
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


<!-- 新增 -->
<div class="popupBox bjtzkkbox" style="width: 750px;">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<form id="tz_form">
			<div class="popupMain cl">
					<div class="f-l w-820">
						<div class="cl mb-10">
							<label class="f-l w-80">用户姓名：</label>
							<input type="text" class="input-text w-160 f-l " name="customerName" />
							<label class="f-l w-80">详细地址：</label>
							<input type="text" class="input-text w-400 f-l"  name="address" />
						</div>
						<div class="cl mb-10">
							<label class="f-l w-80">联系方式：</label>
							<input type="text" class="input-text w-160 f-l " name="mobile" />
							<label class="f-l w-80">旧件条码：</label>
							<input type="text" class="input-text w-160 f-l "  name="oldFitCode" />
							<label class="f-l w-80"><em class="mark">*</em>旧件名称：</label>
							<input type="text" class="input-text w-160 f-l "  name="oldFitName" />
						</div>
						<div class="cl mb-10">
							<label class="f-l w-80">旧件型号：</label>
							<input type="text" class="input-text w-160 f-l "  name="oldFitVersion" />
							<label class="f-l w-80">旧件品牌：</label>
							<input type="text" class="input-text w-160 f-l "  name="oldFitBrand" />
							<label class="f-l w-80"><em class="mark">*</em>登记数量：</label>
							<input type="text" class="input-text w-160 f-l "  name="num" value=""/>
						</div>
						<div class="cl mb-10">
							<label class="f-l w-80">旧件价格：</label>
							<div class="priceWrap w-160 f-l">
								<input type="text" class="input-text f-l"  name="price" value=""/>
								<span class="unit">元</span>
							</div>
							<label class="f-l w-80">是否原配：</label>
							<select class="select w-160 f-l" name="yrpzFlag">
								<option value="1">请选择</option>
								<option value="1">是</option>
								<option value="2">否</option>
							</select>
							<label class="f-l w-80">服务工程师：</label>
							<select class="select w-160" id="empNm"  name="employeName">
								<option value="">请选择</option>
								<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">
									<option value="${emp.columns.id },${emp.columns.name }">${emp.columns.name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="cl mb-10">
							<label class="f-l w-80">备注：</label>
							<textarea type="text" class="input-text h-50 w-640 " name="remarks" ></textarea>
						</div>
						<div class="cl mb-10">
							<label class="f-l w-80">图片：</label>
							<div id="Imgprocess">
							</div>
							<div class="f-l mr-10" id="jiahao">
								<div class="imgWrap jiahao"  >
									<div id="filePicker-add">
										<a href="javascript:;" class="btn-upload"></a>
									</div>
								</div>
							</div>
							<input type="hidden" name="img" value="" id="fittingImage">
						</div>
					</div>
				</div>
				<div class="text-c mb-20">
					<a href="javascript:saveAdjust();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
					<a href="javascript:close();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>
		</form>
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
							<a class="btn-import radius" id="btn-import" >选择</a>
							<%--<input type="file" id="input-file" class="input-file" onchange="getfileName()" />--%>
						</div>
					</div>
					<div class="mt-15 cl c-fd7e2a">
						<label class="w-80 f-l text-r">提示：</label>
						<div class="f-l w-420 lh-26">
							<p>1、仅允许导入“xls”或“xlsx”格式文件，且每次导入建议不超过1000条。</p>
							<p>2、旧件条码唯一，为1-24位字母或数字，如果导入编号存在将会导入失败。</p>
						</div>
					</div>
					<div class="cl mt-20 mb-15">
						<div class="f-l ml-20">
							<a href="${commonFileHead}/fileDownload/SF-OldFittings.xls" class="sfbtn sfbtn-opt3 w-100">下载模板</a>
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
<script type="text/javascript">
    var feedImgsCount = 0;
var sfGrid;
var id = '${headerData.id}';
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';	
var uploaderPic;
var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;//验证价钱的正则表达式
$(function(){
	$.post("${ctx}/fitting/getFittingTabCount",function(result){
		$("#tab_c1").text(result.c1);
		$("#tab_c2").text(result.c2);
	});
	
	$.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
	$.tabfold("#moresearch",".moreCondition",1,"click");
	$('#setHeadersBtn').click(function(){
		$('.addHeaders').tableHeaderSetting({
			id:id,
			defaultId: defaultId,
			sfHeader: defaultHeader,
			sfSortColumns: sortHeader,
			tableHeaderSaveUrl:'${ctx}/operate/site/saveTableHeader'
		}).popup();
	});
	initSfGrid();

	$('#empNm').select2();
    $("#empNm").next(".select2").find(".selection").css("width","160px");

    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
    });

    createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delimgs");

    var $btn =$("#checkExcelBtn");   //校验
    uploader = WebUploader.create({
        // 选完文件后，是否自动上传。
        auto: false,
        swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',
        server: '${ctx}/fitting/checkOldFittingsExcel',
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
        uploader.option( 'server', '${ctx}/fitting/checkOldFittingsExcel');
    });
    uploader.on( 'uploadSuccess', function( file, response ) {
        if(response.operType == "check"){
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
                uploader.option( 'server', '${ctx}/fitting/importOldFitting');
                layer.msg("校验成功，可以导入!");
            }else{
                $("#filename").val('');
                layer.msg("解析Excel错误!");
            }
        }else if(response.operType == "import"){
            layer.closeAll();
            if(response.pass == "y"){
                uploader.option( 'server', '${ctx}/fitting/checkOldFittingsExcel');
                $.closeAllDiv();
                if(response.errorCount > 0){
                    $("#excelErrorDiv").show();
                    $("#excelErrorDetail").attr("href", "${ctx}/common/downloadFile?fileName=ErrorDetail.txt&msg=" + response.errorDetail);
                    $("#excelErrorCount").text(response.errorCount);
                }else{
                    $("#excelErrorDiv").hide();
                }
                $("#excelSuccessCount").text(response.successCount);
                $.post("${ctx}/fitting/getFittingTabCount",function(result){
                    $("#tab_c1").text(result.c1);
                    $("#tab_c2").text(result.c2);
                });
                $("#table-waitdispatch").trigger("reloadGrid");
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
        uploader.option( 'server', '${ctx}/fitting/checkOldFittingsExcel');
        $("#importExcelBtn").addClass("sfbtn-disabled");
        $("#importExcelBtn").attr("disabled", true);
        $("#checkExcelBtn").removeClass("sfbtn-disabled");
        $("#checkExcelBtn").attr("disabled", false);
    });
});

var checkf = true;
//批量删除
function plsc(){
  var idArr=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");

      var id;
  if(idArr.length<1){
      layer.msg("请选择记录！");
  }else{
  	  for(var i=0 ;i<idArr.length;i++){
  		var rowData = $("#table-waitdispatch").jqGrid('getRowData',idArr[i]);
  		if(rowData.status != "已报废"){
  			checkf = false;
  			break            
  		}
         if(isBlank(id) ){
                id=idArr[i];
            }else{
                id=id+","+idArr[i];
            }
        }
  	  if(!checkf){
  		  layer.msg("选择的旧件中含有不为报废件！");
  		return 
  	  }
			checkf = true;

      var content ="确定删除？";
      $('body').popup({
          level:3,
          title:"删除旧件",
          content:content,
          fnConfirm:function(){
            
              $.ajax({
                  type : "POST",
                  url : "${ctx}/fitting/jjpLSC",
                  data :{"idArr":id},
                  success : function(data) {
                      if(data==1){
                          layer.msg('删除成功!');
                          $("#table-waitdispatch").trigger("reloadGrid");
                      }else {
                      	layer.msg('删除失败!');
                      }
                  }
              });
          }
      });
  }
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
            var images="";
            var array=$("input[name='pickerImg']");//单引号 的name替换为相应的name
            for(var i=0;i<array.length;i++) {
                images += $(array[i]).val() + ",";
            }
            $("#fittingImage").val(images);
            if(uploader){
                uploader.reset();
            }
        });

        uploader.on( 'fileQueued', function( file ) {
            if(feedImgsCount==3){
                $("#jiahao").addClass('hide');
            }
            if(parseInt(feedImgsCount) > 3 ){
                layer.msg("最多可上传4张图片！");
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
        if(feedImgsCount > 3){
            $("#jiahao").addClass('hide');
            layer.msg("最多可上传4张图片！");
            return false;
        }
        feedImgsCount=parseInt(feedImgsCount)+1;
        var html =' <div class="f-l imgWrap1 mb-10 appendImage" id="file'+file.id+'"><div class="imgWrap"> ';
        html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="deletePicture(this, \''+file.id+'\')"></a></div>'+
            '<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
        $(site).append(html);
        if(feedImgsCount>=4){
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
        if(feedImgsCount<=7){
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
        $("#fittingImage").val(images);
    }

$('#spimg1').imgShow();

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

function fmtStatus(row){
	if(row.status=='1'){
		return "<span class='oState state-yrk'>已入库</span>";
	}else if(row.status=='3'){
		return "<span class='oState state-yfc'>已返厂</span>";
	}else if(row.status=='4'){
		return "<span class='oState state-ybf'>已报废</span>";
	}else{
		return "";
	}
}

var doc=1;
//初始化jqGrid表格，传递的参数按照说明
function initSfGrid(){
	sfGrid = $("#table-waitdispatch").sfGrid({
		url : '${ctx}/fitting/getWholeOldStockFittings',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		multiselect:true, 
		rownumbers : true,
		onSelectAll:function(rowid) { //点击全选时触发事件
			var rowIds = $('#table-waitdispatch').jqGrid('getDataIDs');//获取jqgrid中所有数据行的id
			if(doc=='1'){
				for(var k=0; k<rowIds.length; k++) {
				   var curRowData = $('#table-waitdispatch').jqGrid('getRowData', rowIds[k]);//获取指定id所在行的所有数据.
			 	   if($.trim(curRowData.status)=="已返厂" ){
			  	  		$('#table-waitdispatch').jqGrid("setSelection", rowIds[k],false);//设置改行不能被选中。
			 		}
			 		doc=2;
				 }
				return;
			}
			if(doc=='2'){
				$("#table-waitdispatch").trigger("reloadGrid");//取消选中
				//$("#cb_table-waitdispatch").parent("lable").removeAttr("style");
				
				$(".ui-jqgrid-htable").find("label").css({'background-position':' -150px -100px'});	
				doc=1;
			}
		},
		onSelectRow:function(id){//选择某行时触发事件
		      var curRowData =  $("#table-waitdispatch").jqGrid('getRowData', id);
		      if($.trim(curRowData.status)=="已返厂" ){
		   		  $("#table-waitdispatch").jqGrid("setSelection", id,false);
		      }
		},
		gridComplete : function() {
			_order_comm.gridNum();
		}

	});
}

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}
//(返厂/报废)
var adpoting = false;
function turnBack(type){
	if(adpoting) {
	    return;
    }
	
	var doing="返厂";
	if(type=='4'){
		doing='报废';
	}
	var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
	
	if(idArr.length<1){
		layer.msg("请选择数据！");
	}else{
		 for(var i=0;i<idArr.length;i++){
			var rowData = $("#table-waitdispatch").jqGrid("getRowData",idArr[i]);//根据上面的id获得本行的所有数据
	        var status= rowData.status;
			 if($.trim(status)=="已报废"){
				layer.msg("您选中的数据中包含已报废的数据！请重新选择！");
				return;
			}
		} 
		
			var id;
			var content="确定要将"+idArr.length+"条旧件"+doing+"?"
				$('body').popup({
					level:3,
					title:"批量入库",
					content:content,
					 fnConfirm :function(){
						 	adpoting = true;
					 		for(var i=0 ;i<idArr.length;i++){
								if(isBlank(id) ){
									id=idArr[i];	
								}else{
									id=id+","+idArr[i];
								}
							} 
				 			$.ajax({
								type : "POST",
								url : "${ctx}/fitting/putOldFitting",
								data :{"idArr":id,"type":type},
								success : function(data) {	
									if(data){
										layer.msg(doing+'成功!');
										$("#table-waitdispatch").trigger("reloadGrid");
										//window.location.reload(true);
									}else{
										layer.msg(doing+'失败!');
									}
								},
				                complete: function() {
				                    adpoting = false;
				                }
							});   
					 }
				});
	}
}

function fmtOper(rowData){
    if(rowData.code){
        return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">' + rowData.code + '</a>';
	} else {
        return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">--</a>';
    }
}

//是否原配转换为字符
 function fmtFitType(row){
	if(row.yrpz_flag==1){
		return '是';
	}else if(row.yrpz_flag==2){
		return "否";
	}else{
		return "";
	}
}


function fmtBxStatus(row) {
	if (row.warranty_type == '1') {
		return '保内';
	}else if (row.warranty_type == '2') {
		return "保外";
	}else {
		return "";
	}
}

function showDetail(id){
	layer.open({
		type : 2,
		content:'${ctx}/fitting/getById?id='+id+"&whereFrom="+1,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1 
	});
}


	function search() {
		var pageSize = $("#pageSize").val();
		if ($.trim(pageSize) == '' || pageSize == null) {
			$("#pageSize").val(20);
		}
		$("#table-waitdispatch").sfGridSearch({
			postData : $("#searchForm").serializeJson()
		});
	}
	function exports() {
		var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
		var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
		if (idArr > 10000) {
			$('body')
					.popup(
							{
								level : 3,
								title : "导出",
								content : content,
								fnConfirm : function() {
									location.href = "${ctx}/fitting/older/export?formPath=/a/fitting/OldStockFittingWhole&&"
											+ $("#searchForm").serialize();
								}

							});
		} else {
			location.href = "${ctx}/fitting/older/export?formPath=/a/fitting/OldStockFittingWhole&&"
					+ $("#searchForm").serialize();
		}

	}

	$(".resetSearchBtn")
			.on(
					"click",
					function() {
						var html = '<span class="w-140 dropdown-sin-2">';
						html += '<select class="select-box w-120"  id="employs" style="display:none" multiple  multiline="true" name="employs"  >';
						html += '<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">';
						html += ' <option value="${emp.columns.name }">${emp.columns.name }</option>';
						html += '</c:forEach>';
						html += '</select>  </span>';
						$("#reloadSpan").html(html);
						$('.dropdown-sin-2')
								.dropdown(
										{
											input : '<input type="text" maxLength="20" placeholder="请输入搜索">',
										});
					});

	function close() {
		$.closeDiv($(".bjtzkkbox"));
	}

	function addNew() {
		$(".bjtzkkbox").find("input").val("");
		$(".bjtzkkbox").find("select").val("");
		$(".bjtzkkbox").find("#img-view").attr("src", "");
        $("#Imgprocess").empty();
		$(".bjtzkkbox").popup();
	}

	var adpoting = false;
	function saveAdjust() {
		var moliereg = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
		var dengNum = /^[0-9]\d*$/;
		if (adpoting) {
			return;
		}
		var customerName = $("input[name='customerName']").val();
		var mobile = $("input[name='mobile']").val();
		var address = $("input[name='address']").val();
		var oldFitCode = $("input[name='oldFitCode']").val();
		var oldFitName = $("input[name='oldFitName']").val();
		var oldFitVersion = $("input[name='oldFitVersion']").val();
		var oldFitBrand = $("input[name='oldFitBrand']").val();
		var num = $("input[name='num']").val();
		var yrpzFlag = $("select[name='yrpzFlag']").val();
		var remarks = $("textarea[name='remarks']").val();
		var empName = $(".bjtzkkbox").find("select[name='employeName']").val();
		var price = $("input[name='price']").val();
		var icon = $("#fittingImage").val();
		if (!isBlank(mobile)) {
			if (!moliereg.test(mobile)) {
				layer.msg("请输入正确的联系方式");
				return;
			}
		}
		if (!isBlank(num)) {
			if (!dengNum.test(num)) {
				layer.msg("请输入正确的登记数量");
				return;
			}
		}
		if (!isBlank(price)) {
			if (!reg.test(price)) {
				layer.msg("旧件价格格式不正确！");
				$("input[name='price']").val("");
				return;
			}
		}
		if (isBlank(oldFitName)) {
			layer.msg("请输入旧件名称！");
		} else if (isBlank(num)) {
			layer.msg("请输入登记数量！");
		} else {
			adpoting = true;
			$.ajax({
				type : "POST",
				url : "${ctx}/fitting/doAddOldFitting",
				data : {
					"oldFitName" : oldFitName,
					"customerName" : customerName,
					"mobile" : mobile,
					"address" : address,
					"oldFitCode" : oldFitCode,
					"oldFitVersion" : oldFitVersion,
					"oldFitBrand" : oldFitBrand,
					"num" : num,
					"yrpzFlag" : yrpzFlag,
					"remarks" : remarks,
					"empIdName" : empName,
					"price" : price,
					"icon" : icon
				},
				success : function(data) {
					if (data) {
						layer.msg('新增成功!');
						$.closeDiv($(".bjtzkkbox"));
						$("#table-waitdispatch").trigger("reloadGrid");
						//window.location.reload(true);
					} else {
						layer.msg(doing + '失败!');
					}
				},
				complete : function() {
					adpoting = false;
				}
			})
		}
	}
</script>
  </body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base" />
<title>全部工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>  --%>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<sfTags:pagePermission authFlag="FITTINGAPPLY_CENTERFITTINGAPPLA_ALLAPPLY_TAB"
							html='<a class="btn-tabBar current" href="${ctx}/fitting/fittingOuterApply/getAllApplyTab">全部申请</a>'></sfTags:pagePermission>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt">
								<i class="sficon sficon-search"></i>
								查询
							</a>
							<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn">
								<i class="sficon sficon-reset"></i>
								重置
							</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1">
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">申请状态：</th>
										<td>
											<span class="select-box">
												<select class="select" name="status">
													<option value="">请选择</option>
													<option value="0">待审核</option>
													<option value="2">待确认</option>
													<option value="4">已完成</option>
													<option value="5">已取消</option>
													<option value="6">审核未通过</option>

												</select>
											</span>
										</td>
										<th style="width: 76px;" class="text-r">备件条码：</th>
										<td>
											<input type="text" class="input-text" name="fittingCode" />
										</td>
										<th style="width: 76px;" class="text-r">备件名称：</th>
										<td>
											<input type="text" class="input-text" name="fittingName" />
										</td>
										<th style="width: 76px;" class="text-r">备件品牌：</th>
										<td>
											<input type="text" class="input-text" name="suitBrand" />
										</td>

										<th style="width: 76px;" class="text-r">适用品类：</th>
										<td>
											<span class="select-box">
												<select class="select" name="suitCategory">
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
							<div class="pt-10 pb-5 cl">
								<div class="f-l">
									<sfTags:pagePermission authFlag="FITTINGAPPLY_CENTERFITTINGAPPLA_ALLAPPLY_APPLYTOCERTER_BTN"
										html='<a href="javascript:addbjsq();" class="sfbtn sfbtn-opt f-l" id="btn-gcssq"><i class="sficon sficon-sqbj"></i>向中心网点申请备件</a>'></sfTags:pagePermission>
								</div>
								<div class="f-r">
									<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn">
										<i class="sficon sficon-reload"></i>
										刷新
									</a>
									<sfTags:pagePermission authFlag="FITTINGAPPLY_CENTERFITTINGAPPLA_ALLAPPLY_HEADERSET_BTN"
										html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
								</div>

							</div>
						</form>
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

	<div class="popupBox addbjsq" style="width: 1045px;">
		<h2 class="popupHead">
			申请备件
			<a  onclick="closed()" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<form action="" id="fittingForm">
				<div class="popupMain" style='max-height: 500px;min-height:300px; overflow: auto;'>
					<div class="pcontent pl-10">
						<table class="table table-border table-bordered table-bg table-sdrk">
							<thead>
								<tr>
									<th style="width: 50px;">序号</th>
									<th class="w-160">备件条码</th>
									<th class="w-160">备件名称</th>
									<th class="w-160">备件型号</th>
									<th class="w-80">备件类型</th>
									<th class="w-80">申请数量</th>
									<th style="width: 200px;">申请备注</th>
									<th class="w-80">操作</th>
								</tr>
							</thead>
							<tbody id="sdrk_tbd"></tbody>
						</table>
						<!-- <div class="mt-10 ">
					备注：<input type="text" style="width:948px" class="input-text applicantFeedback" />
				</div> -->
					</div>
				</div>
			</form>
			<div class="text-c mb-10 mt-10" >
				<a class="sfbtn sfbtn-opt3 w-70 mr-5 fittingBut">保存</a>
				<a onclick="closed()" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
		</div>
	</div>

	<div class="popupBox w-320 vipPromptBox">
		<h2 class="popupHead">提示</h2>
		<div class="popupContainer">
			<div class="popupMain text-c pt-30 pb-20">
				<div class="">
					<i class="iconType iconType2"></i>
					<strong class="f-16">VIP会员功能</strong>
				</div>
				<p class="c-666 lh-26">
					抱歉，此功能需要
					<span class="c-bb3906">开通VIP会员</span>
					后才能使用！
				</p>
				<div class="text-c mt-30">
					<%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
					<span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';			//系统表格的ID
    var ck = /^\d+(\.\d+)?$/

    $(function(){
        $('#btn-gcssq').goHelp('${ctx}/helpindex/indexHelp?a=bjsqsh');
        $.post("${ctx}/fitting/twoStatusCount",function(result){
            $("#tab_c1").text(result[0].sh);
            $("#tab_c2").text(result[1].ck);
        });

        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){
                $(".vipPromptBox").popup();
                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
            }
        });

        $("#fittingName").mouseenter(function(){
            $(this).prev().combobox("showPanel");
            $(".combobox-item").css({"white-space":"nowrap"});
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
       // initializeCodeAndName();
    });

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


    function initializeCodeAndName(){
        $(".addbjsq").find("#fittingCode").select2({
            ajax: {
                type: 'post',
                url: '${ctx}/fitting/stock/getFittingsBySelect',
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
                cache: false
            },
            placeholder: '请输入搜索',//默认文字提示
            language: "zh-CN",
            tags: false,//允许手动添加
            //allowClear: true,//允许清空
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
        $(".addbjsq").find("#fittingName").select2({
            ajax: {
                type: 'post',
                url: '${ctx}/fitting/stock/getFittingsNameBySelect',
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
                cache: false
            },
            placeholder: '请输入搜索',//默认文字提示
            language: "zh-CN",
            tags: false,//允许手动添加
            //allowClear: true,//允许清空
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
        $("#fittingCode").next(".select2").find(".selection").css("width","380px");
        $("#fittingName").next(".select2").find(".selection").css("width","380px");
    }

    var fal='1';
    $("#fittingName").on("change",function(){
        var code = $(this).select2("val");
        if(fal=="2"){
            return;
        }
        if (!isBlank(code)) {
            $.ajax({
                type: "POST",
                url: "${ctx}/fitting/getfitting",
                data: "code=" + code,
                dataType: "json",
                success: function (data) {
                    fal="2";//防止互相影响
                    var obj = eval('data');
                    if (obj.co == '1') {
                        $("#fittingId").val(obj.record.columns.id);
                        $("#fittingVersion").val(obj.record.columns.version);

                        $("#fittingCode").empty().append('<option value='+obj.record.columns.code+'>'+obj.record.columns.code+'</option>');
                        $("#select2-fittingCode-container").empty().append(obj.record.columns.name);

                        $("#fitName").val($("#fittingName").select2('data')[0].text);

                        $("#fittingType").val(obj.record.columns.type);
                        $(".addbjsq").find(".unit").text(obj.record.columns.unit);
                    } else {
                        layer.msg("该条码配件不存在");
                        $("#fittingId").val('');
                        $("#fittingVersion").val('');
                        $("#fittingName").val('');
                        $("#fittingType").val('');

                    }
                },
                complete:function(){
                    fal="1";
                }
            });
        } else {
            clear();
            layer.msg("请选择配件名称");

        }
    })


    $("#fittingCode").on("change",function(){
        var code = $(this).select2("val");
        if(fal=="2"){
            return;
        }
        if (!isBlank(code)) {
            $.ajax({
                type: "POST",
                url: "${ctx}/fitting/getfitting",
                data: "code=" + code,
                dataType: "json",
                success: function (data) {
                    fal="2";//防止互相影响
                    var obj = eval('data');
                    if (obj.co == '1') {
                        $("#fittingId").val(obj.record.columns.id);
                        $("#fittingVersion").val(obj.record.columns.version);

                        $("#fittingName").empty().append('<option value='+obj.record.columns.code+'>'+obj.record.columns.name+'</option>');
                        $("#select2-fittingName-container").empty().append(obj.record.columns.name);

                        var type= obj.record.columns.type;
                        $("#fitName").val($("#fittingName").select2('data')[0].text);
                        $("#fittingType").val(obj.record.columns.type);
                        $(".addbjsq").find(".unit").text(obj.record.columns.unit);
                    } else {
                        layer.msg("该条码配件不存在");
                        $("#fittingId").val('');
                        $("#fittingVersion").val('');
                        $("#fittingName").val('');
                        $("#fittingType").val('');

                    }
                },
                complete:function(){
                    fal="1";
                }
            });
        } else {
            clear();
            layer.msg("请选择配件条码");

        }
    });

    function clear(){
        fal="2";//防止互相影响
        $("#fittingCode").empty();
        $("#select2-fittingCode-container").empty();
        $("#fittingName").empty();
        $("#select2-fittingName-container").empty();
        $("#fittingVersion").val("");
        $("textarea[name='applicantFeedback']").val("");
        fal="1";//防止互相影响
    }


    /* function addbjsq(){
        fal="";
        $('.addbjsq').find("input").val("");
        $('.addbjsq').popup();
    } */
    
 

    $("#fittingApplyNum").blur(function(){
        if(isBlank($("#fittingApplyNum").val())){
            layer.msg("请输入申请数量！");
        }else if(!ck.test($("#fittingApplyNum").val())){
            layer.msg("申请数量格式不正确！");
        }
    });
    

    function fmtOper(row){
        var html = '';
        if(row.status == 0 ){
        	if ('${fns:checkBtnPermission("FITTINGAPPLY_CENTERFITTINGAPPLA_ALLAPPLY_CANCEL_BTN")}' === 'true') {
           		 html = '<span class="oState state-verify c-0383dc"><a href="javascript:Revocation(\''+row.id+'\',\''+row.fitting_name+'\',\''+row.fitting_version+'\');">撤销</a></span>';
        	}
            return html;
        }else if(row.status == 2){
            html='<span class="c-0383dc">——</span>';
            return html;
        }else if(row.status == 3){
        	if ('${fns:checkBtnPermission("FITTINGAPPLY_CENTERFITTINGAPPLA_ALLAPPLY_RUKU_BTN")}' === 'true') {
           		 html = '<span class="oState state-qrck c-0383dc"><a href="javascript:Thelibrary(\''+row.id+'\',\''+row.fitting_name+'\',\''+row.fitting_version+'\');">入库</a></span>';
        	}
            return html;
        }else if(row.status == 4){
            html='<span class="c-0383dc">——</span>';
            return html;
        }else if(row.status == 5){
            html='<span class="c-0383dc">——</span>';
            return html;
        }else if(row.status == 6){
            html='<span><a href="javascript:showDetail(\''+row.id+'\');" class="c-0383dc"><i class="sficon sficon-view"></i>查看</a></span>';
            return html;
        }

        return '<span class="oState state-noopt"></span>';
    }

    function showDetail(id){
        layer.open({
            type : 2,
            content:'${ctx}/fitting/fittingOuterApply/getFittingApplyInfo?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    var subRe=false;
    function Revocation(id,name,version){
        var content = "确认撤销" + name + "(" + version + ")" + "的申请？"
        $('body').popup({
            level:3,
            title:"撤销",
            content:content,
            type:2,
            fnConfirm :function(){
                if(subRe){
                    return;
                }
                subRe=true;
                $.ajax({
                    type:"POST",
                    url: "${ctx}/fitting/fittingOuterApply/revocationApply",
                    traditional: true,
                    data:{"id":id},
                    async:false,
                    success:function(result){
                        if(result=="200"){
                            layer.msg("申请已撤销成功！");
                            $('#table-waitdispatch').trigger("reloadGrid");
                        }else if(result=="405"){
                            layer.msg("该状态不可操作撤销！");
                            $('#table-waitdispatch').trigger("reloadGrid");
                        }else{
                            layer.msg("操作失败!");
                        }
                    },
                    error:function(){
                        layer.alert("系统繁忙!");
                        return;
                    },
                    complete:function(){
                        subRe=false;
                    }
                });
            }
        });
    }

    //入库
    var adpoting = false;
    function Thelibrary(id, name, version) {
        var content = "确认入库" + name + "(" + version + ")" + "？";
        $('body').popup({
            level: 3,
            title: "备件入库",
            content: content,
            type:2,
            fnConfirm: function () {
                if (adpoting) {
                    return;
                }
                adpoting = true;
                $.ajax({
                    type: "POST",
                    url: "${ctx}/fitting/fittingOuterApply/thelibraryApply",
                    data: {id: id},
                    success: function (result) {
                        if(result=="ok"){
                            layer.msg("入库成功！");
                            $('#table-waitdispatch').trigger("reloadGrid");
                        }else{
                            layer.msg("入库失败！");
                        }
                    },
                    complete: function () {
                        adpoting = false;
                    }
                });
            },
            fnCancel: function () {

            }
        });
    }


    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            multiselect:false,
            url : '${ctx}/fitting/fittingOuterApply/getAllApplyList',
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            shrinkToFit: true,
            rownumbers : true,
            gridComplete : function() {
                _order_comm.gridNum();
            }
        });
    }

    function fmtStatus(row){
        if(row.status == 0){
            return '<span class="oState state-waitVerify2">待审核</span>';
        }else if(row.status == 2){
            return '<span class="oState state-waitCk">待出库</span>';
        }else if(row.status == 3){
            return '<span class="oState state-waitCheck">待确认</span>';
        }else if(row.status == 4){
            return '<span  class="oState state-finished">已完成</span>';
        }else if(row.status == 5){
            return '<span class="oState state-canceled">已取消</span>';
        }else if(row.status == 6){
            return "<span class='oState state-verify2nopass'>审核未通过</span>";
        }
        return "<span></span>";
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

    $(".addbjsq").find(".closePopup").on("click",function(){
        $("#fittingName").empty();
        $("#select2-fittingName-container").empty();
        $("#fittingCode").empty();
        $("#select2-fittingCode-container").empty();
    });

    function closed(){
    	resetDatas();
        $("#fittingName").empty();
        $("#select2-fittingName-container").empty();
        $("#fittingCode").empty();
        $("#select2-fittingCode-container").empty();
        $.closeDiv($(".addbjsq"))
    }
    
    function resetDatas(){
    	lon=1;
    	$("#sdrk_tbd").empty();
    }

    function exports(){
        var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
        var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
        if(idArr>10000){
            $('body').popup({
                level:3,
                title:"导出",
                content:content,
                fnConfirm :function(){
                    location.href="${ctx}/fitting/fittingApply/export?formPath=/a/fitting/fittingApply/ApplyallHeader&&maps="+$("#searchForm").serialize();
                }

            });
        }else{
            location.href="${ctx}/fitting/fittingApply/export?formPath=/a/fitting/fittingApply/ApplyallHeader&&maps="+$("#searchForm").serialize();
        }


    }
    
    
    
 // 弹出手动入库页面
    var lon=1;//计算行数
    var flge=false;
    function addbjsq(){
        $("#sdrk_tbd").empty();
        $("#fittingInStockRemarks").val("");
        if(flge){
            return;
        }
        $(".addbjsq").popup();
        var html = '';
       // var nos = (parseInt(lon)+parseInt(1));
        flge = true;
        html += '<tr name="sdrk_tr">';
        html += '	<td class="text-c no no-'+lon+'">'+lon+'</td>';
        html += '	<td class="text-c">';
        html += '		<select class="select w-130 code code-' + lon + '"  name="fittingCode"  >    ';
        html += '  			<option value=""></option>';
        html += '    	</select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  		<select class="select w-130 name name-' + lon + '"  name="fittingName"  >    ';
        html += '  			<option value=""></option>';
        html += '  		</select>';
        html += '   </td>';
        
        html += '	<td class="text-c">';
        html += '  		<select class="select w-130 version version-' + lon + '" name="fittingVersion"  >    ';
        html += '  			<option value="">请选择</option>';
        html += '  		</select>';
        html += '   </td>';
        
        html += '	<td class="text-c type-' + lon + '"></td>';

        html += '	<input type="hidden" class="warning-' + lon + '" name="warning" >';
        html += '	<input type="hidden" class="id-' + lon + '" name="id" >';
        html += '	<td class="text-c"><input type="text" class="input-text center num-' + lon + '" name="num"/></td>';
        html += '	<td class="text-c"><input type="text" class="input-text mark-' + lon + '" name="mark" /></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';


        $("#sdrk_tbd").empty().html(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".code-" + lon).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/stock/getFittingsBySelect',
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

            $("#sdrk_tbd").find(".name-" + lon).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/stock/getFittingsNameBySelect',
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

            $("#sdrk_tbd").find(".version-" + lon).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/stock/getFittingsVersionBySelect',
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

            flge = false;
            manuallyStockPosted = false;
        });
    }
    
    function deleteTR(z){
        $(z).parent('td').parent('tr').remove();
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
                var price="type-"+val[1];//获取配件最新入库价格的class
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var types = "type-"+val[1];
                var nums = "num-"+val[1];

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/fitting/stock/getFittingsByCode',dataType:"json",
                    success: function (result) {
                        var zl=parseInt(val[1]);
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            lon++
                            addNewTR(lon);
                        }


                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow " title="'+valu+'">'+valu+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c  text-overflow"  title="'+result.columns.code+'">'+result.columns.name+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.version+'">'+result.columns.version+'</td>');
                        if(isBlank($("."+nums).val())){
                        	$("."+nums).val('1');
                        }
                        //最新入库价格
                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        var type = result.columns.type;
                        if(type=='1'){
                        	$("."+types).text("配件");
                        }
                        if(type=='2'){
                        	$("."+types).text("耗材");
                        }
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
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var types = "type-"+val[1];
                var nums = "num-"+val[1];

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/fitting/stock/getFittingsByCode',dataType:"json",
                    success: function (result) {

                        var zl=parseInt(val[1]);
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            lon++
                            addNewTR(lon);
                        }

                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow  " title="'+valu+'">'+result.columns.name+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.code+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.version+'">'+result.columns.version+'</td>');

                        //最新入库价格
                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        var type = result.columns.type;
                        if(isBlank($("."+nums).val())){
                        	$("."+nums).val('1');
                        }
                        if(type=='1'){
                        	$("."+types).text("配件");
                        }
                        if(type=='2'){
                        	$("."+types).text("耗材");
                        }
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
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var types = "type-"+val[1];
                var nums = "num-"+val[1];

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/fitting/stock/getFittingsByCode',dataType:"json",
                    success: function (result) {

                        var zl=parseInt(val[1]);
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            lon++
                            addNewTR(lon);
                        }

                        $("."+fitversion).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.name+'">'+result.columns.name+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.code+'">'+result.columns.code+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.version+'">'+result.columns.version+'</td>');
                        if(isBlank($("."+nums).val())){
                        	$("."+nums).val('1');
                        }
                        //库存
                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        var type = result.columns.type;
                        if(type=='1'){
                        	$("."+types).text("配件");
                        }
                        if(type=='2'){
                        	$("."+types).text("耗材");
                        }
                    }
                })
                fla=false;
            } 
        })
    })
    
    function addNewTR(length){
        var html = '';
        html += '<tr name="sdrk_tr">';
        html += '	<td class="text-c no no-'+length+'">'+length+'</td>';
        html += '	<td class="text-c">';
        html += '		<select class="select w-130 code code-' + length + '"  name="fittingCode"  >    ';
        html += '  			<option value=""></option>';
        html += '    	</select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  		<select class="select w-130 name name-' + length + '"  name="fittingName"  >    ';
        html += '  			<option value=""></option>';
        html += '  		</select>';
        html += '   </td>';
        
        html += '	<td class="text-c">';
        html += '  		<select class="select w-130 version version-' + lon + '" name="fittingVersion"  >    ';
        html += '  			<option value="">请选择</option>';
        html += '  		</select>';
        html += '   </td>';
        
        html += '	<td class="text-c type-' + lon + '"></td>';

        html += '	<input type="hidden" class="warning-' + length + ' " name="warning" >';
        html += '	<input type="hidden" class="id-' + length + ' " name="id" >';
        html += '	<td class="text-c"><input type="text" class="input-text num-' + length + '" name="num"/></td>';
        html += '	<td class="text-c"><input type="text" class="input-text mark-' + length + '" name="mark" /></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';

        $("#sdrk_tbd").append(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js",function(){
            $("#sdrk_tbd").find(".code-"+length).select2({
                ajax: {
                    type:'post',
                    url: '${ctx}/fitting/stock/getFittingsBySelect',
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
                    url: '${ctx}/fitting/stock/getFittingsNameBySelect',
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
                    url: '${ctx}/fitting/stock/getFittingsVersionBySelect',
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
    
    $(function(){
    	var reg = /^[1-9]{1}\d*(.\d{1,2})?$|^0.\d{1,2}$/;//数量、价格
        var fa=false;
        $(".fittingBut").click(function(){
        	var fIds = [];
        	var nums = [];
        	var marks = [];
        	var endFalse = false;
        	var h=1;
        	$("#sdrk_tbd").find("tr").each(function(){
        		var fId = $(this).find("input[name='id']").val();
        		if(!isBlank(fId)){
        			var num = $(this).find("input[name='num']").val();
        			if(isBlank(num)){
        				$(this).find("input[name='num']").focus();
        				layer.msg("请填写第"+h+"行的申请数量！");
        				endFalse = true;
        				return false;
        			}
        			if(!reg.test(num)){
        				$(this).find("input[name='num']").focus();
        				layer.msg("第"+h+"行的申请数量格式有误！");
        				endFalse = true;
        				return false;
        			}
        			fIds.push(fId);
        			nums.push(num);
        			var mark = $(this).find("input[name='mark']").val();
        			marks.push("-"+mark);
        		}
        		h++;
        	})
        	if(endFalse){
        		return;
        	}
        	if(fIds.length < 1){
        		layer.msg("请先维护您要申请的备件！");
        		return;
        	}
        	var data = {
        			fIds:fIds.join(","),
        			nums:nums.join(","),
        			marks:marks.join(",")
        	}
            fa=true;
            $.ajax({
                url: "${ctx}/fitting/fittingOuterApply/saveFittingApply",
                type: "POST",
                data: data,
                success: function (data) {
                	fa=false;
                	fal = "2";//防止互相影响
               		var code = data.code;
               		var msg = data.msg;
               		if(code=='420'){
               			layer.msg(msg);
               			return ;
               		}else if(code=='421'){
               			layer.msg(msg);
               			return ;
               		}else if(code=='422'){
               			layer.msg(msg);
               			return ;
               		}else if(code=='200'){
	               		 layer.msg("添加成功");
	                     search();
	                     resetDatas();
	                     $.closeDiv($('.addbjsq'));
               		}else{
               			layer.msg("保存失败，请联系管理员！");
               		}
               		return;
                },
                complete:function(){
                    fa=false;
                    fal="1";//防止互相影响
                },
                error:function(e){
                	layer.msg("保存失败，请联系管理员！");
                	fa=false;
                    fal="1";//防止互相影响
                    return;
                }
            });
            return false;
        })
            	
    })


</script>

</body>
</html>
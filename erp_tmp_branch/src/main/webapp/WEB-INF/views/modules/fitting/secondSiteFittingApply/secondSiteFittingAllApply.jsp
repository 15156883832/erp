<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>全部工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>  --%>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
</head>
<body>
	<div class="sfpagebg bk-gray"><div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="SECONDFITTINF_WAITVERIFY_TAB" html='<a class="btn-tabBar "  href="${ctx }/fitting/fittingOuterApply/waitShenheHeader">待审核<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="SECONDFITTINF_WAITOUTSTOCKS_TAB" html='<a class="btn-tabBar"  href="${ctx }/fitting/fittingOuterApply/waitChukuHeader">待出库<sup  id="tab_c2">0</sup></a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="SECONDFITTINF_ALLAPPLYFITTING_TAB" html='<a class="btn-tabBar current" href="${ctx }/fitting/fittingOuterApply/allApplyHeader">全部申请</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:reset();" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
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
                                    <input type="text" class="input-text" name="fittingCode"/>
                                </td>
                                <th style="width: 76px;" class="text-r">备件名称：</th>
                                <td>
                                    <input type="text" class="input-text" name="fittingName"/>
                                </td>
                               <th style="width: 76px;" class="text-r">二级网点：</th>
								<td>
									<span class="f-l w-140  readonly" >
										<select class="select w-140" name="secondSiteName" id="secondSiteName">
											<option value="">请选择</option>
											<c:forEach items="${listSecondList}" var="lsd">
												<option value="${lsd.columns.name}" <c:if test="${map.secondSiteName == lsd.columns.name }">selected="selected"</c:if>>${lsd.columns.name}</option>
											</c:forEach>
										</select>
									</span>
								</td>
                                </td>
                                <th style="width: 76px;" class="text-r">申请人：</th>
                                <td>
                                    <input type="text" class="input-text" name="employeName"/>
                                </td>
                              	<th style="width: 76px;" class="text-r">申请状态：</th>
								<td>
									<span class="select-box">
										<select class="select" name="status">
											<option value="">请选择</option>
											<option value="0">待审核</option>
											<option value="1">缺件中</option>
											<option value="2">待出库</option>
											<option value="4">已完成</option>
											<option value="5">已取消</option>
											<option value="6">审核未通过</option>
	
										</select>
									</span>
								</td>
                            </tr>
                            <tr>
                            	 <th style="width: 76px;" class="text-r">备件品牌：</th>
                                <td>
                                    <input type="text" class="input-text" name="suitBrand"/>
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
					<div class="f-r">
						<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
						<sfTags:pagePermission authFlag="SECONDFITTINF_ALLAPPLYFITTING_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="SECONDFITTINF_ALLAPPLYFITTING_HEADERSET_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
					</div>
				</div>
			</form>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<!-- pagination -->
					<div class="cl pt-10">
						<div class="f-l">
						<span class="c-f55025">注：</span>
						<span class="oState state-quejian mr-10">缺件中</span>
					</div>
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
	
<script type="text/javascript">
var id = '${headerData.id}';						//服务商表格的ID
var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
var defaultId = '${headerData.defaultId}';			//系统表格的ID
var ck = /^\d+(\.\d+)?$/

$(function(){
	$('#btn-gcssq').goHelp('${ctx}/helpindex/indexHelp?a=bjsqsh');
	initNumber();

	$("#fittingName").mouseenter(function(){
        $(this).prev().combobox("showPanel");
        $(".combobox-item").css({"white-space":"nowrap"});
	});

	$('#employeId').select2();
	$('#orderNumber').select2();

	$("#employeId").next(".select2").find(".selection").css("width","140px");
    $("#orderNumber").next(".select2").find(".selection").css("width","140px");
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
    initializeCodeAndName();
    $("select[name='secondSiteName']").select2();
	$(".selection").css("width","140px");
});

function initNumber(){
	 $.post("${ctx}/fitting/fittingOuterApply/twoStatusCount2", function (result) {
         $("#tab_c1").text(result.ct1);
         $("#tab_c2").text(result.ct2);
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
    $("#fittingCode").next(".select2").find(".selection").css("width","140px");
    $("#fittingName").next(".select2").find(".selection").css("width","140px");
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

                    var type= obj.record.columns.type;
                    if(type == '1'){
                        $("#fittingType").val("备件");
                    }else if (type=='2'){
                        $("#fittingType").val("耗材");
                    }
                    maxpj = parseFloat(obj.record.columns.warning);
                    $("input[name='fittingWarning']").val(maxpj);
                    if (maxpj < 0.1) {
                        layer.msg('该配件已无库存');
                    }
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
                    if(type == '1'){
                        $("#fittingType").val("备件");
                    }else if (type=='2'){
                        $("#fittingType").val("耗材");
                    }
                    maxpj = parseFloat(obj.record.columns.warning);
                    $("input[name='fittingWarning']").val(maxpj);
                    if (maxpj < 0.1) {
                        layer.msg('该配件已无库存');
                    }
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
    $("#fittingType").val("");
    $("input[name='fittingWarning']").val("");
    fal="1";//防止互相影响
}


$("#employeId").on("change",function(){
    if(fal=="2"){
        return;
    }
    $("input[name='customerName']").val("");
    $("#customerM").val("");
    $("input[name='applianceCategory']").val("");
    $("input[name='applianceModel']").val("");
	$("input[name='warrentyType']").val("");
    $("input[name='orderId']").val("");
    var  html='<option value="">请选择</option>';
    $("#orderNumber").empty().append(html);

    var employId=$(this).select2("val");
    var employName=$(this).find("option:selected").text();
    $("#employeName").val(employName);
    if (!isBlank(employId)) {
        $.ajax({
            type: "POST",
            url: "${ctx}/fitting/fittingApply/getOrderByEmp",
            data: {
                employId:employId,
                employName:employName
            },
            dataType: "json",
            success: function (data) {
                var obj = eval('data');
                if(obj!=null){
					var html='';
					html+='<option value="">请选择</option>';
					for(var i=0;i<obj.length;i++){
                        html+=' <option value="'+obj[i].columns.number+'">'+obj[i].columns.number+'</option>';
                    }
                    $("#orderNumber").empty().append(html);
				}
            }
        });
    } else {
        layer.msg("请选择工程师");

    }
})


$("#orderNumber").on("change",function(){
    var number=$(this).select2("val");
    var employeId=$("#employeId").val();
    if (!isBlank(number)) {
        $.ajax({
            type: "POST",
            url: "${ctx}/fitting/fittingApply/getOrderByNumber",
            data: {
                number:number,
                employeId:employeId
			},
            dataType: "json",
            success: function (data) {
                $("input[name='orderId']").val(data.columns.id);
                $("input[name='customerName']").val(data.columns.customer_name);
                $("#customerM").val(data.columns.customer_mobile);
                $("input[name='applianceCategory']").val(data.columns.appliance_category);
                $("input[name='applianceModel']").val(data.columns.appliance_model);
                if (data.columns.warranty_type == "1") {
                    $("input[name='warrentyType']").val("保内");
                } else if (data.columns.warranty_type == "2") {
                    $("input[name='warrentyType']").val("保外");
                } else {
                    $("input[name='warrentyType']").val("");
                }
            }
        });
    } else {
        layer.msg("请输入工单编号");

    }
})

//工程师申请
function addbjsq(){
	fal="";
	$('.addbjsq').find("input").val("");
	$('.addbjsq').popup();
}

var chang="1";
function change(va){
	chang=va;
}

$("#fittingApplyNum").blur(function(){
    if(isBlank($("#fittingApplyNum").val())){
        layer.msg("请输入申请数量！");
    }else if(!ck.test($("#fittingApplyNum").val())){
		layer.msg("申请数量格式不正确！");
	}
});

var fa=false;
$('#fittingForm').Validform({
	btnSubmit: ".fittingBut",
	tiptype: function(msg){
			if(msg != ""){
			layer.msg(msg);
			}
		},
	callback: function (form) {
	    if(fa){
            return;
        }else if(isBlank($("#fittingApplyNum").val())){
			layer.msg("请输入申请数量！");
		}else if($("#fittingApplyNum").val()=="0"){
            layer.msg("请重新输入申请数量！");
        }else if (ck.test($("#fittingApplyNum").val())) {
		    fa=true;
            $.ajax({
                url: "${ctx}/fitting/fittingApply/saveFittingApply",
                type: "POST",
                data: form.serialize(),
                success: function (data) {
                    if (data.noInventory) {
                        layer.msg("库存不足");
                    } else {
                        layer.msg("添加成功");
                        search();
                        if(chang!="1"){
                            $.closeDiv($('.addbjsq'));
                        }
                        fal="2";//防止互相影响
                        $("#fittingName").empty();
                        $("#select2-fittingName-container").empty();
                        $("#fittingCode").empty();
                        $("#select2-fittingCode-container").empty();
                        $("#employeId").val(null).trigger("change");
                        $('#fittingForm').find("input").val("");
                        $('#fittingForm').find("select").val("");
                        var  html='<option value="">请选择</option>';
                        $("#orderNumber").empty().append(html);
                        $("textarea[name='employeFeedback']").val("");
                    }
                },
				complete:function(){
                    fa=false;
                    fal="1";//防止互相影响
				}
            });
        } else {
            layer.msg("申请数量格式不正确");
        }
        return false;
    }
});

function fmtOper(row){
	var html = '';

	 if(row.status == 0 || row.status == 1){
		 if('${fns:checkBtnPermission("SECONDFITTINF_WAITVERIFY_SHENHE_BTN")}' === 'true'){
			 if(row.status == 1){
				 html = '<span class="oState state-quejian " title="缺件中"></span><span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\');">审核</a></span>';
			 }else{
				 html = '<span class="oState state-verify c-0383dc"><a href="javascript:Toexamine(\''+row.id+'\');">审核</a></span>';
			 }
			}
			return html;
		}else if(row.status == 2){
			 if('${fns:checkBtnPermission("SECONDFITTINF_WAITOUTSTOCKS_CHUKU_BTN")}' === 'true'){
					html = '<span class="oState state-qrck c-0383dc"><a href="javascript:Thelibrary(\''+row.id+'\',\''+row.apply_fitting_name+'\',\''+row.apply_fitting_version+'\',\''+row.audit_fitting_num+'\',\''+row.fitStocks+'\');">出库</a></span>';
				}
			return html;
		}

	return '<span class="oState state-noopt"></span>';
}

//出库
var adpoting = false;
function Thelibrary(id,name,version,auditNum,warning){
	if(parseFloat(auditNum)>parseFloat(warning)){
    	layer.msg("库存数量不足");
    	return;
    }else{
	var content = "确认"+name+"("+version+")*"+auditNum+"出库？"
	$('body').popup({
		level:3,
		type:"2",
		title:"备件出库",
		content:content,
		fnConfirm :function (){
			if(adpoting) {
			    return;
		    }
			adpoting = true;
			$.ajax({
				type:"POST",
				url: "${ctx}/fitting/fittingOuterApply/applyOutStocks",
				data:{
					id:id
					},
				success:function(result){
					 if (result == "422") {
                         layer.msg("审核数量要求大于0！");
                     } else if (result == "420") {
                         layer.msg("备件不存在！");
                     }else if (result == "421") {
                         layer.msg("该备件库存不足！");
                     } else if (result == "423") {
                         layer.msg("审核数量要大于审核通过待出库数量！");
                     }else if (result == "424") {
                     	layer.msg("出库失败，备件已出库或已被驳回，请刷新！");
                     }   else if (result == "200") {
                         layer.msg("出库成功！");
                         search();
                         initNumber();
                     } else {
                         layer.msg("出库失败，请检查！");
                     }
                     return;
				},
                complete: function() {
                    adpoting = false;
                }
			});
		},
		fnCancel:function (){

		}
	});
    }
}


//审核gong
function Toexamine(id) {
	layer.open({
		type: 2,
		content: '${ctx}/fitting/fittingOuterApply/secondSiteSHForm?id=' + id,
		title: false,
		area: ['100%', '100%'],
		closeBtn: 0,
		shade: 0,
		anim: -1
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
		url : '${ctx}/fitting/fittingOuterApply/getAllApplyHeaderList',
		sfHeader: defaultHeader,
		sfSortColumns: sortHeader,
		rownumbers : true,
		gridComplete : function() {
			_order_comm.gridNum();
		}
	});
}

function fmtWartype(row){
	if(row.warranty_type == 1){
		return "<span>保外</span>";
	}else if(row.warranty_type == 2){
		return "<span>保内</span>";
	}else{
		return "<span>---</span>";
	}
	return "<span></span>";
}

function fmtOrderNo(rowData){
	return '<a href="javascript:showDetail(\''+rowData.id+'\');">'+rowData.number+'</a>';
}

function showDetail(id){
	layer.open({
		type : 2,
		content:'${ctx}/order/orderDispatch/form?id='+id,
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		fadeIn:0,
		anim:-1
	});
}

function fmtStatus(row){
	 if(row.status == 0 || row.status == 1){
		return '<span class="oState state-waitVerify2">待审核</span>';
	}else if(row.status == 2){
		return '<span class="oState state-waitCk">待出库</span>';
	}else if(row.status == 3){
		return '<span class="oState state-waitLq">待领取</span>';
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
function addNew(){
	layer.open({
		type : 2,
		content:'${ctx}/order/form',
		title:false,
		area: ['100%','100%'],
		closeBtn:0,
		shade:0,
		anim:-1
	});
}


$(".addbjsq").find(".closePopup").on("click",function(){
    $("#fittingName").empty();
    $("#select2-fittingName-container").empty();
    $("#fittingCode").empty();
    $("#select2-fittingCode-container").empty();
});

function closed(){
    $("#fittingName").empty();
    $("#select2-fittingName-container").empty();
    $("#fittingCode").empty();
    $("#select2-fittingCode-container").empty();
	$.closeDiv($(".addbjsq"))
}

function exports(){
	var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
	var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
	if(idArr>10000){
		$('body').popup({
			level:3,
			type:"2",
			title:"导出",
			content:content,
			 fnConfirm :function(){
				 location.href="${ctx}/fitting/fittingOuterApply/export?formPath=/a/fitting/fittingOuterApply/allApplyHeader&&maps="+$("#searchForm").serialize();
			 }

		});
	}else{
		 location.href="${ctx}/fitting/fittingOuterApply/export?formPath=/a/fitting/fittingOuterApply/allApplyHeader&&maps="+$("#searchForm").serialize();
	}


}

function reset(){
	$("#secondSiteName").select2('val', '请选择');
}


</script>
	
</body>
</html>
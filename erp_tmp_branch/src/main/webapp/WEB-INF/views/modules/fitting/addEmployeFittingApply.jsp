<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="decorator" content="base"/>
<title>全部工单</title>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/zh-CN.js"></script>
</head>
<body>
<!-- 添加申请 -->
<div class="popupBox addbjsq">
	<h2 class="popupHead">
		添加工程师备件领取登记
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
	<form action="" id="fittingForm">
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="f-l w-100"><em class="mark">*</em>工  程  师：</label>
					<input type="hidden" id="employeName" name="employeName"/>
					<select class="select f-l w-140" name="employeId" id="employeId" datatype="*" nullmsg ="请选择工程师">
						<option value="">请选择</option>
						<c:forEach items="${emps}" var="emp">
							<option value="${emp.columns.id}">${emp.columns.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100"><em class="mark">*</em>备件条码：</label>
					<span class="w-380 f-l">
						<select class="select w-380" name="fittingCode" id="fittingCode" datatype="*" nullmsg="请选择备件条码" >
						</select>
					</span>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100"><em class="mark">*</em>备件名称：</label>
					<input type="hidden" name="fittingName" id="fitName" value="${fitting.name}"/>
					<span class="w-380 f-l">
						<select class="select w-380"  id="fittingName" datatype="*" nullmsg="请选择备件名称" >
						</select>
					</span>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">备件型号：</label>
					<input type="hidden" id="fittingId" name="fittingId" value="${fitting.id}"/>
					<input type="text" class="input-text w-140 f-l readonly" name="fittingVersion" id="fittingVersion" readonly="readonly" value="${fitting.version}"/>
					<label class="f-l w-100">备件类型：</label>
					<c:if test="${fitting.type eq '1'}">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="fittingType" value="配件"/>
					</c:if>
					<c:if test="${fitting.type eq '2'}">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="fittingType" value="耗材"/>
					</c:if>
					<c:if test="${fitting.type ne '1' && fitting.type ne '2'}">
						<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="fittingType" value=""/>
					</c:if>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">库存数量：</label>
					<div class="priceWrap w-140 f-l">
						<input type="text" class="input-text readonly" readonly="readonly" name="fittingWarning" value="${fitting.warning}"/>
						<span class="unit">件</span>
					</div>

					<label class="f-l w-100"><em class="mark">*</em>申请数量：</label>
					<div class="priceWrap w-140 f-l ">
						<input type="text" class="input-text" name="fittingApplyNum" id="fittingApplyNum" datatype="*" nullmsg="请输入申请数量"/>
						<span class="unit">件</span>
					</div>
				</div>

				<div class="cl mb-10">
					<label class="f-l w-100">工单编号：</label>
					<input type="hidden" name="orderId"/>
					<span class="w-140 f-l">
					<select class="select f-l w-140" name="orderNumber" id="orderNumber">
						<option value="">请选择</option>
						<c:forEach items="${orderList}" var="orders">
							<option value="${orders.columns.number}">${orders.columns.number}</option>
						</c:forEach>
					</select>
					</span>
					<label class="f-l w-100">用户姓名：</label>
					<input type="text" class="input-text w-140 f- readonly" readonly="readonly" name="customerName"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">联系方式：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" id="customerM" name="customerMobile"/>

					<label class="f-l w-100">家电品类：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="applianceCategory"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">家电型号：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="applianceModel"/>

					<label class="f-l w-100">保修类型：</label>
					<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="warrantyType"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-100">备  注：</label>
					<textarea class="input-text w-380 h-50" name="employeFeedback"></textarea>
				</div>
				<div class="mt-25 text-c">
					<a href="javascript:;" id="fittingBut" class="sfbtn sfbtn-opt3 w-110 mr-5 fittingBut" onclick="change(1)">保存，继续添加</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5 fittingBut" onclick="change(2)">保存</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closed()">取消</a>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
var ck = /^\d+(\.\d+)?$/
$(function(){
	$('#employeId').select2();
	$('#orderNumber').select2();

	$("#employeId").next(".select2").find(".selection").css("width","140px");
    $("#orderNumber").next(".select2").find(".selection").css("width","140px");
    initializeCodeAndName();
    fal="";

    $("#fittingCode").next(".select2").find(".selection").css("width","380px");
    $("#fittingName").next(".select2").find(".selection").css("width","380px");

    $("#fittingCode").empty().append('<option value="${fitting.code}">${fitting.code}</option>');
    $("#select2-fittingCode-container").empty().append('${fitting.code}');

    $("#fittingName").empty().append('<option value="${fitting.name}">${fitting.name}</option>');
    $("#select2-fittingName-container").empty().append('${fitting.name}');

    $('.addbjsq').popup();
});


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
                    var name = data.list[i].columns.name+"【库存："+data.list[i].columns.warning+"】";
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
                        parent.layer.msg("库存不足");
                    } else {
                        parent.layer.msg("添加成功");
                        parent.search();
                        if(chang!="1"){
                            $.closeDiv($('.addbjsq'));65
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

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
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

</script>
	
</body>
</html>
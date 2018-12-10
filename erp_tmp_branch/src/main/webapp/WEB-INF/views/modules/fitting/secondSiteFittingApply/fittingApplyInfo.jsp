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
<div class="popupBox addbjsq" style="width: 580px">
    <h2 class="popupHead">
        申请备件
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <form action="" id="fittingForm">
            <div class="popupMain">
                <div class="cl mb-10">
                    <label class="f-l w-120"><em class="mark">*</em>备件条码：</label>
                    <input type="hidden" name="applyFittingCode" value="${applyFitting.columns.apply_fitting_code}"/>
                    <span class="w-380 f-l">
						<select class="select w-380"  value="" id="fittingCode" datatype="*" nullmsg="请选择备件条码" >
                        </select>
					</span>

                </div>
                <div class="cl mb-10">
                    <label class="f-l w-120"><em class="mark">*</em>备件名称：</label>
                    <input type="hidden" name="applyFittingName"  value="${applyFitting.columns.apply_fitting_name}"/>
                    <span class="w-380 f-l">
						<select class="select w-380"  id="fittingName" datatype="*" nullmsg="请选择备件名称" >
                        </select>
					</span>
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-120">备件型号：</label>
                    <input type="hidden" id="fittingId" name="applyFittingId" value="${applyFitting.columns.apply_fitting_id}"/>
                    <input type="text" class="input-text w-140 f-l " name="applyFittingVersion" id="fittingVersion" value="${applyFitting.columns.apply_fitting_version}"/>
                    <label class="f-l w-100">备件类型：</label>
                    <span class="w-140 f-l">
						<select class="select w-140 f-l"  id="fittingType" name="applyFittingType" >
                            <option value="">请选择</option>
                            <option value="1" ${applyFitting.columns.apply_fitting_type eq '1'?'selected':'' }>配件</option>
                            <option value="2" ${applyFitting.columns.apply_fitting_type eq '2'?'selected':'' }>耗材</option>
                        </select>
					</span>
                </div>
                <div class="cl mb-10">
                    <label class="f-l w-120"><em class="mark">*</em>申请数量：</label>
                    <div class="priceWrap w-380 f-l ">
                        <input type="text" class="input-text" name="applyFittingNum" value="${applyFitting.columns.apply_fitting_num}" id="fittingApplyNum" datatype="*" nullmsg="请输入申请数量"/>
                        <span class="unit">${applyFitting.columns.unit}</span>
                    </div>
                </div>

                <div class="cl mb-10">
                    <label class="f-l w-120">申请备注：</label>
                    <textarea class="input-text w-380" style="height: 70px;" id="applicantFeedback" name="applicantFeedback">${applyFitting.columns.applicant_feedback}</textarea>
                </div>
                <div class="mt-25 text-c">
                    <input type="hidden" name="id" value="${applyFitting.columns.id}"/>
                    <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5 fittingBut">重新提交</a>
                    <sfTags:pagePermission authFlag="FITTINGAPPLY_CENTERFITTINGAPPLA_ALLAPPLY_CANCEL_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="Revocation(\'${applyFitting.columns.id}\',\'${applyFitting.columns.apply_fitting_name}\',\'${applyFitting.columns.apply_fitting_version}\')">撤销</a>'></sfTags:pagePermission>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    var ck = /^\d+(\.\d+)?$/

    $(function(){
        initializeCodeAndName();
        $('.addbjsq').popup();

        $("#fittingCode").empty().append('<option value="${applyFitting.columns.apply_fitting_code}">${applyFitting.columns.apply_fitting_code}</option>');
        $("#select2-fittingCode-container").empty().append('${applyFitting.columns.apply_fitting_code}');

        $("#fittingName").empty().append('<option value="${applyFitting.columns.apply_fitting_name}">${applyFitting.columns.apply_fitting_name}</option>');
        $("#select2-fittingName-container").empty().append('${applyFitting.columns.apply_fitting_name}');
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

                       /* $("#fitName").val($("#fittingName").select2('data')[0].text);*/
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

                        $("input[name='applyFittingName']").val($("#fittingName").select2('data')[0].text);

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


    function addbjsq(){
        fal="";
        $('.addbjsq').find("input").val("");
        $('.addbjsq').popup();
    }

    /*撤销*/
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
                            parent.layer.msg("申请已撤销成功！");
                            parent.search();
                            $.closeDiv($('.addbjsq'));
                        }else if(result=="405"){
                            parent.layer.msg("该状态不可操作撤销！");
                            parent.search();
                            $.closeDiv($('.addbjsq'));
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
            $("input[name='applyFittingCode']").val($("#fittingCode").select2("val"));
            if(fa){
                return;
            }else if(isBlank($("#fittingApplyNum").val())){
                layer.msg("请输入申请数量！");
            }else if($("#fittingApplyNum").val()=="0"){
                layer.msg("请重新输入申请数量！");
            }else if (ck.test($("#fittingApplyNum").val())) {
                fa=true;
                $.ajax({
                    url: "${ctx}/fitting/fittingOuterApply/repeatSubmitApply",
                    type: "POST",
                    data: form.serialize(),
                    success: function (data) {
                        if(data=='405'){
                            parent.layer.msg("该网点已非二级网点,请刷新页面！");
                        }else {
                            parent.layer.msg("添加成功");
                            parent.search();
                            $.closeDiv($('.addbjsq'));
                            fal = "2";//防止互相影响
                            $("#fittingName").empty();
                            $("#select2-fittingName-container").empty();
                            $("#fittingCode").empty();
                            $("#select2-fittingCode-container").empty();
                            $('#fittingForm').find("input").val("");
                            $('#fittingForm').find("select").val("");
                            $("textarea[name='applicantFeedback']").val("");
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

</script>

</body>
</html>
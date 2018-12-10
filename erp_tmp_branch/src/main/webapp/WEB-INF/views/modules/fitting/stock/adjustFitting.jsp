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
<body >
<!-- 添加申请 -->
<div class="popupBox bjsdrkbox" style="width: 1130px;">
    <h2 class="popupHead">
        工程师调拨
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer pos-r">
        <div class="popupMain" style="padding-left: 19px;">
            <div class="pcontent" >
                <div>
                    <label class="f-l w-65 mb-10"><em class="mark">*</em>调拨出库：</label>
                    <input id="defaultEmpId"  hidden="hidden"/>
                    <select class="select f-l w-140" name="employeIdss" id="employeId"  datatype="*" nullmsg ="请选择工程师">
                        <option value="">请选择</option>
                        <c:forEach items="${emps}" var="emp">
                            <option value="${emp.columns.id}" <c:if test="${emp.columns.id==employeId }">selected="selected"</c:if>>${emp.columns.name}<c:if test="${emp.columns.status=='3' }">（离职）</c:if></option>
                        </c:forEach>
                    </select>
                </div>
                <table class="table table-border table-bordered table-bg table-sdrk" style='margin-top: 20px;width: 100%;'>
                    <thead>
                    <tr>
                    	<th class="w-80">序号</th>
                        <th class="w-150">备件条码</th>
                        <th class="w-150">备件名称</th>
                        <th class="w-150">备件型号</th>
                        <th class="w-80">备件类型</th>
                        <th class="w-70">当前库存</th>
                        <th class="w-160">调拨入库</th>
                        <th class="w-70">调拨数量</th>
                        <th class="w-70">操作</th>
                    </tr>
                    </thead>
                    <tbody id="sdrk_tbd">
                    <c:forEach var="fitting" items="${fittings}" varStatus="sta">
                        <tr name="sdrk_tr " class="fittingtr">
                        	<td class="text-c sort">${sta.index+1}</td>
                            <td class="text-c  code-${sta.index}">${fitting.columns.code}</td>
                            <td title="${fitting.columns.fittingName}" class="text-c  name-${sta.index}">${fitting.columns.fittingName}</td>
                            <td title="${fitting.columns.version}" class="text-c  version-${sta.index}" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">${fitting.columns.version}</td>
                            <input type="hidden" class=" empfitid id-${sta.index}" name="id" value="${fitting.columns.id}">
                            <input type="hidden" class=" sitefitid id-${sta.index}" name="fid" value="${fitting.columns.fitting_id}">
                            <c:if test="${fitting.columns.type eq 0}">
                                <td class="text-c  type-${sta.index}">耗材</td>
                            </c:if>
                            <c:if test="${fitting.columns.type eq 1}">
                                <td class="text-c  type-${sta.index}">配件</td>
                            </c:if>
                            <c:if test="${fitting.columns.type ne 0 && fitting.columns.type ne 1}">
                                <td class="text-c  type-${sta.index}"></td>
                            </c:if>
                            <td class="text-c stockWarning  warning-${sta.index}">${fitting.columns.warning}</td>
                            
                              <td class="text-c ">
                            	<select class="select f-l w-140 diaoboin dbintos dbintos-${sta.index}" name="dbintos" datatype="*" nullmsg ="请选择工程师">
			                        <option value="">请选择</option>
			                         <c:forEach items="${emps1}" var="emp">
			                            <option value="${emp.columns.id}" >${emp.columns.name}</option>
			                        </c:forEach> 
			                    </select>
                            </td>
                            <td class="text-c"><input type="text" class=" finalnum input-text num-${sta.index}" name="num"/></td>
                            <td class="text-c"><a class="c-0383dc deleFit" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="text-c btnWrap">
            <%--<a href="javascript:sfprint();" class="sfbtn sfbtn-opt3 w-70 mr-5">打印</a>--%>
            <a href="javascript:doSdrk();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
            <a href="javascript:close('.bjsdrkbox');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
        </div>
    </div>
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

<form id="pf1" action="${printServerHost}" method="post" target="_blank" style="display: none;">
    <input type="hidden" name="json" id="p-json" value="">
</form>

<script type="text/javascript">

    var orderHtml='<option value="">请选择</option>';
    var fittings = ${fittingSize};
    $(function(){
    	if('${datas}'=='2'){
    		layer.msg("库存为0的备件不可调拨");
    	}
        $('#employeId').select2();
        $("#employeId").next(".select2").find(".selection").css("width","140px");

        $(".dbintos").select2();
        $(".dbintos").next(".select2").find(".selection").css("width","140px");

        initializeCodeAndName();
        $('.bjsdrkbox').popup();

    });


    var lon=0;//计算行数
    function initializeCodeAndName(){
        var html = '';
        lon=parseInt(fittings);
        html += '<tr name="sdrk_tr" class="fittingtr">';
        html += '   <td class="text-c sort">' + (parseInt($("#sdrk_tbd").find("tr").length)+parseInt(1)) + '</td>';
        html += '	<td class="text-c">';
        html += '	<select class="select w-130 code code-' + lon + '"  name="fittingCode"  >    ';
        html += '  <option value=""></option>';
        html += '    </select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 name name-' + lon + '"  name="fittingName"  >    ';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<td class="text-c version-'+lon+'" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"></td>';

        html += '	<input type="hidden" class=" empfitid id-' + lon + '" name="id" >';
        html += '	<input type="hidden" class=" sitefitid fid-' + lon + '" name="fid" >';
        html += '	<td class="text-c  type-' + lon + '"></td>';
        html += '	<td class="text-c stockWarning  warning-' + lon + '"></td>';
        
        html += '	<td class="text-c ">';
        
        html += ' <select class="select f-l w-140 diaoboin dbintos dbintos-' + lon + '" name="dbintos" datatype="*" nullmsg ="请选择工程师">'+
		        '<option value="">请选择</option>'+
		        '<c:forEach items="${emps1}" var="emp">'+
		            '<option value="${emp.columns.id}" >${emp.columns.name}<c:if test="${emp.columns.status==3 }">（离职）</c:if></option>'+
		        '</c:forEach>'+
		    	' </select>';
        html += '  </td>';
        html += '	<td class="text-c"><input type="text" class="finalnum input-text num-' + lon + '" name="num"/></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';

        $("#sdrk_tbd").append(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".code-" + lon).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/stock/getFittingsBySelectEmp',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page,
                            empId:$("select[name=employeIdss]").val(),
                            ids:getSelecteId()
                        };
                    },
                    processResults: function (data, params) {
                    	if(isBlank($("select[name=employeIdss]").val())){
                    		layer.msg("请先选择调拨出库的工程师！");
                    	}
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
            $(".code-" + lon).next(".select2").find(".selection").css("width", "130");

            $("#sdrk_tbd").find(".name-" + lon).select2({
                ajax: {
                    type: 'post',
                    url: '${ctx}/fitting/stock/getFittingsNameBySelectEmp',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page,
                            empId:$("select[name=employeIdss]").val()
                        };
                    },
                    processResults: function (data, params) {
                    	if(isBlank($("select[name=employeIdss]").val())){
                    		layer.msg("请先选择调拨出库的工程师！");
                    	}
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i = 0; i < data.list.length; i++) {
                            var code = data.list[i].columns.code;
                            var name = data.list[i].columns.name;
                            var warning = data.list[i].columns.warning;
                            var str=name+"【剩余库存："+warning+"】";
                            itemList.push({id: code, text: str});
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
            $(".name-" + lon).next(".select2").find(".selection").css("width", "130");

            $(".dbintos-"+lon).select2();
            $(".dbintos-"+lon).next(".select2").find(".selection").css("width","140px");
            lon=lon+1;
        });

    }

    function deleteTR(z){
        $(z).parent('td').parent('tr').remove();
        for(var i=0;i<$("#sdrk_tbd").find("tr").length;i++){
        	$("#sdrk_tbd").find("tr").eq(i).find(".sort").text(i+1);
        }
    }
    
    function deleAllTR(){
    	$(".deleFit").each(function(){
    		$(this).parent('td').parent('tr').remove();
    	});
    	for(var i=0;i<$("#sdrk_tbd").find("tr").length;i++){
        	$("#sdrk_tbd").find("tr").eq(i).find(".sort").text(i+1);
        }
    }

    function addNewTR(length){
        var html = '';
        html += '<tr name="sdrk_tr" >';
        html += '   <td class="text-c sort">' + (parseInt($("#sdrk_tbd").find("tr").length)+parseInt(1))+ '</td>';
        html += '	<td class="text-c">';
        html += '	<select class="select w-130 code code-' + length + '"  name="fittingCode" datatype="*" nullmsg ="请选择工程师" >';
        html += '  <option value=""></option>';
        html += '    </select>';
        html += '	</td>';

        html += '	<td class="text-c">';
        html += '  <select class="select w-130 name name-' +length + '"  name="fittingName"  >';
        html += '  <option value=""></option>';
        html += '  </select>';
        html += '   </td>';

        html += '	<td class="text-c version-'+length+'" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;"></td>';

        html += '	<input type="hidden" class=" empfitid id-' + length + ' " name="id" >';
        html += '	<input type="hidden" class=" sitefitid fid-' + length + '" name="fid" >';
        html += '	<td class="text-c type-' + length + '"></td>';
        html += '	<td class="text-c stockWarning warning-' + length + '"></td>';
        
        html += '	<td class="text-c ">';
        html += ' <select class="select f-l w-140 diaoboin  dbintos dbintos-' + length + '" name="dbintos" datatype="*" nullmsg ="请选择工程师">'+
		        '<option value="">请选择</option>'+
		        '<c:forEach items="${emps1}" var="emp">'+
		            '<option value="${emp.columns.id}" >${emp.columns.name}<c:if test="${emp.columns.status==3 }">（离职）</c:if></option>'+
		        '</c:forEach>'+
		    	' </select>';
        html += '</td>';
        html += '	<td class="text-c"><input type="text" class=" finalnum input-text num-' + length + '" name="num"/></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';

        $("#sdrk_tbd").append(html);
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js",function(){
            $("#sdrk_tbd").find(".code-"+length).select2({
                ajax: {
                    type:'post',
                    url: '${ctx}/fitting/stock/getFittingsBySelectEmp',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page,
                            empId:$("select[name=employeIdss]").val(),
                            ids:getSelecteId()
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
            $(".code-"+length).next(".select2").find(".selection").css("width","130");

            $("#sdrk_tbd").find(".name-"+length).select2({
                ajax: {
                    type:'post',
                    url: '${ctx}/fitting/stock/getFittingsNameBySelectEmp',
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            q: params.term, // search term 请求参数
                            page: params.page,
                            empId:$("select[name=employeIdss]").val(),
                            ids:getSelecteId()
                        };
                    },
                    processResults: function (data, params) {
                        params.page = params.page || 1;
                        var itemList = [];//当数据对象不是{id:0,text:'ANTS'}这种形式的时候，可以使用类似此方法创建新的数组对象
                        for (var i=0;i<data.list.length;i++) {
                            var code=data.list[i].columns.code;
                            var name=data.list[i].columns.name;
                            var warning = data.list[i].columns.warning;
                            var str=name+"【剩余库存："+warning+"】";
                            itemList.push({id: code, text: str});
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
            $(".name-"+length).next(".select2").find(".selection").css("width","130");

            $(".dbintos-"+length).select2();
            $(".dbintos-"+length).next(".select2").find(".selection").css("width","140px");

            $(".seeDetail").unbind("mouseover");
            $(".seeDetail").unbind("mouseout");

          //  bindEvent();

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
                var price="price-"+val[1];//获取配件最新入库价格的class
                var warn="warning-"+val[1];//获取配件库存的class
                var id="id-"+val[1];//获取配件id的class
                var fid="fid-"+val[1];//获取配件id的class
                var type="type-"+val[1];//获取备件型号class

                $.ajax({type:"post",data:{"code":valu,empId:$("select[name=employeIdss]").val()},url: '${ctx}/fitting/stock/getFittingsByCodeEmpKeep',dataType:"json",
                    success: function (result) {
                        if (result.columns.warning <= 0) {
                            $('.code-' + val[1]).val(null).trigger("change");
                            layer.msg("该备件已无库存,请重新选择!");
                            return;
                        }
                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc deleFit" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }


                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow " title="'+valu+'">'+valu+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c  text-overflow"  title="'+result.columns.name+'">'+result.columns.name+'</td>');
                        $(".version-"+val[1]).text(result.columns.version);
                        $(".version-" + val[1]).attr("title", result.columns.version);

                        //最新入库价格
                        $("."+price).val(result.columns.site_price);
                        $("."+warn).text(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        $("."+fid).val(result.columns.fittingId);
                        if(result.columns.type=="0"){
                            $("."+type).text("耗材");
                        }else if(result.columns.type=="1"){
                            $("."+type).text("配件");
                        }else{
                            $("."+type).text("");
                        }
                        console.log(result.columns.id);
                        $("."+fitName).parent("td").parent("tr").find(".empfitid").val(result.columns.id);
                        $("."+fitName).parent("td").parent("tr").find(".sitefitid").val(result.columns.fittingId);
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
                var fid="fid-"+val[1];//获取配件id的class
                var brand="type-"+val[1];//获取备件型号class

                $.ajax({type:"post",data:{"code":valu,empId:$("select[name=employeIdss]").val()},url: '${ctx}/fitting/stock/getFittingsByCodeEmpKeep',dataType:"json",
                    success: function (result) {
                    	
                    	
                        if (result.columns.warning <= 0) {
                            $('.name-' + val[1]).val(null).trigger("change");
                            layer.msg("该备件已无库存,请重新选择!");
                            return;
                        }
                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc deleFit" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }

                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow  " title="'+valu+'">'+result.columns.name+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.columns.name+'">'+result.columns.code+'</td>');
                        $(".version-"+val[1]).text(result.columns.version);
                        $(".version-" + val[1]).attr("title", result.columns.version);//402882175dcb0bd3015dcb153f3a0000
                       
                        //最新入库价格
                        $("."+price).val(result.columns.site_price);
                        $("."+warn).text(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        $("."+fid).val(result.columns.fittingId);
                        if(result.columns.type=="0"){
                            $("."+type).text("耗材");
                        }else if(result.columns.type=="1"){
                            $("."+type).text("配件");
                        }else{
                            $("."+type).text("");
                        }
                        console.log(result.columns.id);
                        $("."+fitName).parent("td").parent("tr").find(".empfitid").val(result.columns.id);
                        $("."+fitName).parent("td").parent("tr").find(".sitefitid").val(result.columns.fittingId);
                    }
                })
                fla=false;
            }
        })
    })


   

    function closeDrtsBox(){
        window.parent.reloadPage();
        $.closeAllDiv();
    }

    function close(selector){
        $.closeDiv($(selector));
    }

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
    
    function getEmpListByEmpIdString(){
    	var empId = $("select[name=employeIdss]").val();
    	var html = '<option value="">请选择</option>';
    	$.ajax({
    		type:"post",
    		url:"${ctx}/fitting/stock/getEmpListByEmpId",
    		data:{empId:empId},
    		ansy:false,
    		dateType:"json",
    		success:function(data){
    			if(data.length > 0){
    				for(var i=0;i<data.length;i++){
    					html += '<option value="'+data[i].columns.id+'" >'+data[i].columns.name+'</option>';
    				}
    			}
    			
    		}
    	})
    	return html;
    }
    
    function getEmpListByEmpId(){
    	var empId = $("select[name=employeIdss]").val();
    	$.ajax({
    		type:"post",
    		url:"${ctx}/fitting/stock/getEmpListByEmpId",
    		data:{empId:empId},
    		dateType:"json",
    		success:function(data){
    			//$(".diaoboin").empty();
    			var html = '<option value="">请选择</option>';
    			if(data.length > 0){
    				for(var i=0;i<data.length;i++){
    					html += '<option value="'+data[i].columns.id+'" >'+data[i].columns.name+(data[i].columns.status=='3' ? '（离职）' : '')+'</option>';
    				}
    			}
    			console.log(html);
    			$(".diaoboin").each(function(){
    				$(this).empty().append(html);
				})
    		}
    	})
    }
    
    $(function(){
    	$("select[name=employeIdss]").change(function(){
    		getEmpListByEmpId();
    		deleAllTR();
    	})
    	getEmpListByEmpIdString();
    })
    
    function getSelecteId(){
    	var ids = "";
    	$(".empfitid").each(function(){
    		if(isBlank(ids)){
    			ids = $(this).val();
    		}else{
    			ids += ","+ $(this).val();
    		}
    	})
    	return ids;
    }
    
    var adpoting=false;
    function doSdrk() {
        if (adpoting) {
            // 防多次点击
            return;
        }

        var employeId = $("select[name=employeIdss]").val();
        if (isBlank(employeId)) {
            layer.msg("请选择服务工程师");
            return;
        }
        
        
        if($("#sdrk_tbd").find("tr").length < 2){
        	layer.msg("请先维护您要调拨的备件！");
        	return;
        }
        var empIds = "";
        var nums = "";
        var fittingIds = "";
        console.log(($("#sdrk_tbd").find("tr").length-1));
        var mark = "0";
        var errorMsg = "";
        var numReg =  /^(-?\d+)(\.\d+)?$/;
       	for(var i=0;i<($("#sdrk_tbd").find("tr").length-1);i++){
       		var obj = $("#sdrk_tbd").find("tr").eq(i);
       		var stockThis = obj.find(".stockWarning").text();
       		var empId = obj.find("select[name=dbintos]").val();
       		var num = obj.find(".finalnum").val();
       		var fittingId = obj.find(".sitefitid").val();
       		if(isBlank(empId)){
       			mark="1";
       			errorMsg = "请选择第"+(i+1)+"个备件对应的调拨入库的工程师！";
       			break;
       		}
       		if(isBlank(num)){
       			mark="1";
       			errorMsg = "请填写第"+(i+1)+"个备件的调拨数量！";
       			obj.find(".finalnum").focus();
       			break;
       		}
       		if(!numReg.test(num)){
       			mark = "1";
       			errorMsg = "第"+(i+1)+"个备件的调拨数量输入格式有误！";
       			obj.find(".finalnum").focus();
       			break;
       		}
       		if(parseFloat(stockThis) < parseFloat(num)){
       			mark = "1";
       			errorMsg = "第"+(i+1)+"个备件的调拨数量不能大于调拨出库工程师该备件的库存总量！";
       			obj.find(".finalnum").focus();
       			break;
       		}
       		if(isBlank(empIds)){
       			empIds = empId;
       		}else{
       			empIds += ","+ empId;
       		}
       		if(isBlank(nums)){
       			nums = num;
       		}else{
       			nums += ","+ num;
       		}
       		if(isBlank(fittingIds)){
       			fittingIds = fittingId;
       		}else{
       			fittingIds += ","+ fittingId;
       		}
       		//console.log(empId+"--"+nums+"--"+fittingId);
       	}
       	console.log("mark=="+mark)
       	if(mark!="0"){
       		layer.msg(errorMsg);
       		return;
       	}
       	var data = {
       			empIds:empIds,
       			nums:nums,
       			fittingIds:fittingIds,
       			employeId:employeId
       	}
       	adpoting = true;
		$.ajax({
			datatype:{
				"num":/^\d+(\.\d+)?$/
				},
			url:'${ctx}/fitting/stock/doDBSave',
			data:data,
			success:function(re){
				 if(re=="ok"){
					 parent.parent.layer.msg('调拨成功');
					 parent.search();
					 $.closeDiv($('.bjsdrkbox'));
				 }
			},
            complete: function() {
                adpoting = false;
            },
            error:function(){
            	layer.msg("error!");
            	adpoting = false;
            }
		});
    }

</script>

</body>
</html>
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
<!-- 新件返厂 -->
<div class="popupBox bjsdrkbox" style="width: 920px;">
	<h2 class="popupHead">
		新件返厂
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent">
				<div class="cl mb-10">
					<label class="w-90 f-l">返厂单号：</label>
					<input type="text" class="input-text w-177 readonly f-l" value="${number }" style="width:177px;" readonly="readonly" id="number" name="number"/>
					<label class="w-120 f-l">返厂时间：</label>
					<input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:177px;" id="bacFacDate" name="bacFacDate" value="" class="input-text f-l Wdate w-177" >
					<label class="w-120 f-l">返厂操作人：</label>
					<input type="text" class="input-text w-177 f-l readonly" style="width:177px;" readonly="readonly" maxlength="10" value="${uname }" id="dacFacMan" name="dacFacMan"/>
				</div>
				<div class="cl mb-10">
					<label class="w-90 f-l"><em class="mark">*</em>物流名称：</label>
					<span class="select-box w-177 f-l" style="width:177px;">
						<select id="logisticsName" class="select" name="logisticsName">
							<option value="">请选择</option>
							<c:forEach items="${lgn }" var="lgns">
								<option value="${lgns }">${lgns }</option>
							</c:forEach>
						</select>
						</span>
					<%--<input type="text" value="" class="input-text  f-l w-190" id="logisticsName" name="logisticsName"/>--%>
					<label class="w-120 f-l "><em class="mark">*</em>物流单号：</label>
					<input type="text" class="input-text w-177 f-l " style="width:177px;" maxlength="30" value="" id="logisticsNo" name="logisticsNo"/>
					<label class="w-120 f-l">备注：</label>
					<input type="text" class="input-text w-177" style="width:177px;" id="remarks" value="" name="remarks"/>
				</div>
				<table class="table table-border table-bordered table-bg table-sdrk">
					<thead>
					<tr>
						<th class="w-160">备件条码</th>
						<th class="w-160">备件名称</th>
						<th class="w-160">备件型号</th>
						<th class="w-80">备件品牌</th>
						<th class="w-80">适用品类</th>
						<th class="w-220">返厂数量</th>
						<%--<th class="w-100">操作</th>--%>
					</tr>
					</thead>
					<tbody id="sdrk_tbd"></tbody>
				</table>
			</div>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:doSdrk();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
			<a href="javascript:closeThis();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
</div>

<script type="text/javascript">
    $(function(){
    	sdruku();
    });
    var che = /^[0-9]*[1-9][0-9]*$/;
    // 弹出手动入库页面
    var lon=0;//计算行数
    var flge=false;
    function sdruku(){
        $("#sdrk_tbd").empty();
        if(flge){
            return;
        }
        var tIds = '${ids}';
        var ids= [];
        var rowDatas =[];
        if(!isBlank(tIds)){
        	ids = '${ids}'.split(",");
        	$.ajax({
            	type:"post",
            	async:false,
            	url:"${ctx}/fitting/stock/getDefaultReturnList",
            	data:{ids:'${ids}'},
            	success:function(data){
            		rowDatas = data;
            	}
            })
        }
        var html = '';
        lon=ids.length+1;
        flge = true;
        for (var i = 0; i < rowDatas.length; i++) {
            html += '';
            html += '<tr name="sdrk_tr">';
            html += '<td class="text-c code-' + i + '" title="' + rowDatas[i].columns.code + '">' + rowDatas[i].columns.code + '</td>';
            html += '<td class="text-c name-' + i + ' text-overflow" title="' + rowDatas[i].columns.name + '">' + rowDatas[i].columns.name + '</td>';
            html += '<td class="text-c version-' + i + ' text-overflow" title="' + rowDatas[i].columns.version + '"> ' + rowDatas[i].columns.version + '</td>';
            html += '<input type="hidden" class="warning-' + i + '" name="warning" value="' + rowDatas[i].columns.warning + '">';
            html += '<input type="hidden" class="id-' + i + '" name="id" value="' + rowDatas[i].columns.id + '">';
            html += '<td class="text-c brand-' + i + '">' + rowDatas[i].columns.brand + '</td>';
            html += '<td class="text-c category-' + i + '">' + rowDatas[i].columns.suit_category + '</td>';
            html += '<td class="text-c"><input type="text" class="input-text num-' + i + '" name="num"/></td>';
//            html += '<td class="text-c"><a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>';
            html += '</tr>';
        }

//        html += '<tr name="sdrk_tr">';
//        html += '	<td class="text-c">';
//        html += '	<select class="select w-130 code code-' + ids.length + '"  name="fittingCode"  >    ';
//        html += '  <option value=""></option>';
//        html += '    </select>';
//        html += '	</td>';
//
//        html += '	<td class="text-c">';
//        html += '  <select class="select w-130 name name-' + ids.length + '"  name="fittingName" id="fittingName" >    ';
//        html += '  <option value=""></option>';
//        html += '  </select>';
//        html += '   </td>';
//
//        html += '	<td class="text-c">';
//        html += '  <select class="select w-130 version version-' + ids.length + '" name="fittingVersion" id="fittingVersion" >    ';
//        html += '  <option value=""></option>';
//        html += '  </select>';
//        html += '   </td>';
//
//        html += '	<input type="hidden" class="warning-' + ids.length + '" name="warning" >';
//        html += '	<input type="hidden" class="id-' + ids.length + '" name="id" >';
//        html += '	<td class="text-c  brand-' + ids.length + '"></td>';
//        html += '	<td class="text-c  category-' + ids.length + '"></td>';
//        html += '	<td class="text-c"><input type="text" class="input-text num-' + ids.length + '" name="num"/></td>';
//        html += '	<td class="text-c"></td>';
//        html += '</tr>';

        $("#sdrk_tbd").empty();
        $("#sdrk_tbd").append(html);
        $(".bjsdrkbox").popup();
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".code-" + ids.length).select2({
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
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".name-" + ids.length).select2({
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
        });
        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
            $("#sdrk_tbd").find(".version-" + ids.length).select2({
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
        });
        flge = false;
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
        html += '	<td class="text-c brand-' + length + '"></td>';
        html += '	<td class="text-c category-' + length + '"></td>';
        html += '	<td class="text-c"><input type="text" class="input-text num-' + length + '" name="num"/></td>';
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

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/fitting/stock/getFittingsByCode',dataType:"json",
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

                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        $("."+brand).text(result.columns.suit_brand);
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

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/fitting/stock/getFittingsByCode',dataType:"json",
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

                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        $("."+brand).text(result.columns.suit_brand);
                        $("."+category).text(result.columns.suit_category);
                    }
                });
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

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/fitting/stock/getFittingsByCode',dataType:"json",
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

                        $("."+warn).val(result.columns.warning);
                        $("."+id).val(result.columns.id);
                        $("."+brand).text(result.columns.suit_brand);
                        $("."+category).text(result.columns.suit_category);
                    }
                })
                fla=false;
            }
        })
    });


    function fmtFitType(rowDate){
        if(rowDate.type==1){
            return '配件';
        }else if(rowDate.type==2){
            return "耗材";
        }else{
            return "--";
        }
    }

    //新件返厂
    manuallyStockPosted = false;
    function doSdrk() {
        if (manuallyStockPosted) {
            // 防多次点击
            return;
        }
        
        var number = $("#number").val();
//        var bacFacDate = $("#bacFacDate").val();
//        var dacFacMan = $("#dacFacMan").val();
        var logisticName = $("#logisticsName").val();
        var logisticNo = $("#logisticsNo").val();
        var remarks = $("#remarks").val();

        if (isBlank(logisticName)) {
            layer.msg("请填写物流名称");
            return;
        } else if (isBlank(logisticNo)) {
            layer.msg("请填写物流单号");
            return;
        }

        var str = "";
        var check = true;
        var si=$("tr[name='sdrk_tr']").length;
        $("tr[name='sdrk_tr']").each(function (index) {
            var numReg =  /^(-?\d+)(\.\d+)?$/;
            var id = $(this).find("input[name='id']").val();//备件id
            var num = $(this).find("input[name='num']").val();//新的入库数量
            if(!$.trim(num)){
                layer.msg("请输入第"+(index+1)+"行的返厂数量");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if(!numReg.test(num)){
                layer.msg("您输入的第"+(index+1)+"行的返厂数量格式不正确，请重新输入!");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if (num * 1 <= 0) {
                layer.msg("请输入第"+(index+1)+"行的正确的返厂数量!");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
//            if((index+1)==si){
//                return true;
//            }
            str = str + id + "," + num +"-";
        });
        if (!check) {
        } else {
            manuallyStockPosted = true;
            $.ajax({
            	type:"post",
            	data:{"data": str,number:number,logisticName:logisticName,logisticNo:logisticNo,remarks:remarks},
            	url:"${ctx}/fitting/stock/saveNewFittingReturnFactory",
            	success:function(data){
            		var result = data.code;
            		if(result==="200"){
                        window.top.layer.msg("提交成功!");
                       	parent.search();
                        $.closeDiv($('.bjsdrkbox'));
                    }else if(result==="421"){
                        layer.msg("提交失败，数据传输有误!");
    				}else if(result==="420"){
                        layer.msg("提交失败，条码为"+data.msg+"的备件库存不足!");
    				}else if(result==="450"){
                        layer.msg("提交失败，申请单号"+'${number}'+"已存在！");
    				}else if(result==="460"){
                        layer.msg("提交失败，提交的备件中含有厂家不存在的");
    				}else{
                        layer.msg("提交失败!");
    				}
            	},
            	complete:function(){
            		manuallyStockPosted = false;
            		return;
            	},
            	error:function(){
            		manuallyStockPosted = false;
            		layer.msg("ERROR!");
            		return;
            	}
            }) 
        }
    }
    //判断数据是否为空
    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
    
    function closeThis(){
    	$.closeDiv($(".bjsdrkbox"));
    }

</script>
</body>
</html>
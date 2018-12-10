<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="decorator" content="base"/>
	<title>新增备件申请</title>
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
<div class="popupBox bjsdrkbox" style="width: 1045px;">
	<h2 class="popupHead">
		修改备件申请
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<form action="" id="addForm">
				<div class="cl mb-10">
					<label class="w-70 f-l">申请单号：</label><input type="text" class="input-text w-190 readonly mr-15" value="${ffa.number }" readonly="readonly" id="number" name="number"/>
					<label class="w-80"><em class="mark">*</em>收货方：</label><input type="text" class="input-text w-350 readonly mr-15" value="${site.name }" readonly="readonly" />
					<label class="w-80"><em class="mark">*</em>收货人：</label><input type="text" class="input-text w-190" maxlength="10" value="${ffa.customer_name }" id="customerName" name="customerName"/>
				</div>
				<div class="cl mb-10">
					<label class="w-70 f-l"><em class="mark">*</em>联系电话：</label><input type="text" maxlength="20" value="${ffa.customer_contact }" class="input-text w-190 mr-15" id="customerContact" name="customerContact"/>
					<label class="w-80"><em class="mark">*</em>收货地址：</label><input type="text" maxlength="255" value="${ffa.customer_address }" class="input-text w-640" id="customerAddress" name="customerAddress"/>
				</div>
				<div class="cl mb-10 ">
					<label class="w-70 f-l">备注：</label>
					<input type="text" class="input-text f-l" style="width:928px" id="remarks" value="${ffa.apply_mark }" name="remarks"/>
				</div>
				<div class="cl mb-10">
					<label class="w-70 f-l">申请时间：</label>
					<input type="text" class="input-text w-190 f-l readonly" readonly="readonly" value="${ffa.createTime }" id="applyTime" name="applyTime"/>
					<label class="w-100 f-l">申请总金额：</label>
					<div class="priceWrap w-120 f-l readonly">
						<input type="text" class="input-text" readonly="readonly"  id="allMoney" name="allMoney" value="0"/>
						<span class="unit">元</span>
					</div>
					<label class="w-100 f-l">备件押金：</label>
					<span class="f-l lh-26 f-14">当前可用余额 <span class="c-0383dc" id="latestMoney">${site.deposit_left }</span>元</span>
					<!-- <input type="text" class="input-text w-100" name="number"/>元&nbsp;&nbsp; -->
				</div>
				
				<div class="pcontent">
					<table class="table table-border table-bordered table-bg table-sdrk" style="width:998px;table-layout: auto;">
						<thead>
						<tr>
							<th class="w-160">备件条码</th>
							<th class="w-160">备件名称</th>
							<th class="w-160">备件型号</th>
							<th class="w-80">适用品类</th>
							<th class="w-80">单位</th>
							<th class="w-140">价格（元）</th>
							<th class="w-120">申请数量</th>
							<th class="w-100">操作</th>
						</tr>
						</thead>
						<tbody id="sdrk_tbd"></tbody>
					</table>
				</div>
			</form>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:addSave();" class="sfbtn sfbtn-opt3 w-70 mr-5">提交</a>
			<a href="javascript:close('.bjsdrkbox');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
var fla=false;
	$(function(){
		pageShow();
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
                var unit="unit-"+val[1];//获取备件品类class
                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/factoryfitting/stocks/getFactoryFittingsByCode',dataType:"json",
                    success: function (result) {
                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }


                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow " title="'+valu+'">'+valu+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c  text-overflow"  title="'+result.code+'">'+result.name+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c  text-overflow" title="'+result.code+'">'+result.version+'</td>');

                        //最新入库价格
                        $("."+price).text(result.site_price);
                        $("."+warn).val(result.warning);
                        $("."+id).val(result.id);
                        /* $("."+brand).text(result.suit_brand); */
                        $("."+category).text(result.suit_category);
                        $("."+unit).text(result.unit);
                        applyAllMoney();
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
                var unit="unit-"+val[1];//获取备件品类class

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/factoryfitting/stocks/getFactoryFittingsByCode',dataType:"json",
                    success: function (result) {

                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }

                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow  " title="'+valu+'">'+result.name+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.code+'">'+result.code+'</td>');
                        $(".version-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.code+'">'+result.version+'</td>');

                        //最新入库价格
                        $("."+price).text(result.site_price);
                        $("."+warn).val(result.warning);
                        $("."+id).val(result.id);
                        /* $("."+brand).text(result.suit_brand); */
                        $("."+category).text(result.suit_category);
                        $("."+unit).text(result.unit);
                        applyAllMoney();
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
                var unit="unit-"+val[1];//获取备件品类class

                $.ajax({type:"post",data:{"code":valu},url: '${ctx}/factoryfitting/stocks/getFactoryFittingsByCode',dataType:"json",
                    success: function (result) {

                        var zl=parseInt(val[1])+1;
                        if(zl==lon){
                            $(e.target).parent().parent("tr").find("td:last").append('<a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a>');
                            addNewTR(lon);
                            lon+=1;
                        }

                        $("."+va[3]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.code+'">'+result.version+'</td>');
                        $("."+fitName).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.code+'">'+result.code+'</td>');
                        $(".name-"+val[1]).parent("td").replaceWith('<td class="text-c text-overflow" title="'+result.code+'">'+result.name+'</td>');

                        //最新入库价格
                        $("."+price).text(result.site_price);
                        $("."+warn).val(result.warning);
                        $("."+id).val(result.id);
                        /* $("."+brand).text(result.suit_brand); */
                        $("."+category).text(result.suit_category);
                        $("."+unit).text(result.unit);
                        applyAllMoney();
                    }
                })
                fla=false;
            }
        })
        
	})
	
	// 弹出页面
    var lon=0;//计算行数
    var flge=false;
    function pageShow(){
        $("#sdrk_tbd").empty();
        if(flge){
            return;
        }
        $(".bjsdrkbox").popup();
        //var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        
        /* if(ids != null || ids.length != 0){
            for(var i = 0; i < ids.length; i++){
                var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
                rowDatas.push(rowData);
            }
        } */
        var idLenght = 0;
        $.ajax({
        	type:"post",
        	data:{ffId:'${ffa.id}'},
        	url:"${ctx}/factoryfitting/Apply/getApplyDetailDataByApplyId",
        	success:function(data){
        		var ids=[];
                var rowDatas =data;
                idLenght = data.length;
		        var html = '';
		        lon=data.length+1;
		        flge = true;
		        var sumMny = 0;
		        if(rowDatas.length > 0){
			        for (var i = 0; i < rowDatas.length; i++) {
			            html += '';
			            html += '<tr name="sdrk_tr">';
			            html += '<td class="text-c code-' + i + '" title="' + rowDatas[i].code + '"> ' + rowDatas[i].code + '</td>';
			            html += '<td class="text-c name-' + i + ' text-overflow" title="' + rowDatas[i].name + '"> ' + rowDatas[i].name + '</td>';
			            html += '<td class="text-c version-' + i + ' text-overflow" title="' + rowDatas[i].version + '"> ' + rowDatas[i].version + '</td>';
			            html += '	<input type="hidden" class="warning-' + i + '" name="warning" value="">';
			            html += '	<input type="hidden" class="id-' + i + '" name="id" value="' + rowDatas[i].factory_fitting_id + '">';
			            html += '	<input type="hidden" class="detailId-' + i + '" name="detailId" value="' + rowDatas[i].id + '">';
			            /*  html += '	<td class="text-c brand-' + i + '"> ' + rowDatas[i].suit_brand + '</td>';  */
			            html += '	<td class="text-c category-' + i + '">' + rowDatas[i].suit_category + '</td>';
			            html += '	<td class="text-c unit-' + i + '">' + rowDatas[i].unit + '</td>';//单位sitePrice
			            html += '	<td class="text-c pricemark price-' + i + '">' +(isBlank(rowDatas[i].sitePrice) ? rowDatas[i].site_price :rowDatas[i].sitePrice) + '</td>';//价格
			            html += '	<td class="text-c"><input type="text" value="'+rowDatas[i].apply_num+'" class="input-text numbermark num-' + i + '" name="num"/></td>';//申请数量
			            html += '<td class="text-c"><a class="c-0383dc" onclick="deleteTR(this)"><i class="sficon sficon-rubbish"></i>删除</a></td>';
			            html += '</tr>';
			            if((!isBlank(rowDatas[i].site_price)) && (!isBlank(rowDatas[i].apply_num))){
			            	sumMny = (parseFloat(sumMny) + parseFloat(rowDatas[i].site_price) * parseFloat(rowDatas[i].apply_num)).toFixed(2);
			            }
			        }
		        }
				$("#allMoney").val(sumMny);
		        html += '<tr name="sdrk_tr">';
		        html += '	<td class="text-c">';
		        html += '	<select class="select w-130 code code-' + rowDatas.length + '"  name="fittingCode"  >    ';
		        html += '  <option value=""></option>';
		        html += '    </select>';
		        html += '	</td>';
		
		        html += '	<td class="text-c">';
		        html += '  <select class="select w-130 name name-' + rowDatas.length + '"  name="fittingName" id="fittingName" >    ';
		        html += '  <option value=""></option>';
		        html += '  </select>';
		        html += '   </td>';
		
		        html += '	<td class="text-c">';
		        html += '  <select class="select w-130 version version-' + rowDatas.length + '" name="fittingVersion" id="fittingVersion" >    ';
		        html += '  <option value=""></option>';
		        html += '  </select>';
		        html += '   </td>';
		
		        html += '	<input type="hidden" class="warning-' + rowDatas.length + '" name="warning" >';
		        html += '	<input type="hidden" class="id-' + rowDatas.length + '" name="id" >';
		        html += '	<input type="hidden" class="detailId-' + rowDatas.length + '" name="detailId" >';
		       /*  html += '	<td class="text-c  brand-' + ids.length + '"></td>'; */
		        html += '	<td class="text-c  category-' + rowDatas.length + '"></td>';
		        html += '	<td class="text-c  unit-' + rowDatas.length + '"></td>';
		        html += '	<td class="text-c pricemark  price-' + rowDatas.length + '"></td>';
		        html += '	<td class="text-c"><input type="text" class="input-text numbermark num-' + rowDatas.length + '" name="num"/></td>';
		        html += '	<td class="text-c"></td>';
		        html += '</tr>';
		
		
		        $("#sdrk_tbd").empty().html(html);
		        $.getScript("${ctxPlugin}/lib/select/zh-CN.js", function () {
		            $("#sdrk_tbd").find(".code-" + idLenght).select2({
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
		                            var code = data.list[i].code;
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
		            $("#sdrk_tbd").find(".name-" + idLenght).select2({
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
		                            var code = data.list[i].code;
		                            var name = data.list[i].name;
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
		            $("#sdrk_tbd").find(".version-" + idLenght).select2({
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
		                            var code = data.list[i].code;
		                            var version = data.list[i].version;
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
		        sumMoney();
        	}
        })
    }
    
    function deleteTR(z){
        $(z).parent('td').parent('tr').remove();
        applyAllMoney();
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
        html += '	<input type="hidden" class="detailId-' + length + ' " name="detailId" >';
       /*  html += '	<td class="text-c brand-' + length + '"></td>'; */
        html += '	<td class="text-c category-' + length + '"></td>';
        html += '	<td class="text-c unit-' + length + '"></td>';
        html += '	<td class="text-c pricemark price-' + length + '"></td>';
        html += '	<td class="text-c"><input type="text" class="input-text numbermark num-' + length + '" name="num"/></td>';
        html += '	<td class="text-c"></td>';
        html += '</tr>';

        $("#sdrk_tbd").append(html);
        applyAllMoney();
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
                            var code=data.list[i].code;
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
                            var code=data.list[i].code;
                            var name=data.list[i].name;
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
                            var code=data.list[i].code;
                            var version=data.list[i].version;
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
        sumMoney();
    }
    function sumMoney(){
    	$(".numbermark").bind("blur",function(){
    		applyAllMoney();
   		})
    }
    
    function applyAllMoney(){
    	var money = 0;
    	$(".numbermark").each(function(index,el){
    		var num = $(el).val();
    		if(!isBlank(num)){
    			var numReg =  /^(-?\d+)(\.\d+)?$/;
    			var price = $(el).parent("td").parent("tr").find(".pricemark").text();
    			if(!isBlank(price) && numReg.test(num)){
    				money = (parseFloat(money)+parseFloat(num) * parseFloat(price)).toFixed(2);
    			}
    		}
    	})
    	$("#allMoney").val(money);
    	var latestMoney = $("#latestMoney").text();
    	if(parseFloat(latestMoney) < parseFloat(money)){//押金不足
    		layer.msg("可用押金余额不足！");
    	}
    }
    
    
    function isBlank(val) {
        if(val==null || $.trim(val)=='' || val == undefined) {
            return true;
        }
        return false;
    }
    
    var addSaveMark = false;
    function addSave(){
    	if(addSaveMark){
    		return;
    	}
    	var number = $("#number").val();
    	var customerContact = $("#customerContact").val();
    	var customerName = $("#customerName").val();
    	var customerAddress = $("#customerAddress").val();
    	var applyTime = $("#applyTime").val();
    	var remarks = $("#remarks").val();
    	var allMoney = $("#allMoney").val();
    	var latestMoney = $("#latestMoney").text();
    	if(isBlank(customerName)){
    		layer.msg("请填写收货人！");
    		$("#customerName").focus();
    		return;
    	}
    	if(isBlank(customerContact)){
    		layer.msg("请填写联系电话！");
    		$("#customerContact").focus();
    		return;
    	}
    	var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
    	if(!tel.test(customerContact)){
    		layer.msg("联系电话格式不正确！");
    		$("#customerContact").focus();
    		return;
    	} 
    	if(isBlank(customerAddress)){
    		layer.msg("请填写收货地址！");
    		$("#customerAddress").focus();
    		return;
    	}
    	
    	if(parseFloat(latestMoney) < parseFloat(allMoney)){//押金不足
    		layer.msg("备用押金不足！");
    		return;
    	}
    	var str = "";
        var check = true;
        var si=$("tr[name='sdrk_tr']").length;
        $("tr[name='sdrk_tr']").each(function (index) {
            var numReg =  /^(-?\d+)(\.\d+)?$/;
            var id = $(this).find("input[name='id']").val();//备件id
            var num = $(this).find("input[name='num']").val();//申请数量
            var detailId = $(this).find("input[name='detailId']").val();//申请明细id
            var price = $(this).find(".pricemark").text(); //网点价格

            if(((index+1)!=si) && num==''){

                layer.msg("请输入第"+(index+1)+"行的申请数量");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if(((index+1)!=si) && !numReg.test(num)){
                layer.msg("您输入的第"+(index+1)+"行的申请数量格式不正确，请重新输入!");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if (((index+1)!=si) && num * 1 <= 0) {
                layer.msg("第"+(index+1)+"行的申请数量要求大于0!");
                $(this).find("input[name='num']").focus();
                check = false;
                return;
            }
            if(((index+1)!=si) && isBlank(price)){
                price="no";
            }
            if((index+1)==si){
                return true;
            }
            str = str + id + "," + num + "," + price + "," + detailId + "-";
        });
        if(!check){
        	return;
        }
        if(isBlank(str)){
        	layer.msg("请先维护您要申请的备件！");
        	return;
        }
        var postData = {
        		number:number,
        		customerName:customerName,
        		customerContact:customerContact,
        		customerAddress:customerAddress,
        		applyTime:applyTime,
        		remarks:remarks,
        		allMoney:allMoney,
        		str:str,
        		ffaId:'${ffa.id}'
        }
       addSaveMark=true;
       $.ajax({
    		type:"post",
    		data:postData,
    		url:"${ctx}/factoryfitting/Apply/editApplySave",
    		success:function(data){
    			if(data=='200'){
    				parent.search();
    				window.top.layer.msg("提交成功！");
    				close();
    			}else if(data=='420'){
    				layer.msg("提交失败，备件信息有误！");
    			}else  if(data=='421'){
    				layer.msg("提交失败，备件申请信息有误！");
    			}else {
    				layer.msg("提交失败，未知错误！");
    			}
    			return;
    		},
    		complete:function(){
    			addSaveMark=false;
    		},
    		error:function(){
    			addSaveMark=false;
    		}
    	}) 
    }
    
    function close(){
        $.closeDiv($(".bjsdrkbox"));
    }
    
    
</script>

</body>
</html>
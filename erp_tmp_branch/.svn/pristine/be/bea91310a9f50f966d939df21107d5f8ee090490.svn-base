<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>平台商品管理</title>
	<meta name="decorator" content="base" />
</head>
<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage">
		<div class="page-orderWait">
			<div id="tab-system" class="HuiTab">
				<div class="tabBar cl mb-10">
					<sfTags:pagePermission authFlag="PLTFPRODUCT_PLTFPRODUCT_PLTFPRODUCT_TAB" html='<a class="btn-tabBar current" href="${ctx}/goods/platform/WholePlatHeader">平台产品</a>'/>
					<c:if test="${isSysUser}">
						<sfTags:pagePermission authFlag="PLTFPRODUCT_PLTFPRODUCT_PRODUCTORDERS_TAB" html='<a class="btn-tabBar" href="${ctx}/goods/platFormOrder/platOrderHeaderList">产品订单</a>'/>
					</c:if>
					<p class="f-r btnWrap">
						<a href="javascript:search();" class="sfbtn sfbtn-opt"><i
								class="sficon sficon-search"></i>查询</a> <a href="javascript:;"
																		   class="sfbtn sfbtn-opt resetSearchBtn"><i
							class="sficon sficon-reset"></i>重置</a>
					</p>
				</div>

				<div class="tabCon">
					<form id="searchForm">
						<input type="hidden" name="page" id="pageNo" value="1"> <input
							type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
						<div class="bk-gray pt-10 pb-5">
							<table class="table table-search">
								<tr>
									<th style="width: 76px;" class="text-r">商品编号：</th>
									<td><input type="text" class="input-text" name="number" />
									</td>
									<th style="width: 76px;" class="text-r">商品名称：</th>
									<td><input type="text" class="input-text" name="name" />
									</td>
									<th style="width: 76px;" class="text-r">商品状态：</th>
									<td><span class="select-box"> <select
											class="select" name="sellFlag">
													<option value="">请选择</option>
													<option value="1">已上架</option>
													<option value="2">未上架</option>
											</select>
										</span></td>
									<th style="width: 76px;" class="text-r">商品类别：</th>
									<td><span class="select-box">
											<select class="select" name="category">
													<option value="">请选择</option>
													<c:forEach var ="cg" items="${categoryList}">
														<option value="${cg.columns.name }">${cg.columns.name }</option>
													</c:forEach>
											</select>
										</span></td>
								</tr>
							</table>
						</div>
					</form>
					<div class="pt-10 pb-5 cl">
						<div class="f-r">
							<c:if test="${isSupplier != 'y'}">
								<a href="javascript:showXZ();" class="sfbtn sfbtn-opt"><i class="sficon sficon-add"></i>新增</a>
								<a href="javascript:showRuKu();" class="sfbtn sfbtn-opt"><i class="sficon sficon-sdrk"></i>入库</a>
							</c:if>
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

<!-- 入库 -->
<div class="popupBox sprkbox">
	<h2 class="popupHead">
		入库 <a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-15 pb-15">
			<div class="cl mb-10">
				<label class="f-l w-90"><em class="mark">*</em>商品编号：</label>
				<input type="text" class="input-text w-140 f-l readonly"  name="gNumber" readonly="readonly"/>
				<label class="f-l w-90">商品名称：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="gName" readonly="readonly"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-90">商品品牌：</label>
				<input type="text" class="input-text w-140 f-l readonly" name="gBrand" readonly="readonly"/>
				<label class="f-l w-90">商品型号：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly"  name="gModel"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-90">商品类别：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="gCategory"/>
				<label class="f-l w-90">商品单位：</label>
				<input type="text" class="input-text w-140 f-l readonly" readonly="readonly" name="gUnit"/>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-90"><em class="mark">*</em>入库数量：</label>
				<input type="text" class="input-text w-140 f-l mustfill" name="rNum" id="rNum"/>
			</div>
			<div class="text-c mt-20">
				<input type="hidden" name="rgoodId"/>
				<a href="javascript:doRuKu();" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:closeRuku();" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部

    $(function() {
        $.Huitab("#tab-system .tabBar span", "#tab-system .tabCon","current", "click", "0");
        $.tabfold("#moresearch", ".moreCondition", 1, "click");
        initSfGrid();
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid() {
        sfGrid = $("#table-waitdispatch").sfGrid({
            url : '${ctx}/goods/platform/getWholePlat',
            sfHeader : defaultHeader,
            sfSortColumns : sortHeader,
            multiselect: true,
            rownumbers : true,
            gridComplete:function(){
                _order_comm.gridNum();
            }
        });
    }
    function isBlank(val) {
        if (val == null || val == '' || val == undefined) {
            return true;
        }
        return false;
    }

    function fmtOper(rowData) {
        var isSupplier = '${isSupplier}';
        if(isSupplier == "y"){
            return "/";
        }else{
            if (rowData.sell_flag == 2) {
                return '<a href="javascript:shangjia(\'' + rowData.id
                    + '\');" class="c-0383dc"><i class="sficon sficon-sj "></i>上架</a>&nbsp;&nbsp;'
                    + '<a href="javascript:bianji(\'' + rowData.id
                    + '\');" class="c-0383dc"><i class="sficon sficon-edit "></i>编辑</a>&nbsp;&nbsp;'
                    + '<a href="javascript:shanchu(\'' + rowData.id+ '\',\'' + rowData.sell_flag+ '\');" class="c-0383dc"><i class="sficon sficon-del "></i>删除</a>';
            } else if (rowData.sell_flag == 1) {
                return '<a href="javascript:xiajia(\'' + rowData.id
                    + '\');" class="c-0383dc"><i class="sficon sficon-xj "></i>下架</a>&nbsp;&nbsp;'
                    + '<a href="javascript:bianji(\'' + rowData.id
                    + '\');"class="c-0383dc"><i class="sficon sficon-edit "></i>编辑</a>&nbsp;&nbsp;'
                    + '<a href="javascript:shanchu(\'' + rowData.id+ '\',\'' + rowData.sell_flag+ '\');" class="c-0383dc"><i class="sficon sficon-del "></i>删除</a>';
            }
        }

    }

    //上架
    function shangjia(id) {
        var content = "确认要上架？";
        $('body').popup({
            level:3,
            title:"商品上架",
            content:content,
            fnConfirm :function() {
                $.ajax({
                    type : "POST",
                    url : "${ctx}/goods/platform/doSJ",
                    data : {
                        "id" : id
                    },
                    success : function(data) {
                        if (data == "ok") {
                            layer.msg('上架成功!');
                            $("#table-waitdispatch").trigger("reloadGrid");
                        } else {
                            layer.msg('上架失败!');
                        }
                    }
                });
            },
            fnCancel:function (){

            }
        });
    }
    //下架
    function xiajia(id) {
        var content = "确认要下架？";
        $('body').popup({
            level:3,
            title:"商品下架",
            content:content,
            fnConfirm :function() {
                $.ajax({
                    type : "POST",
                    url : "${ctx}/goods/platform/doXJ",
                    data : {
                        "id" : id
                    },
                    success : function(data) {
                        if (data == "ok") {
                            layer.msg('下架成功!');
                            $("#table-waitdispatch").trigger("reloadGrid");
                        } else {
                            layer.msg('下架失败!');
                        }
                    }
                });
            },
            fnCancel:function (){

            }
        });

    }

    //弹出新增页面
    function showXZ(){
        var href='${ctx}/goods/platform/showXZ';
        updateOrCreate("新增商品",href);
    }

    function updateOrCreate(name,href){
        var bStop = false;
        var bStopIndex = 1;
        var show_navLi = $('#min_title_list li',window.top.document);
        show_navLi.each(function () {
            $(this).removeClass('active');
            if ($(this).find('span').text() ==$.trim(name)) {
                bStopIndex = show_navLi.index($(this));
                bStop = true;
            }
        });
        if (!bStop) {
            creatIframe(href, name);
        } else {
            show_navLi.eq(bStopIndex).addClass('active');
            $('#iframe_box .show_iframe',window.top.document).hide().eq(bStopIndex).show().find('iframe').attr({'src': href,});
        }
    }


    //弹出编辑页面
    function bianji(id){
        var href='${ctx}/goods/platform/showBJ?id='+id;
        updateOrCreate("编辑商品",href);
    }
    //删除
    function shanchu(id,flag) {

        if(flag=="1"){
            layer.msg('该商品已上架，不可删除！！！');
        }else{
            var content = "确认要删除？";
            $('body').popup({
                level:3,
                title:"商品下架",
                content:content,
                fnConfirm :function() {
                    $.ajax({
                        type : "POST",
                        url : "${ctx}/goods/platform/doSC",
                        data : {
                            "id" : id
                        },
                        success : function(data) {
                            if (data == "ok") {
                                layer.msg('删除成功!');
                                $("#table-waitdispatch").trigger("reloadGrid");
                            }
                        }
                    });
                },
                fnCancel:function (){

                }
            });
        }
    }

    function fpfSHI(row) {
        if(row.distribution_type=='2'){
            return "手动分配";
        }else if(row.distribution_type=='1'){
            return "自动分配";
        }
        return '';
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

    function spDetail(row){
        return '<a href="javascript:showDetail(\'' + row.id+ '\');">'+row.number+'</a>';
    }

    function showRuKu() {
        var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
        if (idArr.length < 1) {
            layer.msg("请选择数据！");
        } else if (idArr.length > 1) {
            layer.msg("一次只能入库一种商品！");
        } else {
            $.ajax({
                type:"POST",
                url : "${ctx}/goods/platform/show",
                data : {
                    "id" : idArr[0]
                },
                datatype:"json",
                success : function(result){
                    $(".sprkbox").find("input[name='gNumber']").val(result.number);
                    $(".sprkbox").find("input[name='gName']").val(result.name);
                    $(".sprkbox").find("input[name='gBrand']").val(result.brand);
                    $(".sprkbox").find("input[name='gCategory']").val(result.category);
                    $(".sprkbox").find("input[name='gNum']").val(result.stocks);
                    $(".sprkbox").find("input[name='gModel']").val(result.model);
                    $(".sprkbox").find("input[name='gUnit']").val(result.unit);
                    $(".sprkbox").find("input[name='rgoodId']").val(result.id);
                    $('.sprkbox').popup();
                }
            });
        }
    }

    var adpoti = false;
    function doRuKu() {
        if (adpoti) {
            return;
        }

        var id = $("input[name='rgoodId']").val();//商品id
        var num = $.trim($("input[name='rNum']").val());//
        if (!/^\d+$/.test(num)) {
            layer.msg("入库数量格式不正确！");
            return;
        }

        if (isBlank(num)) {
            layer.msg("请输入入库数量！");
            $("#rNum").focus();
        } else if (num <= 0) {
            layer.msg("入库数量必须大于零！");
            $("#rNum").focus();
        } else {
            adpoti = true;
            $.ajax({
                type: "POST",
                url: "${ctx}/goods/platform/doRuKu",
                data: {
                    id: id,
                    num: num
                },
                success: function (data) {
                    if (data.code === "200") {
                        layer.msg('入库成功！');
                        $.closeDiv($(".sprkbox"));
                        $("#table-waitdispatch").trigger("reloadGrid");
                    } else {
                        layer.msg('入库失败！');
                        $.closeDiv($(".sprkbox"));
                        $("#table-waitdispatch").trigger("reloadGrid");
                    }
                },
                complete: function () {
                    adpoti = false;
                }
            });
        }
    }

    function closeRuku() {
        $.closeDiv($(".sprkbox"));
    }

    function showDetail(id){
        layer.open({
            type : 2,
            content:'${ctx}/goods/platform/showBJ?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }
</script>
</body>
</html>

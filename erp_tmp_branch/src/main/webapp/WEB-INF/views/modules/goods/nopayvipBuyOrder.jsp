<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>平台商品</title>
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage table-header-settable">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <a class="btn-tabBar "  href="${ctx }/goods/platFormOrder/vipOrderHeader">已支付VIP购买订单</a>
                    <a class="btn-tabBar current"  href="${ctx }/goods/platFormOrder/nopayvipOrderHeader">未支付VIP购买订单</a>
					<sfTags:pagePermission authFlag="SYSTEM_AUTH_VIP_STATIS_TAB" html='<a class="btn-tabBar "  href="${ctx }/statistic/vipStatisticIndex">VIP统计分析</a>'/>
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
                                    <th style="width: 76px;" class="text-r">订单编号：</th>
                                    <td>
                                        <input type="text" class="input-text" name= "number"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">商品名称：</th>
                                    <td>
                                        <input type="text" class="input-text" name= "goodName"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">支付状态：</th>
                                    <td>
								<span class="select-box">
									<select class="select" name="payStatus">
										<option value="">请选择</option>
										<option value="0">未支付</option>
										<option value="1">已支付</option>
									</select>
								</span>
                                    </td>
                                    <th style="width: 76px;" class="text-r">下单人：</th>
                                    <td>
                                        <input type="text" class="input-text" onkeydown="enterEvent(event)" name = "placingOrderBy"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">用户姓名：</th>
                                    <td>
                                        <input type="text" class="input-text" name = "customerName"/>
                                    </td>

                                </tr>
                                <tr>
                                    <th style="width: 76px;" class="text-r">联系方式：</th>
                                    <td>
                                        <input type="text" class="input-text" name = "customerContact"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">详细地址：</th>
                                    <td>
                                        <input type="text" class="input-text" name = "customerAddress"/>
                                    </td>
                                    <th style="width: 76px;" class="text-r">下单时间：</th>
                                    <td colspan="3">
                                        <input type="text" class="input-text Wdate w-140" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd '})" name = "placingOrderTime"/>
                                        至
                                        <input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd '})" class="input-text Wdate w-140" name = "placingOrderTime1"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>

                    <div class="pt-10 pb-5 cl">
                        <div class="f-r">
                            <a  onclick="return exports()" class="sfbtn sfbtn-opt"><i class="sficon sficon-export"></i>导出</a>

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

<div class="popupBox sporderdetail">
    <h2 class="popupHead">
        订单详情
        <a href="javascript:;" class="sficon closePopup" ></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain" id="detailBox">
            <div class="cl mb-10">
                <div class="f-r mb-10 mr-40">
                    <label class="w-90 f-l">商品图片：</label>
                    <div class="imgbox f-l mr-10" id="spange1">
                        <img id="imgGood" />
                    </div>
                </div>
                <div class="f-l mb-10">
                    <label class="f-l w-70">商品编号：</label>
                    <input type="text" class="input-text w-140 f-l readonly" id="goodNumber" readonly="readonly" value="" />
                    <label class="f-l w-90">商品名称：</label>
                    <input type="text" class="input-text w-140 f-l readonly" id="goodName" readonly="readonly"  value="" />
                </div>
                <div class="f-l mb-10">
                    <label class="f-l w-70">商品品牌：</label>
                    <input type="text" class="input-text w-140 f-l readonly" id="goodBrand" readonly="readonly" value="" />
                    <label class="f-l w-90">商品型号：</label>
                    <input type="text" class="input-text w-140 f-l readonly" id="goodModel" readonly="readonly"  value="" />
                </div>
                <div class="f-l mb-10">
                    <label class="f-l w-70">商品类别：</label>
                    <input type="text" class="input-text w-140 f-l readonly" id="goodCategory" readonly="readonly" value="" />
                    <label class="f-l w-90">商品来源：</label>
                    <input type="text" class="input-text w-140 f-l readonly" id="source" readonly="readonly"  value="" />
                </div>
            </div>
            <div class="line-dashed mb-10"></div>
            <div class="cl mb-10">
                <label class="f-l w-70">用户姓名：</label>
                <input type="text" class="input-text w-140 f-l readonly" id="customerName" readonly="readonly" value="" />
                <label class="f-l w-90">联系方式：</label>
                <input type="text" class="input-text w-140 f-l readonly" id="customerContact" readonly="readonly"  value="" />
            </div>
            <div class="cl mb-10">
                <label class="f-l w-70">详细地址：</label>
                <input type="text" class="input-text w-370 f-l readonly" id="customerAddress" readonly="readonly" value="" />
            </div>
            <div class="cl mb-10">
                <label class="f-l w-70">订单编号：</label>
                <input type="text" class="input-text w-140 f-l readonly" id="number" readonly="readonly" value="" />
                <label class="f-l w-90">购买数量：</label>
                <div class="priceWrap w-140 f-l readonly">
                    <input type="text" class="input-text readonly" id="purchaseNum"  readonly="readonly" value="" />
                    <span class="unit" id="unit"></span>
                </div>
                <label class="f-l w-90">商品总额：</label>
                <div class="priceWrap w-140 readonly f-l readonly">
                    <input type="text" class="input-text readonly" id="goodAmount" readonly="readonly"  value="" />
                    <span class="unit">元</span>
                </div>
            </div>
            <div class="cl mb-10">
                <label class="f-l w-70">下单人：</label>
                <input type="text" class="input-text w-140 f-l readonly" id="placingOrderBy" readonly="readonly" value="" />
                <label class="f-l w-90">订单状态：</label>
                <input type="text" class="input-text w-140 f-l readonly" id="status" readonly="readonly"  value="" />
            </div>
            <input type="text" hidden="hidden" class="input-text" id="sitePrice"   value="" />
            <div class="text-c mt-20" id="selectOne">
                <!-- <a id="shoukuan" href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">收款</a>
                <a id="chuku" href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">出库</a>
                <a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="self-cancel">取消</a> -->
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/unipay/unipay.js"></script>
<script type="text/javascript">

    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';			//系统表格的ID
    var rId;
    var ifFk;
    var ifSuccess;
    var payType = 'alipay';

    $(function(){

        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        $.tabfold("#moresearch",".moreCondition",1,"click");

        initSfGrid();
    });

    function search(){
    	var pageSize = $("#pageSize").val();
		if ($.trim(pageSize) == '' || pageSize == null) {
			$("#pageSize").val(20);
		}
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/goods/platFormOrder/nopayvipOrderGrid',
            sfHeader: defaultHeader,
            sfSortColumns: sortHeader,
            multiselect:false,
            rownumbers : true,
    		gridComplete:function(){
    			_order_comm.gridNum();
                if($("#table-waitdispatch").find("tr").length>1){
                    $(".ui-jqgrid-hdiv").css("overflow","hidden");
                }else{
                    $(".ui-jqgrid-hdiv").css("overflow","auto");
                }
            }
        });
    }


    function detail(rowData){
        //return "<span ><a onclick='detailMsg(\""+rowData.id+"\")' class='c-0383dc'>"+rowData.number+"</a></span>";
        return "<span class='c-0383dc'>"+rowData.number+"</span>";
    }

    /* function detailMsg(rowId){
     $('#selectOne').empty();
     $.ajax({
     type:"POST",
     url:"${ctx}/goods/siteselfOrder/detailMsg",
     data:{rowId:rowId},
     dataType:'json',
     success:function(result){
     var parent = $('#detailBox');
     $("#number").val(result.columns.number);
     $("#goodNumber").val(result.columns.good_number);
     $("#goodBrand").val(result.columns.good_brand);
     $("#goodModel").val(result.columns.good_model);
     $("#customerName").val(result.columns.customer_name);
     $("#customerContact").val(result.columns.customer_contact);
     $("#customerAddress").val(result.columns.customer_address);
     $("#purchaseNum").val(result.columns.purchase_num);
     $("#placingOrderBy").val(result.columns.placing_name);
     $("#goodAmount").val(result.columns.good_amount);
     $("#goodName").val(result.columns.good_name);
     $("#goodBrand").val(result.columns.good_brand);
     $("#unit").html(result.columns.unit);
     $("#goodCategory").val(result.columns.good_category);
     $("#imgGood").attr("src",'${commonStaticImgPath}'+result.columns.good_icon);
     if(result.columns.status=='1'){
     rId=result.columns.id;
     $("#status").val('待收款');
     $("#selectOne").append('<a href="javascript:;" id="shoukuan1" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="gatheringthen(\''+result.columns.id+'\')">收款</a>'+
     '<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao1()" >取消</a>')
     }else if(result.columns.status=='2'){
     if(parseFloat(result.columns.purchase_num) > parseFloat(result.columns.stocks)){
     $("#status").val('待下单');
     $("#selectOne").append('<a href="javascript:;" onclick="xiadan(\''+result.columns.id+'\')" class="sfbtn sfbtn-opt3 w-70 mr-5">下单</a>'+
     '<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()">取消</a>')
     }else{
     $("#status").val('待出库');
     $("#selectOne").append('<a href="javascript:;" onclick="outStocks(\''+result.columns.id+'\')" class="sfbtn sfbtn-opt3 w-70 mr-5">出库</a>'+
     '<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()">取消</a>')
     }
     }else if(result.columns.status=='3'){
     if(result.columns.outstock_type == '0'){
     $("#status").val('已出库');
     $("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
     }else if(result.columns.outstock_type == '1'){
     $("#status").val('已出库');
     $("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
     }else if(result.columns.outstock_type == '2'){
     $("#status").val('已下单');
     $("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>')
     }
     }else if(result.columns.status=='4'){
     $("#status").val('待收款');
     $("#selectOne").append('<a href="javascript:;" onclick="gatheringthen(\''+result.columns.id+'\')" class="sfbtn sfbtn-opt3 w-70 mr-5">收款</a>'+
     '<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="quxiao()>取消</a>')
     }else if(result.columns.status=='0'){
     $("#status").val('已取消');
     $("#selectOne").append('<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiao()>取消</a>');
     }
     if(result.columns.good_source=='1'){
     $("#source").val('自营');
     }else if(result.columns.good_source=='2'){
     $("#source").val('平台');
     }
     if(result.columns.outstock_type=='0'){
     $("#outWay").val('工程师库存');
     }else if(result.columns.outstock_type=='1'){
     $("#outWay").val('公司库存');
     }else if(result.columns.outstock_type=='2'){
     $("#outWay").val('平台发货');
     }

     $('.sporderdetail').popup();
     }
     })
     }
     */
    function paType(rowData){
        if(rowData.payment_type=="0"){
            return "微信";
        }
        if(rowData.payment_type=="1"){
            return "支付宝";
        }
        return "---";
    }
    function paSt(rowData){
        if(rowData.pay_status=="0"){
            return "未支付";
        }
        if(rowData.pay_status=="1"){
            return "已支付";
        }
        return "---";
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
                    location.href="${ctx}/goods/platFormOrder/exportnopayVipOrder?formPath=/a/goods/platFormOrder/nopayvipOrderHeader&&maps="+$("#searchForm").serialize();
                }

            });
        }else{
            location.href="${ctx}/goods/platFormOrder/exportnopayVipOrder?formPath=/a/goods/platFormOrder/nopayvipOrderHeader&&maps="+$("#searchForm").serialize();
        }

    }

    function isBlank(val){
        if($.trim(val) != "" && val != null && val != undefined){
            return false;
        }
        return true;
    }


    function buyNum(rowData){
        if(rowData.purchase_num=="1"){
            return "一个月";
        }
        if(rowData.purchase_num=="6"){
            return "六个月";
        }
        if(rowData.purchase_num=="12"){
            return "一年";
        }
        if(rowData.purchase_num=="24"){
            return "两年";
        }
        if(rowData.purchase_num=="36"){
            return "三年";
        }
        return "---";
    }
    
    /*enter查询*/
    function enterEvent(event){
    	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
    	if (keyCode ==13){
    		search();
    	}
    }
</script>

</body>
</html>
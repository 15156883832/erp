<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
    <style>
        .dropdown-display{font-size: 12px}
        .dropdown-selected{margin-top: 4px}
    </style>
</head>

<body>
<div class="sfpagebg">
    <div class="sfpage table-header-settable">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <a class="btn-tabBar current" href="${ctx }/QRCode/getQRCodeList">使用记录</a>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
                    </p>
                </div>
                <div class="tabCon">
                <form id="searchForm">
                    <input type="hidden" name="page" id="pageNo" value="1">
                    <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                    <div class="bk-gray pt-10 pb-5">
                        <table class="table table-search">
                            <tr>
                                <th style="width: 76px;" class="text-r">服务商：</th>
                                <td id="reloadSpan">
                                    <span class="w-200 dropdown-sin-2">
									<select class="select" multiline="false"  id="paraS"  name="serviceName" style="width:100%;height:25px" panelMaxHeight="300px">
                                        <option value="">请选择</option>
                                        <c:forEach var="service" items="${serviceList}">
                                            <option value="${service.columns.id}">${service.columns.name}</option>
                                        </c:forEach>
									</select>
								    </span>
                                </td>
                                <th style="width: 76px;" class="text-r">打印状态：</th>
                                <td>
                                    <span class="w-200">
									<select class="select"  placeholder="请选择" name="isPrint" style="width:100%;height:25px" panelMaxHeight="300px">
                                        <option value="">请选择</option>
                                        <option value="1">已打印</option>
                                        <option value="0">未打印</option>
									</select>
								    </span>
                                </td>
                                <th style="width: 76px;" class="text-r">使用状态：</th>
                                <td>
                                    <span class="w-200">
									<select class="select"  placeholder="请选择" name="beenUsed" style="width:100%;height:25px" panelMaxHeight="300px">
                                        <option value="">请选择</option>
                                        <option value="1">已使用</option>
                                        <option value="0">未使用</option>
									</select>
								    </span>
                                </td>
                                <th style="width: 76px;" class="text-r">生成时间：</th>
                                <td colspan="2">
                                    <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimemax\')}'})" id="createMin" name="createTimeMin" value="" class="input-text Wdate w-120" >
                           			    至
									<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createMin\')}'})" id="createTimemax" name="createTimeMax"  value="" class="input-text Wdate w-120" >
							
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pt-10 pb-5 cl">
                        <div class="f-l">
                            <a onclick="showQR()" class="sfbtn sfbtn-opt" ><i class="sficon sficon-scancode"></i>生成二维码</a>
                        </div>
                        <div class="f-r">
                            <a onclick="exportExcel()" target="_blank" class="sfbtn sfbtn-opt2" ><i class="sficon sficon-export"></i>导出</a>
                            <a onclick="toQrcodeList()" target="_blank" class="sfbtn sfbtn-opt2" ><i class="sficon sficon-print"></i>打印</a>
                        </div>
                    </div>
                    <div>
                        <table id="table-waitdispatch" class="table"></table>
                        <!-- pagination -->
                        <div class="cl pt-10">
                            <div class="f-l">

                            </div>
                            <div class="f-r">
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <!-- pagination -->
                    </div>
                </form>
            </div>
            </div>
        </div>
    </div>
</div>


<!-- 生成二维码-->
<div class="popupBox w-380 showQRCode">
    <h2 class="popupHead">
        生成二维码
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <form id="tz_form">
            <div class="popupMain pd-15">
                <div class="cl mb-20">
                    <label class="f-l w-100">服务商：</label>
                    <span class="w-200 dropdown-sin-2">
                        <select class="select" multiline="false" id="serviceV"   name="serviceName" style="width:100%;height:25px" panelMaxHeight="300px">
                            <option value="">请选择</option>
                            <c:forEach var="service" items="${serviceList}">
                               <option value="${service.columns.id}">${service.columns.name}</option>
                            </c:forEach>
						</select>
                    </span>
                </div>
                <div class="cl mb-20">
                    <label class="f-l w-100">生成数量：</label>
                   <%-- <div class="priceWrap w-200 f-l">--%>
                        <input type="text" class="input-text w-80" name="num" /> X 54个
                    <%--    <span class="unit">个</span>
                    </div>--%>
                </div>
                <div class="text-c mt-30">
                    <input type="hidden" name="fittingId" value=""/>
                    <a href="javascript:createQRCodeBySiteId();" id="createQrcodeButton" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
                    <a href="javascript:close('.showQRCode');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="popupBox qrcode" >
    <h2 class="popupHead">
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <div class="text-c mt-25 " id="showCode">

            </div>
        </div>
    </div>
</div>

<div class="popupBox w-380 choseLogo">
    <h2 class="popupHead">
        打印二维码
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
            <div class="popupMain pd-15">
                <div class="cl mb-20">
                    <label class="f-l w-100">服务商：</label>
                    <span class="w-200 dropdown-sin-2">
                        <select class="select" multiline="false" id="pringCode"  name="serviceName" style="width:100%;height:25px" panelMaxHeight="300px">
                            <option value="">请选择</option>
                            <c:forEach var="service" items="${serviceList}">
                                <option value="${service.columns.id}">${service.columns.name}</option>
                            </c:forEach>
						</select>
                    </span>
                </div>
                <div class="cl mb-20">
                    <label class="f-l w-100">二维码LOGO：</label>
                    <span class="w-200 dropdown-sin-2">
                        <select class="select" name="logo" style="width:100%;height:25px" panelMaxHeight="300px">
                            <option value="">请选择</option>
                            <option value="1">安徽家电</option>
                            <option value="2">服务管家</option>
						</select>
                    </span>
                </div>
                <div class="cl mb-20">
                    <label class="f-l w-100">打印设置(序号)：</label>
                    <input type="text" class="input-text w-70" name="startPage" /> —
                    <input type="text" class="input-text w-70" name="endPage" />
                </div>
                <div class="cl mb-20 hide" id="tishi">
                    <label class="f-l w-100">提示：</label>
                    <span id="warning" class="f-l w-200 lh-26" style="color:red"></span>
                </div>
                <div class="text-c mt-30">
                    <a onclick="gotoPrint()" target="_blank" class="sfbtn sfbtn-opt3 w-70 mr-5" id="printC">确定</a>
                    <a href="javascript:close('.choseLogo');" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
                </div>
            </div>
    </div>
</div>

<script type="text/javascript">
    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

    $(function(){
        $.Huitab("#tab-system .tabBar span","#tab-system .tabCon","current","click","0");
        $.tabfold("#moresearch",".moreCondition",1,"click");
        initSfGrid();
        $('#paraS').select2();
        $('#serviceV').select2();
        $('#pringCode').select2();
        $(".selection").css("width","200px");
    });

    var seqMax=0;//当前服务商二维码最大序号
    $("#pringCode").change(function(){
        var res = $("#pringCode").select2("val");
        $.ajax({
            type:"post",
            data:{
                siteId:res,
            },
            url:"${ctx}/QRCode/getPage",
            dataType:"JSON",
            success:function(result){
                seqMax=result;
            }
        });
    });

    $("select[name='startPage']").click(function(){
        var res = $("#pringCode").select2("val");
        if(isBlank(res)){
            layer.msg("请先选择服务商！！！");
        }
    });

    function showQR(){
        $(".showQRCode").find(".select").select2('val', '请选择');
        $(".showQRCode").find("input[name='num']").val("");
        $(".showQRCode").popup();
    }
    function close(val){
        $.closeDiv($(val));
    }
    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        var url = "${ctx}/QRCode/getQRCodeValue";
        sfGrid = $("#table-waitdispatch").sfGrid({
            url:url,
            sfHeader:defaultHeader,
            sfSortColumns:sortHeader,
            shrinkToFit: false,
            multiselect: false,
            rownumbers : true,
			gridComplete:function(){
				_order_comm.gridNum();
			}
        });
    }

    $("input[name='endPage']").blur(function(){
        var startPageNo=$("input[name='endPage']").val();
        var endPageNo=$(this).val();
        if(!reg.test(startPageNo) || !reg.test(endPageNo)){
            layer.msg("请输入正确的起始序号");
        }else if(parseInt(startPageNo)>parseInt(endPageNo)){
            layer.msg("请输入正确的起始页码！");
        }
    });

    function toQrcodeList(){
        $("select[name='logo']").val("");
        $(".choseLogo").popup();
    }

    var reg=/^\d*$/;
    function gotoPrint(){
        var res = $("#pringCode").select2("val");//服务商
        var logo=$("select[name='logo']").val();
        var startSeq=$("input[name='startPage']").val();//起始页
        var endSq=$("input[name='endPage']").val();

        if(isBlank(startSeq) || isBlank(endSq)){
            layer.msg("请输入起始序号");
        }else if(parseInt(startSeq)=='0' || parseInt(endSq)=='0'){
            layer.msg("请重新输入起始序号！");
        }else if(!reg.test(startSeq) || !reg.test(endSq)){
            layer.msg("请输入正确的起始序号");
        }else if(parseInt(seqMax) < parseInt(endSq)){
            layer.msg("起始序号的范围超出已生成的二维码序号！");
        }else if(isBlank(res)){
            layer.msg("请选择服务商！");
        }else if(isBlank(logo)){
            layer.msg("请选择二维码LOGO！");
        }else if(parseInt(startSeq)>parseInt(endSq)){
            layer.msg("请输入正确的起始页码！");
        }else{
            var str = logo+","+res+","+startSeq+","+endSq;
            $.closeDiv($(".choseLogo"));
            $("#printC").prop("href", "${ctx}/QRCode/toPrintPage?str=" + str);
        }
    }

    var nu= /^\d{1,2}$/;
    $("input[name='num']").blur(function(){
        var num=$(this).val();
        if(isBlank(num)){
            layer.msg("请输入要生成的二维码数量！");
        }else if(parseInt(num)>=100){
            layer.msg("二维码生成数量一次不能超过一百页");
        }else if(!nu.test(num)){
            layer.msg("请输入正确的二维码数量！");
        }
    });

    var falesR=false;
    function createQRCodeBySiteId(){
        if(falesR){
            return;
        }
        var siteId=$("#serviceV").val();
        var num=$("input[name='num']").val();
        if(isBlank(siteId)){
            layer.msg("请选择服务商！");
        }else if(isBlank(num)){
            layer.msg("请输入要生成的二维码数量！");
        }else if(parseInt(num)>=100){
            layer.msg("二维码生成数量一次不能超过一百页");
        }else if(!nu.test(num)){
            layer.msg("请输入正确的二维码数量！");
        }else if(parseInt(num)==0){
            $.closeDiv($(".showQRCode"));
        }else{
            falesR=true;
            layer.msg("二维码生成中，请耐心等待...",{time:5000000});
            $.ajax({
                type:"post",
                traditional:true,
                data:{
                    siteId:siteId,
                    num:num
                },
                url:"${ctx}/QRCode/createQRCodeBySiteId",
                dataType:"JSON",
                success:function(result){
                    if(result=="1"){
                        layer.msg("二维码已成功生成！");
                        $.closeDiv($(".showQRCode"));
                        search();
                    }else{
                        layer.msg("二维码生成失败！");
                        $.closeDiv($(".showQRCode"));
                    }
                },complete:function(){
                    falesR=false;
                }
            });
        }
    }

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
    function showQRCode(siteId,code){
        var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
        $("#showCode").empty().qrcode({width: 200, height: 200, text: str});
        $(".qrcode").popup();

    }

    function fmtOperPrint(rowData){
        if(rowData.is_print=='0'){
            return "未打印";
        }else if(rowData.is_print=='1'){
            return "已打印";
        }else{
            return "";
        }
    }
    function fmtOperUse(rowData){
        if(rowData.status=='0'){
            return "未使用";
        }else if(rowData.status=='1'){
            return "已使用";
        }else{
            return "";
        }
    }

    function fmtOper(rowData){
        var siteId=rowData.site_id;
        var code=rowData.code;
        return '<span><a href="javascript:showQRCode(\''+siteId+'\',\''+code+'\');" class="sficon sficon-scancode"></a></span>';
    }

    function search(){
    	var pageSize = $("#pageSize").val();
		if ($.trim(pageSize) == '' || pageSize == null) {
			$("#pageSize").val(20);
		}
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function reset(){
        $("select[name='isPrint']").val("");
        $("select[name='beenUsed']").val("");
        $("#createMin").val("");
        $(".select").select2('val', '请选择');
    }

    function exportExcel(){
        var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
        var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
        if(idArr>10000){
            $('body').popup({
                level:3,
                title:"导出",
                content:content,
                fnConfirm :function(){
                    location.href="${ctx}/QRCode/exportSysFile?formPath=/a/QRCode/getQRCodeList&&maps="+$("#searchForm").serialize();
                }

            });
        }else{
            location.href="${ctx}/QRCode/exportSysFile?formPath=/a/QRCode/getQRCodeList&&maps="+$("#searchForm").serialize();
        }
    }
</script>
</body>
</html>
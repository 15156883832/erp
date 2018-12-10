<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base" />
    <title>二维码使用记录</title>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
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
        .btn-import .webuploader-pick{
            background: none;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage table-header-settable">
        <div class="page-orderWait">
            <div class="tabBar cl mb-10">
            	<sfTags:pagePermission authFlag="EMP_SERVICE_EVAL_DETAIL_TAB" html='<a class="btn-tabBar " href="${ctx}/order/orderEvaluation/headList">用户评价</a>'></sfTags:pagePermission>
                <sfTags:pagePermission authFlag="QRCODE_USEDRECORD_TAB" html='<a class="btn-tabBar current" href="${ctx }/QRCode/getQRCodeUsedList">电子名片服务记录</a>'></sfTags:pagePermission>
                <p class="f-r btnWrap">
                    <a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
                    <a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
                </p>
            </div>
            <form id="searchForm">
                <input type="hidden" name="page" id="pageNo" value="1">
                <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                <div class="bk-gray pt-10 pb-5">
                    <table class="table table-search">
                        <tr>
                            <th style="width: 76px;" class="text-r">用户姓名：</th>
                            <td>
                                <input type="text" class="input-text" name= "customerName"/>
                            </td>
                            <th style="width: 76px;" class="text-r">用户电话：</th>
                            <td>
                                <input type="text" class="input-text" name = "customerMobile" />
                            </td>
                            <th style="width: 76px;" class="text-r">详细地址：</th>
                            <td>
                                <input type="text" class="input-text" name = "address"/>
                            </td>
                            <th style="width: 76px;" class="text-r">家电品牌：</th>
                            <td>
                                <input type="text" class="input-text" name = "brand"/>
                            </td>
                            <th style="width: 76px;" class="text-r">家电品类：</th>
                            <td>
                                <input type="text" class="input-text" name = "category"/>
                            </td>
                        </tr>
                        <tr>
                            <th style="width: 76px;" class="text-r">使用类型：</th>
                            <td>
								<span class="select-box">
									<select class="select" name="useType">
										<option value="">请选择</option>
								        <c:forEach items="${fns:getServiceMode() }" var="stype">
                                            <option value="${stype.columns.name }">${stype.columns.name }</option>
                                        </c:forEach>
									</select>
								</span>
                            </td>
                            <th style="width: 76px;" class="text-r">使用人：</th>
                            <td>
                                <input type="text" class="input-text" name="user" />
                            </td>
                            <th style="width: 76px;" class="text-r">购机时间：</th>
                            <td colspan="5">
                                <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="buyTimeMin" name="startBuyTime"  value="" class="input-text Wdate w-120" style="width:120px">
                                至
                                <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="buyTimeMax" name="endBbuyTime"  value="" class="input-text Wdate w-120" style="width:120px">
                                <lable style="width: 76px;" class="text-r">使用时间：</lable>
                                <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="startUseTime"  value="" class="input-text Wdate w-120" style="width:120px">
                                至
                                <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="repairTimeMax" name="endUseTime"  value="" class="input-text Wdate w-120" style="width:120px">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="pt-10 pb-5 cl">
                    <div class="f-l">
                        <a href="javascript:;" onclick="senMagPopup()" class="sfbtn sfbtn-opt"><i class="sficon sficon-massText"></i>群发短信</a>
                    </div>
                    <div class="f-r">
                        <a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>
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


<!-- 短信群发 -->
<div class="popupBox massText">
    <h2 class="popupHead">
        短信群发
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <p class="f-14 mb-10">自定义短信编辑：</p>
            <div class="bk-gray pos-r pb-30">
                <textarea class="textarea h-50" id="content" style="border: none;" placeholder="请输入短信内容"></textarea>
                <div class="senderWrap">
                    【<input type="text" id="sign" value="" align="center" style="font-align:center" class="input-text" /> 服务】
                </div>
            </div>

            <div class="text-c mt-20">
                <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="senMsg()">确定</a>
                <a  class="sfbtn sfbtn-opt w-70" onclick="cancelMsg()">取消</a>
            </div>
        </div>
    </div>
</div>

<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
    <h2 class="popupHead">
        短信群发
        <a href="javascript:;" class="sficon closePopup" onclick="guanbi()"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="f-14">
                您已发送<strong class="c-005aab" id="sucMsg">0</strong>条，未发送<strong class="c-fd7e2a" id="wroMsg">0</strong>条！
            </div>
            <a id="exportLink" onclick="closePopup()" href="${ctx}/order/exportWrongNumber?formPath=/a/order/History" target="_blank" class="c-0383dc mt-10" style="text-decoration: underline;">查看发送失败的工单</a>
            <div class="text-c mt-20">
                <a  class="sfbtn sfbtn-opt w-70" onclick="guanbi()">关闭</a>
            </div>
        </div>
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

<div class="popupBox msgText msgTextQuren" >
    <h2 class="popupHead">
        短信确认
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <div class="lh-26">
                <div>您确定给<span id="peoples" style="color: #999;" class="f-14"></span>发送</div>
                <div style="min-height:100px; text-indent:2em;color: #999;" id="sendContent" ></div>
            </div>
            <div class="text-c mt-25 " id="clickSend">

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
        initSfGrid();
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        var url = '${ctx}/QRCode/getQRCodeUsedValue';
        sfGrid = $("#table-waitdispatch").sfGrid({
            url:url,
            sfHeader:defaultHeader,
            sfSortColumns:sortHeader,
            rownumbers : true,
    		gridComplete:function(){
    			_order_comm.gridNum();
    		}
        });
    }
    function fmtOper(rowData){
        var siteId=rowData.site_id;
        var code=rowData.code;
        return '<span><a href="javascript:showQRCode(\''+siteId+'\',\''+code+'\');" class="sficon sficon-scancode"></a></span>';
    }

    function showQRCode(siteId,code){
        var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
        $("#showCode").empty().qrcode({width: 200, height: 200, text: str});
        $(".qrcode").popup();
    }
    function fmtOperWarrentType(row){
        if(row.warranty_type=='1'){
            return "保内";
        }else if(row.warranty_type=='2'){
            return "保外";
        }else{
            return "";
        }
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
    function cancelMsg(){
        $.closeDiv($(".massText"));
    }

    function closePopup(){
        $.closeDiv($(".massTextNote"));
        $.closeDiv($(".massText"));
    }
    function guanbi(){
        $.closeDiv($(".massTextNote"));
        $.closeDiv($(".msgTextQuren"));
        $.closeDiv($(".massText"));
    }
    function senMagPopup(){
    	var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
    	if(ids.length > 0){
    		var orderIds = "";
        	for(var i=0;i<ids.length;i++){
        		var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
        		if(orderIds==''){
        			orderIds=rowData.source;
        		}else{
        			orderIds=orderIds+','+rowData.source;
        		}
        	}
    		layer.open({
    	        type : 2,
    	        content:'${ctx}/order/sendMsgAccounts?ids=' + orderIds,
    	        title:false,
    	        area: ['100%','100%'],
    	        closeBtn:0,
    	        shade:0,
    	        anim:-1
    	    });
    	}else{
    		layer.msg("请先选择数据！");
    	}
    }


    var sgMark = false;
    function senMsg(){ //批量发送短信
        $("#clickSend").empty();
        if(sgMark){
            return;
        }
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        var mobile="";
        var number="";
        var wrongNumber="";
        var showCustomers="";
        for(var i=0;i<ids.length;i++){
            var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
            var ph1=returnMobile(rowData.customer_mobile);//去空格的mobile
            if($.trim(ph1)=="" || $.trim(ph1)==null){
                layer.msg("选择发送的工单中存在用户手机号为空的工单，请先维护或者重新选择工单！");
                return ;
            }
            if($.trim(ph1).length!=11 || $.trim(ph1).substring(0,1)!="1" ){
                if(wrongNumber==""){
                    wrongNumber=rowData.number;
                }else{
                    wrongNumber=wrongNumber+','+rowData.number;
                }
            }
            if(i==0){
                mobile=$.trim(ph1);
                number=$.trim(rowData.number);
            }else{
                mobile=mobile+','+$.trim(ph1);
                number=number+','+$.trim(rowData.number);
            }
            if(showCustomers==""){
                showCustomers=rowData.customer_name;
            }else{
                showCustomers=showCustomers+","+rowData.customer_name;
            }
        }
        $("#wrongNumber").val(wrongNumber);//未发送的工单编号
        if(wrongNumber==""){
            var a = document.getElementById("exportLink");
            a.removeAttribute("href");
            a.setAttribute("onclick","tishi()");
        }else{
            $("#exportLink").prop("href", $("#exportLink").prop("href")+"&no="+wrongNumber);
        }
        var content = $("#content").val();
        var sign = $.trim($("#sign").val());
        if($.trim(content)=="" || content==null){
            layer.msg("自定义发送短信内容不能为空");
            $("#content").focus();
            return;
        }
        if($.trim(sign)=="" || sign==null ){
            layer.msg("短信签名不能为空！");
            $("#sign").focus();
            return false;
        }
        if($.trim(sign).length>6 ){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            $("#sign").focus();
            return false;
        }
        var siteMsgNums = $("#siteMsgNums").val();
        var msgNumbers = mobile.split(",");
        var msgNums = msgNumbers.length;//需要发送短信的工单数
        sgMark = true;
        $.ajax({
            type:"POST",
            traditional:true,
            url:"${ctx }/order/msgNumbers",
            data:{content:content,
                sign:sign},
            success:function(result){
                if(parseInt(result)*parseInt(msgNums) > parseInt(siteMsgNums)){
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                }else{
                    $("#peoples").html(showCustomers);
                    definedContentTz=content;
                    $("#sendContent").text("“"+content+"”？");
                    $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendAllConfirm(\''+sign+'\',\''+mobile+'\',\''+number+'\')" >确定</a>&nbsp;&nbsp;'+
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                    $(".msgTextQuren").popup({level:2});
                }
            },complete: function() {
                sgMark = false;
            }
        })

    }
    function cancelQueren(){
        $.closeDiv($(".msgTextQuren"));
    }
    function returnMobile(val){
        var mobile="";
        if(val!=null && val!=""){
            var mobiles=val.split(",");
            mobile=mobiles[0];
        }
        return mobile;
    }
    var sgallMsg=false;
    function sendAllConfirm(sign,mobile,number){
        if(sgallMsg){
            return;
        }
        var msgNumbers = mobile.split(",");
        sgallMsg=true;
        $.ajax({
            type:"POST",
            traditional:true,
            url:"${ctx }/order/sendMsg",
            data:{content:definedContentTz,
                sign:sign,
                mobile:mobile,
                number:number
            },
            success:function(result){
                if(result=="ok"){
                    var n = 0;
                    for(var j=0;j<msgNumbers.length;j++){
                        if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
                            n++;
                        }
                    }
                    $("#sucMsg").text(n);
                    $("#wroMsg").text(parseInt(msgNumbers.length)-parseInt(n));
                    layer.msg("发送成功");
                    search();
                    numerCheck();
                    //$.closeDiv($('.massText'));
                    $('.massTextNoteQf').popup({level:4});
                }else if(result=="noMessage"){
                    layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
                    return;
                }else{
                    layer.msg("发送失败，请检查！");
                    return;
                }
            },complete:function(){
                sgallMsg=false;
            }
        })
    }

    function exports() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var nowM = hours * 60 + minutes;
        var start = 7 * 60 + 30;
        var end = 11 * 60 + 30;
        if (nowM >= start && nowM <= end) {
            layer.msg("温馨提醒：系统使用高峰期7:30-11:30,请在其它时间导入、导出！谢谢！");
            return false;
        }

        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records');
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup({
                level: 3,
                title: "导出",
                content: content,
                fnConfirm: function () {
                    location.href = "${ctx}/QRCode/export?formPath=/a/QRCode/getQRCodeUsedList&&maps=" + $("#searchForm").serialize();
                },
                fnCancel: function () {

                }

            });
        } else {
            location.href = "${ctx}/QRCode/export?formPath=/a/QRCode/getQRCodeUsedList&&maps=" + $("#searchForm").serialize();
        }

    }

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }
    
  //供子页面调用
    function getMsgToChildPageArr(id){
    	var map = {};
    	map.ids = $('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
    	map.data = $("#table-waitdispatch").jqGrid('getRowData',id);
    	var mark = "1";
    	map.mark=mark;
    	return map;
    }

</script>

</body>
</html>
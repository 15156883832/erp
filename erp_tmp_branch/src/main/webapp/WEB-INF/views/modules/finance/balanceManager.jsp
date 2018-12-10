<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>

    <meta name="decorator" content="base"/>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
    <script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.fix1.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/imgShow.js"></script>
    <style>
        .sendPresent .dropdown-clear-all{ line-height: 24px;}
        .dropdown-display{font-size: 12px}
        .dropdown-selected{margin-top: 4px}
        .paycaseWrap img{
            left: 0px;
            top:0px;
        }

    </style>
</head>
<body>
<div class="sfpagebg bk-gray ">
    <div class="sfpage ">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <sfTags:pagePermission authFlag="FINANCEMGM_SEQ_TAB" html='<a class="btn-tabBar  current" href="${ctx}/finance/balanceManager/balance">收支流水明细</a>'></sfTags:pagePermission>
                    <sfTags:pagePermission authFlag="FINANCEMGM_FACTORYSETTLE_FACTORYSETTLE_TAB" html='<a class="btn-tabBar "  href="${ctx }/finance/factorysettle">400结算录入</a>'></sfTags:pagePermission>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:jsClearForm();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
                    </p>
                </div>
                    <form id="searchForm">
                        <input type="hidden" name="page" id="pageNo" value="1">
                        <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                        <div class="bk-gray pt-10 pb-5">
                            <table class="table table-search ">
                                <tr>
                                    <th style="width: 76px;" class="text-r">费用科目：</th>
                                    <td id="reloadSignSpan">
                                     <span class="w-140">
                                     <select class="select easyui-combobox"  id="exacctName" multiple="true" multiline="false" name="exacctName" style="width:100%;height:26px" panelMaxHeight="300px">
                                       <c:forEach items="${exacctlist}" var="exacct">
                                           <option value="${exacct.columns.name }">${exacct.columns.name }</option>
                                       </c:forEach>
									 </select>

								     </span>
                                    </td>

                                    <th style="width: 76px;" class="text-r">费用类型：</th>
                                    <td>
                                     <span class="w-140 queryspan">
                                         <select class="select-box w-120"  id="costType" placeholder="请选择" name="costType"  >
                                           <option value="">请选择</option>
                                           <option value="0">收入</option>
                                           <option value="1">支出</option>
                                           <option value="2">欠款</option>
                                        </select>
								     </span>
                                    </td>

                                    <th style="width: 76px;" class="text-r">费用发生人：</th>
                                    <td id="reloadSignSpan3">
                                     <span class="w-140 dropdown-sin-2 queryspan3">
                                         <select class="select-box w-120" id="costproducer" multiple placeholder="请选择" multiline="true" name="costproducer">
                                           <c:forEach items="${sitealllist}" var="site">
                                             <option value="${site.columns.user_id }">${site.columns.name }</option>
                                          </c:forEach>
                                         </select>
                                     </span>
                                    </td>

                                    <th style="width: 76px;" class="text-r">记账人：</th>
                                    <td id="reloadSignSpan2">
								    <span class="w-140 dropdown-sin-2 queryspan2">
									   <select class="select-box w-120" id="createName" multiple placeholder="请选择" multiline="true" name="createName">
									       <c:forEach items="${sitealllist}" var="site">
                                              <option value="${site.columns.user_id }">${site.columns.name }</option>
                                           </c:forEach>
									   </select>
								    </span>
                                    </td>
                                </tr>
                                <tr>
                                  <th style="width: 76px;" class="text-r">品牌：</th>
                                    <td>
								     <input type="text" name="exacctBrand"  class="input-text w-120">
                                    </td>
                                    <th style="width: 76px;" class="text-r">详细内容：</th>
                                    <td>
								     <input type="text" name="detailContent"  class="input-text w-120">
                                    </td>
                                    <th style="width: 76px;" class="text-r">发生时间：</th>
                                    <td colspan="3">
                                        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'occurTimesMax\')}'})"  id="occurTimesMin" name="occurTimesMin" value="${occurtimemin}" class="input-text Wdate w-120" style="width:120px">
                                        至
                                        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'occurTimesMin\')}'})"  id="occurTimesMax" name="occurTimesMax"  value="${occurtimemax}" class="input-text Wdate w-120" style="width:120px">
                                    </td>
                                  
                                    
                                </tr>
                            </table>
                        </div>
                        <div class="bb pt-10 pb-10 f-14 lh-26 cl ordertjbox  mb-10">
                            <div class="f-l w-250">
                                <span class="radius  pl-20 pr-20 bg-e7eff5">收入</span>
                                <span class="f-16 " id="income"></span>
                                <span class="f-13">元</span>
                            </div>
                            <div class="f-l w-250">
                                <span class="radius  pl-20 pr-20 bg-e7eff5">支出</span>
                                <span class="f-16 " id="outcome"></span>
                                <span class="f-13">元</span>
                            </div>
                            <div class="f-l w-250">
                                <span class="radius  pl-20 pr-20 bg-e7eff5">收支差额</span>
                                <span class="f-16 c-fe0101" id="subcome"></span>
                                <span class="f-13">元</span>
                            </div>
                        </div>

                        <div class="pt-10 pb-5 cl">
                            <div class="f-l">
                                <a href="javascript:add();" class="sfbtn sfbtn-opt"><i class="sficon sficon-add"></i>新增</a>
                                <%--<a href="javascript:deletes();" class="sfbtn sfbtn-opt"><i class="sficon sficon-rubbish"></i>删除</a>--%>
                            </div>
                            <div class="f-r">
                                <a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>
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
                    </form>
            </div>
        </div>
    </div>
</div>

<div id="imgShowDiv" class="hide">
    <%--<div class="imgprogress">
        <div class="f-r paycaseWrap spimg1" >
            <img id="img-view" src="${ctxPlugin }/static/h-ui.admin/images/img-default2.png" />
        </div>
    </div>--%>
</div>
 <div class="popupBox w-320 vipPromptBox">
            <h2 class="popupHead">
                提示
            </h2>
            <div class="popupContainer">
                <div class="popupMain text-c pt-30 pb-20">
                    <div class="">
                        <i class="iconType iconType2"></i>
                        <strong class="f-16">VIP会员功能</strong>
                    </div>
                    <p class="c-666 lh-26">
                        抱歉，此功能需要<span class="c-bb3906">开通VIP会员</span>后才能使用！
                    </p>
                    <div class="text-c mt-30">
                        <%-- <a  href="#" onclick="jumpToVIP();return false;" class="sfbtn sfbtn-opt3 w-100">开通VIP会员</a>--%>
                        <span class="sfbtn sfbtn-opt3 w-100" onclick="jumpToVIP();">开通VIP会员</span>
                    </div>
                </div>
            </div>
    </div>

<script type="text/javascript">

    var sfGrid;
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部

    $(function(){
    	
   	 $.post("${ctx}/goods/sitePlatformGoods/distinct", function (result) {
            if (result == "showPopup") {

                $(".vipPromptBox").popup();
                $('#Hui-article-box', window.top.document).css({'z-index': '9'});
            }
        });
        initSfGrid();
        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
        //$("#_easyui_textbox_input1").attr("readonly","readonly")
    });

    //初始化jqGrid表格，传递的参数按照说明
    function initSfGrid(){
        var url = "${ctx}/finance/balanceManager/getbalanceManagerlist";
        sfGrid = $("#table-waitdispatch").sfGrid({
            url:url,
            sfHeader:defaultHeader,
            sfSortColumns:sortHeader,
            shrinkToFit: true,
            multiselect: false,
            postData:$("#searchForm").serializeJson(),
            rownumbers : true,
            gridComplete:function(){
                _order_comm.gridNum();
            },
            loadComplete: function() {
                $.ajax({
                    type:"post",
                    url:"${ctx}/finance/balanceManager/sumbalanceAmount",
                    data:$("#searchForm").serializeJson(),
                    success:function(result){
                        if(result!=null&&result!=""){
                            if(result.income!=null&&result.income!=""){
                                $("#income").html(parseFloat(result.income).toFixed(2));
                            }else{
                                $("#income").html(parseFloat(0).toFixed(2));
                            }
                            if(result.outcome!=null&&result.outcome!=""){
                                $("#outcome").html(parseFloat(result.outcome).toFixed(2));
                            }else{
                                $("#outcome").html(parseFloat(0).toFixed(2));
                            }
                            if(result.sub!=null&&result.sub!=""){
                                $("#subcome").html(parseFloat(result.sub).toFixed(2));
                            }else{
                                $("#subcome").html(parseFloat(0).toFixed(2));
                            }
                        }else{
                            $("#income").html(parseFloat(0).toFixed(2));
                            $("#outcome").html(parseFloat(0).toFixed(2));
                            $("#subcome").html(parseFloat(0).toFixed(2));
                        }

                    }
                });
            }
        });
    }

    function jumpToVIP() {
    	layer.open({
    		type : 2,
    		content : '${ctx}/goods/sitePlatformGoods/jumpVIP',
    		title : false,
    		area : [ '100%', '100%' ],
    		closeBtn : 0,
    		shade : 0,
    		anim : -1
    	});
    }
    function add(){//打开添加弹出框
        layer.open({
            type : 2,
            content:'${ctx}/finance/balanceManager/toadd',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function costTypefmt(rowDate) {
        if (rowDate.cost_type == "0") {
            return "<span>收入</span>"
        } else if (rowDate.cost_type == "1") {
            return "<span>支出</span>"
        } else if (rowDate.cost_type == "2") {
            return "<span>欠款</span>"
        } else {
            return "<span></span>"
        }
    }


    function fmtoperate(rowData){
        var html1='';
        var html2='';
        var html3='';
        if('${fns:checkBtnPermission("FINANCEMGMMGM_FINANCEMGMMGM_BALANCEEMGM_EDIT_BTN")}' === 'true'){
            html1 = '<a class="c-0383dc mr-5" href="javascript:bianji(\'' + rowData.id + '\');"><i class="sficon sficon-edit"></i>编辑</a>&nbsp;&nbsp;';
        }
        if('${fns:checkBtnPermission("FINANCEMGMMGM_FINANCEMGMMGM_BALANCEEMGM_FORBIT_BTN")}' === 'true'){
            html2 = '<a class="c-0383dc mr-5" href="javascript:shanchu(\'' + rowData.id + '\');"><i class="sficon sficon-del"></i>删除 </a>';
        }
            return html1 + html2;
    }

    function bianji(id){
        layer.open({
            type : 2,
            content:'${ctx}/finance/balanceManager/showBJ?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }
    function shanchu(id){
        var content = "确定要删除该明细？";
        $('body').popup({
            level:3,
            title:"删除",
            content:content,
            fnConfirm :function(){
                $.ajax({
                    type : "POST",
                    url : "${ctx}/finance/balanceManager/doShanchu",
                    data :{id:id},
                    success : function(data) {
                        if(data=="ok"){
                            layer.msg('删除成功!');
                            search();
                        }else{
                            layer.msg('删除失败!', {time: 1000});
                            search();
                        }
                    }
                });
                layer.closeAll('dialog');
            }
        });
    }

    function watchImgs(val){
        return '<a onclick="looking(\''+val.imgs+'\')" class="c-0383dc">查看图片</a>';
    }
    function looking(imgs){
        console.log(imgs);
        if(isBlank(imgs)){
            layer.msg("该记录未上传图片");
        }else{
            var imgArrs = imgs.split(",");
            var html='';
            for(var i=0;i<imgArrs.length;i++){
                html += '<div class="imgprogress"> <div class="f-r paycaseWrap" style="padding: 0px">';
                html += '<img class="img_" src="${commonStaticImgPath}'+imgArrs[i]+'"/>';
                html += '</div> </div>';
            }

            $("#imgShowDiv").empty().append(html);
            $('.paycaseWrap').imgShow();
            $(".img_").load(function(){
                $('.img_').click();
            });
        }
    }

    function isBlank(val){
        if (val == "" || val == null || val == undefined || val=="null") {
            return true;
        }else{
            return false;
        }
    }

    function occurtimefmt(rowDate) {
        if (rowDate.occur_time != null) {
            var timenew = rowDate.occur_time.substring(0, 10);
            return "<span>" + timenew + "</span>";
        } else {
            return "<span></span>";
        }
    }


    function jsClearForm() {
        $("#searchForm :input[type='text']").each(function () {
            $(this).val("");
        });
        $("#exacctName").combobox('clear');
        $("select").val("");
        <%--var html1 = '<span class="w-140>';--%>
        <%--html1 += '<select class="select easyui-combobox"  id="exacctName" multiple="true" multiline="false" name="exacctName" style="width:100%;height:26px" panelMaxHeight="300px">';--%>
        <%--html1 += '<c:forEach items="${exacctlist}" var="exacct">';--%>
        <%--html1 += ' <option value="${exacct.columns.name }">${exacct.columns.name }</option>';--%>
        <%--html1 += '</c:forEach>';--%>
        <%--html1 += '</select>  </span>';--%>
        <%--$("#reloadSignSpan").html(html1);--%>

        var html2 = '<span class="w-140 dropdown-sin-2 queryspan2">';
        html2 += '<select class="select-box w-120"  id="createName"  multiple placeholder="请选择" multiline="true" name="createName"  >';
        html2 += '<c:forEach items="${sitealllist}" var="site">';
        html2 += ' <option value="${site.columns.user_id }">${site.columns.name }</option>';
        html2 += '</c:forEach>';
        html2 += '</select>  </span>';
        $("#reloadSignSpan2").html(html2);

        var html3 = '<span class="w-140 dropdown-sin-2 queryspan3">';
        html3 += '<select class="select-box w-120"  id="costproducer"  multiple placeholder="请选择" multiline="true" name="costproducer"  >';
        html3 += '<c:forEach items="${sitealllist}" var="site">';
        html3 += ' <option value="${site.columns.user_id }">${site.columns.name }</option>';
        html3 += '</c:forEach>';
        html3 += '</select>  </span>';
        $("#reloadSignSpan3").html(html3);
        $('#reloadSignSpan .dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
        $('#reloadSignSpan2 .dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
        $('#reloadSignSpan3 .dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });

    }
    function search() {
        var pageSize = $("#pageSize").val();
        if ($.trim(pageSize) == '' || pageSize == null) {
            $("#pageSize").val(20);
        }
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function exports() {
        var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
        var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
        if (idArr > 10000) {
            $('body').popup({
                level: 3,
                title: "导出",
                content: content,
                fnConfirm: function () {
                    location.href = "${ctx}/finance/balanceManager/export?formPath=/a/finance/balanceManager/balance&&maps=" + $("#searchForm").serialize();
                }

            });
        } else {
            location.href = "${ctx}/finance/balanceManager/export?formPath=/a/finance/balanceManager/balance&&maps=" + $("#searchForm").serialize();

        }
    }
</script>
</body>
</html>
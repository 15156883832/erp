<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="decorator" content="base" />
	<title>全部工单</title>
	<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>

	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage table-header-settable">
		<div class="page-orderWait">
			<div class="tabBar cl mb-10">
				<a class="btn-tabBar current" href="${ctx }/secondOrder/waitCallBackTab">待回访工单<sup id="tab_c1">0</sup></a>
				<p class="f-r btnWrap">
					<a href="javascript:search();;" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt moresearch" id="moresearch" ><i class="sficon sficon-moresearch"></i>更多查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<form id="searchForm">
				<input type="hidden" name="page" id="pageNo" value="1">
				<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
				<div class="bk-gray pt-10 pb-5">
					<table class="table table-search">
						<tr>
							<th style="width: 76px;" class="text-r">二级网点：</th>
							<td class="reloadType">
                                        <span class="w-140 dropdown-sin-2">
									    <select class="select"  style="width:100%;height:25px" multiple  name="secondSite" >
										    <c:forEach items="${sites }" var="site">
												<option value="${site.columns.id }">${site.columns.name }</option>
											</c:forEach>
									    </select>
								        </span>
							</td>
							<th style="width: 76px;" class="text-r">工单编号：</th>
							<td>
								<input type="text" class="input-text" name= "number"/>
							</td>
							<th style="width: 76px;" class="text-r">用户姓名：</th>
							<td>
								<input type="text" class="input-text" name = "customerName" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">联系方式：</th>
							<td>
								<input type="text" class="input-text" name = "customerMobile" onkeydown="enterEvent(event)"/>
							</td>
							<th style="width: 76px;" class="text-r">用户地址：</th>
							<td>
								<input type="text" class="input-text" name = "customerAddress" onkeydown="enterEvent(event)"/>
							</td>
						</tr>
						<tr>
							<th style="width: 76px;" class="text-r">家电品类：</th>
							<td>
								<span class="w-140">
									<select class="select easyui-combobox" id="catgyS"  multiline="false"  style="width:100%;height:25px" panelMaxHeight="300px">
										<option value=""></option>
										<c:forEach items="${category }" var="ca">
											<option value="${ca.columns.name }">${ca.columns.name }</option>
										</c:forEach>
									</select>
									<input type="hidden" name="applianceCategory"/>
								</span>
							</td>
							<%--<th style="width: 76px;" class="text-r">工单状态：</th>
							<td>
								<span class="w-140">
									<select class="select easyui-combobox" name="statuss" id="statusFlag" multiple="true" multiline="false" style="width:100%;height:25px">
										<option value="3">待回访</option>
										<option value="4">待结算</option>
										<option value="5">已完成</option>
										<option value="6">取消工单</option>
										<option value="8">无效工单</option>
									</select>
								</span>
							</td>--%>
							<th style="width: 76px;" class="text-r">信息来源：</th>
							<td>
								<span class="select-box">
									<select class="select" name="origin">
									<option value="">请选择</option>
									<c:forEach items="${listorigin }" var="lro">
										<option value="${lro.columns.name }">${lro.columns.name }</option>
									</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">服务方式：</th>
							<td>
								<input type="text" class="input-text" id="serviceMode" name = "serviceMode"/>
							</td>
							<th style="width: 76px;" class="text-r">家电品牌：</th>
							<td>
								<input type="text" class="input-text" name="applianceBrand" />
							</td>
							<th style="width: 76px;" class="text-r">保修类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="warrantyType">
										<option value="">请选择</option>
										<option value="1">保内</option>
										<option value="2">保外</option>
									</select>
								</span>
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">服务类型：</th>
							<td>
								<span class="select-box">
									<select class="select" name="serviceType">
										<option value="">请选择</option>
										<c:forEach items="${fns:getNewServiceType() }" var="stype">
											<option value="${stype.columns.name }">${stype.columns.name }</option>
										</c:forEach>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">登记人：</th>
							<td>
								<input type="text" class="input-text" name="messengerName" />
							</td>
							<th style="width: 76px;" class="text-r">预约日期：</th>
							<td>
								<input type="text" onfocus="WdatePicker({})" id="promiseTime" name="promiseTime" value="" class="input-text Wdate">
							</td>
							<th style="width: 76px;" class="text-r">重要程度：</th>
							<td>
								<span class="select-box">
									<select class="select" name="level">
										<option value="">请选择</option>
										<option value="1">紧急</option>
										<option value="2">一般</option>
									</select>
								</span>
							</td>
							<th style="width: 76px;" class="text-r">家电条码：</th>
							<td>
								<input type="input-text"  name="elictrictyBarcode" value="" class="input-text">
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">报修时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'repairTimeMax\')||\'%y-%M-%d\'}'})" id="repairTimeMin" name="repairTimeMin"  value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'repairTimeMin\')}',maxDate:'%y-%M-%d'})" id="repairTimeMax" name="repairTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
							</td>
							<td colspan="4">
								<label style="margin-left: -12px">录单操作时间：</label>
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'recordDateMax\')}'})"  id="recordDateMin" name="recordDateMin" value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'recordDateMin\')}'})" id="recordDateMax" name="recordDateMax"  value="" class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
						<tr class="moreCondition" style="display: none;">
							<th style="width: 76px;" class="text-r">派工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'dispatchTimeMax\')||\'%y-%M-%d\'}'})" id="dispatchTimeMin" name="dispatchTimeMin"  value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'dispatchTimeMin\')}',maxDate:'%y-%M-%d'})" id="dispatchTimeMax" name="dispatchTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
							</td>
							<th style="width: 76px;" class="text-r">完工时间：</th>
							<td colspan="3">
								<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTimeMax\')||\'%y-%M-%d\'}'})"  id="endTimeMin" name="endTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
								至
								<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endTimeMin\')}',maxDate:'%y-%M-%d'})" id="endTimeMax" name="endTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div class="pt-10 pb-5 cl">
				<%--<div class="f-l">
					<sfTags:pagePermission authFlag="ORDERMGM_STAYVISTORDER_ALLORDER_ZJFD_BTN" html='<a href="javascript:showzjfd();" class="sfbtn sfbtn-opt"><i class="sficon sficon-closeorder"></i>直接封单</a>'></sfTags:pagePermission>
				</div>--%>
				<div class="f-r">
					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
					<sfTags:pagePermission authFlag="SECONDORDER_WAITCALLBACKSECONDORDER_EXPORTSECONDORDER_BTN" html='<a onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="SECONDORDER_WAITCALLBACKSECONDORDER_TITLESETSECONDORDER_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt2" id="setHeadersBtn"><i class="sficon sficon-setting"></i>表头设置</a>'></sfTags:pagePermission>
				</div>

			</div>
			<div>
				<table id="table-waitdispatch" class="table"></table>
				<div class="cl pt-10">
					<%--<div class="f-l iconsBoxWrap">
						<a class="iconDec">图标注释？</a>
						<div class="iconsBox">
							<div class="iconsBoxBg">
								<div class="cl pl-10 pt-5">
									<span class="oState state-waitVisit w-80 mb-5">待回访</span>
									<span class="oState state-waitSettlement w-80 mb-5">待结算</span>
									<span class="oState state-finished w-80 mb-5">已完成</span>
									<span class="w-80 mb-5"><i class="sficon sficon-cancel"></i>取消工单</span>
									<span class="oState state-invalid w-80 mb-5">无效工单</span>
								</div>
							</div>

							<span class="iconArrow"></span>
						</div>
					</div>--%>
					<div class="f-r">
						<div class="pagination"></div>
					</div>
				</div>
			</div>


		</div>


	</div></div>

<!-- 直接封单提示框 -->
<div class="popupBox notDispatch showzjfddiv">
	<h2 class="popupHead">
		直接封单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1"><em class="mark">*</em>直接封单理由：</label>
				<textarea id="reasonofzjfd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="savezjfd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="cancerBox()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>

<input type="hidden" id="settleFlag" name="settleFlag" value="${settleFlag }">
<script type="text/javascript">
    var id = '${headerData.id}';						//服务商表格的ID
    var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
    var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
    var defaultId = '${headerData.defaultId}';			//系统表格的ID
    var check = true;
    function numerCheck(){
        $.post("${ctx}/secondOrder/getWaitCallBackCount",{},function(result){
            $("#tab_c1").text(result.c1);
        });
    }

    $(function(){

        //$('.iconDec').showIcons();
        numerCheck();
        $.tabfold("#moresearch",".moreCondition",1,"click");
        initSfGrid();
        $('#setHeadersBtn').click(function(){
            $('.addHeaders').tableHeaderSetting({
                id:id,
                defaultId: defaultId,
                sfHeader: defaultHeader,
                sfSortColumns: sortHeader,
                tableHeaderSaveUrl:'${ctx}/operate/site/saveTableHeader'
            }).popup();
        });

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
            choice: function() {
            }
        });

        $(".secondSite").dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
            choice: function() {
            }
        });

        $("input.autoCal").change(function(){
            var sum = 0;
            $("input.autoCal").each(function(){
                if(testCash($(this).val())){
                    sum = numAdd(sum, $(this).val());
                }else if($(this).val() !=''){
                    $(this).val("");
                }
                $("#total_cost").val(sum);
            });
        });

        $("#serviceMeasures").change(function(){
            var serviceMeasures = $("#serviceMeasures").val();
            $("#setmeaAmount").empty();
            if(isBlank(serviceMeasures)){
                $(".sdefined0").show();
                $(".sdefined1").hide();
            }else{
                $(".sdefined1").show();
                $(".sdefined0").hide();
                $.ajax({
                    type:"post",
                    url:"${ctx}/order/settlementTemplate/getsetMea",
                    data:{
                        serviceMeasures :serviceMeasures
                    },
                    dataType:"json",
                    success:function(data){
                        var costD = "";
                        var obj = eval(data);
                        var length = obj.length;
                        if(length<1){
                            $("#total_cost").val(0);
                        }else{
                            var  HTML = '';
                            for(var i=0; i < length; i++)
                            {
                                HTML += '<div class="f-l mb-10">';
                                HTML += '<label class="w-100 f-l text-r">';
                                HTML += obj[i].columns.charge_name ;
                                HTML += '：</label><div class="priceWrap w-250 f-l">';
                                HTML += '<input type="text" class="input-text autoCal"  id="'+obj[i].columns.id+'" name="charge_amount" value="" onchange="updatecose();" />';
                                HTML += '<span class="unit">元</span>';
                                HTML += '</div></div>';
                                if(costD == ""){
                                    costD = obj[i].columns.id+':'+0.00;
                                }else{
                                    costD = costD+';'+ obj[i].columns.id+':'+0.00;
                                }
                            }
                            $("#setmeaAmount").append(HTML);
                            $("#combination").val(costD);
                        }
                    }
                });

            }

        });
        $('#btn_checkPay').on('click', function(){
			if($(this).hasClass('label-cbox2-selected')){
				$(this).removeClass('label-cbox2-selected');
			}else{
				$(this).addClass('label-cbox2-selected');
			}
		})
    });

    window.onload=function(){
        $("#_easyui_combobox_i1_0").remove();
    }

    $(".resetSearchBtn").on("click",function(){
        $("#catgyS").combobox('clear');

        var htmlType = '<span class="w-140 dropdown-sin-2">';
        htmlType += '<select class="select"  style="display:none" multiple  name="secondSite" >';
        htmlType += '<c:forEach items="${sites }" var="site">';
        htmlType += ' <option value="${site.columns.id }">${site.columns.name }</option>';
        htmlType += '</c:forEach>';
        htmlType += '</select>  </span>';

        $(".reloadType").html(htmlType);

        $('.dropdown-sin-2').dropdown({
            input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        });
    });

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

    function initSfGrid(){
        $("#table-waitdispatch").sfGrid({
            url : '${ctx}/secondOrder/getWaitCallBackList',
            sfHeader: defaultHeader,
            sfSortColumns:sortHeader,
            rownumbers:true,
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

    function fmtAttitude(row){
        if(row.service_attitude=='1'){
            return "十分不满意";
        }else if(row.service_attitude=='2'){
            return "不满意";
        }else if(row.service_attitude=='3'){
            return "一般 ";
        }else if(row.service_attitude=='4'){
            return "满意 ";
        }else if(row.service_attitude=='5'){
            return "十分满意 ";
        }else{
            return "";
        }
    }
    function fmtTotalMoney(rowData){
        return rowData.auxiliary_cost + rowData.serve_cost + rowData.warranty_cost;
    }

    function fmtWC(rowData){
        return rowData.confirm_cost;
    }

    function addNew(){
        layer.open({
            type : 2,
            content:'${ctx}/order/form',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function fmtOrderNo(rowData){
        return '<a href="javascript:showDetail(\''+rowData.id+'\');" class="c-0383dc">'+rowData.number+'</a>';
    }

    function search(){
        var valCategory = $('#catgyS').combobox('getValues');
        $("input[name='applianceCategory']").val(valCategory);
    	var pageSize = $("#pageSize").val();
    	if($.trim(pageSize)=='' || pageSize==null){
    		$("#pageSize").val(20);
    	}
        $("#table-waitdispatch").sfGridSearch({
            postData: $("#searchForm").serializeJson()
        });
    }

    function confirmCollection(id){//确认交款
        $('body').popup({
            level:'3',
            type:2,
            content:"您确定要交款吗?",
            fnConfirm:function(){
                $.ajax({
                    type:"post",
                    traditional:true,
                    data:{id:id},
                    url:"${ctx}/order/confirmCollection",
                    dataType:"JSON",
                    success:function(result){
                        if(result==true){
                            layer.msg("交款成功！");
                            search();
                            //window.location.reload(true);
                        }else{
                            layer.msg("交款失败，请检查！");
                        }
                    }
                })
            }
        })
    }

    function confirmCard(id){ //确认交单
    	$("#oneOrMore").val('2');
    	dealJiaodan(id,'2');
    }

    function showDetail(id){
    	$("#table-waitdispatch").jqGrid('resetSelection');
   	 $("#table-waitdispatch").jqGrid('setSelection',id);
        jiesuanFormIndex=layer.open({
            type : 2,
            content:'${ctx}/secondOrder/waitCallBackDetail?id='+id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            fadeIn:0,
            anim:-1
        });
    }
    function closejisuanform() {
        layer.close(jiesuanFormIndex);
    }

    function closeBatchForms(){

    }

    function showzjfd(){
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        if(idArr.length > 0){
            $('body').popup({
                level: 3,
                title: "提示",
                content: "您确定要将这"+idArr.length+"条工单直接封单吗？",
                fnConfirm: function () {
                    $('.showzjfddiv').popup({level:1});
                },
                fnCancel: function () {
                }
            });
        }else{
            layer.msg("请先选择数据！");
        }
    }


    var zjfdMark = false;
    function savezjfd(){
        if(zjfdMark){
            return;
        }
        var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
        var ids="";
        for(var i=0;i<idArr.length;i++){
            if(i==0){
                ids=idArr[0];
            }else{
                ids=ids+","+idArr[i];
            }
        }
        var latest_process = $.trim($("#reasonofzjfd").val());
        if(isBlank(latest_process)){
            layer.msg("请输入理由!");
            return;
        }else{
            zjfdMark = true;
            $.ajax({
                type:"POST",
                url:"${ctx}/secondOrder/waitDealOrderPlfd",
                data:{
                    id:ids,
                    latestProcess:latest_process
                },
                success:function(result){
                    if(result=="200"){
                        parent.layer.msg("封单成功！");
                        search();
                        numerCheck();
                        $.closeDiv($('.showzjfddiv'));
                    }else{
                        layer.msg("直接封单失败，请检查！");
                    }
                    zjfdMark = false;
                    return;
                },
                error:function(){
                    alert("系统繁忙!");
                    return;
                }
            });
        }
    }


    var batchJiesuanPopupDiv;
    function batchJiesuan(){
        var settleFlag = $("#settleFlag").val();
        var ids=$('#table-waitdispatch').jqGrid("getGridParam", "selarrrow");
        if(ids == null || ids.length == 0){
            layer.msg("请选择记录!");
            return ;
        }
        var pass = true;
        var dispIds = "";
        var oIds = "";
        for(var i = 0; i < ids.length; i++){
            var rowData = $("#table-waitdispatch").jqGrid('getRowData',ids[i]);
            oIds += "," + rowData.id;
            dispIds += "," + rowData.dispId;
            if(rowData.status == '待回访' && settleFlag == '0'){//用户设置了需要回访才能结算
                pass = false;
                break;
            }
        }
        if(pass){
            dispIds = dispIds.substring(1);
            oIds = oIds.substring(1);
            $("#dispIds").val(dispIds);
            $.ajax({
                type:"post",
                url:"${ctx}/order/settlement/checkAllowSettle",
                data:{ids:oIds},
                success:function(data){
                    if(data.code=="421"){
                        layer.msg("选择的工单中存在编号为"+data.errMsg+"的工单信息异常的工单，请重新选择！");
                    }else if(data.code=="200"){
                        showBatchForm(oIds);
                    }else if(data.code=="430") {
                        layer.msg("编号为"+data.errMsg+"的工单请回访后再进行结算！");
                        return;
                    }else if(data.code=="431") {
                        layer.msg("编号为"+data.errMsg+"的工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                        return;
                    }else if(data.code=="432") {
                        layer.msg("编号为"+data.errMsg+"的工单请回访后再进行结算！");
                        return;
                    }else if(data.code=="433") {
                        layer.msg("编号为"+data.errMsg+"的工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                        return;
                    } else{
                        layer.msg("检验失败，请检查！");
                        return false;
                    }
                }
            })
        }else{
            layer.msg("请先回访工单!");
            return ;
        }
    }

    function showBatchForm(oIds) {
        batchFormIndex = layer.open({
            type: 2,
            content: '${ctx}/order/settlement/batchNew?oIds=' + oIds,
            title: false,
            area: ['100%', '100%'],
            closeBtn: 0,
            shade: 0,
            fadeIn: 0,
            anim: -1
        });
    }

    function closeBatchForm() {
        layer.close(batchFormIndex);
    }

    $('select[name="fwjsfa"]').on('change',function(){
        var index = $(this).find("option:selected").val();
        $('.sdefined').hide();
        $('.sdefined'+index).show();
    });

    function changeUnit(obj){
        var oIndex = $(obj).find('option:selected').val();
        $(obj).closest('.jsbox').find('.priceWrap').hide();
        $(obj).closest('.jsbox').find('.jsbox'+oIndex).show();

    }

    function saveBatchSettle(){
        if(!testCash($("#total_cost").val())){
            layer.msg("结算总额格式不正确!")
            return ;
        }
        $("input[name='charge_amount']").each(function(i, item){
            if(isBlank($(this).val())){
                check = false;
                return ;
            }else{
                check = true;
            }
        });
        var postData = $("#settleForm").serializeJson();


        if(check){

            $.post("${ctx}/order/orderSettlemnt/batchSaveSettlement", postData, function(result){
                $.closeDiv(batchJiesuanPopupDiv);

            });
        }else{
            layer.msg("请输入结算金额！");
            return ;
        }

    }

    function fmtOrderStatus(){
        return "<span class='oState state-waitVisit'>待回访工单&nbsp&nbsp&nbsp</span>";
    }

    function exports(){
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

        var idArr=$("#table-waitdispatch").jqGrid('getGridParam','records')
        var content="共"+idArr+"条数据，本次允许导出前10000条，确定继续导出吗？";
        if(idArr>10000){
            $('body').popup({
                level:3,
                title:"导出",
                content:content,
                fnConfirm :function(){
                    location.href="${ctx}/secondOrder/exportDuringOrCallBack?formPath=/a/secondOrder/waitCallBackTab&&maps="+$("#searchForm").serialize()+"&whoExport=wait";
                },
                fnCancel: function () {

                }

            });
        }else{
            location.href="${ctx}/secondOrder/exportDuringOrCallBack?formPath=/a/secondOrder/waitCallBackTab&&maps="+$("#searchForm").serialize()+"&whoExport=wait";
        }

    }

    function cancerBox(){
        $.closeDiv($('.showzjfddiv'));
    }

	/*enter查询*/
    function enterEvent(event){
        var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
        if (keyCode ==13){
            $("#table-waitdispatch").sfGridSearch({
                postData: $("#searchForm").serializeJson()
            });
        }
    }

    function reAccount(rowData) {
        var html = '';
        if (rowData.record_account == '1') {
            html = '是';
        } else {
            html = '<a style="color:blue;" onclick="confirmAccount(\'' + rowData.id + '\')">确认</a>';
        }
        return html;
    }

    function confirmAccount(id) {
        $(".confirmAccountpop #orderIds").val(id);
        $('.confirmAccountpop').popup();
    }
    function quxiaoAccount() {
        $("#factoryNumber").val("");
        $.closeDiv($('.confirmAccountpop'));
    }
    var plIds="";
    function dealJiaodan(ids,type){//处理交单
    	$(".showOrHide").hide();
    	$("#btn_checkPay").removeClass('label-cbox2-selected');
    	 //异步获取数据
        $.ajax({
        	type:"post",
        	url:"${ctx}/order/jiaodanPageShow",
        	data:{ids:ids},
        	success:function(data){
        		//type:1批量交单 2 单个交单
       			if(data.count < 1){
       				var msg = "您选择的数据中没有可以确认交单的，请重新选择！";
       				if(type=="2"){
       					msg="该工单已确认交单，请重新选择！";
       				}
           			layer.msg(msg);
           			return;
           		}
       			plIds = data.idss;
       			var result = data.data.columns;
       			$(".youxiaoOrder").text(data.count);//需要交单的工单数
       			$(".nomoneyPay").text((isBlankJd(result.allMoney) ? 0.00 : result.allMoney).toFixed(2));//无现金收款
       			$(".zfbPayMoney").text((isBlankJd(result.zfbMoney) ? 0.00 : result.zfbMoney).toFixed(2));//支付宝收款
       			$(".wxPayMoney").text((isBlankJd(result.wxMoney) ? 0.00 : result.wxMoney).toFixed(2));//微信收款
       			$(".payMoneyOrderAll").text((isBlankJd(result.realPayMoney) ? 0.00 : result.realPayMoney).toFixed(2));//收款总额
       			var flashMy = (parseFloat($(".payMoneyOrderAll").text())-parseFloat($(".nomoneyPay").text())).toFixed(2);
       			if(parseFloat(flashMy) < parseFloat(0)){
       				flashMy=0;
       			}
       			$('#ifSelect').val('2');
       			$(".payFlash").text(flashMy);//现金收款
       			$(".realPayMoney").val((isBlankJd(result.realPayMoney) ? 0.00 : result.realPayMoney).toFixed(2));//实收金额
       			var rpm = $('.realPayMoney');
       			if(type=="2"){//单个交单
       				$(".zanshiyincang").show();
       				$(".showNumsTip").hide();
       				/* rpm.removeClass("readonly");
       				rpm.removeAttr("readonly"); */
       				if(result.whether_collection=="1"){//是否交款,1:已交款
       					$("#btn_checkPay").addClass('label-cbox2-selected');
       					$('#ifSelect').val('1');
       					$(".realPayMoney").val((isBlankJd(result.shishouMoney) ? 0.00 : result.shishouMoney).toFixed(2));//实收金额
       					$(".showOrHide").show();
       				}
       			}
       			if(type=="1"){//批量交单
       				$(".zanshiyincang").hide();
       				$(".showNumsTip").show();
       				/* rpm.addClass("readonly");
       				rpm.attr("readonly","readonly"); */
       			}
       			
       		    $("#btn_checkPay").bind('click',function(){
       		    	var ts = $("#btn_checkPay");
       		    	if(ts.hasClass('label-cbox2-selected')){
       		    		$(".showOrHide").show();
       		    		$('#ifSelect').val('1');
       		    	}else{
       		    		$(".showOrHide").hide();
       		    		$('#ifSelect').val('2');
       		    	}
       		    })
       			
       			$(".jiaodan").popup();
        	}
        })
    }
    
    function isBlankJd(num){
    	if($.trim(num)=="" || num==null || num==undefined ){
    		return true;
    	}
    	if(parseFloat(num < parseFloat(0))){
    		return true;
    	}
    	return false;
    }
    var rcClick = false;
    function clickConfirmRC(){
    	if(rcClick){
    		return;
    	}
    	var relMoney = $('.realPayMoney').val();
    	var ifSelect = $('#ifSelect').val();
    	var oneOrMore = $('#oneOrMore').val();
    	if(ifSelect=="1"){
    		if(!checkShiShouMy(relMoney)){
    			layer.msg("实收金额格式有误！");
        		return;
        	}
    	}
    	rcClick=true;
    	 $.ajax({
             type:"post",
             traditional:true,
             data:{id:plIds,relMoney:relMoney,ifSelect:ifSelect,oneOrMore:oneOrMore},
             url:"${ctx}/order/confirmCard",
             success:function(result){
                 if(result=="ok"){
                     layer.msg("交单成功！");
                     search();
                     $.closeDiv($('.jiaodan'));
                 }else if(result=="notExist"){
                	 layer.msg("工单信息信息有误，交单失败！");
                	 return;
                 }else{
                     layer.msg("交单失败，请检查！");
                     return ;
                 }
                 rcClick=false;
             }
         })
    }
    $(".realPayMoney").blur(function(){
    	var blon = checkShiShouMy($.trim($(".realPayMoney").val()));
    	if(!blon){
    		layer.msg("实收金额格式有误！");
    	};
    });
    function checkShiShouMy(num){
    	var money = /^[0-9]+(.[0-9]{1,2}?|)$/;
    	return money.test(num);
    };
    
    function closeJiaodan(){
    	$.closeDiv($('.jiaodan'));
    }
</script>

</body>
</html>
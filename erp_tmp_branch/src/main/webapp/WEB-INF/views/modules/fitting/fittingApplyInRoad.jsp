<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base"/>
    <title>全部工单</title>
    <script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray">
    <div class="sfpage">
        <div class="page-orderWait">
            <div id="tab-system" class="HuiTab">
                <div class="tabBar cl mb-10">
                    <sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEAPPLY_TAB"
                                           html='<a class="btn-tabBar "  href="${ctx }/fitting/fittingApply/getApplyList">待审核<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
                    <sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_WAITEOUTPUT_TAB"
                                           html='<a class="btn-tabBar"  href="${ctx }/fitting/fittingApply/ThelibraryHeader">待出库<sup  id="tab_c2">0</sup></a>'></sfTags:pagePermission>
                    <sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_TAB"
                                           html='<a class="btn-tabBar " href="${ctx }/fitting/fittingApply/ApplyallHeader">全部申请</a>'></sfTags:pagePermission>
                    <sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ONROAD_TAB"
                                           html='<a class="btn-tabBar current" href="${ctx }/fitting/fittingApply/fittingInRoad">备件在途<sup  id="tab_c3">0</sup></a>'></sfTags:pagePermission>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i class="sficon sficon-reset"></i>重置</a>
                    </p>
                </div>
                <form id="searchForm">
                    <input type="hidden" name="page" id="pageNo" value="1">
                    <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                    <input type="hidden" name="applyId" value="${applyId}"/>
                    <div class="bk-gray pt-10 pb-5">
                        <table class="table table-search">
                            <tr>
                                <th style="width: 76px;" class="text-r">备件条码：</th>
                                <td>
                                    <input type="text" class="input-text" name="fittingCode"/>
                                </td>
                                <th style="width: 76px;" class="text-r">备件名称：</th>
                                <td>
                                    <input type="text" class="input-text" name="fittingName"/>
                                </td>
                                <th style="width: 76px;" class="text-r">计划状态：</th>
                                <td>
                                   <span class="select-box" >
                                   		<select class="select" name="fapStatus">
												<option value="">请选择</option>
												<option value="1">待入库</option>
												<option value="2">已入库</option>
												<option value="3">已取消</option>
										</select>
									</span>
                                </td>
                                <th style="width: 76px;" class="text-r">计划时间：</th>
                                <td colspan="3">
                                    <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-140">
                                    至
                                    <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="" class="input-text Wdate w-140">
                                </td>
                            </tr>
                            <tr>
                                <th style="width: 76px;" class="text-r">申请人：</th>
                                <td>
                                    <input type="text" class="input-text" name="applicant"/>
                                </td>
                                <th style="width: 76px;" class="text-r">备注：</th>
                                <td>
                                    <input type="text" class="input-text" name="marks"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </form>


                <div class="pt-10 pb-5 cl">
                    <div class="f-r">
                        <sfTags:pagePermission authFlag="FITTINGMGM_FITAPPLY_ALLAPPLY_EXPORT_BTN" html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
                    </div>
                </div>
                <div>
                    <table id="table-waitdispatch" class="table"></table>
                    <div class="cl pt-10">
						<div class="f-l">
						<span class="c-f55025">注：</span>
							<span class="fittingOntheway">缺件的备件进行备件计划后审核被拒绝</span>
					</div>
                        <div class="f-r">
                            <div class="pagination"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
        <!-- 表头设置 -->
		<div class="">
			<div>
				<h2></h2>
			</div>
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
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
        <script type="text/javascript">
            var id = '${headerData.id}';						//服务商表格的ID
            var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
            var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
            var defaultId = '${headerData.defaultId}';			//系统表格的ID

            $(function () {
                $.post("${ctx}/goods/sitePlatformGoods/distinct", function (result) {
                    if (result == "showPopup") {

                        $(".vipPromptBox").popup();
                        $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                    }
                });
                initNumber();
                $.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
                $.tabfold("#moresearch", ".moreCondition", 1, "click");
                $('#setHeadersBtn').click(function () {
                    $('.addHeaders').tableHeaderSetting({
                        id: id,
                        defaultId: defaultId,
                        sfHeader: defaultHeader,
                        sfSortColumns: sortHeader,
                        tableHeaderSaveUrl: '${ctx}/operate/site/saveTableHeader'
                    }).popup();
                });
                initSfGrid();
                $("#applianceCategory").combobox('clear');
            });

            function initNumber() {
                $.post("${ctx}/fitting/twoStatusCount", function (result) {
                    $("#tab_c1").text(result[0].sh);
                    $("#tab_c2").text(result[1].ck);
                    $("#tab_c3").text(result[2].zt);
                });
            }

            $(".resetSearchBtn").on("click",function(){
                $('#applianceCategory').combobox('setValues',"");
            });

            function isBlank(val) {
                if (val == null || val == '' || val == undefined) {
                    return true;
                }
                return false;
            }

            function initSfGrid() {
                $("#table-waitdispatch").sfGrid({
                    multiselect: false,
                    url: '${ctx}/fitting/fittingApply/getFittingInRoadList',
                    sfHeader: defaultHeader,
                    sfSortColumns: sortHeader,
                    rownumbers : true,
                    postData:$("#searchForm").serializeJson(),
        			gridComplete : function() {
        				_order_comm.gridNum();
                        $("input[name='applyId']").val("");
        			}
                });
            }


        
            
            function cancelFittingPlan(id,orderNumber){
            	if(isBlank(id)){
            		layer.msg("数据有误，请稍后再试！");
            		return 
            	}
            	var content = "确定要取消备件在途？";
    			$('body').popup({
    				level : 3,
    				title : "取消备件在途",
    				content : content,
    				fnConfirm : function() {
            	   $.ajax({
            	         type: "POST",
            	         url: "${ctx}/fitting/fittingApply/cancelFittingPlan",
            	         data: {
            	             id: id,
            	             orderNumber:orderNumber
            	         },
            	         success: function (result) {
            	             if (result == "ok") {
            	                 layer.msg("取消成功！");
            	                 search();
            	             }  else {
            	                 layer.msg("取消失败，请检查！");
            	             }
            	         }
            	     });
    				}
    			})
            }
            function deleteFittingPlan(id){
            	if(isBlank(id)){
            		layer.msg("数据有误，请稍后再试！");
            		return 
            	}
            	   $.ajax({
            	         type: "POST",
            	         url: "${ctx}/fitting/fittingApply/deleteFittingAppPlan",
            	         data: {
            	             id: id
            	         },
            	         success: function (result) {
            	             if (result == "ok") {
            	                 layer.msg("取消成功！");
            	                 search();
            	             }  else {
            	                 layer.msg("取消失败，请检查！");
            	             }
            	         }
            	     });
            }


            function sureToPutInStock(id) {
                layer.open({
                    type: 2,
                    content: '${ctx}/fitting/fittingApply/getFittingApplyPlanById?id=' + id,
                    title: false,
                    area: ['100%', '100%'],
                    closeBtn: 0,
                    shade: 0,
                    fadeIn: 0,
                    anim: -1
                });
            }
            
            function fmtStatus(rowData){
            	var html = "";
             	if(rowData.applyStatus ==6 || rowData.applyStatus == null){
             		html = "<span class='fittingOntheway' title ='已删除申请'></span>";
            	}
             	if(rowData.status == 1){
            		html += "<span class='oState state-waitRk'>待入库</span>";
            	}else if(rowData.status == 2){
            		html += "<span class='oState state-yrk'>已入库</span>";
            	} else{
            		html += "<span class='oState state-canceled'>已取消</span>";
            	} 
             	return html;
            }
            
            function fmtOper(rowData){
                if(rowData.status==3){
                    return '<span><a href="javascript:deleteFittingPlan(\''+rowData.id+'\');" class="c-0383dc">删除</a></span>';
                }else if(rowData.status==1){
                    return '<span><a href="javascript:sureToPutInStock(\''+rowData.id+'\');" class="c-0383dc">确认入库</a></span>&nbsp;&nbsp;'
                    +'<span><a href="javascript:cancelFittingPlan(\''+rowData.id+'\',\''+rowData.order_number+'\')" class="c-0383dc">取消</a></span>';
                }else if(rowData.status==2){
                    return "已入库";
                }
            }

            function search() {
                var pageSize = $("#pageSize").val();
            	if($.trim(pageSize)=='' || pageSize==null){
            		$("#pageSize").val(20);
            	}
                initNumber();
                $("#table-waitdispatch").sfGridSearch({
                    postData: $("#searchForm").serializeJson()
                });
            }

            function jumpToVIP() {
                layer.open({
                    type: 2,
                    content: '${ctx}/goods/sitePlatformGoods/jumpVIP',
                    title: false,
                    area: ['100%', '100%'],
                    closeBtn: 0,
                    shade: 0,
                    anim: -1
                });
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
                            location.href="${ctx}/fitting/fittingApply/fitInRoadExport?formPath=/a/fitting/fittingApply/fittingInRoad&&maps="+$("#searchForm").serialize();
                        }

                    });
                }else{
                    location.href="${ctx}/fitting/fittingApply/fitInRoadExport?formPath=/a/fitting/fittingApply/fittingInRoad&&maps="+$("#searchForm").serialize();
                }


            }

        </script>
</body>
</html>
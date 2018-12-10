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
                    <sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_APPLY_TAB" html='<a class="btn-tabBar current" href="${ctx }/factoryfitting/Apply/siteApplyHeader">厂家备件申请</a>'></sfTags:pagePermission>
                    <p class="f-r btnWrap">
                        <a href="javascript:search();" class="sfbtn sfbtn-opt"><i
                                class="sficon sficon-search"></i>查询</a>
                        <a href="javascript:;" class="sfbtn sfbtn-opt resetSearchBtn"><i
                                class="sficon sficon-reset"></i>重置</a>
                    </p>
                </div>
                <form id="searchForm">
                    <input type="hidden" name="page" id="pageNo" value="1">
                    <input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
                    <div class="bk-gray pt-10 pb-5">
                        <table class="table table-search">
                            <tr>
                                <th style="width: 76px;" class="text-r">申请单号：</th>
                                <td>
                                    <input type="text" class="input-text" name="number"/>
                                </td>
                                <th style="width: 76px;" class="text-r">审核状态：</th>
                                <td>
                                    <span class="select-box">
										<select class="select" name="status">
											<option value="">请选择</option>
											<option value="0">待审核</option>
											<option value="1">已审核</option>
											<option value="2">已出库</option>
											<option value="3">已入库</option>
										</select>
									</span>
                                </td>
                                <th style="width: 76px;" class="text-r">申请人：</th>
                                <td>
                                    <input type="text" class="input-text" name="creator"/>
                                </td>
								<th style="width: 76px;" class="text-r">申请时间：</th>
								<td colspan="2">
									<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')||\'%y-%M-%d\'}'})" id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-140">
									至
									<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}',maxDate:'%y-%M-%d'})" id="createTimeMax" name="createTimeMax" value="" class="input-text Wdate w-140">
								</td>
                            </tr>
                        </table>
                    </div>
                </form>


                <div class="pt-10 pb-5 cl">
                	<div class="f-l">
                		<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_APPLY_ADDAPPLY_BTN" html='<a href="javascript:addFactoryFittingApply();" class="sfbtn sfbtn-opt" id="xzhelp"><i class="sficon sficon-add"></i>添加申请</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_APPLY_EDITAPPLY_BTN" html='<a href="javascript:editFactoryFittingApply();" class="sfbtn sfbtn-opt"><i class="sficon sficon-edit"></i>修改申请</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_APPLY_INSTOCKS_BTN" html='<a href="javascript:instock();" class="sfbtn sfbtn-opt" id="rkhelp"><i class="sficon sficon-sdrk"></i>到货入库</a>'></sfTags:pagePermission>
                	</div>
                    <div class="f-r">
    					<a href="javascript:;" class="sfbtn sfbtn-opt2 reloadPageBtn"><i class="sficon sficon-reload"></i>刷新</a>
                    	<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_APPLY_DELETE_BTN" html='<a href="javascript:plsc();" class="sfbtn sfbtn-opt2"><i class="sficon sficon-rubbish"></i>删除</a>'></sfTags:pagePermission> 
						<sfTags:pagePermission authFlag="FACTORYFITTING_FACTORYFITTING_APPLY_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2" target="_blank"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
					</div>
                </div>
                <div>
                    <table id="table-waitdispatch" class="table"></table>
                    <div class="cl pt-10">
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
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
        <script type="text/javascript">
            var id = '${headerData.id}';						//服务商表格的ID
            var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
            var sortHeader = '${headerData.sortHeader}';		//服务商自定义过的表格头部
            var defaultId = '${headerData.defaultId}';			//系统表格的ID

            $(function () {
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
            });

            function isBlank(val) {
                if (val == null || val == '' || val == undefined) {
                    return true;
                }
                return false;
            }

            function initSfGrid() {
                $("#table-waitdispatch").sfGrid({
                    multiselect: true,
                    url: '${ctx}/factoryfitting/Apply/getSiteApplyList',
                    sfHeader: defaultHeader,
                    sfSortColumns: sortHeader,
                    shrinkToFit:true,
                    rownumbers : true,
        			gridComplete : function() {
        				_order_comm.gridNum();
        			}
                });
            }

            function fmtOrderNo(rowData) {
                return '<a href="javascript:showDetail(\'' + rowData.id + '\');">' + rowData.number + '</a>';
            }

            function search() {
                var pageSize = $("#pageSize").val();
            	if($.trim(pageSize)=='' || pageSize==null){
            		$("#pageSize").val(20);
            	}
                $("#table-waitdispatch").sfGridSearch({
                    postData: $("#searchForm").serializeJson()
                });
            }
            
            function fmtSiteStatus(rowData){
            	var status = rowData.status;
            	if(status=='0'){
            		return "<span class='oState state-waitVerify'>待审核</span>";
            	}
            	if(status=='1'){
            		return "<span class='oState state-verifyPass'>待出库</span>";
            	}
            	if(status=='2'){
            		return "<span class='oState state-yck'>在途</span>";
            	}
            	if(status=='3'){
            		return "<span class='oState state-yrk'>已入库</span>";
            	}
            	return "未知";
            }
            
            function fmtSiteNumber(rowData){
            	return '<a href="javascript:showDetail(\'' + rowData.id + '\');" class="c-0383dc">' + rowData.number + '</a>';
            }
            
            function fmtlogisticsNo(rowData){
            	var logisticsNo = rowData.logistics_no;
            	if(!isBlank(logisticsNo)){
            	return '<a href="javascript:logsitDetail(\'' + rowData.id + '\');" class="c-0383dc">' + rowData.logistics_no + '</a>';
            	}
            	return "";
            }
            
          //物流信息
    		function logsitDetail(id){
    			layer.open({
    				type : 2,
    				content:'${ctx}/factoryfitting/Apply/logsitDetail?id='+id+"&type=1",
    				title:false,
    				area: ['100%','100%'],
    				closeBtn:0,
    				shade:0,
    				anim:-1 
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
                            location.href="${ctx}/factoryfitting/Apply/exports?formPath=/a/factoryfitting/Apply/siteApplyHeader&&maps="+$("#searchForm").serialize();
                        }

                    });
                }else{
                    location.href="${ctx}/factoryfitting/Apply/exports?formPath=/a/factoryfitting/Apply/siteApplyHeader&&maps="+$("#searchForm").serialize();
                }

            }
            
            //添加备件申请
            function addFactoryFittingApply() {
                layer.open({
                    type: 2,
                    content: '${ctx}/factoryfitting/Apply/addFactoryFittingApplyForm',
                    title: false,
                    area: ['100%', '100%'],
                    closeBtn: 0,
                    shade: 0,
                    fadeIn: 0,
                    anim: -1
                });
            }
            
          //修改备件申请
            function editFactoryFittingApply(){
            	 var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
            	 if(idArr.length < 0){
            		 layer.msg("请选择您要修改的数据！");
            		 return;
            	 }
            	 if(idArr.length > 1){
            		 layer.msg("只能选择一条数据进行修改！");
            		 return;
            	 }
            	 var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]);
            	 var status = rowData.status;
            	 if(status!='待审核'){
            		 layer.msg("只有待审核状态的数据可以修改！");
            		 return ;
            	 }
            	 layer.open({
                     type: 2,
                     content: '${ctx}/factoryfitting/Apply/editFactoryFittingApplyForm?id='+idArr[0],
                     title: false,
                     area: ['100%', '100%'],
                     closeBtn: 0,
                     shade: 0,
                     fadeIn: 0,
                     anim: -1
                 });
            }
          
          function plsc(){
        	  var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
         	  if(idArr.length < 0){
         		  layer.msg("请选择您要删除的备件申请！");
         		  return;
         	  }
         	  var mark = 0;
         	  for(var i=0;i<idArr.length;i++){
         		 var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[i]);
            	 var status = rowData.status;
            	 if(status!='待审核'){
            		 mark = 1;
            	 }
         	  }
         	  if(mark==1){
         		  layer.msg("只能删除待审核的备件申请！");
         		  return ;
         	  }
         	 $('body').popup({
                 level:3,
                 title:"删除备件",
                 content:"您确定要是删除这"+idArr.length+"条备件申请吗？",
                 fnConfirm:function(){
                     $.ajax({
                         type : "POST",
                         url : "${ctx}/factoryfitting/Apply/deleteFittingApply",
                         data :{"ids":idArr.join(',')},
                         success : function(data) {
                             if(data=="200"){
                                 layer.msg('删除成功!');
                                 $("#table-waitdispatch").trigger("reloadGrid");
                                 //window.location.reload(true);
                             }else if(data=="420"){
                                 layer.msg('备件申请信息有误!', {time: 1000});
                             }else if(data=="421"){
                                 layer.msg('存在不可删除的备件申请，请刷新列表后重新选择', {time: 1000});
                             }else{
                             	layer.msg("未知错误，请联系管理员！");
                             }
                         }
                     });
                 }
             });
          }
          
          function instock(){
        	  var idArr = $('#table-waitdispatch').jqGrid('getGridParam', 'selarrrow');
         	 if(idArr.length < 0){
         		 layer.msg("请选择您要到货入库的备件申请！");
         		 return;
         	 }
         	 if(idArr.length > 1){
         		 layer.msg("只能选择一条数据进行到货入库操作！");
         		 return;
         	 }
         	 var rowData = $('#table-waitdispatch').jqGrid('getRowData', idArr[0]);
         	 var status = rowData.status;
         	 if(status!='在途'){
         		 layer.msg("只有在途状态的数据才可以进行到货入库操作！");
         		 return ;
         	 }
         	 layer.open({
                  type: 2,
                  content: '${ctx}/factoryfitting/Apply/factoryFittingApplyInStocksForm?id='+idArr[0],
                  title: false,
                  area: ['100%', '100%'],
                  closeBtn: 0,
                  shade: 0,
                  fadeIn: 0,
                  anim: -1
              });
          }
          
          function showDetail(id){
        	  layer.open({
                  type: 2,
                  content: '${ctx}/factoryfitting/Apply/applyDetailForm?id='+id,
                  title: false,
                  area: ['100%', '100%'],
                  closeBtn: 0,
                  shade: 0,
                  fadeIn: 0,
                  anim: -1
              });
          }

        </script>

</body>
</html>
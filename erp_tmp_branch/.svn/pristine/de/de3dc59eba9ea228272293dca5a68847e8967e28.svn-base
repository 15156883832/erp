<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>预警明细</title>
<meta name="decorator" content="base" />
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<style>
.csWrap_dt{
height: 90px;
    line-height: 90px;
    width: 120px;
    font-size: 14px;
    font-weight: 600;
    float: left;
    padding-left: 10px;
    border-right: 1px solid #ccc;
}
.xinxi_{
overflow:hidden;
width:48vw;
float:left;
margin-top:10px;

}
.xinxi_ dl{
border:1px solid #ddd;
}
.xinxi_:last-of-type{
float:right;
margin-left:20px;
}
</style>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMDETAIL_TAB" html='<a class="btn-tabBar current" href="${ctx }/operate/siteAlarm/headerList">系统预警消息</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_XITONGGONGGAO_TAB" html='<a class="btn-tabBar " href="${ctx}/order/announcement/read">系统公告</a>'></sfTags:pagePermission>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt"><i
								class="sficon sficon-search"></i>查询</a> <a href="javascript:;"
								class="sfbtn sfbtn-opt " id="reset"><i
								class="sficon sficon-reset"></i>重置</a>
						</p>
					</div>
					<div class="tabCon">
						<div class="mt-20">
							<div id="xinxi" class='xinxi_'>
								<%-- <dl class="mb-10 pb-10 pt-10 cl csWrap text-c">
									<dt class="csWrap_dt">工单超时预警</dt>
									<dd class="csWrap_dd">
										<div class="f-l w-120">
											<span class="orderCount">${employeCount }</span>
											<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=1" class="c-f55025 f-14">派工</a><span class="f-14">超时</span></p>
										</div>
										<div class="f-l w-120">
											<span class="orderCount">${finishedCount }</span>
											<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=2" class="c-f55025 f-14">服务完工</a><span class="f-14">超时</span></p>
										</div>
									</dd>
								</dl>  --%>	
								</div>
							<div class='xinxi_' id="peijian">
								
								<%-- <dl class="mb-10 pb-10 pt-10 cl csWrap text-c">
									<dt class="csWrap_dt">工单超时预警</dt>
									<dd class="csWrap_dd">
										<div class="f-l w-120">
											<span class="orderCount">${employeCount }</span>
											<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=1" class="c-f55025 f-14">派工</a><span class="f-14">超时</span></p>
										</div>
										<div class="f-l w-120">
											<span class="orderCount">${finishedCount }</span>
											<p class="lh-26"><a href="${ctx }/operate/siteAlarm/headerList?type=2" class="c-f55025 f-14">服务完工</a><span class="f-14">超时</span></p>
										</div>
									</dd>
								</dl> --%> 	
								</div>
					
						</div>
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1"> 
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">预警类型：</th>
										<td><span class="select-box" id="selectBox"> <select
												class="select" name="type" id="type">
													<!-- <option value="">请选择</option>
										<option value="1">工程师接单预警</option>
										<option value="2">服务完成工单预警</option>
										<option value="3">库存预警</option>
										<option value="4">缺件预警</option> -->
											</select>
										</span> <input id="remark" hidden="hidden" name="remark" value="detl" />
										</td>
									</tr>
								</table>
							</div>
						</form>

						<div class="pt-10 pb-5 cl">
						<div class="f-l">
					<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMDETAIL_PLQXYJ_BTN" html='<a href="javascript:;" class="sfbtn sfbtn-opt" onclick="quxiaoyj();"><i class="sficon  sficon-cautionCancel"></i>取消预警</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMDETAIL_PLBJ_BTN" html='<a href="javascript:Bj();" class="sfbtn sfbtn-opt"><i class="sficon sficon-top"></i>置顶</a>'></sfTags:pagePermission>
					<sfTags:pagePermission authFlag="OPERATEMGM_SYSALARMMSG_ALARMDETAIL_PLQXBJ_BTN" html='<a href="javascript:quxiaoBj();" class="sfbtn sfbtn-opt"><i class="sficon sficon-cancelTop"></i>取消置顶</a>'></sfTags:pagePermission>
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

	<script type="text/javascript"
		src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
	<script type="text/javascript">
		var id = '${headerData.id}'; //服务商表格的ID
		var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
		var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		var defaultId = '${headerData.defaultId}'; //系统表格的ID
		var markType = '${markType}';
		var peiJian = '${peiJian }';
		var xinXi = '${xinXi }';
		
		var employeCount = '${employeCount }';
		var finishedCount = '${finishedCount }';
		var storeCount = '${storeCount }';
		var shortCount = '${shortCount }';

		$(function() {
			if (peiJian == "true" && xinXi == "true") {
				$("#type").append(
						'<option value="">请选择</option>'
								+ '<option value="1">工程师接单预警</option>'
								+ '<option value="2">工程师完工预警</option>'
								+ '<option value="3">库存预警</option>'
								+ '<option value="4">缺件预警</option>');
			} else if (peiJian == "false" && xinXi == "false") {
				$("#type").append('<option value="">请选择</option>');
			} else if (peiJian == "true" && xinXi == "false") {
				$("#type").append(
						'<option value="">请选择</option>'
								+ '<option value="3">库存预警</option>'
								+ '<option value="4">缺件预警</option>');
			} else if (peiJian == "false" && xinXi == "true") {
				$("#type").append(
						'<option value="">请选择</option>'
								+ '<option value="1">工程师接单预警</option>'
								+ '<option value="2">工程师完工预警</option>');
			}

			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon",
					"current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			if (markType == "1" || markType == "2" || markType == "3"
					|| markType == "4") {
				$("#type option[value='" + markType + "']").attr("selected",
						"selected");//根据值让option选中  
			}
			initSfGrid();
			
		 	if(xinXi=="true"){
				$("#xinxi").append(
				'<dl class="mb-20 cl csWrap text-c">'+
					'<dt class="csWrap_dt">工单超时预警</dt>'+
					'<dd class="csWrap_dd">'+
						'<div class="f-l w-120">'+
							'<span class="orderCount">'+employeCount+'</span>'+
							'<p class="lh-26"><a href="javascript:;" class="c-f55025 f-14">派工</a><span class="f-14">超时</span></p>'+
						'</div>'+
						'<div class="f-l w-120">'+
							'<span class="orderCount">'+finishedCount+'</span>'+
							'<p class="lh-26"><a href="javascript:;" class="c-f55025 f-14">服务完工</a><span class="f-14">超时</span></p>'+
						'</div>'+
					'</dd>'+
				'</dl>');
			} 
			if(peiJian=="true"){
				$("#peijian").append(
				'<dl class="mb-20 cl csWrap text-c" >'+
					'<dt class="csWrap_dt">备件预警</dt>'+
					'<dd class="csWrap_dd">'+
						'<div class="f-l w-120">'+
							'<span class="orderCount">'+storeCount+'</span>'+
							'<p class="lh-26"><a href="javascript:;" class="c-f55025 f-14">库存</a><span class="f-14">预警</span></p>'+
						'</div>'+
						'<div class="f-l w-120">'+
							'<span class="orderCount">'+shortCount+'</span>'+
							'<p class="lh-26"><a href="javascript:;" class="c-f55025 f-14">缺件</a><span class="f-14">预警</span></p>'+
						'</div>'+
					'</dd>'+
				'</dl>');
			} 
			$.setGridSize();
		});
		
		function search() { //条件查询
			
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
			$("#table-waitdispatch").sfGridSearch({
				postData : $("#searchForm").serializeJson()
			});
		}

		function initSfGrid() { //加载grid表格
			$("#table-waitdispatch").sfGrid({
				url : '${ctx}/operate/siteAlarm/alarmDetailList',
				sfHeader : defaultHeader,
				sfSortColumns : sortHeader,
				postData : {
					type : markType
				},
				shrinkToFit : true,
				rownumbers : true,
				gridComplete:function(){
					_order_comm.gridNum();
				}
			});
		}

		function fmtOper(rowData) { //列表操作
			var html1='';
			var html2 ='';
			var html3='';
			
			if('${fns:checkBtnPermission("OPERATEMGM_EMPLOYEMSGMGM_EMPLOYEMGM_EDIT_BTN")}' === 'true'){
				html1 = "<span ><a onclick='cancelAlarm(\""+ rowData.id+ "\")' class='c-0383dc'><i class='sficon sficon-cautionCancel_empty'></i>取消预警</a></span>&nbsp;&nbsp;";
				html4 = "<span ><a  class='c-0383dc'>已取消</a></span>&nbsp;";
			}
			if('${fns:checkBtnPermission("OPERATEMGM_EMPLOYEMSGMGM_EMPLOYEMGM_EDIT_BTN")}' === 'true'){
				html2 = "<span ><a onclick='isTop(\""+ rowData.id+ "\",\""+ rowData.is_top+ "\")' class='c-0383dc'><i class='sficon sficon-top2'></i>置顶</a></span>&nbsp;";
				html3 = "<span ><a onclick='isTop(\""+ rowData.id+ "\",\""+ rowData.is_top+ "\")' class='c-0383dc'><i class='sficon sficon-cancelTop2'></i>取消置顶</a></span>&nbsp;";
			}
		
			if (rowData.is_cancel == '0') {
				if (rowData.is_top == '0') {
						return html1+html2;
				} else if (rowData.is_top == '1') {
					return html1+html3;
				} else {
					return "<span style='color:red'>异常！</span>";
				}
			} else {
				if (rowData.is_top == '0') {
					return html4+html2;
					
				} else if (rowData.is_top == '1') {
					return html4+html3
					
				} else {
					return "<span style='color:red'>异常！</span>";
				}
			}
		
		}

		function alarmStatus(rowData) { //预警状态
			if (rowData.status == '0') {
				return "<span>未读</span>";
			} else if (rowData.status == '1') {
				return "<span>已读</span>";
			} else {
				return "<span style='color:red'>异常！</span>";
			}
		}

		function alarmType(rowData) { //预警类型
			if (rowData.is_top == '1') {
				
					if (rowData.type == '1') {
						return "<span style='color:red'><i class='sficon sficon-flagC'></i></span>&nbsp;<span>工程师接单预警</span>";
					} else if (rowData.type == '2') {
						return "<span style='color:red'><i class='sficon sficon-flagC'></i></span>&nbsp;<span>服务完成工单预警</span>";
					}
					if (rowData.type == '3') {
						return "<span style='color:red'><i class='sficon sficon-flagC'></i></span>&nbsp;<span>库存预警</span>";
					} else if (rowData.type == '4') {
						return "<span style='color:red'><i class='sficon sficon-flagC'></i></span>&nbsp;<span>缺件预警</span>";
					} else {
						return "<span style='color:red'><i class='sficon sficon-flagC'></i></span>&nbsp;<span style='color:red'>异常！</span>";
					}
				
	
			} else if (rowData.is_top == '0') {
			
					if (rowData.type == '1') {
						return "<span>工程师接单预警</span>";
					} else if (rowData.type == '2') {
						return "<span>服务完成工单预警</span>";
					}
					if (rowData.type == '3') {
						return "<span>库存预警</span>";
					} else if (rowData.type == '4') {
						return "<span>缺件预警</span>";
					} else {
						return "<span style='color:red'>异常！</span>";
					}
				
	
			}
		}

		function cancelAlarm(rowId) {//取消预警
			$('body').popup({
				level : '3',
				type : 2,
				content : "确定要取消预警吗?",
				fnConfirm : function() {
					$.ajax({
						type : "post",
						url : "${ctx}/operate/siteAlarm/cancelAlarm",
						data : {
							rowId : rowId
						},
						success : function(result) {
							if (result == "ok") {
								layer.msg("取消预警成功！");
								//window.location.reload(true);
								search();
							} else {
								$('body').popup({
									level : '3',
									type : 1,
									content : "取消预警失败，请联系管理员！"
								})
							}
						}
					})
				}
			})
		}

		function isTop(rowId, isTop) {//是否置顶
			var mark = "确定要置顶吗？";
			if (isTop == "1") {
				mark = "确定要取消置顶吗？";
			}
			$('body').popup({
				level : '3',
				type : 2,
				content : mark,
				fnConfirm : function() {
					$.ajax({
						type : "post",
						url : "${ctx}/operate/siteAlarm/isTop",
						data : {
							rowId : rowId,
							isTop : isTop
						},
						success : function(result) {
							if (result == "ok") {
								if (isTop == '0') {
									layer.msg("置顶成功！");
								} else {
									layer.msg("取消置顶成功！");
								}
								//window.location.reload(true);
								search();
							} else {
								if (isTop == '0') {
									$('body').popup({
										level : '3',
										type : 1,
										content : "置顶失败，请联系管理员！"
									})
								} else {
									$('body').popup({
										level : '3',
										type : 1,
										content : "取消置顶失败，请联系管理员！"
									})
								}
							}
						}
					})
				}
			})
		}
		function isFlag(rowId, isflag) {//是否标记
			var mark = "确定要标记吗？";
			if (isflag == "1") {
				mark = "确定要取消标记吗？";
			}
			$('body').popup({
				level : '3',
				type : 2,
				content : mark,
				fnConfirm : function() {
					$.ajax({
						type : "post",
						url : "${ctx}/operate/siteAlarm/isFlag",
						data : {
							rowId : rowId,
							isflag : isflag
						},
						success : function(result) {
							if (result == "ok") {
								if (isflag == '0') {
									layer.msg("标记成功！");
								} else {
									layer.msg("取消标记成功！");
								}
								window.location.reload(true);
							} else {
								if (isflag == '0') {
									$('body').popup({
										level : '3',
										type : 1,
										content : "标记失败，请联系管理员！"
									})
								} else {
									$('body').popup({
										level : '3',
										type : 1,
										content : "取消标记失败，请联系管理员！"
									})
								}
							}
						}
					})
				}
			})
		}

		$("#reset").on("click", function() {
			$("#type").val('');
			//document.getElementById('type').value ='';
		})
		
		function quxiaoyj(){//批量取消预警
			
				var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
				if(idArr.length<1){layer.msg("请选择数据！");}else{
					$('body').popup({
						level : '3',
						type : 2,
						content : "确定要取消"+idArr.length+"条数据预警吗？",
						fnConfirm : function() {
							$.ajax({
								type:"POST",
								url:"${ctx}/operate/siteAlarm/plcancelAlarm",
								traditional: true,
										data:{
										"idArr":idArr
										},
										async:false,
									 success:function(data){
											if(data){
											layer.msg("取消完成!",{time:2000});
												 //window.location.reload(true);
												 search();
											}else{			
											layer.msg("操作失败!",{time:2000});
											}
										},
										error:function(){
											layer.alert("系统繁忙!");
											return;
										}
							});
							layer.closeAll('dialog');
						}				
					});			
						
		}
		}
		function Bj(){//批量标记
			var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
			if(idArr.length<1){layer.msg("请选择数据！");}else{
				$('body').popup({
					level : '3',
					type : 2,
					content : "确定要标记"+idArr.length+"条数据吗？",
					fnConfirm : function() {
						$.ajax({
							type:"POST",
							url:"${ctx}/operate/siteAlarm/pltop",
							traditional: true,
									data:{
									"idArr":idArr
									},
									async:false,
								 success:function(data){
										if(data){
										layer.msg("置顶完成!",{time:2000});
											 //window.location.reload(true);
										search();
										}else{			
										layer.msg("操作失败!",{time:2000});
										}
									},
									error:function(){
										layer.alert("系统繁忙!");
										return;
									}
						});
						layer.closeAll('dialog');
					}				
				});			
					
	}
			
		}
		function quxiaoBj(){//批量取消标记
			var idArr=$('#table-waitdispatch').jqGrid('getGridParam','selarrrow');
			if(idArr.length<1){layer.msg("请选择数据！");}else{
				$('body').popup({
					level : '3',
					type : 2,
					content : "确定要取消"+idArr.length+"条数据置顶吗？",
					fnConfirm : function() {
						$.ajax({
							type:"POST",
							url:"${ctx}/operate/siteAlarm/plcanceltop",
							traditional: true,
									data:{
									"idArr":idArr
									},
									async:false,
								 success:function(data){
										if(data){
										layer.msg("取消置顶完成!",{time:2000});
											// window.location.reload(true);
										search();
										}else{			
										layer.msg("操作失败!",{time:2000});
										}
									},
									error:function(){
										layer.alert("系统繁忙!");
										return;
									}
						});
						layer.closeAll('dialog');
					}				
				});			
					
	}
			
		}
	</script>

</body>
</html>
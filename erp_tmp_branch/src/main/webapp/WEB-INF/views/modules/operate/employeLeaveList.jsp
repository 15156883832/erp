<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base" />
<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
	<div class="sfpagebg bk-gray">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYEPOSITION_TAB" html='<a class="btn-tabBar " href="${ctx }/operate/employeOrientation/firstPage">工程师定位</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYERECORD_TAB" html='<a class="btn-tabBar" href="${ctx }/operate/employeDailySign/headerList">考勤记录</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYELEAVE_TAB"
							html='<a class="btn-tabBar current" href="${ctx }/operate/employeDailySign/employeLeaveList">请假记录</a>'></sfTags:pagePermission>
						<p class="f-r btnWrap">
							<a href="javascript:search();" class="sfbtn sfbtn-opt">
								<i class="sficon sficon-search"></i>
								查询
							</a>
							<a href="javascript:reset();" class="sfbtn sfbtn-opt resetSearchBtn">
								<i class="sficon sficon-reset"></i>
								重置
							</a>
						</p>
					</div>
					<div class="tabCon">
						<form id="searchForm">
							<input type="hidden" name="page" id="pageNo" value="1">
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">姓名：</th>
										<td>
											<input type="text" class="input-text" name="employeName" value="${map.employeName }" id="employeName"/>
										</td>
										<th style="width: 76px;" class="text-r">请假日期：</th>
										<td colspan="2">
											<input type="text" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'leaveTimeMax\')}'})"
												id="leaveTimeMin" name="leaveTimeMin" value="${map.leaveTimeMin }" class="input-text Wdate w-140" style="width: 140px">
											至
											<input type="text"
												onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'leaveTimeMin\')}'})"
												id="leaveTimeMax" name="leaveTimeMax" value="${map.leaveTimeMax }" class="input-text Wdate w-140" style="width: 140px">
										</td>
									</tr>
								</table>
							</div>
						</form>

						<div class="pt-10 pb-5 cl">
							<div class="f-r">
								<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYELEAVERECORD_EXPORT_BTN"
									html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
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

	<!-- 修改打卡时间-->
	<div class="popupBox spqrsf">
		<h2 class="popupHead">
			修改打卡时间
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain">
				<div class="pcontent" id="confirmGatheringbox">
					<div class="mb-10 cl">
						<label class="w-130 f-l">打卡时间：</label>
						<input type="text" class="input-text Wdate w-150" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm'})" value="" id="signTime" name="signTime" />
						<input type="text" class="input-text" hidden="hidden" value="" id="signType" name="signTime" />
						<input type="text" class="input-text" hidden="hidden" value="" id="date" name="date" />
					</div>
				</div>
				<div class="text-c mt-35">
					<a href="javascript:;" onclick="confirmEdit()" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
					<a href="javascript:;" id="btn-confirm-cancel" class="sfbtn sfbtn-opt w-70 mr-5">取消</a>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
	<script type="text/javascript">
		var id = '${headerData.id}'; //服务商表格的ID
		var defaultHeader = eval('${headerData.tableHeader}');//默认表格头部，系统已经维护好的
		var sortHeader = '${headerData.sortHeader}'; //服务商自定义过的表格头部
		var defaultId = '${headerData.defaultId}'; //系统表格的ID

		$(function() {
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			initSfGrid();
		});

		function search() {
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
				url : '${ctx}/operate/employeDailySign/employeLeaveGrid',
				sfHeader : defaultHeader,
				sfSortColumns : sortHeader,
				postData : $("#searchForm").serializeJson(),
				shrinkToFit : true,
				multiselect: false,
				rownumbers : true,
				gridComplete : function() {
					_order_comm.gridNum();
				}
			});
		}

		function isBlank(val) {
			if (val == null || $.trim(val) == '' || val == undefined) {
				return true;
			}
			return false;
		}

		function reset() {
			$("#employeName").val('');
			$("#leaveTimeMin").val('');
			$("#leaveTimeMax").val('');
		}

		function exports() {
			var idArr = $("#table-waitdispatch").jqGrid('getGridParam', 'records')
			var content = "共" + idArr + "条数据，本次允许导出前10000条，确定继续导出吗？";
			if (idArr > 10000) {
				$('body').popup({
					level : 3,
					title : "导出",
					content : content,
					fnConfirm : function() {
						location.href = "${ctx}/operate/employeDailySign/exportLeave?formPath=/a/operate/employeDailySign/employeLeaveList&&" + $("#searchForm").serialize();
					}

				});
			} else {
				location.href = "${ctx}/operate/employeDailySign/exportLeave?formPath=/a/operate/employeDailySign/employeLeaveList&&" + $("#searchForm").serialize();
			}

		}
		
		function leaveTimes(rowData){
			var duration = rowData.duration;
			if(!isBlank(duration)){
				var lastNum = duration.substring(duration.length-1,duration.length);
				if(lastNum=='0'){
					duration = duration.substring(0,duration.length-2);
				}
			} 
			return duration;
		}
	</script>

</body>
</html>
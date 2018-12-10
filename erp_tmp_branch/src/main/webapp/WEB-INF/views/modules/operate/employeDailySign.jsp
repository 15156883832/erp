<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base" />
<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<style>
@media screen and (max-width:1440px){
   .tableWrap{
height:400px;
}
}
@media screen and (min-width: 1600px)
.tableWrap {
    height: 560px;
}

.tableWrap {
    max-height: 560px;
    overflow: auto;
}

</style>
</head>
<body>
	<div class="sfpagebg bk-gray" style="overflow:hidden;">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl mb-10">
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYEPOSITION_TAB" html='<a class="btn-tabBar " href="${ctx }/operate/employeOrientation/firstPage">工程师定位</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYERECORD_TAB" html='<a class="btn-tabBar current" href="${ctx }/operate/employeDailySign/headerList">考勤记录</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYELEAVE_TAB" html='<a class="btn-tabBar" href="${ctx }/operate/employeDailySign/employeLeaveList">请假记录</a>'></sfTags:pagePermission>
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
						<form id="searchForm" action="${ctx}/operate/employeDailySign/headerList">
							<input type="hidden" name="page" id="pageNo" value="${page.pageNo}">
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">姓名：</th>
										<td>
											<input type="text" class="input-text" name="employeName" value="${map.employeName }" id="sEmployeName" />
										</td>
										<th style="width: 76px;" class="text-r">打卡类别：</th>
										<td>
											<span class="select-box">
												<select class="select" name="signType" id="sSignType">
													<option value="">请选择</option>
													<option value="1" <c:if test="${map.signType=='1' }">selected</c:if>>签到</option>
													<option value="2" <c:if test="${map.signType=='2' }">selected</c:if>>签退</option>
												</select>
											</span>
										</td>
										<th style="width: 76px;" class="text-r">打卡状态：</th>
										<td>
											<span class="select-box">
												<select class="select" name="signResult" id="sSignResult">
													<option value="">请选择</option>
													<option value="0" <c:if test="${map.signResult=='0' }">selected</c:if>>正常</option>
													<option value="1" <c:if test="${map.signResult=='1' }">selected</c:if>>迟到</option>
													<option value="2" <c:if test="${map.signResult=='2' }">selected</c:if>>早退</option>
													<option value="4" <c:if test="${map.signResult=='4' }">selected</c:if>>未打卡</option>
												</select>
											</span>
										</td>
										<th style="width: 76px;" class="text-r">考勤班次：</th>
										<td>
											<span class="select-box">
												<select class="select" name="signNums" id="signNums">
													<option value="">请选择</option>
													<c:if test="${listLgh > 0 }">
														<c:if test="${listLgh == 1 }">
															<option value="11" <c:if test="${map.signNums=='11' }">selected</c:if>>上班1</option>
															<option value="12" <c:if test="${map.signNums=='12' }">selected</c:if>>下班1</option>
														</c:if>
														<c:if test="${listLgh == 2 }">
															<option value="11" <c:if test="${map.signNums=='11' }">selected</c:if>>上班1</option>
															<option value="12" <c:if test="${map.signNums=='12' }">selected</c:if>>下班1</option>
															<option value="21" <c:if test="${map.signNums=='21' }">selected</c:if>>上班2</option>
															<option value="22" <c:if test="${map.signNums=='22' }">selected</c:if>>下班2</option>
														</c:if>
														<c:if test="${listLgh == 3 }">
															<option value="11" <c:if test="${map.signNums=='11' }">selected</c:if>>上班1</option>
															<option value="12" <c:if test="${map.signNums=='12' }">selected</c:if>>下班1</option>
															<option value="21" <c:if test="${map.signNums=='21' }">selected</c:if>>上班2</option>
															<option value="22" <c:if test="${map.signNums=='22' }">selected</c:if>>下班2</option>
															<option value="31" <c:if test="${map.signNums=='31' }">selected</c:if>>上班3</option>
															<option value="32" <c:if test="${map.signNums=='32' }">selected</c:if>>下班3</option>
														</c:if>
													</c:if>
												</select>
											</span>
										</td>
									</tr>
									<tr>
										<th style="width: 76px;" class="text-r">是否请假：</th>
										<td>
											<span class="select-box">
												<select class="select" name="ifLeave" id="ifLeave">
													<option value="">请选择</option>
													<option value="2" <c:if test="${map.ifLeave=='2' }">selected</c:if>>是</option>
													<option value="1" <c:if test="${map.ifLeave=='1' }">selected</c:if>>否</option>
												</select>
											</span>
										</td> 
										<th style="width: 76px;" class="text-r">打卡日期：</th>
										<td colspan="3">
											<input type="text" class="input-text Wdate w-100"
												onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate1\')||\'%y-%M-%d\'}'})" value="${map.startDate1}" id="startDate1"
												name="startDate1" />
											&nbsp;至&nbsp;
											<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate1\')}',maxDate:'%y-%M-%d'})"
												value="${map.endDate1}" class="input-text Wdate w-100" id="endDate1" name="endDate1" />
										</td>
									</tr>
								</table>
							</div>
						</form>

						<div class="pt-10 pb-5 cl">
						<div class="f-r">
								<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYERECORD_EXPORT_BTN"
									html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
							</div>
							<div class="f-l" id="announcement" style='color:red;width:90%;'>
							今日打卡通知：<span id="empNames" style='display:inline;display:inline-block;color:red;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;min-width:0%;max-width: 40%;cursor:pointer;'></span>&nbsp;&nbsp;&nbsp;<span id="empNamesCount" style="cursor:pointer;"></span>
							</div>
						</div>
						<div class="tableWrap mt-10 text-c maintable" >
							<table class="table table-bg table-border table-bordered table-sdrk" style="table-layout: fixed;">
								<thead style="width:99%">
									<tr class="text-c">
										<th width="5%">序号</th>
										<th width="8%">服务工程师</th>
										<th width="10%">打卡日期</th>
										<th width="8%">考勤班次</th>
										<th width="10%">打卡时间</th>
										<th width="10%">打卡类别</th>
										<th width="5%">打卡状态</th>
										<th width="10%">迟到时间（分）</th>
										<th width="26%">打卡地点</th>
										<th width="6%">是否请假</th>
									</tr>
								</thead>  
								<!-- <div style="width:100%"> -->
								 <tbody style="width:100%" class='wewe'>
									<c:forEach items="${page.list }" var="item" varStatus="sta">
										<tr class='tr'>
											<td class="text-c" width="5%">${sta.index + 1 }</td>
											<td class="text-c" width="8%">${item.columns.empName }</td>
											<td width="10%">${item.columns.date }</td>
	
											<td class="no-pd" width="8%">
												<c:forEach items="${item.columns.detailList }" var="item1" varStatus="sta1">
													<div class="<c:if test="${!sta1.last }">bb</c:if> h-30 pd-5" title="">
														<c:choose>
															<c:when test="${item1.columns.sign_type=='1'}">  
														                       上班${item1.columns.sign_serial}
														    </c:when>
															<c:otherwise> 
														   		下班${item1.columns.sign_serial}
														    </c:otherwise>
														</c:choose>
													</div>
												</c:forEach>
											</td>
											<td class="no-pd" width="10%">
												<c:forEach items="${item.columns.detailList }" var="item1" varStatus="sta1">
													<div class=" <c:if test="${!sta1.last }">bb</c:if> h-30 pd-5" title="${item1.columns.signTime }">
														<span>
															<c:if test="${ empty item1.columns.signTime }">
																— —
															</c:if>
															<c:if test="${not empty item1.columns.signTime }">
																${item1.columns.signTime }
															</c:if>
															<a onclick="editSignTime('${item1.columns.id}','${item.columns.empId}','${item1.columns.sign_type}','${item1.columns.sign_serial}','${item.columns.date }','${item.columns.empName }')" class="c-0383dc">
																&nbsp;&nbsp;<i class="sficon sficon-edit"> </i>修改
															</a>
														</span>
													</div>
												</c:forEach>
											</td>
											<td class="no-pd" width="10%">
												<c:forEach items="${item.columns.detailList }" var="item1" varStatus="sta1">
													<div class="<c:if test="${!sta1.last }">bb</c:if> h-30 pd-5" title="">
														<c:choose>
															<c:when test="${ not empty item1.columns.id}"> 
																<c:if test="${item1.columns.sign_type=='1'}">
																	 签到
																</c:if>
																<c:if test="${item1.columns.sign_type=='2'}">
																	 签退
																</c:if>
															</c:when>
															<c:otherwise> 
														   		 — —
														    </c:otherwise> 
														</c:choose>
													</div>
												</c:forEach>
											</td>
											<td class="no-pd" width="5%">
												<c:forEach items="${item.columns.detailList }" var="item1" varStatus="sta1">
													<div class="<c:if test="${!sta1.last }">bb</c:if> h-30 pd-5" title="">
														<c:choose>
															<c:when test="${empty item1.columns.id}">
																<span style="color:#9d9d9d;">未打卡</span>
															</c:when>
															<c:otherwise> 
														   		 <c:choose>
																	<c:when test="${ empty item1.columns.out_time || item1.columns.out_time=='0'}">
																		正常
																	</c:when>
																	<c:otherwise> 
																   		 <c:if test="${item1.columns.sign_type=='1'}">
																			<span style="color:#ff0000;">迟到</span>
																		 </c:if>
																		 <c:if test="${item1.columns.sign_type=='2'}">
																			 <span style="color:#eac300;">早退</span>
																		 </c:if>
																    </c:otherwise>
																</c:choose>
														    </c:otherwise>
														</c:choose>
													</div>
												</c:forEach>
											</td>
											<td class="no-pd" width="10%">
												<c:forEach items="${item.columns.detailList }" var="item1" varStatus="sta1">
													<div class="<c:if test="${!sta1.last }">bb</c:if> h-30 pd-5" title="${item1.columns.out_time }">
														<c:choose>
															<c:when test="${ empty item1.columns.out_time || item1.columns.out_time==0}">
																— —
															</c:when>
															<c:otherwise> 
														   		<c:if test="${item1.columns.sign_type=='1'}">
																	<span style="color:#ff0000;">${item1.columns.out_time }</span>
																 </c:if>
																 <c:if test="${item1.columns.sign_type=='2'}">
																	 <span style="color:#eac300;">${item1.columns.out_time }</span>
																 </c:if>
														    </c:otherwise>
														</c:choose>
													</div>
												</c:forEach>
											</td>
											<td class="no-pd" width="26%">
												<c:forEach items="${item.columns.detailList }" var="item1" varStatus="sta1">
													<div  class="<c:if test="${!sta1.last }">bb</c:if> h-30 pd-5" style='text-overflow:ellipsis;overflow:hidden;white-space:nowrap;width:100%;' title="${item1.columns.sign_address }">
														<c:choose>
															<c:when test="${ empty item1.columns.id}">
																— —
															</c:when>
															<c:otherwise> 
														   		${item1.columns.sign_address }
														    </c:otherwise>
														</c:choose>
													</div>
												</c:forEach>
											</td>
											<td class="no-pd" width="6%">
												<c:choose>
													<c:when test="${item.columns.ifleave=='1' }">
														<span title="无请假记录">— —</span>
													</c:when>
													<c:otherwise> 
												   		<a style="color:blue;" data1="${item.columns.empId }" data3="${item.columns.empName }" data2="${item.columns.date }" onmouseover="this.style.textDecoration='underline'" onmouseout="this.style.textDecoration='none'" class="jumpToLeaveList" title="点击查看请假详细信息"  >点击查看</a>
												    </c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<!-- </div> -->
							</table>
						</div>
						<div class="cl mt-10">
							<div class="pagination">${page}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改打卡时间-->
	<div class="popupBox spqrsf">
		<h2 class="popupHead">
			<span id="headerTitle">修改打卡时间</span>
			<a href="javascript:calcelEdit();" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain">
				<div class="pcontent" id="confirmGatheringbox">
					<div class="mb-10 cl">
						<label class="w-130 f-l">打卡时间：</label>
						<input type="text" class="input-text Wdate w-150" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm'})" value="" id="signTime" name="signTime" />
						<input type="text" class="input-text" hidden="hidden" value="" id="editSignType" name="editSignType" />
						<input type="text" class="input-text" hidden="hidden" value="" id="editSignDate" name="editSignDate" />
						<input type="text" class="input-text" hidden="hidden" value="" id="editRecordId" name="editRecordId" />
						<input type="text" class="input-text" hidden="hidden" value="" id="editEmpId" name="editEmpId" />
						<input type="text" class="input-text" hidden="hidden" value="" id="editSignSerial" name="editSignSerial" />
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
		var rId;
		var signType;
		var ifFk;
		var bolean = '${ifExist}';
		
		$(function() {
			$('.maintable table tbody').css('height',$(window).height()-350+'px'); 
			$.post("${ctx}/operate/employeDailySign/getAnnouncement", function(result) {
				$("#empNames").text(result.names);
				$("#empNames").attr("title",result.names);
				$("#empNamesCount").text(result.count+"人尚未打卡");
				$("#empNamesCount").attr("title",result.count+"人尚未打卡");
			}); 
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
			$(".jumpToLeaveList").bind('click',function(){
				var empId=$(this).attr("data1");
				var empName=$(this).attr("data3");
				var date=$(this).attr("data2");
				window.location.href="${ctx}/operate/employeDailySign/employeLeaveList?leaveTimeMin="+(date+" 00:00:00")+"&leaveTimeMax="+(date+" 23:59:59")+"&employeName="+empName;
			});
		});
		
		window.onresize = function(){
			$('.maintable table tbody').css('height',$(window).height()-350+'px');
		}
		
		function search() {
			if (isBlank($("#startDate1").val()) || isBlank($("#endDate1").val())) {
				layer.msg("请选择打卡日期！");
				return;
			}
			var dt1 = new Date($("#startDate1").val());
			var dt = new Date();
			if (dt.getTime() - 1000 * 90 * 24 * 60 * 60 > dt1.getTime()) {
				layer.msg("只允许查询近三个月的工程师考勤记录！");
				return;
			}
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
			var params = "&employeName=" + $("#sEmployeName").val() + "&signType=" + $("#sSignType").val() + "&signResult=" + $("#sSignResult").val() + "&startDate1="
					+ $("#startDate1").val() + "&endDate1=" + $("#endDate1").val()+"&signNums="+$("#signNums").val()+"&ifLeave="+$("#ifLeave").val();
			window.location.href = "${ctx}/operate/employeDailySign/headerList?pageNo=" + $("#pageNo").val() + "&pageSize=" + $("#pageSize").val() + params;
		}

		function editSignTime(id,empId,signType,signSerial,signDate,empName) { //列表中点击收款操作
			$("#editSignType").val(signType);
			$("#editSignSerial").val(signSerial);
			$("#editSignDate").val(signDate);
			$("#editRecordId").val(id);
			$("#editEmpId").val(empId);
			/* $("#headerTitle").text('修改'+empName+(signType==1 ? '上班' : '下班')+signSerial+'打卡时间'); */
			if(isBlank(id)){
				$('.spqrsf').popup();
				return;
			}
			$.ajax({
				type:"post",
				data:{id:id},
				url:"${ctx}/operate/employeDailySign/getSignDetailById",
				success:function(data){
					
					if(data!=null){
						$("#signTime").val(data.columns.signTime);
						$('.spqrsf').popup();
					}else{
						$("#editRecordId").val('');
						$('.spqrsf').popup();
					}
					return;
				}
			}) 
		}

		var editMark = false;
		function confirmEdit() {
			if(editMark){
				return ;
			}
			var signTime = $("#signTime").val();
			var editSignDate = $("#editSignDate").val();
			if(isBlank(signTime)){
				layer.msg("请填写打卡时间！");
				return;
			}
			//signTime = editSignDate + " " + $("#signTime").val() + ":00";
			editMark = true;
			$.ajax({
				type : "POST",
				url : "${ctx}/operate/employeDailySign/editSignTimes",
				data : {
					recordId : $("#editRecordId").val(),
					signTime : signTime,
					editSignType : $("#editSignType").val(),
					editSignDate:editSignDate,
					editSignSerial:$("#editSignSerial").val(),
					editEmpId:$("#editEmpId").val()
				},
				dataType : 'json',
				success : function(result) {
					editMark = false;
					if (result == '200') {
						layer.msg("修改成功！");
						search();
						$.closeDiv($('.spqrsf'));
					} else if(result=='421'){
						layer.msg("修改失败，考勤规则信息有误！");
					}else {
						layer.msg("修改失败，请联系管理员！");
					}
					return ;
				},
				error:function(){
					editMark = false;
					layer.msg("error!");
					return ;
				}
			})
		}

		$('#btn-confirm-cancel').on('click', function() { //点击取消 关闭修改打卡时间弹出框
			$("#signTime").val('');
			$.closeDiv($('.spqrsf'));
		});
		
		function calcelEdit(){
			$("#signTime").val('');
			$.closeDiv($('.spqrsf'));
		}

		function reset() {
			$("#sEmployeName").val('');
			$("#sSignType").val('');
			$("#sSignResult").val('');
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
						location.href = "${ctx}/operate/employeDailySign/export?formPath=/a/operate/employeDailySign/headerList&&maps=" + $("#searchForm").serialize();
					}

				});
			} else {
				location.href = "${ctx}/operate/employeDailySign/export?formPath=/a/operate/employeDailySign/headerList&&maps=" + $("#searchForm").serialize();
			}

		}

		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			console.log($("#pageSize").val())
			$("#searchForm").submit();
			// window.location.href="${ctx}/operate/employeDailySign/headerList?"+$("#searchForm").serialize();
			return;
		}
		
		function isBlank(val){
			if(val==null || $.trim(val)=='' || val==undefined){
				return true;
			}
			return false;
		}
	</script>

</body>
</html>
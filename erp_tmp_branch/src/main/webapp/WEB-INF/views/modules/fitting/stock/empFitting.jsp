<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base" />
<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
<style>


.table-bg thead th{
      position: relative;
}

.left_tip{
	    position: absolute;
    top: 21px;
    left: 205px;
    display: block;
    width: 0;
    height: 0;
    border-top: 7px solid #888;
    border-left: 7px solid transparent;
    border-right: 7px solid transparent;
     border-bottom: 7px solid transparent;

		}
		.tip__{
			display: none;
			    position: absolute;
			    color: #999;
			    border: 1px solid #aaa;
			    margin-left: 28px;
			    font-size: 12px;
			    padding: 0 3px;
			    top: -30px;
			    z-index: 10000;
			    left: -232px;
     width: auto;
    word-break: keep-all;
		}
		.left_tip_{
			margin-top: -2px;
			margin-right: -15px;
			margin-left: 3px;
			margin-right: 3px;
			cursor: pointer
		}
		.left_tip_:hover span{
			display: block;
			background-color:white;
		}
		.Hui-iconfont {
			 -webkit-text-stroke-width: 0px;
			 position: relative;
		}
		.fs-14{
		font-size:14px;}

</style>
</head>
<body>
	<div class="sfpagebg bk-gray" style="overflow:hidden;">
		<div class="sfpage table-header-settable">
			<div class="page-orderWait">
				<div id="tab-system" class="HuiTab">
					<div class="tabBar cl">
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_COMPANYSTOCK_TAB" html='<a class="btn-tabBar "  href="${ctx }/fitting/stock/index">公司库存</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_TAB" html='<a class="btn-tabBar current"  href="${ctx }/fitting/stock/empFitting">工程师库存</a>'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_WAITERETURN_TAB" html='<a class="btn-tabBar"  href="${ctx }/fitting/stock/waitReturn">工程师返还<sup  id="tab_c1">0</sup></a>'></sfTags:pagePermission>
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
						<form id="searchForm" action="${ctx}/fitting/stock/empFitting">
							<input type="hidden" name="page" id="pageNo" value="${page.pageNo}">
							<input type="hidden" name="rows" id="pageSize" value="${page.pageSize}">
							<div style="height:35px;line-height:30px;padding-bottom:5px;">
								<a class="c-0e8ee7 fs-14" onclick="toempFitting()" >工程师库存</a>
								<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_STOCKDETAIL_BTN" html='<span style="display:inline-block;border-left: 2px solid #aaa;height: 20px;margin: 0 10px;"></span><a onclick="toempDetaol()" class="fs-14">工程师库存明细</a>'></sfTags:pagePermission>
							</div>
							<div class="bk-gray pt-10 pb-5">
								<table class="table table-search">
									<tr>
										<th style="width: 76px;" class="text-r">服务工程师：</th>
										<td>
											<span class="f-l w-140  readonly" >
												<select class="select w-140" name="empIds" id="empIds">
												<option value="">请选择</option>
													<c:forEach items="${empList}" var="lsd" varStatus="status">
														<option value="${lsd.columns.id}" <c:if test="${map.empIds==lsd.columns.id}">selected="selected"</c:if>>${lsd.columns.name}<c:if test="${lsd.columns.status=='3'}">（离职）</c:if></option>
													</c:forEach> 
												</select>
											</span>
										</td>
									</tr>
								</table>
							</div>
						</form>

						<div class="pt-5 cl">
							<div class="f-r">
								<sfTags:pagePermission authFlag="FITTINGMGM_FITSTOCK_ENIGNEERSTOCK_EXPORT_BTN"
									html='<a  onclick="return exports()" class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
							</div>
						</div>
						<div class="tableWrap mt-10 text-c maintable" >
							<table class="table table-bg table-border table-bordered table-sdrk" style="table-layout: fixed;">
								<thead style="width:99%">
									<tr class="text-c">
										<th width="10%" rowspan="2">操作</th>
										<th width="10%" rowspan="2">服务工程师</th>
										<th width="35%" colspan="4">备件库存</th>
										<th width="35%" colspan="3">待核销备件</th>
										<th width="10%" rowspan="2">待返还数</th>
									</tr>
									<tr class="text-c">
										<th width="5%">种类</th>
										<th width="10%">库存量</th>
										<th width="10%">入库总额 <i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">
											&#xe6cd;
											<span class="tip__" style="width:300px;"><em class="left_tip"></em>各备件单种库存量与其入库价格乘积的总和</span>
										</i></th>
										<th width="10%">工程师总额 <i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">
											&#xe6cd;
											<span class="tip__" style="width:350px;"><em class="left_tip"></em>各备件单种库存量与其工程师价格乘积的总和</span>
										</i></th>
										<th width="10%">待核销数 </th>
										<th width="10%">待核销总额 <i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">
											&#xe6cd;
											<span class="tip__"><em class="left_tip"></em>各备件待核销数与其入库价格乘积的总和</span>
										</i></th>
										<th width="15%">待核销工程师总额 <i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">
											&#xe6cd;
											<span class="tip__"><em class="left_tip"></em>各备件待核销数与其工程师价格乘积的总和</span>
										</i></th>
									</tr> 
								</thead>  
								 <tbody style="width:100%" class='wewe'>
									<c:forEach items="${page.list }" var="item" varStatus="sta">
										<tr class='tr'>
											<td class="text-c" width="10%"><a href="javascript:showEmpItem('${item.columns.employe_id}','${item.columns.estatus }');" class="c-0e8ee7">查看明细</a></td>
											<td class="text-c" width="10%">${item.columns.name}</td>
											<td width="5%" class="my1">${item.columns.ct}</td>
	
											<td class="no-pd my2" width="10%">
												${item.columns.su}
											</td>
											<td class="no-pd my3" width="10%">
												${item.columns.sallSitePrice }
											</td>
											<td class="no-pd my4" width="10%">
												${item.columns.semployeSitePrice }
											</td>
											<td class="no-pd my5" width="10%">
												${item.columns.employe_number}
											</td>
											<td class="no-pd my6" width="10%">
												${item.columns.hallSitePrice}
											</td>
											<td class="no-pd my7" width="15%">
												${item.columns.hemployeSitePrice}
											</td>
											<td class="no-pd" width="10%">
												<a href="javascript:toReturn('${item.columns.employe_id}','${item.columns.estatus }');" class="c-0e8ee7 my8">${item.columns.usedNum}</a>
											</td>
										</tr>
									</c:forEach> 
								</tbody>
								<tfoot>
									<tr class='tr'>
										<td class="text-c" colspan="2" width="20%">合计</td>
										<td class="no-pd" width="10%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk1"></a>
										</td>
										<td class="no-pd" width="5%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk2"></a>
										</td>
										<td class="no-pd" width="10%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk3"></a>
										</td>
										<td class="no-pd" width="10%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk4"></a>
										</td>
										<td class="no-pd" width="10%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk5"></a>
										</td>
										<td class="no-pd" width="10%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk6"></a>
										</td>
										<td class="no-pd" width="15%">
											<a href="javascript:showEmpItem();" class="c-0e8ee7 mk7"></a>
										</td>
										<td width="10%">
											<a href="javascript:toReturn();" class="c-0e8ee7 mk8"></a>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<%-- <div class="cl mt-10">
							<div class="pagination">${page}</div>
						</div> --%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var rId;
		var signType;
		var ifFk;
		var bolean = '${ifExist}';
		
		$(function() {
			dealCountMoney();
			$("select[name='empIds']").select2();
			$(".selection").css("width","140px");
			$.post("${ctx}/fitting/stock/getWaitReturnCount1",function(result){
				$("#tab_c1").text(result[0].count);
			});
			$('.maintable table tbody').css('height',$(window).height()-350+'px'); 
			$.Huitab("#tab-system .tabBar span", "#tab-system .tabCon", "current", "click", "0");
			$.tabfold("#moresearch", ".moreCondition", 1, "click");
				console.log($(window).height()-190+'px')
			$('.tableWrap').css('max-height',$(window).height()-200+'px')
			window.onresize=function(){
					$('.tableWrap').css('max-height',$(window).height()-200+'px')
			  	}
		});
		
		function dealCountMoney(){
			var mk1 = 0;
			var mk2 = 0;
			var mk3 = 0;
			var mk4 = 0;
			var mk5 = 0;
			var mk6 = 0;
			var mk7 = 0;
			var mk8 = 0;
			$(".my1").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk1 = (parseFloat(val) + parseFloat(mk1)).toFixed(2);
			});
			$(".my2").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk2 = (parseFloat(val) + parseFloat(mk2)).toFixed(2);
			});
			$(".my3").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk3 = (parseFloat(val) + parseFloat(mk3)).toFixed(2);
			});
			$(".my4").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk4 = (parseFloat(val) + parseFloat(mk4)).toFixed(2);
			});
			$(".my5").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk5 = (parseFloat(val) + parseFloat(mk5)).toFixed(2);
			});
			$(".my6").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk6 = (parseFloat(val) + parseFloat(mk6)).toFixed(2);
			});
			$(".my7").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk7 = (parseFloat(val) + parseFloat(mk7)).toFixed(2);
			});
			$(".my8").each(function(){
				var val = isBlank($(this).text()) ? 0 : $(this).text();
				mk8 = (parseFloat(val) + parseFloat(mk8)).toFixed(2);
			});
			$(".mk1").text(mk1);
			$(".mk2").text(mk2);
			$(".mk3").text(mk3);
			$(".mk4").text(mk4);
			$(".mk5").text(mk5);
			$(".mk6").text(mk6);
			$(".mk7").text(mk7);
			$(".mk8").text(mk8);
		}
		
		window.onresize = function(){
			$('.maintable table tbody').css('height',$(window).height()-350+'px');
		}
		
		
		
		function search() {
			/* if (isBlank($("#startDate1").val()) || isBlank($("#endDate1").val())) {
				layer.msg("请选择打卡日期！");
				return;
			}
			var dt1 = new Date($("#startDate1").val());
			var dt = new Date();
			if (dt.getTime() - 1000 * 90 * 24 * 60 * 60 > dt1.getTime()) {
				layer.msg("只允许查询近三个月的工程师考勤记录！");
				return;
			} */
			var empIds = $("select[name='empIds']").val();
			var pageSize = $("#pageSize").val();
			if ($.trim(pageSize) == '' || pageSize == null) {
				$("#pageSize").val(20);
			}
			
			window.location.href = "${ctx}/fitting/stock/empFitting?empIds=" + empIds;
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
			$("select[name='empIds']").select2('val','请选择');
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
						location.href = "${ctx}/fitting/stock/exportEmpKeep?maps=" + $("#searchForm").serialize();
					}

				});
			} else {
				location.href = "${ctx}/fitting/stock/exportEmpKeep?maps=" + $("#searchForm").serialize();
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
		
		function toempDetaol(){
			window.location.href="${ctx}/fitting/stock/empFittingItem";
		}
		
		function toempFitting(){
			window.location.href="${ctx }/fitting/stock/empFitting";
		}
		
		function showEmpItem(empId,status){
			if(status=='1'){
				layer.msg("工程师不存在！");
				return ;
			}
			/* if(status=='3'){
				layer.msg("工程师已离职！");
				return ;
			} */
			window.location.href="${ctx }/fitting/stock/empFittingItem?empId="+empId;
		}
		
		function toReturn(empId,status){
			if(status=='1'){
				layer.msg("工程师不存在！");
				return ;
			}
			/* if(status=='3'){
				layer.msg("工程师已离职！");
				return ;
			} */
			window.location.href="${ctx }/fitting/stock/waitReturn?empId="+empId;
		}
	</script>

</body>
</html>
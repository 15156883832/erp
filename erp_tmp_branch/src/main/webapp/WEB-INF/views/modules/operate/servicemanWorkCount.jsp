<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统公告管理</title>
	<meta name="decorator" content="base"/>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/highcharts.js"></script>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/exporting.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.js"></script>
	<style type="text/css">
		.dropdown-clear-all{
			line-height: 22px
		}
		.dropdown-display{font-size: 12px}
		.dropdown-selected{margin-top: 4px}
		.left_tip{
			position: absolute;
			top: 3px;
			left: -14px;
			display: block;
			width: 0;
			height: 0;
			border-top: 7px solid transparent;
			border-left: 7px solid transparent;
			border-right: 7px solid #888;
			border-bottom: 7px solid transparent;

		}
		.tip__{
			display: none;
			position: absolute;
			color:#999;
			border: 1px solid #aaa;
			margin-left: 28px;
			font-size: 12px;
			padding: 0 3px;
			top:3px;
			width: 235px;
		}
		.left_tip_{
			margin-top: -6px;
			margin-right: -15px;
			margin-left: 5px;
			cursor: pointer
		}
		.left_tip_:hover span{
			display: block;
			background-color:white;
		}
		.Hui-iconfont {
			 -webkit-text-stroke-width: 0px;
		}

	</style>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
	<div class="page-orderWait">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="STATISTIC_WORKLOADCOUNT_WORKLOADINDEX_TAB" html='<a class="btn-tabBar current" href="${ctx}/operate/nonServiceman/getServiceManWorkCount">工作量统计</a>'></sfTags:pagePermission>
			<p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<form action="${ctx}/operate/nonServiceman/getServiceManWorkCount"  id="cx" method="post">
			<div class="cl mt-15">
				<label class="">统计时间：</label>
				<input type="text" onfocus="WdatePicker({onpicked:checkfinish,maxDate:'#F{$dp.$D(\'endTime\')||\'%2018-%M-%d\'}',minDate:'#F{$dp.$D(\'startTime\',{M:-4});}'})" id="startTime" name="startTime" value="${map.startTime }" class="input-text Wdate w-140" readonly>
				至
				<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'%y-%M-%d'})" id="endTime" name="endTime" value="${map.endTime }" class="input-text Wdate w-140" readonly>
				<label class="ml-15">信息员：</label>
				<span class="w-140 dropdown-sin-2">
				<select class="select-box w-120"  id="servicemanIds" style="display:none" multiple  multiline="true" name="userIds"  >
					<c:forEach items="${servicemanList}" var="emp">
						<option value="${emp.columns.id}" <c:forEach var="chooseId" items="${userIdArry}"><c:if test="${chooseId eq emp.columns.id}">selected</c:if></c:forEach>>${emp.columns.name }</option>
					</c:forEach>
				</select>
				</span>
				<p class="f-r">
					<sfTags:pagePermission authFlag="STATISTIC_WORKLOADCOUNT_WORKLOADINDEX_EXPORT_BTN" html='<a  onclick="return exports()"class="sfbtn sfbtn-opt2"><i class="sficon sficon-export"></i>导出</a>'></sfTags:pagePermission>
				</p>
			</div>
		</form>
		<div class="mt-10 text-c tableWrap1 pr-5">
			<div class="tableLabel"  id="boxWrapHead">
				<table class="table table-bg table-bordered table-sdrk" style="border-bottom: 0;">
					<thead>
						<tr>
							<th style="width: 20%;">信息员</th>
							<th style="width: 20%;">新建工单</th>
							<th style="width: 20%;">工单派工</th>
							<th style="width: 20%;position: relative;">
								确认录单
								<i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">&#xe6cd;
									<span class="tip__"><em class="left_tip"></em>7.25日后的数据才添加确认录单人信息，所以只支持此后日期的确认录单量统计。</span>
								</i>
							</th>
							<th style="width: 20%;">工单回访</th>
							<th style="width: 20%;">工单结算</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="tableBody">
				<table class="table table-border table-bordered" id="bjStock_table">
					<tbody class="">
						<c:forEach var="record" items="${list}">
							<tr>
								<td style="width:20%;">${record.columns.serviceName}</td>
								<td style="width:20%;">${record.columns.buildOrderCount}</td>
								<td style="width:20%;">${record.columns.dispatchOrderCount}</td>
								<td style="width:20%;">${record.columns.recordAccountCount}</td>
								<td style="width:20%;">${record.columns.callBackCount}</td>
								<td style="width:20%;">${record.columns.settlementCount}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>
</div></div>

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
	var ct = eval('${empMap.empCount}');
	var dd;
	  $(function () {
		  $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
				if(result=="showPopup"){
					
					$(".vipPromptBox").popup();
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
				}
			});
			initTableH();
			dd = $('.dropdown-sin-2').dropdown({
		        // data: json2.data,
		        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',}).data('dropdown');

			var ids = '${empIds}';
			dd.choose(ids.split(","),true);
        });

	  function checkfinish(){
          var startTime = $("#startTime").val();
          var endTime = $("#endTime").val();
          if (!isBlank(startTime) && !isBlank(endTime)) {
              var startArry = startTime.split("-");
              var endArry = endTime.split("-");
              if (startArry[0] == endArry[0]) {
                  if (startArry[1] != endArry[1]) {
                      layer.msg("统计时间不能跨月查询，请重新选择！");
                      return false;
                  }else{
                      return true;
				  }
              } else {
                  layer.msg("统计时间不能跨月查询，请重新选择！");
                  return false;
              }
          }
          return true;
      }

    function isBlank(val){
        if (val == null || val == "" || val == undefined) {
            return true;
        }
    }

	function initTableH(){
		var tHeight = ($('.sfpagebg').height()-140);
		$('.tableBody').css({
			'max-height':tHeight,
			'overflow':'auto',
		});
		var h2 = $('#bjStock_table').height();
		if(h2 > tHeight){
			$('#boxWrapHead').css({
				'position':'relative',
				'padding-right':'17px',
			});
		}
	}
	
	function exports(){
        location.href="${ctx}/operate/nonServiceman/exportForService?"+$("#cx").serialize();
	}
	
	function search(){
        var result = checkfinish();
        if(result){
            $("#cx").submit();
        }
	}
	
	function reset(){
		$("#startTime").val('');
		$("#endTime").val('');
        dd.reset();
	}
	
	function jumpToVIP(){
		layer.open({
			type : 2,
			content:'${ctx}/goods/sitePlatformGoods/jumpVIP',
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		});
	}
	
</script> 
</body>
</html>
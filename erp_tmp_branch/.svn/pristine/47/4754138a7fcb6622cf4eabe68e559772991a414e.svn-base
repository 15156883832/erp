<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统公告管理</title>
	<meta name="decorator" content="base"/>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/highcharts.js"></script>
	<script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/exporting.js"></script>
</head>
<body>
<div class="sfpagebg bk-gray"><div class="sfpage">
	<div class="page-orderWait">
		<div class="tabBar cl mb-10">
			<sfTags:pagePermission authFlag="STATISTIC_ORDERSTATISTIC_WHOLEORDERSTATISTIC_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/orderIndex">全部工单统计</a>'></sfTags:pagePermission>
			<sfTags:pagePermission authFlag="STATISTIC_ORDERSTATISTIC_YWCORDERSTATISTIC_TAB" html='<a class="btn-tabBar current" href="${ctx}/statistic/orderCompleteIndex">已完成工单统计</a>'></sfTags:pagePermission>
		</div>
		<div class="cl mt-15">
			<label class="f-l">工单完成时间：</label>
			<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'bxdatemax\')||\'%y-%M-%d\'}'})" value="${startStr }" id="bxdatemin" name="bxdatemin" value="" class="input-text Wdate w-140" readonly>
			至
			<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'bxdatemin\')}',maxDate:'%y-%M-%d'})" value="${endStr }" id="bxdatemax" name="bxdatemax" value="" class="input-text Wdate w-140" readonly>
								
			<p class="f-r">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:reset();" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
		<h3 class="mt-15 modelHead"><strong>工单类型分析</strong> </h3>
		<div class="mt-10 cl">
			<div class="col-6 f-l " style=" padding: 0;">
				<div id="pieChart1" class="bk-gray" style="height: 260px;"></div>
			</div>
			<div class="col-6 f-l" style=" padding-right: 0;">
				<div id="pieChart2" class="bk-gray"  style="height: 260px;"></div>
			</div>
		</div>
		<h3 class="mt-15 modelHead"><strong>工单效率分析</strong> </h3>
		<div class="mt-10 cl">
			<div class="col-3-1 f-l bk-gray h-300" >
				<div id="barChart1" style="height: 260px;"></div>
				<p class="c-777 pb-10 pl-10">注：工单完工用时由工程师接单开始到工单完工结束。</p>
			</div>
			<div class="col-3-1 f-l pl-15 pr-15">
				<div class=" bk-gray h-300">
					<div id="pieChart3"  style="height: 260px;overflow: hidden;"></div>
					<p class="c-777 pl-10">注：接单及时是指工单派给工程师到工程师接单时间不超过1小时。</p>
				</div>
			</div>
			<div class="col-3-1 f-l bk-gray h-300">
				<div id="pieChart4" class=""  style="height: 260px;"></div>
				<p class="c-777 pb-10 pl-10">注：工单超过一次派工即为多次派工。</p>
			</div>
		</div>
		<h3 class="mt-15 modelHead"><strong>服务质量分析</strong> </h3>
		<div class="mt-10 cl">
			<div class="col-3-1 f-l bk-gray" >
				<div id="pieChart5" class="mb-30" style="height: 260px;"></div>
			</div>
			<div class="col-3-1 f-l pl-15 pr-15">
				<div class=" bk-gray">
					<div id="barChart2"  style="height: 260px;overflow: hidden;"></div>
					<p class="c-777 pb-10 pl-10 h-30">注：一个工单可能不止一个安全评价。</p>
				</div>
			</div>
			<div class="col-3-1 f-l bk-gray">
				<div id="pieChart6" class="mb-30"  style="height: 260px;"></div>
			</div>
		</div>
	</div>
</div></div>

<script type="text/javascript">
	var pieData2 = [];
	<c:forEach items="${orderMap.serviceTypeStats}" var="item">
		pieData2.push({name: '${item.columns.service_type}', y: ${item.columns.cnt}});
	</c:forEach>

	$(function(){
		
		var pieColor1 = ['#0e8ee7','#f29244'];
		var	pieData1 = [];
		if(!isBlank(eval('${orderMap.baonei}')) || !isBlank(eval('${orderMap.baowai}'))){
			pieData1.push({name: '保内', y: eval('${orderMap.baonei}')},{name:'保外', y: eval('${orderMap.baowai}')});
		}
		if(pieData1.length==0){
			showPiecharts('pieChart1', pieColor1,'保修类型统计',pieData1,"暂无分析数据");
		}else{
			showPiecharts('pieChart1', pieColor1,'保修类型统计',pieData1,"");
		}

//		红色 #FF0000
//		橙色 #FF7F00
//		黄色 #FFFF00
//		绿色 #00FF00
//		青色 #00FFFF
//		蓝色 #0000FF
//		紫色 #8B00FF
		var pieColor2 = ['#FF0000','#FF7F00','#FFFF00','#00FF00','#00FFFF','#0000FF','#8B00FF','#FF0000','#FF7F00','#FFFF00','#00FF00','#00FFFF','#0000FF','#8B00FF'];
		<%--pieData2 = [{name: '保养', y: eval('${orderMap.baoyang}')},{name:'维修', y: eval('${orderMap.weixiu}')},{name:'安装', y: eval('${orderMap.anzhuang}')}];--%>
		if(pieData2.length==0){
			showPiecharts('pieChart2', pieColor2,'服务类型统计',pieData2,"暂无分析数据");
		}else{
			showPiecharts('pieChart2', pieColor2,'服务类型统计',pieData2,"");
		}
	
		var pieColor3 = ['#0e8ee7','#f3643d'],
			pieData3 = [{name: '及时', y: eval('${orderMap.jdjs}')},{name:'不及时', y: eval('${orderMap.jdbjs}')}];//有问题
		showPiecharts('pieChart3', pieColor3,'接单及时率（派工1小时）',pieData3);
		
		var pieColor4 = ['#34cfce','#f29244'];
		var	pieData4 = [];
		
		if(!isBlank(eval('${orderMap.zcpaigong}')) || !isBlank(eval('${orderMap.duocipaigong}'))){
			pieData4.push({name: '正常派工', y: eval('${orderMap.zcpaigong}')},{name:'多次派工', y: eval('${orderMap.duocipaigong}')});
		}
		if(pieData4.length==0){
			showPiecharts('pieChart4', pieColor4,'多次派工',pieData4,"暂无分析数据");
		}else{
			showPiecharts('pieChart4', pieColor4,'多次派工',pieData4,"");
		}
		

		var pieColor5 = ['#f3643d','#02d4d3','#cc66ff','#f29244','#16cd70'];
		var	pieData5 = [];
		
		if(!isBlank(eval('${orderMap.sfmy}')) || !isBlank(eval('${orderMap.my}')) || !isBlank(eval('${orderMap.ybmy}')) || !isBlank(eval('${orderMap.bmy}')) || !isBlank(eval('${orderMap.sfbmy}')) ){
			pieData5.push({name: '非常满意', y: eval('${orderMap.sfmy}')},{name:'满意', y: eval('${orderMap.my}')},{name:'一般', y: eval('${orderMap.ybmy}')},{name:'不满意', y: eval('${orderMap.bmy}')},
					{name:'非常不满意', y: eval('${orderMap.sfbmy}')});
		}
		if(pieData5.length==0){
			showPiecharts('pieChart5', pieColor5,'服务态度',pieData5,"暂无分析数据");
		}else{
			showPiecharts('pieChart5', pieColor5,'服务态度',pieData5,"");
		}
		
		
		var pieColor6 = ['#0e8ee7','#f29244'],
			pieData6 = [];
		
		if(!isBlank(eval('${orderMap.zcshangmen}')) || !isBlank( eval('${orderMap.duocishangmen}')) ){
			pieData6.push({name: '正常上门', y: eval('${orderMap.zcshangmen}')},{name:'多次上门', y: eval('${orderMap.duocishangmen}')});
		}
		if(pieData6.length==0){
			showPiecharts('pieChart6', pieColor6,'多次上门',pieData6,"暂无分析数据");
		}else{
			showPiecharts('pieChart6', pieColor6,'多次上门',pieData6,"");
		}
		
		test();
	});

	var maxsi = 0;
	var sii = [];
	var si = [eval('${orderMap.totalYS}'), eval('${orderMap.YS24}'), eval('${orderMap.YS48}'), eval('${orderMap.YS72}'), eval('${orderMap.YSOV72}')];
	for (var j = 0; j < si.length; j++) {
		if (si[j] && si[j] > maxsi) {
			maxsi = si[j];
		}
		sii.push(Math.round(si[j] / maxsi * 100));
	}
	if (maxsi <= 0) {
		maxsi = 100;
	}

	function test(){
		$('#barChart1').highcharts({
	        chart: {
	            type: 'column',
	            style:{
	            	color:'#2a2a2a',
	        		fontWeight:'400' ,
	        		fontSize:'12px'
	            }
	        },
	        credits:false,
	        exporting:{
	        	enabled: false
	        },
	        legend: {
	        	enabled: false
	        },
	        title: {
	            text: '工单完工用时',
	            style:{
	            	color:'#2a2a2a',
	            	fontSize:'14px',
	            	fontWeight:'600'
	            }
	        },
	        colors:['#16cd70','#0e8ee7','#fdbc0e','#f27904','#fe0101'],
	        xAxis: {
	            categories:  ['全部工单','24h内','48h内','72h内','超72h'],
	            labels:{
	            	style:{
	            		color:'#2a2a2a',
	            		fontSize:'12px'
	            	}
	            },
	            lineColor:'#0d75be',
	            lineWidth: 2
	        },
	        yAxis: {
	            min: 0,
	            title: {text:''},
				ceiling: 100,
	            labels:{
	            	style:{
	            		color:'#2a2a2a',
	            		fontSize:'12px',
	            	}, formatter: function() {
	                    return Highcharts.numberFormat(this.value, 0) +'%';
	                }
	            },
	            lineColor:'#0d75be',
	            lineWidth: 2,
	            gridLineColor:'#cccccc'
	        },
	        tooltip: {
	            enabled:false,
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    formatter:function(){
	                   		return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+Highcharts.numberFormat(Math.round(this.y / 100 * maxsi), 0)+'</span>';
	                   	}
	                },
	                colorByPoint: true
	            }
	        },
	        series: [{
	            data: sii
	        }]
    	});
		
		$('#barChart2').highcharts({
	        chart: {
	            type: 'column',
	            style:{
	            	color:'#2a2a2a',
	        		fontWeight:'400' ,
	        		fontSize:'12px',
	            }
	        },
	        credits:false,
	        exporting:{
	        	enabled: false
	        },
	        legend: {
	        	enabled: false
	        },
	        title: {
	            text: '安全评价',
	            style:{
	            	color:'#2a2a2a',
	            	fontSize:'14px',
	            	fontWeight:'600'
	            }
	        },
	        colors:['#0e8ee7'],
	        xAxis: {
	            categories: ['全部工单','按安全规范操作','未清理现场','未穿工作服','未出示上岗证'],
	            labels:{
	            	style:{
	            		color:'#2a2a2a',
	            		fontSize:'12px',
	            	}
	            },
	            lineColor:'#0d75be',
	            lineWidth: 2
	        },
	        yAxis: {
	            min: 0,
	            title: {text:''},
	            labels:{
	            	style:{
	            		color:'#2a2a2a',
	            		fontSize:'12px',
	            	}, formatter: function() {
	                    return Highcharts.numberFormat(this.value,0) +'%';
	                }
	            },
	            lineColor:'#0d75be',
	            lineWidth: 2,
	            gridLineColor:'#cccccc'
	        },
	        tooltip: {
	            enabled:false,
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    formatter:function(){
	                   		return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+Highcharts.numberFormat(this.y, 0)+'</span>';
	                   	}
	                }
	            }
	        },
	        series: [{
	            data: [eval('${orderMap.total}'), eval('${orderMap.saf1}'), eval('${orderMap.saf4}'), eval('${orderMap.saf3}'), eval('${orderMap.saf2}')]
	        }]
    	});
	}
	
	function showPiecharts(id,colors,titleText,data,titleTwo){
		$('#'+id).highcharts({
	        chart: { },
	        credits:false,
	        exporting:{
	        	enabled: false
	        },
	        colors:colors,
	        title: {
	            text: titleText,
	            style:{
	            	fontSize:'13px',
	            	fontWeight:'600',
	            	color:'#2a2a2a',
	            },
	            y:15
	        },
	        subtitle:{
	        	text:titleTwo,
	        	style:{
		            	fontSize:'13px',
		            	fontWeight:'600',
		            	color:'#38a5f2',
		        },
		        y:150
	        },
	        tooltip: {
	            enabled:false,
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: false,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    connectorColor:'#666666',
	                   	formatter:function(){
	                   		return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+this.key+':'+ Highcharts.numberFormat(this.percentage, 0) +'%</span>';
	                   		//return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+this.key+':'+ this.percentage +'%</span>';
	                   	}
	                },
	            }
	        },
	        series: [{
	            type: 'pie',
	            size:'90%',
	            innerSize: '62.5%',
	            name: '保修类型统计',
	            data: data
	        }]
	    });    
	}
	
	function showBarcharts(id,colors,titleText,xAxis,data){
		$('#'+id).highcharts({
	        chart: {
	            type: 'column',
	            style:{
	            	color:'#2a2a2a',
	        		fontWeight:'400' ,
	        		fontSize:'12px',
	            }
	        },
	        credits:false,
	        exporting:{
	        	enabled: false
	        },
	        legend: false,
	        colors:colors,
	        title: {
	            text: titleText,
	            style:{
	            	color:'#2a2a2a',
	            	fontSize:'14px',
	            	fontWeight:'600'
	            }
	        },
	        xAxis: {
	            categories:xAxis,
	            labels:{
	            	style:{
	            		color:'#2a2a2a',
	            		fontSize:'12px',
	            	}
	            },
	            lineColor:'#0d75be',
	            lineWidth: 2
	        },
	        yAxis: {
	            min: 0,
	            title: {text:''},
	            labels:{
	            	style:{
	            		color:'#2a2a2a',
	            		fontSize:'12px',
	            	}
	            },
	            lineColor:'#0d75be',
	            lineWidth: 2,
	            gridLineColor:'#cccccc'
	        },
	        tooltip: {
	            enabled:false,
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    formatter:function(){
	                   		return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+Highcharts.numberFormat(this.y, 0)+'</span>';
	                   	}
	                },
	                colorByPoint: true
	            }
	        },
	        series: [{
	            data:data
	        }]
    	});
	}
	
	function search(){
		var bxdatemin =  $("#bxdatemin").val();
		var bxdatemax =  $("#bxdatemax").val();
		var year = $('#year option:selected').val();
		window.location.href="${ctx}/statistic/orderCompleteIndex?bxdatemin="+bxdatemin+"&bxdatemax="+bxdatemax;
	}
	
	function reset(){
		$("#bxdatemin").val('');
		$("#bxdatemax").val('');
	}
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}
</script> 
</body>
</html>
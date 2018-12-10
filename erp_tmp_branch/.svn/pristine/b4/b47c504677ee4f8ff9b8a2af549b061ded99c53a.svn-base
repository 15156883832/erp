<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
  <head>
    
    <meta name="decorator" content="base"/>
<%-- <script type="text/javascript" src="${ctxPlugin}/lib/Highcharts/4.1.7/js/highcharts.js"></script>  --%>
<script src="${ctxPlugin }/lib/Highcharts/highcharts.js"></script>
<script src="${ctxPlugin }/lib/Highcharts/map.js"></script>
<script src="${ctxPlugin }/lib/Highcharts/china.js"></script>
<script>
    var mapdata = Highcharts.maps['cn/china'];
</script>
	

  </head>
  
  <body>
    <div class="sfpagebg bk-gray">
	<div class="sfpage  table-header-settable">
	<div class="page-orderWait">
	<div id="tab-system" class="HuiTab">
		<div class="tabBar cl mb-20">
			<a class="btn-tabBar " href="${ctx }/goods/nanDao/sysOrder">南岛订单</a>
			<sfTags:pagePermission authFlag="SYSTEM_AUTH_NANDAO_SITERANT_TAB" html='<a class="btn-tabBar " href="${ctx}/statistic/siteRankList">网点排名</a>'/>
			<sfTags:pagePermission authFlag="SYSTEM_AUTH_NANDAO_SITEANALYSIS_TAB" html='<a class="btn-tabBar current" href="${ctx}/statistic/siteLoubaoList">统计分析</a>'/>
			<!-- <p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
			</p> -->
		</div>
		<div class="cl pt-30">
			<div class=" cl" style="width:90%; margin: 0 auto 20px">
			<!-- <div class="f-l " style="width:40%;padding-right:30px; border-right:1px solid #ccc"> -->
				<div class=" cl" >
					<div class="pl-20 f-16 f-r">
						月份查询：<!-- <select class="select w-100"><option>1</option></select> -->
						<input id="starttime" type="text" runat="server" readonly="readonly" onfocus="selectMonth()" class="input-text Wdate w-120 va-t" value="${queryMonth }"/> 
					</div>
					<div class="pl-20 f-16 f-l "><span class="lh-20 iconStatic1">漏保购买总数：</span><span class="c-f55025 f-24 lh-24 va-t" id="total1">11</span><span class="lh-20 pl-5">个</span> </div>
				</div>
				<div id="container"  style="width: 100%; height: 400px; margin: 0 auto 20px"></div>
			<!-- </div> -->
			<!-- <div class="f-l " style="width:60%"> -->
			<div class=" cl" >
				<div class="pl-20 f-16 mb-10 "><span class="lh-20 iconStatic2">漏保累积购买总数：</span><span class="c-f55025 va-t lh-24 f-24 " id="total2">11</span><span class=" lh-20 pl-5">个</span></div>
				<div id="mapContainer" style="width: 100%; height: 700px; margin: 0 auto"></div>
			</div>
			<!-- </div> -->
		</div>
	</div>
	
</div>

</div>
</div>

<script type="text/javascript">
	var chart1, chart2;
	var mapJson = eval('(' +'${mapJson}'+ ')');
	var chartJson = eval('(' + '${chartJson}' + ')');
	var chartItems = chartJson.items;
	$("#total1").text(chartJson.total);
	$("#total2").text(mapJson.total);
	$(document).ready(function() {
		initCharts();
		initMap();
	});
	
	function selectMonth() {  
        WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false , maxDate:'%y-%M',
        	onpicked:function(){
        		var queryMonth = $dp.cal.getDateStr(); 
        		$.post('${ctx}/statistic/siteLoubaoMonthData', {queryMonth: queryMonth}, function(result){
        			var data = eval("(" + result + ")");
        			var total = data.total;
        			$("#total1").text(total);
        			chartItems = data.items;
        			$('#container').highcharts().series[0].setData(chartItems);//.get('ser1').setData(data, true, false, false);
        		});
        	}
        });
    }
	
	function initCharts(){
		var title = {
		      text: '漏保购买趋势'   
		   };
		   var xAxis = {
				min:0,
				crosshair: {
		            width: 1,
		            color: '#9900ff',
		            dashStyle: 'shortdot'
				},
				tickInterval:1,
				startOnTick:true,
				labels: {
					formatter : function(){
						return (this.value + 1);
					}
				}
		   };
		   var yAxis = {
		      title: {
		         text: '购买数量(个)'
		      },
		      min:0,
		      crosshair: {
		            width: 1,
		            color: '#9900ff',
		            dashStyle: 'shortdot'
		        },
		      minPadding:0,
		    　　startOnTick:false,
			    lineColor: '#A6A89B',
	            lineWidth: 1,
		      plotLines: [{
		         value: 0,
		         width: 1,
		         color: '#808080'
		      }]
		   };   

		   var tooltip = {
		      valueSuffix: '\xB0C'
		   };

		   var series =  [
		      {
				id:'ser1',
		         name: '个数',
		         color:'#0e8ee7',
		         lineWidth:1,
	        	 //data:testData()
	        	 data: chartItems,
	        	 marker:{
	        		 lineWidth:1,
	        		 radius:2.8
	        	 }
		      }
		   ];
		   
		   var tooltip = {
			   formatter : function (){ // 提示框格式化字符串
			   		var idx = this.point.index;
			   		var data = chartItems[idx];
	                 var s = '<p><strong>购买日期: </strong>'+data[0]+'</p><br/>'
	                 	 + '<p><strong>购买总数量: </strong>'+data[1]+'(个)</p><br/>'
	                 	 + '<p><strong>购买总次数: </strong>'+data[2]+'(单)</p>';
	                 return s;
	             }
		   };

		   var json = {};
		   var credits = {
			     enabled: false // 禁用版权信息
		   };

		   var plotOptions = {
		        line: {
		            dataLabels: {
		            	formatter: function(){
		            		var idx = this.point.index;
					   		var data = chartItems[idx];
		            		if(data[1] > 0){
		            			return data[1] + '个/' + data[2] + '单';		            			
		            		}else{
		            			return "0";
		            		}
		            	},
		                enabled: true          // 开启数据标签
		            }
		        }
		    };
		   json.title = title;
		   json.xAxis = xAxis;
		   json.yAxis = yAxis;
		   json.tooltip = tooltip;
		   json.credits = credits;
		   json.series = series;
		   json.legend = false;
		   json.plotOptions = plotOptions;

		   $('#container').highcharts(json);
	}

	function initMap(){
		var map = null;
	    map = $('#mapContainer').highcharts('Map', {
	        title: {
	            text: '漏保购买区域分布'
	        },
	        credits: {
			    enabled: false // 禁用版权信息
			},
	        mapNavigation: {
	            enabled: true,
	            enableMouseWheelZoom: true,
	            enableButtons: false
	        }, 
	        colorAxis: {
	            min: 0,
	            minColor: '#fff',
	            maxColor: '#006cee',
	            dataClasses: levelArr()
	           /*  labels:{
	                style:{
	                    "color":"red","fontWeight":"bold"
	                }
	            } */
	        },
	        legend: {
	        	title: {
	        		text: '(颜色-购买总数)'
	        	},
	            layout: 'vertical',
	            align: 'left',
	            floating: true,
	            x: 10,
	            //labelFormat: '{name} (个)',
	            labelFormatter: function(){
	            	if(this.to == undefined){
	            		return this.from + '以上';
	            	}
	            	return this.from + '-' + this.to + '(个)';
	            }
	        },
	        series: [{
	            data: mapJson.items,
	            mapData: mapdata,
	            joinBy: 'name',
	            dataLabels: {
                    enabled: true,
                    color: '#333',
                    style:{"fontSize": "12px", "fontWeight": "bold", "textOutline": "0px 0px contrast" },
                    format: '{point.name}({point.value})'
                },
                tooltip: {
                    useHTML: true,
                    headerFormat: '<strong>{point.key}</strong><br/><table>',
                    pointFormat: '<tr><td>服务商个数: </td><td>{point.fws}</td></tr><br/>' + 
                    '<tr><td>购买总单数: </td><td>{point.cs}(单)</td></tr><br/>' + 
                    '<tr><td>购买总数量: </td><td>{point.zs}(个)</td></tr><br/>',
                    footerFormat: '</table>',
                },
	        }]
	    });
	}
	
	function levelArr(){
		var arr = [];
		var val = mapJson.total;
		if(val > 10){
			var gap = parseInt(val/100);
			arr = [{
	            from: 0,
	            to: gap,
	            color: '#feda9f'
	        }, {
	            from: gap + 1,
	            to: gap*2,
	            color: '#a6f7e2'
	        }, {
	            from: gap*2 + 1,
	            to: gap*4,
	            color: '#7eb5fc'
	        }, {
	            from: gap*4 + 1,
	            to: gap*6,
	            color: '#f29efe'
	        }, {
	            from: gap*6,
	            color: '#fc543d'
	        }]
		}else{
			arr = [{
	            from: 0,
	            to: 10,
	            color: '#feda9f'
	        }];
		}
		return arr;
	}
	
function search(){
	var pageSize = $("#pageSize").val();
	if ($.trim(pageSize) == '' || pageSize == null) {
		$("#pageSize").val(20);
	}
    $("#table-waitdispatch").sfGridSearch({
        postData: $("#searchForm").serializeJson()
    });

}

</script>
  </body>
</html>
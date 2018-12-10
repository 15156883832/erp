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
			<a class="btn-tabBar "  href="${ctx }/goods/platFormOrder/vipOrderHeader">已支付VIP购买订单</a>
            <a class="btn-tabBar "  href="${ctx }/goods/platFormOrder/nopayvipOrderHeader">未支付VIP购买订单</a>
            <sfTags:pagePermission authFlag="SYSTEM_AUTH_VIP_STATIS_TAB" html='<a class="btn-tabBar current"  href="${ctx }/statistic/vipStatisticIndex">VIP统计分析</a>'/>
			<!-- <p class="f-r btnWrap">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
			</p> -->
		</div>
		<div class="cl pt-30">
			<div class=" cl" style="width:90%; margin: 0 auto 20px">
				<div class=" cl" >
					<div class="pl-20 f-16 f-l "><span class="lh-20 iconStatic1">VIP到期-服务商总数：</span><span class="c-f55025 f-24 lh-24 va-t" id="total1">11</span><span class="lh-20 pl-5">个</span><span id="titleSpan"></span></span> </div>
				</div>
				<div id="container"  style="width: 100%; height: 400px; margin: 0 auto 20px"></div>
			<div class=" cl" >
				<div class="pl-20 f-16 ">
					<span class="lh-20 iconStatic3">VIP服务商数：</span><span class="c-f55025 va-t lh-24 f-24" id="total2">11</span><span class=" lh-20 pl-5">个</span>
					<span class="lh-20 iconStatic4 ml-30">非VIP服务商数：</span><span class="c-f55025 va-t lh-24 f-24 " id="nvtotal2">11</span><span class=" lh-20 pl-5">个</span>					
				</div>
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
	$("#nvtotal2").text(mapJson.nvTotal);
	$(document).ready(function() {
		initCharts();
		initMap();
		$("#titleSpan").append("(从" + chartItems[0][0] + "月份以后)");
	});
	
	function initCharts(){
		var title = {
		      text: 'VIP到期趋势'   
		   };
		   var xAxis = {
				min:0,
				crosshair: {
		            width: 1,
		            color: '#9900ff',
		            dashStyle: 'shortdot'
				},
				tickInterval: 1,
				startOnTick: true,
				categories: chartJson.xCategories,
				labels: {
					formatter : function(){
						return (this.value.substring(2));
					}
				}
		   };
		   var yAxis = {
		      title: {
		         text: '到期服务商数量(个)'
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
	                 var s = '<p><strong>到期月份: </strong>'+data[0]+'</p><br/>'
	                 	 + '<p><strong>服务商数量: </strong>'+data[1]+'(个)</p><br/>';
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
		            			return data[1] + '个';
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
	            text: '服务商区域分布'
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
	        		text: '(颜色-服务商数)'
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
                    format: '{point.name}(v:{point.vfws})'
                },
                tooltip: {
                    useHTML: true,
                    headerFormat: '<strong>{point.key}</strong><br/><table>',
                    pointFormat: '<tr><td>vip服务商个数: </td><td>{point.vfws}</td></tr><br/>' + '<tr><td>非vip服务商数: </td><td>{point.nvfws}(个)</td></tr><br/>',
                    footerFormat: '</table>',
                },
	        }]
	    });
	}
	
	function levelArr(){
		var arr = [];
		var val = mapJson.total;
		if(val > 10){
			var gap = parseInt(val/10);
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
	            to: gap*3,
	            color: '#7eb5fc'
	        }, {
	            from: gap*3 + 1,
	            to: gap*4,
	            color: '#f29efe'
	        }, {
	            from: gap*4+1,
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
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
			<a class="btn-tabBar current" href="">产品顾问绩效</a>
		
		</div>
		<div class="cl mt-15">
			<label class="f-l">查询月份：</label>
			<input id="starttime" type="text" name="month" runat="server" readonly="readonly" onfocus="selectMonth()" class="input-text Wdate w-120" value="${times }"/>
			<p class="f-r">
				<a href="javascript:search();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt"><i class="sficon sficon-reset"></i>重置</a>
			</p>
		</div>
	
		<div class="mt-10">
			<div id="barChart" class="chartBox" style="height: 400px"></div>
			
		</div>
		<div class="mt-10">
			<div id="addbarChart" class="chartBox" style=""></div>
			
		</div>
	</div>
</div></div>



<script type="text/javascript">
	 var xtext = [];//X轴TEXT
		var month="${times}"
		
			function selectMonth() {  
	        WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false , maxDate:'%y-%M',
	        	onpicked:function(){
	        		var queryMonth = $dp.cal.getDateStr(); 
	        	
	        	}
	        });
	    }
		
	$(function(){
			    $.ajax({
					type:"post",
			        url:'${ctx}/order/statistics/getlisttimes', //请求数据的地址
					data: {month:month},
					dataType:"json",
					success:function(data){
						var obj = eval(data);
						 var length = obj.length;
						for(var i=0; i < length; i++)
						{
				              xtext.push(obj[i]);
						
						}
						barChart();
						addbarChart();
			        },
			        error:function(e){
			        } 
		    }); 
			});
	
	function barChart(){
		
		var seriesData = ${data};
		var items = [];
		/* $.each(seriesData, function(idx, item){
			console.log(item);
			var point = {
					point: {
						cursor:'pointer',
						events:{
							click:function(){
								var index = this.index;
								var val = item.data[index];
								var name = item.name;
								console.log(name + "----" +val);
								
								//location.href='https://www.baidu.com';
							}
						}
					}		
			};
			var item1 = $.extend(point, item);
			items.push(item1);
		}); */
		
		$('#barChart').highcharts({
	        chart: {
	            type: 'line'
	        },
	        credits:false,
	        exporting:{
	        	enabled: false
	        },
	      
	        title: {
	            text: month+'月产品顾问绩效',
	            style:{
	            	color:'#2a2a2a',
	            	fontSize:'14px',
	            	fontWeight:'600'
	            }
	        },
	       xAxis: {
	        	type: 'datetime',
		        categories:xtext,
	            dateTimeLabelFormats: {
	                week: '%Y-%m-%d'
	            }
	        }, 
	        yAxis: {
	            min: 0,
	            title: {text:''},
	            lineColor:'#0d75be',
	            lineWidth: 1,
	            gridLineWidth:0
	        },
	        tooltip: {
	            enabled:true,
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    formatter:function(){
	                   		return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+this.y+'</span>';
	                   	}
	                },
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function (e) {
	                        	var seriesKey = this.series.name;
	                        	
	                        	var data = [];
	                        	$.each(seriesData, function(idx, item){
	                    			if(item.name == seriesKey){
	                    				data = item.data;
	                    				return false;
	                    			}
	                    		});
	                        	//查询出所有值
	                        	var dataVal = data[this.index];
	                        	
	                         //   alert(dataVal);
	                        }
	                    }
	                }
	            }
	        },
	        //series: ${data}
	        series: seriesData
    	});
	}
	
	var seriesData = [];
	
	function addbarChart(){

		$('#addbarChart').highcharts({
	        chart: {
	            type: 'line'
	        },
	        credits:false,
	        exporting:{
	        	enabled: false
	        },
	      
	        title: {
	            text: month+'月产品顾问每天新增客户数',
	            style:{
	            	color:'#2a2a2a',
	            	fontSize:'14px',
	            	fontWeight:'600'
	            }
	        },
	       xAxis: {
	        	type: 'datetime',
		        categories:xtext,
	            dateTimeLabelFormats: {
	                week: '%Y-%m-%d'
	            }
	        }, 
	        yAxis: {
	            min: 0,
	            title: {text:''},
	            lineColor:'#0d75be',
	            lineWidth: 1,
	            gridLineWidth:0
	        },
	        tooltip: {
	            enabled:true,
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    formatter:function(){
	                   		return '<span style="color:#2a2a2a;font-size:12px;font-weight:400">'+this.y+'</span>';
	                   	}
	                }
	            }
	        },
	        series: ${assdata}
	      
    	});
	}
	
	function initTableH(){
		var tHeight = ($('.sfpagebg').height()-100)/2;
		$('.boxWrap').css({
			'height':tHeight,
			'overflow':'auto',
		})
		$('.chartBox').height(tHeight-20);
	}
	
	function search(){
		var month = $('#starttime').val();
		window.location.href="${ctx}/order/statistics/getStatistics?month="+month;
	}


</script> 
</body>
</html>
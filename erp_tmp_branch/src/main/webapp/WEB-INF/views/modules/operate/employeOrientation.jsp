<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui/css/H-ui.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css"/>
	 <style type="text/css">
      body,html,#container{
        height: 100%;
        margin: 0px
      }
     .panel {
        background-color: #ddf;
        color: #333;
        border: 1px solid silver;
        box-shadow: 3px 4px 3px 0px silver;
        position: absolute;
        top: 10px;
        right: 10px;
        border-radius: 5px;
        overflow: hidden;
        line-height: 20px;
      }
      #input{
        width: 250px;
        height: 25px;
        border: 0;
        background-color: white;
      }
    </style>
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef&plugin=AMap.Autocomplete,AMap.PlaceSearch"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
	
</head>
<body>
<div class="sfpagebg bk-gray">
	<div class="sfpage">
		<div class="page-orderWait">
			<div class="tabBar cl mb-10">
				<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYEPOSITION_TAB" html='<a class="btn-tabBar current" href="${ctx }/operate/employeOrientation/firstPage">工程师定位</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYERECORD_TAB" html='<a class="btn-tabBar" href="${ctx }/operate/employeDailySign/headerList">考勤记录</a>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="OPERATEMGM_EMPLOYEATTEND_EMPLOYELEAVE_TAB" html='<a class="btn-tabBar" href="${ctx }/operate/employeDailySign/employeLeaveList">请假记录</a>'></sfTags:pagePermission>
			</div>
			<div class="cl mt-15">
				<label class="f-l">服务工程师：</label>
				<select class="select select-box w-140 f-l"  id="selectName">
					<option value="">请选择</option>
					<c:forEach items="${employeList}" var="emp" >
						<option value="${emp.columns.id }">${emp.columns.name }</option>
					</c:forEach>
				</select>&nbsp;&nbsp;
				<input id="hcName" hidden="hidden" value="${emp.columns.name }"/> 
				<p class="f-r">
					<a href="javascript:test();" class="sfbtn sfbtn-opt"><i class="sficon sficon-search"></i>查询</a>
					<a href="javascript:orbitSearchWrap();" class="sfbtn sfbtn-opt " id="btn-track" ><i class="sficon sficon-track"></i>轨迹查询</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt" id="reset"><i class="sficon sficon-reset"></i>重置</a>
				</p>
			</div>
			<div class="mt-10 bk-gray pos-r mapWrap">
				<div class="addrTxtBg h-40"></div>
				<div class="addrTxt h-40 pl-10 pt-5">
					<p class="f-l"><i class="lState lState1"></i><span style="color:blue" id="has"></span> 人&nbsp;10分钟内有定位信息</p>
					<p class="f-l ml-20"><i class="lState lState2"></i> <span style="color:blue" id="noHas"></span> 人&nbsp; 10分钟内无定位信息</p>
					<div class="f-l ml-20 lh-30 c-fe0101">
						<span class="f-l mr-5 sficon-ring">通知</span>
						<div class="f-l c-333" id="namelist" style="max-width: 670px;overflow: hidden;">
							<c:if test="${count > 0 }">
							  	 <c:forEach items="${list1}" var="lit">
									${lit.columns.name }
							  	 </c:forEach>
							</c:if>
						</div>
						<span class="f-l ml-5">今日 <span style="color:blue">${count}</span> 人未登录APP</span> 
					</div>
				</div>
				<div class="addrMap" id="map-container">
					<!-- 地图部分 -->
				</div>
			</div>
			<div class="c-fe0101 pt-5 lh-26">注：当前“定位信息”需服务工程师APP在线且开启定位功能才能获取
				<p class="f-r">
					<input type="text" class="input-text w-300 f-l " id="input1"  value="点击地图显示地址" />&nbsp;&nbsp;
					<input type="text" class="input-text w-140 f-l " id = 'input2' value = '点击地图显示坐标' >
				</p>
			</div>

		</div>
	</div>
</div>
	
<div class="popupBox popupMap checkTrack">
	<h2 class="popupHead">
		轨迹查询
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain ">
			<div class="bk-gray mapBox pos-r">
				<div class="addrTxtBg h-40"></div>
				<div class="addrTxt h-40 pl-10">
					<p class="f-l mt-5"><i class="lState lState3"></i><span id="emName" ></span> <span class="c-e90a0a">未完工工单</span> <span style="color:blue" id="countContinue" ></span> 个 </p>
					<p class="f-l mt-5 ml-20"><i class="lState lState4"></i><span id="emName1" ></span> <span class="c-e90a0a">当天完工工单</span> <span style="color:blue" id="countEnd" ></span> 个 </p>
					<p class="f-l mt-5 ml-20"><input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d',minDate:'2017-12-13',onpicked: onOrbitDatePicked })" class="input-text w-160 readonly" placeholder="请选择日期(15日以内)" id="orbitSearchBox" readonly></p>
				</div>
				<div class="mapBox" id="container">
				
				</div>
			</div>
		</div>
	</div>
</div>

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

<script src="${ctxPlugin}/static/h-ui.admin/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>
<%--<script type="text/javascript" src="${ctxPlugin}/lib/layer/2.4/layer.js"></script>--%>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<%--<script type="text/javascript" src="${ctxPlugin}/lib/My97DatePicker/4.8/WdatePicker.js"></script> --%>
<%--<script src="${ctxPlugin}/static/h-ui.admin/js/jquery.jqGrid.src.revised.js" type="text/javascript" charset="utf-8"></script>--%>
<script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/laypage/1.2/laypage.js"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/grid.locale-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/sifang.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery.ztree.core.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/jquery.ztree.excheck.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/txtScroll.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctxPlugin}/static/h-ui.admin/js/aliSimplePath2.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.10"></script>
<script type="text/javascript">
var defaultLayer = new AMap.TileLayer({textIndex:15});
var defaultLayer1 = new AMap.TileLayer({textIndex:15});
var traffic = new AMap.TileLayer.Traffic();//图层叠加，默认图层
var traffic1 = new AMap.TileLayer.Traffic();//交通图层
var geocoder;
 var map = new AMap.Map("map-container", {
    resizeEnable: true,
    layers: [
             defaultLayer1,//默认图层
            // traffic1,//实时交通图层
             new AMap.Buildings()
         ], 
    zoom: 16 //地图显示的缩放级别
});  
 
 var map1 = new AMap.Map("container", {
	    resizeEnable: true,
	    layers: [
	             defaultLayer,//默认图层
	             traffic,//实时交通图层
	             new AMap.Buildings()
	         ],
	    zoom: 10 //地图显示的缩放级别
	});
 
 /*异步加载多个插件的方法AMap.plugin*/
 AMap.plugin(["AMap.OverView","AMap.CircleEditor","AMap.Scale","AMap.Geocoder","AMap.ToolBar"],function(){//位于地图左上角，比列缩放等小工具
     view = new AMap.OverView({//地图右下角显示一个地图简略的概览
         visible:true //初始化隐藏鹰眼
     });
     view1 = new AMap.OverView({//地图右下角显示一个地图简略的概览
         visible:true //初始化隐藏鹰眼
     });
     tool = new AMap.ToolBar({
    	 offset:new AMap.Pixel(10,37),
    	 visible:true //初始化隐藏鹰眼 
    	
     });
     tool1 = new AMap.ToolBar({
    	 offset:new AMap.Pixel(10,37),
    	 visible:true //初始化隐藏鹰眼 
    	
     });
     map.addControl(view1);
     map.addControl(tool);
     map.addControl(tool1);
   	 map1.addControl(view);
     
     map.addControl(new AMap.Scale());//比列尺
     map1.addControl(new AMap.Scale());
     
     geocoder = new AMap.Geocoder({
         city: "010"//城市，默认：“全国”
     });
     var marker4 = new AMap.Marker({
    	 visible:false,//点标记不可见
         map:map,
         bubble:true
     });
     map.on('click',function(e){
         marker4.setPosition(e.lnglat);
         geocoder.getAddress(e.lnglat,function(status,result){
           if(status=='complete'){
              document.getElementById('input1').value = result.regeocode.formattedAddress;
              document.getElementById('input2').value = e.lnglat;
           }
         })
     })

 });



 
 /*定位*/
var markers=[];
var infoWindow = new AMap.InfoWindow(); //信息窗体
$(function(){
	$('#selectName').select2();
	//2.监听父层按钮的动作
	$('#pngfix-nav-btn', parent.document).click(function(){
		//3.给定一个时间点
		setTimeout(function(){
			//4.再次执行全屏
			layer.restore(full_idx);
		},200);
	});
	
	$(".selection").css("width","140px");
	
	
	var sc = new Scroll(document.getElementById('namelist'));
	
	$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
		if(result=="showPopup"){
			
			$(".vipPromptBox").popup();
			$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		}
	});
	
	initTableH();
	getLoc('${siteAddress}', function() {
		map.panTo(this);
		test();
	}, function() {
		getLoc('${alternateAddress}', function() {
			map.panTo(this);
			test();
		}, function() {
			test();
		});
	});
});

function onOrbitDatePicked() {
    orbitSearch();
}

function initTableH(){
		var tHeight = $('.sfpagebg').height()-150;
		$('.mapWrap').css({
			'height':tHeight,
			'overflow':'auto'
		})
	}
	
$("#reset").on("click",function(){
	//$("#selectName").val("");
	$("#selectName").select2('val', '请选择');
});


function test(){
	var empId = $("#selectName").val();
	$.ajax({
		type:"POST",
		url:"${ctx}/operate/employeOrientation/discEmploye",
		data:{empId:empId}, 
		dataType:'json',
		success:function(result){
				map.remove(markers);
				var lnglats = result;
				var has=0 ;
				var noHas=0;
	            for(var i = 0, marker; i < lnglats.length; i++){
	            	if(lnglats[i].columns.longitude==null || lnglats[i].columns.longitude==""){
	            		if(empId==""){
	            		}else{
	            			if(empId != "" || empId != null || empId != undefined){
	            		  		$('body').popup({
	        					level:'3',
	        					type:2,
	        					content:lnglats[i].columns.name+" 今天未登陆app！"
		       					})	
		            		}
	            		}
	            	}else{
	            	 var timestamp = (new Date()).valueOf();
		             var createTime=lnglats[i].columns.create_date;
	                 var gap = (timestamp-createTime)/(1000*60);
	                 var img;
	                 var htmlContent;
	            	 if(gap>10){
	            		noHas=noHas+1;
		                htmlContent='<div class="eName eName2" id="eName2">'+
										'<i class="lState lState2"></i>'+
										'<div class="text-overflow">'+lnglats[i].columns.name+'</div>'+
									'</div>';	
	                 }else{
	                	 has=has+1;
	                	 htmlContent='<div class="eName eName1" id="eName1">'+
										'<i class="lState lState1"></i>'+
										'<div class="text-overflow">'+lnglats[i].columns.name+'</div>'+
									'</div>';			
	                 }
	                marker=new AMap.Marker({
	                    position:[lnglats[i].columns.longitude,lnglats[i].columns.latitude],
	                    map:map,
	                    content:htmlContent,
                        clickable:true
	                });
	                markers.push(marker);
	                marker.setTitle("最新定位时间   "+getDate(lnglats[i].columns.create_date)+"");
	                marker.content="<div class='text-c mb-10'>"+"【"+lnglats[i].columns.name+"】<span class='c-fe0101'>"+ getDate2(lnglats[i].columns.create_date)+"</span></div>";
	                marker.on('click',markerClick2);
	            }
	            map.setFitView();
            }
	            $("#has").text(has);
	            $("#noHas").text(noHas);
		}
	})
}
var infoWindow1 = new AMap.InfoWindow({
    offset: new AMap.Pixel(16, -30)
});
function markerClick2(e){
    var thisadress;
    geocoder = new AMap.Geocoder({
        city: "010"//城市，默认：“全国”
    });

    geocoder.getAddress(e.lnglat,function(status,result){

        if(status=='complete'){
            infoWindow1.setContent(e.target.content+"<div class='c-888'>"+result.regeocode.formattedAddress+"</div>");
        }else{
            infoWindow1.setContent(e.target.content+"");
		}
    })
    //infoWindow1.setContent(e.target.content+""+thisadress);
    infoWindow1.open(map, e.target.getPosition());
}


function getDate(tm) {
	var tt = new Date(parseInt(tm)).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
	return tt;
}
function getDate2(tm) {
    var date = new Date(tm);
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes();
    return currentdate;
}


function getLoc(addr, ret, fail) {
	$.ajax({
		type: "POST",
		url: "${ctx}/operate/employeOrientation/getLocations",
		data: {address: addr},
		success: function (data) {
			if(data && data.length > 0) {
				ret.call(data);
			} else {
				fail.call();
			}
		},
		error: function() {
			fail.call();
		}
	});
}

function getLocationCall(address, customer_name, repair_time, lastest_process, customer_tel, service_type, appliance_category, map, markers) {
	return function() {
		$.ajax({
			type: "POST",
			url: "${ctx}/operate/employeOrientation/getLocations",
			data: {address: address},
			success: function (data) {
				if (data != null && data != "") {
					var marker1 = new AMap.Marker({
						animation: "AMAP_ANIMATION_DROP",
						position: data,
						map: map,
						offset: new AMap.Pixel(-12, -12),
						content: '<i class="lState lState3"></i>'
					});
					marker1.setTitle("用户姓名  " + customer_name + "");
					markers.push(marker1);
					marker1.content =
							'<div class="posInfoWrap pl-5 pr-5">' +
							'<div class="pd-10 lh-18">' +
							'<p class="cl">' +
							'报修时间：' + repair_time + '' +
							'<span class="f-r c-fe0101">' + lastest_process + '</span>' +
							'</p>' +
							'</div>' +
							'<div class="line-dashed"></div>' +
							'<div class="pd-10 lh-18">' +
							'<p class="cl">' +
							'<span class="f-l c-666">' + customer_tel + '</span>' +
							'<span class="c-0383dc f-r" >' + service_type + '</span>' +
							'<span class="f-r mr-10">' + appliance_category + '</span>' +
							'</p>' +
							'<p class="c-666 mt-5">' + address + '</p>' +
							'</div>' +
							'</div>' +
							'<i class="iconArrow"></i>';
					marker1.on('click', markerClick);
				}
			}
		});
	}
}

function getLocationCallFinished(address, customer_name, repair_time, lastest_process, customer_tel, service_type, appliance_category, map, markers) {
	return function() {
		$.ajax({
			type: "POST",
			url: "${ctx}/operate/employeOrientation/getLocations",
			data: {address: address},
			success: function (data) {
				if (data != null && data != "") {
					var marker2 = new AMap.Marker({
						animation: "AMAP_ANIMATION_DROP",
						position: data,
						map: map,
						offset: new AMap.Pixel(-12, -12),
						content: '<i class="lState lState4"></i>'
					});
					marker2.setTitle("用户姓名  " + customer_name + "");
					markers.push(marker2);
					marker2.content = '<div class="posInfoWrap pl-5 pr-5">' +
							'<div class="pd-10 lh-18">' +
							'<p class="cl">' +
							'报修时间：' + repair_time + '' +
							'<span class="f-r c-fe0101">' + lastest_process + '</span>' +
							'</p>' +
							'</div>' +
							'<div class="line-dashed"></div>' +
							'<div class="pd-10 lh-18">' +
							'<p class="cl">' +
							'<span class="f-l c-666">' + customer_tel + '</span>' +
							'<span class="c-0383dc f-r" >' + service_type + '</span>' +
							'	<span class="f-r mr-10">' + appliance_category + '</span>' +
							'</p>' +
							'<p class="c-666 mt-5">' + address + '</p>' +
							'</div>' +
							'</div>' +
							'<i class="iconArrow"></i>';
					marker2.on('click', markerClick);
				}
			}
		});
	}
}

function orbitSearchWrap() {
    $("#orbitSearchBox").val("");
    orbitSearch();
}

/*轨迹*/
var orbitSearching = false;
function orbitSearch() {
    if (orbitSearching) {
        return;
    }

	map1 = new AMap.Map("container", {
	    resizeEnable: true,
	    layers: [
	             defaultLayer,//默认图层
	             traffic,//实时交通图层
	             new AMap.Buildings()
	         ],
	    zoom: 10 //地图显示的缩放级别
	});
    AMap.plugin(["AMap.OverView", "AMap.CircleEditor", "AMap.Scale", "AMap.Geocoder", "AMap.ToolBar"], function () {//位于地图左上角，比列缩放等小工具
        view1 = new AMap.OverView({//地图右下角显示一个地图简略的概览
            visible: true //初始化隐藏鹰眼
        });
        tool1 = new AMap.ToolBar({
            offset: new AMap.Pixel(10, 37),
            visible: true //初始化隐藏鹰眼

        });
        map1.addControl(tool1);
        map1.addControl(view);
        map1.addControl(new AMap.Scale());
        geocoder = new AMap.Geocoder({
            city: "010"//城市，默认：“全国”
        });
    });
    var selName = $("#selectName");
	var empId = selName.val();
	var name = selName.find("option:selected").text();
	$("#emName").html(name);
	$("#emName1").html(name);

	if (!empId) {
		$('body').popup({
			level: '3',
			type: 1,
			content: "请先选择服务工程师！"
		})
	} else {
	    orbitSearching = true;
		$.ajax({
			type: "POST",
			url: "${ctx}/operate/employeOrientation/orbitSearch",
			data: {empId: empId, orbitDate: $("#orbitSearchBox").val()},
			dataType: 'json',
			success: function (result) {
				$("#countContinue").html(result.countContinue);
				$("#countEnd").html(result.countEnd);
				map1.remove(markers);
				map1.remove(infoWindow);
				var lnglatsEnd = result.recordsEnd;
				var lnglats = result.records;
				var todayLinegj = eval('('+result.todayLine+')');
				var i = 0;
				if (todayLinegj.length > 1) {
					var htContent = "";
					var lngX;
					var latY;
					var lineArr = [];
					for (i = 0; i < todayLinegj.length; i++) {
						lngX = todayLinegj[i].e;
						latY = todayLinegj[i].n;
						lineArr.push(new AMap.LngLat(lngX, latY));
						if (i === 0) {
							htContent = '<i class="lStateStart"></i>';
							marker3 = new AMap.Marker({
								animation: "AMAP_ANIMATION_DROP",
								map: map1,
								position: new AMap.LngLat(todayLinegj[0].e, todayLinegj[0].n),//基点位置
								autoRotation: true,
								content: htContent
							});
							markers.push(marker3);
						} else if (i === (todayLinegj.length - 1)) {
							htContent = '<i class="lStateEnd"></i>';
							marker3 = new AMap.Marker({
								animation: "AMAP_ANIMATION_DROP",
								map: map1,
								position: new AMap.LngLat(todayLinegj[i].e, todayLinegj[i].n),//基点位置
								autoRotation: true,
								content: htContent
							});
							markers.push(marker3);
						}

					}

					var lngLatMinMax = result.lngLatMinMax;
					drawSimplePath(map1, lineArr, lngLatMinMax);
				} else {
                    layer.msg("未查询到轨迹信息");
				}
				/*到目前为止所有未完成的工单*/
				if (lnglats.length > 0) {
					for (i = 0; i < lnglats.length; i++) {
						var address = lnglats[i].columns.customer_address;
						var o2 = lnglats[i].columns.customer_name + "";
						var o3 = getDate(lnglats[i].columns.repair_time);
						var o4 = lnglats[i].columns.latest_process;
						var o5 = lnglats[i].columns.customer_name + '  ' + lnglats[i].columns.customer_telephone;
						var o6 = lnglats[i].columns.service_type;
						var o7 = lnglats[i].columns.appliance_category;
						getLocationCall(address, o2, o3, o4, o5, o6, o7, map1, markers)();
					}
				}
				/*今日完成的工单*/
				if (lnglatsEnd.length > 0) {
					for (i = 0; i < lnglatsEnd.length; i++) {
						var address = lnglatsEnd[i].columns.customer_address;
						var o2 = lnglatsEnd[i].columns.customer_name + "";
						var o3 = getDate(lnglatsEnd[i].columns.repair_time);
						var o4 = lnglatsEnd[i].columns.latest_process;
						var o5 = lnglatsEnd[i].columns.customer_name + '  ' + lnglatsEnd[i].columns.customer_telephone;
						var o6 = lnglatsEnd[i].columns.service_type;
						var o7 = lnglatsEnd[i].columns.appliance_category;
						getLocationCallFinished(address, o2, o3, o4, o5, o6, o7, map1, markers)();
					}
				}
				map.setFitView();
				var tracker = $('.checkTrack');
				if(!tracker.is(":visible")) {
                    tracker.popup();
				}
			},
			complete: function() {
                orbitSearching = false;
			}
		})
	}
}

function markerClick(e){
   infoWindow.setContent(e.target.content);
   infoWindow.open(map1, e.target.getPosition());  
}

//地理编码返回结果展示  
function geocoder_CallBack(data){
    var resultStr="";
    //地理编码结果数组
    var geocode = new Array();
    geocode = data.geocodes; 
    for (var i = 0; i < geocode.length; i++) {
        //拼接输出html
        resultStr += "<span style=\"font-size: 12px;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;\">"+"<b>地址</b>："+geocode[i].formattedAddress+""+ "<b>    坐标</b>：" + geocode[i].location.getLng() +", "+ geocode[i].location.getLat() +""+ "<b>    匹配级别</b>：" + geocode[i].level +"</span>";  
        addmarker(i, geocode[i]);
    } 
    mapObj.setFitView();  
    document.getElementById("result").innerHTML = resultStr; 
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
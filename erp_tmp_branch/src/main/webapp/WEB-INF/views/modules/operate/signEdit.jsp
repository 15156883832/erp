<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<%--<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.css" />--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/H-ui.admin.css" />--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/Hui-iconfont/1.0.8/iconfont.css" />--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/skin/default/skin.css" id="skin" />--%>

<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/ui.jqgrid.css"/>--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/jquery-ui-1.9.2.custom.css"/>--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/bootstrap.pagination.css"/>--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/easyui.css"/>--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/style.css" />--%>
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
</head>
<body>
<c:if test="${type eq 1 or type eq 3 }">
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div class="mt-35">
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>上班时间：</label>
						<%--<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'\')||\'%h:%m:%s\'}'})" id="workdatemax" name="workdatemax" value="" class="input-text Wdate w-300" >--%>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm:ss'})" id="workdatemax" name="workdatemax" value="" class="input-text Wdate w-300">
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>下班时间：</label>
						<%--<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'\')||\'%h:%m:%s\'}'})" id="afterdatemax" name="afterdatemax" value="" class="input-text Wdate w-300" >--%>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm:ss'})" id="afterdatemax" name="afterdatemax" value="" class="input-text Wdate w-300">
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90 text-r">打卡地点：</label>
						<input type="text" class="input-text w-300 f-l" id="signPoint" /><a href="javascript:;" class="c-0e8ee7 ml-10" onclick="curmaskAddr()" id="btn-showaddr" ><i class="Hui-iconfont Hui-iconfont-weizhi f-20"></i></a>
					</div>
					<input type="hidden" name="customerLnglat" readonly="true" id="lnglat" value="" />
					<input type="hidden" name="longitude" readonly="true" id="longitude" value="" />
					<input type="hidden" name="latitude" readonly="true" id="latitude" value="" />
					<div class="cl mb-20">
						<label class="f-l w-90 text-r">打卡范围：</label>
						<select class="select f-l w-300" id="signRange">
							<option value="">请选择</option>
							<option value="100">100米内</option>
							<option value="200">200米内</option>
							<option value="300">300米内</option>
							<option value="500">500米内</option>
							<option value="1000">1公里内</option>
						</select>
					</div>
					<div class="pl-90">
						<a href="javascript:save()" class="sfbtn sfbtn-opt3 text-c f-13 w-70">保存</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${type eq 2 }">
	<div class="sfpagebg bk-gray">
		<div class="sfpage">
			<div class="page-orderWait">
				<div class="mt-35">
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>上班时间：</label>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm:ss'})" id="workdatemax" name="workdatemax" value="<fmt:formatDate value="${record.columns.working_time }" pattern="HH:mm:ss"/>" class="input-text Wdate w-300">
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>下班时间：</label>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm:ss'})" id="afterdatemax" name="afterdatemax" value="<fmt:formatDate value="${record.columns.off_working_time }" pattern="HH:mm:ss"/>" class="input-text Wdate w-300">
					</div>
					<div class="cl mb-10">
						<label class="f-l w-90 text-r">打卡地点：</label>
						<input type="text" class="input-text w-300 f-l" value="${record.columns.sign_point }" id="signPoint" /><a href="javascript:;" class="c-0e8ee7 ml-10" onclick="curmaskAddr()" id="btn-showaddr" ><i class="Hui-iconfont Hui-iconfont-weizhi f-20"></i></a>
					</div>
					<input type="hidden" name="customerLnglat" readonly="true" id="lnglat" value="" />
					<input type="hidden" name="longitude" readonly="true" id="longitude" value="" />
					<input type="hidden" name="latitude" readonly="true" id="latitude" value="" />
					<input type="hidden"  value="${record.columns.id }" id="signId" />
					<div class="cl mb-20">
						<label class="f-l w-90 text-r">打卡范围：</label>
						<select class="select f-l w-300" value="${record.columns.sign_range }" id="signRange">
							<option value="">请选择</option>
							<option value="100">100米内</option>
							<option  value="200">200米内</option>
							<option value="300">300米内</option>
							<option value="500">500米内</option>
							<option value="1000">1公里内</option>
						</select>
					</div>
					<div class="pl-90">
						<a href="javascript:save1()" class="sfbtn sfbtn-opt3 text-c f-13 w-70">保存</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:if>



<div class="popupBox popupMap plocation">
	<h2 class="popupHead">
		地址定位
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain ">
			<div class="bk-gray mapBox pos-r">
				<div class="addrTxtBg"></div>
				<div class="addrTxt ">
					<p class="c-f55025 lh-26">注：在地图上拖动用户位置或输入详细地址（XX市XX县/区XX街道XX小区）点击“定位”获取用户位置信息</p>
					<input type="text" class="input-text w-300 mr-5" id="dingweidizhi" value="合肥市蜀山区">
					<a href="javascript:dingwei();" id="dingwei" class="sfbtn sfbtn-opt3 text-c f-13 w-70">定位</a>
					<a href="javascript:gather();" class="sfbtn sfbtn-opt3 text-c f-13 w-70 ml-10">确定</a>
				</div>
				<div class="addrMap" id="map-container">
					<!-- 地图部分 -->
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

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript">
var type;
var a = true;
var marker;
type='${type}';
AMap.service('AMap.Geocoder', function () {//回调函数
    //实例化Geocoder
    geocoder = new AMap.Geocoder();
});

$(function(){
	$.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
		if(result=="showPopup"){
			
			$(".vipPromptBox").popup();
			$('#Hui-article-box',window.top.document).css({'z-index':'9'});
		}
	});
	$("#signRange option[value='"+'${record.columns.sign_range}'+"']").attr("selected","selected");//根据值让option选中  
});

//点击显示“地址定位”弹出框
function curmaskAddr(){
	//$('.spqrsf').popup();
	var openBtn = $('#btn-showaddr');
	var obj = $('.plocation');
	initAddrmap();
	 	 if(!isBlank($("#signPoint").val())) {
			$("#dingweidizhi").val($("#signPoint").val()); 
		}
			if(a) {
			 map.plugin(["AMap.ToolBar"],function(){
			        var tool = new AMap.ToolBar();
			        tool.setOffset(new AMap.Pixel(10,52));
			        map.addControl(tool);  
			    });
			 a = false;
			} 
			$('.plocation').popup();
} 


	function initAddrmap(){
		var addrMap = $('#addrMap');
		var hAddr = addrMap.height();
		var hWin = $(window).height()/2 ;
		addrMap.height( hWin < 394 ? 394:hWin );
		map = new AMap.Map('map-container', {
	        zoom: 10
	    });
	     mark = new AMap.Marker({ 
	    	 map:map,
	    	 draggable:true
	    });
	    mark.setMap(map);
	     mark.on('dragend',function(e){
    	    geocoder.getAddress(mark.getPosition(),function(status,result){
    	      if(status=='complete'){
    	    	  $('#dingweidizhi').val(result.regeocode.formattedAddress);
    	          $("#lnglat").val(mark.getPosition());
    	          $("#latitude ").val(mark.getPosition().lat);
    	          $("#longitude").val(mark.getPosition().lng);
    	      }else{
    	    	  layer.msg('无法获取地址');
    	      }
    	    })
    	}); 
	}
	
	function isBlank(val) {
		if(val==null || val=='' || val == undefined) {
			return true;
		}
		return false;
	}
	
	function dingwei(){//定位
		var slnglat;
		 var address = $('#dingweidizhi').val();
		 if($('#dingweidizhi').val() == ""){
				layer.msg("请输入地址定位");
			}else{
				mark.setMap(null);
	         geocoder.getLocation(address, function (status, result) {
	        	 if(marker!=null){
	        	       	marker.setMap(null);
	        	       	marker = null;
	        	       	}
	            if (status === 'complete' && result.info === 'OK') {
	                if (result.resultNum && result.resultNum > 0) {
	                    var location = result.geocodes[0].location;
	                    slnglat = location.lng+","+location.lat
	                    $("#lnglat").val(slnglat); 
	                    map.panTo(new AMap.LngLat(location.lng, location.lat));
	                    map.setZoom(13);
	                    $("#latitude ").val(location.lat);
             	        $("#longitude").val(location.lng);
	                    if (marker == null) {
	                        marker = new AMap.Marker({
	                            position: [location.lng, location.lat],
	                            map: map,
	                            draggable:true
	                        });
	                        marker.setMap(map);
	                        marker.on('dragend',function(e){
	                    	    geocoder.getAddress(marker.getPosition(),function(status,result){
	                    	      if(status=='complete'){
	                    	    	  $('#dingweidizhi').val(result.regeocode.formattedAddress);
	                    	    	  $("#latitude ").val(marker.getPosition()[0]);
	                    	          $("#longitude").val(marker.getPosition()[1]);
	                    	          $("#lnglat").val(marker.getPosition()); 
	                    	      }else{
	                    	    	  layer.msg('无法获取地址');
	                    	      }
	                    	    })
	                    	});
	                    } else {
	                        marker.setPosition(location.lng, location.lat);
	                    }
	                }
	            } else {
	            }
	        }); 
	
	}
	}
	
	function gather(){
		if($('#dingweidizhi').val() == ""){
			layer.msg("请输入地址定位");
		}else if(isBlank($("#lnglat").val())) {		
				layer.msg('请定位'); 
			}else{
		  $("#signPoint").val($('#dingweidizhi').val());
		  $("#signPoint").focus();
				//$(".bottommask").hide();
		//$('.curMaskbox-addr').hide();
		$.closeDiv($('.plocation'));
		 $('#dingweidizhi').val("");
		 $("#customerAddress").blur();
		}
		

	} 

function save(){
	var workingTime = $("#workdatemax").val();
	var offWorkingTime = $("#afterdatemax").val();
	var signPoint = $("#signPoint").val();//打卡地点
	var signRange = $("#signRange").val();//打卡范围
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	
	if(!isBlank(signRange)){
		if(isBlank(signPoint)){
			layer.msg("请设置打卡地点！");
			return;
		}
	}
	if($.trim(workingTime)==null || $.trim(workingTime)==""){
		layer.msg("请填写上班时间！");
		return;
	}else if($.trim(offWorkingTime)==null || $.trim(offWorkingTime)==""){
		layer.msg("请填写下班时间！");
		return;
	}else  if(offWorkingTime<workingTime){
		layer.msg("下班时间要求大于上班时间！");
		return;
	}else{
		var d = new Date();
		var workingTime1 = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+workingTime;
		var offWorkingTime1 = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+offWorkingTime;
		$.ajax({
			type:"POST",
			url:"${ctx}/operate/employeDailySign/saveSign",
			data:{workingTime:workingTime1,
				offWorkingTime:offWorkingTime1,
				signPoint:signPoint,
				signRange:signRange,
				latitude:latitude,
				longitude:longitude},  
			dataType:'json',
			success:function(result){
				if(result==true){
					if(type=="1"){
						window.location.href="${ctx }/operate/employeDailySign/headerList";
						layer.msg("添加成功！");
					}else if(type=="3"){
						layer.msg("添加成功！");
						window.location.reload(true);
					}
				}else{
					layer.msg("添加失败，请检查！");
				}
			}
		})
	}
}

function save1(){//修改
	var workingTime = $("#workdatemax").val();
	var offWorkingTime = $("#afterdatemax").val();
	var signPoint = $("#signPoint").val();
	var signRange = $("#signRange").val();
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	var signId = $("#signId").val();
	
	if(!isBlank(signRange)){
		if(isBlank(signPoint)){
			layer.msg("请设置打卡地点！");
			return;
		}
	}
	
	if($.trim(workingTime)==null || $.trim(workingTime)==""){
		layer.msg("请填写上班时间！");
		return;
	}else if($.trim(offWorkingTime)==null || $.trim(offWorkingTime)==""){
		layer.msg("请填写下班时间！");
		return;
	}else if(offWorkingTime<workingTime){
		layer.msg("下班时间要求大于上班时间！");
		return;
	}else{
		var d = new Date();
		var workingTime1 = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+workingTime;
		var offWorkingTime1 = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+offWorkingTime;
		 $.ajax({
			type:"POST",
			url:"${ctx}/operate/employeDailySign/saveSignEdit",
			data:{workingTime:workingTime1,
				offWorkingTime:offWorkingTime1,
				signPoint:signPoint,
				signRange:signRange,
				latitude:latitude,
				longitude:longitude,
				signId:signId}, 
			dataType:'json',
			success:function(result){
				if(result==true){
					layer.msg("修改成功！");
					 setTimeout(function () {window.location.reload(true); }, 1000);
					
					
				}else{
					layer.msg("修改失败，请检查！");
				}
			}
		}) 
	}
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
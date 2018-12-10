<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>全部工单</title>
<meta name="decorator" content="base"/>
<script type="text/javascript" src="${ctxPlugin}/lib/orderFormat.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
	<style type="text/css">
		.dropdown-clear-all{
			line-height: 22px;
		}
		.dropdown-display{font-size: 12px}
		.dropdown-selected{line-height: 22px}
	</style>
</head>
<body>
<div class="popupBox bjfcbox w-520 addwork">
	<form id="fc_form">
		<h2 class="popupHead">
			修改
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
		<input hidden="hidden" id="signId" value="${detail.columns.id }" />
			<div class="popupMain pd-15 tab1">
			<c:forEach items="${fns:getSignTimesList(detail.columns.sign_times) }" var = "dt" varStatus="idx">
			 	<c:if test="${idx.index==0 }">
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>上班时间：</label>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'08:30',maxDate:'#F{$dp.$D(\'afterdatemax1\')||\'%y-%M-%d\'}'})" id="workdatemax1"  name="workdatemax1" style="width:101px;" value="${dt.on }" class="input-text Wdate w-100">
						<label class="w-90 text-r"><em class="mark">*</em>下班时间：</label>
						<c:choose>
							<c:when test="${ idx.last}"> 
						   		<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'18:00',minDate:'#F{$dp.$D(\'workdatemax1\')}',maxDate:'%y-%M-%d'})" id="afterdatemax1"  name="afterdatemax1" style="width:101px;" value="${dt.off }" class="input-text Wdate w-100">
							</c:when>
							<c:otherwise> 
						   		<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'18:00',minDate:'#F{$dp.$D(\'workdatemax1\')}',maxDate:'#F{$dp.$D(\'workdatemax2\')||\'%y-%M-%d\'}'})" id="afterdatemax1"  name="afterdatemax1" style="width:101px;" value="${dt.off }" class="input-text Wdate w-100">
						    </c:otherwise> 
						</c:choose>
						
					</div> 
				</c:if>
				<c:if test="${idx.index==1 }">
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>上班时间：</label>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'08:30',minDate:'#F{$dp.$D(\'afterdatemax1\')}',maxDate:'#F{$dp.$D(\'afterdatemax2\')||\'%y-%M-%d\'}'})" id="workdatemax2"  name="workdatemax2" style="width:101px;" value="${dt.on }" class="input-text Wdate w-100">
						<label class="w-90 text-r"><em class="mark">*</em>下班时间：</label>
						<c:choose>
							<c:when test="${ idx.last}"> 
								<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'18:00',minDate:'#F{$dp.$D(\'workdatemax2\')}',maxDate:'%y-%M-%d'})" id="afterdatemax2"  name="afterdatemax2" style="width:101px;" value="${dt.off }" class="input-text Wdate w-100">
							</c:when>
							<c:otherwise> 
						   		<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'18:00',minDate:'#F{$dp.$D(\'workdatemax2\')}',maxDate:'#F{$dp.$D(\'workdatemax3\')||\'%y-%M-%d\'}'})" id="afterdatemax2"  name="afterdatemax2" style="width:101px;" value="${dt.off }" class="input-text Wdate w-100">
						    </c:otherwise> 
						</c:choose>
						
					</div> 
				</c:if>
				<c:if test="${idx.index==2 }">
					<div class="cl mb-10">
						<label class="f-l w-90 text-r"><em class="mark">*</em>上班时间：</label>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'08:30',minDate:'#F{$dp.$D(\'afterdatemax2\')}',maxDate:'#F{$dp.$D(\'afterdatemax3\')||\'%y-%M-%d\'}'})" id="workdatemax3"   name="workdatemax3" style="width:101px;" value="${dt.on }" class="input-text Wdate w-100">
						<label class="w-90 text-r"><em class="mark">*</em>下班时间：</label>
						<input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'HH:mm',startDate:'18:00',minDate:'#F{$dp.$D(\'workdatemax3\')}',maxDate:'%y-%M-%d'})"  name="afterdatemax3" id="afterdatemax3" style="width:101px;" value="${dt.off }" class="input-text Wdate w-100">
					</div> 
				</c:if>
			</c:forEach>
				<div class="cl mb-10">
					<label class="f-l w-90 text-r">打卡地点：</label>
					<input type="text" class="input-text w-300 f-l signPoint" value="${detail.columns.sign_point }" id="signPoint" name="signPoint" /><a href="javascript:;" class="c-0e8ee7 ml-10" onclick="curmaskAddr()"  ><i class="Hui-iconfont Hui-iconfont-weizhi f-20"></i></a>
				</div>
				<input type="hidden" name="customerLnglat" class="customerLnglat" readonly="true"  value="" />
				<input type="hidden" name="longitude" class="longitude" readonly="true" value="" />
				<input type="hidden" name="latitude" class="latitude" readonly="true" value="" />
				<div class="cl mb-10">
					<label class="f-l w-90 text-r">打卡范围：</label>
					<select class="select f-l w-300" name="signRange" id="signRange">
						<option value="">请选择</option>
						<option value="100" <c:if test="${detail.columns.sign_range=='100' }">selected="selected"</c:if> >100米内</option>
						<option value="200" <c:if test="${detail.columns.sign_range=='200' }">selected="selected"</c:if>>200米内</option>
						<option value="300" <c:if test="${detail.columns.sign_range=='300' }">selected="selected"</c:if>>300米内</option>
						<option value="500" <c:if test="${detail.columns.sign_range=='500' }">selected="selected"</c:if>>500米内</option>
						<option value="1000" <c:if test="${detail.columns.sign_range=='1000' }">selected="selected"</c:if>>1公里内</option>
					</select>
				</div>
				<c:if test="${detail.columns.type=='1' }">
					<div class="cl mb-20 relaEmp">
						<label class="f-l w-90 text-r"><em class="mark">*</em>关联工程师：</label>
						<span class="reloadDropDown intHtml">
						<span class="w-300 dropdown-sin-2" >
							<select class="select-box w-300" placeholder="请选择" multiple name="employeIds" id="employeIds"  style="width:300px">
								<option value="" disabled>请选择</option>
								<c:forEach items="${fns:getEmloyeOtherList(siteId,detail.columns.id) }" var="emp">
									<option value="${emp.columns.id }" 
									<c:forEach items="${detail.columns.idsArr }" var = "arrys">
										<c:if test="${arrys==emp.columns.id }">selected</c:if>
									</c:forEach>  
									>${emp.columns.name }</option>
								</c:forEach>
							</select>
						</span>
						</span>
					</div>
				</c:if>
				<div class="text-c">
					<a href="javascript:save()" class="sfbtn sfbtn-opt3 text-c f-13 w-70">保存</a>
				</div>
			</div>
		</div>
	</form>
</div>

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
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
/*是否有数据*/
var gridHadData=true;

var a = true;
var dd;//dropdown
var marker;
AMap.service('AMap.Geocoder', function () {//回调函数
    //实例化Geocoder
    geocoder = new AMap.Geocoder();
});

$(function(){
	$(".addwork").popup();
	dd = $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        choice: function() {
        }
    }).data("dropdown");
})

//点击显示“地址定位”弹出框
function curmaskAddr(){
    initAddrmap();
    if(!isBlank($(".signPoint").val())) {
        $("#dingweidizhi").val($(".signPoint").val());
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
                $(".customerLnglat").val(mark.getPosition());
                $(".latitude ").val(mark.getPosition().lat);
                $(".longitude").val(mark.getPosition().lng);
            }else{
                layer.msg('无法获取地址');
            }
        })
    });
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
                    $(".customerLnglat").val(slnglat);
                    map.panTo(new AMap.LngLat(location.lng, location.lat));
                    map.setZoom(13);
                    $(".latitude ").val(location.lat);
                    $(".longitude").val(location.lng);
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
                                    $(".latitude ").val(marker.getPosition()[0]);
                                    $(".longitude").val(marker.getPosition()[1]);
                                    $(".customerLnglat").val(marker.getPosition());
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
    }else if(isBlank($(".customerLnglat").val())) {
        layer.msg('请定位');
    }else{
        $(".signPoint").val($('#dingweidizhi').val());
        $(".signPoint").focus();
        $.closeDiv($('.plocation'));
        $('#dingweidizhi').val("");
        $(".customerAddress").blur();
    }
}

function isBlank(val) {
	if(val==null || $.trim(val)=='' || val == undefined) {
		return true;
	}
	return false;
}

var addMark = false;
function save(){
	if(addMark){
		return;
	}
	var on1 = $("#workdatemax1").val();
	var off1 = $("#afterdatemax1").val();
	var on2 = $("#workdatemax2").val();
	var off2 = $("#afterdatemax2").val();
	var on3 = $("#workdatemax3").val();
	var off3 = $("#afterdatemax3").val();
	var signPoint = $("#signPoint").val();;
	var signRange = $("#signRange").val();
	var employeIds = $("#employeIds").val();
	if(isBlank(on1)){
		layer.msg("请填写上班时间！");
		return ;
	}
	if(isBlank(off1)){
		layer.msg("请填写下班时间！");
		return ;
	}
	if('${tag}'=='2' || '${tag}'=='3'){
		if(isBlank(on2)){
			layer.msg("请填写上班时间！");
			return ;
		}
		if(isBlank(off2)){
			layer.msg("请填写下班时间！");
			return ;
		}
	}
	if('${tag}'=='3'){
		if(isBlank(on3)){
			layer.msg("请填写上班时间！");
			return ;
		}
		if(isBlank(off3)){
			layer.msg("请填写下班时间！");
			return ;
		}
	}
	if('${detail.columns.type}'=='1'){
		if(isBlank(employeIds)){
			layer.msg("请选择关联工程师！");
			return ;
		}
	}
	var postData = {
			on1:dealTime(on1),
			off1:dealTime(off1),
			on2:dealTime(on2),
			off2:dealTime(off2),
			on3:dealTime(on3),
			off3:dealTime(off3),
			signPoint:signPoint,
			signRange:signRange,
			employeIds:employeIds,
			signNum:'${detail.columns.sign_num}',
			id:$("#signId").val()
	}
	addMark = true;
	$.ajax({
		type:"post",
		data:postData,
		url:"${ctx}/operate/employeDailySign/saveEditSignSet",
		dataType:"json",
		success:function(data){
			addMark = false;
			if(data=='200'){
				parent.parent.layer.msg("修改成功！");
				//window.location.href="${ctx}/operate/employeDailySign/signSet?signNum="+'${detail.columns.sign_num}';
				parent.relaodPage();
				$.closeDiv($(".addwork"));
			}else if(data=='420'){
				layer.msg("该考勤记录信息已过时，请刷新后重试！");//记录已被删
			}else if(data=='421'){
				layer.msg("您选择的工程师中有已设置过的历史记录！");
			}else{
				layer.msg("修改失败，请联系管理员！");
			}
			return ;
		},
		error:function(){
			addMark = false;
			layer.msg("出现异常！");
			return;
		}
	}) 
}

function dealTime(val){
	var d = new Date();
    return d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + val+":00";
}


</script>
</body>
</html>
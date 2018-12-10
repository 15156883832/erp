﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="decorator" content="base" />
    <script type="text/javascript" src="${ctxPlugin}/lib/socket.io.js"></script>
    <link rel="stylesheet" href="${ctxPlugin}/static/h-ui.admin/css/date.css" type="text/css">
    <%-- <link rel="stylesheet" href="${ctxPlugin}/static/h-ui.admin/css/calendar.css" type="text/css"> --%>
   
    <title>全部工单</title>

</head>
<body>
<div class="homepage">
    <div class="cl">
        <div class="f-l col-6" style="padding-left: 0px;margin-bottom: 15px">
            <div class="radius modeBox">
                <h2 class="boxHeader2 tabBarP2">
                    <a href="javascript:showTab('today');" class="tabswitch current tabswitch-today">今日工单</a>
                    <c:if test="${isPeijianMan}">
                        <a href="javascript:showTab('beijian');" class="tabswitch tabswitch-beijian">备件申请待办</a>
                    </c:if>
                </h2>
                <div class="pl-20 pt-10 pr-20 leftTopTab tab-today" style="height: 281px;padding-top: 75px;">

                    <div class="col-4-1 f-l pt-10 pb-10">
                        <div class="bjwrap ">
                            <p class="f-16 mb-10" onclick="jumpToJrgd();">今日工单</p>
                            <p class="num c-0e8ee7" id="jr_order" onclick="jumpToJrgd();">0</p>
                        </div>
                        <!-- <div class="bjbox bjbox4">
                            <p class="num c-0e8ee7" >0</p>
                            <p class="f-14">今日预约</p>
                        </div> -->
                    </div>
                    <div class="col-4-1 f-l bl br pt-10 pb-10">
                        <div class="bjwrap ">
                            <p class="f-16 mb-10" onclick="jumpToDpg();">待派工</p>
                            <p class="num c-ef6d6d " id="dpg_wct" onclick="jumpToDpg();">0</p>
                            <p class="f-14" onclick="jumpToJryu();">今日预约<strong class="c-ef6d6d pd-5" id="jryy_wct">0</strong></p>
                        </div>
                        <!-- <div class="bjbox bjbox5">
                            <p class="num c-ef6d6d" >0</p>
                            <p class="f-14">待派工工单</p>
                        </div> -->
                    </div>
                    <div class="col-4-1 f-l  br  pt-10 pb-10">
                        <div class="bjwrap">
                            <p class="f-16 mb-10" onclick="jumpToFwz();">服务中</p>
                            <p class="num c-00c3a3" id="fwz_order" onclick="jumpToFwz();">0</p>
                            <p class="f-14" onclick="jumpToQjz();">缺件中<strong class="c-00c3a3 pd-5" id="qjz_wct">0</strong></p>
                        </div>
                        <!-- <div class="bjbox bjbox6">
                            <p class="num c-00c3a3" >0</p>
                            <p class="f-14">缺件中</p>
                        </div> -->
                    </div>
                    <div class="col-4-1 f-l pt-10 pb-10">
                        <div class="bjwrap ">
                            <p class="f-16 mb-10" onclick="jumpToJrtx();">今日提醒标记</p>
                            <p class="num c-fd7e2a" id="jrtx_order" onclick="jumpToJrtx();">0</p>
                        </div>
                        <!-- <div class="bjbox bjbox4">
                            <p class="num c-0e8ee7" >0</p>
                            <p class="f-14">今日预约</p>
                        </div> -->
                    </div>
                </div>
                <c:if test="${isPeijianMan}">
                    <div class="cl hide leftTopTab tab-beijian " style="height: 281px;padding-top: 75px;">
                        <div class="col-3-1 f-l pt-30 pb-30">
                            <div class="bjbox bjbox1">
                                <p class="num c-0e8ee7" id="dsh_bj">0</p>
                                <p class="f-14" >待审核</p>
                            </div>
                        </div>
                        <div class="col-3-1 f-l bl br pt-30 pb-30">
                            <div class="bjbox bjbox2">
                                <p class="num c-ef6d6d" id="qjz_bj">0</p>
                                <p class="f-14" >缺件中</p>
                            </div>
                        </div>
                        <div class="col-3-1 f-l  pt-30 pb-30">
                            <div class="bjbox bjbox3">
                                <p class="num c-00c3a3" id="dck_bj">0</p>
                                <p class="f-14">待出库</p>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="f-l col-6" style="padding-right: 0px;padding-left:0; margin-bottom: 15px">
            <div class="radius modeBox">
                <h2 class="boxHeader">待办事项<a href="javascript:;" class="f-r c-white f-14" id="btn-addItem"><!-- <i class="sficon sficon-edit4"></i>签到 --><i class="marginLeft15 sficon sficon-edit3"></i> 新增事项</a></h2>
                <div class=""style="height: 281px;">
                    <div class="col-6 f-l"style="padding: 0;">
                        <div class="data-con" id="data-con">
                            <div class="added-event" data-date="2017-6-19" data-time="Tüm Gün" data-title="WWDC 13 on San Francisco, LA"></div>
                            <div class="added-event" data-date="2017-6-20" data-time="20:45" data-title="Tarkan İstanbul Concert on Harbiye Açık Hava Tiyatrosu"></div>
                            <div class="added-event" data-date="2017-6-30" data-time="21:00" data-title="CodeCanyon İstanbul Meeting on Starbucks, Kadıköy"></div>
                            <div class="added-event" data-date="2017-7-19" data-time="22:00" data-title="Front-End Design and Javascript Conferance on Haliç Kongre Merkezi"></div>
                            <div class="added-event" data-date="2017-7-2" data-time="22:00" data-title="Lorem ipsum dolor sit amet"></div>
                        </div>
                    </div>
                    <div class="col-6 f-l bl mt-15" id="itemsWrap" style="padding: 0;">
                        <p class="lh-30 f-14 pl-15 pr-15 tabBarP3">
                            <a class="tabswitch  current"  >个人事项</a>
                            <a class="tabswitch " id="shixiang">公开事项</a>
                            <a onclick="resert()" hidden="hidden" id="seeAll" class="sfbtn sfbtn-opt f-r">查看全部</a>
                            <a onclick="resert2()" hidden="hidden" id="seeAll2" class="sfbtn sfbtn-opt f-r">查看全部</a>
                        </p>
                        <!-- <p class="f-r">
                    <a onclick="resert()" hidden="hidden" id="seeAll" class="sfbtn sfbtn-opt">查看全部</a>
                    </p> -->
                        <div class="itemList " id="itemList">
                            <ul>
                                <c:forEach items="${listDaiban }" var="dbList">

                                    <li>
                                        <div id="newDate"  class="${dbList.columns.id}">
                                            <p class="c-0e8ee7 f-13 lh-30 cl">
                                                    ${dbList.columns.trSatrtTime}-${dbList.columns.trEndTime}
                                                <a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu('${dbList.columns.id}')"><i class="sficon sficon-del "></i></a>
                                                <a class=" mt-3 f-r hide" title="编辑" onclick="bianji(' ${dbList.columns.id}','${dbList.columns.trSatrtTime }','${dbList.columns.trEndTime}','${dbList.columns.content}')"><i class="sficon sficon-edit"></i></a>
                                            </p>
                                            <p class="lh-20">${dbList.columns.content}</p>
                                        </div>
                                    </li>

                                </c:forEach>
                                <div id="newDate2">

                                </div>
                            </ul>
                        </div>
                        <div class="itemList hide" id="itemListOther">
                            <ul id="itemListOtherul">
                            </ul>
                        </div>
                        <div class="itemBox hide" id="itemBox">
                            <div class="mb-10 txtwrap1 pos-r">
                                <input type="hidden"  id="thisid"/>
                                <label class="lb">日期：</label>
                                <!-- <input type="text" onfocus="WdatePicker({mineDate:'#F{$dp.$D(\'datemin\')||\'%y-%M-%d\'}'})" id="datemin" name="datemin" class="input-text Wdate w-100"> -->
                                <input type="text" onFocus="WdatePicker({readOnly:true,lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" id="datemin" name="datemin" class="input-text Wdate w-100">
                                <select class="select w-60 va-m" id="startTime">
                                    <option value="00:00">0:00</option><option value="01:00">1:00</option><option value="02:00">2:00</option><option value="03:00">3:00</option><option value="04:00">4:00</option><option value="05:00">5:00</option><option value="06:00">6:00</option>
                                    <option value="07:00">7:00</option><option value="08:00">8:00</option><option value="09:00">9:00</option><option value="10:00">10:00</option><option value="11:00">11:00</option><option value="12:00">12:00</option><option value="13:00">13:00</option>
                                    <option value="14:00">14:00</option><option value="15:00">15:00</option><option value="16:00">16:00</option><option value="17:00">17:00</option><option value="18:00">18:00</option><option value="19:00">19:00</option><option value="20:00">20:00</option>
                                    <option value="21:00">21:00</option><option value="22:00">22:00</option><option value="23:00">23:00</option><option value="24:00">24:00</option>
                                </select> ~
                                <select class="select w-60 va-m" id="endTime">
                                    <option value="00:00">0:00</option><option value="01:00">1:00</option><option value="02:00">2:00</option><option value="03:00">3:00</option><option value="04:00">4:00</option><option value="05:00">5:00</option><option value="06:00">6:00</option>
                                    <option value="07:00">7:00</option><option value="08:00">8:00</option><option value="09:00">9:00</option><option value="10:00">10:00</option><option value="11:00">11:00</option><option value="12:00">12:00</option><option value="13:00">13:00</option>
                                    <option value="14:00">14:00</option><option value="15:00">15:00</option><option value="16:00">16:00</option><option value="17:00">17:00</option><option value="18:00">18:00</option><option value="19:00">19:00</option><option value="20:00">20:00</option>
                                    <option value="21:00">21:00</option><option value="22:00">22:00</option><option value="23:00">23:00</option><option value="24:00">24:00</option>
                                </select>
                            </div>
                            <div class="txtwrap1 pos-r mb-10 pr-15">
                                <label class="lb">事项：</label>
                                <textarea class="textarea" id="content"></textarea>
                            </div>
                            <div class="txtwrap1">
                                <a href="javascript:saveSiteSchedule();" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btn-save">保存</a>
                                <a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="btn-cancel">取消</a>
                            </div>
                            <!-- <a onclick="test()">数据测试</a> -->
                        </div>
                        <div class="itemBox hide" id="itemBox1">
                            <div class="itemList " id="itemList1">
                                <ul>
                                    <div id="newDate1">
                                        <%-- <li>
                                            <p class="c-0e8ee7 f-13 lh-30">${dbList.columns.trSatrtTime}-${dbList.columns.trEndTime}</p>
                                            <p class="lh-20">${dbList.columns.content}</p>
                                        </li> --%>
                                    </div>
                                </ul>
                            </div>
                        </div>
                        <div class="itemBox hide" id="itemBox2">
                            <div class="itemList " id="itemList2">
                                <ul>
                                    <div id="newDate3">
                                        <%-- <li>
                                            <p class="c-0e8ee7 f-13 lh-30">${dbList.columns.trSatrtTime}-${dbList.columns.trEndTime}</p>
                                            <p class="lh-20">${dbList.columns.content}</p>
                                        </li> --%>
                                    </div>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${userType eq '2' or (userType eq '3' && fns:strInStrs('ff03e62c82c855569b68089a199eurue', permissions, ','))}">
            <div class="f-l col-6" style="padding-left: 0px">
                <div class="radius modeBox">
                    <h2 class="boxHeader">预警消息 <a onclick="change()" id="changeYJ"  class="f-r c-white f-14">更多&gt;&gt;</a> </h2>
                    <div class="pt-15 pb-15">

                        <table id="table-waitdispatch" class="table table3">
                            <tr class="">
                                <th class="w-130 firstCol">
                                    <span class="icon_seq"></span>预警类型</th>
                                <th class="w-280">预警内容</th>
                                 <th class="w-60 text-c">状态</th> 
                                <th class="w-120 text-c">预警时间</th>

                            </tr>
                            <c:forEach items="${sitealarmlist }" var="alarm"   begin="0" end="3">
                                <c:if test="${alarm.columns.status==0 }">
                                    <input type="hidden" value="${alarm.columns.id }"/>
                                    <tr class="unread">
                                        <c:if test="${alarm.columns.type==1 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>工程师接单预警</td>
                                        </c:if>
                                        <c:if test="${alarm.columns.type==2 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>服务完成工单预警</td>
                                        </c:if>
                                        <c:if test="${alarm.columns.type==3 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>库存预警</td>
                                        </c:if>
                                        <c:if test="${alarm.columns.type==4 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>缺件预警</td>
                                        </c:if>
                                       <td>
	                                        <div class="wrap"  title="${alarm.columns.content }"  style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
	                                       	 	<a onclick="arlyWarningMsg(this,'${alarm.columns.id }')" class='c-0383dc'>${alarm.columns.content }</a>
	                                        </div>
                                        </td>
                                         <td class="text-c readState">未读</td>
                                        <td class="text-c">${alarm.columns.create_time }</td>
                                    </tr>
                                </c:if>


                                <c:if test="${alarm.columns.status==1 }">
                                    <input type="hidden" value="${alarm.columns.id }"/>
                                    <tr>
                                        <c:if test="${alarm.columns.type==1 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>工程师接单预警</td>
                                        </c:if>
                                        <c:if test="${alarm.columns.type==2 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>服务完成工单预警</td>
                                        </c:if>
                                        <c:if test="${alarm.columns.type==3 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>库存预警</td>
                                        </c:if>
                                        <c:if test="${alarm.columns.type==4 }">
                                            <td class="firstCol">
                                                <span class="icon_seq"></span>缺件预警</td>
                                        </c:if>
                                        <td>
	                                        <div class="wrap"  title="${alarm.columns.content }"  style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
	                                       	 	<a onclick="arlyWarningMsg(this,'${alarm.columns.id }')" class='c-0383dc'>${alarm.columns.content }</a>
	                                        </div>
                                        </td>

                                         <td class="text-c readState">已读</td>

                                        <td class="text-c">${alarm.columns.create_time }</td>
                                    </tr>
                                </c:if>

                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
        <div class="f-l col-6" style="padding-right: 0px;padding-left:0;">
            <div class="radius modeBox">
                <h2 class="boxHeader">系统公告<a onclick="changes()" href="#"  class="f-r c-white f-14">更多&gt;&gt;</a></h2>
                <div class="pt-15 pb-15">
                    <!-- <table class="table table3"> -->
                    <table id="table-waitdispatch2" class="table table3">

                        <tr class="">
                            <th class="w-160 firstCol">
                                <span class="icon_seq"></span>发布时间</th>
                            <th class="w-320">公告标题</th>
                            <th class="w-100 text-c">状态</th>

                        </tr>
                        <c:forEach begin="0"  end="3"  items="${announcementlist }" var="announce">
                            <c:if test="${announce.columns.flag==0 }">
                                <input type="hidden" value="${announce.columns.id }"/>
                                <tr class="unread">
                                    <td class="firstCol">
                                        <span class="icon_seq"></span>${announce.columns.create_time }</td>
                                    <td class="">
                                        <div class="wrap"  style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                                            <a onclick="updateMsg(this,'${announce.columns.id }')" class='c-0383dc'>${announce.columns.title }</a>
                                        </div>
                                    </td>
                                    <td class="text-c readState">未读</td>
                                </tr>
                            </c:if>

                            <c:if test="${announce.columns.flag==1 }">
                                <input type="hidden" value="${announce.columns.id }"/>
                                <tr>
                                    <td class="firstCol">
                                        <span class="icon_seq"></span>${announce.columns.create_time }</td>
                                    <td class="">
                                        <div class="wrap "  style="white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">
                                            <a onclick="updateMsg(this,'${announce.columns.id }')" class='c-0383dc'>${announce.columns.title }</a>
                                        </div>
                                    </td>

                                    <td class="text-c readState">已读</td>
                                </tr>
                            </c:if>

                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="popupBox sysNotice showNotice">
    <h2 class="popupHead">
        系统通知
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20">
            <h3 class="text-c lh-22 f-16"><strong class="title"></strong></h3>
            <p class="c-888 text-c lh-24 createTime"></p>
            <textarea class="mt-10 bk-blue-dotted noticeTxt" readonly="true" style="width: 100%">

			</textarea>
            <div class="text-c mt-20">
                <a href="javascript:;" class="sfbtn sfbtn-opt3 w-70" onclick="closed()">关闭</a>
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

<div class="popupBox sysNotice editeNotice">
	<h2 class="popupHead">
		修改公告
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pt-25 pr-25 pb-15">
			<div class="cl mb-10">
			<input type="hidden"  id="ids"/>
				<label class="w-80 text-r f-l">公告类型：</label>
				<select class="select w-140 f-l   editetype"   name="editetype">
					<option value="1">系统升级</option>
					<option value="2">功能说明</option>
					<option value="3">系统通知</option>
				</select>
			</div>
			<div class="pos-r pl-80 mb-10">
				<label class="w-80 text-r lb">公告标题：</label>
				<input type="text" class="input-text editetitle"   name="editetitle" id="editetitle"/>
			</div>
			<div class="pos-r pl-80 mb-10">
				<label class="w-80 text-r lb">公告内容：</label>
				<div class="" style="margin: 0 auto; width: 609px;">
					<div class="">
						<!-- 编辑器 -->
						<script id="container1" name="content1" type="text/plain">
       				 
   						</script>
						<textarea class="textarea h-50 hide addcontent" value="" id="html1" name="html1"></textarea>
					</div>
				</div>
			</div>
			<div class="cl mb-10">
				<label class="w-80 text-r f-l">发布时间：</label>
				<input type="text " onclick="WdatePicker()" id="bxdatemin" name="bxdatemin" value="" class="input-text Wdate w-140 editetime">
			</div>
			<div class="text-c mt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5 " id="btn-publish" onclick="edite()">修改</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="closed()">关闭</a>
			</div>
		</div>
	</div>
</div>
 <%-- <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/date.js"></script> --%>
  <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/date1.js"></script>
 <script src="${ctxPlugin}/static/h-ui.admin/js/popUp.js" type="text/javascript" charset="utf-8"></script>
 <script type="text/javascript" src="${ctxPlugin}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript">
    var userId = '${userId}';
    var array ='${listDate}' ;
    var dateItems = eval(array);
    var d = new Date();
    var recordDate = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate(); // 初始化
    var mark;
	
    $(function () {
    	//showCanalenderStyle();
    })
    
    function showCanalenderStyle(){
    	var dataIndex=$('.text');
		for(var i=0;i<dataIndex.length;i++){
		    var dateHtml=$(dataIndex[i]).html();
            var date=$(dataIndex[i]);
            if(dateHtml!=''){
            	// date.next().addClass('signRed');
                 date.next().next().addClass('noteDai');
            }
		} 
    }

    function closed(){

        $.closeDiv($(".showNotice"));
        //window.location.reload(true);
        //$.closeDiv($(".editOrigin"));
        search();

    }
    function showTab(tab){
        $.post("${ctx}/goods/sitePlatformGoods/distinct",function(result){
            if(result=="showPopup"){
                $(".vipPromptBox").popup();
                $('#Hui-article-box',window.top.document).css({'z-index':'9'});
            }else{
                $(".leftTopTab").hide();
                $(".tabswitch").removeClass("current");
                $(".tabswitch-" + tab).addClass("current");
                $(".tab-"+tab).show();
                if(tab == 'beijian'){
                    loadPeijianData();
                }
            }
        });
    }
    var dateTable= $('#data-con').calendar({ //日历
        dateItems:dateItems,
        nextMon:function(){//下一个月
            var nextmonurl="${ctx}/order/siteSchedule/backOrAhead";
            if(($("#shixiang").hasClass('current'))){
                nextmonurl="${ctx}/order/siteSchedule/backOrAheadother1";
            }else{
            }
            mark="1";
            $.ajax({
                type:"POST",
                url:nextmonurl,
                data:{recordDate:recordDate,
                    mark:mark},
                success:function(result){
                    if(eval(result).length>0){
                        dateItems = eval(result);
                        recordDate = dateItems[0].date;//获取查询到的日期数组的第一个值
                        dateTable.reload({dateItems:dateItems});
                    } else{
                        dateTable.reload({dateItems:[]});
                        $.ajax({
                                type:"POST",
                                url:"${ctx}/order/siteSchedule/recordDate",
                                data:{recordDate:recordDate,
                                    mark:mark},
                                success:function(result){
                                    recordDate = result;//当查询结果为空的时候根据当前的recordDate来加一个月所得到的日期
                                }
                            })
                        }
                    }

            })
        },
        preMon:function(){//前一个月
            mark="2";
            var premonurl="${ctx}/order/siteSchedule/backOrAhead";
            if(($("#shixiang").hasClass('current'))){
                premonurl="${ctx}/order/siteSchedule/backOrAheadother1";
            }else{
            }
            $.ajax({
                type:"POST",
                url:premonurl,
                data:{recordDate:recordDate,
                    mark:mark},
                success:function(result){
                    if(eval(result).length>0){
                        dateItems = eval(result);
                        recordDate = dateItems[0].date;//获取查询到的日期数组的第一个值
                        dateTable.reload({dateItems:dateItems});
                    }else{
                        dateTable.reload({dateItems:[]});
                        $.ajax({
                            type:"POST",
                            url:"${ctx}/order/siteSchedule/recordDate",
                            data:{recordDate:recordDate,
                                mark:mark},
                            success:function(result){
                                recordDate = result;//当查询结果为空的时候根据当前的recordDate来减一个月所得到的日期
                            }
                        })
                    }
                }
            })
        } ,clickEvent:function(dateVal){
        	if($.trim(dateVal)=='' || dateVal==null || dateVal==undefined){
        		layer.msg("获取日期失败，请重新点击！");
        		return false;
        	}
            $('#itemList').hide();
            $('#itemListOther').hide();
            $('#itemBox').hide();
            $('#itemBox2').hide();
            $('#btn-addItem').show();
            if(($("#shixiang").hasClass('current'))){
                $('#seeAll2').show();
                $('#seeAll').hide();
                //$('#btn-addItem').hide();
                $.ajax({
                    type:"POST",
                    url:"${ctx}/order/siteSchedule/dailyScheduleOther",
                    data:{compareDate:dateVal},
                    success:function(result){
                        $("#newDate1").empty();
                        if(result.length>0){
                            for(var i=0;i<result.length;i++){
                                $("#newDate1").prepend(getListHtml(result[i]));
                            }
                            $('#itemBox1').show();
                            $('#itemList1').show();
                        }
                    }
                })
            }else{
                $('#seeAll2').hide();
                $('#seeAll').show();
                $.ajax({
                    type:"POST",
                    url:"${ctx}/order/siteSchedule/dailySchedule",
                    data:{compareDate:dateVal},
                    success:function(result){
                        $("#newDate1").empty();
                        if(result.length>0){
                            for(var i=0;i<result.length;i++){
                                $("#newDate1").prepend('<li id='+"'"+result[i].columns.id+"'"+'>'+
                                    '<p class="c-0e8ee7 f-13 lh-30 cl">'+result[i].columns.trSatrtTime+'-'+result[i].columns.trEndTime+
                                    '<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''+result[i].columns.id+'\')"><i class="sficon sficon-del "></i></a>'+
                                    '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('+ "'"+result[i].columns.id+"',"+"'"+result[i].columns.trSatrtTime+"',"+"'"+result[i].columns.trEndTime+"',"+"'"+result[i].columns.content+"'"+')"><i class="sficon sficon-edit"></i></a>'+
                                    '</p>'+
                                    '<p class="lh-20">'+result[i].columns.content+'</p>'+
                                    '</li>');
                            }
                            $('#itemBox1').show();
                            $('#itemList1').show();
                        }
                    }
                })
            }



        }
    });
    
	$(function() {
		$.post("${ctx}/order/orderDispatch/ifShowAnounce", {},
				function(result) {
					if ("okShow" == result) {
						updateMsg('','');
					}
				});
		loadWelcomeData();
	});

	function getListHtml(result) {
		var html = "";
		if (result.columns.user_id == userId) {
			html = '<li id='+"'"+result.columns.id+"'"+'>'
					+ '<p class="c-0e8ee7 f-13 lh-30 cl">'
					+ result.columns.trSatrtTime
					+ '-'
					+ result.columns.trEndTime
					+ '<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''
					+ result.columns.id
					+ '\')"><i class="sficon sficon-del "></i></a>'
					+ '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('
					+ "'"
					+ result.columns.id
					+ "',"
					+ "'"
					+ result.columns.trSatrtTime
					+ "',"
					+ "'"
					+ result.columns.trEndTime
					+ "',"
					+ "'"
					+ result.columns.content
					+ "'"
					+ ')"><i class="sficon sficon-edit"></i></a>'
					+ '</p>'
					+ '<p class="lh-20">'
					+ result.columns.content
					+ '</p>'
					+ '</li>';
		} else {
			html = '<li id='+"'"+result.columns.id+"'"+'>'
					+ '<p class="c-0e8ee7 f-13 lh-30 cl">'
					+ result.columns.trSatrtTime + '-'
					+ result.columns.trEndTime + '('
					+ result.columns.create_name + ')' + '</p>'
					+ '<p class="lh-20">' + result.columns.content + '</p>'
					+ '</li>';
		}
		return html;
	}

	//     全部事项tab切换
	$('#itemsWrap .tabBarP3 .tabswitch').on('click', function() {
		$('#itemsWrap .tabBarP3 .tabswitch').removeClass('current');
		$(this).addClass('current');
		var thisIndex = $(this).index();
		$.ajax({
			type : "POST",
			url : "${ctx}/main/redirect/getOtherlistdate",
			data : {},
			success : function(result) {
				$("#newDate1").empty();
				$("#newDate3").empty();
				$("#itemListOtherul").empty();
				if (result.length > 0) {
					for (var i = 0; i < result.length; i++) {
						$("#itemListOtherul").prepend(getListHtml(result[i]));
					}
				}
			}
		})
		$('#itemsWrap .itemList').hide().eq(thisIndex).show();
		if (!($("#itemListOther").is(":hidden"))) {
			$('#itemBox').hide();
			//$('#btn-addItem').hide();
			$('#btn-addItem').show();
			$('#seeAll').hide();
			$('#itemBox2').hide();
			$('#itemBox1').hide();
			$.ajax({
				type : "POST",
				url : "${ctx}/main/redirect/getOtherlistTime",
				data : {},
				success : function(result) {
					$("#newDate1").empty();
					$("#newDate3").empty();
					if (result.length > 0) {
						array = result;
						dateItems = eval(array);
						dateTable.reload({
							dateItems : dateItems
						});
					}
				}
			})
		} else {
			$('#seeAll').hide();
			$('#btn-addItem').show();
			$('#itemBox2').hide();
			//showBox($('#itemList'),$('#itemBox1'),);
			$('#itemBox').hide();
			$('#itemBox1').hide();
			$.ajax({
				type : "post",
				url : "${ctx}/order/siteSchedule/newDate",
				data : {},
				success : function(result) {
					dateItems = eval(result);
					dateTable.reload({
						dateItems : dateItems
					});
				}
			});
		}
	})

	$('#btn-addItem').on('click', function() {
		$("#content").val("");
		$("#datemin").val("");
		$("thisid").val("");
		$(this).hide();
		$('#itemBox1').hide();
		$('#itemBox2').hide();
		$('#seeAll2').hide();
		$('#seeAll').show();
		$('#btn-addItem').show();
		$('#itemListOther').hide();
		showBox($('#itemList'), $('#itemBox1'), $('#itemBox'));

	});

	$('#btn-cancel').on('click', function() {
		$("#datemin").val("");
		$("#content").val("");
		$("#startTime").val("");
		$("#endTime").val("");
		$('#btn-addItem').show();
		$('#seeAll').hide();
		$('#seeAll2').hide();
		if (($("#shixiang").hasClass('current'))) {
			showBox($('#itemBox'), $('#itemBox1'), $('#itemListOther'));
		} else {
			showBox($('#itemBox'), $('#itemBox1'), $('#itemList'));
		}

	});

	function showBox(obj1, obj2, obj3) {
		obj1.hide();
		obj2.hide();
		obj3.show();
	}

	function loadWelcomeData() {
		var isPeijianMan = '${isPeijianMan}';
		$.post("${ctx}/commonAjax/getMessengerWelcomeData", {},
				function(result) {
					$("#jrjd_wct").text(result.jrjd);
					$("#jryy_wct").text(result.jryy);
					$("#ylgd_wct").text(result.ylgd);
					$("#fwz_wct").text(result.fwz);
					$("#djd_wct").text(result.djd);
					$("#dpg_wct").text(result.dpg);
					$("#qjz_wct").text(result.qjz);
					$("#ywg_wct").text(result.ywg);
					$("#jr_order").text(result.jrgd);
					$("#fwz_order").text(result.fwz);
					$("#jrtx_order").text(result.jrtx);
				});
	}

	function loadPeijianData() {
		$.post("${ctx}/commonAjax/getPeijianWelcomeData", {}, function(result) {
			$("#dck_bj").text(result.dck);
			$("#qjz_bj").text(result.qjz);
			$("#dsh_bj").text(result.dsh);
		});
	}

	function resert() {
		$('#itemBox').hide();
		$('#itemBox1').hide();
		$('#itemBox2').hide();
		$('#seeAll').hide();
		$('#seeAll2').hide();

		$
				.ajax({
					type : "POST",
					url : "${ctx}/order/siteSchedule/allSchedule",
					data : {},
					success : function(result) {
						$("#newDate1").empty();
						$("#newDate3").empty();
						if (result.length > 0) {
							for (var i = 0; i < result.length; i++) {
								$("#newDate3")
										.prepend(
												'<li id='+"'"+result[i].columns.id+"'"+'>'
														+ '<p class="c-0e8ee7 f-13 lh-30 cl">'
														+ result[i].columns.trSatrtTime
														+ '-'
														+ result[i].columns.trEndTime
														+ '<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''
														+ result[i].columns.id
														+ '\')"><i class="sficon sficon-del "></i></a>'
														+ '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('
														+ "'"
														+ result[i].columns.id
														+ "',"
														+ "'"
														+ result[i].columns.trSatrtTime
														+ "',"
														+ "'"
														+ result[i].columns.trEndTime
														+ "',"
														+ "'"
														+ result[i].columns.content
														+ "'"
														+ ')"><i class="sficon sficon-edit"></i></a>'
														+ '</p>'
														+ '<p class="lh-20">'
														+ result[i].columns.content
														+ '</p>' + '</li>');
							}
							$('#itemBox2').show();
							$('#itemList2').show();
						}
					}
				})
	}

	function resert2() {
		$('#itemBox').hide();
		$('#itemBox1').hide();
		$('#itemBox2').hide();
		$('#seeAll').hide();
		$('#seeAll2').hide();

		$.ajax({
			type : "POST",
			url : "${ctx}/order/siteSchedule/allOtherSchedule",
			data : {},
			success : function(result) {
				$("#newDate1").empty();
				$("#newDate3").empty();
				if (result.length > 0) {
					for (var i = 0; i < result.length; i++) {
						$("#newDate3").prepend(getListHtml(result[i]));
					}
					$('#itemBox2').show();
					$('#itemList2').show();
				}
			}
		})
	}

	function bianji(id, starttime, endtime, content) {
		if (endtime.length < 5) {
			endtime = "0" + endtime
		}
		var startdate = starttime.substr(0, 10);
		var startdate2 = starttime.substr(11, 5);
		if (startdate2.endsWith(":")) {
			startdate2 = "0" + startdate2;
			startdate2 = startdate2.substr(0, 5);
		}
		$("#content").val(content);
		$("#datemin").val(startdate);
		$("#startTime").val(startdate2);
		$("#endTime").val(endtime)
		$("#thisid").val(id);
		$(this).hide();
		$('#itemBox1').hide();
		$('#itemBox2').hide();
		$('#seeAll').show();
		$('#btn-addItem').show();
		$('#itemListOther').hide();
		showBox($('#itemList'), $('#itemBox1'), $('#itemBox'));
	}
	function saveSiteSchedule() {//保存服务商新增的待办事项
		var types;
		if (($("#shixiang").hasClass('current'))) {
			types = '1'
		} else {
			types = '0'
		}
		var id = $("#thisid").val();
		var content = $("#content").val();
		var date = $("#datemin").val();
		var stTime = $("#startTime").find("option:selected").text();
		var edTime = $("#endTime").find("option:selected").text();
		var startTime1 = date + " " + stTime + ":00";
		var endTime1 = date + " " + edTime + ":00";
		var a1 = Date.parse(new Date(startTime1));
		var a2 = Date.parse(new Date(endTime1));
		if (date == "" || date == null) {
			layer.msg("请填写日期");
			return;
		} else if ($.trim(content) == "" || $.trim(content) == null) {
			/*  $('body').popup({
			      level:'3',
			      type:1,
			      content:"请填写事项！"
			  })*/
			layer.msg("请填写事项！");
			return;
		} else {
			if (a1 >= a2) {
				layer.msg("开始时间必须小于结束时间！");
				return;
			} else {
				var sg = "sg";
				$
						.ajax({
							type : "POST",
							url : "${ctx}/order/siteSchedule/saveSiteSchedule",
							data : {
								id : id,
								type : types,
								content : content,
								startTime : startTime1,
								endTime : endTime1
							},
							success : function(result) {
								if (result.result == "ok2") {
									layer.msg("添加成功");
									if (($("#shixiang").hasClass('current'))) {
										$("#itemListOtherul")
												.prepend(
														'<li id='+"'"+result.id+"'"+'>'
																+ '<p class="c-0e8ee7 f-13 lh-30">'
																+ startTime1
																+ '-'
																+ edTime
																+ '<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''
																+ result.id
																+ '\')"><i class="sficon sficon-del "></i></a>'
																+ '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('
																+ "'"
																+ result.id
																+ "',"
																+ "'"
																+ startTime1
																+ "',"
																+ "'"
																+ endTime1
																+ "',"
																+ "'"
																+ content
																+ "'"
																+ ')"><i class="sficon sficon-edit"></i></a>'
																+ '</p>'
																+ '<p class="lh-20">'
																+ content
																+ '</p>'
																+ '</li>');
									} else {
										$("#newDate2")
												.prepend(
														'<li id='+"'"+result.id+"'"+'>'
																+ '<p class="c-0e8ee7 f-13 lh-30">'
																+ startTime1
																+ '-'
																+ edTime
																+ '<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''
																+ result.id
																+ '\')"><i class="sficon sficon-del "></i></a>'
																+ '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('
																+ "'"
																+ result.id
																+ "',"
																+ "'"
																+ startTime1
																+ "',"
																+ "'"
																+ endTime1
																+ "',"
																+ "'"
																+ content
																+ "'"
																+ ')"><i class="sficon sficon-edit"></i></a>'
																+ '</p>'
																+ '<p class="lh-20">'
																+ content
																+ '</p>'
																+ '</li>');
									}
									$("#content").val("");
									$("#datemin").val("");

									$('#btn-addItem').show();
									$('#seeAll2').hide();
									$('#seeAll').hide();
									if (($("#shixiang").hasClass('current'))) {
										showBox($('#itemBox'), $('#itemBox1'),
												$('#itemListOther'));
									} else {
										showBox($('#itemBox'), $('#itemBox1'),
												$('#itemList'));
									}
								} else if (result.result = "ok1") {
									layer.msg("修改成功");
									var newid = id.trim();
									if (($("#shixiang").hasClass('current'))) {
										$("#" + newid + " p.f-13").text(
												startTime1 + '-' + edTime);
										$("#" + newid + " p.lh-20").text(
												content);
										$("#" + newid + " p.f-13")
												.prepend(
														'<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''
																+ newid
																+ '\')"><i class="sficon sficon-del "></i></a>'
																+ '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('
																+ "'"
																+ newid
																+ "',"
																+ "'"
																+ startTime1
																+ "',"
																+ "'"
																+ edTime
																+ "',"
																+ "'"
																+ content
																+ "'"
																+ ')"><i class="sficon sficon-edit"></i></a>');
									} else {
										$("div." + newid + " p.f-13").text(
												startTime1 + '-' + edTime);
										$("div." + newid + " p.lh-20").text(
												content);
										$("div." + newid + " p.f-13")
												.prepend(
														'<a class="mt-3 ml-5 f-r hide" title="删除"  onclick="shanchu(\''
																+ newid
																+ '\')"><i class="sficon sficon-del "></i></a>'
																+ '<a class=" mt-3 f-r hide" title="编辑" onclick="bianji('
																+ "'"
																+ newid
																+ "',"
																+ "'"
																+ startTime1
																+ "',"
																+ "'"
																+ edTime
																+ "',"
																+ "'"
																+ content
																+ "'"
																+ ')"><i class="sficon sficon-edit"></i></a>');
									}
									$("#content").val("");
									$("#datemin").val("");
									$('#btn-addItem').show();
									$('#seeAll').hide();
									$('#seeAll2').hide();
									$("#itemBox").css("display", 'none');
									//showBox($('#itemBox'),$('#itemBox1'),$('#itemList'));
									if (($("#shixiang").hasClass('current'))) {
										showBox($('#itemBox'), $('#itemBox1'),
												$('#itemListOther'));
									} else {
										showBox($('#itemBox'), $('#itemBox1'),
												$('#itemList'));
									}
									$("#thisid").val("");
								} else {
									layer.msg("添加失败，请联系管理员！");
									return;
								}
							},
							complete : function() {
								var dateUrl2 = "${ctx}/order/siteSchedule/newDate";
								if (($("#shixiang").hasClass('current'))) {
									dateUrl2 = "${ctx}/main/redirect/getOtherlistTime"
								} else {
								}
								$.ajax({
									type : "post",
									url : dateUrl2,
									data : {},
									success : function(result) {
										dateItems = eval(result);
										dateTable.reload({
											dateItems : dateItems
										});
									}
								});
							}
						})
			}
		}
	}

	function shanchu(id) {
		var dateUrl = "${ctx}/order/siteSchedule/newDate";
		if (($("#shixiang").hasClass('current'))) {
			dateUrl = "${ctx}/main/redirect/getOtherlistTime"
		} else {
		}
		var content = "确定要删除该事项？";
		$('body').popup({
			level : "3",
			title : "删除",
			content : content,
			fnConfirm : function() {
				$.ajax({
					type : "POST",
					url : "${ctx}/order/siteSchedule/deleteSiteSchedule",
					traditional : true,
					data : {
						"id" : id
					},
					success : function(data) {
						if (data = "ok") {
							layer.msg("删除完成!", {
								time : 2000
							});
							//window.location.reload(true);
							var newid = id.trim();
							$("#" + newid).remove();
							$("div." + newid).remove();
							$("#newDate1>li#" + newid).remove();
							$("#newDate2>li#" + newid).remove();
							$("#newDate3>li#" + newid).remove();
							$.ajax({
								type : "post",
								url : dateUrl,
								data : {},
								success : function(result) {
									dateItems = eval(result);
									dateTable.reload({
										dateItems : dateItems
									});
								}
							});
						} else {
							layer.msg("操作失败!", {
								time : 2000
							});
						}
					},
					error : function() {
						layer.alert("系统繁忙!");
						return;
					}
				});
				layer.closeAll('dialog');
			}
		});
	}

	function test() {
		$.ajax({
			type : "post",
			url : "${ctx}/order/siteSchedule/test",
			data : {},
			success : function() {

			}
		})
	}

	function change() {//
		$.post("${ctx}/goods/sitePlatformGoods/distinct", function(result) {
			if (result == "showPopup") {
				var a = document.getElementById("changeYJ");
				a.removeAttribute("href");
				$(".vipPromptBox").popup();
				$('#Hui-article-box', window.top.document).css({
					'z-index' : '9'
				});
			} else {
				parent.jumpToMenuItem("运营管理", "系统预警消息");
			}
		});

	}
	function changes() {
		parent.jumpToMenuItem("运营管理", "系统公告");
	}

	function jumpToJryu() {
		selectModuleOnFly("工单管理", "待派工工单", "${ctx}/order/getWwgList/jryy",
				"${ctx}/order/getWwgList");
	}

	function jumpToJrtx() {
		selectModuleOnFly("工单管理", "全部工单", "${ctx}/order/jrtxbj",
				"${ctx}/order/Whole");
	}

	function jumpToFwz() {
		parent.jumpToMenuItem("工单管理", "服务中工单");
	}

	function jumpToDpg() {
		parent.jumpToMenuItem("工单管理", "待派工工单");
	}

	function jumpToJrgd() {
		parent.jumpToMenuItem("工单管理", "全部工单");
	}

	function jumpToQjz() {
		selectModuleOnFly("工单管理", "服务中工单", "${ctx}/order/getWwgList/djgd",
				"${ctx}/order/during");
	}

	function jumpToVIP() {
		layer.open({
			type : 2,
			content : '${ctx}/goods/sitePlatformGoods/jumpVIP',
			title : false,
			area : [ '100%', '100%' ],
			closeBtn : 0,
			shade : 0,
			anim : -1
		});
	}
	
	function updateMsg(obj,id){
        $(obj).parent("div").parent("td").parent("tr").removeClass("unread");
        $(obj).parent("div").parent("td").parent("tr").find(".readState").text("已读");
		layer.open({
			type : 2,
			content : '${ctx}/order/orderDispatch/showLatestAnnounce?id='+id,
			title : false,
			area : [ '100%', '100%' ],
			closeBtn : 0,
			shade : 0,
			anim : -1
		});
	}
	
	function arlyWarningMsg(obj,id){
        $(obj).parent("div").parent("td").parent("tr").removeClass("unread");
        $(obj).parent("div").parent("td").parent("tr").find(".readState").text("已读");
		layer.open({
			type : 2,
			content : '${ctx}/order/orderDispatch/showearlyWarningAnnounce?id='+id,
			title : false,
			area : [ '100%', '100%' ],
			closeBtn : 0,
			shade : 0,
			anim : -1
		});
	}

	function isBlank(obj){
	    if(obj==null || obj == 'undefind' || obj == ''){
            return true;
        }else{
            return false;
        }
    }

	function closeLoadBg(){
		$('#loadBg').remove();
	}
</script>
</body>
</html>
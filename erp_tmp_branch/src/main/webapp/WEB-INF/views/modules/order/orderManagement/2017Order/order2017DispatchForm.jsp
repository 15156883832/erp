<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>工单录入</title>
    <meta name="decorator" content="base"/>

    <link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/>
    <script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>

    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb">
    <h2 class="popupHead">
        工单详情
        <a href="javascript:;" class="sficon closePopup" ></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pos-r" >
            <div class="pcontent">
                <div id="detialWd">
                    <div class="tabBarP" style="overflow: visible;">
                        <a href="javascript:;" class="tabswitch current">基本信息</a>
                        <a href="javascript:;" class="tabswitch ">过程信息</a>
                        <c:if test="${count != 0 }">
                            <a  class="tooltipLink f-r" onclick="changeStyle('${order.number}')"  >
                                <i class="sficon sficon-note"></i>已发送<span class="va-t">${count }</span>条短信
                            </a>
                        </c:if>
                        <c:if test="${order.printTimes != 0 }">
                            <a  class="tooltipLink f-r" >
                                <i class="sficon sficon-print"></i>已打印<span class="va-t">${order.printTimes }</span>次
                            </a>
                        </c:if>
                        <c:if test="${order.bdImgs ne null }">
                            <a class="f-r c-f55025 underline f-14 mr-40" id="btn_showImg">查看微信报单图片</a>
                            <div class="hide" id="wxImgList">
                                <c:forEach items="${bdImgs }" var="lts">
                                    <img alt="" src="${commonStaticImgPath}${lts}">
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                    <form id="updateOrder" action="${ctx}/order/orderDispatch/update" method="post">
                        <div class="tabCon pt-10">
                            <div class="cl mb-10 mt-10">
                                <input type="hidden" name="id" value="${order.id}">
                                <div class="f-l ">
                                    <label class="f-l w-100">工单编号：</label>
                                    <input type="text" id="orderNumber" class="input-text w-160 readonly dischange" readonly="readonly" name="number" value="${order.number }"/>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="lb w-100"><em class="mark"></em>服务类型：</label>
                                    <select id="serviceType"  disabled="disabled" name="serviceType" class="select w-120 readonly">
                                        <c:forEach items="${fns:getServiceTypeWithDefault(order.serviceType) }" var="serm">
                                            <c:if test="${order.serviceType eq serm.columns.name }">
                                                <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
                                            </c:if>

                                            <c:if test="${order.serviceType ne  serm.columns.name }">
                                                <option value="${serm.columns.name }">${serm.columns.name }</option>
                                            </c:if>
                                        </c:forEach>

                                    </select>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="w-80 pos"><em class="mark"></em>服务方式：</label>
                                    <select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-120 readonly ">
                                        <c:forEach items="${fns:getServiceModeWithDefault(order.serviceMode) }" var="serm">
                                            <c:if test="${order.serviceMode eq serm.columns.name }">
                                                <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
                                            </c:if>
                                            <c:if test="${order.serviceMode ne  serm.columns.name }">
                                                <option value="${serm.columns.name }">${serm.columns.name }</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="w-80 pos"><c:if test="${mustfill.columns.origin}"><em class="mark"></em></c:if>信息来源：</label>
                                    <select id="origin" name="origin"  disabled="disabled" class="select w-120 readonly hide">
                                        <c:choose>
                                            <c:when test="${fn:contains(listoriginlist,order.origin)}">

                                                <option value="">请选择</option>
                                                <c:forEach items="${listorigin}" var="serm">
                                                    <c:if test="${order.origin eq serm.columns.name }">
                                                        <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
                                                    </c:if>

                                                    <c:if test="${order.origin ne  serm.columns.name }">
                                                        <option value="${serm.columns.name }">${serm.columns.name }</option>
                                                    </c:if>
                                                </c:forEach>

                                            </c:when>

                                            <c:otherwise>
                                                <option value="">请选择</option>
                                                <option value="${order.origin}" selected="selected">${order.origin }</option>
                                                <c:forEach items="${listorigin}" var="serm">
                                                    <option value="${serm.columns.name }">${serm.columns.name }</option>
                                                </c:forEach>

                                            </c:otherwise>

                                        </c:choose>

                                    </select>
                                </div>
                                <c:if test="${order.recordAccount=='1' }">
                                    <a class="f-r c-0383dc lh-26 pr-10" id="btn_More" onclick="showMore(this)">展开</a>
                                </c:if>
                            </div>
                            <div class="cl mb-10 hide" id="moreConWrap">
                                <div class="f-l ">
                                    <label class="w-100 f-l"><em class="mark"></em>厂家工单编号：</label>
                                    <input type="text" id="factoryNumber" class="input-text w-160 readonly " maxlength="32" readonly="readonly" name="factoryNumber" value="${order.factoryNumber }"/>
                                </div>
                            </div>

                            <div class="line"></div>
                            <div class="cl mt-10">
                                <div class="f-l ">
                                    <label class="f-l w-100"><em class="mark"></em>用户姓名：</label>
                                    <input type="text" id="customerName" class="input-text w-160 readonly" readonly="readonly" name="customerName"  value="${order.customerName }"/>
                                    <input type="hidden" class="input-text w-140" id="sign"   value=""/>
                                    <input type="hidden" class="input-text w-140"  id="siteMsgNums" value=""/>
                                </div>
                                <div class="f-l pos-r pl-100">
							<span class="lb w-100" id="mobileType">
								<label class="lb w-100 text-r">联系方式1：</label>
							</span>
                                    <input type="text" id="customerMobile" class="input-text w-120 readonly f-l" readonly="readonly" name="customerMobile" value="${order.customerMobile }"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="w-80 pos">联系方式2：</label>
                                    <input type="text" id ="customerTelephone" class="input-text w-120 readonly" readonly="readonly" name="customerTelephone"  value="${order.customerTelephone }"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="w-80 pos">联系方式3：</label>
                                    <input type="text" id="customerTelephone2" class="input-text w-120 readonly" readonly="readonly" name="customerTelephone2" value="${order.customerTelephone2 }"/>
                                </div>
                            </div>
                            <div class="cl mt-10 mb-10">
                                <div class="f-l" id="pcd">
                                    <label class="w-100 f-l"><em class="mark"></em>详细地址：</label>
                                    <%--<span class="select-box w-90 f-l mr-10 mustfill" id="showProvince" style="display:none">
                                    <select class="prov select" id="province"></select>
                                    </span>
                                    <span class="select-box w-90 f-l mr-10 mustfill" id="showCity" style="display:none">
                                    <select class="city select" id="city" disabled="disabled"></select>
                                    </span>
                                    <span class="select-box w-90 f-l mr-10 mustfill" id="showArea" style="display:none">
                                    <select class="dist select" id="area" disabled="disabled"></select>
                                    </span>--%>
                                    <input type="text" class="input-text readonly w-580 f-l" readonly="readonly" id="customerAddress1" name="customerAddress1" autocomplete="off" value="<c:out value='${order.customerAddress}'/>"/>
                                    <input type="hidden" id="customerAddress" name="customerAddress" value="<c:out value='${order.customerAddress}'/>"/>
                                    <input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
                                </div>
                            </div>
                            <div class="line"></div>
                            <div class="cl mt-10" id="styleMArk">
                                <div class="f-l" style="height:26px">
                                    <label class="f-l w-100"><em class="mark"></em>家电品牌：</label>
                                    <select  disabled="disabled"  class="select w-160 readonly " name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择品类！">
                                        <c:choose>
                                            <c:when test="${fn:contains(brandlist,order.applianceBrand)}">
                                                <option value="">请选择</option>
                                                <c:forEach items="${brand}" var="ba" varStatus="cast">
                                                    <c:if test="${order.applianceBrand eq ba.value  }">
                                                        <option value="${ba.key }" selected="selected">${ba.value }</option>
                                                    </c:if>
                                                    <c:if test="${order.applianceBrand ne ba.value }">
                                                        <option value="${ba.key }">${ba.value }</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>


                                            <c:otherwise>
                                                <option value="">请选择</option>
                                                <option value="${order.applianceBrand}" selected="selected">${order.applianceBrand}</option>
                                                <c:forEach items="${brand}" var="ba" varStatus="cast">
                                                    <option value="${ba.key }">${ba.value }</option>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                                <div class="f-l pos-r pl-100" style="height:26px">
                                    <label class="pos w-100"><em class="mark"></em>家电品类：</label>
                                    <select class="select w-120 readonly" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择品类！"  disabled="disabled">
                                        <c:choose>
                                            <c:when test="${fn:contains(catelist,order.applianceCategory)}">
                                                <option value="">请选择</option>

                                                <c:forEach items="${category}" var="cad" varStatus="cast1">
                                                    <c:if test="${order.applianceCategory eq cad.columns.name  }">
                                                        <option value="${cad.columns.name }" selected="selected">${cad.columns.name}</option>
                                                    </c:if>

                                                    <c:if test="${order.applianceCategory ne cad.columns.name }">
                                                        <option value="${cad.columns.name }">${cad.columns.name }</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:when>


                                            <c:otherwise>
                                                <option value="">请选择</option>
                                                <option value="${order.applianceCategory}" selected="selected">${order.applianceCategory}</option>
                                                <c:forEach items="${category}" var="cad" varStatus="cast1">
                                                    <option value="${cad.columns.name }">${cad.columns.name }</option>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="w-80 pos"><c:if test="${mustfill.columns.promiseTime}"><em class="mark"></em></c:if>预约日期：</label>
                                    <input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text Wdate w-120 readonly ptime" disabled="disabled" name="promiseTime" id="promiseTime" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="w-80 pos"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark"></em></c:if>时间要求：</label>
                                    <select id="promiseLimit" class="select w-120 readonly " name="promiseLimit"  disabled="disabled">
                                        <option value="">请选择</option>
                                        <c:forEach items="${proLimitList}" var="serm">
                                            <c:if test="${order.promiseLimit eq serm }">
                                                <option value="${serm }" selected="selected" >${serm }</option>
                                            </c:if>

                                            <c:if test="${order.promiseLimit ne  serm }">
                                                <option value="${serm }">${serm }</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="cl mt-10">
                                <div class="f-l h-50">
                                    <label class="f-l w-100"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark"></em></c:if>服务描述：</label>
                                    <textarea type="text" class="input-text w-380 h-50 readonly" readonly="readonly" id="customerFeedback" name="customerFeedback">${order.customerFeedback}</textarea>
                                </div>
                                <div class="f-l pl-80 pos-r h-50">
                                    <label class="pos w-80"><c:if test="${mustfill.columns.remarks}"><em class="mark"></em></c:if>备注：</label>
                                    <textarea type="text" class="input-text h-50 w-320 readonly" readonly="readonly" id="remark" name="remarks" >${order.remarks}</textarea>
                                </div>
                            </div>


                            <div class="cl mt-10">
                                <div class="f-l ">
                                    <label class="f-l w-100"><c:if test="${mustfill.columns.applianceModel}"><em class="mark"></em></c:if>产品型号：</label>
                                    <input type="text" class="input-text w-160 readonly" readonly="readonly" id="applianceModel" name="applianceModel" value="${order.applianceModel}"/>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="pos w-100"><c:if test="${mustfill.columns.applianceNum}"><em class="mark"></em></c:if>产品数量：</label>
                                    <input type="text" class="input-text w-120 readonly" readonly="readonly" id="applianceNum" name="applianceNum" value="${order.applianceNum }"/>
                                </div>
                                <div class="f-l pos-r pl-80 wrapss">
                                    <label class="w-80 pos"><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark"></em></c:if>内机条码：</label>
                                    <input type="text" class="input-text w-178 readonly" maxlength="100" style="width:180px;"  readonly="readonly" id="applianceBarcode" name="applianceBarcode" value="${order.applianceBarcode}" title="${order.applianceBarcode}"/>
                                    <span class="weishu1" hidden="hidden">
								( <span id="incodeNum">0</span>位 )
							</span>
                                    <span class="ml-2 code1" hidden="hidden">
								<a href="javascript:showQRCode('${order.siteId }','1');" class="sficon sficon-scancode"></a>
							</span>
                                    <span class="va-t underline c-fe0101 codeConnectShow cPointer " preData="${order.applianceBarcode}"  id="codeInshow"></span >
                                </div>
                            </div>
                            <div class="cl mt-10">
                                <div class="f-l ">
                                    <label class="w-100 f-l"><c:if test="${mustfill.columns.applianceBuyTime}"><em class="mark"></em></c:if>购买日期：</label>
                                    <input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })" class="input-text w-160 readonly ptime" disabled="disabled" id="applianceBuyTime" name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
                                </div>
                                <div class="f-l pos-r pl-100">

                                    <c:choose>
                                        <c:when test="${not empty malllist}">
                                            <label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
                                            <span class="w-120">
									<select class="select ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" disabled="diabled"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										<c:forEach items="${malllist }" var="mall">
                                            <option value="${mall.columns.mall_name } " ${order.pleaseReferMall eq mall.columns.mall_name ?'selected':''}>${mall.columns.mall_name }</option>
                                        </c:forEach>
									</select>
								</span>
                                        </c:when>
                                        <c:otherwise>
                                            <label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
                                            <input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-120 ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" readonly="readonly" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
                                        </c:otherwise>
                                    </c:choose>


                                    <%--<label class="pos w-100 "><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark"></em></c:if>购机商场：</label>
                                    <input type="text" id="pleaseReferMall" name="pleaseReferMall" class="input-text w-120 readonly" readonly="readonly" value="${order.pleaseReferMall}">--%>
                                </div>
                                <div class="f-l pos-r pl-80 wrapss">
                                    <label class="w-80 pos"><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark"></em></c:if>外机条码：</label>
                                    <input type="text" class="input-text  readonly" style="width:180px;" readonly="readonly"  id="applianceMachineCode" name="applianceMachineCode" value="${order.applianceMachineCode}" title="${order.applianceMachineCode}"/>
                                    <span class="ml-2 mr-2 weishu2" hidden="hidden">
								( <span id="outcodeNum">0</span>位 )
							</span>
                                    <span class="ml-2 mr-2 code2"  hidden="hidden">
								<a href="javascript:showQRCode('${order.siteId }','2');" class="sficon sficon-scancode"></a>
							</span>
                                    <span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}"  id="codeOutshow"></span>
                                </div>
                            </div>
                            <div class="cl mt-10 mb-10">
                                <div class="f-l ">
                                    <label class="w-100 f-l"><c:if test="${mustfill.columns.warrantyType}"><em class="mark"></em></c:if>保修类型：</label>
                                    <span class="select-box w-160">
								<select class="select readonly " name="warrantyType"  disabled="disabled" id="warrantyType">
									<option value="">请选择</option>
									<c:if test="${order.warrantyType eq '1' }">
                                        <option value="1" selected = "selected">保内</option>
                                        <option value="2">保外</option>
                                    </c:if>
									<c:if test="${order.warrantyType eq '2' }">
                                        <option value="1">保内</option>
                                        <option value="2" selected = "selected">保外</option>
                                    </c:if>
									<c:if test="${order.warrantyType ne '1' && order.warrantyType ne '2'}">
                                        <option value="1">保内</option>
                                        <option value="2">保外</option>
                                    </c:if>
								</select>
							</span>
                                </div>
                                <div class="f-l pos-r pl-100">
                                    <label class="w-100 pos"><c:if test="${mustfill.columns.level}"><em class="mark"></em></c:if>重要程度：</label>
                                    <select class="select w-120 readonly" name="level" id="level"  disabled="disabled">
                                        <option value="">请选择</option>
                                        <c:choose>
                                            <c:when test="${order.level eq '1'}">
                                                <option value="1" selected ="selected">紧急</option>
                                                <option value="2">一般</option>
                                            </c:when>
                                            <c:when test="${order.level eq '2'}">
                                                <option value="1">紧急</option>
                                                <option value="2" selected ="selected">一般</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="1">紧急</option>
                                                <option value="2">一般</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                    </span>
                                </div>
                                <div class="f-l ">
                                    <label class="f-l w-80">报修时间：</label>
                                    <input type="text" class="input-text w-130 readonly dischange" readonly="readonly" name="repairTime" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
                                </div>
                                <div class="f-l pos-r pl-80">
                                    <label class="pos w-80">登记人：</label>
                                    <input type="text" class="input-text w-110 readonly dischange" readonly="readonly" name="messengerName" value="${order.xm}"/>
                                </div>
                            </div>
                            <%-- <div class="lh-20 pl-25 f-14">
                                <div  id="codeShow" hidden="hidden">
                                    <i class="sficon sficon-note"></i>
                                    <span class="codeIn" hidden="hidden">该内机条码<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceBarcode}"  id="codeInshow"></span >记录<span class="douhao">，</span></span>
                                    <span class="codeOut" hidden="hidden">该外机条码<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}"  id="codeOutshow"></span>记录</span>
                                </div>
                            </div>  --%>
                        </div>
                        <div class="tabCon pt-10">
                            <div class="processWrap">
                                <c:forEach var="pros" items="${fns:getOrderProcess(order.processDetail)}">
                                    <p class="processItem">
                                        <span class="time">${pros.time}</span>
                                        <span>${pros.content}</span>
                                    </p>
                                </c:forEach>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="btnMenubox pb-80">
                    <c:if test="${'0' ne order.status}">
                        <%--<c:if test="${'7' ne order.orderType}">--%>
                            <!-- 小厂家派过来的工单是不能修改，不能无效的 -->
                            <%--      <sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input id="xggd" class="sfbtn sfbtn-opt" value="修改工单" type="button" />'></sfTags:pagePermission>
                              </c:if>
                              <input class="sfbtn sfbtn-opt sbtn" value="派工" type="button" onclick="directDis()"/>
                              <input class="sfbtn sfbtn-opt notDispatch sbtn" onclick=showzbpg() id="zbpg" value="暂不派工" type="button" />
                              <c:if test="${'7' ne order.orderType}">
                                  <input class="sfbtn sfbtn-opt sbtn" onclick=showwxgd('${order.orderType}') value="无效工单" type="button"/>
                              </c:if>
                              <input class="sfbtn sfbtn-opt sbtn" value="短信通知"  onclick="senMagPopup('${order.id}')" type="button" />
                              <input class="sfbtn sfbtn-opt sbtn" id="repeteWrite" type="button" value="打印工单" target="_blank" onclick="dygd('${order.id}')" />
                              <input class="sfbtn sfbtn-opt sbtn" id="repeatOrder_custom"  type="button" onclick="dygdcustom('${order.id}')" value="打印工单" style="display: none;"/>--%>
                        <input class="sfbtn sfbtn-opt sbtn" value="新建工单" type="button" onclick="newOrder('${order.id}')"/>
                    </c:if>
                    <c:if test="${('0' eq order.status) and ('7' ne order.orderType)}">
                        <!--二级网点-->
                      <%--  <sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_RECV_ORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="接单" type="button" onclick="jd(\'${order.id}\')"/>'></sfTags:pagePermission>
                        <sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_REFUSE_ORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="拒单" type="button" onclick="refuseOrder(\'${order.id}\')"/>'></sfTags:pagePermission>
                        <input class="sfbtn sfbtn-opt sbtn" id="repeteWrite" type="button" value="打印工单" target="_blank" onclick="dygd('${order.id}')" />
                        <input class="sfbtn sfbtn-opt sbtn" id="repeatOrder_custom"  type="button" onclick="dygdcustom('${order.id}')" value="打印工单" style="display: none;"/>--%>
                    </c:if>

                    <c:if test="${('0' eq order.status) and ('7' eq order.orderType)}">
                        <!--小厂家-->
                       <%-- <sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_RECV_ORDER_F_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="接收" type="button" onclick="jdFac(\'${order.id}\')"/>'></sfTags:pagePermission>
                        <sfTags:pagePermission authFlag="ORDERMGM_ALLORDER_REFUSE_ORDER_F_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="拒单" type="button" onclick="refuseOrderFac(\'${order.id}\')"/>'></sfTags:pagePermission>
                        <input class="sfbtn sfbtn-opt sbtn" value="短信通知"  onclick="senMagPopup('${order.id}')" type="button" />
                        <input class="sfbtn sfbtn-opt sbtn" id="repeteWrite" type="button" value="打印工单" target="_blank" onclick="dygd('${order.id}')" />
                        <input class="sfbtn sfbtn-opt sbtn" id="repeatOrder_custom"  type="button" onclick="dygdcustom('${order.id}')" value="打印工单" style="display: none;"/>--%>
                        <input class="sfbtn sfbtn-opt sbtn" value="新建工单" type="button" onclick="newOrder('${order.id}')"/>
                       <%-- <sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="标记工单" type="button" onclick="showMarkOrder(\'${order.id}\')"/>'></sfTags:pagePermission>--%>
                    </c:if>
                    <sf:hasPermission perm="ORDERMGM_STAYVISTORDER_PERM_ZJFD_BTN"><input class="sfbtn sfbtn-opt zjfd sbtn" onclick="showzjfd()" value="直接封单" type="button"/></sf:hasPermission>
                    <sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="标记工单" type="button" onclick="showMarkOrder(\'${order.id}\')"/>'></sfTags:pagePermission>

                <%-- <c:if test="${whereMark eq 1 }">
                        <div class="btnWrap text-c"  style="bottom:0">
                            <a class="sfbtn sfbtn-opt3 sbtn" onclick="previousOrder('${order.id}','${order.number }')">上一单</a>
                            <a class="sfbtn sfbtn-opt3 sbtn" onclick="nextOrder('${order.id}','${order.number }')" >下一单</a>
                        </div>
                    </c:if>--%>
                </div>
            </div>

        </div>

    </div>
</div>
<!-- 暂不派工提示框 -->
<div class="popupBox notDispatch showzbpgdiv">
    <h2 class="popupHead">
        暂不派工
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="txtwrap1 pos-r mb-30">
                <label class="lb lb1"><em class="mark">*</em>暂不派工理由：</label>
                <textarea id="reasonofzbpg" class="textarea "></textarea>
            </div>
            <div class="text-c pl-30">
                <input onclick="savezbpg('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="cancelBox(this);"/>
            </div>
        </div>
    </div>
</div>

<!-- 直接封单提示框 -->
<div class="popupBox notDispatch showzjfddiv">
    <h2 class="popupHead">
        直接封单
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="txtwrap1 pos-r mb-30">
                <label class="lb lb1"><em class="mark">*</em>直接封单理由：</label>
                <textarea id="reasonofzjfd" class="textarea"></textarea>
            </div>
            <div class="text-c pl-30">
                <input onclick="savezjfd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button" onclick="cancerBox()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
            </div>
        </div>
    </div>
</div>

<!-- 无效工单提示框 -->
<div class="popupBox notDispatch showwxgddiv">
    <h2 class="popupHead">
        无效工单
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="txtwrap1 pos-r mb-30">
                <label class="lb lb1"><em class="mark">*</em>无效工单理由：</label>
                <textarea id="reasonofwxgd" class="textarea"></textarea>
            </div>
            <div class="text-c pl-30">
                <input onclick="savewxgd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
                <input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="$.closeDiv($('.showwxgddiv'), true);"/>
            </div>
        </div>
    </div>
</div>



<!-- 我要派工 -->
<div class="popupBox dispatch activeDispatch " >
    <h2 class="popupHead">
        我要派工
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain cl" >
            <input type="hidden" name= "employeId" id="employeId">
            <div class="f-l serversWrap">
                <div class="searchbox">
                    <input type="text" placeholder="请输入工程师姓名" class="input-text" id="filterName"/>
                    <a href="javascript:;" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
                </div>
                <div class="mt-10 showLatestlook" hidden="hidden">
                    <a class="iconDec1"></a>该用户最近一次（30天内）的服务工程师：<span id="latestEmps" style="width: 195px;overflow:hidden;text-overflow: ellipsis;white-space: nowrap;" ></span>
                </div>
                <div class="mt-10 serverlistWrap">
                    <div class="tableWrap">
                        <table class="table table-border table-bg table-serverlist">
                            <thead>
                            <th class="w-90" style="border-left: none;">工程师姓名</th>
                            <th class="w-100">未完成工单</th>
                            <th class="w-100">今日已完成</th>
                            <th class="w-90">距离</th>
                            <th class="w-80">选择</th>
                            </thead>

                            <tbody id="zhijiepaidan">

                            </tbody>
                        </table>
                    </div>
                    <div class="serversName">
                        <div class="txtwrap1 pos-r">
                            <label class="lb lb1 mt-3"><em class="c-fe0101">派工至</em>：</label>
                            <p class="lh-30" id="nameWrap" style="min-height:30px"></p>
                            <input type="button" class="w-70 sfbtn sfbtn-opt3" value="确认派工" onclick="dispa('${order.id}')"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="f-r w-460">
                <div class="cl mb-10">
                    <div class="f-l w-220 bk-gray" id="dispatch_map_container" style="height: 120px;">
                        <!-- 地图 -->
                    </div>
                    <div class="f-l w-230 ml-10 f-13 pt-10" style="height: 120px;">
                        <p class=""><strong class="custNam">${order.customerName}</strong></p>
                        <p class=""><strong class="custMob">${order.customerMobile}</strong></p>
                        <p class="custAddr">${order.customerAddress}</p>
                    </div>
                </div>
                <div class="cl mb-10">
                    <input type="text"  class="input-text w-330 f-l" id="arroundCustomerAddress" />
                    <a class="sfbtn sfbtn-opt f-r" href="javascript:searchArroundCust();"><i class="sficon sficon-search"></i>查看周边用户 </a>
                </div>
                <div class="serverlistWrap">
                    <div class="tableWrap" style="height: 195px;">
                        <table class="table table-border table-bg table-serverlist" style="table-layout: auto;">
                            <thead>
                            <th class="w-90" style="border-left: none;">姓名</th>
                            <th class="w-100">联系方式</th>
                            <th class="w-100">报修家电</th>
                            <th class="w-90">报修时间</th>
                            <th class="w-80">选择</th>
                            </thead>
                            <tbody id="arroundUserInfo">
                            <tr>
                                <%--<td style="border-left: none;">小灰灰</td>
                                <td>15656565656</td>
                                <td>格力空调</td>
                                <td>2018-02-23</td>
                                <td>
                                    <label class="label-cbox3" ><input type="checkbox" name="serverSelected" ></label>
                                </td>--%>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="serversName">
                        <div class="pos-r pl-15 pr-80">
                            <p class="pt-5 pb-5 lh-20" style="min-height: 30px"><%--郑经文、小灰灰、张晓明郑经文、小灰灰、张晓明--%></p>
                            <input type="button" class="w-70 sfbtn sfbtn-opt3 " value="发送短信" onclick="senMsg()" />
                            <input type="hidden" name="sendMsgOrderId" value="${order.id}" />
                            <input type="hidden" name="customerMobileNow" value="" />
                            <input type="hidden" name="jdTelephone" id="jdTelephone" value="" />
                        </div>
                    </div>
                </div>
            </div>
            <%--<div class="f-r mapWrap" id="dispatch_map_container">

            </div>--%>
        </div>
    </div>
</div>

<div id="map-container" style="display: none;">

</div>

<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
    <h2 class="popupHead">
        短信群发
        <a href="javascript:;" class="sficon closePopup" onclick="guanbi()"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain " >
            <div class="f-14">
                您已发送<strong class="c-005aab" id="sucMsg">0</strong>条，未发送<strong class="c-fd7e2a" id="wroMsg">0</strong>条！
            </div>
            <a id="exportLink" onclick="closePopup()" href="${ctx}/order/exportWrongNumber?formPath=/a/order/History" target="_blank" class="c-0383dc mt-10" style="text-decoration: underline;">查看发送失败的工单</a>
            <div class="text-c mt-20">
                <a  class="sfbtn sfbtn-opt w-70" onclick="guanbi()">关闭</a>
            </div>
        </div>
    </div>
</div>


<!-- 待派工工单下和服务中工单下 -->
<div class="popupBox msgText msgText1" style="height:285px;">
    <h2 class="popupHead">
        发送短信
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer" style="height:245px;overflow:auto;">
        <div class="popupMain pd-20" id="msgWrap" >
            <div class="tabBarP ">
                <a href="javascript:;" class="tabswitch current">模板发送</a>
                <a href="javascript:;" class="tabswitch ">编辑发送</a>
            </div>
            <div class="tabCon">
                <div class="pos-r pl-70 pr-80 mt-10">
                    <label class="lb w-70 text-r">选择模板：</label>
                    <span class="select-box w-160">
						<select class="select radius h-26" id="select-msgmode" name="selectModel" onchange="selectMsgMould(this)">
							<c:forEach items="${listModel }" var="lm">
                                <c:if test="${lm.columns.tag eq 8 }">
                                    <option value="${lm.columns.tag }">待派工</option>
                                </c:if>
                            </c:forEach>
							<c:forEach items="${listModel }" var="lm">
                                <c:if test="${lm.columns.tag eq 9 }">
                                    <option value="${lm.columns.tag }">配件无人接听</option>
                                </c:if>
                            </c:forEach>
						</select>
					</span>
                </div>
                <div class="msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板一）</span></span>
                        <div class="bk-gray pd-10">
                            <input type="text" class="msg-input" id="custName" value="${order.customerName }"  onkeyup="inputWidth(this)" />您好，
                            您的<input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>业务
                            <input type="text" class="msg-input" id="siteName" value="${siteName }" i onkeyup="inputWidth(this)"/>已受理，
                            请保持电话通畅，监督电话：
                            <input type="text" class="msg-input" id="jdMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign1" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel1">

                        </div>
                    </div>
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：<span class="c-0383dc">（模板二）</span></span>
                        <div class="bk-gray pd-10">
                            尊敬的用户，您的电话无法接通，请您在方便的时候回复
                            <input type="text" class="msg-input" id="custNameMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>， 我们将尽快为您提供
                            <input type="text" class="msg-input" id="yw" value="${order.serviceType }"  onkeyup="inputWidth(this)"/>服务！
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign2" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel2">	</div>
                    </div>
                </div>
                <!-- 配件无人接听 -->
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            你好，你购买的商品
                            <input type="text" class="msg-input" id="goodsTime" value="今天" onkeyup="inputWidth(this)"/>到
                            <input type="text" class="msg-input" value="${siteArea }" id="pjArea" onkeyup="inputWidth(this)"/>,联系你电话无人接听，看到短信后请联系
                            <input type="text" class="msg-input" value="${siteMobile }" id="pjMobile" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign20" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel20">	</div>
                    </div>
                </div>
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            尊敬的用户，您的电话无法接通状态，请您在方便的时候回复
                            <input type="text" class="msg-input" id="siteMobile" value="${jdPhone }" onkeyup="inputWidth(this)"/>
                            或服务工程师电话<input type="text" class="msg-input" value="${msg1 }" onkeyup="inputWidth(this)"/>,
                            我们将尽快为您提供满意的服务！
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign3" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel3"></div>
                    </div>
                </div>
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            <input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
                            您的预约时间已改至<input type="text" class="msg-input" id="proTime" value="${proTime } "  onkeyup="inputWidth(this)"/>，
                            <input type="text" class="msg-input" id="promiseLimit" value="${order.promiseLimit }" onkeyup="inputWidth(this)"/>，
                            具体上门时间，<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
                            会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign4" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel4">	</div>
                    </div>
                </div>
                <div class="hide msgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10">
                            <input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
                            因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
                            <input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
                            会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign5" onkeyup="inputWidth(this)"/>服务】
                        </div>
                        <div id="sendModel5">	</div>
                    </div>
                </div>

            </div>
            <div class="tabCon">
                <p class="c-f55025 f-12 lh-30">
                    注：自定义文字内容需要人工审核，等待时间较长
                </p>
                <div class="pr-80 pos-r">
                    <div class="bk-gray" >
                        <textarea class="textarea radius" placeholder="请输入短信内容" id="content" style="border-width: 0; height: 60px;"></textarea>
                        <div class="h-26">
                            <p class="f-r">【<input type="text" class="msg-input"  value="${serviceName }" id="sign6" onkeyup="inputWidth(this)"/>服务】</p>
                        </div>
                    </div>
                    <a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="sendMsgConfirm()">发送</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="popupBox msgText msgTextdefined" style="height:470px;">
    <h2 class="popupHead">
        发送短信
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer" style="height:430px;overflow:auto;">
        <div class="popupMain pd-20" id="msgWrapdef" >
            <div class="tabBarP ">
                <a href="javascript:;" class="tabswitch current">模板发送</a>
                <a href="javascript:;" class="tabswitch ">编辑发送</a>
            </div>
            <div class="tabCon">
                <div class="pos-r pl-70 pr-80 mt-10">
                    <label class="lb w-70 text-r">选择模板：</label>
                    <span class="select-box w-160">
						<select class="select radius h-26" id="select-msgmodedef" name="selectModel" onchange="selectMsgMoulddef(this)">
							<c:forEach items="${definedmodel}" var="def">
                                <option value="${def.columns.id }">${def.columns.name }(自定义)</option>
                            </c:forEach>
						</select>
					</span>
                </div>
                <div class=" defmsgmould">
                    <div class="pos-r pl-70 pr-80 mt-10">
                        <span class="lb w-70 text-c">发送内容：</span>
                        <div class="bk-gray pd-10 defmsgcontent">
                            <%--<input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
                            因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
                            <input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
                            会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
                            【<input type="text" class="msg-input" value="${serviceName }" id="sign5" onkeyup="inputWidth(this)"/>服务】--%>
                        </div>
                        <div id="defsendModel">	</div>
                    </div>
                </div>
            </div>
            <div class="tabCon">
                <p class="c-f55025 f-12 lh-30">
                    注：自定义文字内容需要人工审核，等待时间较长
                </p>
                <div class="pr-80 pos-r">
                    <div class="bk-gray" >
                        <textarea class="textarea radius" placeholder="请输入短信内容" id="contentdef" style="border-width: 0; height: 60px;"></textarea>
                        <div class="h-26">
                            <p class="f-r">【<input type="text" class="msg-input"  value="${serviceName }" id="signdef" onkeyup="inputWidth(this)"/>服务】</p>
                        </div>
                    </div>
                    <a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="defsendMsgConfirm()">发送</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="popupBox msgText msgTextQuren"  >
    <h2 class="popupHead">
        短信确认
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <div class="lh-26">
                <div>您确定给<span id="peoples" style="color: #999;" class="f-14"></span>发送</div>
                <div style="min-height:100px; text-indent:2em;color: #999;" id="sendContent" ></div>
            </div>
            <div class="text-c mt-25 " id="clickSend">

            </div>
        </div>
    </div>
</div>

<div class="popupBox qrcode" >
    <h2 class="popupHead">
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <div class="text-c mt-25 " id="showCode">

            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>

<script type="text/javascript">
    AMap.service('AMap.Geocoder', function () {//回调函数
        //实例化Geocoder
        geocoder = new AMap.Geocoder();
    });
    var changeMark = true;
    var definedContentTz="";
    var addressRecord="";
    var orderMsgId="";
    var orderMsgMobile="";
    var dispatchMap,dispatchMarker,employeMarker;
    var marker;
    var mark;

    function directDis(){
        $("#arroundUserInfo").empty();
        splitAddress('${order.customerAddress}');

        $('.activeDispatch').popup({level:2,closeSelfOnly:true}); //显示我要派工弹出框和判断高度
        $.selectCheck2("serverSelected");
        showLatestEmploye($("#customerMobile").val());
        initDispatchMap();
        employe();

    }

    function searchArroundCust(){
        var address = $("#arroundCustomerAddress").val();
        var orderId = $("input[name='sendMsgOrderId']").val();
        var mobile = $("input[name='customerMobileNow']").val();
        if(isBlank(address)){
            layer.msg("请输入地址信息");
        }else if(address.length>=2){
            $.ajax({
                type : "POST",
                url : "${ctx}/order/geteArroundCustInfo",
                data : {
                    address :address,
                    orderId:orderId,
                    mobile:mobile
                },
                success : function(data) {
                    var html='';
                    if(data.length>0){
                        for(var i=0;i<data.length;i++){
                            html+='<tr><td style="border-left: none;">'+data[i].columns.customer_name+'</td>';
                            html+='<td class="customerMobile">'+data[i].columns.customer_mobile+'</td>';
                            html+='<td>'+data[i].columns.applBranCate+'</td>';
                            html+='<td>'+data[i].columns.repair_time+'</td>';
                            html+='<td><label class="label-cbox3" ><input type="hidden" name="customerTelephone" value="'+data[i].columns.customer_telephone+'"/><input type="hidden" name="customerTelephone2" value="'+data[i].columns.customer_telephone2+'"/><input type="hidden" name="number" value="'+data[i].columns.number+'"/><input type="checkbox" name="serverSelected" ></label></td></tr>';
                        }
                        $("#arroundUserInfo").empty().append(html);

                        $("#arroundUserInfo tr").on('click', function(ev) {
                            var name = ev.target.tagName.toLowerCase();
                            if(name == 'label') return;

                            var flag = $(this).hasClass('checked');
                            if (flag) {
                                $(this).removeClass('checked');
                            } else {
                                $(this).attr("class","checked");
                                $.trim($(this).children('td').eq(0).html())
                            }
                        });
                    }else{
                        layer.msg("该地址暂无周边用户信息！");
                    }
                },
            });
        }else{
            layer.msg("输入的地址信息需要超过两个字符！");
        }

    }


    function returnMobile(val1,val2,val3){
        var mobile=$.trim(val1);
        if(isBlank(mobile)){
            mobile= $.trim(val2);
        }
        if(isBlank(mobile)){
            mobile= $.trim(val3);
        }
        if(isBlank(mobile)){
            mobile= "";
        }
        return mobile;
    }

    var noRepeateSend=false;
    function senMsg() { //批量发送短信
        var ids = $("#arroundUserInfo").find(".checked");
        var mobile = "";
        var number = "";
        var wrongNumber = "";

        var sign = $("#sign").val();
        var jsPhone = $("#jdTelephone").val();
        var toAnUrl = "";
        var content = "";
        if (ids.length < 1) {
            layer.msg("您还未选中任何数据！");
            return false;
        }
        $.ajax({
            type: "post",
            data: {},
            url: "${ctx}/order/orderDispatch/getHrefAjax",
            success: function (data) {
                toAnUrl = data;
                for (var i = 0; i < ids.length; i++) {
                    var customer_mobile = $(ids[i]).find(".customerMobile").text();
                    var customer_telephone = $(ids[i]).find("input[name='customerTelephone']").val();
                    var customer_telephone2 = $(ids[i]).find("input[name='customerTelephone2']").val();
                    var numb = $(ids[i]).find("input[name='number']").val();
                    var applBranCate = $(ids[i]).find(".applBranCate").text();
                    /*品牌品类*/
                    for (var i = 0; i < ids.length; i++) {
                        var customer_mobile = $(ids[i]).find(".customerMobile").text();
                        var customer_telephone = $(ids[i]).find("input[name='customerTelephone']").val();
                        var customer_telephone2 = $(ids[i]).find("input[name='customerTelephone2']").val();
                        var numb = $(ids[i]).find("input[name='number']").val();
                        var applBranCate = $(ids[i]).find(".applBranCate").text();
                        /*品牌品类*/

                        var ph1 = returnMobile(customer_mobile, customer_telephone, customer_telephone2);//去空格的mobile
                        if ($.trim(ph1) == "" || $.trim(ph1) == null) {
                            layer.msg("选择发送的工单中存在用户手机号为空的工单，请先维护或者重新选择工单！");
                            return;
                        }
                        if ($.trim(ph1).length != 11 || $.trim(ph1).substring(0, 1) != "1") {
                            if (wrongNumber == "") {
                                wrongNumber = numb;
                            } else {
                                wrongNumber = wrongNumber + ',' + numb;
                            }
                        }
                        if (i == 0) {
                            mobile = $.trim(ph1);
                            number = $.trim(numb);
                        } else {
                            mobile = mobile + ',' + $.trim(ph1);
                            number = number + ',' + $.trim(numb);
                        }

                        /*短信模板*/
                        content += "尊敬的用户，您好。我们是曾为您服务过的" + sign + "维修部。" +
                            "您的" + applBranCate + "产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
                            "可以联系我们公司：" + jsPhone + "。同时，家用电器用电安全也需要进行关注，" +
                            "可以放心点击观看以下用电安全内容（" + toAnUrl + "）。#";

                    }
                    $("#wrongNumber").val(wrongNumber);//未发送的工单编号
                    if (wrongNumber == "") {
                        var a = document.getElementById("exportLink");
                        a.removeAttribute("href");
                        a.setAttribute("onclick", "tishi()");
                    } else {
                        $("#exportLink").prop("href", $("#exportLink").prop("href") + "&no=" + wrongNumber);
                    }

                    if ($.trim(sign) == "" || sign == null) {
                        layer.msg("短信签名不能为空！");
                        $("#sign").focus();
                        return false;
                    }
                    if ($.trim(sign).length > 6) {
                        layer.msg("短信签名过长，最多为6个汉字！");
                        $("#sign").focus();
                        return false;
                    }
                    var siteMsgNums = $("#siteMsgNums").val();
                    var msgNumbers = mobile.split(",");
                    var msgNums = msgNumbers.length;//需要发送短信的工单数
                    var message="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
                        "您的XXXX产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
                        "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
                        "可以放心点击观看以下用电安全内容（XXXXXX）。";

                    $('body').popup({
                        level:3,
                        title:"短信确认",
                        content:message,
                        fnConfirm: function () {
                            if (noRepeateSend) {
                                return;
                            }
                            noRepeateSend = true;
                            layer.msg("短信发送中，请耐心等待...", {time: 5000000});
                            $.ajax({
                                type: "POST",
                                traditional: true,
                                url: "${ctx }/order/msgNumbers",
                                data: {
                                    content: content,
                                    sign: sign
                                },
                                success: function (result) {
                                    if (parseInt(result) * parseInt(msgNums) > parseInt(siteMsgNums)) {
                                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                                    } else {
                                        $.ajax({
                                            type: "POST",
                                            traditional: true,
                                            url: "${ctx }/order/sendInDispOrTurnDisp",
                                            data: {
                                                content: content,
                                                sign: sign,
                                                mobile: mobile,
                                                number: number
                                            },
                                            success: function (result) {
                                                if (result == "noMessage") {
                                                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                                                } else {
                                                    var n = 0;
                                                    for (var j = 0; j < msgNumbers.length; j++) {
                                                        if (msgNumbers[j].length == 11 && msgNumbers[j].substring(0, 1) == "1") {
                                                            n++;
                                                        }
                                                    }
                                                    $("#sucMsg").text(n);
                                                    $("#wroMsg").text(parseInt(msgNumbers.length) - parseInt(n));
                                                    layer.msg("发送成功");
                                                    $('.massTextNoteQf').popup({level: 2});
                                                }
                                            }
                                        })
                                    }
                                }, complete: function () {
                                    noRepeateSend = false;
                                }
                            })
                        },
                        fnCancel: function () {

                        }
                    });
                }
            }
        })
    }

    function guanbi(){
        $.closeDiv($(".massTextNote"));
    }

    function closePopup(){
        $.closeDiv($(".massTextNote"));
    }

    /*切割地址（去掉省市区）*/
    function splitAddress(address) {
        var addressDetail="";
        var sz = [];
        if (address.indexOf("区") > 0 && address.indexOf("县") <= 0 && address.indexOf("市") < 0) {
            sz = address.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (1 < sz.length <= 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if (address.indexOf("县") > 0 && address.indexOf("市") < 0) {
            sz = address.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (1 < sz.length <= 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if(address.indexOf("县") > 0 && address.indexOf("市") > 0){
            var ciAd=address.indexOf("市");
            var xaAd=address.indexOf("县");
            if(parseInt(ciAd) < parseInt(xaAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (sz.length == 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
                sz = address.split("县");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "县";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (1 < sz.length <= 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }
        }else if(address.indexOf("市") > 0 && address.indexOf("区") < 0){
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                addressDetail=strs;
            } else if (sz.length == 2) {
                addressDetail=sz[1];
            } else {
                addressDetail=sz[0];
            }
        }else if (address.indexOf("市") > 0 && address.indexOf("区") > 0) {
            var ciAd=address.indexOf("市");
            var quAd=address.indexOf("区");

            if(parseInt(ciAd) < parseInt(quAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (sz.length == 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
                sz = address.split("区");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "区";
                        } else {
                            strs += sz[i];
                        }
                    }
                    addressDetail=strs;
                } else if (1 < sz.length <= 2) {
                    addressDetail=sz[1];
                } else {
                    addressDetail=sz[0];
                }
            }
        } else if (address.indexOf("区") <= 0 && address.indexOf("县") <= 0 && address.indexOf("市") <= 0) {
            addressDetail=address;
        }
        $("#arroundCustomerAddress").val(addressDetail);
    }

    $('#btn_showImg').on('click', function(){
        $('#wxImgList img').eq(0).click();
    })



    $(function(){
        if('${haveData}'=="1"){
            layer.msg("没有上一条数据了");
        }
        if('${haveData}'=="2"){
            layer.msg("没有下一条数据了");
        }
        $('#wxImgList').imgShow();
        var content1="@您好，您的@业务@已受理，请保持电话通畅，服务电话：@。【@服务】";
        var content2="尊敬的用户，您的电话无法接通，请您在方便的时候回复@，我们将尽快为您提供@服务！【@服务】";
        $("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("10","8","'+content1+'") >发送</a>');
        $("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick=sendModel1("11","8","'+content2+'") >发送</a>');
        orderMsgId='${order.id}';
        $.post("${ctx}/order/remainMsgNum",{},function(result){
            $("#sign").val(result.columns.sms_sign);//签名
            $("#siteMsgNums").val(result.columns.sms_available_amount);//服务商剩余可发送短信总数
            $("#jdTelephone").val(result.columns.sms_phone);
        });
        $(".codeConnectShow").bind('click', function () {
            var code = $(this).parent(".wrapss").find("input").val();
            layer.open({
                type : 2,
                content:'${ctx}/order/showHistoryPopupDetail2017?code=' + code+'&id='+'${order.id}',
                title:false,
                area: ['100%','100%'],
                closeBtn:0,
                shade:0,
                anim:-1
            });
        });

        codeNumberCounts();


        $('#filterName').keyup(function(){
            $('#zhijiepaidan tr').hide()
                .filter(":contains('" +($(this).val()) + "')").show();
            if(isBlank($(this).val())){
                $('#zhijiepaidan tr').show();
            }
        }).keyup();//DOM加载完时，绑定事件完成之后立即触发
        $("#origin").select2();
        $(".selection").css("width","120px");

        $('#applianceBrand').select2();
        $("#applianceBrand").next(".select2").find(".selection").css("width","160px");

        $('#applianceCategory').select2();
        $("#applianceCategory").next(".select2").find(".selection").css("width","120px");

        $("#pleaseReferMall").select2();
        $("#pleaseReferMall").next(".select2").find(".selection").css("width","120px");
        judgedygd();




    });


    function getDefaultAddress(){
        $.ajax({
            type: "POST",
            url: "${ctx}/order/getDefaultAddress",
            datatype:"text",
            success: function (result) {
                $("#pcd").citySelect({
                    url:'${ctxPlugin}/lib/city.min.js',
                    address:result
                });
                //addressTwo(result);
            },
            error: function () {
                layer.msg("系统繁忙!");
                return;
            },
            complete: function () {

            }

        });
    }

    function addressTwo(str){
        var sz=[];
        var regshi = "市";
        var regqu="区";
        var address = str;

        if(address.indexOf(regqu) >0 && address.indexOf("县")<=0){
            sz=address.split(regqu);
            if(sz.length>2){
                $("#customerAddress1").val(sz[1]+"区"+sz[2]);
            }else if(1<sz.length<=2){
                $("#customerAddress1").val(sz[1]);
            }else{
                $("#customerAddress1").val(sz[0]);
            }
        }else if(address.indexOf("县") >0 ){
            sz=address.split("县");
            if(sz.length>2){
                $("#customerAddress1").val(sz[1]+"县"+sz[2]);
            }else if(1<sz.length<=2){
                $("#customerAddress1").val(sz[1]);
            }else{
                $("#customerAddress1").val(sz[0]);
            }
        }else if(address.indexOf(regqu) <=0 && address.indexOf("县")<=0){
            sz=address.split(regshi);
            $("#customerAddress1").val(sz[1]);
        }
    }

    function toggleMirror(isMirror) {
        if(!isMirror) {
            $("#applanceBrandMirror").hide();
            $("#applianceCategoryMirror").hide();
            $("#applianceCategory").show();
            $("#applianceBrand").show();
        } else {
            $("#applanceBrandMirror").show();
            $("#applianceCategoryMirror").show();
            $("#applianceCategory").hide();
            $("#applianceBrand").hide();
        }
    }

    /*获取必填项设置参数*/
    function getJurisdiction(){
        /*变量名要与元素中的id对应*/
        var promiseTime = '${mustfill.columns.promiseTime}';
        var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
        var origin = '${mustfill.columns.origin}';
        var promiseLimit = '${mustfill.columns.promiseLimit}';
        var remarks = '${mustfill.columns.remarks}';
        var applianceModel = '${mustfill.columns.applianceModel}';
        var applianceNum = '${mustfill.columns.applianceNum}';
        var applianceBarcode = '${mustfill.columns.applianceBarcode}';
        var applianceMachineCode = '${mustfill.columns.applianceMachineCode}';
        var pleaseReferMall = '${mustfill.columns.pleaseReferMall}';
        var warrantyType = '${mustfill.columns.warrantyType}';
        var level = '${mustfill.columns.level}';
        var customerFeedbackJuris = '${mustfill.columns.customerFeedback}';
        var jurisdiction=origin+","+promiseTime+","+promiseLimit+","+customerFeedbackJuris+","+remarks+","+applianceModel+","+applianceNum+","+applianceBarcode+","+applianceMachineCode+","+applianceBuyTime+","+pleaseReferMall+","+warrantyType+","+level;
        return jurisdiction;
    }
    /*获取参数*/
    function getJurisdisctionValue(){
        var origin= $("#origin").val();
        var promiseTime= $("#promiseTime").val();
        var promiseLimit= $("#promiseLimit").val();
        var customerFeedback= $("#customerFeedback").val();
        var remarks= $("#remark").val();
        var applianceModel= $("#applianceModel").val();
        var applianceNum= $("#applianceNum").val();
        var applianceBarcode= $("#applianceBarcode").val();
        var applianceMachineCode= $("#applianceMachineCode").val();
        var applianceBuyTime= $("#applianceBuyTime").val();
        var pleaseReferMall= $("#pleaseReferMall").val();
        var warrantyType= $("#warrantyType").val();
        var level= $("#level").val();
        //var jurisdictionvalue=origin+"(**..)"+promiseTime+"(**..)"+promiseLimit+"(**..)"+customerFeedback+"(**..)"+remarks+"(**..)"+applianceModel+"(**..)"+applianceNum+"(**..)"+applianceBarcode+"(**..)"+applianceMachineCode+"(**..)"+applianceBuyTime+"(**..)"+pleaseReferMall+"(**..)"+warrantyType+"(**..)"+level;

        var array=new Array();
        array[0]=origin;
        array[1]=promiseTime;
        array[2]=promiseLimit;
        array[3]=customerFeedback;
        array[4]=remarks;
        array[5]=applianceModel;
        array[6]=applianceNum;
        array[7]=applianceBarcode;
        array[8]=applianceMachineCode;
        array[9]=applianceBuyTime;
        array[10]=pleaseReferMall;
        array[11]=warrantyType;
        array[12]=level;
        return array;
    }


    $(function(){
        /* $.post("${ctx}/order/orderDispatch/getCodeShowPopup",{id:'${order.id}'},function(result){
			 var cdIn = result.codeIn;
			 var cdOut = result.codeOut;
			 if(cdIn == 0 && cdOut == 0){
				 $('#codeShow').hide();
			 }else{
				 if(cdIn < 1 || cdOut < 1){
					 $(".douhao").text("");
				 }
				 if(cdIn > 0){
					 $("#codeInshow").text(cdIn+'条历史工单');
					 $(".codeIn").show();
				 }else{
					 $(".codeIn").hide();
				 }
				 if(cdOut > 0){

					 $("#codeOutshow").text(cdOut+'条历史工单');
					 $(".codeOut").show();
				 }else{
					 $(".codeOut").hide();
				 }
				 $('#codeShow').show();
			 }
		}) */
        $.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
        $.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
        $.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");

        $('.orderdetailVb').popup({fixedHeight:false});

        $("input.autoCal").change(function(){
            var sum = 0;
            $("input.autoCal").each(function(){
                if(testCash($(this).val())){
                    sum = numAdd(sum, $(this).val());
                }else if($(this).val() !=''){
                    $(this).val("");
                }
                $("#total_cost").val(sum);
            });
        });
        $("#xggd").click(function(){
//			$("#origin1").hide();
            $("#origin").removeClass("hide");
            var markMobile = '${order.customerMobile}';
            var firstNumber = "";
            if(markMobile!=null && markMobile!=""){ //如果联系方式的第一位为0，则为固话
                firstNumber = markMobile.substring(0,1);
            }
            var html='<span class="f-r pr-5">:</span>';
            html+='<select class="lb-sel f-r readonly select" style="width:75px" disabled="disabled" id="mobileOrtel">';
            if(firstNumber=="0"){
                html+='<option value="1"  >手机号码</option>';
                html+='<option value="2" selected="selected">固定电话</option>';
            }else{
                html+='<option value="1" selected="selected">手机号码</option>';
                html+='<option value="2" >固定电话</option>';
            }
            html+='</select>';
            html+='<em class="mark f-r">*</em>'
            $("#mobileType").empty().append(html);
            if($(this).val()!="保存"){
                toggleMirror(false);
                $(".sbtn").prop("disabled", true);
                $("input[type='text']").removeClass("readonly");
                $("#factoryNumber").removeClass("readonly");
                $("#factoryNumber").removeAttr("readonly");
                $("#factoryNumber").removeAttr("disabled");
                $("textarea").removeClass("readonly");
                $("input[type='text']").prop("readonly",false);
                $("textarea").prop("disabled",false);
                $("#customerFeedback").prop("readonly", false);
                $("#remark").prop("readonly", false);
                $("select").removeClass("readonly");
                $('.ptime').removeClass("readonly");
                $('.ptime').prop("disabled",false);

                $("#showProvince").css("display","");
                $("#showCity").css("display","");
                $("#showArea").css("display","");

                $("select").prop("disabled",false);

                $("#serviceType").addClass("mustfill");
                $("#serviceMode").addClass("mustfill");
                $("#customerName").addClass("mustfill");
                $("#customerMobile").addClass("mustfill");
                $("#customerAddress1").addClass("mustfill");
                $("#applianceBrand").addClass("mustfill");
                $("#applianceCategory").addClass("mustfill");
                $("#styleMArk .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
                //$("#customerFeedback").addClass("mustfill");

                var str='origin,promiseTime,promiseLimit,customerFeedback,remark,applianceModel,applianceNum,applianceBarcode,applianceMachineCode,applianceBuyTime,pleaseReferMall,warrantyType,level';
                addMustFill(getJurisdiction(),str);

                $(".mark").text("*");

                $(".dischange").addClass("readonly");
                $(".dischange").prop("disabled",true);
                /*$("#customerAddress1").css({'width':'480px'});*/
                $("#repeteWrite").addClass("sfbtn-disabled");
                $(".btnMenubox").find("input").addClass("sfbtn-disabled");
                $(this).removeClass("sfbtn-disabled");
                $(this).after("<input id='qxgf' class='sfbtn sfbtn-opt' onclick='getoff()'  value='取消' type='button'/>");
                $(this).val("保存");

                $("#orderNumber").prop("disabled",false);
                $("#orderNumber").prop("readonly",true);



                /*var addr="<c:out value='${order.customerAddress}'/>";
				if(isBlank(addr)){
					getDefaultAddress();
				}else if(addr.indexOf("区") <= 0 && addr.indexOf("县") <=0 && addr.indexOf("市") <=0 ){
					getDefaultAddress();
				}else{
					address();
				}*/
            }else{
                var mobileOrtel = $("#mobileOrtel").val();

                var serviceType = $("#serviceType").val();
                var serviceMode = $("#serviceMode").val();
                var customerName = $.trim($("#customerName").val());
                var customerMobile = $("#customerMobile").val();
                var customerTelephone = $("#customerTelephone").val();
                var customerTelephone2=$("#customerTelephone2").val();
                var customerAddress = $("#customerAddress1").val();
                var applianceBrand = $("#applianceBrand").val();
                var applianceCategory = $("#applianceCategory").val();
                var customerFeedback = $.trim($("#customerFeedback").val());
                var moliereg=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
                var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
                //var tel=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
                var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
                //var fdfd = /^(^(0[0-9]{2,3}?[2-9][0-9]{6,7})?$)$/;
                var factoryNumber = $("#factoryNumber").val();
                if('${order.recordAccount}'=='1'){
                    if(isBlank(factoryNumber)){
                        layer.msg("请填写厂家工单编号");
                        $("#factoryNumber").focus();
                        return;
                    }
                    if ($.trim(factoryNumber).length > 32) {
                        layer.msg("厂家工单编号过长");
                        $("#factoryNumber").focus();
                        return;
                    }
                }
                if(serviceType==null||serviceType==""){
                    layer.msg("服务类型为必填项");
                    return;
                }
                if(serviceMode==null||serviceMode==""){
                    layer.msg("服务方式为必填项");
                    return;
                }
                if(customerName==null||customerName==""){
                    layer.msg("用户姓名为必填项");
                    return;
                }

                if(!isBlank(customerMobile)){
                    //if(!moliereg.test($.trim(customerMobile))){
                    if(!tel.test($.trim(customerMobile))){
                        layer.msg("请输入正确的联系方式");
                        $("#mobileOrtel").prop("disabled",false);
                        $("#mobileOrtel").removeClass("readonly");
                        if(mobileOrtel == "1"){
                            $("#mobileOrtel").val("手机号码");
                        }else{
                            $("#mobileOrtel").val("固定电话");
                        }
                        return;
                    }
                    //}
                }else{
                    layer.msg("请输入联系方式");
                    return;
                }
                if(customerTelephone.length>0){
                    if(!mtel.test($.trim(customerTelephone))){
                        layer.msg("请输入正确的联系方式2");
                        return;
                    }

                }
                if(customerTelephone2.length>0){
                    if(!mtel.test($.trim(customerTelephone2))){
                        layer.msg("请输入正确的联系方式3");
                        return;
                    }

                }


                if(customerAddress==null||customerAddress==""){
                    layer.msg("详细地址为必填项");
                    return;
                }
                if(applianceBrand==null||applianceBrand==""){
                    layer.msg("家电品牌为必填项");
                    return;
                }
                if(applianceCategory==null||applianceCategory==""){
                    layer.msg("家电品类必填项");
                    return;
                }
                /*if(customerFeedback==null||customerFeedback==""){
                    layer.msg("服务描述为必填项");
                    return;
                }*/


                /*var addressspace="";
                if($("#province").val()!=null){
                    addressspace+=$("#province").val();
                }else{
                    layer.msg("省市区为必填项");
                    return;
                }
                if($("#city").val()!=null){
                    addressspace+=$("#city").val();
                }else{
                    layer.msg("省市区为必填项");
                    return;
                }
                if($("#area").val()!=null){
                    addressspace+=$("#area").val();
                }else{
                    layer.msg("省市区为必填项");
                    return;
                }*/

                var result=checkMustFill(getJurisdiction(),getJurisdisctionValue());
                if(!result){
                    return;
                }else{
                    $("#customerAddress").val($("#customerAddress1").val());
                    $.ajax({
                        url: "${ctx}/order/orderDispatch/update",
                        type: "post",
                        data: $("#updateOrder").serialize(),
                        success: function() {
                            parent.search();
                            window.location.reload();
                        }
                    });
                    return;
                }

            }

        });
    });

    function showMore(obj){
        if($('#moreConWrap').is(':visible')){

            $('#moreConWrap').slideUp();
            $(obj).text('展开');
        }else{
            console.log(2);
            $('#moreConWrap').slideDown();
            $(obj).text('收起');
        }
    }

    $(function(){
        // 选择品类时获取服务商维护对应的品牌
        $("#applianceCategory").change(function(){
            var brand = $("#applianceBrand").val();

            var cate = $("#applianceCategory").val();
            $.ajax({
                type:"post",
                url:"${ctx}/order/getBrand",
                data:{
                    category:cate
                },
                dataType:"json",
                success:function(data){
                    var obj = eval(data);
                    $("#applianceBrand").empty();
                    if(obj.count == 2){
                        layer.msg("没有相关品牌，请维护");
                        //$("#applianceBrand").empty();
                        document.getElementById("applianceBrand").setAttribute("disabled", "disabled");
                    }else{
                        document.getElementById("applianceBrand").removeAttribute("disabled");
                        var HTML = " <option value=''>请选择</option> ";
                        $.each(obj.brand,function(key,values){
                            if(brand ==values){
                                HTML += '<option value="'+values+'" selected = "selected" >'+key+'</option>';
                            }else{
                                HTML += '<option value="'+values+'">'+key+'</option>';
                            }

                        });
                        $("#applianceBrand").append(HTML);
                    }
                }
            });
            //}
        });

        // 选择品牌时获取服务商维护对应的品类
        $("#applianceBrand").change(function () {
            var cate = $("#applianceCategory").val();
            var brand = $("#applianceBrand").val();
            $.ajax({
                type: "post",
                url: "${ctx}/order/getCategory",
                data: {
                    brand: brand
                },
                dataType: "json",
                success: function (data) {
                    var obj = eval(data);
                    $("#applianceCategory").empty();
                    if (obj.count == 2) {
                        layer.msg("没有相关品类，请维护");
                        document.getElementById("applianceCategory").setAttribute("disabled", "disabled");
                    } else {
                        document.getElementById("applianceCategory").removeAttribute("disabled");
                        var HTML = " <option value=''>请选择</option> ";
                        $.each(obj.cate, function (key, values) {
                            if (cate == values) {
                                HTML += '<option value="' + values + '" selected = "selected" >' + key + '</option>';
                            } else {
                                HTML += '<option value="' + values + '">' + key + '</option>';
                            }

                        });
                        $("#applianceCategory").append(HTML);
                    }
                }
            });
        });
    });


    function employe() {
        var lnglat = $("#lnglat").val();
        var address = $("#customerAddress").val();
        var category = $('#applianceCategory').val();
        $.ajax({
            type : "POST",
            url : "${ctx}/operate/employe/dispatchList",
            data : {
                lnglat :lnglat,
                category:category,
                address:address
            },
            //dataType: 'json',
            success : function(data) {
                var content = $("#zhijiepaidan");
                content.empty();
                var sites = data;
                var appendHtml = '';
                for (var i = 0; i < sites.length; i++) {
                    var item = sites[i].columns;
                    appendHtml +='<tr>'
                        +'<td style="border-left: none;">'+item.name+'</td>'
                        +'<td>'+item.wwg+'</td>'
                        +'<td>'+item.jrywg+'</td>'
                        +'<td>'+item.distance_formatted+'</td>'
                        +'<td><label class="label-cbox3" for="'+item.id+'"><input type="checkbox" name="serverSelected" id="'+item.id+'"></label></td>'
                        +'</tr>';
                }
                if(isBlank(appendHtml)){
                    layer.msg("服务工程师没有维护"+category+"服务品类，请先维护");
                }
                content.html(appendHtml);

                $("#zhijiepaidan tr").each(function(index) {
                    $(this).data("emp", sites[index].columns);
                });
                $("#zhijiepaidan tr").on('click', function(ev) {
                    var name = ev.target.tagName.toLowerCase();
                    if(name == 'label') return;

                    var flag = $(this).hasClass('checked');
                    if (flag) {
                        $(this).removeClass('checked');
                    } else {
                        $(this).attr("class","checked");
                        $.trim($(this).children('td').eq(0).html())
                    }
                    $("#nameWrap").empty();
                    var name="";
                    var id = "";
                    $("#zhijiepaidan tr").each(function(index) {
                        var flag = $(this).hasClass('checked');
                        if (flag) {
                            if(isBlank(name)){
                                name = $.trim($(this).children('td').eq(0).html());
                            }else{
                                name = name+" "+ $.trim($(this).children('td').eq(0).html());
                            }
                            if(isBlank(id)){
                                id= $.trim($(this).children('td').eq(4).children('label').attr('for'));
                            }else{
                                id= id+","+$(this).children('td').eq(4).children('label').attr('for');
                            }
                        }
                    });
                    $("#nameWrap").append("<span>"+name+"</span>");
                    $("#employeId").val(id);

                });
            }
        });
    }

    function select(id,val){
        if(!isBlank(val)){
            var select = document.getElementById(id);
            for (var i = 0; i < select.options.length; i++){
                if (select.options[i].value == val){
                    select.options[i].selected = true;
                    break;
                }
            }
        }
    }

    function getoff(){
        window.location.reload();
    }

    function address() {
        var sz = [];
        var address = $("#customerAddress").val();
        if (address.indexOf("区") > 0 && address.indexOf("县") <= 0 && address.indexOf("市") < 0) {
            sz = address.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if (address.indexOf("县") > 0 && address.indexOf("市") < 0) {
            sz = address.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if(address.indexOf("县") > 0 && address.indexOf("市") > 0){
            var ciAd=address.indexOf("市");
            var xaAd=address.indexOf("县");
            if(parseInt(ciAd) < parseInt(xaAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
                sz = address.split("县");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "县";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }
        }else if(address.indexOf("市") > 0 && address.indexOf("区") < 0){
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (sz.length == 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if (address.indexOf("市") > 0 && address.indexOf("区") > 0) {
            var ciAd=address.indexOf("市");
            var quAd=address.indexOf("区");

            if(parseInt(ciAd) < parseInt(quAd)){//市在前
                sz = address.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
                sz = address.split("区");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "区";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress1").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress1").val(sz[1]);
                } else {
                    $("#customerAddress1").val(sz[0]);
                }
            }
        } else if (address.indexOf("区") <= 0 && address.indexOf("县") <= 0 && address.indexOf("市") <= 0) {
            $("#customerAddress1").val(address);
        }
        var province = $("#province").val();
        var city = $("#city").val();
        var area = $("#area").val();
        if (isBlank(province) || isBlank(city) || isBlank(area)) {
            getDefaultAddress();
        }
    }

    function saveCallback(){
        var postData = $("#callback_form").serializeJson();
        $.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
        });
    }

    function saveSettlement(){
        var postData = $("#seltment_form").serializeJson();
        $.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
        });
    }

    function newOrder(id){
        window.location.href="${ctx}/order2017/newFormFormDetail?id="+id;
    }

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

    function showzbpg(){
        if("${order.status}"==7){
            layer.msg("已经为暂不派工!");
            return;
        }
        $('.showzbpgdiv').popup({level:2, closeSelfOnly:true});
    }

    function showwxgd(type){
        if(type=='6'){
            layer.msg("该工单为一级网点所派，不能进行无效工单操作！");
            return;
        }
        $('.showwxgddiv').popup({level:2, closeSelfOnly:true});
    }
    /* 	保存无效工单 */
    function savewxgd(id) {
        var latest_process = $.trim($("#reasonofwxgd").val());
        if (isBlank(latest_process)) {
            layer.msg("请输入理由!");
            return;
        } else {
            $.ajax({
                type:"POST",
                data:{id:id,latest_process:latest_process},
                dataType:"JSON",
                url: "${ctx}/order/orderDispatch/updateOrderInvalid" ,
                success: function (result) {
                    if (result) {
                        window.top.layer.msg("无效工单更新完毕!", {time: 2000});
                        parent.search();
                        parent.numerCheck();
//					$.closeDiv($('.showzbpgdiv'));
//					parent.closeBatchForm();
//					parent.closeBatchForms();
//					$('#Hui-article-box', window.top.document).css({'z-index': '9'});
                        $.closeAllDiv();
                    }
                },
                error: function () {
                    layer.msg("系统繁忙!");
                    return;
                }

            });
        }
    }
    /* 保存暂不派工 */
    var tempDis = false;
    function savezbpg(id) {
        if (tempDis) {
            return;
        }

        var latest_process = $.trim($("#reasonofzbpg").val());
        if (isBlank(latest_process)) {
            layer.msg("请输入理由!");
            return;
        } else {
            tempDis = true;
            $.ajax({
                type: "POST",
                url: "${ctx}/order/orderDispatch/TemporarilyDis",
                data: {
                    id: id,
                    latest_process: latest_process
                },
                success: function (result) {
                    layer.msg("暂不派工更新完毕!", {time: 2000});
                    parent.search();
                    parent.numerCheck();
//                $.closeDiv($('.showzbpgdiv'));
//                parent.closeBatchForm();
//                parent.closeBatchForms();
//                $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                    $.closeAllDiv();
                },
                error: function () {
                    layer.msg("系统繁忙!");
                    return;
                },
                complete: function () {
                    tempDis = false;
                }

            });
        }
    }

    //确认派工按钮
    var adpotingpai = false;
    function dispa(orderId) {
        if (adpotingpai) {
            return;
        }
        var empId = $("#employeId").val();
        if (isBlank(empId)) {
            layer.msg("请选择服务工程师");
        } else {
            var name = $.trim($("#nameWrap").children('span').html());
            $('body').popup({
                level: '3',
                //	 type:1,  // 提示操作成功
                type: 2,  // 提示是否进行某种操作
                content: '确认派工至' + name + '吗？',
                fnConfirm: function () {
                    adpotingpai = true;
                    $.ajax({
                        type: "POST",
                        url: "${ctx}/order/orderDispatch/save",
                        data: {
                            orderId: orderId,
                            empId: empId
                        },
                        success: function (data) {
                            if (data) {
                                var topWin = window.top;
                                layer.msg('已派工!');
                                parent.search();
                                parent.numerCheck();

                                $.ajax({
                                    type:"post",
                                    url:"${ctx}/order/checkIfAllowSendMsg",
                                    data:{},
                                    success:function(data){
                                        if(data=="200"){
                                            $.closeDiv($('.showwxgddiv'));
                                            $.closeDiv($('.orderdetailVb'));
                                            msgInforms(topWin, '${order.id}');
                                            parent.closeBatchForm();
                                            parent.closeBatchForms();
                                            $('#Hui-article-box', window.top.document).css({'z-index': '9'});
                                        }else{
                                            $.closeDiv($('.showwxgddiv'));
                                            $.closeDiv($('.orderdetailVb'));
                                        }
                                    }
                                })
                            } else {
                                layer.msg('派工失败!');
                            }
                        },
                        complete: function () {
                            adpotingpai = false;
                        }
                    });
                },
                fnCancel: function () {
                }
            });
        }
    }
    function msgInforms(topWin, id){
        var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
        var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);

        if(isBlank(id)){
            frameWin.layer.msg("数据有误！");
            return
        }
        /* $.ajax({
            type:"post",
            url:"${ctx}/order/checkIfAllowSendMsg",
    	data:{},
    	success:function(data){
    		alert(data)
    		if(data=="200"){  */
        frameWin.layer.open({
            type : 2,
            content:'${ctx}/order/sendMsgAccountsOne?ids=' + id + "&type=1",
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });

        /* }
    }
})  */
    }

    function cancelBox(a) {
        $.closeDiv($(".showzbpgdiv"), true);
    }

    function initDispatchMap() {
        if (!dispatchMap) {
            dispatchMap = new AMap.Map('dispatch_map_container', {
                zoom: 12
            });
            dispatchMarker = new AMap.Marker({
                map:dispatchMap,
                draggable:true
            });
            employeMarker = new AMap.Marker({});
            dispatchMarker.setMap(dispatchMap);
        }
        var lnglat = $("#lnglat").val();
        if(!isBlank(lnglat)) {
            var lnglats = lnglat.split(",");
            var position = new AMap.LngLat(lnglats[0], lnglats[1]);
            dispatchMap.setZoomAndCenter(12, position);
            dispatchMarker.setPosition(position);
        }
        employeMarker.setMap(null);
    }

    function changeStyle(orderNum){
        var bStop = false;
        var bStopIndex = 1;
        var topWindow = $(window.top.document),
            show_navLi = topWindow.find("#min_title_list li");

        show_navLi.each(function() {
            $(this).removeClass('active');
            if($(this).find('span').text() =='短信发送记录'){
                bStopIndex=show_navLi.index($(this));
                bStop=true;
            }
        });
        if(!bStop){
            creatIframe('${ctx }/operate/sendedSms?orderNum='+orderNum+'&target=2','短信发送记录');
        }else{
            show_navLi.eq(bStopIndex).addClass('active');
            topWindow.find('#iframe_box .show_iframe').hide().eq(bStopIndex).show().find('iframe').attr({'src':'${ctx }/operate/sendedSms?orderNum='+orderNum+'&target=2'});
        }
    }

    function printOrder(orderId){
        window.location.href="${ctx}/print/order?orderId="+orderId;
    }

    function msgInform(orderId){
        orderMsgId = orderId;
        if(!${empty definedmodel}){
            $.Huitab("#msgWrapdef .tabBarP .tabswitch","#msgWrapdef .tabCon","current","click","0");
            $('.msg-input').each(function(){
                inputWidth(this);
            });
            selectMsgMoulddef("");
            $('.msgTextdefined').popup({level:4, closeSelfOnly: true});
        }else{
            $.Huitab("#msgWrap .tabBarP .tabswitch","#msgWrap .tabCon","current","click","0");
            $('.msg-input').each(function(){
                inputWidth(this);
            });
            $('.msgText1').popup({level:4, closeSelfOnly: true});
        }

    }

    //下拉框切换模板
    function selectMsgMould(obj){
        var aDiv = $('.msgText1 .msgmould');
        var index = obj.selectedIndex;
        var tag = $('#select-msgmode option:selected') .val();
        $.ajax({
            type:"POST",
            url:"${ctx }/order/getTag",
            data:{tag:tag},
            success:function(result){
                if(tag==8){//派工前
                    if(result[0].columns.id=='10'){
                        $("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\')" >发送</a>');
                    }else{
                        $("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[1].columns.content+'\')" >发送</a>');
                    }
                    if(result[1].columns.id=='11'){
                        $("#sendModel1").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[1].columns.tag+'\',\''+result[0].columns.content+'\')" >发送</a>');
                    }else{
                        $("#sendModel2").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[1].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[1].columns.content+'\')" >发送</a>');
                    }
                }else if(tag==4){
                    $("#sendModel3").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\')" >发送</a>');
                }else if(tag==3){
                    $("#sendModel4").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\')" >发送</a>');
                }else if(tag==2){
                    $("#sendModel5").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\')" >发送</a>');
                }else if(tag==9){
                    $("#sendModel20").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModel1(\''+result[0].columns.id+'\',\''+result[0].columns.tag+'\',\''+result[0].columns.content+'\',3)" >发送</a>');
                }else if(tag==11){

                }
                //$.setPos($(".msgText1"))
            }
        })
        aDiv.hide().eq(index).show();

    }


    //下拉框切换自定义模板
    function selectMsgMoulddef(obj){
        var id = $('#select-msgmodedef option:selected') .val();
        $.ajax({
            type:"POST",
            url:"${ctx }/order/getsmsbyid",
            data:{id:id},
            success:function(result) {
                if (result != "" || result != null) {
                    $(".defmsgcontent").empty();
                    var newcontent=result.columns.content;
                    while(newcontent.indexOf('@1') >= 0){
                        newcontent = newcontent.replace("@1","<input type='text' class='msg-input' value='${order.customerName }' onkeyup='inputWidth(this)' id='defcustomerName'/>");
                    }
                    while(newcontent.indexOf('@2') >= 0){
                        newcontent = newcontent.replace("@2","<input type='text' class='msg-input' value='${order.applianceBrand }' onkeyup='inputWidth(this)' id='defapplianceBrand'/>");
                    }
                    while(newcontent.indexOf('@3') >= 0){
                        newcontent = newcontent.replace("@3","<input type='text' class='msg-input' value='${order.applianceCategory }' onkeyup='inputWidth(this)' id='defapplianceCategory'/>");
                    }
                    while(newcontent.indexOf('@4') >= 0){
                        newcontent = newcontent.replace("@4","<input type='text' class='msg-input' value='${order.serviceType }' onkeyup='inputWidth(this)' id='defserviceType'/>");
                    }
                    while(newcontent.indexOf('@5') >= 0){
                        if('${order.serviceMode }'=='1'){
                            newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='上门' onkeyup='inputWidth(this)' id='defserviceMode'/>");
                        }else if('${order.serviceMode }'=='2'){
                            newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='拉修' onkeyup='inputWidth(this)' id='defserviceMode'/>");
                        }else{
                            newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='' onkeyup='inputWidth(this)' id='defserviceMode'/>");
                        }
                    }
                    while(newcontent.indexOf('@6') >= 0){
                        newcontent = newcontent.replace("@6","<input type='text' class='msg-input' value='${msg2Names}' onkeyup='inputWidth(this)' id='defmsg2Names'/>");
                    }
                    while(newcontent.indexOf('@7') >= 0){
                        newcontent = newcontent.replace("@7","<input type='text' class='msg-input' value='${msg2Mobiles }' onkeyup='inputWidth(this)' id='defmsg2Mobiles'/>");
                    }
                    while(newcontent.indexOf('@8') >= 0){
                        newcontent = newcontent.replace("@8","<input type='text' class='msg-input' value='${jdPhone }' onkeyup='inputWidth(this)' id='defjdPhone'/>");
                    }
                    $(".defmsgcontent").append(newcontent);
                    $("#defsendModel").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModeldef(\''+result.columns.id+'\',\''+result.columns.tag+'\',\''+result.columns.content+'\')" >发送</a>');
                    $.setPos($(".msgTextdefined"))
                }else{

                }
            }
        })
    }

    var afl = false;
    function sendModel1(id,tag,content){
        $("#clickSend").empty();
        if(afl) {
            return;
        }
        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var custName = $("#custName").val();
        var yw = $("#yw").val();
        var siteName = $("#siteName").val();
        var jdMobile = $("#jdMobile").val();
        var emName = $("#emName").val();
        var emMobile = $("#emMobile").val();
        var proTime = $("#proTime").val();
        var goodsTime = $("#goodsTime").val();
        var pjArea = $("#pjArea").val();
        var pjMobile = $("#pjMobile").val();
        var promiseLimit = $("#promiseLimit").val();
        var siteMobile = $("#siteMobile").val();
        var custNameMobile = $("#custNameMobile").val();
        var customerMobile = $("#customerMobile").val();//用户联系方式
        var sign = $("#sign").val();
        var emNameMobile = $("#emNameMobile").val();//工程师、加电话集合
        // 查询出"@"的所有位置
        var path_1 = content.indexOf("@");// 第一个位置
        var path_2 = path_1 + content.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
        var path_3 = path_2 + content.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
        var path_4 = path_3 + content.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
        var path_5 = path_4 + content.substring(path_4 + 1).indexOf("@") + 1;// 第四个位置
        var path_6 = path_5 + content.substring(path_5 + 1).indexOf("@") + 1;// 第四个位置
        var s_temp;
        if(id==10){ //模板一
            if($.trim($("#sign1").val())=="" || $("#sign1").val()==null){
                layer.msg("短信签名不能为空！");
                $("#sign1").focus();
                return;
            }
            if($.trim($("#sign1").val()).length>6){
                layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
                $("#sign1").focus();
                return;
            }
            sign=$.trim($("#sign1").val());
            s_temp = content.substring(0, path_1) + custName
                + content.substring(path_1 + 1, path_2) + yw
                + content.substring(path_2 + 1, path_3) + siteName
                + content.substring(path_3 + 1, path_4) + jdMobile
                + content.substring(path_4 + 1, path_5) + sign
                + content.substring(path_5 + 1);

        }else if(id==11){//模板二
            if($.trim($("#sign2").val())=="" || $("#sign2").val()==null){
                layer.msg("短信签名不能为空！");
                $("#sign2").focus();
                return;
            }
            if($.trim($("#sign2").val()).length>6){
                layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
                $("#sign2").focus();
                return;
            }
            sign=$.trim($("#sign2").val());
            s_temp = content.substring(0, path_1) + custNameMobile
                + content.substring(path_1 + 1, path_2) + yw
                + content.substring(path_2 + 1,path_3)  + sign
                + content.substring(path_3 + 1);

        }else if(id==12){//配件无法接通
            if($.trim(pjMobile)=="" || pjMobile==null){
                layer.msg("联系电话不能为空！");
                $("#pjMobile").focus();
                return;
            }
            if($.trim($("#sign20").val())=="" || $("#sign20").val()==null){
                layer.msg("短信签名不能为空！");
                $("#sign20").focus();
                return;
            }
            if($.trim($("#sign20").val()).length>6){
                layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
                $("#sign20").focus();
                return;
            }
            sign=$.trim($("#sign20").val());
            s_temp = content.substring(0, path_1) + goodsTime
                + content.substring(path_1 + 1, path_2) + pjArea
                + content.substring(path_2 + 1, path_3) + pjMobile
                + content.substring(path_3 + 1, path_4) + sign
                + content.substring(path_4 + 1);
        }else if(id==4){//无法接通
            if($.trim($("#sign3").val())=="" || $("#sign3").val()==null){
                layer.msg("短信签名不能为空！");
                $("#sign3").focus();
                return;
            }
            if($.trim($("#sign3").val()).length>6){
                layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
                $("#sign3").focus();
                return;
            }
            sign=$.trim($("#sign3").val());
            s_temp = content.substring(0, path_1) + siteMobile
                + content.substring(path_1 + 1, path_2) + emNameMobile
                + content.substring(path_2 + 1, path_3) + sign
                + content.substring(path_3 + 1);

        }else if(id==5){//改约
            if($.trim($("#sign4").val())=="" || $("#sign4").val()==null){
                layer.msg("短信签名不能为空！");
                $("#sign4").focus();
                return;
            }
            if($.trim($("#sign4").val()).length>6){
                layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
                $("#sign4").focus();
                return;
            }
            sign=$.trim($("#sign4").val());
            s_temp = content.substring(0, path_1) + custName
                + content.substring(path_1 + 1, path_2) + proTime
                + content.substring(path_2 + 1, path_3) + promiseLimit
                + content.substring(path_3 + 1, path_4) + emNameMobile
                + content.substring(path_4 + 1, path_5) + jdMobile
                + content.substring(path_5 + 1, path_6) + sign
                + content.substring(path_6 + 1);
        }else if(id==6){//缺件
            if($.trim($("#sign5").val())=="" || $("#sign5").val()==null){
                layer.msg("短信签名不能为空！");
                $("#sign5").focus();
                return;
            }
            if($.trim($("#sign5").val()).length>6){
                layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
                $("#sign5").focus();
                return;
            }
            sign=$.trim($("#sign5").val());
            s_temp = content.substring(0, path_1) + custName
                + content.substring(path_1 + 1, path_2) + emNameMobile
                + content.substring(path_2 + 1, path_3) + jdMobile
                + content.substring(path_3 + 1, path_4) + sign
                + content.substring(path_4 + 1);
        }
        if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
            afl = true;
            $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
                type:"POST",
                //traditional:true,
                url:"${ctx }/order/msgNumbers",
                data:{content:s_temp,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    }else{
                        $("#peoples").html('${order.customerName}');
                        $("#sendContent").text("“"+s_temp+"”？");
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                },
                complete: function() {
                    afl = false;
                }
            })
        }else if($.trim(customerMobile)==""){
            layer.msg("请填写用户的手机号码！");
        }else{
            layer.msg("用户的手机号码格式不正确，请重新填写！");
        }
    }

    var defafl=false;
    function sendModeldef(id,tag,content){
        $("#clickSend").empty();
        if(defafl) {
            return;
        }
        var customerMobile = $("#customerMobile").val();//用户联系方式
        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var custName = $("#defcustomerName").val();
        var applianceBrand = $("#defapplianceBrand").val();
        var applianceCategory = $("#defapplianceCategory").val();
        var  serviceType =$("#defserviceType").val();
        var  serviceMode =$("#defserviceMode").val();
        var defempName=$("#defmsg2Names").val();
        var defempMobile=$("#defmsg2Mobiles").val();
        var smsmobile=$("#defjdPhone").val();
        var defsign ='${serviceName }';
        while(content.indexOf('@1') >= 0){
            content = content.replace("@1",custName);
        }
        while(content.indexOf('@2') >= 0){
            content = content.replace("@2",applianceBrand);
        }
        while(content.indexOf('@3') >= 0){
            content = content.replace("@3",applianceCategory);
        }
        while(content.indexOf('@4') >= 0){
            content = content.replace("@4",serviceType);
        }
        while(content.indexOf('@5') >= 0){
            content = content.replace("@5",serviceMode);
        }
        while(content.indexOf('@6') >= 0){
            content = content.replace("@6",defempName);
        }
        while(content.indexOf('@7') >= 0){
            content = content.replace("@7",defempMobile);
        }
        while(content.indexOf('@8') >= 0){
            content = content.replace("@8",smsmobile);
        }
        var newdefcontent=content;
        var s_temp;
        if($.trim(defsign)=="" || defsign==null){
            layer.msg("短信签名不能为空！");
            return;
        }
        if($.trim(defsign).length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            return;
        }
        var sign=defsign;
        s_temp =newdefcontent;

        if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
            defafl = true;
            $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
                type:"POST",
                //traditional:true,
                url:"${ctx }/order/msgNumbers",
                data:{content:s_temp,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    }else{
                        $("#peoples").html('${order.customerName}');
                        $("#sendContent").text("“"+s_temp+"”？");
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                },
                complete: function() {
                    defafl = false;
                }
            })
        }else if($.trim(customerMobile)==""){
            layer.msg("请填写用户的手机号码！");
        }else{
            layer.msg("用户的手机号码格式不正确，请重新填写！");
        }
    }

    var aflModel=false;
    function sendConfirmMsgModel(id,sign,s_temp,tag,orderMsgId,customerMobile){
        if(aflModel) {
            return;
        }
        aflModel=true;
        $.ajax({
            type:"POST",
            url:"${ctx }/order/fwzSendmsgModel",
            data:{temId:id,
                sign:sign,
                content:s_temp,
                extno:tag,
                orderId:orderMsgId,
                customerMobile:customerMobile
            },
            success:function(result){
                if(result=="ok"){
                    layer.msg("发送成功!");
                    $.closeDiv($(".msgText1"));
                    $.closeDiv($(".msgTextdefined"));
                    window.location.reload();
                }else if(result=="noMessage"){
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    return;
                } else{
                    layer.msg("发送失败，请稍后重试!");
                }
            },
            complete: function() {
                aflModel = false;
            }
        })
    }

    function inputWidth(obj){
        var textValue = obj.value,
            textLength = textValue.length,
            charCode = -1;
        var charLen = textValue.replace(/[^\x00-\xff]/g,"**").length;

        var minWidth = charLen*7 >10?charLen*7 : 10;
        minWidth = minWidth>448?448:minWidth;
        $(obj).css({'width':minWidth + 'px'});
    }

    var afs1= false;
    function sendMsgConfirm(){
        $("#clickSend").empty();
        if(afs1) {
            return;
        }

        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var sign = $("#sign").val();
        var customerMobile = $("#customerMobile").val();//用户联系方式
        if($.trim($("#sign6").val())=="" || $("#sign").val()==null){
            layer.msg("短信签名不能为空！");
            $("#sign6").focus();
            return;
        }
        if($.trim($("#sign6").val()).length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            $("#sign6").focus();
            return;
        }
        sign=$.trim($("#sign6").val());
        var content = $.trim($("#content").val());
        if(content=="" ){
            layer.msg("自定义发送短信内容不能为空");
            $("#content").focus();
            return;
        }
        if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
            //自定义模板
            afs1 = true;
            $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
                type:"POST",
                url:"${ctx }/order/msgNumbers",
                data:{content:content,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                        layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
                    }else{
                        $("#peoples").html('${order.customerName}');
                        $("#sendContent").text("“"+$("#content").val()+"”？");
                        definedContentTz=content;
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsg(\''+sign+'\',\''+customerMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                },
                complete: function() {
                    afs1 = false;
                }
            });
        }else if($.trim(customerMobile)==""){
            layer.msg("请填写用户的手机号码！");
        }else{
            layer.msg("用户的手机号码格式不正确，请重新填写！");
        }
    }

    var defafs1
    function defsendMsgConfirm(){
        $("#clickSend").empty();
        if(defafs1) {
            return;
        }

        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var sign = $("#sign").val();
        var customerMobile = $("#customerMobile").val();//用户联系方式
        if($.trim($("#signdef").val())=="" || $("#sign").val()==null){
            layer.msg("短信签名不能为空！");
            $("#signdef").focus();
            return;
        }
        if($.trim($("#signdef").val()).length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            $("#signdef").focus();
            return;
        }
        sign=$.trim($("#signdef").val());
        var content = $.trim($("#contentdef").val());
        if(content=="" ){
            layer.msg("自定义发送短信内容不能为空");
            $("#content").focus();
            return;
        }
        if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
            //自定义模板
            defafs1 = true;
            $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
                type:"POST",
                url:"${ctx }/order/msgNumbers",
                data:{content:content,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                        layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
                    }else{
                        $("#peoples").html('${order.customerName}');
                        $("#sendContent").text("“"+$("#contentdef").val()+"”？");
                        definedContentTz=content;
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsg(\''+sign+'\',\''+customerMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                },
                complete: function() {
                    defafs1 = false;
                }
            });
        }else if($.trim(customerMobile)==""){
            layer.msg("请填写用户的手机号码！");
        }else{
            layer.msg("用户的手机号码格式不正确，请重新填写！");
        }
    }

    var afs= false;
    function sendMsg(sign,orderMsgMobile,orderMsgId){
        if(afs) {
            return;
        }
        afs = true;
        $.ajax({
            type:"POST",
            url:"${ctx }/order/fwzSendmsg",
            data:{content:definedContentTz,
                sign:sign,
                orderMsgMobile:orderMsgMobile,
                orderMsgId:orderMsgId
            },
            success:function(result){
                if(result=="ok"){
                    layer.msg("发送成功!");
                    $.closeDiv($(".msgText1"));
                    $.closeDiv($(".msgTextdefined"));
                    window.location.reload();
                }else if(result=="noMessage"){
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    return;
                } else{
                    layer.msg("发送失败，请稍后重试!");
                }
            },
            complete: function() {
                afs = false;
            }
        });

    }

    function dygd(id){
        //使用默认
        window.open("${ctx}/print/order?orderId="+id);
    }

    function dygdcustom(id){
        $.ajax({
            type : 'POST',
            url : "${ctx}/order/printdesign/getOrderKeyName",
            data : {orderId:id},
            datatype:"JSON",
            success : function(data) {
                if(data == null || data.content == null || data.content.length<=0){
                    var newTab=window.open('about:blank');
                    newTab.location.href="${ctx}/print/order?orderId="+id;
                    return
                }
                var number='${order.number}';
                $.ajax({url:"${ctx}/print/writePrintTimes", type:"post", data:{number:number}, success:function(result){}});
                prn_Preview(data);
            }

        });
    }
    //判断是否设置自定义打印模板
    function judgedygd(){
        $.ajax({
            type : 'POST',
            url : "${ctx}/order/printdesign/getOrderPrin",
            data : {},
            datatype:"JSON",
            success : function(data) {
                if(data == "ok"){
                    $("#repeteWrite").hide();
                    $("#repeatOrder_custom").show();
                    return
                }else{
                    $("#repeteWrite").show();
                    $("#repeatOrder_custom").hide();
                }

            }

        });
    }

    function cancelQueren(){
        $.closeDiv($(".msgTextQuren"),true);
    }

    function showMarkOrder(id) {
        layer.open({
            type : 2,
            content:'${ctx}/order/showMarkOrdersFor2017?ids=' + id,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    //下一页
    function nextOrder(id,number) {
        toOrderDetail(id,number,'1');
    }

    //上一页
    function previousOrder(id,number) {
        toOrderDetail(id,number,'0');
    }

    function toOrderDetail(id,number,previousOrNext){
        var dtMsg = parent.getConditions();
        var topWin = window.top;
        parent.search();
        $.closeAllDiv();
        var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
        var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);
        frameWin.layer.open({
            type : 2,
            content:'${ctx}/order/orderDispatch/Wholeform?map='+dtMsg+'&id='+id+'&previousOrNext='+previousOrNext+'&whereMark=1'+'&parentNumber='+number,
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }


    function showGoodsMsg(){
        var orderNumber = "${order.number}";
        $.ajax({
            url:"${ctx}/order/showGoodsMsg",
            data:{orderNumber:orderNumber},
            dataType:'json',
            async:false,
            success:function(data){
                var html="";
                if(data.length > 0){
                    for(var i=0;i<data.length;i++){
                        var goods = data[i].columns;
                        html+="<tr>" +
                            "<td  title='"+goods.number+"'>"+goods.number+"</td>" +
                            "<td  title='"+goods.good_name+"'>"+goods.good_name+"</td>" +
                            "<td >"+outStocksType(goods.status,goods.outstock_type)+"</td>" +
                            "<td >"+goods.purchase_num+"</td>" +
                            "<td >"+goods.good_amount+"</td>" +
                            "<td >"+goods.real_amount+"</td>" +
                            "<td >"+goods.confirm_amount+"</td>" +
                            "<td >"+goods.sales_commissions+"</td>" +
                            "<td  title='"+goods.placing_name+"'>"+goods.placing_name+"</td>" +
                            "<td >"+formatDate(goods.placing_order_time)+"</td>" +
                            "<td  style='color:red;'>"+goodsOrderStatus(goods.status,goods.outstock_type,goods.stocks,goods.purchase_num,goods.outstock_type)+"</td>" +
                            "</tr>";
                    }
                    $("#goodsMsg").empty();
                    $("#goodsMsg").append(html);
                }
            }
        })
    }
    function jd(orderId) {
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要接收派工吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/secondOrder/recvOrders",
                    type: 'post',
                    data: {
                        ids: orderId
                    },
                    success: function(data) {
                        if ('500' === data.code) {
                            layer.msg("您选择的工单中有不可接收的工单，不能操作接单！")
                        } else if('200' === data.code) {
                            layer.msg("接单成功！");
                            parent.search();
                            $.closeAllDiv();
                        } else if('422' === data.code) {
                            window.top.layer.msg("工单已被转派！");
                            parent.search();
                            $.closeAllDiv();
                        } else if('423' === data.code) {
                            layer.msg("自建工单不可退回！");
                        }
                    },
                    error: function() {
                    }
                });
            },
            fnCancel: function () {
            }
        });
    }
    function jdFac(orderId) {
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要接收派工吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/order/recvOrdersFac",
                    type: 'post',
                    data: {
                        ids: orderId
                    },
                    success: function(data) {
                        if ('500' === data.code) {
                            layer.msg("您选择的工单中有不可接收的工单，不能操作接单！")
                        } else if('200' === data.code) {
                            window.top.layer.msg("接单成功！");
                            parent.search();
                            $.closeAllDiv();
                        } else if('422' === data.code) {
                            layer.msg("工单已被转派！");
                        } else if('201' === data.code || '205' === data.code) {
                            layer.msg("接收失败，请稍后再试！");
                        }
                    },
                    error: function() {
                    }
                });
            },
            fnCancel: function () {
            }
        });
    }
    function refuseOrder(orderId) {
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要退回工单吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/secondOrder/refuseOrders",
                    type: 'post',
                    data: {
                        ids: orderId
                    },
                    success: function(data) {
                        if ('500' === data.code) {
                            layer.msg("您选择的工单中有不可退回的工单，不能操作拒单！");
                        } else if('200' === data.code) {
                            layer.msg("退回成功！")
                        } else if('422' === data.code) {
                            window.top.layer.msg("工单已被转派！");
                            parent.search();
                            $.closeAllDiv();
                        }
                        parent.search();
                        $.closeAllDiv();
                    },
                    error: function() {
                    }
                });
            },
            fnCancel: function () {
            }
        });
    }

    function showQRCode(siteId,type){
        var code = $("#applianceBarcode").val();
        if("2"==type){
            code = $("#applianceMachineCode").val();
        }
        if(isBlank(code)){
            layer.msg("条码为空！");
            return;
        }
        //var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
        $("#showCode").empty().qrcode({width: 200, height: 200, text: code});
        $(".qrcode").popup({level:2,closeSelfOnly:true});

    }

    function codeNumberCounts(){
        codeCounts();
        $('#applianceBarcode').bind('blur', function() {
            codeCounts();
            var code = $.trim($(this).val());
            if(!isBlank(code)){
                changeMark = false;
                loadAlreadyCode(1,code);//历史工单显示
                $(".code1").show();
                $(".weishu1").show();
            }else{
                changeMark = true;
                $("#codeInshow").hide();
                $(".code1").hide();
                $(".weishu1").hide();
            }
        });
        $('#applianceMachineCode').bind('blur', function() {
            codeCounts();
            var code = $(this).val();
            if(!isBlank(code)){
                changeMark = false;
                loadAlreadyCode(2,code);//历史工单显示
                $(".code2").show();
                $(".weishu2").show();
            }else{
                changeMark = true;
                $("#codeOutshow").hide();
                $(".code2").hide();
                $(".weishu2").hide();
            }
        });
        $('#applianceMachineCode').bind('input propertychange', function() {
            codeCounts1();//条码字数统计
        })
        $('#applianceBarcode').bind('input propertychange', function() {
            codeCounts1();//条码字数统计
        })
    }

    function codeCounts1(){
        var applianceBarcode = $.trim($("#applianceBarcode").val());
        var applianceMachineCode = $.trim($("#applianceMachineCode").val());
        $("#incodeNum").text(applianceBarcode.length);
        $("#outcodeNum").text(applianceMachineCode.length);
        if(!isBlank(applianceBarcode)){
            $(".weishu1").show();
            $(".code1").show();
            changeMark=false;
            //loadAlreadyCode(1,applianceBarcode);
        }else{
            $(".weishu1").hide();
            $(".code1").hide();
        }
        if(!isBlank(applianceMachineCode)){
            $(".weishu2").show();
            $(".code2").show();
            changeMark=false;
            //loadAlreadyCode(2,applianceMachineCode);
        }else{
            $(".weishu2").hide();
            $(".code2").hide();
        }
    }

    function codeCounts(){
        var applianceBarcode = $.trim($("#applianceBarcode").val());
        var applianceMachineCode = $.trim($("#applianceMachineCode").val());
        $("#incodeNum").text(applianceBarcode.length);
        $("#outcodeNum").text(applianceMachineCode.length);
        if(!isBlank(applianceBarcode)){
            $(".weishu1").show();
            $(".code1").show();
            changeMark=false;
            loadAlreadyCode(1,applianceBarcode);
        }else{
            $(".weishu1").hide();
            $(".code1").hide();
        }
        if(!isBlank(applianceMachineCode)){
            $(".weishu2").show();
            $(".code2").show();
            changeMark=false;
            loadAlreadyCode(2,applianceMachineCode);
        }else{
            $(".weishu2").hide();
            $(".code2").hide();
        }
    }

    function refuseOrderFac(orderId) {
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要拒接退回工单吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/order/refuseOrders",
                    type: 'post',
                    data: {
                        ids: orderId
                    },
                    success: function (data) {
                        if ('422' === data.code) {
                            window.top.layer.msg("您选择的工单中有不可退回的工单，无法操作拒单！")
                        } else if ('200' === data.code) {
                            window.top.layer.msg("退回成功！");
                            parent.search();
                            $.closeAllDiv();
                        } else if ('423' === data.code) {
                            window.top.layer.msg("您选择的工单状态已经更新，请重试！");
                        }
                    },
                    error: function () {
                    }
                });
            },
            fnCancel: function () {
            }
        });
    }

    function loadAlreadyCode(type,code){
        if(changeMark){
            return;
        }
        if(isBlank(code)){
            if(type==1){
                $("#codeInshow").hide();
                $(".codeIn").hide();
            }else{
                $("#codeOutshow").hide();
                $(".codeOut").hide();
            }
            return;
        }
        $.ajax({
            url: "${ctx}/order/getHistoryOrdersCodeOutCountByTelDetail2017?code=" + $.trim(code)+"&id="+'${order.id}',
            type: 'GET',
            success: function(data) {
                if(changeMark){
                    return;
                }
                var count = data.cnt;
                if(count == 0){
                    if(type==1){
                        $("#codeInshow").hide();
                        $(".codeIn").hide();
                    }else{
                        $("#codeOutshow").hide();
                        $(".codeOut").hide();
                    }
                }else{
                    if(count < 1){
                        $(".douhao").text("");
                    }
                    if(count > 0){
                        if(type==1){
                            $("#codeInshow").text(count+'条历史工单');
                            $("#codeInshow").show();
                            $(".codeIn").show();
                        }else{
                            $("#codeOutshow").text(count+'条历史工单');
                            $("#codeOutshow").show();
                            $(".codeOut").show();
                        }
                    }else{
                        if(type==1){
                            $(".codeIn").hide();
                        }else{
                            $(".codeOut").hide();
                        }

                    }
                    $('#codeShow').show();
                }
                changeMark=false;
            }
        });
    }

    function showLatestEmploye(mobile){
        $.ajax({
            type:"post",
            url:"${ctx}/order/getLatestEmployesByMobile",
            data:{mobile:mobile},
            success:function(data){
                if(isBlank(data)){
                    $("#latestEmps").text("");
                    $("#latestEmps").attr("title","");
                    return ;
                }
                $("#latestEmps").text(data);
                $("#latestEmps").attr("title",data);
                $(".showLatestlook").show();
                return;
            }
        })
    }

    function senMagPopup(id){
        layer.open({
            type : 2,
            content:'${ctx}/order/sendMsgAccountsOne?ids=' + id + '&type=2',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });
    }

    function showzjfd(){
        $('.showzjfddiv').popup({level:2, closeSelfOnly:true});
    }

    function cancerBox(){
        $.closeDiv($('.showzjfddiv'), true);
    }

    function savezjfd(id){
        var latest_process = $.trim($("#reasonofzjfd").val());
        if(isBlank(latest_process)){
            layer.msg("请输入理由!");
            return;
        }else{
            $.ajax({
                type:"POST",
                url:"${ctx}/order/orderDispatch/updateOrderClose2017",
                data:{
                    id:id,
                    latest_process:latest_process
                },
                success:function(result){
                    layer.msg("封单完成");
                    $('#Hui-article-box',window.top.document).css({'z-index':'9'});
                    parent.search();
                    parent.numerCheck();
                    $.closeAllDiv();
                },
                error:function(){
                    alert("系统繁忙!");
                    return;
                }
            });
        }
    }
</script>
</body>
</html>